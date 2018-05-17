From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 17 May 2018 09:02:14 -0600
Subject: [PATCHSET 0/3] Split queue lock into submission/completion locks
Message-ID: <1526569337-3489-1-git-send-email-axboe@kernel.dk>

This series is on top of the previous work from yesterday, including
Christophs patch. It splits nvmeq->q_lock into two locks:

1) ->sq_lock, that protects the submission side of things
2) ->cq_lock, that protects the completion side

This also means that we can drop the IRQ safe nature of the submission
side locking.

 drivers/nvme/host/pci.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)
