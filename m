From: willy@linux.intel.com (Matthew Wilcox)
Date: Sun, 15 Jun 2014 06:28:31 -0400
Subject: [PULL REQUEST] NVMe driver updates for 3.16
Message-ID: <20140615102831.GE12025@linux.intel.com>


Hi Linus,

Mostly bugfixes again for the NVMe driver.  I'd like to call out the
exported tracepoint in the block layer; I believe Keith has cleared this
with Jens.  We've had a few reports from people who're really pounding
on NVMe devices at scale, hence the timeout changes (and new module
parameters), hotplug cpu deadlock, tracepoints, and minor performance
tweaks.

The following changes since commit 89ca3b881987f5a4be4c5dbaa7f0df12bbdde2fd:

  Linux 3.15-rc4 (2014-05-04 18:14:42 -0700)

are available in the git repository at:

  git://git.infradead.org/users/willy/linux-nvme.git 

for you to fetch changes up to b8e080847a7292347a3eee76264f77e4abcb61f7:

  NVMe: Fix START_STOP_UNIT Scsi->NVMe translation. (2014-06-13 13:11:00 -0400)

----------------------------------------------------------------
Dan McLeran (1):
      NVMe: Fix START_STOP_UNIT Scsi->NVMe translation.

Dimitri John Ledkov (1):
      NVMe: Update namespace and controller identify structures to the 1.1a spec

Indraneel Mukherjee (1):
      NVMe: Fix the buffer size passed in GetLogPage(CDW10.NUMD)

Keith Busch (9):
      NVMe: Protect against badly formatted CQEs
      NVMe: Add tracepoints
      NVMe: Configure support for block flush
      NVMe: Flush with data support
      NVMe: Make iod bio timeout a parameter
      NVMe: Make admin timeout a module parameter
      NVMe: Fix nvme get/put queue semantics
      NVMe: Use last bytes of f/w rev SCSI Inquiry
      NVMe: Fix hot cpu notification dead lock

Matthew Wilcox (8):
      NVMe: Update copyright headers
      NVMe: Improve error messages
      NVMe: Enable BUILD_BUG_ON checks
      NVMe: Update data structures for NVMe 1.2
      NVMe: Delete NVME_GET_FEAT_TEMP_THRESH
      NVMe: Rename io_timeout to nvme_io_timeout
      NVMe: Define Log Page constants
      NVMe: Use Log Page constants in SCSI emulation

Sam Bradshaw (1):
      NVMe: Adhere to request queue block accounting enable/disable

Santosh Y (1):
      NVMe: Prevent possible NULL pointer dereference

 block/blk-core.c          |   1 +
 drivers/block/nvme-core.c | 203 ++++++++++++++++++++++++++++++----------------
 drivers/block/nvme-scsi.c |  36 ++++----
 include/linux/nvme.h      |  14 ++--
 include/uapi/linux/nvme.h |  50 +++++++++---
 5 files changed, 194 insertions(+), 110 deletions(-)
