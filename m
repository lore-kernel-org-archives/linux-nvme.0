From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 11 Jun 2018 13:40:07 -0400
Subject: [PATCH] nvmet: add commands supported and effects log page
Message-ID: <20180611174007.5387-1-chaitanya.kulkarni@wdc.com>

This patch adds support for Commands Supported and Effects log page
(Log Identifier 05h) for NVMeOF. This also makes it easier to find
which commands are supported, e.g. :-

# nvme id-ctrl /dev/nvme0 | grep subnqn
subnqn    : testnqn1
# nvme effects-log /dev/nvme0
Admin Command Set
ACS2     [Get Log Page                    ] 00000001
ACS6     [Identify                        ] 00000001
ACS8     [Abort                           ] 00000001
ACS9     [Set Features                    ] 00000001
ACS10    [Get Features                    ] 00000001
ACS12    [Asynchronous Event Request      ] 00000001
ACS24    [Keep Alive                      ] 00000001

NVM Command Set
IOCS0    [Flush                           ] 00000001
IOCS1    [Write                           ] 00000001
IOCS2    [Read                            ] 00000001
IOCS8    [Write Zeroes                    ] 00000001
IOCS9    [Dataset Management              ] 00000001

This partticular functionality can be used from the host side to examine
the NVMeOF ctrl commands supported.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 35 ++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 38803576d5e1..dc2800bdac4b 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -128,6 +128,36 @@ static void nvmet_execute_get_log_page_smart(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
+static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
+{
+	u16 status = NVME_SC_INTERNAL;
+	struct nvme_effects_log *log;
+
+	log = kzalloc(sizeof(*log), GFP_KERNEL);
+	if (!log)
+		goto out;
+
+	log->acs[nvme_admin_get_log_page]	= 1 << 0;
+	log->acs[nvme_admin_identify]		= 1 << 0;
+	log->acs[nvme_admin_abort_cmd]		= 1 << 0;
+	log->acs[nvme_admin_set_features]	= 1 << 0;
+	log->acs[nvme_admin_get_features]	= 1 << 0;
+	log->acs[nvme_admin_async_event]	= 1 << 0;
+	log->acs[nvme_admin_keep_alive]		= 1 << 0;
+
+	log->iocs[nvme_cmd_read]		= 1 << 0;
+	log->iocs[nvme_cmd_write]		= 1 << 0;
+	log->iocs[nvme_cmd_flush]		= 1 << 0;
+	log->iocs[nvme_cmd_dsm]			= 1 << 0;
+	log->iocs[nvme_cmd_write_zeroes]	= 1 << 0;
+
+	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
+
+	kfree(log);
+out:
+	nvmet_req_complete(req, status);
+}
+
 static void nvmet_execute_get_log_changed_ns(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
@@ -208,7 +238,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	/* first slot is read-only, only one slot supported */
 	id->frmw = (1 << 0) | (1 << 1);
-	id->lpa = (1 << 0) | (1 << 2);
+	id->lpa = (1 << 0) | (1 << 1) | (1 << 2);
 	id->elpe = NVMET_ERROR_LOG_SLOTS - 1;
 	id->npss = 0;
 
@@ -586,6 +616,9 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 		case NVME_LOG_CHANGED_NS:
 			req->execute = nvmet_execute_get_log_changed_ns;
 			return 0;
+		case NVME_LOG_CMD_EFFECTS:
+			req->execute = nvmet_execute_get_log_cmd_effects_ns;
+			return 0;
 		}
 		break;
 	case nvme_admin_identify:
-- 
2.17.0
