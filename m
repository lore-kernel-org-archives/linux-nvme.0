Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08B0D2F7E5
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 04:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H3twq65KwbkC14NyrNVydA8TIPcZBKQ37w3XAo2kteE=; b=WTNKVLwZCTD7ccuS+Ms9LK0WLb
	eBKLr7VnPcRMb3QolEr3pAhuOOgbGSOcRePS6ZjLXGNbK6CYSAIIsvSOMKrphrzUP+1EBgPbgDrVD
	0jHABwxFqV81GoeJON79WDBY8Rn5X0EZzx/D3z3zO+p6h4vG3o7IcA48LCSrS4d3NI2QX0Pw5HeGI
	M181Q6lxtQPn1SNGqzcAP17bJSekwTrzm/IemqAjbfnNJ593t6PX4BgaHEPabqWwvyuTREETb3cAM
	3nN03UvDxgqBKhNW6Sa4FfERO7Naz8QAstXG/dfd460EhynrV0i/GdPMDTL8Zw9hGaf4LgN+F15tI
	WYhocsqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1IR0-0000000DkGB-24mS;
	Thu, 17 Oct 2024 04:48:26 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1IQx-0000000DkEo-3baS
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 04:48:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729140501; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=H3twq65KwbkC14NyrNVydA8TIPcZBKQ37w3XAo2kteE=;
	b=ZSZKrMolPMync1pWQA4TdKvtMRcZXnEUZcAZAdOO9OxilsZpJ0ksWoZxE5R35VK8d2U/npiaazSUmEd/boxBbVkLkaixRI/1gcYBN7uijnUq5i9Txcr66DJjLfqvha6d1vRXWWVLxMDFWVqanvGt7DUOKrUm8+PCGbq8fjzhzWI=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WHJaFN5_1729140494 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 12:48:19 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	shinichiro.kawasaki@wdc.com,
	d.bogdanov@yadro.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v16 1/2] nvme: add reservation command's defines
Date: Thu, 17 Oct 2024 12:48:08 +0800
Message-ID: <20241017044809.122021-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241017044809.122021-1-kanie@linux.alibaba.com>
References: <20241017044809.122021-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_214824_134674_89469430 
X-CRM114-Status: UNSURE (   8.43  )
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

This is a preparation patch for NVMeOF target reservation
commands implantation.
Add the defines of reservation command, such as reservation log
and sub operations.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Tested-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/nvme.h | 68 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b58d9405d65e..44d048d68503 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -2037,4 +2037,72 @@ struct nvme_completion {
 #define NVME_MINOR(ver)		(((ver) >> 8) & 0xff)
 #define NVME_TERTIARY(ver)	((ver) & 0xff)
 
+enum {
+	NVME_AEN_RESV_LOG_PAGE_AVALIABLE	= 0x00,
+};
+
+enum {
+	NVME_PR_LOG_EMPTY_LOG_PAGE			= 0x00,
+	NVME_PR_LOG_REGISTRATION_PREEMPTED		= 0x01,
+	NVME_PR_LOG_RESERVATION_RELEASED		= 0x02,
+	NVME_PR_LOG_RESERVATOPM_PREEMPTED		= 0x03,
+};
+
+enum {
+	NVME_PR_NOTIFY_BIT_REG_PREEMPTED		= 1,
+	NVME_PR_NOTIFY_BIT_RESV_RELEASED		= 2,
+	NVME_PR_NOTIFY_BIT_RESV_PREEMPTED		= 3,
+};
+
+struct nvme_pr_log {
+	__le64			count;
+	__u8			type;
+	__u8			nr_pages;
+	__u8			rsvd1[2];
+	__le32			nsid;
+	__u8			rsvd2[48];
+};
+
+struct nvmet_pr_register_data {
+	__le64	crkey;
+	__le64	nrkey;
+};
+
+struct nvmet_pr_acquire_data {
+	__le64	crkey;
+	__le64	prkey;
+};
+
+struct nvmet_pr_release_data {
+	__le64	crkey;
+};
+
+enum nvme_pr_capabilities {
+	NVME_PR_SUPPORT_PTPL				= 1,
+	NVME_PR_SUPPORT_WRITE_EXCLUSIVE			= 1 << 1,
+	NVME_PR_SUPPORT_EXCLUSIVE_ACCESS		= 1 << 2,
+	NVME_PR_SUPPORT_WRITE_EXCLUSIVE_REG_ONLY	= 1 << 3,
+	NVME_PR_SUPPORT_EXCLUSIVE_ACCESS_REG_ONLY	= 1 << 4,
+	NVME_PR_SUPPORT_WRITE_EXCLUSIVE_ALL_REGS	= 1 << 5,
+	NVME_PR_SUPPORT_EXCLUSIVE_ACCESS_ALL_REGS	= 1 << 6,
+	NVME_PR_SUPPORT_IEKEY_VER_1_3_DEF		= 1 << 7,
+};
+
+enum nvme_pr_register_action {
+	NVME_PR_REGISTER_ACT_REG		= 0,
+	NVME_PR_REGISTER_ACT_UNREG		= 1,
+	NVME_PR_REGISTER_ACT_REPLACE		= 1 << 1,
+};
+
+enum nvme_pr_acquire_action {
+	NVME_PR_ACQUIRE_ACT_ACQUIRE		= 0,
+	NVME_PR_ACQUIRE_ACT_PREEMPT		= 1,
+	NVME_PR_ACQUIRE_ACT_PREEMPT_AND_ABORT	= 1 << 1,
+};
+
+enum nvme_pr_release_action {
+	NVME_PR_RELEASE_ACT_RELEASE		= 0,
+	NVME_PR_RELEASE_ACT_CLEAR		= 1,
+};
+
 #endif /* _LINUX_NVME_H */
-- 
2.43.0


