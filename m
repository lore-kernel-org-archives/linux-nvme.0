Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1F3C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 23:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cR3XEgehtRfTrZLs/xAV8IoOJJMMtsnNdlaPklWFe7s=; b=h8VzgT+1vA8/Zf+dvNJNeUrU9t
	b6EGxQw2f6KZfJ87u8bP6IPtIqfP/5tOfWRwLP5B6vVYkbDK4O0ORX7BmhgDTVHgXWDBMSrNT/woh
	sxAWpomItN0tDEG7Hg8N1lwMaQevTBoxqWgjL+zgCM2Tr2+DlS8G6oLcwITmtEDxTXNEHjW3G3Wty
	kpya3Vt9y6ypfiaTE3mfm1dP5x7U7D76Ii4kQiAW0DGjNGc406+TR+/OP2kg+AXMVm1/DQR86Y+bp
	hNzBP5mC6qKNxHYqYrh8sdRsYoc35OgaB6mzb6QUI+0RsA2BMXgDgPesnXggifrMAH3oir1/bOjP9
	UQYYgAfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ne3pG-00AtrH-WB; Mon, 11 Apr 2022 23:52:07 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ne3pE-00AtqT-Ai
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 23:52:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B8C88617C7;
 Mon, 11 Apr 2022 23:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F2CC385A4;
 Mon, 11 Apr 2022 23:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649721123;
 bh=NSme6n1+rIXNaaUMzRVIKxLIDWfjMfG845SNj9jfBFs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lGy6k9bE00zBmJekx8JT35ysUgN0qbHWTZMZ6payKmrKjxCThxZyhLVm2mQT8zaBL
 AetPlwtqELfLSCfTtanpzQr5ZvwHxb55DGnfR0FcUjXHlAULSldn6qzfuWcAOmMIRH
 IQ0y6W+FAw2I/uHI4Fsja7gQR9X3meJr/kT+83TKq9Oz/abzapnIQrttVIPJ0fnPrd
 P1gzzN3Ec3WyCH9bcumn67pJnsqx4cBxNJd/aJ3RuoWiKprvRxizrb5LVj9nBBF0rK
 cEQw9EjpCE5M0Iq/FfIY9jHiO9I7cbHnp0tZCBkBYo7EvUWv/cWWPFefrOwJLKuqWa
 QOVeRfIfFaGsw==
Date: Mon, 11 Apr 2022 17:51:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/3] nvme-core: don't check non-mdts for disc ctrl
Message-ID: <YlS/HrmdtmK61ecT@kbusch-mbp.dhcp.thefacebook.com>
References: <20220411031249.5158-1-kch@nvidia.com>
 <20220411031249.5158-3-kch@nvidia.com>
 <20220411061301.GB14797@lst.de>
 <34d61434-27cd-f918-a3bc-fdca3196ef99@grimberg.me>
 <b5dd1bb3-e001-ac66-d461-4d699a2dadd6@nvidia.com>
 <d86c4a83-ac9d-f0b1-de41-5d411f5444f3@nvidia.com>
 <20220411121209.GA21711@lst.de>
 <63d1842c-35d7-e482-21c6-57cab24ae83f@nvidia.com>
 <YlQ3xWkZNKcMvvOU@kbusch-mbp.dhcp.thefacebook.com>
 <cb42edaa-a545-e7df-f9ed-fcb57caf9139@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb42edaa-a545-e7df-f9ed-fcb57caf9139@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220411_165204_440463_C2C32817 
X-CRM114-Status: GOOD (  15.28  )
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

On Mon, Apr 11, 2022 at 08:44:59PM +0000, Chaitanya Kulkarni wrote:
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 3554c20e78c3..ce4060c3d62e 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2525,6 +2525,13 @@ static void nvme_dev_add(struct nvme_dev *dev)
>          int ret;
> 
>          if (!dev->ctrl.tagset) {
> +               ret = nvme_init_non_mdts_limits(&dev->ctrl);
> +               if (ret < 0) {
> +                       dev_warn(dev->ctrl.device,
> +                               "reading non mdts limit error: %d\n", ret);
> +                       return;
> +               }
> +
>                  dev->tagset.ops = &nvme_mq_ops;
>                  dev->tagset.nr_hw_queues = dev->online_queues - 1;
>                  dev->tagset.nr_maps = 2; /* default + read */

This isn't right either. A controller can change it's limits after a reset.
It's unlikely outside some odd firmware upgrades, but it could happen, so
the limits need to be checked on each reset, not just the first one.

