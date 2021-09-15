Return-Path: <SRS0=dHSS=OF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C91C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 13:30:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE8B461268
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 13:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE8B461268
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/77l+/gHkTZG+ezaWUxesyCeloUgzpWO45ByPG4mt2A=; b=3pdeAlgmmqK6d9
	zGv9a5i3TvbBRhS90FJaE8s0nvoQaKaM7t14DwOWKXjmbUSaPsPtLxgVgW9gZo7mnZVJO3v5M3EaC
	/dqptHHybWsnsB7ZTCsEqYYfAUc4RVBrch7yOlJElbv0RSt6mNEGOVVSW11arkCD1bqiisNwpcJTD
	to5cqoxI0Nj3xUHTAf5hQTw/ICGpro3EnwQLJsvrN64J3SNGi6aJSZ9cHAeTiUoPycru3j0kZ+Phr
	b7GJoPUwn8k9Gl3NCh/WOQKZQlhIShakor7uW4uGHRm9PryBX8FuCEDOVjKHxgjTb2XdU0Cep85h7
	fa+nv1WVKK8hc2lwqYoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQUyo-009Bzs-Rm; Wed, 15 Sep 2021 13:29:38 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQUya-009BwB-QP
 for linux-nvme@lists.infradead.org; Wed, 15 Sep 2021 13:29:26 +0000
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H8gyV1bdxzW78K;
 Wed, 15 Sep 2021 21:28:18 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 21:29:15 +0800
Received: from huawei.com (10.169.63.14) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 15 Sep
 2021 21:29:14 +0800
From: chengjike <chengjike.cheng@huawei.com>
To: <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>
CC: <sunao.sun@huawei.com>, <chengjike.cheng@huawei.com>,
 <jiangtao62@huawei.com>
Subject: [PATCH nvme-cli 2/2] set disk state
Date: Wed, 15 Sep 2021 21:29:12 +0800
Message-ID: <20210915132912.3004-3-chengjike.cheng@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20210915132912.3004-1-chengjike.cheng@huawei.com>
References: <20210915132912.3004-1-chengjike.cheng@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.169.63.14]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210915_062925_319229_773ED001 
X-CRM114-Status: GOOD (  14.66  )
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

From: chengjike <jiangtao62@huawei.com>

When it is failed to get data from NVMe Subsystem, the "State" of this disk is set to "faulty".
Some displaying content of fault device can be obtained from the disk attribute files.

Signed-off-by: chengjike <chengjike.cheng@huawei.com>
---
 src/nvme/private.h |  1 +
 src/nvme/tree.c    | 57 ++++++++++++++++++++++++++++++++++++++++++----
 src/nvme/tree.h    |  8 +++++++
 3 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/src/nvme/private.h b/src/nvme/private.h
index 2a151bf..2c62084 100644
--- a/src/nvme/private.h
+++ b/src/nvme/private.h
@@ -37,6 +37,7 @@ struct nvme_ns {
 	__u32 nsid;
 	char *name;
 	char *sysfs_dir;
+	char *state;
 
 	int lba_shift;
 	int lba_size;
diff --git a/src/nvme/tree.c b/src/nvme/tree.c
index 293b0c0..9564bb4 100644
--- a/src/nvme/tree.c
+++ b/src/nvme/tree.c
@@ -229,9 +229,11 @@ nvme_ns_t nvme_subsystem_next_ns(nvme_subsystem_t s, nvme_ns_t n)
 static void __nvme_free_ns(struct nvme_ns *n)
 {
 	list_del_init(&n->entry);
-	close(n->fd);
+	if (n->fd > 0)
+		close(n->fd);
 	free(n->name);
 	free(n->sysfs_dir);
+	free(n->state);
 	free(n);
 }
 
@@ -1023,9 +1025,6 @@ static int nvme_configure_ctrl(nvme_ctrl_t c, const char *path,
 	closedir(d);
 
 	c->fd = nvme_open(name);
-	if (c->fd < 0)
-		return c->fd;
-
 	c->name = strdup(name);
 	c->sysfs_dir = (char *)path;
 	c->firmware = nvme_get_ctrl_attr(c, "firmware_rev");
@@ -1277,6 +1276,11 @@ const char *nvme_ns_get_name(nvme_ns_t n)
 	return n->name;
 }
 
+const char *nvme_ns_get_state(nvme_ns_t n)
+{
+	return n->state;
+}
+
 const char *nvme_ns_get_model(nvme_ns_t n)
 {
 	return n->c ? n->c->model : n->s->model;
@@ -1515,6 +1519,37 @@ free_ns:
 	return NULL;
 }
 
+static nvme_ns_t nvme_ns_get_local_data(const char *name, const char *path)
+{
+	struct nvme_ns *n;
+	char *ns_id;
+
+	n = calloc(1, sizeof(*n));
+	if (!n) {
+		errno = ENOMEM;
+		return NULL;
+	}
+	memset(n, 0, sizeof(struct nvme_ns));
+
+	n->name = strdup(name);
+	n->fd = -1;
+	ns_id = nvme_get_attr(path, "nsid");
+	if (!ns_id) 
+		goto free_ns;
+	n->nsid = atoi(ns_id);
+	free(ns_id);
+
+	list_head_init(&n->paths);
+	list_node_init(&n->entry);
+
+	return n;
+
+free_ns:
+	free(n->name);
+	free(n);
+	return NULL;
+}
+
 static struct nvme_ns *__nvme_scan_namespace(const char *sysfs_dir, const char *name)
 {
 	struct nvme_ns *n;
@@ -1528,9 +1563,21 @@ static struct nvme_ns *__nvme_scan_namespace(const char *sysfs_dir, const char *
 	}
 
 	n = nvme_ns_open(name);
-	if (!n)
+	if (!n) {
+		n = nvme_ns_get_local_data(name, path);
+		if (!n)
+			goto free_path;
+		ret = asprintf(&n->state, "%s", "faulty");
+		if (ret < 0) 
+			goto free_path;
+ 		goto get_attr;
+	}
+
+	ret = asprintf(&n->state, "%s", "live");
+	if (ret < 0) 
 		goto free_path;
 
+get_attr:
 	n->sysfs_dir = path;
 	return n;
 
diff --git a/src/nvme/tree.h b/src/nvme/tree.h
index 68f5cbf..5254b19 100644
--- a/src/nvme/tree.h
+++ b/src/nvme/tree.h
@@ -452,6 +452,14 @@ const char *nvme_ns_get_sysfs_dir(nvme_ns_t n);
  */
 const char *nvme_ns_get_name(nvme_ns_t n);
 
+/**
+ * nvme_ns_get_status() -
+ * @n:
+ *
+ * Return: 
+ */
+const char *nvme_ns_get_state(nvme_ns_t n);
+
 /**
  * nvme_ns_get_firmware() -
  * @n:
-- 
2.21.0.windows.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
