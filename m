Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6826FEDEC71
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Sep 2023 15:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/zhA5qkv6+GMtp+LLkXb/MOaqVn6FxPQZWNo0f50ZwQ=; b=ZKzrlxxKMg7mVNRcMVgHhxEKaH
	5WBO2lpdNMIUJM8WCBVuuckPq2rpXKvzuoExFOrLbzIfJb1f044sGdXse0ZBAkkDaF5DIjxeEhx8Q
	OgUOSGR1mrPRyxEKVBvlwDHtRWPsN4gqOBYiSWdI7o7EFHXyAM6r0PvaGpMWByDb32pewdyIRx0FO
	dePGIp0TYr9YoBOyWwCZSkltFjNudO6nSa9CmG31puT0A3aygiK8lBmynp1qYjuNk0A3/fgJRRQV6
	5+IR01xs+kQxExc0PBgw2TI3chHbww3aHIAgwNi98sRovjLjnbH4Lp1PcVxVlBsC+2oGGPD0jzKaB
	XmPgUw7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgRaA-006Bsx-18;
	Wed, 13 Sep 2023 15:15:10 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgRa7-006Bru-0j
	for linux-nvme@lists.infradead.org;
	Wed, 13 Sep 2023 15:15:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4ACAB619A0;
	Wed, 13 Sep 2023 15:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681ACC433C7;
	Wed, 13 Sep 2023 15:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694618105;
	bh=ozjc71/Y1N+yFoWByjrcbpH275Xjc3mq64DGj2vHBtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TjmarMDE6NkAUGHDQlivnvtwhPnI4eQwDpAm+wO/Ik3q33AiEEL/eGo4phQGdHVUd
	 7BrHofcmPBAk0VlIHrMCHvLZ4mSgFTt3mY66TqjoarTcpqp/pRKjAmMSLb467yjJcD
	 jpnW/DvSYNiy1bZCeYo7JKXHrF27OWK5zLOIXo3wmY2MMZEAx3iM7l/xqlWD94UpKG
	 +q1ccVZlNJRe+e02jytYZIxEXoc+PEkgtKM2a7/hPVmU8dS67gaqUNkxhXLmeKdJUE
	 Pmf3wY1cXj5LPf++uWkk61STTP2i1Twix02m2HPYQdbG5hG8J9xWZodsz/m3l2jLZ1
	 d+1l0fP52OzEA==
Date: Wed, 13 Sep 2023 08:15:01 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	=?iso-8859-1?Q?Cl=E1udio?= Sampaio <patola@gmail.com>,
	Felix Yan <felixonmars@archlinux.org>, stable@vger.kernel.org
Subject: Re: [PATCH] nvme: avoid bogus CRTO values
Message-ID: <ZQHR9eRDzzyRoV-z@kbusch-mbp.dhcp.thefacebook.com>
References: <20230912214733.3178956-1-kbusch@meta.com>
 <20230913105015.GA30644@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913105015.GA30644@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_081507_305075_0B93EE80 
X-CRM114-Status: GOOD (  24.45  )
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

On Wed, Sep 13, 2023 at 12:50:15PM +0200, Christoph Hellwig wrote:
> On Tue, Sep 12, 2023 at 02:47:33PM -0700, Keith Busch wrote:
> >  1 file changed, 29 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> 
> > +	if (ctrl->cap & NVME_CAP_CRMS_CRWMS && ctrl->cap & NVME_CAP_CRMS_CRIMS)
> 
> I don't think the NVME_CAP_CRMS_CRWMS check here makes sense, this
> should only need the NVME_CAP_CRMS_CRIMS one.

I think you're right, but we currently only enable CRIME if both are
set, so that would be a functional change snuck into this sanity check.
 
> > +	timeout = NVME_CAP_TIMEOUT(ctrl->cap);
> > +	if (ctrl->cap & NVME_CAP_CRMS_CRWMS) {
> > +		u32 crto;
> > +
> > +		ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CRTO, &crto);
> > +		if (ret) {
> > +			dev_err(ctrl->device, "Reading CRTO failed (%d)\n",
> > +				ret);
> > +			return ret;
> > +		}
> > +
> > +		/*
> > +		 * CRTO should always be greater or equal to CAP.TO, but some
> > +		 * devices are known to get this wrong. Use the larger of the
> > +		 * two values.
> > +		 */
> > +		if (ctrl->ctrl_config & NVME_CC_CRIME)
> > +			timeout = max(timeout, NVME_CRTO_CRIMT(crto));
> > +		else
> > +			timeout = max(timeout, NVME_CRTO_CRWMT(crto));
> 
> Should we at least log a harmless one-liner warning if the new timeouts
> are too small?

Felix had something like that in an earlier patch, but it would print on
every reset. That could get a bit spammy on the kernel logs, but I can
add a dev_warn_once() instead.

