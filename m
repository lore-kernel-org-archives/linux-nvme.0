From: hch@lst.de (Christoph Hellwig)
Date: Mon, 12 Oct 2015 09:10:03 +0200
Subject: RFC: nvme driver split, the main part
Message-ID: <1444633811-28319-1-git-send-email-hch@lst.de>

And this is where the real work starts.  This moves all the block device,
char device and sysfs interface code as well as the controller identification
and namespaces scanning into the common code.  I've ported both my nvme-loop
and the fabrics driver over to this scheme to validate that it works fine.

The main complication here is patch two which uses the block layer PI
infrastructure for metdata passthrough.  I can't test it because I don't
have access to a metadata capable device so I'll have to rely on testers.

Once this this series is done there are a few more items remaining:

 - remove a few library-like functions to core.c (trivial)
 - abort rewrite to sit on top of the struct request infrastructure (in progress)
 - AEN rewrite, including making a small part of it common
 - a proper state machine for probing, scanning and resets (will take a while)

To make testing easier I've pushed out a git tree with this and all dependencies:

    git://git.infradead.org/users/hch/block.git nvme-split.4

or in gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-split.4
