From: paul.grabinar@ranbarg.com (Paul Grabinar)
Date: Thu, 23 Jul 2015 21:03:37 +0100
Subject: nvme-cli format timeout
Message-ID: <55B14899.5000407@ranbarg.com>

Hi,

I am aware of some NVMe drives that take well over 60 seconds to perform
a format and therefore timeout during the format command issued by nvme-cli.

We might want to consider increasing the timeout. The following patch is
an example to show what I mean.

Thanks.

diff --git a/nvme.c b/nvme.c
index 02f4dec..5c99dea 100644
--- a/nvme.c
+++ b/nvme.c
@@ -51,6 +51,8 @@
 
 #define min(x, y) (x) > (y) ? (y) : (x)
 
+#define	FORMAT_TIMEOUT	120000	// 120 seconds
+
 static int fd;
 static struct stat nvme_stat;
 static const char *devicename;
@@ -2132,6 +2134,7 @@ static int format(int argc, char **argv)
 	cmd.opcode = nvme_admin_format_nvm;
 	cmd.nsid   = cfg.namespace_id;
 	cmd.cdw10  = (cfg.lbaf << 0) | (cfg.ms << 4) | (cfg.pi << 5) | (cfg.pil << 8) | (cfg.ses << 9);
+	cmd.timeout_ms = FORMAT_TIMEOUT;
 
 	err = ioctl(fd, NVME_IOCTL_ADMIN_CMD, &cmd);
 	if (err < 0)
