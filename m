Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21542C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Dec 2022 08:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+ci5bcUIbLGxQVgLgfmHm24kEGwwT3UbgpEsz57UQFg=; b=GXMIYngtsyDtPkyEHfhO8WYY22
	glK+QyoYo2bCKqK6gV9WeXKsE2J5yddxRZQ8klnLksxsVhhc3aAVKFNrgJZBpCmsSUCciJIJd8fXn
	cSXUgrChDTojJmdvF04kN3z7t5sS/tVKFNBwFxDQ+9MO4oqfboLGnP++R5FgU8a9+MUKo/roQnhkD
	gIj74q70aU0l4fg6hx7ZOR3oFzAKBggdoPdKon5wmzMJ+DNSKW+/2wMZyQyZCXem1fqEoZBTYohVd
	PSoaknhc/63EpYk/ZK81T4B1nGRIAM5LnTPL8t2lJugNITgdQdS67tXamrWIImRpYFNCIjxBz3QoX
	rxt4SpDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7uMe-00C65l-Um; Wed, 21 Dec 2022 08:22:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7uM3-00C5iv-RO
	for linux-nvme@lists.infradead.org; Wed, 21 Dec 2022 08:21:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BFFC267373; Wed, 21 Dec 2022 09:21:31 +0100 (CET)
Date: Wed, 21 Dec 2022 09:21:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: zhangyanjun@cestc.cn
Cc: sagi@grimberg.me, axboe@kernel.dk, kbusch@kernel.org, axboe@fb.com,
	hch@lst.de, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] nvme: fix multipath crash caused by flush request
 when blktrace is enabled
Message-ID: <20221221082131.GA23644@lst.de>
References: <20221220063233.43932-1-zhangyanjun@cestc.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220063233.43932-1-zhangyanjun@cestc.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221221_002136_106142_863D7342 
X-CRM114-Status: GOOD (  10.66  )
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

Just checking for ->bio seems to be:

 - simpler
 - faster

and does not require block layer internals.  So why not just this:


diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 6bbb73ef8b2548..424c8a467a0c2a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -893,7 +893,7 @@ static inline void nvme_trace_bio_complete(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
 
-	if (req->cmd_flags & REQ_NVME_MPATH)
+	if ((req->cmd_flags & REQ_NVME_MPATH) && req->bio)
 		trace_block_bio_complete(ns->head->disk->queue, req->bio);
 }
 

