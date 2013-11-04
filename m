From: dmilburn@redhat.com (David Milburn)
Date: Mon,  4 Nov 2013 10:34:25 -0600
Subject: [PATCH]: NVMe: ioctl support for FLUSH command
Message-ID: <1383582865-4538-1-git-send-email-dmilburn@redhat.com>

Support for user space application to submit FLUSH command.

Signed-off-by: David Milburn <dmilburn at redhat.com>
---
 drivers/block/nvme-core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index da52092..4fab135 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1392,6 +1392,10 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	case nvme_cmd_compare:
 		iod = nvme_map_user_pages(dev, io.opcode & 1, io.addr, length);
 		break;
+	case nvme_cmd_flush:
+		nvmeq = get_nvmeq(dev);
+		status = nvme_submit_flush_data(nvmeq, ns);
+		return status;
 	default:
 		return -EINVAL;
 	}
