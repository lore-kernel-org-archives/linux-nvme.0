Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C912BCD5BD2
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2026 08:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HtgQUXVXAcx9v8GCgcbikHVNDgq9zDqTeXTBdczcVc4=; b=PmYuPWRA4IvqYe03l871xTQVY3
	RDWngMCVfhNeDeDT/w70hg9MCOrgFrj0zWeZHSOpwROFZ3XkLvhxALETJ3gXGPWOJ2O1NYIrMGQlr
	+T/wCv8i+gcsJvRemsKHlHTHtQYZ5gUPr9YkmLZRetCmDGctmKkSqrsuXuAg12Yf0lY3ndUBuLzXS
	xQoIQCsotj7pHigGhs7ZgyKhQ3UnQuA4uCv0yr/DDh3IXMvQuPhsBHnqZIun0YBCwrhv5VDWn2hFA
	b52nQ5/tDcqNoTYWJNPtAJyLReBbco74bO8kny3WOy9Ls76Um0NWYsQeacgXD8Ad0saMmEfhdlpGS
	DKozGJ7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSsx4-000000070ii-3pWZ;
	Fri, 29 May 2026 08:52:22 +0000
Received: from m16.mail.163.com ([220.197.31.4])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSsx0-000000070hQ-0lcT
	for linux-nvme@lists.infradead.org;
	Fri, 29 May 2026 08:52:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ht
	gQUXVXAcx9v8GCgcbikHVNDgq9zDqTeXTBdczcVc4=; b=QQMes+DlOJln4FnhVM
	iNBM+OttPWzIdevv5hKpl+EHzKj+2sBCKEH1AT11yao7PlVcwW3EmPvQXk8A2fYx
	I0a2jrXKsaX25xQS/MObKiiQdke/9+Mt8TkTIO+aMlp8Hw0RtGE2ibJJlV7XhG6J
	PEL/SVhyHW0KXxZBbUIzTpDOo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD39XChUxlqPlj3AA--.31837S2;
	Fri, 29 May 2026 16:51:46 +0800 (CST)
From: dayou5941@163.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	liyouhong <liyouhong@kylinos.cn>
Subject: [PATCH] nvme-multipath: require exact iopolicy names for module parameter
Date: Fri, 29 May 2026 16:51:43 +0800
Message-Id: <20260529085143.2016914-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD39XChUxlqPlj3AA--.31837S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF17Aw45KFy7ZFW3KFWkXrb_yoW8tr4fpF
	W3Xr9I9r4xWFy7GrsFga1UCryY9w1ft3yUtrW7Kwn5Aw15A34Skw4rKFnYvF1rCF4DWFy7
	Jr45Wr4UuF4Utr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOtxhUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+gLdjGoZU6IEawAA3E
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260529_015218_588421_6CF74491 
X-CRM114-Status: GOOD (  12.36  )
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

From: liyouhong <liyouhong@kylinos.cn>

The iopolicy module parameter uses strncmp prefix matching, so values
like "numax" are accepted as "numa".  The per-subsystem sysfs attribute
already requires an exact match via sysfs_streq().  Parse both through
a shared helper so invalid values are rejected consistently.

Signed-off-by: liyouhong <liyouhong@kylinos.cn>
---
 drivers/nvme/host/multipath.c | 40 +++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 263161cb8ac0..ce8dbb741d57 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -73,19 +73,29 @@ static const char *nvme_iopolicy_names[] = {
 
 static int iopolicy = NVME_IOPOLICY_NUMA;
 
+static int nvme_iopolicy_parse(const char *str)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
+		if (sysfs_streq(str, nvme_iopolicy_names[i]))
+			return i;
+	}
+	return -EINVAL;
+}
+
 static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
 {
+	int policy;
+
 	if (!val)
 		return -EINVAL;
-	if (!strncmp(val, "numa", 4))
-		iopolicy = NVME_IOPOLICY_NUMA;
-	else if (!strncmp(val, "round-robin", 11))
-		iopolicy = NVME_IOPOLICY_RR;
-	else if (!strncmp(val, "queue-depth", 11))
-		iopolicy = NVME_IOPOLICY_QD;
-	else
-		return -EINVAL;
 
+	policy = nvme_iopolicy_parse(val);
+	if (policy < 0)
+		return policy;
+
+	iopolicy = policy;
 	return 0;
 }
 
@@ -1039,16 +1049,14 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 {
 	struct nvme_subsystem *subsys =
 		container_of(dev, struct nvme_subsystem, dev);
-	int i;
+	int policy;
 
-	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
-		if (sysfs_streq(buf, nvme_iopolicy_names[i])) {
-			nvme_subsys_iopolicy_update(subsys, i);
-			return count;
-		}
-	}
+	policy = nvme_iopolicy_parse(buf);
+	if (policy < 0)
+		return policy;
 
-	return -EINVAL;
+	nvme_subsys_iopolicy_update(subsys, policy);
+	return count;
 }
 SUBSYS_ATTR_RW(iopolicy, S_IRUGO | S_IWUSR,
 		      nvme_subsys_iopolicy_show, nvme_subsys_iopolicy_store);
-- 
2.25.1


