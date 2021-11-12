Return-Path: <SRS0=M30F=P7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDAEC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 13:08:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4B3861073
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 13:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D4B3861073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qAxDleQhcBnRVqim4xsCkgoMJzKNfo2jzB5uGRPwDs0=; b=NncEHWKBVQON8sNZ6IF5mKhli0
	ZMe2k5jSVQAu+9So0mq8wFADrUTpsjKHfKAQ+1keNuuAKRl+Ik+45i7HdsMqA0WSqmUdl0pHTdqu2
	yHkwuwu8lCxrgBZEu4h9MLmh2Tw1/VV/pvXx19NgXp4Os7Cxv4LJbVlWatXmrupPORdtLyLn6VueF
	ONdlZYCbak92lqmViOCumlKwsBjwrc+sksImxF32xhrsOq1YKpsJReOF6n9XrMut2eIbMIjOWs9N+
	kf/azGwtiQjOk+2gLkFbsthnYdNzW7nTLa5WugMhvtT/yAlKwF4HUbTpehCUyo88aHXIFPwMEBXSJ
	IyJALTpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mlWHb-00ATNl-3c; Fri, 12 Nov 2021 13:07:55 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlWAq-00ARYW-87
 for linux-nvme@lists.infradead.org; Fri, 12 Nov 2021 13:00:58 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 042AE21983;
 Fri, 12 Nov 2021 13:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636722055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qAxDleQhcBnRVqim4xsCkgoMJzKNfo2jzB5uGRPwDs0=;
 b=V3FoN+cIl/67qpnf/m6iC4Hw6sNhQMsrly2NOxKuygWN5JHowYgfnObFpz5WQJnnoOMxuo
 SQ9v6RcKEmJtglbIjTdJKBS8YZ6BicB9LH7JfV/6/2u3q9U7XIFPVOEtGhyziVtI6P3898
 eCuLvX+CXlMZjhR/nRHy/17JG/3xD2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636722055;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qAxDleQhcBnRVqim4xsCkgoMJzKNfo2jzB5uGRPwDs0=;
 b=agbzrwFLf7VZJu1U+bcjiVWCboc0bpETngWVz9vU12w2tg7Ubr7S1WTBqAra2tPQslTi/R
 5AtAQdtVECnXgQDQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id F0A97A3B81;
 Fri, 12 Nov 2021 13:00:54 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id ECA5E519126D; Fri, 12 Nov 2021 14:00:54 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH libnvme] Implement 'dhchap_key' host and controller attributes
