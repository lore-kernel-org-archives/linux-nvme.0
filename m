From: hch@lst.de (Christoph Hellwig)
Date: Wed,  6 Jun 2018 16:33:01 +0200
Subject: draft ANA support v3
Message-ID: <20180606143311.23076-1-hch@lst.de>

The big TODO list item for the kernel code is support for transition
timeouts.

Besides that we still need nvme-cli and nvmetcli support as well as
an automated test suite.

A git tree is available at:

    git://git.infradead.org/users/hch/block.git nvme-ana

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-ana

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
