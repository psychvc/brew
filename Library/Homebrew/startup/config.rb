# typed: true
# frozen_string_literal: true

raise "HOMEBREW_BREW_FILE was not exported! Please call bin/brew directly!" unless ENV["HOMEBREW_BREW_FILE"]

# Path to `bin/brew` main executable in `HOMEBREW_PREFIX`
# Used for e.g. permissions checks.
HOMEBREW_ORIGINAL_BREW_FILE = Pathname(ENV.fetch("HOMEBREW_ORIGINAL_BREW_FILE")).freeze

# Path to the executable that should be used to run `brew`.
# This may be HOMEBREW_ORIGINAL_BREW_FILE or HOMEBREW_BREW_WRAPPER.
HOMEBREW_BREW_FILE = Pathname(ENV.fetch("HOMEBREW_BREW_FILE")).freeze

# Where we link under
HOMEBREW_PREFIX = Pathname(ENV.fetch("HOMEBREW_PREFIX")).freeze

# Where `.git` is found
HOMEBREW_REPOSITORY = Pathname(ENV.fetch("HOMEBREW_REPOSITORY")).freeze

# Where we store most of Homebrew, taps and various metadata
HOMEBREW_LIBRARY = Pathname(ENV.fetch("HOMEBREW_LIBRARY")).freeze

# Where shim scripts for various build and SCM tools are stored
HOMEBREW_SHIMS_PATH = (HOMEBREW_LIBRARY/"Homebrew/shims").freeze

# Where external data that has been incorporated into Homebrew is stored
HOMEBREW_DATA_PATH = (HOMEBREW_LIBRARY/"Homebrew/data").freeze

# Where we store symlinks to currently linked kegs
HOMEBREW_LINKED_KEGS = (HOMEBREW_PREFIX/"var/homebrew/linked").freeze

# Where we store symlinks to currently version-pinned kegs
HOMEBREW_PINNED_KEGS = (HOMEBREW_PREFIX/"var/homebrew/pinned").freeze

# Where we store lock files
HOMEBREW_LOCKS = (HOMEBREW_PREFIX/"var/homebrew/locks").freeze

# Where we store built products
HOMEBREW_CELLAR = Pathname(ENV.fetch("HOMEBREW_CELLAR")).freeze

# Where we store Casks
HOMEBREW_CASKROOM = Pathname(ENV.fetch("HOMEBREW_CASKROOM")).freeze

# Where downloads (bottles, source tarballs, etc.) are cached
HOMEBREW_CACHE = Pathname(ENV.fetch("HOMEBREW_CACHE")).freeze

# Where formulae installed via URL are cached
HOMEBREW_CACHE_FORMULA = (HOMEBREW_CACHE/"Formula").freeze

# Where build, postinstall and test logs of formulae are written to
HOMEBREW_LOGS = Pathname(ENV.fetch("HOMEBREW_LOGS")).expand_path.freeze

# Must use `/tmp` instead of `TMPDIR` because long paths break Unix domain sockets
HOMEBREW_TEMP = Pathname(ENV.fetch("HOMEBREW_TEMP")).then do |tmp|
  tmp.mkpath unless tmp.exist?
  tmp.realpath
end.freeze

# Where installed taps live
HOMEBREW_TAP_DIRECTORY = (HOMEBREW_LIBRARY/"Taps").freeze

# The Ruby path and args to use for forked Ruby calls
HOMEBREW_RUBY_EXEC_ARGS = [
  RUBY_PATH,
  ENV.fetch("HOMEBREW_RUBY_WARNINGS"),
  ENV.fetch("HOMEBREW_RUBY_DISABLE_OPTIONS"),
].freeze

# Location for `brew alias` and `brew unalias` commands.
#
# Unix-Like systems store config in $HOME/.config whose location can be
# overridden by the XDG_CONFIG_HOME environment variable. Unfortunately
# Homebrew strictly filters environment variables in BuildEnvironment.
HOMEBREW_ALIASES = if (path = Pathname.new("~/.config/brew-aliases").expand_path).exist? ||
                      (path = Pathname.new("~/.brew-aliases").expand_path).exist?
  path.realpath
else
  path
end.freeze
