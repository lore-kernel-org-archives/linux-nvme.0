Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978ABC55167
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 03:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mFKLdaOEWpda6Q8r2IYTuVI/GPVcwVZsYb7JTkqmhiQ=; b=D+/URDxXhNpNmF21FPdl3YD2Qe
	FoHj+a+On07q7laT0NWNmYIyXbICwvSIVAgmyyIWWONhBEi6wkyKPjpeoK+Bmd6atCLi5xNWxa03C
	y1p59kjqy5931fwIe3edadC8LFfxdOhVbR8LTHRqdANdlOq6MFKxvzN/SXVHAiLDdp2sCRUlOo9xo
	l+PUJE5bQpfR9uA3mxMZyqXziI5XPiIQyzhzmid+bzfaJYXwpnNhDzvunuKXH8nOH/cWQeRPseXA9
	cBEq5hcbpugvvqlHxBD6C24pchy4o9kcgRPkGpxkgg4afNkzLoJgxKyu2dcJjMyaNOI4ptb8gNRkb
	JTgvcGcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpdnk-0000000BfhN-42mU;
	Fri, 31 Jul 2026 03:20:48 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpdnf-0000000Bfeh-2WXK
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jul 2026 03:20:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785468039; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=mFKLdaOEWpda6Q8r2IYTuVI/GPVcwVZsYb7JTkqmhiQ=;
	b=b1TBq3n/3MdUU0TBHNl1T/Cehe92B6FUvsjkbQaC962aZx0ip7DmTyA1wsnl6TLeDTcasWOhDoaBYSmq3kUXllFHBkTXXTceXYFgUumbjc9SNNcoLiroGg/OlWqr5AVG+hNF/DNd69h0hBY0idASFiB/9YkB6iJSENylEWYPM1g=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X86jPlV_1785468038;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X86jPlV_1785468038 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 31 Jul 2026 11:20:38 +0800
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
Subject: [PATCH v2 2/5] nvmet: propagate percpu_ref_init() failure in nvmet_ns_enable()
Date: Fri, 31 Jul 2026 11:20:28 +0800
Message-ID: <20260731032031.1090755-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260731032031.1090755-1-kanie@linux.alibaba.com>
References: <20260731032031.1090755-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_202044_131904_ED65EAA8 
X-CRM114-Status: GOOD (  11.71  )
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


