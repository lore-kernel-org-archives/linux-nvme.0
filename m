From: hch@lst.de (Christoph Hellwig)
Date: Fri,  1 Jun 2018 09:11:19 +0200
Subject: draft ANA support v2
Message-ID: <20180601071128.7630-1-hch@lst.de>

Next repost of the ANA support with a lot of changes.

The big TODO list item for the kernel code is support for transition
timeouts, and handling of last resort retries on change or inaccssible
paths.

Besides that we still need nvme-cli and nvmetcli support as well as
an automated test suite.

A git tree is available at:

    git://git.infradead.org/users/hch/block.git nvme-ana

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-ana

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
 - fixed a memory leak (Hannes Reinecke)
 - fix reporting of NUSE (based on a patch from Hannes Reinecke)
 - make ANATT configurable
