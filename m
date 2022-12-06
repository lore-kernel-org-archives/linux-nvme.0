Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54FBC352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 10:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EjxcT7s0G6NzdYkLLEMRpVnPO3NSARFPUey6LwGz4bY=; b=pBCGRWA48vxg/x0rQoR9GRaIPQ
	GcoqhAEHhw9OYYndmXnqRJbP6ztXDvXqk6+lxmS7UTKBze6INY9+MSvSyzAeZtuvJfatB7h3E+jdT
	RUPmt2NvgUL1VWVgCLyZzs2Vx1XVN5ch7DobP2sChX+rpQ4qSA/FoWDepIHvdien+mLLmxuSBDsQ3
	LuLkDVUgUVdaeNWWvJUAsMV6NYc/BP5kxt0r/nmxpagDR/USyF8Nv855HvsvOUr0uknMCCYZwHCes
	QlCViNeSgItJBRM+ZJ3E2l2kmcy2BXTYXlgrMLb14wT8kat1drbdux1Tx2DgjkWavOyCKu1Jdjxf7
	wwsCKZdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2VMR-007CfK-8j; Tue, 06 Dec 2022 10:39:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2VMH-007CFI-Di
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 10:39:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670323168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EjxcT7s0G6NzdYkLLEMRpVnPO3NSARFPUey6LwGz4bY=;
	b=fZT07vvXny3es16yTqX+nw/W9Pbvlbg7xLV/tIUtknBxgh0cxfP2Km2hFDD8R2jnS/8yO0
	RT/ATqSvdQ54vLfJxt3eFF3Ha6XynWlkTDf07NKAfpX1jjS/+T7PSCKC1WLrjKS/tMZyHy
	znjZ1sq1qVrYdvsiXfs21iGuezKeDTI=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-301-uMV_55xVMiyQoKfCUNm-Rw-1; Tue, 06 Dec 2022 05:39:27 -0500
X-MC-Unique: uMV_55xVMiyQoKfCUNm-Rw-1
Received: by mail-ua1-f69.google.com with SMTP id p18-20020ab01552000000b003e348b9ba6fso7471934uae.14
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 02:39:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjxcT7s0G6NzdYkLLEMRpVnPO3NSARFPUey6LwGz4bY=;
        b=ynxuo5ifIuhuHLapEuAOmPqLp3Ax/vZE5aMtn9pXad+LCZhJNabuyHOJcy3UKjgMpi
         rjN1qn2AF99A02XTFSxoId5qGbNVSl6KwYslvjye62dvk3Fu60QAoQGTF5IzNqRM8sBz
         zsPnulkvPQovK8whSEekaSwXh5msqn9jja9hOc85mxVjITb6Eb//ANwApX0/9ZOsddnQ
         jlM9roGjMSRVXikppIXFHz3dWKbQIWQWJeUFWAPg9dzqdFLoa1dgV2CpGgGpxqQ0Pq1D
         KzFK/7L8ZpLdQBkJuuj/fQ/P53HEQ6wB+2tCjOrl8CF5ZfC8LmCwlDJ7auWdGqRZuOnl
         SE7g==
X-Gm-Message-State: ANoB5pnTMcc6P2VjasOSCheasUuynifQ4FOMwwazV7tPg71I/gBwvrfl
	Rb/pF+f6LBZLg1RIPPlNi7doIh9C0iRCMxRYA4Dy7f0Mixqy3NWRfnKZwObZJNrQKRsl0p/42bf
	iykK6V2Il2llWLZIwbZdYm9aLd5N8hyh3/jagc4u6guE=
X-Received: by 2002:a1f:1b0d:0:b0:3b3:b114:8ff1 with SMTP id b13-20020a1f1b0d000000b003b3b1148ff1mr39568030vkb.17.1670323166702;
        Tue, 06 Dec 2022 02:39:26 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6yc6cX/hNx5MTrfR2LYsczoNPUfT6CJCiQYSwq0/Hyjhtm5KhZdvPxTDOplcZ1aknwFY5owbiCI3znrOgZZWA=
X-Received: by 2002:a1f:1b0d:0:b0:3b3:b114:8ff1 with SMTP id
 b13-20020a1f1b0d000000b003b3b1148ff1mr39568015vkb.17.1670323166513; Tue, 06
 Dec 2022 02:39:26 -0800 (PST)
MIME-Version: 1.0
References: <20221129132208.4337-1-hch@lst.de> <20221129132208.4337-6-hch@lst.de>
In-Reply-To: <20221129132208.4337-6-hch@lst.de>
From: Eric Curtin <ecurtin@redhat.com>
Date: Tue, 6 Dec 2022 10:39:10 +0000
Message-ID: <CAOgh=FxeOUAeyY1xZGoWO1OGRRK4Usdx_E_h_C3T22iw4Vut5Q@mail.gmail.com>
Subject: Re: [PATCH 5/9] nvme-pci: remove nvme_pci_disable
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, asahi@lists.linux.dev, 
	linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_023929_574223_9FC4FD9A 
X-CRM114-Status: GOOD (  16.84  )
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

On Tue, 29 Nov 2022 at 13:29, Christoph Hellwig <hch@lst.de> wrote:
>
> nvme_pci_disable has a single caller, fold it into that.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

> ---
>  drivers/nvme/host/pci.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c6a02210d22b46..c3d9b23699d3f3 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2657,18 +2657,6 @@ static void nvme_dev_unmap(struct nvme_dev *dev)
>         pci_release_mem_regions(to_pci_dev(dev->dev));
>  }
>
> -static void nvme_pci_disable(struct nvme_dev *dev)
> -{
> -       struct pci_dev *pdev = to_pci_dev(dev->dev);
> -
> -       pci_free_irq_vectors(pdev);
> -
> -       if (pci_is_enabled(pdev)) {
> -               pci_disable_pcie_error_reporting(pdev);
> -               pci_disable_device(pdev);
> -       }
> -}
> -
>  static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  {
>         bool dead = true, freeze = false;
> @@ -2708,7 +2696,11 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>         }
>         nvme_suspend_io_queues(dev);
>         nvme_suspend_queue(&dev->queues[0]);
> -       nvme_pci_disable(dev);
> +       pci_free_irq_vectors(pdev);
> +       if (pci_is_enabled(pdev)) {
> +               pci_disable_pcie_error_reporting(pdev);
> +               pci_disable_device(pdev);
> +       }
>         nvme_reap_pending_cqes(dev);
>
>         nvme_cancel_tagset(&dev->ctrl);
> --
> 2.30.2
>
>


