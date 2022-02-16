Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0868CC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 12:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q+RpnxgQYsABHzLXlYYtzivoXu90cGIoZb6pLh2bx7E=; b=VOolrbJCrc1ThNO7BdovDmQMDN
	OXylO3V+44zu18sZ65CVNC1hnzfQL7JKYW7x+FXdqlhxDfcS9YVhUNgO/Si75wNOC0h2p6kzuXfF9
	kAtivRNuzkoOBOUwyOygvONGC9WrO2FL3o1u3SQ58/JSrwxB2CfPODdhgxn51eYUUMjI7XAC1IxU8
	rv+ENJpE2svd1SZxlVw+Q0kDcTWsVZhIhhZ6g0xEOYD+TJ/4hr2vrc/jdPvT1gHRudWNwY9GtcQA/
	O3hJlsJfU/b8Hl6U4TZUsb+GcvKz6WEULqbZHkrhlXLzvBkYEDcsOGyuU0IQ6uCtpIYBV0GIMc+84
	mpCRFzbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKJhG-006z5O-AP; Wed, 16 Feb 2022 12:46:14 +0000
Received: from mail-yb1-f170.google.com ([209.85.219.170])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKJhD-006z48-Ht
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 12:46:13 +0000
Received: by mail-yb1-f170.google.com with SMTP id p5so5542713ybd.13
 for <linux-nvme@lists.infradead.org>; Wed, 16 Feb 2022 04:46:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q+RpnxgQYsABHzLXlYYtzivoXu90cGIoZb6pLh2bx7E=;
 b=V+77qGND0wGpFT8VkuTlzsYymtb4eHY8m3VTZc42ehUAWE0HwfFfRnbyJxjoGtCwGh
 aNY04AmEMqPeKjhrsJPSnsY1SWkoycUtimVOun7meN30fBkPYgIMuPJgtZ1/qqj7F9Rm
 E941Pj8gAOoKwJb3UzDdy2W4s5fNL2IcTV5kmCr0DOUPffoF1mRxMJO2da0blxI4uhfx
 bLOfDsTgPdQGS7vsapG1HarAiLGStie0YUs1d5qiTAWPOCNLEBzwpqgkllQfzKat6AqV
 AXMxctGT/N2+UfOcYuyeDXrU0ttlRC1fWlGKl+cEy6V3VectXgGKcVIgTJ9FxlxX+Ll6
 WiMw==
X-Gm-Message-State: AOAM5319/zL7KAVMuju7lTsotYlVFnRyH+2VN6D+g9eWvJJVcZclWJgd
 HMC1KyNcs5HpyBjV7PdwyuHw29rI33+wzwHwDEA=
X-Google-Smtp-Source: ABdhPJyu3SGqfc3m5JmfkgPAjKHdhId1Ymd1Jaz4/vn89KjGMtW9NxebArqD+lrpBaFRf/Fb0+RGyX9wRDnz0nubHe8=
X-Received: by 2002:a05:6902:1370:b0:61d:fc48:6df5 with SMTP id
 bt16-20020a056902137000b0061dfc486df5mr1847440ybb.272.1645015570228; Wed, 16
 Feb 2022 04:46:10 -0800 (PST)
MIME-Version: 1.0
References: <20220210152233.1657933-1-kbusch@kernel.org>
 <20220216084313.GA11360@lst.de>
In-Reply-To: <20220216084313.GA11360@lst.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 Feb 2022 13:45:57 +0100
Message-ID: <CAJZ5v0jt7St9by2gHsEPBU_-i80q_Wgsty=5XrSj0QoT0sEKng@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: simple suspend quirk for vmd devices
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, m.heingbecker@googlemail.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_044611_614707_9C108190 
X-CRM114-Status: GOOD (  21.09  )
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

On Wed, Feb 16, 2022 at 9:43 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Feb 10, 2022 at 07:22:33AM -0800, Keith Busch wrote:
> > Bug reports from users tell us platfroms with vmd enabled regressed
> > power when using nvme power management on s2idle. We can't get the
> > StorageD3Enable property on such devices so the driver used the wrong
> > suspend method. Add a simple suspend quirk for the domain since that is
> > the safest option.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=215467
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>
> Rafael, can you try this on the affected platform?
> (not for merge as-is)

I can't really do that myself (no access to the system in question),
but I've just asked the original reporter (CCed) to do it.

>
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 9e1e6b8d88763..49f4e54da919d 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -723,4 +723,5 @@ struct pci_dev *pci_real_dma_dev(struct pci_dev *dev)
>
>         return dev;
>  }
> +EXPORT_SYMBOL_GPL(pci_real_dma_dev);
>  #endif
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6a99ed6809158..6edc8c514cbc8 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3086,7 +3086,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>
>         quirks |= check_vendor_combination_bug(pdev);
>
> -       if (!noacpi && acpi_storage_d3(&pdev->dev)) {
> +       if (!noacpi && acpi_storage_d3(&pci_real_dma_dev(pdev)->dev)) {
>                 /*
>                  * Some systems use a bios work around to ask for D3 on
>                  * platforms that support kernel managed suspend.

