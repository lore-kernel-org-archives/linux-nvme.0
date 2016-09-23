From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Sep 2016 20:22:57 -0700
Subject: [PATCH 06/18] various trivial sparse fixes
In-Reply-To: <1474600989-16657-1-git-send-email-hch@lst.de>
References: <1474600989-16657-1-git-send-email-hch@lst.de>
Message-ID: <1474600989-16657-7-git-send-email-hch@lst.de>

Use NULL instead of 0 for pointers, mark symbols static as needed
and provide proper ANSI C prototypes for all functions.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 Makefile        |  2 +-
 argconfig.c     | 10 ++++-----
 cmd_handler.h   |  4 ++--
 fabrics.c       | 10 ++++-----
 intel-nvme.c    | 10 ++++-----
 lnvm-nvme.c     | 18 +++++++--------
 memblaze-nvme.c |  6 ++---
 nvme-ioctl.c    |  6 ++---
 nvme-lightnvm.c |  8 +++----
 nvme-print.c    |  8 +++----
 nvme-print.h    | 14 ++++++------
 nvme.c          | 68 ++++++++++++++++++++++++++++-----------------------------
 12 files changed, 82 insertions(+), 82 deletions(-)

diff --git a/Makefile b/Makefile
index 39597dc..1d68d76 100644
--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,5 @@
 CFLAGS += -std=gnu99 -O2 -g -Wall -Werror
-CPPFLAGS += -D_GNU_SOURCE
+CPPFLAGS += -D_GNU_SOURCE -D__CHECK_ENDIAN__
 NVME = nvme
 INSTALL ?= install
 DESTDIR =
diff --git a/argconfig.c b/argconfig.c
index 41bb6d9..e2bb7ab 100644
--- a/argconfig.c
+++ b/argconfig.c
@@ -42,9 +42,9 @@
 
 static argconfig_help_func *help_funcs[MAX_HELP_FUNC] = { NULL };
 
-char END_DEFAULT[] = "__end_default__";
+static char END_DEFAULT[] = "__end_default__";
 
