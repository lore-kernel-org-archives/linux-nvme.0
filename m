From: hch@lst.de (Christoph Hellwig)
Date: Fri,  9 Oct 2015 18:55:53 +0200
Subject: nvme ->queue_rq updates
Message-ID: <1444409756-7317-1-git-send-email-hch@lst.de>

This series has a few changes for the ->queue_rq path.  The first is a
simple fix, the second a cleanup and the third a major cleanup which
also micro optimizes the time spent with irqs disabled.
