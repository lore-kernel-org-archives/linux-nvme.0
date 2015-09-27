From: hch@lst.de (Christoph Hellwig)
Date: Sun, 27 Sep 2015 21:01:48 +0200
Subject: nvme completion path optimizations and fixes V2
Message-ID: <1443380518-6829-1-git-send-email-hch@lst.de>

This series optimized the NVMe completion path by taking full advantage
to the block layer multiple completion protection.  For that we'll need
to switch the remaining internal NVMe admin commands over to use the
block layer queuing.

The first patch is from a series by Akinobu Mita and required for
CPU hotplugging to not crash blk-mq drivers.  If you don't hot unplug
any CPU the patchset is perfectly fine without it, but given that Keith
pointed out a hot unplug bug in V1 I've included it so that this path
can be tested.

Changes since V1:
 - various hotplug CPU fixes, including a patch from Akinobu Mita
