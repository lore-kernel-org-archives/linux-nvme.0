From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Oct 2015 14:03:32 +0200
Subject: nvme abort and reset fixes
Message-ID: <1445515421-4940-1-git-send-email-hch@lst.de>

This series allows my controller that dosn't like the small but aligned discard
requests to recover slowly but safely.  To get there I had to turn most of the
abort and reset path upside down unfortunately.

This is on top of Keith' master branch with all the nvme driver split work in it.
