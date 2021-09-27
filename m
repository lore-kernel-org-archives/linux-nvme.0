Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E81DC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 01:42:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1635560FDC
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 01:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1635560FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rqEBqSSrAxsloxmL/ncLjm1THsM/uwIqywH7m57pNUY=; b=gMD44hOjBVWZup
	rNFPEAcnrYeMs7hhsy+ssmFOZdnZa0wJPSm7MT5ZVbUzY7oJ/HGem56MDsFpSkxGSckGDtyVCHs3B
	V9kbd/ZENgEZqkg+PRj46JzeBlxj2DWPEkEPQwvw1ythKFAW+vwQTEv8qSda7ug7y7AxTN7izWdi+
	U9FhzOKtXym68ijOJGaGg11YUf4dKewJPxQMM06IvifrRfhgTGFPXML/YGS/rnNkV7hMnckCDcYj+
	mzrukIs5g2awm45W7tZd+fn3YVNPh7pdqLMUHQfc/50tZte5puqPhnTc+h0vH6j/qZKhKnmIVlVHI
	YWapYmm9TfBWYivhAL2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUfeb-001Mlc-L4; Mon, 27 Sep 2021 01:42:01 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUfeO-001Mk3-L2
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 01:41:50 +0000
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HHlh80wGZz1DHJ1;
 Mon, 27 Sep 2021 09:40:24 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 27 Sep 2021 09:41:39 +0800
Received: from huawei.com (10.169.63.14) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 27 Sep
 2021 09:41:38 +0800
From: chengjike <chengjike.cheng@huawei.com>
To: <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, 
 <chaitanyak@nvidia.com>
CC: <sunao.sun@huawei.com>, <jiangtao62@huawei.com>
Subject: [PATCH V2 nvme-cli 1/2] initialize disk "access" variable
Date: Mon, 27 Sep 2021 09:41:36 +0800
Message-ID: <20210927014137.3756-2-chengjike.cheng@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20210927014137.3756-1-chengjike.cheng@huawei.com>
References: <20210927014137.3756-1-chengjike.cheng@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.169.63.14]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210926_184149_063385_9E1A9C54 
X-CRM114-Status: GOOD (  14.82  )
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

When it is failed to get nvme_id_ns data from NVMe Subsystem, the failure may be caused
by a link disconnection or an error code returned by the subsystem(such as NVME_SC_*).
Then the "access" of disk is set to "faulty"(otherwise, set the value to "live").
Some displaying content of fault device can be obtained from the disk attribute files.

Signed-off-by: chengjike <chengjike.cheng@huawei.com>
---
 src/nvme/private.h |  1 +
 src/nvme/tree.c    | 57 ++++++++++++++++++++++++++++++++++++++++++----
 src/nvme/tree.h    |  8 +++++++
 3 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/src/nvme/private.h b/src/nvme/private.h
index 2a151bf..255c1b1 100644
--- a/src/nvme/private.h
+++ b/src/nvme/private.h
@@ -37,6 +37,7 @@ struct nvme_ns {
 	__u32 nsid;
 	char *name;
 	char *sysfs_dir;
+	char *access;
 
 	int lba_shift;
 	int lba_size;
diff --git a/src/nvme/tree.c b/src/nvme/tree.c
index 293b0c0..dea0f45 100644
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
+	free(n->access);
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
 
+const char *nvme_ns_get_access(nvme_ns_t n)
+{
+	return n->access;
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
+		ret = asprintf(&n->access, "%s", "faulty");
+		if (ret < 0) 
+			goto free_path;
+ 		goto get_attr;
+	}
+
+	ret = asprintf(&n->access, "%s", "live");
+	if (ret < 0) 
 		goto free_path;
 
+get_attr:
 	n->sysfs_dir = path;
 	return n;
 
diff --git a/src/nvme/tree.h b/src/nvme/tree.h
index 68f5cbf..7d3d049 100644
--- a/src/nvme/tree.h
+++ b/src/nvme/tree.h
@@ -452,6 +452,14 @@ const char *nvme_ns_get_sysfs_dir(nvme_ns_t n);
  */
 const char *nvme_ns_get_name(nvme_ns_t n);
 
+/**
+ * nvme_ns_get_access() -
+ * @n:
+ *
+ * Return: 
+ */
+const char *nvme_ns_get_access(nvme_ns_t n);
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
