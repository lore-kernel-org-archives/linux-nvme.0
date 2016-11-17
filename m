From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 17 Nov 2016 14:54:47 +0200
Subject: [PATCH nvme-cli v2 1/2] nvme-cli: Add nvme hostnqn generation option
In-Reply-To: <1479387288-13367-1-git-send-email-sagi@grimberg.me>
References: <1479387288-13367-1-git-send-email-sagi@grimberg.me>
Message-ID: <1479387288-13367-2-git-send-email-sagi@grimberg.me>

Add option to generate a NVMe qualified name of a given host
(in the form of: nqn.2014-08.org.nvmexpress:NVMf:uuid:<some_uuid>).
This hostnqn will be used for fabrics discovery and connect functions.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 Makefile       |  1 +
 nvme-builtin.h |  1 +
 nvme.c         | 12 ++++++++++++
 3 files changed, 14 insertions(+)

diff --git a/Makefile b/Makefile
index 33c71902479a..2a946ce8cb61 100644
--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,6 @@
 CFLAGS += -std=gnu99 -O2 -g -Wall -Werror
 CPPFLAGS += -D_GNU_SOURCE -D__CHECK_ENDIAN__
+LDFLAGS += -luuid
 NVME = nvme
 INSTALL ?= install
 DESTDIR =
diff --git a/nvme-builtin.h b/nvme-builtin.h
index dc314cbbb371..b182b1e01f5b 100644
--- a/nvme-builtin.h
+++ b/nvme-builtin.h
@@ -49,6 +49,7 @@ COMMAND_LIST(
 	ENTRY("connect-all", "Discover and Connect to NVMeoF subsystems", connect_all_cmd)
 	ENTRY("connect", "Connect to NVMeoF subsystem", connect_cmd)
 	ENTRY("disconnect", "Disconnect from NVMeoF subsystem", disconnect_cmd)
+	ENTRY("gen-hostnqn", "Generate NVMeoF host NQN", gen_hostnqn_cmd)
 );
 
 #endif
diff --git a/nvme.c b/nvme.c
index 170fbec08d4c..82a958ca3f4c 100644
--- a/nvme.c
+++ b/nvme.c
@@ -44,6 +44,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/time.h>
+#include <uuid/uuid.h>
 
 #include "nvme-print.h"
 #include "nvme-ioctl.h"
@@ -2699,6 +2700,17 @@ static int admin_passthru(int argc, char **argv, struct command *cmd, struct plu
 	return passthru(argc, argv, NVME_IOCTL_ADMIN_CMD, desc, cmd);
 }
 
+static int gen_hostnqn_cmd(int argc, char **argv, struct command *command, struct plugin *plugin)
+{
+	uuid_t uuid;
+	char uuid_str[37]; /* e.g. 1b4e28ba-2fa1-11d2-883f-0016d3cca427 + \0 */
+
+	uuid_generate_random(uuid);
+	uuid_unparse_lower(uuid, uuid_str);
+	printf("nqn.2014-08.org.nvmexpress:NVMf:uuid:%s\n", uuid_str);
+	return 0;
+}
+
 static int discover_cmd(int argc, char **argv, struct command *command, struct plugin *plugin)
 {
 	const char *desc = "Send Get Log Page request to Discovery Controller.";
-- 
2.7.4
