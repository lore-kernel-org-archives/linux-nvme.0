From: hch@lst.de (Christoph Hellwig)
Date: Mon, 21 Sep 2015 11:40:46 -0700
Subject: nvme completion path optimizations and fixes
Message-ID: <1442860853-26447-1-git-send-email-hch@lst.de>

This series optimized the NVMe completion path by taking full advantage
to the block layer multiple completion protection.  For that we'll need
to switch the remaining internal NVMe admin commands over to use the
block layer queuing.

The first patch fixes a potential race in updating the error value which
is required to make this conversion bullet proof.
