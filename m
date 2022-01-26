Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D8DC2BA4C
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jan 2022 05:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J1F7j6+C8DXHO5fhIXVaDrpLS8SUodnhoTv2SytMx5E=; b=knsCKwO3ykRTO5i88EYqP56r0V
	T9rIPlTqya/u7dEUG/lNP/mB0//+s4Lq6qh3iQbm1oWUB0JHC3UdG51U9QUtUcDlPkEiUXi8nEMmj
	YWvYULq2sCvc36mAeZK19NPRKferZRTRzb4+t4CH16p7ay1Zmj64F/Wr7O2AxjPXpdHZG4o5OCNFz
	hCSIUdjw+gOQ6EsU2OTvYvAkZLcXGgUrUvLABjzEsxN0kmXnXRi3Di9kq/AabOZWRxnsDA2NsNTiv
	Rx2MDn5CZzHxal5fdKeBHb43YUJ8pUpGHLdTbFpB8yyrhRuJBZoSEv5kmpxVDmHtJGapWi+VLsiIz
	gI7eWzlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCbC8-00AE9t-Cc; Wed, 26 Jan 2022 05:50:12 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCbC5-00AE8y-Ok
 for linux-nvme@lists.infradead.org; Wed, 26 Jan 2022 05:50:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2E30867373; Wed, 26 Jan 2022 06:50:04 +0100 (CET)
Date: Wed, 26 Jan 2022 06:50:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH V2 05/13] block: only account passthrough IO from userspace
Message-ID: <20220126055003.GA21089@lst.de>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
 <20220122111054.1126146-6-ming.lei@redhat.com>
 <20220124130555.GD27269@lst.de> <Ye8xleeYZfmwA3D7@T590>
 <20220125061634.GA26495@lst.de> <20220125071906.GA27674@lst.de>
 <Ye++VmBkg0I8Lq8+@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye++VmBkg0I8Lq8+@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220125_215009_980888_F71C8F9C 
X-CRM114-Status: GOOD (  14.79  )
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

On Tue, Jan 25, 2022 at 05:09:42PM +0800, Ming Lei wrote:
> Follows another simple way by accounting all request with bio attached,
> except for requests with kernel buffer.

> -	else if (rq->q->disk)
> +	else if (rq->q->disk && rq->bio)
>  		rq->part = rq->q->disk->part0;

Most passthrough requests will have a bio, so you'll still use e.g.
the sd gendisk for sg request here.

I think the right way would be to just remove this branch entirely.
This means we only account bios with a block_device, which implies
they have a gendisk.

