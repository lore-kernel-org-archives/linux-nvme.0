Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B554DC369DC
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 18:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aYLwraxAlkftd9iQDwKIqOKRtuHuD6xLiPMysqV69QA=; b=2MUjD4he6XibdckIqdgGum8nJp
	W4DTeXt6sZ2995h2q3AOTjJE/jrRBQwVl1diSQBvqgquLaNWVrFGRnwMVa+cL64oED6/f3t+tLz8r
	L0QpjwkgFTyjJVF9zybnyIyXSWnX4nvZBWjiLzBOQhDJwIlxiJ9JRiCbiZOxjDXW4/FVdck05sCKL
	PTSocPNwZ3sHgt3w4gUZz7CQ+V3q0u4MTJlW2ddeJst5zEys/LZdSSJ1AqlcT+PZOG1GSYQi/u96S
	Y7S1zWSI0muXPDktylYmpqgNsU7W17NGrvHbyAxllPD3VDPUwZFimfQQnTXQZPxkbLb6TxpTdDlGw
	hHAXwd/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9puZ-0000000Aa9d-00QE;
	Tue, 29 Apr 2025 18:42:31 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9puW-0000000Aa8x-0GIo
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 18:42:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 989AE439EB;
	Tue, 29 Apr 2025 18:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505F3C4CEE3;
	Tue, 29 Apr 2025 18:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745952147;
	bh=AVZaIFfl3C3AnVUI9WWYbfNoTf+Ot9B32U+3KMaA6gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N9P4/WXVd/gQqKxGxomjEWqs7DXWROTnaKEREvwt8cX/apG6nNxCNoyrydDT5RFqU
	 P9swB3/9KtuyKXLKhHwiEO/1gjBwfGdc2wRxeWeLV9r20rE9/qj66/TMAqvzbTcGud
	 DGO/vx2pj5agTujUhkZWkX7/JKxqJ4fUltcWbTqO1RdhJh7utmw6JcWpXkII05YO5w
	 vxDIQdrixgH56yIaow+40iObKhhVvEiadQMjrvUme2TMsqEnBI069p/OyxceBaNNzz
	 02FOBa2AJfs2MXC+9BZsT9s7N9onkKEx4ijK8C9+cNSlRDrS7VrVs049b/X/H3ZH4S
	 RZ+AJqpdW0F9Q==
Date: Tue, 29 Apr 2025 11:42:25 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
	Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme: only allow entering LIVE from CONNECTING state
Message-ID: <aBEdkUky_-bfgISv@kbusch-mbp>
References: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
 <20250214-nvme-fc-fixes-v1-1-7a05d557d5cc@kernel.org>
 <0134ea15-8d5f-41f7-9e9a-d7e6d82accaa@roeck-us.net>
 <cb46aa83-8033-4d64-a3c7-420172c3f3f5@flourine.local>
 <9763c4cf-8ca5-45d4-b723-270548ca1001@suse.de>
 <aBEW4W40ZelIXfs2@kbusch-mbp>
 <253e0551-d4d7-4ffe-8842-daecf1f6c753@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <253e0551-d4d7-4ffe-8842-daecf1f6c753@roeck-us.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_114228_122307_6D056081 
X-CRM114-Status: GOOD (  25.71  )
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

On Tue, Apr 29, 2025 at 11:23:25AM -0700, Guenter Roeck wrote:
> On 4/29/25 11:13, Keith Busch wrote:
> > On Mon, Apr 28, 2025 at 03:21:18PM +0200, Hannes Reinecke wrote:
> > > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > > index b502ac07483b..d3c4eacf607f 100644
> > > > --- a/drivers/nvme/host/core.c
> > > > +++ b/drivers/nvme/host/core.c
> > > > @@ -4493,7 +4493,8 @@ static void nvme_fw_act_work(struct work_struct *work)
> > > >                   msleep(100);
> > > >           }
> > > > 
> > > > -       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
> > > > +       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
> > > > +           !nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
> > > >                   return;
> > > > 
> > > >           nvme_unquiesce_io_queues(ctrl);
> > > 
> > > I would rather have a separate state for firmware activation.
> > > (Ab-)using the 'RESETTING' state here has direct implications
> > > with the error handler, as for the error handler 'RESETTING'
> > > means that the error handler has been scheduled.
> > > Which is not true for firmware activation.
> > 
> > But the point of having firmware activation set the state to RESETTING
> > was to fence off error handling from trying to schedule a real reset.
> > The fw activation work schedules its own recovery if it times out, but
> > we don't want any other recovery action or user requested resets to
> > proceed while an activation is still pending.
> 
> Not only that; there are various checks against NVME_CTRL_RESETTING
> sprinkled through the code. What is the impact of introducing a new state
> without handling all those checks ?

Good point, bad things will happen if these checks are not updated to
know about the new state. For example, nvme-pci will attempt aborting IO
or disabling the controller on a timeout instead of restarting the timer
as desired.

Can we just revert the commit that prevented the RESETTING -> LIVE
transtion for now?

