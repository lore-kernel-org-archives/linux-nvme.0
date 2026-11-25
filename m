Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1738606A32C
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 06:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4YOyixR0;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kl7D4D8a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=GV3Y3tNRTvYw1Ue9coRq0XGjKZ6SrLWwf7MPhaXizbk=; b=4YOyixR0GOyRiC
	a5ZO0RVx6jNUBCG6C10DEWdMvFsS7MvIclraYTKkoMd2OsDrDtqu+ptElPeLNXDaa8y4OJ/lnjXaq
	BcoSbmUC2rkgBGNK1uh1fGV9C9F9L4X00PBa9q3qNYtU5U+L9jr6ZBecs5b9R7RDfpd7vViEqzPvp
	mxOsdaX6CYlOS64XKEJz2Qmbo37Zw+qoO0lbkhruz8DrZjXreVqEsMKqDqYA5Ck1H3/fk0xilm3gd
	xy0kpz2QSyBnDm/53NjjQ9AG0+3bRdkG3lVzkwt1pjwtJL2wYCDjU9iapqrtYtho1lAOwPmVUOQJa
	t4145UlVrU1dn1FQCLJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW6Hy-00000008Y5O-1WDa;
	Wed, 25 Nov 2026 06:15:30 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW6Hv-00000008Y2a-0tIX
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 06:15:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795587325; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GV3Y3tNRTvYw1Ue9coRq0XGjKZ6SrLWwf7MPhaXizbk=;
	b=kl7D4D8aLK9Btjf/JnZxYSJeYRupD3eMJzQnBlZlvRcbpr/2PpxpD9ZV/IypRidOUq5KdXXMED9qjNF9DGu8P45aVKIY4jI2Y+c7pheF/AiIU23e/Nscoxe4vijMQOmV1ONYb9gCUCAfJlLojR2XtVjzNjt0tuKB5WGgFcSLZ3A=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XFQgjit_1795587324;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XFQgjit_1795587324 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Nov 2026 14:15:24 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v5 2/3] nvme: define the SMART / Health Status async event subtypes
Date: Wed, 25 Nov 2026 14:15:21 +0800
Message-ID: <20261125061522.231591-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261125061522.231591-1-kanie@linux.alibaba.com>
References: <20261125061522.231591-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_221527_427020_659CAC62 
X-CRM114-Status: UNSURE (   8.03  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the asynchronous event information values of the SMART / Health
Status event type (NVMe 2.x, Figure 154) alongside the notice subtypes.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 include/linux/nvme.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 6248711784b37..66fcd5a160684 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -859,6 +859,12 @@ enum {
 	NVME_AER_ERROR_PERSIST_INT_ERR	= 0x03,
 };
 
+enum {
+	NVME_AER_SMART_RELIABILITY	= 0x00,
+	NVME_AER_SMART_TEMP_THRESH	= 0x01,
+	NVME_AER_SMART_SPARE_THRESH	= 0x02,
+};
+
 enum {
 	NVME_AER_NOTICE_NS_CHANGED	= 0x00,
 	NVME_AER_NOTICE_FW_ACT_STARTING = 0x01,
-- 
2.43.7


