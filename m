Return-Path: <SRS0=LlAf=2K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE9FC43603
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2019 03:32:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBCF524680
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2019 03:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ieT+huGD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCNEdejA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBCF524680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GRSJJ9vdCZ+AELxwlSQFLAeqTRQHb+ytJWVJy4zeTwU=; b=ieT+huGDC6ClSR
	7SWecyUh+bQtMwBAwGownkRolXG9deBW0klK7gxVSNGYuWSP/ZUet/ivyHmWILJceYLv+kAWA8/vQ
	gYFkbvMuHYLK5xpCZNRBwDsjIFxk8ghE8d5WpWKPr/T8BnbZn/Ur9o2mk7bYrAZfJSQRiKp/6WVP3
	rXCFAGB43bcIzPUkhYo5DRNina1y2aqFj86v+UhjbYsMrTAIWVkIg599WXiOumeRZC4LlTHGGEls9
	F3b+brXVTl+SjoE3sCVgKRF4zyDKzWgffCgFSU1KlbigSPd9I7L2WuQGIIr88ZpeLsvw2pHoQkgfY
	VZqvlUYbcMAiZCR+LFcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ii91K-00073W-NZ; Fri, 20 Dec 2019 03:32:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ii90e-0006Ve-Qs
 for linux-nvme@lists.infradead.org; Fri, 20 Dec 2019 03:31:27 +0000
