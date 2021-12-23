Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4A2C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Dec 2021 06:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JLQtENMa33h3fhXhjaEWcG5M+qdt9we4ioRUz7Vq8sI=; b=sBESWiPaKkUPVeaPHE/00Nn7Z6
	AaYSSYYid42ECLiG02ngRJkfVvenKMFW1chS/Zo9rZ38GgRkL+xLEewhy1sd1gXJktDNkAaFMIpRf
	tmL4cYjum0W20dEAtjnG63jJ9lmDRSwYQ/2yS0ufivvwMVO2Jhv27BfcwOYM5gjXNt+QzEdc/q6U7
	O+hBy4JWw//LVJD4pFrEhoqQtE8J2sj/k6Z6KatirHTZKeyeC41SYmKBiD4ppFLwYOIXRbnBq0iex
	RtK00vd32wULQSSQwTnhcj6j86QqfHM+Rxd76pnPxCb0+z/n1uuD+gDoyqWs96j4v4OA3UtbEOQK1
	+Ljm1rMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n0HTG-00BvSN-4S; Thu, 23 Dec 2021 06:20:58 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n0HTD-00BvRz-TU
 for linux-nvme@lists.infradead.org; Thu, 23 Dec 2021 06:20:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4A01368B05; Thu, 23 Dec 2021 07:20:47 +0100 (CET)
Date: Thu, 23 Dec 2021 07:20:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me
Subject: Re: [PATCH] nvme/pci: fix queue_rqs list splitting
Message-ID: <20211223062047.GA3846@lst.de>
References: <20211222214159.1767965-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222214159.1767965-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211222_222056_143875_81197AD5 
X-CRM114-Status: GOOD (  13.69  )
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

On Wed, Dec 22, 2021 at 01:41:59PM -0800, Keith Busch wrote:
>  			/* detach 'req' and add to remainder list */
> +			struct request *next = rq_list_next(req);
> +
>  			if (prev)
> -				prev->rq_next = req->rq_next;
> +				prev->rq_next = next;
> +			else
> +				*rqlist = next;
> +
>  			rq_list_add(&requeue_list, req);
> -		} else {
> +
> +			if (prev)
> +				req = prev;
> +			else
> +				req = next;
> +		}
> +
> +		if (req) {
>  			prev = req;
> +			req = rq_list_next(req);
>  		}

This hunk absolutely needs to go into a helper instead of being open
coded in a driver.

