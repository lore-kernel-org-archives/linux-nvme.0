From: wnukowski@google.com (Michal Wnukowski)
Date: Wed, 15 Aug 2018 15:51:57 -0700
Subject: [PATCH v2] Bugfix for handling of shadow doorbell buffer.
In-Reply-To: <CA+55aFxOc7_s-BbWJx-kyit-pH9m5fQJk6MSMJ57tFFvMtNh-w@mail.gmail.com>
References: <CA+55aFxOc7_s-BbWJx-kyit-pH9m5fQJk6MSMJ57tFFvMtNh-w@mail.gmail.com>
Message-ID: <20180815225157.89523-1-wnukowski@google.com>

This patch adds full memory barrier into nvme_dbbuf_update_and_check_event
function to ensure that the shadow doorbell is written before reading
EventIdx from memory. This is a critical bugfix for initial patch that
added support for shadow doorbell into NVMe driver
(f9f38e33389c019ec880f6825119c94867c1fde0).

This memory barrier is required because ?Loads may be reordered with
older stores to different locations? (quote from Intel 64 Architecture
Memory Ordering White Paper). The following two operations can be
reordered:
 - Write shadow doorbell (dbbuf_db) into memory.
 - Read EventIdx (dbbuf_ei) from memory.
This can result in a potential race condition between driver and VM host
processing requests (if given virtual NVMe controller has a support for
shadow doorbell). If that occurs, then virtual NVMe controller may
decide to wait for MMIO doorbell from guest operating system, and guest
driver may decide not to issue MMIO doorbell on any of subsequent
commands.

Note that NVMe controller should have similar ordering guarantees around
writing EventIdx and reading shadow doorbell. Otherwise, analogous race
condition may occur.

This issue is purely timing-dependent one, so there is no easy way to
reproduce it. Currently the easiest known approach is to run ?ORacle IO
Numbers? (orion) that is shipped with Oracle DB:

orion -run advanced -num_large 0 -size_small 8 -type rand -simulate
concat -write 40 -duration 120 -matrix row -testname nvme_test

Where nvme_test is a .lun file that contains a list of NVMe block
devices to run test against. Limiting number of vCPUs assigned to given
VM instance seems to increase chances for this bug to occur. On test
environment with VM that got 4 NVMe drives and 1 vCPU assigned the
virtual NVMe controller hang could be observed within 10-20 minutes.
That correspond to about 400-500k IO operations processed (or about
100GB of IO read/writes).

Orion tool was used as a validation and set to run in a loop for 36
hours (equivalent of pushing 550M IO operations). No issues were
observed. That suggest that the patch fixes the issue.

Fixes: f9f38e33389c (?nvme: improve performance for virtual NVMe devices?)
Signed-off-by: Michal Wnukowski <wnukowski at google.com>

changes since v1:
 - Additional note about NVMe controller behavior.
 - Removal of volatile keyword has been reverted.

---
 drivers/nvme/host/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 17a0190bd88f..4452f8553301 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -306,6 +306,14 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, u32 *dbbuf_db,
 		old_value = *dbbuf_db;
 		*dbbuf_db = value;
 
+		/*
+		 * Ensure that the doorbell is updated before reading
+		 * the EventIdx from memory. NVMe controller should have
+		 * similar ordering guarantees - update EventIdx before
+		 * reading doorbell.
+		 */
+		mb();
+
 		if (!nvme_dbbuf_need_event(*dbbuf_ei, value, old_value))
 			return false;
 	}
-- 
2.18.0.865.gffc8e1a3cd6-goog
