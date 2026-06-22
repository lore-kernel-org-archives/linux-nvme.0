Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EF1CD98E4
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jun 2026 02:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6KsFQUJoeYL7Ze4WBExLyldd138Y6/Yj8uXh/IIZa/U=; b=Pee9EhQPFCdf7ToQPrwXWH70lW
	LqK5NrHyxjNbUtvkgui0plqBxuiglvdCVp07uXLp8c2Q+pUbzbLjihal0z1shadPTzpL9F/qxe9B5
	lfuHri3U4BEoyK+0pq03OMisReXPVEbmE3vjuARtg/d52TlgGcLs1OruwoLymznYwQURxxi9MZfFA
	sBGwKK4bchA0/LmE+jodFCi22w51hu4MTpywNZlIwI87lQwywXO5hAwMMD1UyfsNNJMYpuWF12wfR
	Oe+wJ0WKN8m/6fD5Zr+APpzAPBAcwZ4Z4LQewq2HjFI+VsDWHCfn1c+mWZVU3KBx2Q409hV28Jghf
	/838ViCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbUsi-00000004Kg9-16Ni;
	Mon, 22 Jun 2026 02:59:28 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbUsf-00000004Kfg-1WU6
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jun 2026 02:59:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782097163; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6KsFQUJoeYL7Ze4WBExLyldd138Y6/Yj8uXh/IIZa/U=;
	b=obXVzxXXdzsWHZ4LKmz/6swkwWLiwO7q12NV5driarxICRhAzA9aLoggTwwJIiPiUhaBfuXRylg6Qt/qxHanU9PTmdAzVKWlPj6YtmQPmMw2FtsFNYYTP7/6EKaFqZHdcThKDQ6LBbV/Nc3BzTG4mCtWILqZwxDN3LMWovCBSnY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X5Ghg4v_1782097155;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X5Ghg4v_1782097155 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Jun 2026 10:59:20 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: replace sysfs_emit() with sprintf() in configfs show attrs
Date: Mon, 22 Jun 2026 10:59:15 +0800
Message-ID: <20260622025915.1294806-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260621_195925_737349_94953469 
X-CRM114-Status: UNSURE (   9.61  )
X-CRM114-Notice: Please train this message.
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

sysfs_emit() is designed for sysfs attributes and internally checks that
the buffer is page-aligned. Although configfs currently happens to use a
page-aligned buffer allocated via kzalloc(PAGE_SIZE), using sysfs_emit()
in configfs show callbacks is a semantic misuse of the API. Replace with
sprintf() to match the convention used by all other configfs show
functions in these files.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/configfs.c | 6 +++---
 drivers/nvme/target/pci-epf.c  | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index b88f897f06e2..f4c77dd1f160 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -798,7 +798,7 @@ CONFIGFS_ATTR_WO(nvmet_ns_, revalidate_size);
 
 static ssize_t nvmet_ns_resv_enable_show(struct config_item *item, char *page)
 {
-	return sysfs_emit(page, "%d\n", to_nvmet_ns(item)->pr.enable);
+	return sprintf(page, "%d\n", to_nvmet_ns(item)->pr.enable);
 }
 
 static ssize_t nvmet_ns_resv_enable_store(struct config_item *item,
@@ -1534,7 +1534,7 @@ static ssize_t nvmet_subsys_attr_ieee_oui_show(struct config_item *item,
 {
 	struct nvmet_subsys *subsys = to_subsys(item);
 
-	return sysfs_emit(page, "0x%06x\n", subsys->ieee_oui);
+	return sprintf(page, "0x%06x\n", subsys->ieee_oui);
 }
 
 static ssize_t nvmet_subsys_attr_ieee_oui_store_locked(struct nvmet_subsys *subsys,
@@ -1582,7 +1582,7 @@ static ssize_t nvmet_subsys_attr_firmware_show(struct config_item *item,
 {
 	struct nvmet_subsys *subsys = to_subsys(item);
 
-	return sysfs_emit(page, "%s\n", subsys->firmware_rev);
+	return sprintf(page, "%s\n", subsys->firmware_rev);
 }
 
 static ssize_t nvmet_subsys_attr_firmware_store_locked(struct nvmet_subsys *subsys,
diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 4e9db96ebfec..547eeb0cae85 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -2482,7 +2482,7 @@ static ssize_t nvmet_pci_epf_portid_show(struct config_item *item, char *page)
 	struct config_group *group = to_config_group(item);
 	struct nvmet_pci_epf *nvme_epf = to_nvme_epf(group);
 
-	return sysfs_emit(page, "%u\n", le16_to_cpu(nvme_epf->portid));
+	return sprintf(page, "%u\n", le16_to_cpu(nvme_epf->portid));
 }
 
 static ssize_t nvmet_pci_epf_portid_store(struct config_item *item,
@@ -2515,7 +2515,7 @@ static ssize_t nvmet_pci_epf_subsysnqn_show(struct config_item *item,
 	struct config_group *group = to_config_group(item);
 	struct nvmet_pci_epf *nvme_epf = to_nvme_epf(group);
 
-	return sysfs_emit(page, "%s\n", nvme_epf->subsysnqn);
+	return sprintf(page, "%s\n", nvme_epf->subsysnqn);
 }
 
 static ssize_t nvmet_pci_epf_subsysnqn_store(struct config_item *item,
@@ -2543,7 +2543,7 @@ static ssize_t nvmet_pci_epf_mdts_kb_show(struct config_item *item, char *page)
 	struct config_group *group = to_config_group(item);
 	struct nvmet_pci_epf *nvme_epf = to_nvme_epf(group);
 
-	return sysfs_emit(page, "%u\n", nvme_epf->mdts_kb);
+	return sprintf(page, "%u\n", nvme_epf->mdts_kb);
 }
 
 static ssize_t nvmet_pci_epf_mdts_kb_store(struct config_item *item,
-- 
2.43.7


