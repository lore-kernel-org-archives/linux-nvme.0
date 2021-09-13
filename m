Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6BDC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 09:47:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB6960F46
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 09:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7CB6960F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tdzMWac0iE0Jfhuy0LLzkG2q4zA8j1GRf+XGFe+UqOw=; b=d0vfjlrhWDJhq1
	q80+yzktRGY+i/SbTOjtTk4/ErhPgH00N6c6ywUI8xzf40bcj92/5WVvYhFLhIraIcChV4pMRLoW3
	sJrNG9p35ebQI2TYnFhNhXD5uX0Qgpv83Wu0UFgad1qG80SHk/LNOhvvDRBg3tOc3sDOOYyAVetJD
	UiZmX7Wc6Bst+rnyoeg4Pb7Bpepri9Cb4ovNYWQ7/U+ipRZ/WEZEAqNnwQNvqKAoiIQu8jhPx1J2y
	iUUFoHOUwoAqXEwlU5jmrYbh/8BFEMeusZYssa0bsRQRietOQl0wL3i2iATziuWbwXTNwEXYOPDFv
	IqDeuxlb517ygH3FnwQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPiXr-0017hY-2c; Mon, 13 Sep 2021 09:46:35 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPiSl-0016Yl-Ce
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 09:41:21 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id E6ECB21EFE;
 Mon, 13 Sep 2021 09:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1631526075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xGstSgjL4+qaQ9DaF77tP4OJSnLGQD1NcwDKUlZpWa0=;
 b=bfFzDEUvJR/TybYFt9JVqM2zBzk0gST3BVA8nyYrYPxWa/ZyQCcvmA5S/BmLJAaw+w2Q3c
 p2fEbxZ5dQgK5FBL//Flzb4jnrnQDIKOEzS2n7fGLIT7pz78N5Qzzq1NXzdv20d3sybCSi
 3T3uIXlrezM0UIukhQzM7LGeHa0R1Kg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1631526075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xGstSgjL4+qaQ9DaF77tP4OJSnLGQD1NcwDKUlZpWa0=;
 b=2PeZOkVTe/32LSAPRFWydw+YmABSxG3HfXmI2xstYk6n/KLGQZXfmQK15ErJe2hHRm7Vxy
 /8kz6QjXFDp9zbBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id B314CA3BB2;
 Mon, 13 Sep 2021 09:41:15 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id A538D518E595; Mon, 13 Sep 2021 11:41:15 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH libnvme] Implement 'hostkey' and 'dhchap_bidi' attributes
Date: Mon, 13 Sep 2021 11:41:14 +0200
Message-Id: <20210913094114.18654-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_024119_645746_10C8A661 
X-CRM114-Status: GOOD (  18.06  )
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

Implement a 'hostkey' attribute for the nvme_host structure to
support the 'dhchap_secret' connection argument, and a
'dhchap_bidi' fabrics configuration setting to enable
bidirectional authentication.
This is the libnvme patch to support NVMe In-band authentication as posted
on the linux-nvme mailinglist.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 pynvme/nvme.i      |  1 +
 src/nvme/fabrics.c | 16 ++++++++++++++--
 src/nvme/fabrics.h | 10 ++++++++++
 src/nvme/json.c    | 12 +++++++++++-
 src/nvme/private.h |  1 +
 src/nvme/tree.c    | 17 +++++++++++++++++
 src/nvme/tree.h    | 15 +++++++++++++++
 7 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/pynvme/nvme.i b/pynvme/nvme.i
