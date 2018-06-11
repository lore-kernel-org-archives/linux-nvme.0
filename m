From: hch@lst.de (Christoph Hellwig)
Date: Mon, 11 Jun 2018 16:11:29 +0200
Subject: draft ANA support v4
Message-ID: <20180611141139.30462-1-hch@lst.de>

This version has a major update to move the ANA state to struct nvme_ns,
as I did in my original prototypes.  I moved away from to handle the
ANA status codes directly, but it turns out that idea is fundamentally
racy anyway.

We'll stell need good nvme-cli and nvmetcli support as well as a lot of
(preferably automated) testing.

A git tree is available at:

    git://git.infradead.org/users/hch/block.git nvme-ana

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-ana


Changes since v3:
 - keep the ana state in struct nvme_ns
 - don't update the internal ana state based on status codes
 - add a ANATT timer (based on code from Hannes Reinecke)
 - fix ANA AEN detection, which is missing a OAES bit currently
 - make more code conditional on CONFIG_NVME_MULTIPATH
 - optimize delayed adding of ns_head gendisks
 - only kick of a requeue when setting groups live
 - only send AENs on controllers of a port where the group state changes
 - a few cleanups to the build-in default group
 - fix a use after free in nvme_failover_req (Hannes Reinecke)

Changes since v2:
 - support changing the state for the default ANA group
 - drop ANATT configuration again
 - delay gendisk registration until we have an I/O capable path
 - remove nvme_req_needs_failover and the SCT=3 handling in it,
   we actually do the right thing without it
 - refactor the get log page helpers

Changes since v1:
 - fix the check for SCT = 3
 - fix the check for immutable ANAGRPID
 - disable ANA if the ANA log can't be transferred in a single chunk
 - enable the ANA AEN explicitly
 - don't zero buffers that don't get copied to the SGL
 - use READ_ONCE/WRITE_ONCE for the ana_state fields
 - update ANA state on completion with an ANA status code
 - improve commit logs
 - add proper AEN enable and masking conditionals
 - fix the numeric value for the change state
 - fix a memory leak (Hannes Reinecke)
 - fix reporting of NUSE (based on a patch from Hannes Reinecke)
 - make ANATT configurable
