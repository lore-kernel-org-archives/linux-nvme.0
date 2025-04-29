Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB20C369DC
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 18:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JCVejbrk1oqYbm8dYIfFjulWMD9bS7BPaADhmFUOcpU=; b=DAa/QPT+dVayBhfJxKXdsTu5fj
	wOdmIXAYtLt+T4vXw/r6MfrffegZoFxPvkima2m7gQX+ZbR0jcnFWw1eWv9DMWoINxayKebjQG9l3
	+V0TaoloIKQ6ojJ+77NBrzGflKA1zEHGypl4gvVdKRKXHX4EA+7tcqJLvI9speY9NOsl1k7gJ+J+M
	LaebtsXHFbNT+KIFZyp2yOYeRvhIAsSFDLIabck/D5FbsNJL7Uk0e6AFwwzX0WnSFBC5fn7y3Am4f
	uhcp1VhmL+YBClS36yGyJOeJFhvPYwb1XLMTD+ZKIjGUYOymiAimpFFw51z8YonwC8GjhpbNeqqYJ
	7Vuq9v+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9pT2-0000000AUvo-0LIV;
	Tue, 29 Apr 2025 18:14:04 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9pSv-0000000AUvB-0Vqu
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 18:13:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4138BA4BE11;
	Tue, 29 Apr 2025 18:08:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FACC4CEE3;
	Tue, 29 Apr 2025 18:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745950435;
	bh=7KLFhpo7TQ1uAQoOU0I1z3Knl9gIW2GZLoY/PE9dL1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aya0qzlzgpRzNk1R0C3VBxvKNxLBFeeUk+rkLGyhP13c55hQRbWI+wZFwxbzI9bs8
	 wD9R2gm471vipnW8KqETrNRm1IcIOfekxZWPDKyRR4J8ltf4FkR/LzRN1cjfkV4Pgw
	 m/6sq2vzChL8UErMmp+NYwT8eN9rYe9ZB8/Q9ZCOResNz102/RGDNYW334dEr6TrY3
	 654Hu0p4/1+/LHVrk3ZEbaqtKNrinteWfbEABX9VOisX144QELJL5mtG+4/ITt3wcz
	 1Q3ojD3aZyYqBtPxCYorY4gWMrzwXvkkDyGZuzRKcFt665BdzdiGPq90DTwXkb1dKf
	 sKEY8Hy1XasZw==
Date: Tue, 29 Apr 2025 11:13:53 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <dwagner@suse.de>, Guenter Roeck <linux@roeck-us.net>,
	Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme: only allow entering LIVE from CONNECTING state
Message-ID: <aBEW4W40ZelIXfs2@kbusch-mbp>
References: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
 <20250214-nvme-fc-fixes-v1-1-7a05d557d5cc@kernel.org>
 <0134ea15-8d5f-41f7-9e9a-d7e6d82accaa@roeck-us.net>
 <cb46aa83-8033-4d64-a3c7-420172c3f3f5@flourine.local>
 <9763c4cf-8ca5-45d4-b723-270548ca1001@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9763c4cf-8ca5-45d4-b723-270548ca1001@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_111357_228085_AF843F3E 
X-CRM114-Status: GOOD (  16.96  )
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

On Mon, Apr 28, 2025 at 03:21:18PM +0200, Hannes Reinecke wrote:
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index b502ac07483b..d3c4eacf607f 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -4493,7 +4493,8 @@ static void nvme_fw_act_work(struct work_struct *work)
> >                  msleep(100);
> >          }
> > 
> > -       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
> > +       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
> > +           !nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
> >                  return;
> > 
> >          nvme_unquiesce_io_queues(ctrl);
> 
> I would rather have a separate state for firmware activation.
> (Ab-)using the 'RESETTING' state here has direct implications
> with the error handler, as for the error handler 'RESETTING'
> means that the error handler has been scheduled.
> Which is not true for firmware activation.

But the point of having firmware activation set the state to RESETTING
was to fence off error handling from trying to schedule a real reset.
The fw activation work schedules its own recovery if it times out, but
we don't want any other recovery action or user requested resets to
proceed while an activation is still pending.

