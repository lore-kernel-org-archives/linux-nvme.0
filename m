From: hch@lst.de (Christoph Hellwig)
Date: Sat, 21 Nov 2015 08:19:40 +0100
Subject: NVMe mega patchbomb for Linux 4.5-rc (resend)
Message-ID: <1448090427-18749-1-git-send-email-hch@lst.de>

This series is a respin of all my pending NVMe patches that didn't make
it into 4.4-rc, as well a few patches from Keith that logically were
inbetween them, and include:

 - split of them NVMe driver ?nto a core and PCIe specific part
 - lots of abort / reset fixes
 - optimizations of the completion path by better relying on blk-mq

Since the last posting of all the series the major changes are another
set of fixes to the abort path to hopefully make it rock solide now.
To get there we had to add another core block request flag to avoid
struct request reuse just before a reset.  Note that various patches
have been squashed into the original patches to avoid fixups.

A git tree is also available at:

	http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-req.9