index 9193617..a2ade7f 100644
--- a/pynvme/nvme.i
+++ b/pynvme/nvme.i
@@ -271,6 +271,7 @@ struct nvme_host {
   %immutable hostid;
   char *hostnqn;
   char *hostid;
+  char *hostkey;
 };
 
 struct nvme_subsystem {
diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
index bdbcb83..1ff06ac 100644
--- a/src/nvme/fabrics.c
+++ b/src/nvme/fabrics.c
@@ -37,10 +37,12 @@
 #include "private.h"
 
 #define NVMF_HOSTID_SIZE	37
+#define NVMF_HOSTKEY_SIZE	65
 
 const char *nvmf_dev = "/dev/nvme-fabrics";
 const char *nvmf_hostnqn_file = "/etc/nvme/hostnqn";
 const char *nvmf_hostid_file = "/etc/nvme/hostid";
+const char *nvmf_hostkey_file = "/etc/nvme/hostkey";
 
 const char *arg_str(const char * const *strings,
 		size_t array_size, size_t idx)
@@ -217,7 +219,7 @@ static int build_options(nvme_host_t h, nvme_ctrl_t c, char **argstr)
 {
 	struct nvme_fabrics_config *cfg = nvme_ctrl_get_config(c);
 	const char *transport = nvme_ctrl_get_transport(c);
-	const char *hostnqn, *hostid;
+	const char *hostnqn, *hostid, *hostkey;
 	bool discover = false;
 
 	if (!transport) {
@@ -247,6 +249,7 @@ static int build_options(nvme_host_t h, nvme_ctrl_t c, char **argstr)
 		discover = true;
 	hostnqn = nvme_host_get_hostnqn(h);
 	hostid = nvme_host_get_hostid(h);
+	hostkey = nvme_host_get_hostkey(h);
 	if (add_argument(argstr, "transport", transport) ||
 	    add_argument(argstr, "traddr",
 			 nvme_ctrl_get_traddr(c)) ||
@@ -258,6 +261,8 @@ static int build_options(nvme_host_t h, nvme_ctrl_t c, char **argstr)
 			 nvme_ctrl_get_trsvcid(c)) ||
 	    (hostnqn && add_argument(argstr, "hostnqn", hostnqn)) ||
 	    (hostid && add_argument(argstr, "hostid", hostid)) ||
+	    (!discover && hostkey &&
+	     add_argument(argstr, "dhchap_secret", hostkey)) ||
 	    (!discover &&
 	     add_int_argument(argstr, "nr_io_queues",
 			      cfg->nr_io_queues, false)) ||
@@ -289,7 +294,9 @@ static int build_options(nvme_host_t h, nvme_ctrl_t c, char **argstr)
 	    (!strcmp(transport, "tcp") &&
 	     add_bool_argument(argstr, "hdr_digest", cfg->hdr_digest)) ||
 	    (!strcmp(transport, "tcp") &&
-	     add_bool_argument(argstr, "data_digest", cfg->data_digest))) {
+	     add_bool_argument(argstr, "data_digest", cfg->data_digest)) ||
+	    (!strcmp(transport, "tcp") &&
+	     add_bool_argument(argstr, "dhchap_bidi", cfg->dhchap_bidi))) {
 		free(*argstr);
 		return -1;
 	}
@@ -722,3 +729,8 @@ char *nvmf_hostid_from_file()
 {
 	return nvmf_read_file(nvmf_hostid_file, NVMF_HOSTID_SIZE);
 }
+
+char *nvmf_hostkey_from_file()
+{
+	return nvmf_read_file(nvmf_hostkey_file, NVMF_HOSTKEY_SIZE);
+}
diff --git a/src/nvme/fabrics.h b/src/nvme/fabrics.h
index 10ac2e2..d9a1210 100644
--- a/src/nvme/fabrics.h
+++ b/src/nvme/fabrics.h
@@ -31,6 +31,7 @@
  * @disable_sqflow:	Disable controller sq flow control
  * @hdr_digest:		Generate/verify header digest (TCP)
  * @data_digest:	Generate/verify data digest (TCP)
+ * @dhchap_bidi:	Enable bidirectional authentication (TCP)
  */
 struct nvme_fabrics_config {
 	int queue_size;
@@ -47,6 +48,7 @@ struct nvme_fabrics_config {
 	bool disable_sqflow;
 	bool hdr_digest;
 	bool data_digest;
+	bool dhchap_bidi;
 };
 
 /**
@@ -169,6 +171,14 @@ char *nvmf_hostnqn_from_file();
  */
 char *nvmf_hostid_from_file();
 
+/**
+ * nvmf_hostkey_from_file() - Reads the host dhchap secret from the config
+ * 			      default location in /etc/nvme/.
+ * Return: The host dhchap secret, or NULL if unsuccessful. If found, the
+ * 	   caller is responsible to free the string.
+ */
+char *nvmf_hostkey_from_file();
+
 /**
  * nvmf_connect_disc_entry() -
  * @h:
diff --git a/src/nvme/json.c b/src/nvme/json.c
index faadf2d..dcafcbb 100644
--- a/src/nvme/json.c
+++ b/src/nvme/json.c
@@ -62,6 +62,8 @@ static void json_update_attributes(nvme_ctrl_t c,
 					hdr_digest, val_obj);
 		JSON_UPDATE_BOOL_OPTION(cfg, key_str,
 					data_digest, val_obj);
+		JSON_UPDATE_BOOL_OPTION(cfg, key_str,
+					dhchap_bidi, val_obj);
 		if (!strcmp("persistent", key_str) &&
 		    !nvme_ctrl_is_persistent(c))
 			nvme_ctrl_set_persistent(c, true);
@@ -136,6 +138,9 @@ static void json_parse_host(nvme_root_t r, struct json_object *host_obj)
 	if (attr_obj)
 		hostid = json_object_get_string(attr_obj);
 	h = nvme_lookup_host(r, hostnqn, hostid);
+	attr_obj = json_object_object_get(host_obj, "hostkey");
+	if (attr_obj)
+		nvme_host_set_hostkey(h, json_object_get_string(attr_obj));
 	subsys_array = json_object_object_get(host_obj, "subsystems");
 	if (!subsys_array)
 		return;
@@ -207,6 +212,7 @@ static void json_update_port(struct json_object *ctrl_array, nvme_ctrl_t c)
 	JSON_BOOL_OPTION(cfg, port_obj, disable_sqflow);
 	JSON_BOOL_OPTION(cfg, port_obj, hdr_digest);
 	JSON_BOOL_OPTION(cfg, port_obj, data_digest);
+	JSON_BOOL_OPTION(cfg, port_obj, dhchap_bidi);
 	if (nvme_ctrl_is_persistent(c))
 		json_object_add_value_bool(port_obj, "persistent", true);
 	json_object_array_add(ctrl_array, port_obj);
@@ -247,7 +253,7 @@ int json_update_config(nvme_root_t r, const char *config_file)
 	json_root = json_object_new_array();
 	nvme_for_each_host(r, h) {
 		nvme_subsystem_t s;
-		const char *hostid;
+		const char *hostid, *hostkey;
 
 		host_obj = json_object_new_object();
 		json_object_add_value_string(host_obj, "hostnqn",
@@ -256,6 +262,10 @@ int json_update_config(nvme_root_t r, const char *config_file)
 		if (hostid)
 			json_object_add_value_string(host_obj, "hostid",
 						     hostid);
+		hostkey = nvme_host_get_hostkey(h);
+		if (hostkey)
+			json_object_add_value_string(host_obj, "hostkey",
+						     hostkey);
 		subsys_array = json_object_new_array();
 		nvme_for_each_subsystem(h, s) {
 			json_update_subsys(subsys_array, s);
diff --git a/src/nvme/private.h b/src/nvme/private.h
index 2a151bf..fc61ef1 100644
--- a/src/nvme/private.h
+++ b/src/nvme/private.h
@@ -103,6 +103,7 @@ struct nvme_host {
 
 	char *hostnqn;
 	char *hostid;
+	char *hostkey;
 };
 
 struct nvme_root {
diff --git a/src/nvme/tree.c b/src/nvme/tree.c
index 6c46ef1..502f4ae 100644
--- a/src/nvme/tree.c
+++ b/src/nvme/tree.c
@@ -64,6 +64,8 @@ nvme_host_t nvme_default_host(nvme_root_t r)
 	free(hostnqn);
 	if (hostid)
 		free(hostid);
+	if (h)
+		h->hostkey = nvmf_hostkey_from_file();
 	return h;
 }
 
@@ -147,6 +149,21 @@ const char *nvme_host_get_hostid(nvme_host_t h)
 	return h->hostid;
 }
 
+const char *nvme_host_get_hostkey(nvme_host_t h)
+{
+	return h->hostkey;
+}
+
+void nvme_host_set_hostkey(nvme_host_t h, const char *hostkey)
+{
+	if (h->hostkey) {
+		free(h->hostkey);
+		h->hostkey = NULL;
+	}
+	if (hostkey)
+		h->hostkey = strdup(hostkey);
+}
+
 nvme_subsystem_t nvme_first_subsystem(nvme_host_t h)
 {
 	return list_top(&h->subsystems, struct nvme_subsystem, entry);
diff --git a/src/nvme/tree.h b/src/nvme/tree.h
index 68f5cbf..e5a350d 100644
--- a/src/nvme/tree.h
+++ b/src/nvme/tree.h
@@ -105,6 +105,21 @@ const char *nvme_host_get_hostnqn(nvme_host_t h);
  */
 const char *nvme_host_get_hostid(nvme_host_t h);
 
+/**
+ * nvme_host_get_hostkey() -
+ * @h:
+ *
+ * Return: 
+ */
+const char *nvme_host_get_hostkey(nvme_host_t h);
+
+/**
+ * nvme_host_set_hostkey() -
+ * @h: 
+ * @k: 
+ */
+void nvme_host_set_hostkey(nvme_host_t h, const char *k);
+
 /**
  * nvme_default_host() -
  * @r:
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
