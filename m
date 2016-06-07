From: hch@lst.de (Christoph Hellwig)
Date: Tue,  7 Jun 2016 17:19:23 +0200
Subject: [PATCH 07/11] Implement discover command
In-Reply-To: <1465312767-10070-1-git-send-email-hch@lst.de>
References: <1465312767-10070-1-git-send-email-hch@lst.de>
Message-ID: <1465312767-10070-8-git-send-email-hch@lst.de>

From: Ming Lin <ming.l@ssi.samsung.com>

Example output:

root at host:~# nvme discover -t rdma -a 192.168.2.2 -p 1023
Discovery Log Number of Records 1, Generation counter 3
=====Discovery Log Entry 0======
trtype:  1
adrfam:  1
nqntype: 2
treq:    0
portid:  1
trsvcid: 1023

subnqn:  nqn.testiqn
traddr:  192.168.2.2

rdma_prtype: 0
rdma_qptype: 0
rdma_cms:    0
rdma_pkey: 0x0000

Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
Tested-by: Armen Baloyan <armenx.baloyan at intel.com>
Tested-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Jay Freyensee <james.p.freyensee at intel.com>
---
 Makefile  |   6 +-
 fabrics.c | 393 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fabrics.h |   6 +
 nvme.c    |   8 ++
 4 files changed, 412 insertions(+), 1 deletion(-)
 create mode 100644 fabrics.c
 create mode 100644 fabrics.h

diff --git a/Makefile b/Makefile
index c125756..e43c65d 100644
--- a/Makefile
+++ b/Makefile
@@ -31,7 +31,8 @@ override CFLAGS += -DNVME_VERSION='"$(NVME_VERSION)"'
 
 NVME_DPKG_VERSION=1~`lsb_release -sc`
 
-OBJS := argconfig.o suffix.o parser.o nvme-print.o nvme-ioctl.o nvme-lightnvm.o
+OBJS := argconfig.o suffix.o parser.o nvme-print.o nvme-ioctl.o \
+	nvme-lightnvm.o fabrics.o
 
 nvme: nvme.c ./linux/nvme.h $(OBJS) NVME-VERSION-FILE
 	$(CC) $(CPPFLAGS) $(CFLAGS) nvme.c $(LDFLAGS) -o $(NVME) $(OBJS)
@@ -39,6 +40,9 @@ nvme: nvme.c ./linux/nvme.h $(OBJS) NVME-VERSION-FILE
 nvme-ioctl.o: nvme-ioctl.c nvme-ioctl.h
 	$(CC) $(CPPFLAGS) $(CFLAGS) -c nvme-ioctl.c
 
+fabrics.o: fabrics.c
+	$(CC) $(CPPFLAGS) $(CFLAGS) -c fabrics.c
+
 parser.o: parser.c
 	$(CC) $(CPPFLAGS) $(CFLAGS) -c parser.c
 
