Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B215E6F083
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Nov 2024 19:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qHvzwKICO5YOt8K5VTFfb/cAFZ2f5/ikvRZ/0sdYgQQ=; b=PSNysZNCNaSN5YtRYI2xZfPd/N
	hRfpjdLYdI0hzUwl05GNlkuPfl2/gf84dWEGapBk9JJvzFMeIXqs293gNkYg3sQoKd8sAvgqIu0Nr
	rsuGrn04YMufN2wHaRjernHNrqDLggaPkYpLSlMB3X16bzn9oqRj1bO0qoy3N4CrBd7xFiinuVOyC
	zadQLyl0LSuOzTHkbD5JgVhztGyMb9l/yv5bdJV1sxBSZ3Wl9yBXzpBhcNos1EXDg/fiB3iIDOTJD
	k3DVu/j7FTWJpL9QcWiq2fir8Vd9d3pvSXhJt+Lqc/eFKdfH3TwyJrm8D6j2MKA173tMCYX10JDVv
	5SluLvNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6x5m-000000084ye-0n3h;
	Fri, 01 Nov 2024 19:13:54 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6x5j-000000084y0-409a
	for linux-nvme@lists.infradead.org;
	Fri, 01 Nov 2024 19:13:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5A647A44B59;
	Fri,  1 Nov 2024 19:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA705C4CECD;
	Fri,  1 Nov 2024 19:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730488430;
	bh=m8X49Xf0XsU/SL0/M1s+EP2WmiK633FGFaSbX3lYlcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XWGfLuGwcETZfVraDrpO1nuPo0MQ9sn+zlHbjNdJhfDYoDSoRAQzgm/5sTGHjwvhv
	 2XGxFNunCIH0Y+EvEKOo9z6XdNIuS/YTIpNpVSx6M2bGnwSh21m8BajmAknu215Bxo
	 OtxxLMWtDXUu7lh7id6XesqvEBrDj/HvnEo+8HZvaYY1Rls6l6+Ge4j6mIAxfSiYpd
	 Q9eAPzGEzjM03A1eXb/zNZm/mFNv2KqQ2XZxfgs5FCc0OwjvHETSejeNpNTzbENFpV
	 6W1Drb4H+euHzciN03MywHJOAybCJnZGgu3cacu2X1RW0S4RGKQ5UxpFEPLnNjZnGB
	 9WertkUTNq+3A==
Date: Fri, 1 Nov 2024 13:13:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	axboe@fb.com, chaitanyak@nvidia.com, dlemoal@kernel.org,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH 3/3] nvme: use helper nvme_ctrl_state in
 nvme_keep_alive_end_io function
Message-ID: <ZyUoa33hvwEybcRf@kbusch-mbp.dhcp.thefacebook.com>
References: <20241027170209.440776-1-nilay@linux.ibm.com>
 <20241027170209.440776-4-nilay@linux.ibm.com>
 <ZyD433W-caGMfVsv@kbusch-mbp>
 <480b7c6a-9f4b-4611-a3d6-de82c39bfe6d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <480b7c6a-9f4b-4611-a3d6-de82c39bfe6d@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_121352_078312_60DCD1D6 
X-CRM114-Status: GOOD (  18.59  )
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

On Wed, Oct 30, 2024 at 11:37:15AM +0530, Nilay Shroff wrote:
> On 10/29/24 20:31, Keith Busch wrote:
> >> @@ -1296,10 +1296,9 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
> >>  						 blk_status_t status)
> >>  {
> >>  	struct nvme_ctrl *ctrl = rq->end_io_data;
> >> -	unsigned long flags;
> >> -	bool startka = false;
> >>  	unsigned long rtt = jiffies - (rq->deadline - rq->timeout);
> >>  	unsigned long delay = nvme_keep_alive_work_period(ctrl);
> >> +	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl->state);
> >>  
> >>  	/*
> >>  	 * Subtract off the keepalive RTT so nvme_keep_alive_work runs
> >> @@ -1324,13 +1323,9 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
> >>  
> >>  	ctrl->ka_last_check_time = jiffies;
> >>  	ctrl->comp_seen = false;
> >> -	spin_lock_irqsave(&ctrl->lock, flags);
> >> -	if (ctrl->state == NVME_CTRL_LIVE ||
> >> -	    ctrl->state == NVME_CTRL_CONNECTING)
> >> -		startka = true;
> >> -	spin_unlock_irqrestore(&ctrl->lock, flags);
> >> -	if (startka)
> >> +	if (state == NVME_CTRL_LIVE || state == NVME_CTRL_CONNECTING)
> >>  		queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
> >> +
> >>  	return RQ_END_IO_NONE;
> >>  }
> > 
> > This restores what you had in the reverted patch, which was a
> > significant portion of the diff stat. If we're keeping this chunk, maybe
> > a full revert isn't necessary, and we can squash the series to just one
> > fixing commit.
> > 
> This doesn't exactly restore what was reverted in the patch. If you 
> closely look at the reverted patch then you would find that we reverted 
> the nvme_keep_alive_finish function which is not exactly same as 
> nvme_keep_alive_end_io function. We renamed nvme_keep_alive_end_io() 
> to nvme_keep_alive_finish() for the upstream patch.     
> 
> So the revert patch restores nvme_keep_alive_end_io function and also 
> restores the nvme_keep_alive_work changes. Then the current patch in this 
> patchset, actually works upon nvme_keep_alive_end_io function.

Not the whole thing. I'm just talking about the parts I've hightlighted
here. Squashing this series doesn't show any changes to the state check.

