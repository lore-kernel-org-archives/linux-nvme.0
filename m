Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8180AC77B7A
	for <linux-nvme@archiver.kernel.org>; Sat, 20 May 2023 04:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=asVVv/ZNjQ6Ex2sARFuNEahrZn1h1kAMZuHnRewycKk=; b=oYTJmaepo6pevR6JizrkHsYqsP
	F/qSXDwCe51ViBJ+Ro35r7pJOykDgXQHzTZQ5/BJcevWaUYYo4/T3rbOmuYhWnPr5ZQJFtugyOSul
	db4gHD3F1WcTutioiyJ5uvsmBIKADaJLv81KA2qXnXLSBRHfzmwxgdoiibMnMBG+JzwVLlpY9PBjN
	AOwy/KN5iPWoa+PPxmAt4yrpzdQfinYcG9S2VzmckEQOQXF+tZpkT0JSK3jPkejC+G1u9FL4H3eiQ
	GeCrOt9fSEfxhNsjqrWP1VjC0594iIEmdJVCQkHs3ZBiWo+Ml1nbAm6PXUcgS5XR+MQG7YpXcjpVH
	2Tjr16ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0EIW-000ga1-31;
	Sat, 20 May 2023 04:34:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0EIU-000gZU-24
	for linux-nvme@lists.infradead.org;
	Sat, 20 May 2023 04:34:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 98D4C68CFE; Sat, 20 May 2023 06:34:22 +0200 (CEST)
Date: Sat, 20 May 2023 06:34:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Costa Sapuntzakis <costa@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/3] nvme: check IO start time when deciding to
 defer KA
Message-ID: <20230520043422.GE31780@lst.de>
References: <20230518183311.3224326-1-ushankar@purestorage.com> <20230518183311.3224326-3-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518183311.3224326-3-ushankar@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230519_213426_827208_F4D3F140 
X-CRM114-Status: GOOD (  13.94  )
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

On Thu, May 18, 2023 at 12:33:10PM -0600, Uday Shankar wrote:
> +	WRITE_ONCE(ctrl->ka_last_check_time, jiffies);
> +	smp_wmb();
>  	ctrl->comp_seen = false;
>  	spin_lock_irqsave(&ctrl->lock, flags);
>  	if (ctrl->state == NVME_CTRL_LIVE ||
> @@ -1206,6 +1215,9 @@ static void nvme_keep_alive_work(struct work_struct *work)
>  	bool comp_seen = ctrl->comp_seen;
>  	struct request *rq;
>  
> +	WRITE_ONCE(ctrl->ka_last_check_time, jiffies);
> +	smp_wmb();

WRITE_ONCE only works when paired with READ_ONCE on the read size,
which I don't ee here.

smp_wmb always pairs with smp_rmb, which I don't see here either.  We
also require documentation explaining the pairing because it tends to
be non-obvious (unlike READ_ONCE/WRITE_ONCE that are paired to a
variable).  I also can't really see a reason for the barrier here,
but the comment would be the thing to convince the reviewer.