diff --git a/fabrics.c b/fabrics.c
new file mode 100644
index 0000000..ad79017
--- /dev/null
+++ b/fabrics.c
@@ -0,0 +1,393 @@
+/*
+ * Copyright (C) 2016 Intel Corporation. All rights reserved.
+ * Copyright (c) 2016 HGST, a Western Digital Company.
+ * Copyright (c) 2016 Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This file implements the discovery controller feature of NVMe over
+ * Fabrics specification standard.
+ */
+
+#include <errno.h>
+#include <getopt.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <libudev.h>
+
+#include <linux/types.h>
+
+#include "parser.h"
+#include "nvme-ioctl.h"
+#include "fabrics.h"
+
+#include "linux/nvme.h"
+#include "src/argconfig.h"
+
+#include "common.h"
+
+struct config {
+	char *nqn;
+	char *transport;
+	char *traddr;
+	char *trsvcid;
+} cfg = { 0 };
+
+#define BUF_SIZE		4096
+#define PATH_NVME_FABRICS	"/dev/nvme-fabrics"
+
+enum {
+	OPT_INSTANCE,
+	OPT_CNTLID,
+	OPT_ERR
+};
+
+static const match_table_t opt_tokens = {
+	{ OPT_INSTANCE,		"instance=%d"	},
+	{ OPT_CNTLID,		"cntlid=%d"	},
+	{ OPT_ERR,		NULL		},
+};
+
+static int add_ctrl(const char *argstr)
+{
+	substring_t args[MAX_OPT_ARGS];
+	char buf[BUF_SIZE], *options, *p;
+	size_t len = strlen(argstr);
+	int token, ret, fd;
+
+	fd = open(PATH_NVME_FABRICS, O_RDWR);
+	if (fd < 0) {
+		fprintf(stderr, "Failed to open %s: %s\n",
+			 PATH_NVME_FABRICS, strerror(errno));
+		ret = -errno;
+		goto out;
+	}
+
+	if (write(fd, argstr, len) != len) {
+		fprintf(stderr, "Failed to write to %s: %s\n",
+			 PATH_NVME_FABRICS, strerror(errno));
+		ret = -errno;
+		goto out_close;
+	}
+
+	len = read(fd, buf, BUF_SIZE);
+	if (len < 0) {
+		fprintf(stderr, "Failed to read from %s: %s\n",
+			 PATH_NVME_FABRICS, strerror(errno));
+		ret = -errno;
+		goto out_close;
+	}
+
+	buf[len] = '\0';
+	options = buf;
+	while ((p = strsep(&options, ",\n")) != NULL) {
+		if (!*p)
+			continue;
+
+		token = match_token(p, opt_tokens, args);
+		switch (token) {
+		case OPT_INSTANCE:
+			if (match_int(args, &token))
+				goto out_fail;
+			ret = token;
+			goto out_close;
+		default:
+			/* ignore */
+			break;
+		}
+	}
+
+out_fail:
+	fprintf(stderr, "Failed to parse ctrl info for \"%s\"\n", argstr);
+	ret = -EINVAL;
+out_close:
+	close(fd);
+out:
+	return ret;
+}
+
+static int remove_ctrl_by_path(char *sysfs_path)
+{
+	int ret, fd;
+
+	fd = open(sysfs_path, O_WRONLY);
+	if (fd < 0) {
+		ret = errno;
+		goto out;
+	}
+
+	if (write(fd, "1", 1) != 1) {
+		ret = errno;
+		goto out_close;
+	}
+
+	ret = 0;
+out_close:
+	close(fd);
+out:
+	return ret;
+}
+
+static int remove_ctrl(int instance)
+{
+	char *sysfs_path;
+	int ret;
+
+	if (asprintf(&sysfs_path, "/sys/class/nvme/nvme%d/delete_controller",
+			instance) < 0) {
+		ret = errno;
+		goto out;
+	}
+
+	ret = remove_ctrl_by_path(sysfs_path);
+	free(sysfs_path);
+out:
+	return ret;
+}
+
+enum {
+	DISC_OK,
+	DISC_NO_LOG,
+	DISC_GET_NUMRECS,
+	DISC_GET_LOG,
+	DISC_NOT_EQUAL,
+};
+
+static int nvmf_get_log_page_discovery(const char *dev_path,
+		struct nvmf_disc_rsp_page_hdr **logp, int *numrec)
+{
+	struct nvmf_disc_rsp_page_hdr *log;
+	unsigned log_size = 0;
+	unsigned long genctr;
+	int error, fd;
+
+	fd = open(dev_path, O_RDWR);
+	if (fd < 0) {
+		error = -errno;
+		goto out;
+	}
+
+	/* first get_log_page we just need numrec entry from discovery hdr.
+	 * host supplies its desired bytes via dwords, per NVMe spec.
+	 */
+	log_size = round_up((offsetof(struct nvmf_disc_rsp_page_hdr, numrec) +
+			    sizeof(log->numrec)), sizeof(__u32));
+
+	/*
+	 * Issue first get log page w/numdl small enough to retrieve numrec.
+	 * We just want to know how many records to retrieve.
+	 */
+	log = calloc(1, log_size);
+	if (!log) {
+		error = -ENOMEM;
+		goto out_close;
+	}
+
+	error = nvme_discovery_log(fd, log, log_size);
+	if (error) {
+		error = DISC_GET_NUMRECS;
+		goto out_free_log;
+	}
+
+	/* check numrec limits */
+	*numrec = le64toh(log->numrec);
+	genctr = le64toh(log->genctr);
+	free(log);
+
+	if (*numrec == 0) {
+		error = DISC_NO_LOG;
+		goto out_close;
+	}
+
+	/* we are actually retrieving the entire discovery tables
+	 * for the second get_log_page(), per
+	 * NVMe spec so no need to round_up(), or there is something
+	 * seriously wrong with the standard
+	 */
+	log_size = sizeof(struct nvmf_disc_rsp_page_hdr) +
+			sizeof(struct nvmf_disc_rsp_page_entry) * *numrec;
+
+	/* allocate discovery log pages based on page_hdr->numrec */
+	log = calloc(1, log_size);
+	if (!log) {
+		error = -ENOMEM;
+		goto out_close;
+	}
+
+	/*
+	 * issue new get_log_page w/numdl+numdh set to get all records,
+	 * up to MAX_DISC_LOGS.
+	 */
+	error = nvme_discovery_log(fd, log, log_size);
+	if (error) {
+		error = DISC_GET_LOG;
+		goto out_free_log;
+	}
+
+	if (*numrec != le32toh(log->numrec) || genctr != le64toh(log->genctr)) {
+		error = DISC_NOT_EQUAL;
+		goto out_free_log;
+	}
+
+	/* needs to be freed by the caller */
+	*logp = log;
+	goto out_close;
+
+	error = DISC_OK;
+out_free_log:
+	free(log);
+out_close:
+	close(fd);
+out:
+	return error;
+}
+
+static void print_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec)
+{
+	int i;
+
+	printf("Discovery Log Number of Records %d, Generation counter %lld\n",
+		numrec, log->genctr);
+
+	for (i = 0; i < numrec; i++) {
+		struct nvmf_disc_rsp_page_entry *e = &log->entries[i];
+
+		printf("=====Discovery Log Entry %d======\n", i);
+		printf("trtype:  %d\n", e->trtype);
+		printf("adrfam:  %d\n", e->adrfam);
+		printf("nqntype: %d\n", e->nqntype);
+		printf("treq:    %d\n", e->treq);
+		printf("portid:  %d\n", e->portid);
+		printf("trsvcid: %s\n", e->trsvcid);
+		printf("subnqn:  %s\n", e->subnqn);
+		printf("traddr:  %s\n", e->traddr);
+
+		switch (e->trtype) {
+		case NVMF_TRTYPE_RDMA:
+			printf("rdma_prtype: %d\n", e->tsas.rdma.prtype);
+			printf("rdma_qptype: %d\n", e->tsas.rdma.qptype);
+			printf("rdma_cms:    %d\n", e->tsas.rdma.cms);
+			printf("rdma_pkey: 0x%04x\n", e->tsas.rdma.pkey);
+			break;
+		}
+	}
+}
+
+static int build_options(char *argstr, int max_len)
+{
+	int len;
+
+	if (!cfg.transport) {
+		fprintf(stderr, "need a transport (-t) argument\n");
+		return -EINVAL;
+	}
+
+	if (strncmp(cfg.transport, "loop", 4)) {
+		if (!cfg.traddr) {
+			fprintf(stderr, "need a address (-a) argument\n");
+			return -EINVAL;
+		}
+	}
+
+	len = snprintf(argstr, max_len, "nqn=%s", cfg.nqn);
+	if (len < 0)
+		return -EINVAL;
+	argstr += len;
+	max_len -= len;
+
+	len = snprintf(argstr, max_len, ",transport=%s", cfg.transport);
+	if (len < 0)
+		return -EINVAL;
+	argstr += len;
+	max_len -= len;
+
+	if (cfg.traddr) {
+		len = snprintf(argstr, max_len, ",traddr=%s", cfg.traddr);
+		if (len < 0)
+			return -EINVAL;
+		argstr += len;
+		max_len -= len;
+	}
+
+	if (cfg.trsvcid) {
+		len = snprintf(argstr, max_len, ",trsvcid=%s", cfg.trsvcid);
+		if (len < 0)
+			return -EINVAL;
+		argstr += len;
+		max_len -= len;
+	}
+
+	return 0;
+}
+
+int discover(const char *desc, int argc, char **argv)
+{
+	char argstr[BUF_SIZE];
+	struct nvmf_disc_rsp_page_hdr *log = NULL;
+	char *dev_name;
+	int instance, numrec = 0, ret;
+	const struct argconfig_commandline_options command_line_options[] = {
+		{"transport", 't', "LIST", CFG_STRING, &cfg.transport, required_argument,
+			"transport type" },
+		{"traddr", 'a', "LIST", CFG_STRING, &cfg.traddr, required_argument,
+			"transport address" },
+		{"trsvcid", 's', "LIST", CFG_STRING, &cfg.trsvcid, required_argument,
+			"transport service id (e.g. IP port)" },
+		{0},
+	};
+
+	argconfig_parse(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
+
+	cfg.nqn = NVME_DISC_SUBSYS_NAME;
+
+	ret = build_options(argstr, BUF_SIZE);
+	if (ret)
+		return ret;
+
+	instance = add_ctrl(argstr);
+	if (instance < 0)
+		return instance;
+
+	if (asprintf(&dev_name, "/dev/nvme%d", instance) < 0)
+		return errno;
+	ret = nvmf_get_log_page_discovery(dev_name, &log, &numrec);
+	free(dev_name);
+	remove_ctrl(instance);
+
+	switch (ret) {
+	case DISC_OK:
+		print_discovery_log(log, numrec);
+		break;
+	case DISC_GET_NUMRECS:
+		fprintf(stderr, "Get number of discovery log entries failed.\n");
+		break;
+	case DISC_GET_LOG:
+		fprintf(stderr, "Get discovery log entries failed.\n");
+		break;
+	case DISC_NO_LOG:
+		fprintf(stderr, "No discovery log entries to fetch.\n");
+		break;
+	case DISC_NOT_EQUAL:
+		fprintf(stderr, "Numrec values of last two get dicovery log page not equal\n");
+		break;
+	default:
+		fprintf(stderr, "Get dicovery log page failed: %d\n", ret);
+		break;
+	}
+
+	return ret;
+}
diff --git a/fabrics.h b/fabrics.h
new file mode 100644
index 0000000..c80b016
--- /dev/null
+++ b/fabrics.h
@@ -0,0 +1,6 @@
+#ifndef _DISCOVER_H
+#define _DISCOVER_H
+
+extern int discover(const char *desc, int argc, char **argv);
+
+#endif
diff --git a/nvme.c b/nvme.c
index 72a85a4..2dd2f3a 100644
--- a/nvme.c
+++ b/nvme.c
@@ -54,6 +54,8 @@
 #include "src/argconfig.h"
 #include "src/suffix.h"
 
+#include "fabrics.h"
+
 #define array_len(x) ((size_t)(sizeof(x) / sizeof(x[0])))
 #define min(x, y) (x) > (y) ? (y) : (x)
 #define max(x, y) (x) > (y) ? (x) : (y)
@@ -112,6 +114,7 @@ static const char nvme_version_string[] = NVME_VERSION;
 	ENTRY(LNVM_FACTORY, "lnvm-factory", "Reset device to factory state", lnvm_factory_init) \
 	ENTRY(LNVM_BBTBL_GET, "lnvm-diag-bbtbl", "Diagnose bad block table", lnvm_get_bbtbl) \
 	ENTRY(LNVM_BBTBL_SET, "lnvm-diag-set-bbtbl", "Update bad block table", lnvm_set_bbtbl) \
+	ENTRY(DISCOVER, "discover", "Discover NVMeoF subsystems", discover_cmd) \
 	ENTRY(VERSION, "version", "Shows the program version", version) \
 	ENTRY(HELP, "help", "Display this help", help)
 
@@ -2837,6 +2840,11 @@ static int lnvm_set_bbtbl(int argc, char **argv)
 				 cfg.value);
 }
 
+static int discover_cmd(int argc, char **argv)
+{
+	const char *desc = "Send command to discovery service.";
+	return discover(desc, argc, argv);
+}
 
 static void usage()
 {
-- 
2.1.4
