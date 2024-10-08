Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACCACED270
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 06:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E+wiPnDwtOK+5GTTsnG32f2ytPdsPd4Xsn6ExuqBrr4=; b=1+KMAKFxfj8zr2H6ZeiVL7jnbg
	0bmWyeZVT243uhIqOAWMPd653uhJ/mbAKUT9Q4aq9LDgrpDHfz+Xt7We2nUV71bFs//KTdS5Agawj
	E1sxB3+NeK92Eo+RJjkMGQymfqrsQGZ4jHwcpMgp3Ppn4zjbawFYD1aY2nWhkXLWKZjDVUs5mX0AM
	j3kn+scRcR6llYb0qpy+bFc3SmRywVVzbjcItfBVVfhrW7nZXITswm14bv/d1Nzfmgh83Hp6Xnih9
	tC0I4myv0f5A++ZOOlZNnlMlKa4mSoPi8yASAu0L/apdVgw77UbUiZ8HAge2NxQcUypOmW9RUlEbt
	HXW+Gmfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy3wb-00000004gku-01cT;
	Tue, 08 Oct 2024 06:43:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy3wX-00000004gja-49xM
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 06:43:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7180A227A88; Tue,  8 Oct 2024 08:43:34 +0200 (CEST)
Date: Tue, 8 Oct 2024 08:43:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvme-multipath: cannot disconnect controller on
 stuck partition scan
Message-ID: <20241008064334.GC22424@lst.de>
References: <20241007100134.21104-1-hare@kernel.org> <20241007100134.21104-3-hare@kernel.org> <ZwQmK6dZ_goSQ4Cg@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwQmK6dZ_goSQ4Cg@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_234338_201228_D13B8EE5 
X-CRM114-Status: GOOD (  21.04  )
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

On Mon, Oct 07, 2024 at 12:19:23PM -0600, Keith Busch wrote:
> On Mon, Oct 07, 2024 at 12:01:33PM +0200, Hannes Reinecke wrote:
> > @@ -239,6 +239,13 @@ static bool nvme_path_is_disabled(struct nvme_ns *ns)
> >  {
> >  	enum nvme_ctrl_state state = nvme_ctrl_state(ns->ctrl);
> >  
> > +	/*
> > +	 * Skip deleted controllers for I/O from partition scan
> > +	 */
> > +	if (state == NVME_CTRL_DELETING &&
> > +	    mutex_is_locked(&ns->ctrl->scan_lock))
> > +		return true;
> 
> This feels off to me, using these seemingly unrelated dependencies to
> make these kinds of decisions.
> 
> We talked a couple weeks ago about suppressing the parition scanning
> during nvme scan_work. I know you said there was some reason it wouldn't
> work, but could you check the below? It seems okay to me.
> 
> ---
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 48e7a8906d012..82cb1eb3a773b 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -586,6 +586,12 @@ static void nvme_requeue_work(struct work_struct *work)
>  		container_of(work, struct nvme_ns_head, requeue_work);
>  	struct bio *bio, *next;
>  
> +	if (test_and_clear_bit(GD_SUPPRESS_PART_SCAN, &head->disk->state)) {
> +		mutex_lock(&head->disk->open_mutex);
> +		bdev_disk_changed(head->disk, false);
> +		mutex_unlock(&head->disk->open_mutex);
> +	}
> +

Rescan_work feels a little counter intuitive for the partition scanning.
I guess this should work because requeue_work is scheduled from the end
of nvme_mpath_set_live and gives us a context outside of scan_lock.

It'll need really good comments to explain this.


