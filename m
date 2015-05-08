From: hch@lst.de (Christoph Hellwig)
Date: Fri,  8 May 2015 18:00:25 +0200
Subject: nvme patchbomb, take 2
Message-ID: <1431100836-28112-1-git-send-email-hch@lst.de>

The first 10 patches have already been posted last month, I've just
reordered the INQUIRY memory corruption to be first so that Jens can
pick it up for 4.1 and -stable.

The last patch is new and converts NVMe to use the block layer for its
internal commands.

The series is based on Jens' for-next tree.
