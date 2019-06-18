From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 18 Jun 2019 22:12:14 +0900
Subject: [PATCH V7 5/7] nvme: Return errno mapped for nvme error status
In-Reply-To: <20190618131216.3661-1-minwoo.im.dev@gmail.com>
References: <20190618131216.3661-1-minwoo.im.dev@gmail.com>
Message-ID: <20190618131216.3661-6-minwoo.im.dev@gmail.com>

If ioctl module has returned a nvme error status, it will be returned
by being converted to a mapped errno value which has been provided by
previous commits.

Cc: Keith Busch <kbusch at kernel.org>
Cc: Chaitanya Kulkarni <chaitanya.Kulkarni at wdc.com>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 nvme.c | 106 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/nvme.c b/nvme.c
index d337b4a..9a00b26 100644
--- a/nvme.c
+++ b/nvme.c
@@ -48,6 +48,7 @@
 #include "common.h"
 #include "nvme-print.h"
 #include "nvme-ioctl.h"
+#include "nvme-status.h"
 #include "nvme-lightnvm.h"
 #include "plugin.h"
 
@@ -223,7 +224,7 @@ static int get_smart_log(int argc, char **argv, struct command *cmd, struct plug
 	close(fd);
 
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int get_ana_log(int argc, char **argv, struct command *cmd,
@@ -298,7 +299,7 @@ static int get_ana_log(int argc, char **argv, struct command *cmd,
 close_fd:
 	close(fd);
 ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int get_telemetry_log(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -428,7 +429,7 @@ static int get_telemetry_log(int argc, char **argv, struct command *cmd, struct
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int get_endurance_log(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -485,7 +486,7 @@ static int get_endurance_log(int argc, char **argv, struct command *cmd, struct
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int get_effects_log(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -550,7 +551,7 @@ static int get_effects_log(int argc, char **argv, struct command *cmd, struct pl
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int get_error_log(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -637,7 +638,7 @@ static int get_error_log(int argc, char **argv, struct command *cmd, struct plug
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int get_fw_log(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -694,7 +695,7 @@ static int get_fw_log(int argc, char **argv, struct command *cmd, struct plugin
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int get_changed_ns_list_log(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -752,7 +753,7 @@ static int get_changed_ns_list_log(int argc, char **argv, struct command *cmd, s
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int get_log(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -854,7 +855,7 @@ static int get_log(int argc, char **argv, struct command *cmd, struct plugin *pl
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int sanitize_log(int argc, char **argv, struct command *command, struct plugin *plugin)
@@ -919,7 +920,7 @@ static int sanitize_log(int argc, char **argv, struct command *command, struct p
  close_fd:
 	close(fd);
  ret:
-	return ret;
+	return nvme_status_to_errno(ret, false);
 }
 
 static int list_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -975,7 +976,7 @@ static int list_ctrl(int argc, char **argv, struct command *cmd, struct plugin *
 close_fd:
 	close(fd);
 ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int list_ns(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -1029,7 +1030,7 @@ static int list_ns(int argc, char **argv, struct command *cmd, struct plugin *pl
 close_fd:
 	close(fd);
 ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int get_nsid(int fd)
@@ -1103,7 +1104,7 @@ static int delete_ns(int argc, char **argv, struct command *cmd, struct plugin *
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int nvme_attach_ns(int argc, char **argv, int attach, const char *desc, struct command *cmd)
@@ -1170,7 +1171,7 @@ static int nvme_attach_ns(int argc, char **argv, int attach, const char *desc, s
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int attach_ns(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -1300,7 +1301,7 @@ static int create_ns(int argc, char **argv, struct command *cmd, struct plugin *
 close_fd:
 	close(fd);
 ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 char *nvme_char_from_block(char *block)
@@ -1788,7 +1789,7 @@ free:
 		free(subsysnqn);
 
 ret:
-	return ret;
+	return nvme_status_to_errno(ret, false);
 }
 
 static int get_nvme_info(int fd, struct list_item *item, const char *node)
@@ -1921,7 +1922,7 @@ static int list(int argc, char **argv, struct command *cmd, struct plugin *plugi
 		free(devices[i]);
 	free(devices);
  ret:
-	return ret;
+	return nvme_status_to_errno(ret, false);
 }
 
 int __id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin, void (*vs)(__u8 *vs, struct json_object *root))
@@ -1997,7 +1998,7 @@ int __id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin,
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -2080,7 +2081,7 @@ static int ns_descs(int argc, char **argv, struct command *cmd, struct plugin *p
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int id_ns(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -2169,7 +2170,7 @@ static int id_ns(int argc, char **argv, struct command *cmd, struct plugin *plug
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int id_nvmset(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -2229,7 +2230,7 @@ static int id_nvmset(int argc, char **argv, struct command *cmd, struct plugin *
 close_fd:
 	close(fd);
 ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int get_ns_id(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -2258,7 +2259,7 @@ static int get_ns_id(int argc, char **argv, struct command *cmd, struct plugin *
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int virtual_mgmt(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -2325,8 +2326,7 @@ static int virtual_mgmt(int argc, char **argv, struct command *cmd, struct plugi
 
 	close(fd);
 ret:
-	return err;
-
+	return nvme_status_to_errno(err, false);
 }
 
 static int list_secondary_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -2404,7 +2404,7 @@ static int list_secondary_ctrl(int argc, char **argv, struct command *cmd, struc
 close_fd:
 	close(fd);
 ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int device_self_test(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -2455,7 +2455,7 @@ static int device_self_test(int argc, char **argv, struct command *cmd, struct p
 
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int self_test_log(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -2513,7 +2513,7 @@ static int self_test_log(int argc, char **argv, struct command *cmd, struct plug
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int get_feature(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -2646,7 +2646,7 @@ static int get_feature(int argc, char **argv, struct command *cmd, struct plugin
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int fw_download(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -2753,7 +2753,7 @@ static int fw_download(int argc, char **argv, struct command *cmd, struct plugin
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static char *nvme_fw_status_reset_type(__u32 status)
@@ -2848,7 +2848,7 @@ static int fw_commit(int argc, char **argv, struct command *cmd, struct plugin *
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int subsystem_reset(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -2877,7 +2877,7 @@ static int subsystem_reset(int argc, char **argv, struct command *cmd, struct pl
 
 	close(fd);
 ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int reset(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -2901,7 +2901,7 @@ static int reset(int argc, char **argv, struct command *cmd, struct plugin *plug
 
 	close(fd);
 ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int ns_rescan(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -2925,7 +2925,7 @@ static int ns_rescan(int argc, char **argv, struct command *cmd, struct plugin *
 
 	close(fd);
 ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int sanitize(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -3019,7 +3019,7 @@ static int sanitize(int argc, char **argv, struct command *cmd, struct plugin *p
  close_fd:
 	close(fd);
  ret:
-	return ret;
+	return nvme_status_to_errno(ret, false);
 }
 
 static int show_registers(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -3094,7 +3094,7 @@ static int show_registers(int argc, char **argv, struct command *cmd, struct plu
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int get_property(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -3148,7 +3148,7 @@ static int get_property(int argc, char **argv, struct command *cmd, struct plugi
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int set_property(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -3205,7 +3205,7 @@ static int set_property(int argc, char **argv, struct command *cmd, struct plugi
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int format(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -3368,7 +3368,7 @@ static int format(int argc, char **argv, struct command *cmd, struct plugin *plu
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int set_feature(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -3490,7 +3490,7 @@ static int set_feature(int argc, char **argv, struct command *cmd, struct plugin
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int sec_send(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -3589,7 +3589,7 @@ static int sec_send(int argc, char **argv, struct command *cmd, struct plugin *p
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int dir_send(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -3743,7 +3743,7 @@ free:
 close_fd:
 	close(fd);
 ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int write_uncor(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -3800,7 +3800,7 @@ static int write_uncor(int argc, char **argv, struct command *cmd, struct plugin
 close_fd:
 	close(fd);
 ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int write_zeroes(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -3894,7 +3894,7 @@ static int write_zeroes(int argc, char **argv, struct command *cmd, struct plugi
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int dsm(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -3997,7 +3997,7 @@ static int dsm(int argc, char **argv, struct command *cmd, struct plugin *plugin
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int flush(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -4047,7 +4047,7 @@ static int flush(int argc, char **argv, struct command *cmd, struct plugin *plug
 close_fd:
 	close(fd);
 ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int resv_acquire(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -4124,7 +4124,7 @@ static int resv_acquire(int argc, char **argv, struct command *cmd, struct plugi
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int resv_register(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -4204,7 +4204,7 @@ static int resv_register(int argc, char **argv, struct command *cmd, struct plug
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int resv_release(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -4280,7 +4280,7 @@ static int resv_release(int argc, char **argv, struct command *cmd, struct plugi
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int resv_report(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -4377,7 +4377,7 @@ static int resv_report(int argc, char **argv, struct command *cmd, struct plugin
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int submit_io(int opcode, char *command, const char *desc,
@@ -4625,7 +4625,7 @@ static int submit_io(int opcode, char *command, const char *desc,
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int compare(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -4734,7 +4734,7 @@ static int sec_recv(int argc, char **argv, struct command *cmd, struct plugin *p
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int dir_receive(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -4867,7 +4867,7 @@ free:
 close_fd:
 	close(fd);
 ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, struct command *cmd)
@@ -5070,7 +5070,7 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
  close_fd:
 	close(fd);
  ret:
-	return err;
+	return nvme_status_to_errno(err, false);
 }
 
 static int io_passthru(int argc, char **argv, struct command *cmd, struct plugin *plugin)
-- 
2.21.0
