From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri, 12 Jul 2019 17:57:36 -0600
Subject: [PATCH blktests 06/12] nvme/015: Ensure the namespace is flushed not
 the char device
In-Reply-To: <20190712235742.22646-1-logang@deltatee.com>
References: <20190712235742.22646-1-logang@deltatee.com>
Message-ID: <20190712235742.22646-7-logang@deltatee.com>

Flushing the char device now results in the warning:

   nvme nvme1: using deprecated NVME_IOCTL_IO_CMD ioctl on the char
	device!

Instead, call the flush on the namespace.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 tests/nvme/015 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/015 b/tests/nvme/015
index 47e1b048e16d..ca1216163e16 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -39,7 +39,7 @@ test() {
 
 	dd if=/dev/urandom of="/dev/${nvmedev}n1" count=128000 bs=4k status=none
 
-	nvme flush "/dev/${nvmedev}" -n 1
+	nvme flush "/dev/${nvmedev}n1" -n 1
 
 	nvme disconnect -n "${subsys_name}"
 
-- 
2.17.1
