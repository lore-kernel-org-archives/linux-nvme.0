Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E85BC433C1
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 15:59:55 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E4B60241
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 15:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E4B60241
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ep4nWQlDJKXqZUr45WJa6PV6trSXncfK/d/z3YkDBkc=; b=lH7oOBze9MkCxwaA2DKuNy5Lz
	w/Pezmg/jhJBnydoZi6jg/N+rs89Z2EE82WU/jnD+vXaDh6E+ycUj1e2r0XnHTPGV0cVXBz0zM0RZ
	+biDTjCrALV3brrFt+mwpXERt3IFF403xVnk6ODaaJ89/hiqUwVRP2wkeA5HREgk/47tKhiome4H/
	0LIViUu6Ar6PVp6f1TMLDTRKF/izrAqvCQyFXDGypn1Uxe8IY9AvdiNOMQncDRe1r9AMEBpEon3Hg
	VjS51+kBnC/xVk+hRDPXTS/eKZvX2KgxjVnDXNPj1Z1VOnAR1bjaN8+p9nqhZdYMJ1MA3yB6yGDd1
	HAzi1fHVQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRGmQ-004HZB-IW; Tue, 30 Mar 2021 15:59:46 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRGln-004HSQ-US
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 15:59:09 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1617119942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5gfS+imYrLgxEq/JwP0ixEKn9uZY+xHavmpo4I/kXCU=;
 b=J3OwS4La8PTOHxlmYSPICrseSaRvTTgaMtM5NhWk4bCIKZI8zZVuKcduDt07ckWp16k4GO
 Op7BtmjTP4LE2Zu+D8PVdOdzfJEjGdmN2r0f9ID+ce10tnWPIDj5/xRQn2k0kbgQ6R1R2u
 rPuTyPrnHmmVolW6KhVz89yxu0ANjEQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 7EED3B1D5;
 Tue, 30 Mar 2021 15:59:02 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH v2 6/9] nvme: convert some function arguments from "char *" to
 "const char *"
Date: Tue, 30 Mar 2021 17:57:08 +0200
Message-Id: <20210330155711.8436-7-mwilck@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210330155711.8436-1-mwilck@suse.com>
References: <20210330155711.8436-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210330_165908_208680_9D1ED9BC 
X-CRM114-Status: GOOD (  13.65  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Martin Wilck <mwilck@suse.com>

Make some function arguments "const char *" where possible. This
is generally desirable and allows passing string constants to these
function.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 fabrics.c       | 25 +++++++++++++++----------
 nvme-topology.c |  2 +-
 nvme.c          |  2 +-
 nvme.h          |  4 ++--
 4 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 1aa1507..4a5c2f9 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -234,7 +234,7 @@ static int do_discover(char *argstr, bool connect, enum nvme_print_flags flags);
  * If field found, return string containing field value. If field
  * not found, return an empty string.
  */
-static char *parse_conn_arg(char *conargs, const char delim, const char *field)
+static char *parse_conn_arg(const char *conargs, const char delim, const char *field)
 {
 	char *s, *e;
 	size_t cnt;
@@ -278,17 +278,22 @@ empty_field:
 	return strdup("\0");
 }
 
-static int ctrl_instance(char *device)
+static int ctrl_instance(const char *device)
 {
 	char d[64];
+	const char *p;
 	int ret, instance;
 
-	device = basename(device);
-	ret = sscanf(device, "nvme%d", &instance);
+	p = strrchr(device, '/');
+	if (p == NULL)
+		p = device;
+	else
+		p++;
+	ret = sscanf(p, "nvme%d", &instance);
 	if (ret <= 0)
 		return -EINVAL;
 	if (snprintf(d, sizeof(d), "nvme%d", instance) <= 0 ||
-	    strcmp(device, d))
+	    strcmp(p, d))
 		return -EINVAL;
 	return instance;
 }
@@ -299,7 +304,7 @@ static int ctrl_instance(char *device)
  * given.
  * Return true/false based on whether it matches
  */
-static bool ctrl_matches_connectargs(char *name, struct connect_args *args)
+static bool ctrl_matches_connectargs(const char *name, struct connect_args *args)
 {
 	struct connect_args cargs;
 	bool found = false;
@@ -924,7 +929,7 @@ add_int_argument(char **argstr, int *max_len, char *arg_str, int arg,
 }
 
 static int
-add_argument(char **argstr, int *max_len, char *arg_str, char *arg)
+add_argument(char **argstr, int *max_len, char *arg_str, const char *arg)
 {
 	int len;
 
@@ -1675,7 +1680,7 @@ static int scan_sys_nvme_filter(const struct dirent *d)
 /*
  * Returns 1 if disconnect occurred, 0 otherwise.
  */
-static int disconnect_subsys(char *nqn, char *ctrl)
+static int disconnect_subsys(const char *nqn, char *ctrl)
 {
 	char *sysfs_nqn_path = NULL, *sysfs_del_path = NULL;
 	char subsysnqn[NVMF_NQN_SIZE] = {};
@@ -1713,7 +1718,7 @@ static int disconnect_subsys(char *nqn, char *ctrl)
 /*
  * Returns the number of controllers successfully disconnected.
  */
-static int disconnect_by_nqn(char *nqn)
+static int disconnect_by_nqn(const char *nqn)
 {
 	struct dirent **devices = NULL;
 	int i, n, ret = 0;
@@ -1735,7 +1740,7 @@ static int disconnect_by_nqn(char *nqn)
 	return ret;
 }
 
-static int disconnect_by_device(char *device)
+static int disconnect_by_device(const char *device)
 {
 	int instance;
 
diff --git a/nvme-topology.c b/nvme-topology.c
index 63e433d..c2c9b38 100644
--- a/nvme-topology.c
+++ b/nvme-topology.c
@@ -46,7 +46,7 @@ close_fd:
 	return subsysnqn;
 }
 
-char *nvme_get_ctrl_attr(char *path, const char *attr)
+char *nvme_get_ctrl_attr(const char *path, const char *attr)
 {
 	char *attrpath, *value;
 	ssize_t ret;
diff --git a/nvme.c b/nvme.c
index 8751ffd..bf18366 100644
--- a/nvme.c
+++ b/nvme.c
@@ -209,7 +209,7 @@ int parse_and_open(int argc, char **argv, const char *desc,
 	return ret;
 }
 
-enum nvme_print_flags validate_output_format(char *format)
+enum nvme_print_flags validate_output_format(const char *format)
 {
 	if (!format)
 		return -EINVAL;
diff --git a/nvme.h b/nvme.h
index 8501754..1293d4d 100644
--- a/nvme.h
+++ b/nvme.h
@@ -91,7 +91,7 @@ int parse_and_open(int argc, char **argv, const char *desc,
 extern const char *devicename;
 extern const char *output_format;
 
-enum nvme_print_flags validate_output_format(char *format);
+enum nvme_print_flags validate_output_format(const char *format);
 int __id_ctrl(int argc, char **argv, struct command *cmd,
 	struct plugin *plugin, void (*vs)(__u8 *vs, struct json_object *root));
 char *nvme_char_from_block(char *block);
@@ -109,7 +109,7 @@ int scan_subsystems(struct nvme_topology *t, const char *subsysnqn,
 		    __u32 ns_instance, int nsid, char *dev_dir);
 void free_topology(struct nvme_topology *t);
 char *get_nvme_subsnqn(char *path);
-char *nvme_get_ctrl_attr(char *path, const char *attr);
+char *nvme_get_ctrl_attr(const char *path, const char *attr);
 
 void *nvme_alloc(size_t len, bool *huge);
 void nvme_free(void *p, bool huge);
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
