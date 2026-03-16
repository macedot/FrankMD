#!/usr/bin/env ruby

require "resolv"

begin
  Resolv.getaddress("registry.npmjs.org")
rescue Resolv::ResolvError, SocketError, SystemCallError
  warn "Skipping importmap audit: cannot resolve registry.npmjs.org in this environment"
  exit 0
end

exec "bin/importmap", "audit"
