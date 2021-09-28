Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16487C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 12:31:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F1461058
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 12:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C7F1461058
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=J5BrAEni+B+4Bwwkua7zR/Pd58i1aGtpeD5SElHDWgs=; b=GEv8gcqOFQzQz8
	5Aymldk05atwtrJ+vUQxlTCZjp/JzAMpqa+tn8KeQmr4kZ6Yk9aVDQWtDpq0h6I1RsQfgSQIXaSoI
	fEvydz0hRLc1BWdw0/oiLo9188fZ+G1fmaDekdORs/lg7U/mStcrcOP4JK6jVl58lZh6Hczk9k7EQ
	CIBgb3+jEi0ueuf1s6LBtYRmSaZo+HINO4t0/WRjNHG3dVppYIo0o8wqceV+zAcbLF76rTZolqPox
	L5tgYfPDxiGYF6lAFdGkFiOJYClAUHiSRGQAWfGJ/AazA8lW1GqXe22IMNTHyr09EcAbdOS/Rvh8/
	1RqMc1WSWuNzYzYO4O8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVCG4-00789m-3o; Tue, 28 Sep 2021 12:30:52 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVC74-00745y-CE
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 12:21:36 +0000
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
 by smtp-out2.suse.de (Postfix) with ESMTP id 6E2FF20202;
 Tue, 28 Sep 2021 12:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632831692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4l1lbwYbh8cFCWtbltC6HNIiHtAq/EaWOh4sNU6xiuU=;
 b=hNwmF0JgyIfZRwmWbRZkr7Ayyr5ANmNa8i1n60KFUy0razXKnuX9KXD+dxjlq34ChMnlDF
 hRlfbd0n2Iuz87UoAVZk9ZfNBgq8sZ7+SYsYkjon4ngDbtDrRYxtsXhCzMHEtTIj3dSZzB
 4bWa+4VZ5YF5+NoqDnhzWWu6Pd3EOQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632831692;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4l1lbwYbh8cFCWtbltC6HNIiHtAq/EaWOh4sNU6xiuU=;
 b=YGN6+9HHVirw3UoFJcPUMAIl4Gp/Gm3Et5bxZNnqTQJAutL0I7nhWn3a8XIHPgIkYKwuca
 Mlf2qshqsENpIMCg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay1.suse.de (Postfix) with ESMTP id 3F2E325D86;
 Tue, 28 Sep 2021 12:21:32 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 2FC12518EE61; Tue, 28 Sep 2021 14:21:32 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH libnvme] Implement 'dhchap_key' host and controller attributes
Date: Tue, 28 Sep 2021 14:21:28 +0200
Message-Id: <20210928122128.34512-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_052134_623220_EB5F9B20 
X-CRM114-Status: GOOD (  15.25  )
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

Implement a 'dhchap_key' attribute for the nvme_host structure to
support the 'dhchap_secret' connection argument, and a
'dhchap_key' attribute for the nvme_controller structure to support
the 'dhchap_ctrl_secret' connection argument.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 pynvme/nvme.i      |  2 ++
 src/nvme/fabrics.c |  8 +++++++-
 src/nvme/json.c    | 16 +++++++++++++++-
 src/nvme/private.h |  2 ++
 src/nvme/tree.c    | 43 +++++++++++++++++++++++++++++++++++++++++++
 src/nvme/tree.h    | 32 ++++++++++++++++++++++++++++++++
 6 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/pynvme/nvme.i b/pynvme/nvme.i
