From: hch@lst.de (Christoph Hellwig)
Date: Sat,  3 Oct 2015 15:39:39 +0200
Subject: nvme reset and probe updates V2
Message-ID: <1443879587-23553-1-git-send-email-hch@lst.de>

Hi Jens, hi Keith,

this serie contains a couple small update and cleanups for the
reset and probe path in the nvme driver.  I've included Keith
previous 3 patches dealing with namespaces attachment as I
depend on them and this allows the whole series to be applied
directly to Jens' tree.

Changes since V1:
 - rebased on top of Jens' for-linux tree
 - included Keith patches in the series
 - dropped two patches
