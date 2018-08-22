# Get your own GH API token @ https://github.com/settings/tokens
export ghtoken="68a38200e9b19822b9acc7d56a3aa5c68a380b36"

# Returns something like `Gusto/zenpayroll`
get-origin-repo () {
  originUrl=`git config --get remote.origin.url`  # Looks like git@github.com:Gusto/zenpayroll.git
  if [[ "$?" != "0" ]]; then
    echo "ERROR: Could not find remote called \"origin\"." 1>&2
    return
  fi
  # Strip prefix and suffix
  originUrl="${originUrl//git@github.com:/}"
  originUrl="${originUrl//.git/}"
  echo "$originUrl"
}

display-and-open-pr () {
  prWebUrl="$1"
  echo "PR URL: $prWebUrl"
  open "$prWebUrl"
}

# Create or view PR for this branch
ghpr () {
  # Determine origin repo, head, and base
  originRepo=`get-origin-repo`
  if [[ "$originRepo" == "" ]]; then return; fi

  # Get local branch name to use as remote candidate
  currentLocalBranch=`git rev-parse --abbrev-ref HEAD`
  if [[ "$?" != "0" ]]; then echo "ERROR: Could not get local git branch name."; return; fi

  # Tracked branch
  trackedBranch=`git rev-parse --abbrev-ref --symbolic-full-name @{u}`
  if [[ "$?" != "0" ]]; then echo "ERROR: Could not get tracked branch name."; return; fi

  # In GH world, PR pulls from 'head' to 'base'
  head="$currentLocalBranch"
  base="${trackedBranch//origin\//}" # Need to omit "origin"

  # Stuff output in temp file so we can use it
  outFile=`mktemp`

  # First check if we already have a PR for this repo, head and base.
  curl -s -u adam-schirmacher-gusto:$ghtoken -G -d "q=head:$head%20repo:$originRepo" -o "$outFile" "https://api.github.com/search/issues"
  prWebUrl=`cat "$outFile" | jq -r .items[0].html_url`
  if [[ "$prWebUrl" != "null" ]]; then display-and-open-pr "$prWebUrl"; return; fi

  # Else submit GH pull request
  read -p "PR Title: " prTitle
  if [[ "$prTitle" == "" ]]; then echo "ERROR: Must enter valid GH title."; return; fi

  requestBody="{\"title\": \"$prTitle\", \"head\": \"$head\", \"base\": \"$base\"}"
  curl -s -u adam-schirmacher-gusto:$ghtoken -X POST -H "Content-Type: application/json" --data "$requestBody" -o "$outFile" "https://api.github.com/repos/$originRepo/pulls"

  # Find PR URL in output
  prWebUrl=`cat "$outFile" | jq -r .html_url`

  if [[ "$prWebUrl" == "null" ]]; then
    echo "ERROR: See below."
    cat "$outFile"
  else
    display-and-open-pr "$prWebUrl"
  fi
}
