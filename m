From: jsmart2021@gmail.com (James Smart)
Date: Fri, 27 Apr 2018 10:29:39 -0700
Subject: [PATCH] nvme-cli: Wait for device file if not present after
 successful add_ctrl
Message-ID: <20180427172939.3571-1-jsmart2021@gmail.com>

It's possible for the transport to return very quickly after add_ctrl
such that the cli may attempt to access the /dev/nvme? device file
before the udev event has propagated to user space to create the device
file. In these cases, the open fails with EAGAIN.

As the add_ctrl call was successful, thus there "should" be a device
file, if the open fails with EAGAIN delay 500ms and try again. Wait
for at most 2 seconds for the device file to come into existence.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 fabrics.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index 7e9d56c..408afb0 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -171,6 +171,32 @@ static const char *cms_str(__u8 cm)
 
 static int do_discover(char *argstr, bool connect);
 
+#define OPEN_RETRIES	4
+#define OPEN_DELAY	500000		/* us units, thus 1/2 second */
+
+static void
+wait_for_devname(int instance)
+{
+	char *dev_name;
+	int retry = 0, fd;
+
+	if (asprintf(&dev_name, "/dev/nvme%d", instance) < 0)
+		return;
+
+	/* takes a little time for udev to make the dev node */
+	for ( ; retry < OPEN_RETRIES; retry++) {
+		fd = open(dev_name, O_RDWR);
+		if (fd >= 0) {
+			close(fd);
+			break;
+		}
+		if (errno != EAGAIN)
+			break;
+		usleep(OPEN_DELAY);
+	}
+	free(dev_name);
+}
+
 static int add_ctrl(const char *argstr)
 {
 	substring_t args[MAX_OPT_ARGS];
@@ -225,6 +251,8 @@ out_fail:
 out_close:
 	close(fd);
 out:
+	if (ret >= 0)
+		wait_for_devname(ret);
 	return ret;
 }
 
-- 
2.13.1
