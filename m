Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D36C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:50:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1D7F2072E
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rYJTQYQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D7F2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pfqekc7mp0HBCr7B9xWBL9AW4I/1iP7cm6Mdu0vlLA0=; b=rYJTQYQNdL7PaJPIx7XewOhA4V
	L4ndEuPSYzezIpCIYOAJ6nqDW+PyPm/hFgg1R6n9gnJqm1MhzhoVH0qJGAXHvDkFftANLD8Jgpapu
	/0qiYWLxsxGjaKUb+gEi3xfvUOucktNjYr0eUREb+n3gRwSCWAdj7OW6umTPM+BC/obVCFEjPg4j6
	7+X3TMvBkCtaPGiNdLN0powNQy+obec/0c7F5MNgujY8gm5RolqnKEm1JrpIvzq2h+Obpxu49j9go
	XnvFfGcxz2SzxeyjDIypApiLDyVY21Fja66zn3tp3BTGEkE5ZhT1eCsJqh44Fc1xkPI1aluTl/jME
	9KS8lgXw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnzEf-0006KU-0o; Wed, 24 Jun 2020 06:50:17 +0000
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnzEZ-0006Hv-RB
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 06:50:13 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e07488;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0U0Zd2IT_1592981407; 
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0U0Zd2IT_1592981407) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 24 Jun 2020 14:50:07 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH v2 2/2] nvme: Use USEC_PER_SEC instead of magic numbers
Date: Wed, 24 Jun 2020 14:49:58 +0800
Message-Id: <440d84877c3bc0917790466ee85753919fb29cb5.1592980985.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1592980985.git.baolin.wang@linux.alibaba.com>
References: <cover.1592980985.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1592980985.git.baolin.wang@linux.alibaba.com>
References: <cover.1592980985.git.baolin.wang@linux.alibaba.com>
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
Cc: baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
 baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Use USEC_PER_SEC instead of magic numbers to make code more readable.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f5f882f..405bafa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2967,7 +2967,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 
 	if (id->rtd3e) {
 		/* us -> s */
-		u32 transition_time = le32_to_cpu(id->rtd3e) / 1000000;
+		u32 transition_time = le32_to_cpu(id->rtd3e) / USEC_PER_SEC;
 
 		ctrl->shutdown_timeout = clamp_t(unsigned int, transition_time,
 						 shutdown_timeout, 60);
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
