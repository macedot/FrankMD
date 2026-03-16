# Run using bin/ci

CI.run do
  step "Setup", "bin/setup --skip-server"

  step "Style: Ruby", "RUBOCOP_CACHE_ROOT=tmp/rubocop_cache bin/rubocop"

  step "Security: Gem audit", "bin/bundler-audit"
  step "Security: Importmap vulnerability audit", "ruby script/ci/importmap_audit.rb"
  step "Security: Brakeman code analysis", "bin/brakeman --quiet --no-pager --exit-on-warn --exit-on-error"

  step "Tests: Ruby", "PARALLEL_WORKERS=0 bin/rails test"
  step "Tests: JavaScript", "npx vitest run"
end