index 9193617..eb9e6ef 100644
--- a/pynvme/nvme.i
+++ b/pynvme/nvme.i
@@ -271,6 +271,7 @@ struct nvme_host {
   %immutable hostid;
   char *hostnqn;
   char *hostid;
+  char *dhchap_key;
 };
 
 struct nvme_subsystem {
@@ -302,6 +303,7 @@ struct nvme_ctrl {
   char *traddr;
   char *host_traddr;
   char *trsvcid;
+  char *dhchap_key;
   char *address;
   char *firmware;
   char *model;
diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
index ebfc635..62012a0 100644
--- a/src/nvme/fabrics.c
+++ b/src/nvme/fabrics.c
@@ -276,7 +276,7 @@ static int build_options(nvme_host_t h, nvme_ctrl_t c, char **argstr)
 {
 	struct nvme_fabrics_config *cfg = nvme_ctrl_get_config(c);
 	const char *transport = nvme_ctrl_get_transport(c);
-	const char *hostnqn, *hostid;
+	const char *hostnqn, *hostid, *hostkey, *ctrlkey;
 	bool discover = false;
 
 	if (!transport) {
@@ -306,6 +306,8 @@ static int build_options(nvme_host_t h, nvme_ctrl_t c, char **argstr)
 		discover = true;
 	hostnqn = nvme_host_get_hostnqn(h);
 	hostid = nvme_host_get_hostid(h);
+	hostkey = nvme_host_get_dhchap_key(h);
+	ctrlkey = nvme_ctrl_get_dhchap_key(c);
 	if (add_argument(argstr, "transport", transport) ||
 	    add_argument(argstr, "traddr",
 			 nvme_ctrl_get_traddr(c)) ||
@@ -317,6 +319,10 @@ static int build_options(nvme_host_t h, nvme_ctrl_t c, char **argstr)
 			 nvme_ctrl_get_trsvcid(c)) ||
 	    (hostnqn && add_argument(argstr, "hostnqn", hostnqn)) ||
 	    (hostid && add_argument(argstr, "hostid", hostid)) ||
+	    (!discover && hostkey &&
+	     add_argument(argstr, "dhchap_secret", hostkey)) ||
+	    (!discover && ctrlkey &&
+	     add_argument(argstr, "dhchap_ctrl_secret", ctrlkey)) ||
 	    (!discover &&
 	     add_int_argument(argstr, "nr_io_queues",
 			      cfg->nr_io_queues, false)) ||
diff --git a/src/nvme/json.c b/src/nvme/json.c
index 9d49758..83c91ac 100644
--- a/src/nvme/json.c
+++ b/src/nvme/json.c
@@ -94,6 +94,9 @@ static void json_parse_port(nvme_subsystem_t s, struct json_object *port_obj)
 	c = nvme_lookup_ctrl(s, transport, traddr, host_traddr,
 			     host_iface, trsvcid);
 	if (c) {
+		attr_obj = json_object_object_get(port_obj, "dhchap_key");
+		if (attr_obj)
+			nvme_ctrl_set_dhchap_key(c, json_object_get_string(attr_obj));
 		json_update_attributes(c, port_obj);
 	}
 }
@@ -136,6 +139,9 @@ static void json_parse_host(nvme_root_t r, struct json_object *host_obj)
 	if (attr_obj)
 		hostid = json_object_get_string(attr_obj);
 	h = nvme_lookup_host(r, hostnqn, hostid);
+	attr_obj = json_object_object_get(host_obj, "dhchap_key");
+	if (attr_obj)
+		nvme_host_set_dhchap_key(h, json_object_get_string(attr_obj));
 	subsys_array = json_object_object_get(host_obj, "subsystems");
 	if (!subsys_array)
 		return;
@@ -192,6 +198,10 @@ static void json_update_port(struct json_object *ctrl_array, nvme_ctrl_t c)
 	value = nvme_ctrl_get_trsvcid(c);
 	if (value)
 		json_object_add_value_string(port_obj, "trsvcid", value);
+	value = nvme_ctrl_get_dhchap_key(c);
+	if (value)
+		json_object_add_value_string(port_obj, "dhchap_key",
+					     value);
 	JSON_INT_OPTION(cfg, port_obj, nr_io_queues, 0);
 	JSON_INT_OPTION(cfg, port_obj, nr_write_queues, 0);
 	JSON_INT_OPTION(cfg, port_obj, nr_poll_queues, 0);
@@ -248,7 +258,7 @@ int json_update_config(nvme_root_t r, const char *config_file)
 	json_root = json_object_new_array();
 	nvme_for_each_host(r, h) {
 		nvme_subsystem_t s;
-		const char *hostid;
+		const char *hostid, *dhchap_key;
 
 		host_obj = json_object_new_object();
 		json_object_add_value_string(host_obj, "hostnqn",
@@ -257,6 +267,10 @@ int json_update_config(nvme_root_t r, const char *config_file)
 		if (hostid)
 			json_object_add_value_string(host_obj, "hostid",
 						     hostid);
+		dhchap_key = nvme_host_get_dhchap_key(h);
+		if (dhchap_key)
+			json_object_add_value_string(host_obj, "dhchap_key",
+						     dhchap_key);
 		subsys_array = json_object_new_array();
 		nvme_for_each_subsystem(h, s) {
 			json_update_subsys(subsys_array, s);
diff --git a/src/nvme/private.h b/src/nvme/private.h
index 2a151bf..803d0ce 100644
--- a/src/nvme/private.h
+++ b/src/nvme/private.h
@@ -77,6 +77,7 @@ struct nvme_ctrl {
 	char *trsvcid;
 	char *host_traddr;
 	char *host_iface;
+	char *dhchap_key;
 	bool discovered;
 	bool persistent;
 	struct nvme_fabrics_config cfg;
@@ -103,6 +104,7 @@ struct nvme_host {
 
 	char *hostnqn;
 	char *hostid;
+	char *dhchap_key;
 };
 
 struct nvme_root {
diff --git a/src/nvme/tree.c b/src/nvme/tree.c
index 293b0c0..0910b32 100644
--- a/src/nvme/tree.c
+++ b/src/nvme/tree.c
@@ -147,6 +147,21 @@ const char *nvme_host_get_hostid(nvme_host_t h)
 	return h->hostid;
 }
 
+const char *nvme_host_get_dhchap_key(nvme_host_t h)
+{
+	return h->dhchap_key;
+}
+
+void nvme_host_set_dhchap_key(nvme_host_t h, const char *key)
+{
+	if (h->dhchap_key) {
+		free(h->dhchap_key);
+		h->dhchap_key = NULL;
+	}
+	if (key)
+		h->dhchap_key = strdup(key);
+}
+
 nvme_subsystem_t nvme_first_subsystem(nvme_host_t h)
 {
 	return list_top(&h->subsystems, struct nvme_subsystem, entry);
@@ -310,6 +325,8 @@ static void __nvme_free_host(struct nvme_host *h)
 	free(h->hostnqn);
 	if (h->hostid)
 		free(h->hostid);
+	if (h->dhchap_key)
+		free(h->dhchap_key);
 	h->r->modified = true;
 	free(h);
 }
@@ -415,6 +432,11 @@ static int nvme_scan_subsystem(struct nvme_root *r, char *name,
 		free(hostnqn);
 		if (hostid)
 			free(hostid);
+		if (h) {
+			if (h->dhchap_key)
+				free(h->dhchap_key);
+			h->dhchap_key = nvme_get_attr(path, "dhchap_secret");
+		}
 	}
 	if (!h)
 		h = nvme_default_host(r);
@@ -666,6 +688,21 @@ struct nvme_fabrics_config *nvme_ctrl_get_config(nvme_ctrl_t c)
 	return &c->cfg;
 }
 
+const char *nvme_ctrl_get_dhchap_key(nvme_ctrl_t c)
+{
+	return c->dhchap_key;
+}
+
+void nvme_ctrl_set_dhchap_key(nvme_ctrl_t c, const char *key)
+{
+	if (c->dhchap_key) {
+		free(c->dhchap_key);
+		c->dhchap_key = NULL;
+	}
+	if (key)
+		c->dhchap_key = strdup(key);
+}
+
 void nvme_ctrl_disable_sqflow(nvme_ctrl_t c, bool disable_sqflow)
 {
 	c->cfg.disable_sqflow = disable_sqflow;
@@ -1035,6 +1072,7 @@ static int nvme_configure_ctrl(nvme_ctrl_t c, const char *path,
 	c->queue_count = nvme_get_ctrl_attr(c, "queue_count");
 	c->serial = nvme_get_ctrl_attr(c, "serial");
 	c->sqsize = nvme_get_ctrl_attr(c, "sqsize");
+	c->dhchap_key = nvme_get_ctrl_attr(c, "dhchap_ctrl_secret");
 	return 0;
 }
 
@@ -1173,6 +1211,11 @@ nvme_ctrl_t nvme_scan_ctrl(nvme_root_t r, const char *name)
 		free(hostnqn);
 	if (hostid)
 		free(hostid);
+	if (h) {
+		if (h->dhchap_key)
+			free(h->dhchap_key);
+		h->dhchap_key = nvme_get_attr(path, "dhchap_secret");
+	}
 	if (!h) {
 		h = nvme_default_host(r);
 		if (!h) {
diff --git a/src/nvme/tree.h b/src/nvme/tree.h
index 4974741..48f2ad4 100644
--- a/src/nvme/tree.h
+++ b/src/nvme/tree.h
@@ -105,6 +105,21 @@ const char *nvme_host_get_hostnqn(nvme_host_t h);
  */
 const char *nvme_host_get_hostid(nvme_host_t h);
 
+/**
+ * nvme_host_get_dhchap_key() -
+ * @h:
+ *
+ * Return: 
+ */
+const char *nvme_host_get_dhchap_key(nvme_host_t h);
+
+/**
+ * nvme_host_set_dhchap_key() -
+ * @h: 
+ * @key: 
+ */
+void nvme_host_set_dhchap_key(nvme_host_t h, const char *key);
+
 /**
  * nvme_default_host() -
  * @r:
@@ -787,6 +802,23 @@ const char *nvme_ctrl_get_host_traddr(nvme_ctrl_t c);
  */
 const char *nvme_ctrl_get_host_iface(nvme_ctrl_t c);
 
+/**
+ * nvme_ctrl_set_dhchap_key() -
+ * @c:
+ * @key:
+ *
+ * Return:
+ */
+void nvme_ctrl_set_dhchap_key(nvme_ctrl_t c, const char *key);
+
+/**
+ * nvme_ctrl_get_dhchap_key() -
+ * @c:
+ *
+ * Return:
+ */
+const char *nvme_ctrl_get_dhchap_key(nvme_ctrl_t c);
+
 /**
  * nvme_ctrl_get_config() -
  * @c:
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
