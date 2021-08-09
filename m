Return-Path: <SRS0=jKil=NA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C055FC4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 06:46:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8253B60462
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 06:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8253B60462
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8vbUPmmxK9l0AUrrVG6LoR5817lNzL0UZBqgIEZE+MQ=; b=OqkSxLLfGDRU78
	IiLy+m7zhRxsO0HjRXdNL6w8Y4FHlbdZcun/TKYD2w9v+fI3+kBTVhPb1DNcP3owDt+QS3Wnmt3lS
	8hZqyONHn1z3gbkUwKHB93QiKsH/WPbwORbR5AtOmjIrsZ0YSU+l/TSwepFb3ESaaNrFOiDvNlIdC
	Nqw/RA+yUPicW8tZ9DEvZvSaSVXOgNBkysaTE3sTV3uQxKJi4xoSL9p+zY1oJq7O6eGXL2t+zzl9D
	yHhpYPTwe7lNOWQlpy8D4qpdkxgLrjXy/OOqmULIEOGKNGa765b6pwmUiKxiNWh96/vUxVTFBaxXB
	XpX2mP/vlP7Ciz0ajpmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mCz3C-00HHTo-Hi; Mon, 09 Aug 2021 06:46:18 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mCz3A-00HHSw-Lb
 for linux-nvme@bombadil.infradead.org; Mon, 09 Aug 2021 06:46:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=2PUg8TD54X+a+8A8rMLEejxIQ+qkWq2AjkJmKrVeDxw=; b=b4tOoPmwQd+crYJCpCx1iG9g4l
 RlE6R1qccfuDeNqWl0NCLbSrEpI8/o22zI/ri0UPqsR/LvTzcdz+rDSB/AMzXpoYVgv4UcyfeZCKg
 ZtEq5VNw8F/j/hQfVA+AZ6LP4rXNKRBpeqcCuC3Mwr08Hzlv4HRaR+d8viAlVr4qNU36T9vv0sEpz
 IuCHhcPqquilvquiiSWmGF1DD7w5DEtzpjQi7uYEODw7XOGbguvZ2zk6TKZewHJ0DgYwuCZ6ILeV4
 m2ypujmPZIeZjyHNoc7Ig3yIxz2Utee3+rA5P+44Zey8BhvISjqFHnlYYrzpGgePzxecsjxo6xQWV
 +Q0Xdqow==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mCz1y-00Aip9-5f; Mon, 09 Aug 2021 06:45:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Luis Chamberlain <mcgrof@kernel.org>,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCH 5/8] sx8: use the internal state machine to check if
 del_gendisk needs to be called
Date: Mon,  9 Aug 2021 08:40:25 +0200
Message-Id: <20210809064028.1198327-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809064028.1198327-1-hch@lst.de>
References: <20210809064028.1198327-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

Remove usage of the block layer internal GENHD_FL_UP by just looking
at the host state.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/sx8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index 7b54353ee92b..420cd952ddc4 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -1373,7 +1373,7 @@ static void carm_free_disk(struct carm_host *host, unsigned int port_no)
 	if (!disk)
 		return;
 
-	if (disk->flags & GENHD_FL_UP)
+	if (host->state > HST_DEV_ACTIVATE)
 		del_gendisk(disk);
 	blk_cleanup_disk(disk);
 }
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
