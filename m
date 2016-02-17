From: hch@lst.de (Christoph Hellwig)
Date: Wed, 17 Feb 2016 19:03:11 +0100
Subject: nvme: remove the global device list and kthread
Message-ID: <1455732194-30790-1-git-send-email-hch@lst.de>

This series drops the global nvme thread, and the device list only
needed for it.  Note that I haven't been able to trigger an AER with
my test controller, but the code is based on work for the NVMe over
Fabrics driver that has been properly tested.