Received: from localhost (36-236-5-169.dynamic-ip.hinet.net [36.236.5.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BDE5724686;
 Fri, 20 Dec 2019 03:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576812683;
 bh=GzNlEg/VMjtsfUE0iAU4YQ72cJITvXFAeerZrn5IQj8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QCNEdejA00VNQjB5kobCW5987m9HzN6rQHS0T+V3nymhJU/A+Bxd/ghOnuUUnnyjL
 rkEJH4QjCUY6cfO+PKKgkPpR1wCoQ5YjnfNZvPt7HcCfFa2Og7G0mXidUNjoUvo4QS
 z9lWmWiv599eh8MwJtltnf31rCoUx4xhiP4tZ/s4=
From: Andy Lutomirski <luto@kernel.org>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 3/4] Use systemd-generated hostid if no hostid is configured
Date: Thu, 19 Dec 2019 19:31:04 -0800
Message-Id: <b4feb87b30edfb30998a2b42de3b1e0618203700.1576726427.git.luto@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1576726427.git.luto@kernel.org>
References: <cover.1576726427.git.luto@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191219_193125_077053_C286FBEC 
X-CRM114-Status: GOOD (  15.91  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is just like the hostnqn support.  It adds a show-hostid command
for introspection.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 Documentation/nvme-show-hostid.txt | 29 +++++++++++++++
 fabrics.c                          | 57 ++++++++++++++++++++++++++----
 fabrics.h                          |  1 +
 nvme-builtin.h                     |  1 +
 nvme.c                             | 15 ++++++++
 5 files changed, 96 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/nvme-show-hostid.txt

diff --git a/Documentation/nvme-show-hostid.txt b/Documentation/nvme-show-hostid.txt
new file mode 100644
index 000000000000..52bdc8a1f480
--- /dev/null
+++ b/Documentation/nvme-show-hostid.txt
@@ -0,0 +1,29 @@
+nvme-show-hostid(1)
+===================
+
+NAME
+----
+nvme-show-hostid - Generate a host NVMe ID
+
+SYNOPSIS
+--------
+[verse]
+'nvme show-hostid'
+
+DESCRIPTION
+-----------
+Show the host ID configured for the system.  If /etc/nvme/hostid is
+not present and systemd application-specific machine IDs are available,
+this will show the systemd-generated host ID for the system.
+
+OPTIONS
+-------
+No options needed
+
+EXAMPLES
+--------
+nvme show-hostid
+
+NVME
+----
+Part of the nvme-user suite
diff --git a/fabrics.c b/fabrics.c
index 4448416f9855..7c5b7efd5270 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -46,6 +46,7 @@
 #ifdef HAVE_SYSTEMD
 #include <systemd/sd-id128.h>
 #define NVME_HOSTNQN_ID SD_ID128_MAKE(c7,f4,61,81,12,be,49,32,8c,83,10,6f,9d,dd,d8,6b)
+#define NVME_HOSTID_ID SD_ID128_MAKE(df,66,bf,ec,f7,e4,21,0e,46,27,ac,a8,f2,8f,3b,98)
 #endif
 
 #define NVMF_HOSTID_SIZE	36
@@ -728,11 +729,11 @@ static int nvmf_hostnqn_load(void)
 	return cfg.hostnqn != NULL;
 }
 
-static int nvmf_hostid_file(void)
+static char *hostid_read_file(void)
 {
 	FILE *f;
 	char hostid[NVMF_HOSTID_SIZE + 1];
-	int ret = false;
+	char *ret = NULL;
 
 	f = fopen(PATH_NVMF_HOSTID, "r");
 	if (f == NULL)
@@ -741,16 +742,58 @@ static int nvmf_hostid_file(void)
 	if (fgets(hostid, sizeof(hostid), f) == NULL)
 		goto out;
 
-	cfg.hostid = strdup(hostid);
-	if (!cfg.hostid)
-		goto out;
+	ret = strdup(hostid);
+
 
-	ret = true;
 out:
 	fclose(f);
 	return ret;
 }
 
+static char *hostid_generate_systemd(void)
+{
+#if defined(LIBUUID) && defined(HAVE_SYSTEMD)
+	sd_id128_t id;
+	char uuidstr[37];
+	char *ret;
+
+	if (sd_id128_get_machine_app_specific(NVME_HOSTID_ID, &id) < 0)
+		return NULL;
+
+	uuid_unparse_lower(id.bytes, uuidstr);
+
+	if (asprintf(&ret, "%s\n", uuidstr) == -1)
+		ret = NULL;
+
+	return ret;
+#else
+	return NULL;
+#endif
+}
+
+/* returns an allocated string or NULL */
+char *hostid_read(void)
+{
+	char *ret;
+
+	ret = hostid_read_file();
+	if (ret)
+		return ret;
+
+	ret = hostid_generate_systemd();
+	if (ret)
+		return ret;
+
+	return NULL;
+}
+
+static int nvmf_hostid_load(void)
+{
+	cfg.hostid = hostid_read();
+
+	return cfg.hostid != NULL;
+}
+
 static int
 add_bool_argument(char **argstr, int *max_len, char *arg_str, bool arg)
 {
@@ -829,7 +872,7 @@ static int build_options(char *argstr, int max_len, bool discover)
 	    add_argument(&argstr, &max_len, "trsvcid", cfg.trsvcid) ||
 	    ((cfg.hostnqn || nvmf_hostnqn_load()) &&
 		    add_argument(&argstr, &max_len, "hostnqn", cfg.hostnqn)) ||
-	    ((cfg.hostid || nvmf_hostid_file()) &&
+	    ((cfg.hostid || nvmf_hostid_load()) &&
 		    add_argument(&argstr, &max_len, "hostid", cfg.hostid)) ||
 	    (!discover &&
 	      add_int_argument(&argstr, &max_len, "nr_io_queues",
diff --git a/fabrics.h b/fabrics.h
index b8e53f492b53..64aede897535 100644
--- a/fabrics.h
+++ b/fabrics.h
@@ -4,6 +4,7 @@
 #define NVMF_DEF_DISC_TMO	30
 
 extern char *hostnqn_read(void);
+extern char *hostid_read(void);
 
 extern int discover(const char *desc, int argc, char **argv, bool connect);
 extern int connect(const char *desc, int argc, char **argv);
diff --git a/nvme-builtin.h b/nvme-builtin.h
index bfb907dff9ef..907d470cbeac 100644
--- a/nvme-builtin.h
+++ b/nvme-builtin.h
@@ -71,6 +71,7 @@ COMMAND_LIST(
 	ENTRY("disconnect-all", "Disconnect from all connected NVMeoF subsystems", disconnect_all_cmd)
 	ENTRY("gen-hostnqn", "Generate NVMeoF host NQN", gen_hostnqn_cmd)
 	ENTRY("show-hostnqn", "Show NVMeoF host NQN", show_hostnqn_cmd)
+	ENTRY("show-hostid", "Show NVMeoF host ID", show_hostid_cmd)
 	ENTRY("dir-receive", "Submit a Directive Receive command, return results", dir_receive)
 	ENTRY("dir-send", "Submit a Directive Send command, return results", dir_send)
 	ENTRY("virt-mgmt", "Manage Flexible Resources between Primary and Secondary Controller ", virtual_mgmt)
diff --git a/nvme.c b/nvme.c
index 0c23eee8a477..d81f8226b84d 100644
--- a/nvme.c
+++ b/nvme.c
@@ -4771,6 +4771,21 @@ static int show_hostnqn_cmd(int argc, char **argv, struct command *command, stru
 	}
 }
 
+static int show_hostid_cmd(int argc, char **argv, struct command *command, struct plugin *plugin)
+{
+	char *hostid;
+
+	hostid = hostid_read();
+	if (hostid) {
+		fputs(hostid, stdout);
+		free(hostid);
+		return 0;
+	} else {
+		fprintf(stderr, "hostid is not available -- generate /etc/nvme/hostid\n");
+		return -ENOENT;
+	}
+}
+
 static int discover_cmd(int argc, char **argv, struct command *command, struct plugin *plugin)
 {
 	const char *desc = "Send Get Log Page request to Discovery Controller.";
-- 
2.23.0


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
