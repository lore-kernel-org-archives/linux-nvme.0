Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57ED4C369A2
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 16:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RZnjsYfhhZGaM/xEcQ+5iJ/iDXaXWBfat2HQHQyozXw=; b=otej4FvQf3/83mi8vVnmLWScUR
	MKmIm6KKY4PjcJ/bxlFVSsF2aZbdtmTZBCLdgizK4mP0mAZ3LNYigS3gI7XSL9LAbkqP8ZSOPq1/q
	ZoY1ixcOMxW+m5SLe8CxMVptlCzkg/qHuac9PGLLp2/8zMOyCooFt88E+c4dvdtjDFTmggpgD8NWO
	SR47ZRGmAaL/z/iXVqucImD/Qc14jM3kZqI1mpnHhvTkS+dj9Px1vCO+MDwhzV7UQRkuVXCcas/Df
	mgdFInA/FwlCs6KJ17iLmlHF+IJ6Ex7LevN7j8IrYSCFJY3Q76Iv+1L4BoC8OuJVIyJaj497LM+w+
	vuNBXMCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1pKX-00000001BX6-1lVO;
	Mon, 07 Apr 2025 16:28:13 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1ni7-00000000mu2-0PWX
	for linux-nvme@bombadil.infradead.org;
	Mon, 07 Apr 2025 14:44:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RZnjsYfhhZGaM/xEcQ+5iJ/iDXaXWBfat2HQHQyozXw=; b=PgcLt4RRo7TYmxcWGv0GTe2KUW
	ysYD8E2p/JDbXTfy534+UwmIsBLJiih08FHnqv8R2u88cZOUOQfhEvAeO7GjnT8/KzcMki9E5jYRf
	auaWyqP36sWIg0wvfchk8qPj4888OGTlWY7Qmptnwfz8fo6Lf+YP6i/WNNxcTKGaBpLqpoMoe4X/g
	whJIFgSHsDiJQPArhJIIovbqpsvfou814GtFTiKnZHJR2NbaLB8giL49mMohD4pPOpJuCwrq5P1WL
	K+1vqaEHzzaRTbwtckCaMqSD/PhoyrZHKGzFaiXGid5l7PjGYGd0QArMNjwVLYNsbQVGNyRZFuoGJ
	P8G+WTOQ==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1ni3-00000007zmd-3y5z
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 14:44:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2C9A367373; Mon,  7 Apr 2025 16:44:14 +0200 (CEST)
Date: Mon, 7 Apr 2025 16:44:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	kbusch@kernel.org, hare@suse.de, sagi@grimberg.me,
	jmeneghi@redhat.com, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [RFC PATCH 1/2] nvme-multipath: introduce delayed removal of
 the multipath head node
Message-ID: <20250407144413.GA12216@lst.de>
References: <20250321063901.747605-1-nilay@linux.ibm.com> <20250321063901.747605-2-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321063901.747605-2-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_154424_132078_36FAA04B 
X-CRM114-Status: GOOD (  20.12  )
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

> @@ -3690,6 +3690,10 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>  	ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
>  	ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);
>  	kref_init(&head->ref);
> +#ifdef CONFIG_NVME_MULTIPATH
> +	if (ctrl->ops->flags & NVME_F_FABRICS)
> +		set_bit(NVME_NSHEAD_FABRICS, &head->flags);
> +#endif

We might want to make the flags unconditional or move this into a helper
to avoid the ifdef'ery if we keep the flag (see below).

> -	if (last_path)
> -		nvme_mpath_shutdown_disk(ns->head);
> +	nvme_mpath_shutdown_disk(ns->head);

I guess this function is where the shutdown naming came from, and it
probably was a bad idea even back then..

Maybe throw in an extra patch to rename it as well.

> +	/*
> +	 * For non-fabric controllers we support delayed removal of head disk
> +	 * node. If we reached up to here then it means that head disk is still
> +	 * alive and so we assume here that even if there's no path available
> +	 * maybe due to the transient link failure, we could queue up the IO
> +	 * and later when path becomes ready we re-submit queued IO.
> +	 */
> +	if (!(test_bit(NVME_NSHEAD_FABRICS, &head->flags)))
> +		return true;

Why is this conditional on fabrics or not?  The same rationale should
apply as much if not more for fabrics controllers.

Also no need for the set of braces around the test_bit() call.

>  }
>  
> +static void nvme_remove_head(struct nvme_ns_head *head)
> +{
> +	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
> +		/*
> +		 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
> +		 * to allow multipath to fail all I/O.
> +		 */

Full sentence are supposed to start with a capitalized word.

(yes, I saw this just move, but it's a good chance to fix it)


