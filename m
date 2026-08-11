Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA11C5B56A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 15:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9mYHGQ2Q+YL+7Y+umND8aH8Znn1uhq2HGqzgJMKW+7g=; b=MIPwQyz+GN4GeTBraWvaew/LYP
	FqhPMYvBEyTOZjv2fpbDxO1ZUA0ikKOa8eeI/aToHVzeEHJ8xI7QMjFnO+bVqi8XxfhQwndyT/HMM
	VYqXRmVF2MssUP4sOlUdVk6zsNZjSlAHBhWh08VzhDvdefUPYOEiQRCiG1Mf8d0XBEGE0Xdlen3uL
	lRSTpxnFFHsAThUIHfY8OH8fiaNqASz6Fsyuk2jASaE30+xzVrytcOC3G0WasevZcWklTBTCffBI7
	UAKpcP3/jRnhMpn9PyCGYVPXgUCHOw9lMmJodeVIDGAJZXdioB4tZgv5y5ZStfcyjHOmTTTD3W3Gg
	iGjeHi1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtoQA-0000000EK1H-3NBD;
	Tue, 11 Aug 2026 15:29:42 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtoQ9-0000000EK1B-2q60
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 15:29:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BCA97600AD;
	Tue, 11 Aug 2026 15:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE3F1F000E9;
	Tue, 11 Aug 2026 15:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786462180;
	bh=9mYHGQ2Q+YL+7Y+umND8aH8Znn1uhq2HGqzgJMKW+7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WMqrtZmaHZaL1+UdVsFI7tW8p58TgGA7yDsW+dotxkiR6ZeOdnv67Hi/htEiZh5Mt
	 6oBvKZRQO9GwMJrLgjt9Ku0MXmbkUhtg9Ihj6xZ9S8uKqJpAnH1L6lGQqoObDEpSKv
	 bJovCo0WVqId7bbPqoYgpzmJU17CK1C0ehfXKCj4XJzV9/Luniig5aFeBo7oMZnPgE
	 56gudfAR60tjMACaShgNmRq/pnbNO9zZf8dQ+iCSnZ47fNzoP0UCy5cHZR8099gXQX
	 z1HF73j72BxthFfFpAmLieIKSQEJLohuR3yVUouDTGXfr6CJH0lET2aH4xBpvM/tGX
	 gv+1S2WyKXlgA==
Date: Tue, 11 Aug 2026 09:29:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Rihyeon Kim <rihyeon8648@gmail.com>
Cc: hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com, paul.ely@broadcom.com,
	kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when
 nvme_add_ctrl() fails
Message-ID: <ans_4i0GcU2YAkKl@kbusch-mbp>
References: <6a7a83ac.01d0871a.3a0d52.00bb.GAE@google.com>
 <20260811125310.165487-1-rihyeon8648@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811125310.165487-1-rihyeon8648@gmail.com>
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

On Tue, Aug 11, 2026 at 09:53:10PM +0900, Rihyeon Kim wrote:
> It only does so on the fail_ctrl: path, though.  When nvme_add_ctrl()
> fails, nvme_fc_init_ctrl() jumps to out_put_ctrl: instead, so
> nvme_fc_ctrl_free() still sees ctrl->ctrl.opts set and frees opts, and
> nvmf_create_ctrl() frees it again.

...

> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 04363b9c4489..e4d0eeccd846 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3601,6 +3601,9 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>  	nvme_uninit_ctrl(&ctrl->ctrl);
>  
>  out_put_ctrl:
> +	/* nvme_add_ctrl() failures skip the clear in fail_ctrl: above */
> +	ctrl->ctrl.opts = NULL;
> +
>  	/* Remove core ctrl ref. */
>  	nvme_put_ctrl(&ctrl->ctrl);

Can't you move the setting from the "fail_ctrl:" label to the
"out_put_ctrl:" one instead of duplicating it for both?

