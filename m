From: hch@lst.de (Christoph Hellwig)
Date: Fri, 13 Jan 2017 12:29:09 +0100
Subject: fix data transfer size caculation for special payload requests
Message-ID: <1484306953-3194-1-git-send-email-hch@lst.de>

Hi all,

the first two fixes fix a regression in 4.10-rc1 where the data transfer
size for discard commands wasn't set properly, leading to hangs with
Hyper-V VMs.  The use the new data transfer size helper added in patch 1
more widely.
