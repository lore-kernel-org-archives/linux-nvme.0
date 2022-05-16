Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D95C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 16 May 2022 12:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oW6Y62S6PfRtn17YzO3FMpoA4HnBO4KUSLl4uZTVxkw=; b=tXd4TGHZuxDBSbVDYrXJ5lDkCB
	R8bLLIsJ0uZR7zKKGfZLVhjqTMSwPUT+vZp0g4IEDeqH7b2nq4dTe/kYvXLUkMYvKSEpR/22vRMlp
	sAGpf2+n/M91hh1KxUuBHzBFB5JSA4HYzHL/odu3bN5IlKUeyaFtc0ycCAbALdU9YVyEnH2+KVoRU
	19w3aXLiaNrRpUg0d4AKp4iN987UXw8MFGG2ax8jR8vJ/QJ+qJvWokUXXOR883SFv6umkk8fNVrEE
	fXIkLXOVBz7AJpPswONKqAdqV1oduFeC92U9dRKw2KL2J4JtlMSax0fFEuMhjf+5nZ7deFziIZHn4
	RfjAkJ3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqaHp-007mN4-9s; Mon, 16 May 2022 12:57:21 +0000
Received: from 213-225-7-200.nat.highway.a1.net ([213.225.7.200]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqaDd-007k5J-IC; Mon, 16 May 2022 12:53:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: sagi@grimberg.me,
	kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: split the enum used for various register constants
Date: Mon, 16 May 2022 14:52:58 +0200
Message-Id: <20220516125258.2800718-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Instead of having one big enum add one for each register or field.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/nvme.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index bbabdc7600da6..5f6d432fa06a6 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -204,8 +204,9 @@ enum {
 	NVME_CC_SHN_MASK	= 3 << NVME_CC_SHN_SHIFT,
 	NVME_CC_IOSQES		= NVME_NVM_IOSQES << NVME_CC_IOSQES_SHIFT,
 	NVME_CC_IOCQES		= NVME_NVM_IOCQES << NVME_CC_IOCQES_SHIFT,
-	NVME_CAP_CSS_NVM	= 1 << 0,
-	NVME_CAP_CSS_CSI	= 1 << 6,
+};
+
+enum {
 	NVME_CSTS_RDY		= 1 << 0,
 	NVME_CSTS_CFS		= 1 << 1,
 	NVME_CSTS_NSSRO		= 1 << 4,
@@ -214,10 +215,18 @@ enum {
 	NVME_CSTS_SHST_OCCUR	= 1 << 2,
 	NVME_CSTS_SHST_CMPLT	= 2 << 2,
 	NVME_CSTS_SHST_MASK	= 3 << 2,
+};
+
+enum {
 	NVME_CMBMSC_CRE		= 1 << 0,
 	NVME_CMBMSC_CMSE	= 1 << 1,
 };
 
+enum {
+	NVME_CAP_CSS_NVM	= 1 << 0,
+	NVME_CAP_CSS_CSI	= 1 << 6,
+};
+
 struct nvme_id_power_state {
 	__le16			max_power;	/* centiwatts */
 	__u8			rsvd2;
-- 
2.30.2


