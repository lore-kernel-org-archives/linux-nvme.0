Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39220C3DA7F
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Aug 2024 15:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ArMWgDQDYLq/ioaxV4ghnnXCvuJu563bM+/egLbjmJY=; b=hdyR+nHBUQBuLNnMj8X0s+EAsd
	AxGhpIyb39/RCRx4VL03cFbuFUpSUU9OXDrxQQhorYFKLp0/DE42zHxxoGEhBOMypQLIsvfdEQWtP
	Ns4bxOfsdiLOEKknskN3tj0bdB4B9SPFjJk484fKfHVUGtzZtRhyWIPJDwOKgGSLjorhuYkpxW3Wc
	eh1pgja7wuBUbfEOPGWA0rJJNSjPESdo9bSSkwby30zSJp6S9erMxlTvvmniER0vmI1FFTMaEu8EE
	7eIgYpPr2ggK960ZaHVAFVZt7L4/MnMz+EFqknxKjBKWFI0XQLyX8yFoXE+grkANuE51tj0OybFss
	YgpK55JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdWns-00000000iBD-2EIM;
	Mon, 12 Aug 2024 15:17:48 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdWnp-00000000i9S-2JQB
	for linux-nvme@lists.infradead.org;
	Mon, 12 Aug 2024 15:17:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D38DD612AB;
	Mon, 12 Aug 2024 15:17:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11974C32782;
	Mon, 12 Aug 2024 15:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723475864;
	bh=yERMwJgIICRfeV5w3b1sXJuK7frQz3Y5ncuJJC5ndNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OnirtJOLwtNs0yNZEf8C5bnFuzByMxWm//sc4POK49wSW3cu351f/6xvsFEkuQMRw
	 pUSEr/3zgokkvNbgdiNADAFaqINNU7274vLPx8tPhAAMUAyehJ9/e4/pFuZfcDQdvr
	 D0thJQ7/XabiL5R3pj/N1+1oiqs/vr91pfzH08zeKFXEW3iA2vpbRiuqqwDDwMShyO
	 eULqrjtaiLCSqlIHfNXiS77nPSAAwvsud9oBLxPirRoTAmcMq8ZdJijOuA5T+67KHE
	 xCXlCxSg10ej8R298ZhTSBwBoBVFJc9/HrhZ8oNAfQctzXriscA+5LgvKnhfvkOdIU
	 sYuP79LmqlgPg==
Date: Mon, 12 Aug 2024 09:17:41 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/9] nvme-tcp: check for invalidated or revoked key
Message-ID: <ZronlWGQ81fa6XSx@kbusch-mbp>
References: <20240722120226.88737-1-hare@kernel.org>
 <20240722120226.88737-4-hare@kernel.org>
 <ZqeqqK3XBk_eoyZb@kbusch-mbp>
 <9192ada0-0be6-4fad-8d2d-a26bebe934be@grimberg.me>
 <659e9317-9f68-4264-b976-f8f13184c4da@suse.de>
 <e9d1d499-8491-4883-bdf5-01aa28e42c7c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9d1d499-8491-4883-bdf5-01aa28e42c7c@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240812_081745_677161_B01DDB5D 
X-CRM114-Status: GOOD (  13.92  )
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

On Mon, Aug 12, 2024 at 04:09:01PM +0200, Hannes Reinecke wrote:
> Should be fixed with:
> 
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index a3caef75aa0a..883aaab2d83e 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -109,6 +109,7 @@ config NVME_HOST_AUTH
>         bool "NVMe over Fabrics In-Band Authentication in host side"
>         depends on NVME_CORE
>         select NVME_AUTH
> +       select NVME_KEYRING if NVME_TCP_TLS
>         help
>           This provides support for NVMe over Fabrics In-Band Authentication
> in
>           host side.
> 
> Will send an updated series.

If this is the only change you have, no need to resend. Looks good on my
end, I've pushed this out to the nvme tree a few minutes ago.

