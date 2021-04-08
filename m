Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10A3C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:20:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3058561106
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3058561106
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hEINNJHW+nUJcN107eQMPwzQHV13qwaaXxZsSvBDoOo=; b=Oa+e1NfWmrcq08SYoK2GtAWi4
	gca1F/PKPwc7wXIR5Y6UHS4DMfkp0MrshasZifBoQuFW2+LSIvT1WRVaKviWcpxgKDyXeef5RTaia
	5sYx/j0b0+Q4LtG34TRIY9X552INIu4Bv8aiCDmEuykcc7et8ceZpYCdNO1eSQnczhW8VKABkrltO
	YULhpzF0sxE+pRUhMYSmkpt76O4UygltXIODNndiKQ1iwBwQIeINDaLh43M2KQ7rgEnfgbFnHtbo9
	7txcPuKais19+8O6ppBG7QVX5bEX+35XtJOAO4b7hSajvbzqhmRGJscMKDC2U1lLUPRAfeOXzv9Xm
	4sdbtigrw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUTdo-007xO7-6m; Thu, 08 Apr 2021 12:20:08 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTdZ-007xKQ-Ih
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 12:19:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=TGhk8N/IEiG1QFZCYX/5lKwvQuq+vhkJC6PzD4p3LfQ=; b=j0IfHe88lifnhqNQ2YWoGQEIr2
 NLrGDeR2zts2doiUJ3+QdVyFJBc582u7wjw8Fg0jHq9l0sogjcaSuMMF7wBt3+0RTWxADE+nblRl8
 K1rEVhALmgzz270MT3ty7TJy5cN5iSeJVy11YU7RyeSnfSIcpLBoOGCagalEuJgC0riHoF0ruC+9y
 QTJTokV19aSlDzKg20Zxr0AcLXfM9DFjX9c5K9CcO0Fads4P2dXfdc5Xw0Krjkfd+6473aF5p3s0a
 6mZvm/v9zCPDM3AqqgyOWq5zBAVDJemVxcTuSgA1aC9bkjDfpUWrKcOAIXM9vYjPPWKF2wAf4hQmW
 HXOr5P3A==;
Received: from [2001:4bb8:188:4907:196e:5227:9015:fba2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTdV-00HATW-R5; Thu, 08 Apr 2021 12:19:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: [PATCH 05/13] nvme: simplify the compat ioctl handling
Date: Thu,  8 Apr 2021 14:08:34 +0200
Message-Id: <20210408120842.1450092-6-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210408120842.1450092-1-hch@lst.de>
References: <20210408120842.1450092-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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

Don't bother defining a separate compat_ioctl handler, and just handle
the NVME_IOCTL_SUBMIT_IO32 case inline.  Also only defined it for those
ABIs (currently just i386 vs x86_64) that are affected.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 69 +++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 43 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 56fe5b9712e756..1b80868e2539df 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1783,6 +1783,24 @@ static int nvme_handle_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
 	return ret;
 }
 
+#ifdef COMPAT_FOR_U64_ALIGNMENT
+struct nvme_user_io32 {
+	__u8	opcode;
+	__u8	flags;
+	__u16	control;
+	__u16	nblocks;
+	__u16	rsvd;
+	__u64	metadata;
+	__u64	addr;
+	__u64	slba;
+	__u32	dsmgmt;
+	__u32	reftag;
+	__u16	apptag;
+	__u16	appmask;
+} __attribute__((__packed__));
+#define NVME_IOCTL_SUBMIT_IO32	_IOW('N', 0x42, struct nvme_user_io32)
+#endif /* COMPAT_FOR_U64_ALIGNMENT */
+
 static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
 		void __user *argp)
 {
@@ -1792,6 +1810,14 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
 		return ns->head->ns_id;
 	case NVME_IOCTL_IO_CMD:
 		return nvme_user_cmd(ns->ctrl, ns, argp);
+	/*
+	 * struct nvme_user_io can has different padding on some 32-bit ABIs.
+	 * Just accept the compat version as all fields that are used are the
+	 * same size and at the same offset.
+	 */
+#ifdef COMPAT_FOR_U64_ALIGNMENT
+	case NVME_IOCTL_SUBMIT_IO32:
+#endif
 	case NVME_IOCTL_SUBMIT_IO:
 		return nvme_submit_io(ns, argp);
 	case NVME_IOCTL_IO64_CMD:
@@ -1828,47 +1854,6 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 	return ret;
 }
 
-#ifdef CONFIG_COMPAT
-struct nvme_user_io32 {
-	__u8	opcode;
-	__u8	flags;
-	__u16	control;
-	__u16	nblocks;
-	__u16	rsvd;
-	__u64	metadata;
-	__u64	addr;
-	__u64	slba;
-	__u32	dsmgmt;
-	__u32	reftag;
-	__u16	apptag;
-	__u16	appmask;
-} __attribute__((__packed__));
-
-#define NVME_IOCTL_SUBMIT_IO32	_IOW('N', 0x42, struct nvme_user_io32)
-
-static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
-		unsigned int cmd, unsigned long arg)
-{
-	/*
-	 * Corresponds to the difference of NVME_IOCTL_SUBMIT_IO
-	 * between 32 bit programs and 64 bit kernel.
-	 * The cause is that the results of sizeof(struct nvme_user_io),
-	 * which is used to define NVME_IOCTL_SUBMIT_IO,
-	 * are not same between 32 bit compiler and 64 bit compiler.
-	 * NVME_IOCTL_SUBMIT_IO32 is for 64 bit kernel handling
-	 * NVME_IOCTL_SUBMIT_IO issued from 32 bit programs.
-	 * Other IOCTL numbers are same between 32 bit and 64 bit.
-	 * So there is nothing to do regarding to other IOCTL numbers.
-	 */
-	if (cmd == NVME_IOCTL_SUBMIT_IO32)
-		return nvme_ioctl(bdev, mode, NVME_IOCTL_SUBMIT_IO, arg);
-
-	return nvme_ioctl(bdev, mode, cmd, arg);
-}
-#else
-#define nvme_compat_ioctl	NULL
-#endif /* CONFIG_COMPAT */
-
 static int nvme_open(struct block_device *bdev, fmode_t mode)
 {
 	struct nvme_ns *ns = bdev->bd_disk->private_data;
@@ -2356,7 +2341,6 @@ EXPORT_SYMBOL_GPL(nvme_sec_submit);
 static const struct block_device_operations nvme_bdev_ops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= nvme_ioctl,
-	.compat_ioctl	= nvme_compat_ioctl,
 	.open		= nvme_open,
 	.release	= nvme_release,
 	.getgeo		= nvme_getgeo,
@@ -2385,7 +2369,6 @@ const struct block_device_operations nvme_ns_head_ops = {
 	.open		= nvme_ns_head_open,
 	.release	= nvme_ns_head_release,
 	.ioctl		= nvme_ioctl,
-	.compat_ioctl	= nvme_compat_ioctl,
 	.getgeo		= nvme_getgeo,
 	.report_zones	= nvme_report_zones,
 	.pr_ops		= &nvme_pr_ops,
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
