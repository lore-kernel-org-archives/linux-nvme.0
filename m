From: hch@lst.de (Christoph Hellwig)
Date: Tue,  1 Dec 2015 19:52:35 +0100
Subject: NVMe reset fixes and completion path optimizations
Message-ID: <1448995981-11982-1-git-send-email-hch@lst.de>

This series fixes the NVMe driver abort and reset path to properly work
on various device I can test and optimizes the completion path by taking
full advantage of the blk-mq infrastructure.  In addition to my work
it also contains various patches Keith contributed.

The biggest change since the last version is the patch from Keith which
shut? down controller that need to be reset directly from the timeout
handler, but there are several other changes and a lot of rebasing as well,
so pleas re-review carefully.

A git tree is also available at:

    git://git.infradead.org/users/hch/block.git nvme-req.11

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-req.11
