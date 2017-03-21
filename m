From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 21 Mar 2017 18:33:35 +0200
Subject: [GIT PULL] nvme patches for kernel 4.11 rc4
Message-ID: <1490114015-17672-1-git-send-email-sagi@grimberg.me>

Hey Jens,

This consists of some fixes for issues reported lately:
- loop and rdma host driver cpu hotplug fixes
- fix loop use-after-free
- nvmet percpu_ref confirmation fix to fail ongoing requests
- nvmet-rdma fix a non-initialized commands deref

please pull from:

  git://git.infradead.org/nvme.git nvme-4.11-rc

Thanks!

----------------------------------------------------------------
Sagi Grimberg (5):
      nvme-loop: fix a possible use-after-free when destroying the admin queue
      nvmet: confirm sq percpu has scheduled and switched to atomic
      nvmet-rdma: Fix a possible uninitialized variable dereference
      nvme-rdma: handle cpu unplug when re-establishing the controller
      nvme-loop: handle cpu unplug when re-establishing the controller

 drivers/nvme/host/rdma.c    | 28 +++++++-------
 drivers/nvme/target/core.c  | 11 +++++-
 drivers/nvme/target/loop.c  | 90 +++++++++++++++++++++++++--------------------
 drivers/nvme/target/nvmet.h |  1 +
 drivers/nvme/target/rdma.c  |  8 ++--
 5 files changed, 79 insertions(+), 59 deletions(-)
