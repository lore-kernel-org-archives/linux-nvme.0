Return-Path: <SRS0=n/mE=MT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259B9C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jul 2021 16:41:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E313760FEA
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jul 2021 16:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E313760FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=c5F0voEuozjtx/nu70cDrHE1zLYLJUF8Tg0Wwq87Qq4=; b=P/kIBdhVa4Szuy
	/BV+3jfq5yUeAzNt5Dn4FTx14iANzGX7a863kfcWU4dFStryEERly7CxQQvawGQfyuo6nA2ucPcVu
	+Tr7ff1qItgZF+wOiZWd2Oo8dZ+IbRACsSl2jPzmElxeZOqn7lKGF8ulxODA7ElOIoJy68pUEG8p1
	cc1IYYUzJITAGQuJ4LhNdsF4u6el4RAaM9xod8mVeus7TxX7nZJFSeXdXknypQ2f54P5h0anI2lf2
	1mKM8FZVMLIEMW0Ad3wx/MpKzLhLGoLg//iGTOQwjiy13yvJCheeGJfACWi243exmxOn5v2nwMID5
	pW5khtJzE1b8brOUnbQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m8Q8P-00FP2O-NI; Tue, 27 Jul 2021 16:40:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m8Q8M-00FP1W-Rc
 for linux-nvme@lists.infradead.org; Tue, 27 Jul 2021 16:40:48 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A233A60462;
 Tue, 27 Jul 2021 16:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627404046;
 bh=UCKQtMd+9o9xnZs9Yxvub3uip0n9KBtMizDxSqekXec=;
 h=From:To:Cc:Subject:Date:From;
 b=Hjwb60pMOXLGv5M/IajuCuGYip5UujEkN8BkxCphZPY2pI+Er3nGtL5pJo8QwoNkS
 1NiFUF/Ys0CTgM16DSWdsgz6FpLdWXs8Q2fGajpMnqegjjMHHr2SSe0Iioi51DsuKk
 13xwpa6qYxLUEJZwa2jb0/pmVaCTx8MMtCTB66dTDc+UofHioUC6p65Z3K/JJFNRw+
 MwrgOp65ruijX3fC4B9B1QkeZcfdB4cXGp23hNtgYar1+Hmy3jFZ4U4dLgOdOfGdVe
 TiXuwcbDcbsBYuL0yFKDzqG+YBP8xn4yC4S8KoOhOqlW07Bw3FeXHna7UJboGUpLz7
 NIOhMKkvOtUsQ==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de
Cc: sagi@grimberg.me, kai.heng.feng@canonical.com,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/2] nvme: allow user toggling hmb usage
Date: Tue, 27 Jul 2021 09:40:43 -0700
Message-Id: <20210727164044.2285364-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210727_094046_957394_6EAFD870 
X-CRM114-Status: GOOD (  14.31  )
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

The NVMe host memory buffer may consume a non-negligable amount of
memory. Controllers are required to function without the host memory
buffer enabled, but with possibly degraded performance. Export a sysfs
property to toggle this feature on a per-device granularity so users may
choose to reclaim memory at the expense of storage performance.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 45 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ac72386b1f2c..e8f3b32131d2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -137,6 +137,7 @@ struct nvme_dev {
 	u32 cmbloc;
 	struct nvme_ctrl ctrl;
 	u32 last_ps;
+	bool hmb;
 
 	mempool_t *iod_mempool;
 
@@ -1896,7 +1897,9 @@ static int nvme_set_host_mem(struct nvme_dev *dev, u32 bits)
 		dev_warn(dev->ctrl.device,
 			 "failed to set host mem (err %d, flags %#x).\n",
 			 ret, bits);
-	}
+	} else
+		dev->hmb = bits & NVME_HOST_MEM_ENABLE;
+
 	return ret;
 }
 
@@ -2081,6 +2084,42 @@ static ssize_t cmbsz_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(cmbsz);
 
+static ssize_t hmb_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct nvme_dev *ndev = to_nvme_dev(dev_get_drvdata(dev));
+
+	return sysfs_emit(buf, "%d\n", ndev->hmb);
+}
+
+static ssize_t hmb_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
+{
+	struct nvme_dev *ndev = to_nvme_dev(dev_get_drvdata(dev));
+	bool new;
+	int ret;
+
+	if (strtobool(buf, &new) < 0)
+		return -EINVAL;
+
+	if (new == ndev->hmb)
+		return count;
+
+	if (new) {
+		ret = nvme_setup_host_mem(ndev);
+	} else {
+		ret = nvme_set_host_mem(ndev, 0);
+		if (!ret)
+			nvme_free_host_mem(ndev);
+	}
+
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR_RW(hmb);
+
 static umode_t nvme_pci_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
@@ -2094,6 +2133,9 @@ static umode_t nvme_pci_attrs_are_visible(struct kobject *kobj,
 	    	if (!dev->cmbsz)
 			return 0;
 	}
+	if (a == &dev_attr_hmb.attr && !ctrl->hmpre)
+		return 0;
+
 	return a->mode;
 }
 
@@ -2101,6 +2143,7 @@ static struct attribute *nvme_pci_attrs[] = {
 	&dev_attr_cmb.attr,
 	&dev_attr_cmbloc.attr,
 	&dev_attr_cmbsz.attr,
+	&dev_attr_hmb.attr,
 	NULL,
 };
 
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
