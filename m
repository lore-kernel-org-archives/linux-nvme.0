From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue,  4 Apr 2017 12:54:46 +0300
Subject: [GIT PULL] nvme patches for kernel 4.11 rc6
Message-ID: <1491299686-6222-1-git-send-email-sagi@grimberg.me>

Hey Jens,

We have one spec mis-match fix from Roland and
several sparse fixes from Christoph.

please pull from:

  git://git.infradead.org/nvme.git nvme-4.11-rc

Thanks!

----------------------------------------------------------------
Christoph Hellwig (4):
      nvme: add missing byte swap in nvme_setup_discard
      nvmet: add missing byte swap in nvmet_get_smart_log
      nvmet: fix byte swap in nvmet_execute_write_zeroes
      nvmet: fix byte swap in nvmet_parse_io_cmd

Roland Dreier (1):
      nvme: Correct NVMF enum values to match NVMe-oF rev 1.0

 drivers/nvme/host/core.c        |  2 +-
 drivers/nvme/target/admin-cmd.c |  2 +-
 drivers/nvme/target/io-cmd.c    |  4 ++--
 include/linux/nvme.h            | 16 ++++++++--------
 4 files changed, 12 insertions(+), 12 deletions(-)
