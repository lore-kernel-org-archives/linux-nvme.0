From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Wed, 9 May 2018 13:46:09 +0800
Subject: [PATCH V4 0/7] nvme: pci: fix & improve timeout handling
In-Reply-To: <20180505135905.18815-1-ming.lei@redhat.com>
References: <20180505135905.18815-1-ming.lei@redhat.com>
Message-ID: <b913ff71-23b3-69e7-b9cc-3c48cb5d9d36@oracle.com>

Hi ming

I did some tests on my local.

[  598.828578] nvme nvme0: I/O 51 QID 4 timeout, disable controller

This should be a timeout on nvme_reset_dev->nvme_wait_freeze.

[  598.828743] nvme nvme0: EH 1: before shutdown
[  599.013586] nvme nvme0: EH 1: after shutdown
[  599.137197] nvme nvme0: EH 1: after recovery

The EH 1 have mark the state to LIVE

[  599.137241] nvme nvme0: failed to mark controller state 1

So the EH 0 failed to mark state to LIVE
The card was removed.
This should not be expected by nested EH.

[  599.137322] nvme nvme0: Removing after probe failure status: 0
[  599.326539] nvme nvme0: EH 0: after recovery
[  599.326760] nvme0n1: detected capacity change from 128035676160 to 0
[  599.457208] nvme nvme0: failed to set APST feature (-19)

nvme_reset_dev should identify whether it is nested.

Thanks
Jianchao
