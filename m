Return-Path: <SRS0=DaKL=5S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C169C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 19:31:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D5C12078E
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 19:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RWECCeIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5C12078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qs8bxBqGp3HXkHOVXUMFgB6cuk4Aq+XeyK6nJeplJHc=; b=RWECCeIyYFtSqt
	lS8qlyVY/CZ91DWO8gxLtUnqet3rZS7O3Ic/pa3Ueyhb9n/WAam1UTuZHZfpBVbdU62WKtcaeuVXF
	f5LE3XOXsaHug+HTfCEhzrl9je4E3KziciYP5tI/hqFPXK/tUFOb4bRStvr6ff8rdysYMe6ALeHww
	julPry5x2dwUCYX7PfdIxiWQWGHOTnwSlRdKxOXvqVYJn4IL4EcrLjucRKNscMR1xKq3+eA16+CFf
	WXfhaYafggGeCiIlfwTlfiSoka91uap/q122jfa80unwczP3I8FXYetz+AaS47CyOrlgXewSQ+Hc8
	QaqoBW7CUPLSEC4jwhnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jK5Yg-0001uR-0E; Thu, 02 Apr 2020 19:31:22 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jK5Yd-0001tg-80
 for linux-nvme@lists.infradead.org; Thu, 02 Apr 2020 19:31:21 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A8C07AEC2;
 Thu,  2 Apr 2020 19:31:13 +0000 (UTC)
From: Anthony Iliopoulos <ailiop@suse.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] nvmet: add revalidation support to bdev and file backed
 namespaces
Date: Thu,  2 Apr 2020 21:30:52 +0200
Message-Id: <20200402193052.19935-1-ailiop@suse.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200402_123119_428864_DFD87B83 
X-CRM114-Status: GOOD (  12.59  )
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
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add support for detecting capacity changes on nvmet blockdev and file
backed namespaces. This allows for emulating and testing online resizing
of nvme devices and filesystems on top.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 drivers/nvme/target/admin-cmd.c   |  5 +++++
 drivers/nvme/target/io-cmd-bdev.c | 10 ++++++++++
 drivers/nvme/target/io-cmd-file.c | 14 ++++++++++++++
 drivers/nvme/target/nvmet.h       |  2 ++
 4 files changed, 31 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 9d6f75cfa77c..4c79aa804887 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -486,6 +486,11 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	if (!ns)
 		goto done;
 
+	if (ns->bdev)
+		nvmet_bdev_ns_revalidate(ns);
+	else
+		nvmet_file_ns_revalidate(ns);
+
 	/*
 	 * nuse = ncap = nsze isn't always true, but we have no way to find
 	 * that out from the underlying device.
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index ea0e596be15d..1f8c00d68aa9 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -75,6 +75,16 @@ void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
 	}
 }
 
+void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)
+{
+	loff_t size;
+
+	size = i_size_read(ns->bdev->bd_inode);
+
+	if (ns->size != size)
+		ns->size = size;
+}
+
 static u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
 {
 	u16 status = NVME_SC_SUCCESS;
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index cd5670b83118..c102437db72a 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -80,6 +80,20 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 	return ret;
 }
 
+void nvmet_file_ns_revalidate(struct nvmet_ns *ns)
+{
+	struct kstat stat;
+
+	if (!ns->file)
+		return;
+
+	if (vfs_getattr(&ns->file->f_path,
+			&stat, STATX_SIZE, AT_STATX_FORCE_SYNC))
+		return;
+
+	ns->size = stat.size;
+}
+
 static void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg)
 {
 	bv->bv_page = sg_page(sg);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 421dff3ea143..8b479d932a7b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -498,6 +498,8 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns);
 u16 nvmet_bdev_flush(struct nvmet_req *req);
 u16 nvmet_file_flush(struct nvmet_req *req);
 void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
+void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns);
+void nvmet_file_ns_revalidate(struct nvmet_ns *ns);
 
 static inline u32 nvmet_rw_len(struct nvmet_req *req)
 {
-- 
2.26.0


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
