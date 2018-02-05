From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Mon,  5 Feb 2018 17:20:09 +0800
Subject: [PATCH V2 0/6]nvme-pci: fixes on nvme_timeout and nvme_dev_disable
Message-ID: <1517822415-11710-1-git-send-email-jianchao.w.wang@oracle.com>

Hi Christoph, Keith and Sagi

Please consider and comment on the following patchset.
That's really appreciated.

There is a complicated relationship between nvme_timeout and nvme_dev_disable.
 - nvme_timeout has to invoke nvme_dev_disable to stop the
   controller doing DMA access before free the request.
 - nvme_dev_disable has to depend on nvme_timeout to complete
   adminq requests to set HMB or delete sq/cq when the controller
   has no response.
 - nvme_dev_disable will race with nvme_timeout when cancels the
   outstanding requests.
We have found some issues introduced by them, please refer the following link

http://lists.infradead.org/pipermail/linux-nvme/2018-January/015053.html 
http://lists.infradead.org/pipermail/linux-nvme/2018-January/015276.html
http://lists.infradead.org/pipermail/linux-nvme/2018-January/015328.html
Even we cannot ensure there is no other issue.

The best way to fix them is to break up the relationship between them.
With this patch, we could avoid nvme_dev_disable to be invoked
by nvme_timeout and eliminate the race between nvme_timeout and
nvme_dev_disable on outstanding requests.

Changes V1->V2:
 - free and disable pci things in nvme_pci_disable_ctrl_directly
 - change comment and add reviewed-by in 1st patch
 - resort patches
 - other misc changes

There are 6 patches:

1st ~ 3th patches does some preparation for the 4th one.
4th fixes a bug found when test.
5th is to avoid nvme_dev_disable to be invoked by nvme_timeout, and implement
the synchronization between them. More details, please refer to the comment of
this patch.
6th fixes a bug after 4th patch is introduced. It let nvme_delete_io_queues can
only be wakeup by completion path.

This patchset was tested under debug patch for some days.
And some bugfix have been done.
The patches are available in following it branch:
https://github.com/jianchwa/linux-blcok.git nvme_fixes_V2

Jianchao Wang (6)
0001-nvme-pci-quiesce-IO-queues-prior-to-disabling-device.patch
0002-nvme-pci-fix-the-freeze-and-quiesce-for-shutdown-and.patch
0003-blk-mq-make-blk_mq_rq_update_aborted_gstate-a-extern.patch
0004-nvme-pci-suspend-queues-based-on-online_queues.patch
0005-nvme-pci-break-up-nvme_timeout-and-nvme_dev_disable.patch
0006-nvme-pci-discard-wait-timeout-when-delete-cq-sq.patch


diff stat:
block/blk-mq.c          |   3 +-
drivers/nvme/host/pci.c | 250 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------
include/linux/blk-mq.h  |   1 +
3 files changed, 188 insertions(+), 66 deletions(-)

Thanks
Jianchao
