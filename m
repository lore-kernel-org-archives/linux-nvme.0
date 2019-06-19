From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 19 Jun 2019 10:36:59 -0700
Subject: [PATCH nvme-cli 11/13] nvme-cli: Skip properties that are not
 supported
In-Reply-To: <20190619173701.8263-1-bvanassche@acm.org>
References: <20190619173701.8263-1-bvanassche@acm.org>
Message-ID: <20190619173701.8263-12-bvanassche@acm.org>

Instead of causing the show-regs command to fail if a property is
encountered that is not supported by the target side, do not display
the property. With this patch applied the following output is displayed
for the Linux NVMf target:

$ nvme show-regs /dev/nvme0
cap     : f0003ff
version : 10300
cc      : 460001
csts    : 1

Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 nvme-ioctl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index 0c8de0748c18..57fae22e1e37 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -614,7 +614,10 @@ int nvme_get_properties(int fd, void **pbar)
 	memset(*pbar, 0xff, size);
 	for (offset = NVME_REG_CAP; offset <= NVME_REG_CMBSZ;) {
 		err = nvme_get_property(fd, offset, &value);
-		if (err) {
+		if (err > 0 && (err & 0xff) == NVME_SC_INVALID_FIELD) {
+			err = 0;
+			value = -1;
+		} else if (err) {
 			free(*pbar);
 			break;
 		}
-- 
2.22.0.rc3
