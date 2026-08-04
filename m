Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7097EC55AB9
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2026 02:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mFKLdaOEWpda6Q8r2IYTuVI/GPVcwVZsYb7JTkqmhiQ=; b=U5BZKv/5XHCslkeQ8f9pHZr1N5
	iQOQgLI3LfHP+srheUsnxT+dQUywWSdgeoiFFiZc196UhzS8Y9E6xS/LL6x8yoVOznx2NZBoIk/JR
	g3HEd7JwLbCOK4pzk/TlDInznryHI8QIJmwi5MoY7OvxH4AzO0wwN8gMCCp+ycSP9XXoKiEJADcY0
	oPsmkoFGywYzsp62aHowkTMFSNZi+OE4PukpZmPU7+Eo+AC668TwRJimDEZYcPPuQhNqipNrtcKlT
	U+lSfDVQiop7//d+b1j9t5URcly+BpH5LjkgNygAKPw32Mzx5iUBehfIdqS7J5gtHoMYBDHJi7p0i
	WF9BGnWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr4kQ-00000000pLx-1alT;
	Tue, 04 Aug 2026 02:19:18 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr4kM-00000000pJ2-11mz
	for linux-nvme@lists.infradead.org;
	Tue, 04 Aug 2026 02:19:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785809949; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=mFKLdaOEWpda6Q8r2IYTuVI/GPVcwVZsYb7JTkqmhiQ=;
	b=rJ4o9sfr/Rxd43p83tg21E0vtK3v3PI1zBZ64UiidZwyLKV+/QS3Up5eFpYsNV6ob4vbIrg+4PXoqnw5oc4hdXnn+9dn3ysb2AYDRYRkQToh2eV5vUVuQYudvrOc0/9vdcufOa1KT6Vaefd53IkvdX0S2pfKlk8GKr4hoEYWlYw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X8MEQ0e_1785809947;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8MEQ0e_1785809947 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 04 Aug 2026 10:19:08 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	nilay@linux.ibm.com,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3 2/5] nvmet: propagate percpu_ref_init() failure in nvmet_ns_enable()
Date: Tue,  4 Aug 2026 10:18:58 +0800
Message-ID: <20260804021901.3777326-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260804021901.3777326-1-kanie@linux.alibaba.com>
References: <20260804021901.3777326-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260803_191915_201867_DE4AB267 
X-CRM114-Status: GOOD (  11.80  )
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
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


