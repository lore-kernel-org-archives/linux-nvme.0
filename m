Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3506BC36014
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Apr 2025 08:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yOaiH5ToqgzFXLvcwH7ItJr4LUGKxzlpLjA+oIRT1o4=; b=nR8fXgLGjCbkWymIR3fpoo1+cx
	VYs/caGR6BkRJ2SWxtP2Yn0jSGab/3Ym7PDZRrt8YnrMYS9gTHvNJpY0Lom+MfPIHS28VrVWErD+m
	3hbJiQuxuySvGyaGb7KkEBfAwTi7S5wzjQ9C8FGDPSbFvEtsvxzSmgdrLpf71NPtQVyfstz5opBSC
	EC0UFYNzCI1wEaqcgmT0tBhvBhkqMaShwygC+uZjlkiPpXheNkh0XL6dL9+/g985LyL1HZqp3L3oM
	GiSf0pY+tEE2A1MbklZ2Bf2vzNf+f2DLvZKseXCtjwZKgEJn2ktLIHwik3N8E3SSOkRvkYWy63Yf4
	W5Y79D1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzWc8-00000002H6s-3J0q;
	Tue, 01 Apr 2025 08:04:52 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzWc5-00000002H5M-2MF1
	for linux-nvme@lists.infradead.org;
	Tue, 01 Apr 2025 08:04:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1050E4453A;
	Tue,  1 Apr 2025 08:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D89DC4CEE4;
	Tue,  1 Apr 2025 08:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743494688;
	bh=uoqxFn461uJWatWNv82EkPSO4xUwOaxQli24YjB0PeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BlaCAqZ2x2jEYsaQmJv6sm81CPlhaB7/gaMCm0g4fkiQCqeIN0Sli9xRtH+qCpiUG
	 wRuqZLB5yJZM2ybvhcux8Bk+aM/B92QPnUTbZW4AGXwUbR+cPz5RkHx9BrRSdUlnPN
	 9tz6z32IMGsXt5+lxq9gjGSVsGRQgPmIAfmdxw/uQlt2BNyjW3KhJTwwfe71OiCJA2
	 oUBo3ri7HyMO+Ivt4MqRZnMU3yT3R/WvXMbfjo9vpKyzil5arq3pQ3qci8UchxPUlt
	 8nBqBNOWmioyzzWDaiQV0Zs6ORAosaTYSZ9VO7G7/RY2bd5oVgD13S8NvWuRbNkl3P
	 jVV/dRrNTDWPw==
Date: Tue, 1 Apr 2025 10:04:43 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Kamaljit Singh <kamaljit.singh1@wdc.com>, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, niklas.cassel@wdc.com,
	damien.lemoal@wdc.com
Subject: Re: [PATCH v1 1/1] nvme: add admin controller support. prohibit ioq
 creation for admin & disco ctrlrs
Message-ID: <Z-ueG-wTibsSu5lK@ryzen>
References: <20250328213640.798910-1-kamaljit.singh1@wdc.com>
 <20250328213640.798910-2-kamaljit.singh1@wdc.com>
 <Z-qur5YnK2ZtiRR3@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-qur5YnK2ZtiRR3@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250401_010449_619939_DDB8DF22 
X-CRM114-Status: GOOD (  19.14  )
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

On Mon, Mar 31, 2025 at 09:03:11AM -0600, Keith Busch wrote:
> On Fri, Mar 28, 2025 at 02:36:40PM -0700, Kamaljit Singh wrote:
> > -static inline bool nvme_discovery_ctrl(struct nvme_ctrl *ctrl)
> > -{
> > -	return ctrl->opts && ctrl->opts->discovery_nqn;
> > -}
> > -
> 
> I suppose it's fine to rename this function with an nvmf_ prefix, but
> it's not really related to the rest of the patch and makes the diff
> larger than necessary.
> 
> > +	/* An admin or discovery controller has one admin queue, but no I/O queues */
> > +	if (nvme_admin_ctrl(&ctrl->ctrl) || nvmf_discovery_ctrl(&ctrl->ctrl)) {
> > +		ctrl->ctrl.queue_count = 1;
> > +	} else if (ctrl->ctrl.queue_count < 2) {
> > +		/* I/O controller with no I/O queues is not allowed */
> > +		ret = -EOPNOTSUPP;
> > +		dev_err(ctrl->ctrl.device,
> > +			"I/O controller doesn't allow zero I/O queues!\n");
> > +		goto destroy_admin;
> > +	}
> 
> The queue_count comes from the user. If the user provides a bad value
> for an IO controller, you're erroring. If they provide a bad value for a
> discovery or admin controller, you override the value. Why the different
> behavior?
> 

Good question.

My initial proposal was simply to override the user provided value
to 1 (admin queue only) in case of admin (or discovery) controller.

The check for queue_count < 2 should be in a separate patch, if we
want that check at all. But to be honest, the code did previously
allow an I/O controller with just the admin queue and no I/O queues.
Thus, without a commit message explaining clearly why we should start
to disallow an I/O controller with just the admin queue, I think that
additional check is wrong.


Kind regards,
Niklas

