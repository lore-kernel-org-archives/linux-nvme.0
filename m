Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC10D5E142
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 07:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MxLKEb8U0nJwpV2JiJjfUCSQymoraoaOwVc4GleCs6o=; b=IkaycBCxn808Llc6XVsfdw7D+a
	eS4OuLKS6UVRRdBvy5x4FrZWbPXrMxuz1cdr4l6R+DqOzCs0ChoQemcMqyJ9QDrZipHKAEpRh1J3l
	mPG67w6tNRgXrC5hKbNu96SDS59SMKHBhJ4UUhGvS7y0hojSM/dvOifpSIu2XoKl2m9vVQGVvoXi1
	KddYvhWS9S3NVrjCO91bgjjTT72GTLMIwY8AB0Qqp24G98S5B7HmbvIrQk/XsbK63mcTUYbd8iHWL
	JP7Zz21NXzYH3O6wIpj6clPlsqP3QBx/AfSoeKtgsnpoXHACKlQuRNxs+eYWUsbCxSrtxay1o+eO/
	WwtdR1Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9J7W-00000009aQx-2AUO;
	Fri, 08 Nov 2024 07:09:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9J7S-00000009aO2-1z5I
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 07:09:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 356B168AFE; Fri,  8 Nov 2024 08:09:18 +0100 (CET)
Date: Fri, 8 Nov 2024 08:09:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: max_hw_zone_append_sectos fixes
Message-ID: <20241108070918.GB9216@lst.de>
References: <20241105154817.459638-1-hch@lst.de> <bfc380c1-c198-4a41-97f7-f286e3692879@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfc380c1-c198-4a41-97f7-f286e3692879@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_230922_734853_3005917B 
X-CRM114-Status: GOOD (  16.51  )
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

On Thu, Nov 07, 2024 at 03:35:14PM -0700, Jens Axboe wrote:
> On 11/5/24 8:48 AM, Christoph Hellwig wrote:
> > Hi Jens,
> > 
> > this series has a fix and a cleanup for the max_hw_zone_append_sectors
> > change.
> > 
> > Diffstat:
> >  block/blk-settings.c          |    2 +-
> >  drivers/nvme/host/multipath.c |    2 --
> >  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> Given the recent revert, will you respin the parts that makes sense?

The first one should just be kept as-is.  But I can resend it separately
justto be clear.