Date: Fri, 12 Nov 2021 14:00:53 +0100
Message-Id: <20211112130053.97493-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211112_050056_498612_2E4BF996 
X-CRM114-Status: GOOD (  14.76  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Implement a 'dhchap_key' attribute for the nvme_host structure to
support the 'dhchap_secret' connection argument, and a
'dhchap_key' attribute for the nvme_controller structure to support
the 'dhchap_ctrl_secret' connection argument.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 libnvme/nvme.i     |  2 ++
 src/nvme/fabrics.c |  8 +++++++-
 src/nvme/json.c    | 16 +++++++++++++++-
 src/nvme/private.h |  2 ++
 src/nvme/tree.c    | 43 +++++++++++++++++++++++++++++++++++++++++++
 src/nvme/tree.h    | 32 ++++++++++++++++++++++++++++++++
 6 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/libnvme/nvme.i b/libnvme/nvme.i
index cfab8a2..7f1854a 100644
--- a/libnvme/nvme.i
+++ b/libnvme/nvme.i
@@ -265,6 +265,7 @@ struct nvme_host {
   %immutable hostid;
   char *hostnqn;
   char *hostid;
+  char *dhchap_key;
 };
 
 struct nvme_subsystem {
@@ -297,6 +298,7 @@ struct nvme_ctrl {
   char *traddr;
   char *host_traddr;
   char *trsvcid;
+  char *dhchap_key;
   char *address;
   char *firmware;
   char *model;
diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
index 43c4fb1..cfa242e 100644
--- a/src/nvme/fabrics.c
+++ b/src/nvme/fabrics.c
@@ -376,7 +376,7 @@ static int build_options(nvme_host_t h, nvme_ctrl_t c, char **argstr)
 {
 	struct nvme_fabrics_config *cfg = nvme_ctrl_get_config(c);
 	const char *transport = nvme_ctrl_get_transport(c);
-	const char *hostnqn, *hostid;
+	const char *hostnqn, *hostid, *hostkey, *ctrlkey;
 	bool discover = false;
 
 	if (!transport) {
@@ -406,6 +406,8 @@ static int build_options(nvme_host_t h, nvme_ctrl_t c, char **argstr)
 		discover = true;
 	hostnqn = nvme_host_get_hostnqn(h);
 	hostid = nvme_host_get_hostid(h);
+	hostkey = nvme_host_get_dhchap_key(h);
+	ctrlkey = nvme_ctrl_get_dhchap_key(c);
 	if (add_argument(argstr, "transport", transport) ||
 	    add_argument(argstr, "traddr",
 			 nvme_ctrl_get_traddr(c)) ||
@@ -417,6 +419,10 @@ static int build_options(nvme_host_t h, nvme_ctrl_t c, char **argstr)
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
index 5aa09b0..38930ed 100644
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
@@ -191,6 +197,10 @@ static void json_update_port(struct json_object *ctrl_array, nvme_ctrl_t c)
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
@@ -247,7 +257,7 @@ int json_update_config(nvme_root_t r, const char *config_file)
 	json_root = json_object_new_array();
 	nvme_for_each_host(r, h) {
 		nvme_subsystem_t s;
-		const char *hostid;
+		const char *hostid, *dhchap_key;
 
 		host_obj = json_object_new_object();
 		json_object_add_value_string(host_obj, "hostnqn",
@@ -256,6 +266,10 @@ int json_update_config(nvme_root_t r, const char *config_file)
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
index 93770d4..23863b3 100644
--- a/src/nvme/private.h
+++ b/src/nvme/private.h
@@ -86,6 +86,7 @@ struct nvme_ctrl {
 	char *trsvcid;
 	char *host_traddr;
 	char *host_iface;
+	char *dhchap_key;
 	bool discovered;
 	bool persistent;
 	struct nvme_fabrics_config cfg;
@@ -112,6 +113,7 @@ struct nvme_host {
 
 	char *hostnqn;
 	char *hostid;
+	char *dhchap_key;
 };
 
 struct nvme_root {
diff --git a/src/nvme/tree.c b/src/nvme/tree.c
index 0f72320..c39e0c2 100644
--- a/src/nvme/tree.c
+++ b/src/nvme/tree.c
@@ -168,6 +168,21 @@ const char *nvme_host_get_hostid(nvme_host_t h)
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
@@ -331,6 +346,8 @@ static void __nvme_free_host(struct nvme_host *h)
 	free(h->hostnqn);
 	if (h->hostid)
 		free(h->hostid);
+	if (h->dhchap_key)
+		free(h->dhchap_key);
 	h->r->modified = true;
 	free(h);
 }
@@ -454,6 +471,11 @@ static int nvme_scan_subsystem(struct nvme_root *r, char *name,
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
@@ -693,6 +715,21 @@ struct nvme_fabrics_config *nvme_ctrl_get_config(nvme_ctrl_t c)
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
@@ -1064,6 +1101,7 @@ static int nvme_configure_ctrl(nvme_ctrl_t c, const char *path,
 	c->queue_count = nvme_get_ctrl_attr(c, "queue_count");
 	c->serial = nvme_get_ctrl_attr(c, "serial");
 	c->sqsize = nvme_get_ctrl_attr(c, "sqsize");
+	c->dhchap_key = nvme_get_ctrl_attr(c, "dhchap_ctrl_secret");
 	return 0;
 }
 
@@ -1233,6 +1271,11 @@ nvme_ctrl_t nvme_scan_ctrl(nvme_root_t r, const char *name)
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
index fc01b5e..f7b7902 100644
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
@@ -771,6 +786,23 @@ const char *nvme_ctrl_get_host_traddr(nvme_ctrl_t c);
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
2.31.1


