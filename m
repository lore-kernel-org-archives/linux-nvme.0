Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBE5CDE008
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 06:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EECnjrJMvIlQIrX5X6/8THYeCQNaGqWPUOKjgzCIc+0=; b=bvffkEtAd+nsOIxzKKs6aSpQTs
	is4MYwqLYiM9eaCqGL1y+Z1eUX1zwhzwwPItFbw0/DPS7RsELAkDtE42gtDNq7B1OEQnOrLV79z0P
	ODK6o5NazMyq4OSEXpsDoRhrprWFMdp8+RxJkE4ZPAYKXOB0npkKK9iJTV57QkoRU63xlPM3AoK4b
	8Sjbdov1XJ+kRtC/2cVxuPuPky8HbLUQsP/E6vVgUGhnGbrmmVEldX0SErDWjBl6yZdqvxYiOiVeP
	g2M2+y497npvrEigeHZHSTIOnqEeqVrQfb+GSVUJ2hF2tpgFH1kwXJ9rU3GzBLBTZfsE68jAhZ90F
	xNrOi9Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd0C9-0000000AbiX-2QDx;
	Fri, 26 Jun 2026 06:37:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd0C7-0000000AbiC-0z64
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 06:37:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6431168C4E; Fri, 26 Jun 2026 08:37:38 +0200 (CEST)
Date: Fri, 26 Jun 2026 08:37:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com
Subject: Re: [PATCHv2 04/17] nvme: add Clang context annotations for
 nvme_ns_head::requeue_list
Message-ID: <20260626063738.GD10731@lst.de>
References: <20260614131541.2017845-1-nilay@linux.ibm.com> <20260614131541.2017845-5-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614131541.2017845-5-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_233743_445352_3A6428EB 
X-CRM114-Status: GOOD (  12.58  )
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

> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index a275c03e7c59..9e7f12fe8cd6 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -706,8 +706,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>  	struct queue_limits lim;
>  
>  	mutex_init(&head->lock);
> -	bio_list_init(&head->requeue_list);
> -	spin_lock_init(&head->requeue_lock);
> +	scoped_guard(spinlock_init, &head->requeue_lock)
> +		bio_list_init(&head->requeue_list);

We had that discussion before, but this kind of annotation is just
idiotic :(

We really to be able to just initialize fields without annotations
before they are first published.  Now bio_list_init is actually a no-op
on a zero-allocated structure, so we could just drop it here, but this
is a more general problem.


