Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAAEC369A8
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 08:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=79x3ouwVOTvrEIArzQEpjs3iehLMdgsN2AWvSGAHt3M=; b=WX+Gv7hbqfjgEUwSmc2IRrYw8K
	uHkG5lamxGTs4ZFuYWT+gfmT7SGbhSkfRqnz8Ab3u+we+0ed5onSzcq6dNmpU/u9r9w/fVcn17w/R
	sfgji8zMqmqE2kiuevERyuk2YvDgxJT6Gj93Nre+YMATTZKpQGfzMLdw6I3Twh58NAgiKhqfsh1F9
	0bgI2LbPSWQ7SBWAiW5IwQYt9WLj3rIuUIOp6iK/s3+Onm7bQL9qnEuNT2ibQfd4XOEEz8SRAe6wP
	J6KhxmS/ogtYIM6+PU4ee9DzNkj2VI1D8RM68V+Wam6WTTkudsW61zIPXnX+CxJR/5b0YvTWu23m2
	LI8xbBqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2njE-00000009pxX-17ho;
	Thu, 10 Apr 2025 08:57:44 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2nMs-00000009lYt-250W
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 08:34:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 994036843D;
	Thu, 10 Apr 2025 08:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50025C4CEDD;
	Thu, 10 Apr 2025 08:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744274077;
	bh=gvYbiZmh8hj4Q0YzBFwRtD6c6+vl3FpGqOr34aIT5JI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lUqiPcYRckY0IIkKSfvMcHvKc8JKzj6Gjguhyh1lf48/sshZU9TGhZcXYXpEy+nTt
	 xCSkMX/tdn4IAB5trbbbXVPWVUnHAiYqn/HQr5BwVISH45bWf2pKRqZcGAIMBH/heR
	 41YjgMU6ryTVm/198lSfqNCpcoIjXX4B4lg9ClJxvIF4HSO6WhzZuKau98ftWj7zZl
	 Yb2eZP+vFUNfE10B9zq7h7hqLWqg+QW1e/1D9WlQP+eBWCAidlLESg5xa+Hkh+wbzC
	 wfg0q2pnmHx9uBWTeE9LBVderrsC6USJwNjJmCnww+oGpmI+DHEhha2ZUsCQczk05/
	 ROzTaAFcAdojA==
Date: Thu, 10 Apr 2025 09:34:33 +0100
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/3] nvmet: pci-epf: Clear CC and CSTS when disabling the
 controller
Message-ID: <Z_eCmfXXjmarMnQl@kbusch-mbp>
References: <20250408024733.690966-1-dlemoal@kernel.org>
 <20250408024733.690966-3-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408024733.690966-3-dlemoal@kernel.org>
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

On Tue, Apr 08, 2025 at 11:47:32AM +0900, Damien Le Moal wrote:
> @@ -1895,6 +1912,11 @@ static void nvmet_pci_epf_disable_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
>  	nvmet_pci_epf_delete_cq(ctrl->tctrl, 0);
>  
>  	ctrl->csts &= ~NVME_CSTS_RDY;
> +	if (shutdown) {
> +		ctrl->csts |= NVME_CSTS_SHST_CMPLT;
> +		ctrl->cc &= ~NVME_CC_ENABLE;
> +		nvmet_pci_epf_bar_write32(ctrl, NVME_REG_CC, ctrl->cc);
> +	}
>  }

I think this is probably okay, but I don't know if it's necessary to be
messing with CC.EN that the host didn't request. The qemu emulated nvme
doesn't do this, at least. But it looks like that would all work out in
the end anyway, so again, I think it's fine.

