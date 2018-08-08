From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue,  7 Aug 2018 23:01:04 -0700
Subject: [PATCH V4 0/3] nvmet: add ns write protect feature
Message-ID: <20180808060107.5849-1-chaitanya.kulkarni@wdc.com>

Hi,

This patch series implements the support for NVMeOF target ns write
protect get/set-features command. In this implementation we support
Write Protect and No Write Protect state for the target ns which can be
toggled/read by set/get-features commands.  

Regards,
Chaitanya

Changes since V3:-
1. Introduce io-cmd check access routine which can be used in the future
   for io-cmd code path, remove the code for admin-cmd check when ns is
   write-protected for now.
2. Simplify nvmet_bdev_flush().                                                                           
3. Adjust the patch for latest code changes.

Changes since V2:-
1. Fix the offset numbering.
2. Use short-cut in nvmet_ns_wp_cmd_allow() for admin-cmds.
3. Get rid of conditional operators in nvmet_write_protect_flush_sync().
4. Use the original status from the file/bdev flush call.
5. Use simplified set and unset write-protect switch with
   subsus->mutex_lock synchronization.
6. Add helper to handle get-features for write-protect.
7. Don't initialize ns->readonly in nvmet_ns_alloc().
8. Use ! instead of false for nvmet_ns_wp_cmd_allow().
9. Get rid of blk_status_t in nvmet_bdev_flush().
10. Adjust the patch for latest ANA related code changes.

Changes since V1:-
1. Incorporate Christoph's comments.
2. Use feature not changeable error code in case of invalid state
   transition.
3. Split the patch into 3 patches.
4. Set the gendisk associated with the nvme namespace into readonly mode
   if identify namespace nsattr attribute indicates namesapce is write
   protected.


Chaitanya Kulkarni (3):
  nvme: add support for ns write protect definitions
  nvme-core: set gendisk read only based on nsattr
  nvmet: add ns write protect support

 drivers/nvme/host/core.c          |  6 +++
 drivers/nvme/target/admin-cmd.c   | 77 +++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c        | 20 +++++++-
 drivers/nvme/target/io-cmd-bdev.c |  8 ++++
 drivers/nvme/target/io-cmd-file.c | 15 ++++--
 drivers/nvme/target/nvmet.h       |  4 ++
 include/linux/nvme.h              | 17 ++++++-
 7 files changed, 141 insertions(+), 6 deletions(-)

-- 
2.17.0
