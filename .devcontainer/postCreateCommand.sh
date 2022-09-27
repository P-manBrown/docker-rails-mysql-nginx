set -eu

function copy_and_ignore() {
	file_path=$1
	target_path=$2
	file_name=$(basename "$file_path")
	ignore_path=$(echo $target_path$file_name | sed -e "s:^./:/:; /^[^/]/s:^:/:")
	if ! cat ./.git/info/exclude | grep -q $ignore_path; then
		echo -e "$ignore_path" >> ./.git/info/exclude
	fi
	cp --update $file_path $target_path
}

copy_and_ignore ./.devcontainer/vscode/launch.json .vscode/

GITHUB_PKG_CRED=$(cat ./.docker/api/secrets/github-pkg-cred.txt)
bundle config https://rubygems.pkg.github.com/P-manBrown $GITHUB_PKG_CRED

mkdir -p ./config/
copy_and_ignore ./.devcontainer/solargraph/.solargraph.yml ./
copy_and_ignore ./.devcontainer/solargraph/solargraph.rb ./config/

copy_and_ignore ./.devcontainer/lefthook/lefthook-local.yml ./
bundle exec lefthook install
