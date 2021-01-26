Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B14CC433E6
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:35:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1F9A221FC
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F9A221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YgfEoNBAFdKHcIGZZAcR4u09lEehi36q+LzucolLbck=; b=anQEB47ylEX3exsJ4TvhEUepX
	jUmok2q+aijiiDYL/3XZJwYf6QJHdYWyKQ5KdiMDQ8+SwRvWoDlt6aTZkBM602agYNInnGrlmnw46
	f2xGbHszTFu35OjRE5f09p9qOP8kXIH5xPU7apNyClgre0WH6O7ViIQeE45+TbNcLSQqE8Lz6TgYY
	fixpFe3CYESPaf7FMFtlJ7ZmTiV4gBhMdsFjzrpICf9YPqetLBXN1MQX05WXMLPDojZrmVTPQKV9e
	+fCnrxXwY9iZAgQYX8UfQWF31hg3lRDEA0rPVklN6U2nqfprEWW/EqQWcQabJVeNHD3Y/O5SUSCq3
	/N5yKs3qg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V3h-0001hB-8r; Tue, 26 Jan 2021 20:35:29 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V29-0000zC-JE
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:34:01 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nkjN005NtMsT6WM7eZNX8WRG6FJYNw8Qqy53wks8vfM=;
 b=mhUMu/AKb+enDINR/GI8g1ts8CD+npPj6GA6iNcpxdRsoPlbuY/B99LLnGqf09z7jQqvp9
 GzVkPvIuYolhqZkbjYlCKzaR1D4Edmlw5sfuvA3lOcxvrOnn4sBfvlgLCWOe+tTU7fQbgH
 +WciQgEW0SvXWXWcyXgfrSpwObpO4AA=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id ECF77B05C;
 Tue, 26 Jan 2021 20:33:47 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 19/35] fabrics: use "const char *" in struct config
Date: Tue, 26 Jan 2021 21:33:08 +0100
Message-Id: <20210126203324.23610-20-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153353_892930_B5311174 
X-CRM114-Status: GOOD (  15.31  )
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
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Martin Wilck <mwilck@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Martin Wilck <mwilck@suse.com>

This is easily done, and allows passing in some const char* pointers
that would otherwise need to be strdup()d first.

constifying cfg->device requires changes in the ctrl_instance()
function, because basename() can't be used.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 fabrics.c | 23 ++++++++++++++---------
 fabrics.h | 17 +++++++++--------
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index c1a4bb5..e3d2a3a 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -252,17 +252,22 @@ empty_field:
 	return strdup("\0");
 }
 
-static int ctrl_instance(char *device)
+int ctrl_instance(const char *device)
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
@@ -273,7 +278,7 @@ static int ctrl_instance(char *device)
  * given.
  * Return true/false based on whether it matches
  */
-static bool ctrl_matches_connectargs(char *name, struct connect_args *args)
+static bool ctrl_matches_connectargs(const char *name, struct connect_args *args)
 {
 	struct connect_args cargs;
 	bool found = false;
@@ -815,7 +820,7 @@ add_int_argument(char **argstr, int *max_len, char *arg_str, int arg,
 }
 
 static int
-add_argument(char **argstr, int *max_len, char *arg_str, char *arg)
+add_argument(char **argstr, int *max_len, char *arg_str, const char *arg)
 {
 	int len;
 
@@ -1541,7 +1546,7 @@ static int scan_sys_nvme_filter(const struct dirent *d)
 /*
  * Returns 1 if disconnect occurred, 0 otherwise.
  */
-static int disconnect_subsys(char *nqn, char *ctrl)
+static int disconnect_subsys(const char *nqn, char *ctrl)
 {
 	char *sysfs_nqn_path = NULL, *sysfs_del_path = NULL;
 	char subsysnqn[NVMF_NQN_SIZE] = {};
@@ -1579,7 +1584,7 @@ static int disconnect_subsys(char *nqn, char *ctrl)
 /*
  * Returns the number of controllers successfully disconnected.
  */
-static int disconnect_by_nqn(char *nqn)
+static int disconnect_by_nqn(const char *nqn)
 {
 	struct dirent **devices = NULL;
 	int i, n, ret = 0;
@@ -1601,7 +1606,7 @@ static int disconnect_by_nqn(char *nqn)
 	return ret;
 }
 
-static int disconnect_by_device(char *device)
+static int disconnect_by_device(const char *device)
 {
 	int instance;
 
diff --git a/fabrics.h b/fabrics.h
index ce965a3..1dfbd67 100644
--- a/fabrics.h
+++ b/fabrics.h
@@ -13,13 +13,13 @@ extern int fabrics_disconnect_all(const char *desc, int argc, char **argv);
 /* Symbols used by monitor.c */
 
 struct config {
-	char *nqn;
-	char *transport;
-	char *traddr;
-	char *trsvcid;
-	char *host_traddr;
-	char *hostnqn;
-	char *hostid;
+	const char *nqn;
+	const char *transport;
+	const char *traddr;
+	const char *trsvcid;
+	const char *host_traddr;
+	const char *hostnqn;
+	const char *hostid;
 	int  nr_io_queues;
 	int  nr_write_queues;
 	int  nr_poll_queues;
@@ -29,7 +29,7 @@ struct config {
 	int  ctrl_loss_tmo;
 	int  tos;
 	char *raw;
-	char *device;
+	const char *device;
 	int  duplicate_connect;
 	int  disable_sqflow;
 	int  hdr_digest;
@@ -43,5 +43,6 @@ extern struct config cfg;
 
 int build_options(char *argstr, int max_len, bool discover);
 int do_discover(char *argstr, bool connect);
+int ctrl_instance(const char *device);
 
 #endif
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
