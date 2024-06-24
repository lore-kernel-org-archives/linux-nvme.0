Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D056FC2BD09
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jun 2024 21:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rhZ7j7YNkPyKckEl5HyXXXRhv0XlLwRB/8QeLdVwG+M=; b=UveFLF6slewNOFajxJfm6acApY
	9CdWGdd8N5p2HEkWjVuoPXqUOhdckLCSSgtB2wyqR7xpPbBGojtuOHBrw28fwVd9LruFzWNQDkEFu
	+HhgPt8iGboOL4kbyXdewIFnMWi5nG4nnGLfKLwSl2FRM38ECCgfcvGO7Aqv94qRL2AdYFA2mJBmi
	vn4mvbBDHMNI5iEfXcn8Ijc9BkaJ+hAXEkBt53nAqxw8lqQXppIYPeLV1j3Ha2Y38YaD3YWJIgfkJ
	GQQq6zUPV3J2up8E67Xy2Pqvuybxffte1IdmHxNOsC4XpR+xuwsXo2XmA8FQzNlRKC5kguk3UGh00
	hMi4Qi2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLrZD-00000000kNd-02Jx;
	Mon, 24 Jun 2024 21:49:39 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLrZ9-00000000kN5-4AGa
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jun 2024 21:49:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id DF584CE0F96;
	Mon, 24 Jun 2024 21:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEB7C2BBFC;
	Mon, 24 Jun 2024 21:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719265773;
	bh=NoMsGuylpEJI82FlH9CaAKGAu0TMQ1SmZandLQUgBAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YrOHeK73b3yB8k38TuJJReLU6gzg4sMKkvH5ANgXzeW5/xQx0OKtFTIRbxwFtRNoO
	 qan8ddebJOC2QYDsL3T9qBd+wCjcsOBhWbvnjEiScHqaF7mXWGAz39UwPh9emChG4N
	 V6rEYXBGH9SGmbzumMZD2RPyThE6hKDvS8bbhxHdG16qH7QboWHkWjX2tszqnqWC9Q
	 NiUXQ+3dBzRBx29nbiT0M1ipYMyznkgf/c+2PwnMbN2d4v06U513MEUxequy5lNQgp
	 +FZW0mQHVDW+7GSd4eM5ruRp9CrQScW/vre7iMKGhmOeBpayFlqbUzGTSCZX/x4Y7a
	 QYJbqEVjyAjDA==
Date: Mon, 24 Jun 2024 15:49:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: guanwentao@uniontech.com, huanglin@uniontech.com, axboe@fb.com,
	hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND. PATCH] nvme/pci: Add APST quirk for Lenovo N60z laptop
Message-ID: <Znnp6jIfcNYoDb2m@kbusch-mbp.dhcp.thefacebook.com>
References: <AFD9EEAB191702D0+20240622042108.10427-1-wangyuli@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AFD9EEAB191702D0+20240622042108.10427-1-wangyuli@uniontech.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_144936_234420_C29F0C63 
X-CRM114-Status: GOOD (  20.81  )
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

On Sat, Jun 22, 2024 at 12:21:08PM +0800, WangYuli wrote:
> There is a hardware power-saving problem with the Lenovo N60z
> board. When turn it on and leave it for 30 minutes, there is a
> 20% chance that a nvme disk will not wake up until reboot.
> 
> Signed-off-by: hmy <huanglin@uniontech.com>
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  drivers/nvme/host/pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 282d808400c5..1e0991667453 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2903,6 +2903,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
>  			return NVME_QUIRK_SIMPLE_SUSPEND;
>  	}
>  
> +	/*
> +	 * NVMe SSD drops off the PCIe bus after system idle
> +	 * for 30 minuites on a Lenovo N60z board.
> +	 */
> +	if (dmi_match(DMI_BOARD_NAME, "LXKT-ZXEG-N6"))
> +		return NVME_QUIRK_NO_APST;

Based on your commit message, it sounds like the platform works the
majority of the time. Is it possible that NVME_QUIRK_NO_DEEPEST_PS is
sufficient for this? Or do you really need to disable it entirely? The
power usage differences can be meaningful.

Also, 30 minutes of idle is an eternity for APST to kick in, so I'm
curious if there's something else going on here or if the breakage
occurs earlier than that.

