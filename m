From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 26 Jul 2018 19:56:53 -0700
Subject: [PATCH V2 0/3] nvmet: add support for ns write protect
Message-ID: <20180727025656.9334-1-chaitanya.kulkarni@wdc.com>

Hi,

This patch series implements the support for NVMeOF target ns write
protect get/set-features command. In this implementation we support
Write Protect and No Write Protect state for the target ns which can be
toggled/read by set/get-features commands.  

Changes from V1:-
1. Incorporate Christoph's comments.
2. Use feature not changeable error code in case of invalid state
   transition.
3. Split the patche into 3 patches.
4. Set the gendisk associated with the nvme namespace into readonly mode
   if identify namespace nsattr attribute indicates namesapce is write
   protected.

Regards,
Chaitanya

Chaitanya Kulkarni (3):
  nvme: add support for ns write protect definitions
  nvme-core: set gendisk read only based on nsattr
  nvmet: add ns write protect support

 drivers/nvme/host/core.c          |   6 ++
 drivers/nvme/target/admin-cmd.c   | 120 +++++++++++++++++++++++++++++-
 drivers/nvme/target/core.c        |   6 +-
 drivers/nvme/target/io-cmd-bdev.c |  12 +++
 drivers/nvme/target/io-cmd-file.c |  15 +++-
 drivers/nvme/target/nvmet.h       |   6 ++
 include/linux/nvme.h              |  17 ++++-
 7 files changed, 174 insertions(+), 8 deletions(-)

-- 
2.17.0
