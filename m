Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68758E81BDA
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Feb 2026 15:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=37AGiOQdl/AsObR/EHc//6xiGsOr/iLokhD0B3iqDvY=; b=UHjB+DGgElLA4HQgLfM8Lm21Vs
	3Ce0NhG0sL5zjBbz+o96ThxQ0+x0/5Jstf7DXrqkFjgfZYLlxLWTm2dSo2r6W0FZuT3kPVbdyCzXJ
	kmQHeKKKgsHgiMwl2UE5BHXuzc3uEvaHcqMov4CCQ/BScU4CsmbYITC9x7jzGGloevdiPE7cMUTpm
	j4u3GQTcJZbb9NawZvRlqq/BlfwQ04zXTu6+GPnpxOzH7oroSLDI/wCrEVZPM6yU5rhTTmCExzTPs
	fvGlv84CZjQve222dV56+bZm/hkr4IHaYfA4xhTWtT9lKc0ijHcn5md629+ueY1hB5rVo5cEtHBp2
	3YpdQczQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpTIe-0000000FcN5-3Mvo;
	Mon, 09 Feb 2026 15:35:44 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpTIa-0000000FcLs-484w;
	Mon, 09 Feb 2026 15:35:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6A96D4174B;
	Mon,  9 Feb 2026 15:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9F1C116C6;
	Mon,  9 Feb 2026 15:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770651338;
	bh=0fifQJtiYVqXic/pGE/HONsBR9WXkXWJmgdnGITt1fE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S/i/ej0vQy4DsADNeeCeJA110Giu9VxKPNLcgVrsSDpbfOgtjJCtep8mv7PQDXyPt
	 WYVVbzL//HHhfvGSpA3NrkGjPagFP/C28J2wMtraTlUElp49ttSQYmwFWKkdG3CA+/
	 A4JR51GUlctcecXsRM4sf6Ecsvea2tVcc5JvlV074Uw+jGJx57rkBsvBfXIZzBhRHu
	 IsTYmrVRmzSbuaPN6qVoww3VPstRyrrJHX0nkhtk/3SX1Ijfl9H1/rY42WN0gAOYzi
	 0eOX7vPLacwa/ZxOEXh9rumO+HYRTGNOyOSB0XkjIqVl6IHlHBvge3bjq+HGc4MvlW
	 ZJEHkudjVKpTA==
Date: Mon, 9 Feb 2026 08:35:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, sagi@grimberg.me,
	sven@kernel.org, j@jannau.net, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, tj@kernel.org, nilay@linux.ibm.com,
	ming.lei@redhat.com, neal@gompa.dev, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] nvme-apple: move blk_mq_update_nr_hw_queues after
 nvme_unfreeze
Message-ID: <aYn-xwFHCpd7sITJ@kbusch-mbp>
References: <20260209082953.3053721-1-yukuai@fnnas.com>
 <20260209082953.3053721-4-yukuai@fnnas.com>
 <20260209145832.GC18315@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209145832.GC18315@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260209_073541_134516_7AEDF46B 
X-CRM114-Status: GOOD (  24.41  )
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

On Mon, Feb 09, 2026 at 03:58:32PM +0100, Christoph Hellwig wrote:
> On Mon, Feb 09, 2026 at 04:29:52PM +0800, Yu Kuai wrote:
> > blk_mq_update_nr_hw_queues() freezes and unfreezes queues internally.
> > When the queue is already frozen before this call (from nvme_start_freeze
> > in apple_nvme_disable), the freeze depth becomes 2. The internal unfreeze
> > only decrements it to 1, leaving the queue still frozen when
> > debugfs_create_files() is called.
> > 
> > This triggers WARN_ON_ONCE(q->mq_freeze_depth != 0) in
> > debugfs_create_files() and risks deadlock.
> > 
> > Fix this by moving nvme_unfreeze() before blk_mq_update_nr_hw_queues()
> > so the queue is unfrozen before the call, allowing the internal
> > freeze/unfreeze to work correctly.
> > 
> > Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> > ---
> >  drivers/nvme/host/apple.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> > index 15b3d07f8ccd..1835753ad91a 100644
> > --- a/drivers/nvme/host/apple.c
> > +++ b/drivers/nvme/host/apple.c
> > @@ -1202,8 +1202,8 @@ static void apple_nvme_reset_work(struct work_struct *work)
> >  
> >  	nvme_unquiesce_io_queues(&anv->ctrl);
> >  	nvme_wait_freeze(&anv->ctrl);
> > -	blk_mq_update_nr_hw_queues(&anv->tagset, 1);
> >  	nvme_unfreeze(&anv->ctrl);
> > +	blk_mq_update_nr_hw_queues(&anv->tagset, 1);
> 
> Looks good on it's own, but it would also good to align the
> apple driver with the PCI one here more.

I'm pretty sure this series would deadlock nvme-pci, as that driver
still leaves the queue frozen when calling blk_mq_update_nr_hw_queues.

We've left it frozen on purpose, though. The idea was to prevent new IO
from entering a hw context that's no longer backed by a hardware
resourse. Unfreezing prior opens that window up again. Maybe it's not a
big deal; I don't often encounter scenarios where the queue count
changes after a reset.