-const char *append_usage_str = "";
+static const char *append_usage_str = "";
 
 void argconfig_append_usage(const char *str)
 {
@@ -130,7 +130,7 @@ static void argconfig_print_help(const char *program_desc,
 	print_word_wrapped(program_desc, 0, 0);
 	printf("\n\n\033[1mOptions:\033[0m\n");
 
-	for (s = options; (s->option != 0) && (s != NULL); s++)
+	for (s = options; (s->option != NULL) && (s != NULL); s++)
 		show_option(s);
 }
 
@@ -146,13 +146,13 @@ int argconfig_parse(int argc, char *argv[], const char *program_desc,
 	void *value_addr;
 
 	errno = 0;
-	for (s = options; s->option != 0; s++)
+	for (s = options; s->option != NULL; s++)
 		options_count++;
 
 	long_opts = malloc(sizeof(struct option) * (options_count + 2));
 	short_opts = malloc(sizeof(*short_opts) * (options_count * 3 + 4));
 
-	for (s = options; (s->option != 0) && (option_index < options_count);
+	for (s = options; (s->option != NULL) && (option_index < options_count);
 	     s++) {
 		if (s->short_option != 0) {
 			short_opts[short_index++] = s->short_option;
diff --git a/cmd_handler.h b/cmd_handler.h
index e5979b0..b2e3e9d 100644
--- a/cmd_handler.h
+++ b/cmd_handler.h
@@ -87,8 +87,8 @@ static struct plugin plugin = {				\
 	.commands = commands				\
 }; 							\
 							\
-static void init() __attribute__((constructor)); 	\
-static void init()					\
+static void init(void) __attribute__((constructor)); 	\
+static void init(void)					\
 {							\
 	register_extension(&plugin);			\
 }
diff --git a/fabrics.c b/fabrics.c
index dff5d6a..ad06392 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -44,7 +44,7 @@
 
 #include "common.h"
 
-struct config {
+static struct config {
 	char *nqn;
 	char *transport;
 	char *traddr;
@@ -55,7 +55,7 @@ struct config {
 	char *reconnect_delay;
 	char *raw;
 	char *device;
-} cfg = { 0 };
+} cfg = { NULL };
 
 #define BUF_SIZE		4096
 #define PATH_NVME_FABRICS	"/dev/nvme-fabrics"
@@ -718,7 +718,7 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 		 "user-defined hostnqn (if default not used)" },
 		{"raw", 'r', "LIST", CFG_STRING, &cfg.raw, required_argument,
 		 "raw output file" },
-		{0},
+		{NULL},
 	};
 
 	argconfig_parse(argc, argv, desc, command_line_options, &cfg,
@@ -761,7 +761,7 @@ int connect(const char *desc, int argc, char **argv)
 			"keep alive timeout period in seconds" },
 		{"reconnect-delay", 'r', "LIST", CFG_STRING, &cfg.reconnect_delay, required_argument,
 			"reconnect timeout period in seconds" },
-		{0},
+		{NULL},
 	};
 
 	argconfig_parse(argc, argv, desc, command_line_options, &cfg,
@@ -885,7 +885,7 @@ int disconnect(const char *desc, int argc, char **argv)
 		 required_argument, nqn},
 		{"device", 'd', "LIST", CFG_STRING, &cfg.device,
 		 required_argument, device},
-		{0},
+		{NULL},
 	};
 
 	argconfig_parse(argc, argv, desc, command_line_options, &cfg,
diff --git a/intel-nvme.c b/intel-nvme.c
index 31b664d..e824a2e 100644
--- a/intel-nvme.c
+++ b/intel-nvme.c
@@ -61,7 +61,7 @@ static int get_additional_smart_log(int argc, char **argv, struct command *cmd,
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"namespace-id", 'n', "NUM", CFG_POSITIVE, &cfg.namespace_id, required_argument, namespace},
 		{"raw-binary",   'b', "",    CFG_NONE,     &cfg.raw_binary,   no_argument,       raw},
-		{0}
+		{NULL}
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -95,7 +95,7 @@ static int get_market_log(int argc, char **argv, struct command *cmd, struct plu
 
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"raw-binary", 'b', "", CFG_NONE, &cfg.raw_binary, no_argument, raw},
-		{0}
+		{NULL}
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -155,7 +155,7 @@ static int get_temp_stats_log(int argc, char **argv, struct command *cmd, struct
 
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"raw-binary", 'b', "", CFG_NONE, &cfg.raw_binary, no_argument, raw},
-		{0}
+		{NULL}
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -221,7 +221,7 @@ static int get_lat_stats_log(int argc, char **argv, struct command *cmd, struct
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"write",      'w', "", CFG_NONE, &cfg.write,      no_argument, write},
 		{"raw-binary", 'b', "", CFG_NONE, &cfg.raw_binary, no_argument, raw},
-		{0}
+		{NULL}
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -275,7 +275,7 @@ static int get_internal_log(int argc, char **argv, struct command *command, stru
 		{"log",          'l', "NUM",  CFG_POSITIVE, &cfg.log,          required_argument, log},
 		{"namespace-id", 'n', "NUM",  CFG_POSITIVE, &cfg.namespace_id, required_argument, namespace_id},
 		{"output-file",  'o', "FILE", CFG_STRING,   &cfg.file,         required_argument, file},
-		{0}
+		{NULL}
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
diff --git a/lnvm-nvme.c b/lnvm-nvme.c
index eabdf37..d12ac3e 100644
--- a/lnvm-nvme.c
+++ b/lnvm-nvme.c
@@ -39,7 +39,7 @@ static int lnvm_init(int argc, char **argv, struct command *cmd, struct plugin *
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"device-name",   'd', "DEVICE", CFG_STRING, &cfg.devname, required_argument, devname},
 		{"mediamgr-name", 'm', "MM",     CFG_STRING, &cfg.mmtype,  required_argument, mmtype},
-		{0}
+		{NULL}
 	};
 
 	argconfig_parse(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -57,7 +57,7 @@ static int lnvm_list(int argc, char **argv, struct command *cmd, struct plugin *
 	const char *desc = "List all devices registered with LightNVM.";
 
 	const struct argconfig_commandline_options command_line_options[] = {
-		{0}
+		{NULL}
 	};
 
 	argconfig_parse(argc, argv, desc, command_line_options, NULL, 0);
@@ -70,7 +70,7 @@ static int lnvm_info(int argc, char **argv, struct command *cmd, struct plugin *
 	const char *desc = "Show general information and registered target types with LightNVM";
 
 	const struct argconfig_commandline_options command_line_options[] = {
-		{0}
+		{NULL}
 	};
 
 	argconfig_parse(argc, argv, desc, command_line_options, NULL, 0);
@@ -105,7 +105,7 @@ static int lnvm_id_ns(int argc, char **argv, struct command *cmd, struct plugin
 		{"force",           'f', "FLAG", CFG_NONE,     &cfg.force,           no_argument,       force},
 		{"raw-binary",      'b', "FLAG", CFG_NONE,     &cfg.raw_binary,      no_argument,       raw_binary},
 		{"human-readable",  'H', "FLAG", CFG_NONE,     &cfg.human_readable,  no_argument,       human_readable},
-		{0}
+		{NULL}
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -151,7 +151,7 @@ static int lnvm_create_tgt(int argc, char **argv, struct command *cmd, struct pl
 		{"target-type",   't', "TARGETTYPE",  CFG_STRING,    &cfg.tgttype,   required_argument, tgttype},
 		{"lun-begin",     'b', "NUM",    CFG_POSITIVE,  &cfg.lun_begin,      required_argument,       lun_begin},
 		{"lun-end",       'e', "NUM",    CFG_POSITIVE,  &cfg.lun_end,   required_argument,       lun_end},
-		{0}
+		{NULL}
 	};
 
 	argconfig_parse(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -188,7 +188,7 @@ static int lnvm_remove_tgt(int argc, char **argv, struct command *cmd, struct pl
 
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"target-name",   'n', "TARGET", CFG_STRING,    &cfg.tgtname,   required_argument, tgtname},
-		{0}
+		{NULL}
 	};
 
 	argconfig_parse(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -226,7 +226,7 @@ static int lnvm_factory_init(int argc, char **argv, struct command *cmd, struct
 		{"erase-only-marked",    'e', "",       CFG_NONE,   &cfg.erase_only_marked, no_argument,       erase_only_marked},
 		{"clear-host-side-blks", 's', "",       CFG_NONE,   &cfg.clear_host_marks,  no_argument,       host_marks},
 		{"clear-bb-blks",        'b', "",       CFG_NONE,   &cfg.clear_bb_marks,    no_argument,       bb_marks},
-		{0}
+		{NULL}
 	};
 
 	argconfig_parse(argc, argv, desc, command_line_options, &cfg,
@@ -270,7 +270,7 @@ static int lnvm_get_bbtbl(int argc, char **argv, struct command *cmd, struct plu
 		{"channel-id",   'c', "",     CFG_SHORT,    &cfg.chid,         required_argument, ch},
 		{"lun-id",       'l', "",     CFG_SHORT,    &cfg.lunid,        required_argument, lun},
 		{"raw-binary",   'b', "FLAG", CFG_NONE,     &cfg.raw_binary,   no_argument,       raw_binary},
-		{0}
+		{NULL}
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -320,7 +320,7 @@ static int lnvm_set_bbtbl(int argc, char **argv, struct command *cmd, struct plu
 		{"plane-id",     'p', "NUM",     CFG_SHORT,    &cfg.plnid,        required_argument, pln},
 		{"block-id",     'b', "NUM",     CFG_SHORT,    &cfg.blkid,        required_argument, blk},
 		{"value",        'v', "NUM",     CFG_SHORT,    &cfg.value,        required_argument, value},
-		{0}
+		{NULL}
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
diff --git a/memblaze-nvme.c b/memblaze-nvme.c
index 3dc8c03..50f11bd 100644
--- a/memblaze-nvme.c
+++ b/memblaze-nvme.c
@@ -157,7 +157,7 @@ static int get_additional_smart_log(int argc, char **argv, struct command *cmd,
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"namespace-id", 'n', "NUM", CFG_POSITIVE, &cfg.namespace_id, required_argument, namespace},
 		{"raw-binary",   'b', "",    CFG_NONE,     &cfg.raw_binary,   no_argument,       raw},
-		{0}
+		{NULL}
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -234,7 +234,7 @@ static int get_additional_feature(int argc, char **argv, struct command *cmd, st
 		{"raw-binary",     'b', "FLAG", CFG_NONE,     &cfg.raw_binary,     no_argument,       raw_binary},
 		{"cdw11",          'c', "NUM", CFG_POSITIVE, &cfg.cdw11,          required_argument, cdw11},
 		{"human-readable", 'H', "FLAG", CFG_NONE,     &cfg.human_readable, no_argument,       human_readable},
-		{0}
+		{NULL}
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -327,7 +327,7 @@ static int set_additional_feature(int argc, char **argv, struct command *cmd, st
 		{"data-len",     'l', "NUM",  CFG_POSITIVE, &cfg.data_len,     required_argument, data_len},
 		{"data",         'd', "FILE", CFG_STRING,   &cfg.file,         required_argument, data},
 		{"save",         's', "FLAG", CFG_NONE,     &cfg.save,         no_argument, save},
-		{0}
+		{NULL}
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index 188f080..f2c72f5 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -21,7 +21,7 @@
 
 #include "nvme-ioctl.h"
 
-void nvme_verify_chr(int fd)
+static void nvme_verify_chr(int fd)
 {
 	static struct stat nvme_stat;
 	int err = fstat(fd, &nvme_stat);
@@ -70,12 +70,12 @@ int nvme_submit_passthru(int fd, int ioctl_cmd, struct nvme_passthru_cmd *cmd)
 	return ioctl(fd, ioctl_cmd, cmd);
 }
 
-int nvme_submit_admin_passthru(int fd, struct nvme_passthru_cmd *cmd)
+static int nvme_submit_admin_passthru(int fd, struct nvme_passthru_cmd *cmd)
 {
 	return ioctl(fd, NVME_IOCTL_ADMIN_CMD, cmd);
 }
 
-int nvme_submit_io_passthru(int fd, struct nvme_passthru_cmd *cmd)
+static int nvme_submit_io_passthru(int fd, struct nvme_passthru_cmd *cmd)
 {
 	return ioctl(fd, NVME_IOCTL_IO_CMD, cmd);
 }
diff --git a/nvme-lightnvm.c b/nvme-lightnvm.c
index 03fcd70..970976b 100644
--- a/nvme-lightnvm.c
+++ b/nvme-lightnvm.c
@@ -217,7 +217,7 @@ int lnvm_do_factory_init(char *devname, int erase_only_marked,
 	return ret;
 }
 
-void show_lnvm_id_grp(struct nvme_nvm_id_group *grp)
+static void show_lnvm_id_grp(struct nvme_nvm_id_group *grp)
 {
 	printf(" mtype   : %d\n", grp->mtype);
 	printf(" fmtype  : %d\n", grp->fmtype);
@@ -240,7 +240,7 @@ void show_lnvm_id_grp(struct nvme_nvm_id_group *grp)
 	printf(" cpar    : %#x\n", (uint16_t)le16toh(grp->cpar));
 }
 
-void show_lnvm_ppaf(struct nvme_nvm_addr_format *ppaf)
+static void show_lnvm_ppaf(struct nvme_nvm_addr_format *ppaf)
 {
 	printf("ppaf     :\n");
 	printf(" ch offs : %d ch bits  : %d\n",
@@ -257,7 +257,7 @@ void show_lnvm_ppaf(struct nvme_nvm_addr_format *ppaf)
 					ppaf->sect_offset, ppaf->sect_len);
 }
 
-void show_lnvm_id_ns(struct nvme_nvm_id *id)
+static void show_lnvm_id_ns(struct nvme_nvm_id *id)
 {
 	int i;
 
@@ -279,7 +279,7 @@ void show_lnvm_id_ns(struct nvme_nvm_id *id)
 	}
 }
 
-int lnvm_get_identity(int fd, int nsid, struct nvme_nvm_id *nvm_id)
+static int lnvm_get_identity(int fd, int nsid, struct nvme_nvm_id *nvm_id)
 {
 	struct nvme_admin_cmd cmd = {
 		.opcode		= nvme_nvm_admin_identity,
diff --git a/nvme-print.c b/nvme-print.c
index 4d2c9b6..89413e0 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1417,7 +1417,7 @@ void show_registers_version(__u32 vs)
 	printf("\tNVMe specification %d.%d\n\n", (vs & 0xffff0000) >> 16,  (vs & 0x0000ff00) >> 8);
 }
 
-void show_registers_cc_ams (__u8 ams)
+static void show_registers_cc_ams (__u8 ams)
 {
 	printf("\tArbitration Mechanism Selected     (AMS): ");
 	switch (ams) {
@@ -1435,7 +1435,7 @@ void show_registers_cc_ams (__u8 ams)
 	}
 }
 
-void show_registers_cc_shn (__u8 shn)
+static void show_registers_cc_shn (__u8 shn)
 {
 	printf("\tShutdown Notification              (SHN): ");
 	switch (shn) {
@@ -1464,7 +1464,7 @@ void show_registers_cc (__u32 cc)
 	printf("\tEnable                              (EN): %s\n\n", (cc & 0x00000001) ? "Yes":"No");
 }
 
-void show_registers_csts_shst (__u8 shst)
+static void show_registers_csts_shst (__u8 shst)
 {
 	printf("\tShutdown Status               (SHST): ");
 	switch (shst) {
@@ -1510,7 +1510,7 @@ void show_registers_cmbloc(__u32 cmbloc, __u32 cmbsz)
 	}
 }
 
-char *nvme_register_szu_to_string(__u8 szu)
+static char *nvme_register_szu_to_string(__u8 szu)
 {
 	switch (szu) {
 	case 0:	return "4 KB";
diff --git a/nvme-print.h b/nvme-print.h
index b62a241..eec3b05 100644
--- a/nvme-print.h
+++ b/nvme-print.h
@@ -37,13 +37,13 @@ void json_error_log(struct nvme_error_log_page *err_log, int entries, const char
 void json_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char *devname);
 void json_fw_log(struct nvme_firmware_log_page *fw_log, const char *devname);
 
-void show_registers_version();
-void show_registers_cap();
-void show_registers_cc();
-void show_registers_csts();
-void show_registers_aqa();
-void show_registers_cmbloc();
-void show_registers_cmbsz();
+void show_registers_version(__u32 vs);
+void show_registers_cap(struct nvme_bar_cap *cap);
+void show_registers_cc(__u32 cc);
+void show_registers_csts(__u32 csts);
+void show_registers_aqa(__u32 aqa);
+void show_registers_cmbloc(__u32 cmbloc, __u32 cmbsz);
+void show_registers_cmbsz(__u32 cmbsz);
 
 
 #endif
diff --git a/nvme.c b/nvme.c
index dac9d7d..66ce668 100644
--- a/nvme.c
+++ b/nvme.c
@@ -138,7 +138,7 @@ int parse_and_open(int argc, char **argv, const char *desc,
 	return fd;
 }
 
-const char *output_format = "Output format: normal|json|binary";
+static const char *output_format = "Output format: normal|json|binary";
 
 enum {
 	NORMAL,
@@ -184,7 +184,7 @@ static int get_smart_log(int argc, char **argv, struct command *cmd, struct plug
 		{"namespace-id", 'n', "NUM", CFG_POSITIVE, &cfg.namespace_id, required_argument, namespace},
 		{"output-format", 'o', "FMT", CFG_STRING, &cfg.output_format, required_argument, output_format },
 		{"raw-binary",   'b', "",    CFG_NONE,     &cfg.raw_binary,   no_argument,       raw},
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -230,7 +230,7 @@ static int get_additional_smart_log(int argc, char **argv, struct command *cmd,
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"namespace-id", 'n', "NUM", CFG_POSITIVE, &cfg.namespace_id, required_argument, namespace},
 		{"raw-binary",   'b', "",    CFG_NONE,     &cfg.raw_binary,   no_argument,       raw},
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -277,7 +277,7 @@ static int get_error_log(int argc, char **argv, struct command *cmd, struct plug
 		{"log-entries",  'e', "NUM",  CFG_POSITIVE, &cfg.log_entries,  required_argument, log_entries},
 		{"raw-binary",   'b', "",     CFG_NONE,     &cfg.raw_binary,   no_argument,       raw_binary},
 		{"output-format", 'o', "FMT", CFG_STRING, &cfg.output_format, required_argument, output_format },
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -344,7 +344,7 @@ static int get_fw_log(int argc, char **argv, struct command *cmd, struct plugin
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"raw-binary", 'b', "",   CFG_NONE, &cfg.raw_binary,   no_argument,       raw_binary},
 		{"output-format", 'o', "FMT", CFG_STRING, &cfg.output_format, required_argument, output_format },
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -401,7 +401,7 @@ static int get_log(int argc, char **argv, struct command *cmd, struct plugin *pl
 		{"log-id",       'i', "NUM",  CFG_POSITIVE, &cfg.log_id,       required_argument, log_id},
 		{"log-len",      'l', "NUM",  CFG_POSITIVE, &cfg.log_len,      required_argument, log_len},
 		{"raw-binary",   'b', "",     CFG_NONE,     &cfg.raw_binary,   no_argument,       raw_binary},
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -456,7 +456,7 @@ static int list_ctrl(int argc, char **argv, struct command *cmd, struct plugin *
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"cntid",        'c', "NUM", CFG_SHORT,    &cfg.cntid,        required_argument, controller},
 		{"namespace-id", 'n', "NUM", CFG_POSITIVE, &cfg.namespace_id, required_argument, namespace_id},
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -498,7 +498,7 @@ static int list_ns(int argc, char **argv, struct command *cmd, struct plugin *pl
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"namespace-id", 'n', "NUM",  CFG_POSITIVE, &cfg.namespace_id, required_argument, namespace_id},
 		{"all",          'a', "",     CFG_NONE,     &cfg.all,          no_argument,       all},
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -536,7 +536,7 @@ static int delete_ns(int argc, char **argv, struct command *cmd, struct plugin *
 
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"namespace-id", 'n', "NUM",  CFG_POSITIVE, &cfg.namespace_id,    required_argument, namespace_id},
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -579,7 +579,7 @@ static int nvme_attach_ns(int argc, char **argv, int attach, const char *desc, s
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"namespace-id", 'n', "NUM",  CFG_POSITIVE, &cfg.namespace_id, required_argument, namespace_id},
 		{"controllers",  'c', "LIST", CFG_STRING,   &cfg.cntlist,      required_argument, cont},
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -662,7 +662,7 @@ static int create_ns(int argc, char **argv, struct command *cmd, struct plugin *
 		{"flbas", 'f', "NUM", CFG_BYTE,        &cfg.flbas, required_argument, flbas},
 		{"dps",   'd', "NUM", CFG_BYTE,        &cfg.dps,   required_argument, dps},
 		{"nmic",  'm', "NUM", CFG_BYTE,        &cfg.nmic,  required_argument, nmic},
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -711,7 +711,7 @@ static void get_registers(struct nvme_bar **bar)
 		exit(ENODEV);
 	}
 
-	membase = mmap(0, getpagesize(), PROT_READ, MAP_SHARED, pci_fd, 0);
+	membase = mmap(NULL, getpagesize(), PROT_READ, MAP_SHARED, pci_fd, 0);
 	if (membase == MAP_FAILED) {
 		fprintf(stderr, "%s failed to map\n", base);
 		exit(ENODEV);
@@ -845,7 +845,7 @@ static int list(int argc, char **argv, struct command *cmd, struct plugin *plugi
 	return 0;
 }
 
-static int get_nsid()
+static int get_nsid(void)
 {
 	int nsid = nvme_get_nsid(fd);
 
@@ -888,7 +888,7 @@ int __id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin,
 		{"raw-binary",      'b', "", CFG_NONE, &cfg.raw_binary,      no_argument, raw_binary},
 		{"human-readable",  'H', "", CFG_NONE, &cfg.human_readable,  no_argument, human_readable},
 		{"output-format", 'o', "FMT", CFG_STRING, &cfg.output_format, required_argument, output_format },
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -963,7 +963,7 @@ static int id_ns(int argc, char **argv, struct command *cmd, struct plugin *plug
 		{"raw-binary",      'b', "FLAG", CFG_NONE,     &cfg.raw_binary,      no_argument,       raw_binary},
 		{"human-readable",  'H', "FLAG", CFG_NONE,     &cfg.human_readable,  no_argument,       human_readable},
 		{"output-format", 'o', "FMT", CFG_STRING, &cfg.output_format, required_argument, output_format },
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -1060,7 +1060,7 @@ static int get_feature(int argc, char **argv, struct command *cmd, struct plugin
 		{"raw-binary",     'b', "FLAG",CFG_NONE,     &cfg.raw_binary,     no_argument,       raw_binary},
 		{"cdw11",          'c', "NUM", CFG_POSITIVE, &cfg.cdw11,          required_argument, cdw11},
 		{"human-readable", 'H', "FLAG",CFG_NONE,     &cfg.human_readable, no_argument,       human_readable},
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -1154,7 +1154,7 @@ static int fw_download(int argc, char **argv, struct command *cmd, struct plugin
 		{"fw",     'f', "FILE", CFG_STRING,   &cfg.fw,     required_argument, fw},
 		{"xfer",   'x', "NUM",  CFG_POSITIVE, &cfg.xfer,   required_argument, xfer},
 		{"offset", 'o', "NUM",  CFG_POSITIVE, &cfg.offset, required_argument, offset},
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -1240,7 +1240,7 @@ static int fw_activate(int argc, char **argv, struct command *cmd, struct plugin
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"slot",   's', "NUM", CFG_BYTE, &cfg.slot,   required_argument, slot},
 		{"action", 'a', "NUM", CFG_BYTE, &cfg.action, required_argument, action},
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -1330,7 +1330,7 @@ static int show_registers(int argc, char **argv, struct command *cmd, struct plu
 
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"human-readable",  'H', "", CFG_NONE, &cfg.human_readable,  no_argument, human_readable},
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -1340,7 +1340,7 @@ static int show_registers(int argc, char **argv, struct command *cmd, struct plu
 	if (cfg.human_readable) {
 		printf("cap     : ");
 		print_lo_hi_64((uint32_t *)&bar->cap);
-		show_registers_cap(&bar->cap);
+		show_registers_cap((struct nvme_bar_cap *)&bar->cap);
 
 		printf("version : %x\n", bar->vs);
 		show_registers_version(bar->vs);
@@ -1450,7 +1450,7 @@ static int format(int argc, char **argv, struct command *cmd, struct plugin *plu
 		{"pil",          'p', "NUM",  CFG_BYTE,     &cfg.pil,          required_argument, pil},
 		{"ms",           'm', "NUM",  CFG_BYTE,     &cfg.ms,           required_argument, ms},
 		{"reset",        'r', "FLAG", CFG_NONE,     &cfg.reset,        no_argument,       reset},
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -1542,7 +1542,7 @@ static int set_feature(int argc, char **argv, struct command *cmd, struct plugin
 		{"data-len",     'l', "NUM",  CFG_POSITIVE, &cfg.data_len,     required_argument, data_len},
 		{"data",         'd', "FILE", CFG_STRING,   &cfg.file,         required_argument, data},
 		{"save",         's', "FLAG", CFG_NONE,     &cfg.save,         no_argument, save},
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -1640,7 +1640,7 @@ static int sec_send(int argc, char **argv, struct command *cmd, struct plugin *p
 		{"secp",         'p', "NUM",  CFG_BYTE,     &cfg.secp,         required_argument, secp},
 		{"spsp",         's', "NUM",  CFG_SHORT,    &cfg.spsp,         required_argument, spsp},
 		{"tl",           't', "NUM",  CFG_POSITIVE, &cfg.tl,           required_argument, tl},
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -1699,7 +1699,7 @@ static int write_uncor(int argc, char **argv, struct command *cmd, struct plugin
 		{"namespace-id",      'n', "NUM",  CFG_POSITIVE,    &cfg.namespace_id,      required_argument, namespace_id},
 		{"start-block",       's', "NUM",  CFG_LONG_SUFFIX, &cfg.start_block,       required_argument, start_block},
 		{"block-count",       'c', "NUM",  CFG_SHORT,       &cfg.block_count,       required_argument, block_count},
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -1766,7 +1766,7 @@ static int write_zeroes(int argc, char **argv, struct command *cmd, struct plugi
 		{"ref-tag",           'r', "NUM",  CFG_POSITIVE,    &cfg.ref_tag,           required_argument, ref_tag},
 		{"app-tag-mask",      'm', "NUM",  CFG_BYTE,        &cfg.app_tag_mask,      required_argument, app_tag_mask},
 		{"app-tag",           'a', "NUM",  CFG_POSITIVE,    &cfg.app_tag,           required_argument, app_tag},
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -1847,7 +1847,7 @@ static int dsm(int argc, char **argv, struct command *cmd, struct plugin *plugin
 		{"idw", 	 'w', "FLAG", CFG_NONE,      &cfg.idw,          no_argument,       idw},
 		{"idr", 	 'r', "FLAG", CFG_NONE,      &cfg.idr,          no_argument,       idr},
 		{"cdw11",        'c', "NUM",  CFG_POSITIVE,  &cfg.cdw11,        required_argument, cdw11},
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -1900,7 +1900,7 @@ static int flush(int argc, char **argv, struct command *cmd, struct plugin *plug
 
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"namespace-id", 'n', "NUM",  CFG_POSITIVE,    &cfg.namespace_id, required_argument, namespace_id},
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -1956,7 +1956,7 @@ static int resv_acquire(int argc, char **argv, struct command *cmd, struct plugi
 		{"rtype",        't', "NUM",  CFG_BYTE,        &cfg.rtype,        required_argument, rtype},
 		{"racqa",        'a', "NUM",  CFG_BYTE,        &cfg.racqa,        required_argument, racqa},
 		{"iekey",        'i', "",     CFG_NONE,        &cfg.iekey,        no_argument,       iekey},
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -2016,7 +2016,7 @@ static int resv_register(int argc, char **argv, struct command *cmd, struct plug
 		{"rrega",        'r', "NUM",  CFG_BYTE,        &cfg.rrega,        required_argument, rrega},
 		{"cptpl",        'p', "NUM",  CFG_BYTE,        &cfg.cptpl,        required_argument, cptpl},
 		{"iekey",        'i', "",     CFG_NONE,        &cfg.iekey,        no_argument,       iekey},
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -2078,7 +2078,7 @@ static int resv_release(int argc, char **argv, struct command *cmd, struct plugi
 		{"rtype",        't', "NUM",  CFG_BYTE,        &cfg.rtype,        required_argument, rtype},
 		{"rrela",        'a', "NUM",  CFG_BYTE,        &cfg.rrela,        required_argument, rrela},
 		{"iekey",        'i', "NUM",  CFG_BYTE,        &cfg.iekey,        required_argument, iekey},
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -2137,7 +2137,7 @@ static int resv_report(int argc, char **argv, struct command *cmd, struct plugin
 		{"numd",         'd', "NUM",  CFG_POSITIVE, &cfg.numd,         required_argument, numd},
 		{"raw-binary",   'b', "",     CFG_NONE,     &cfg.raw_binary,   no_argument,       raw_binary},
 		{"output-format", 'o', "FMT", CFG_STRING, &cfg.output_format, required_argument, output_format },
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -2252,7 +2252,7 @@ static int submit_io(int opcode, char *command, const char *desc,
 		{"show-command",      'v', "",     CFG_NONE,        &cfg.show,              no_argument,       show},
 		{"dry-run",           'w', "",     CFG_NONE,        &cfg.dry_run,           no_argument,       dry},
 		{"latency",           't', "",     CFG_NONE,        &cfg.latency,           no_argument,       latency},
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -2437,7 +2437,7 @@ static int sec_recv(int argc, char **argv, struct command *cmd, struct plugin *p
 		{"spsp",         's', "NUM",  CFG_SHORT,    &cfg.spsp,         required_argument, spsp},
 		{"al",           't', "NUM",  CFG_POSITIVE, &cfg.al,           required_argument, al},
 		{"raw-binary",   'b', "",     CFG_NONE,     &cfg.raw_binary,   no_argument,       raw_binary},
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
@@ -2565,7 +2565,7 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 		{"dry-run",      'd', "",     CFG_NONE,     &cfg.dry_run,      no_argument,       dry},
 		{"read",         'r', "",     CFG_NONE,     &cfg.read,         no_argument,       re},
 		{"write",        'w', "",     CFG_NONE,     &cfg.write,        no_argument,       wr},
-		{0}
+		{NULL}
 	};
 
 	parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-- 
2.1.4
