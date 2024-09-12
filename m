Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2F2EE6457
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 07:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6GxW4hfHD5hVAsmiDQyovcWNzS1mJAQPf5bO993KCU0=; b=l4Q/XjRyfRSBIp16o2ouzyhlRt
	sd95/TUDYWKo/LCYWwySLoL1dJQwwEQF9HlqchnLk+5Op8ltTPPZj9qs0eqYlRfN7r3fpnHXdF+Yc
	k1dvyX38X/EFYCk2Ipkm6b3NDVNBPtvomaRLR85jpkaWB1WV/Vw5VXHVT2YmBzaTJVj973rNhdXE3
	JvwugbE/k/zpmxQFsUrhLO5/xAj7KAEJLPBRze2xE/i/R2RI3kKG8a0aDqFo8knQwaHFPOhy0MPCT
	2ePCuuhDbNMpM6t4UgM/qDQNwwRi9fJyM3On5Jql0zpuDS8mI18LXp3nQy4k9yi0KEjWE79KBgrUc
	B0D1mHAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soeWz-0000000CF1F-1vfR;
	Thu, 12 Sep 2024 07:46:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soeWx-0000000CF0i-0Wh1
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 07:46:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EC0C468AFE; Thu, 12 Sep 2024 09:46:13 +0200 (CEST)
Date: Thu, 12 Sep 2024 09:46:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk, hch@lst.de,
	martin.petersen@oracle.com, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	sagi@grimberg.me
Subject: Re: [PATCHv4 10/10] blk-integrity: improved sg segment mapping
Message-ID: <20240912074613.GA8409@lst.de>
References: <20240911201240.3982856-1-kbusch@meta.com> <20240911201240.3982856-11-kbusch@meta.com> <ZuImbgYqqZzLZkho@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuImbgYqqZzLZkho@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_004619_329886_630AA3C0 
X-CRM114-Status: GOOD (  13.74  )
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

On Wed, Sep 11, 2024 at 05:23:26PM -0600, Keith Busch wrote:
> On Wed, Sep 11, 2024 at 01:12:40PM -0700, Keith Busch wrote:
> > @@ -102,6 +103,12 @@ int blk_rq_map_integrity_sg(struct request_queue *q, struct bio *bio,
> > +	 */
> > +	BUG_ON(segments > blk_rq_nr_phys_segments(rq));
> 
> Doh, this was mixed up with the copy from blk_rq_map_sg. It should say:
> 
> 	BUG_ON(segments > blk_rq_nr_integrity_segments(rq));
> 
> Question though, blk_rq_map_sg uses WARN and scsi used BUG for this
> check. But if the condition is true, a buffer overrun occured. So BUG,
> right?

That would be my preference, unless we manage to add a error return
condition.  Note that Linus seems to be on his weird anti-BUG crusade
again, though.

