Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB06AC531D0
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 04:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uQWVHCKQec6ohoATCm3OB3r8yeaBn/4/MvS8nv9iLiY=; b=0lxE3zU7aEbPXuJl4pcYIcFwXL
	8d6eDeu5y9fbENZbtTkl5+8BDJRb72x/G+Y1KOyPaFa5L1b2pJ9KtSclba/Jl0a4XsHhC5O6asGkF
	nJ1UmoZz3GYCSUm+EciXbGSW4NLV4hk2NnVU1k3G1OuIRIp91IAhe7FBctqmg55F2UPJ4Y619bNlj
	KnK1W8QD9KiXNtdt3ENexjKWidw8LwuPBDOLMe0gTPYF+rDTpEqp2QviuAGKmLFSVwQf6Cn5xVSlP
	BYvQsLOug6RxPWXojcfzIz6+6aGKHGUdBs+dhMYvD0yyU0S7GJ7U/uecnmhMSWE7VXFibjsjzsV0H
	ACWwbrfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpIQU-00000009TpE-1q69;
	Thu, 30 Jul 2026 04:31:22 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpIQS-00000009TkA-00Qv
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 04:31:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785385873; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=uQWVHCKQec6ohoATCm3OB3r8yeaBn/4/MvS8nv9iLiY=;
	b=EOJ/EjDcekZZxfFbGeJPJouoz9cE+Q/kwZtYhq8r+JJ8P15tYfwkQLaMB01WKFtZCttWEaN/kdMn3CX5AL9MwapTcuyD/PMQVSkSYrMAXwu3lmziaw2j7u2S1y1YDpXb1RRssnlKgs9+1ciUbQ8aBat7kWPQJX+XxZQQHKF7SLA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X83rcPb_1785385872;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X83rcPb_1785385872 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 30 Jul 2026 12:31:12 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 2/4] nvmet: propagate percpu_ref_init() failure in nvmet_ns_enable()
Date: Thu, 30 Jul 2026 12:31:03 +0800
Message-ID: <20260730043105.3071328-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260730043105.3071328-1-kanie@linux.alibaba.com>
References: <20260730043105.3071328-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_213120_212191_3ADF04EF 
X-CRM114-Status: GOOD (  11.09  )
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

The return value of percpu_ref_init() is discarded. At this point ret is
0 from the preceding successful steps, so when the allocation inside
percpu_ref_init() fails the code jumps to the out_pr_exit cleanup chain
which ends with "return ret", i.e. reports success. The configfs enable
store then tells userspace the namespace was enabled even though it was
not and its backing device has already been torn down.

Capture the return value so the failure is propagated.

Fixes: 408232680707 ("nvmet: Fix crash when a namespace is disabled")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 4477c4d6b1ee..c8e01dda4121 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -610,7 +610,8 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 			goto out_dev_put;
 	}
 
-	if (percpu_ref_init(&ns->ref, nvmet_destroy_namespace, 0, GFP_KERNEL))
+	ret = percpu_ref_init(&ns->ref, nvmet_destroy_namespace, 0, GFP_KERNEL);
+	if (ret)
 		goto out_pr_exit;
 
 	nvmet_ns_changed(subsys, ns->nsid);
-- 
2.43.7


