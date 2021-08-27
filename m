Return-Path: <SRS0=9COT=NS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C384C432BE
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Aug 2021 19:20:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C43C2600CD
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Aug 2021 19:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C43C2600CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TNHp3KeNnVLe2ZwD4ZORx56tVZ1jluy37Am1zUZBsIg=; b=Gp50Ap1T2NYp+4
	FGs8Fp5XFT5y7YFrvia/HNRqA29HlKz8ayZdrLQ094Y6ux173IMtPiqWeIMmYH7HRPw2Onu8zF8Y6
	gEeDJxrShf+0O0adYTpFMV4MHBVvgz/80uKjgT5BCd1An47whkDfEgMd1IbYD7VZOSmlufogqARmG
	8fiXpFz5vcYfr5jU++gX93yUPlYZPdshPhA6Nw8h8YXGlOm8ANBsdC+r+DJfYXMYajC0WJpYf48rf
	tVfNt6C2ZTx1Ugl321rdfPzTPp6V+Kn9mjZX/W2bowBiuD3Vm7bsNYdTUaUMRwNwqgCWnt4ATjVUK
	XLN1blwDlbWJCVpc+jTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mJhP2-00D6KE-B3; Fri, 27 Aug 2021 19:20:36 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mJhMh-00D5B9-Dv; Fri, 27 Aug 2021 19:18:11 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk, colyli@suse.de, kent.overstreet@gmail.com,
 kbusch@kernel.org, sagi@grimberg.me, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, dave.jiang@intel.com, ira.weiny@intel.com,
 konrad.wilk@oracle.com, roger.pau@citrix.com, boris.ostrovsky@oracle.com,
 jgross@suse.com, sstabellini@kernel.org, minchan@kernel.org,
 ngupta@vflare.org, senozhatsky@chromium.org
Cc: xen-devel@lists.xenproject.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-bcache@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 08/10] nvdimm/blk: add error handling support for add_disk()
Date: Fri, 27 Aug 2021 12:18:07 -0700
Message-Id: <20210827191809.3118103-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210827191809.3118103-1-mcgrof@kernel.org>
References: <20210827191809.3118103-1-mcgrof@kernel.org>
MIME-Version: 1.0
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

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

Since nvdimm/blk uses devm we just need to move the devm
registration towards the end. And in hindsight, that seems
to also provide a fix given del_gendisk() should not be
called unless the disk was already added via add_disk().
The probably of that issue happening is low though, like
OOM while calling devm_add_action(), so the fix is minor.

We manually unwind in case of add_disk() failure prior
to the devm registration.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/nvdimm/blk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
index 591fa1f86f1e..9f1eb41404ac 100644
--- a/drivers/nvdimm/blk.c
+++ b/drivers/nvdimm/blk.c
@@ -265,7 +265,9 @@ static int nsblk_attach_disk(struct nd_namespace_blk *nsblk)
 	}
 
 	set_capacity(disk, available_disk_size >> SECTOR_SHIFT);
-	device_add_disk(dev, disk, NULL);
+	rc = device_add_disk(dev, disk, NULL);
+	if (rc)
+		goto out_before_devm_err;
 
 	/* nd_blk_release_disk() is called if this fails */
 	if (devm_add_action_or_reset(dev, nd_blk_release_disk, disk))
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
