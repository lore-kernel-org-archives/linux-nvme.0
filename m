Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B1BC352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 10:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yf0pg6HyCZe9RGQZhR7ZfKdQUaSK6G751H86Hj4Y1Nw=; b=eC6LIIzLdtT6zSoHTeQXdpeCvd
	Pq22ck7hLXPPGV0BzvSMsyq3eRJq5LFwEQmE3PxX1/hg8ai6JfpnimoskabikRX0E8vHxQ0aVpn9o
	0cU4EU/LgAQHoa3h2EvHagO03RpgidedYTjBdmxrWppU8SnkkykoPfGz731SLfgIp+XxIgE7/Y4nA
	3HyV8JUYxnon5UYf3s9dA5/eQ8g5Z2CJBEW2DUJYYDtIKrdFdlzWwRI3ZzAsHTwrFmz63xPwlnOMr
	QNXL1hyNJ+ZZd/wmusCiibOJRiqyQEDyM/Uc5UCzIBPcZaWNqyeRTX4M7EsFE8yuzNw3fyLPwXlqV
	78RaPjVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2VM3-007BVe-Jx; Tue, 06 Dec 2022 10:39:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2VM1-007BHh-0G
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 10:39:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670323150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yf0pg6HyCZe9RGQZhR7ZfKdQUaSK6G751H86Hj4Y1Nw=;
	b=CcsAyNfTWr9O9dA/g63u7d1GdT/T7TfUgUkj1ltlFOn9Xq6ZtEavtyXymZdG1IBWGRdzO9
	iFDKCFWqmo8YuZT1O19UsMaJTFwdNh4g5rRQW0Khq/rZMhmtI5AJPSlBQBVn4Q8ULWfZ1f
	K8lP/XW7v9ZjTkoZgoL6CMRjtd4nkUI=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-487-y96Kgbn1NGiDozd1mwl_cQ-1; Tue, 06 Dec 2022 05:39:09 -0500
X-MC-Unique: y96Kgbn1NGiDozd1mwl_cQ-1
Received: by mail-vk1-f200.google.com with SMTP id b77-20020a1f1b50000000b003bbf35b919bso6650606vkb.11
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 02:39:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yf0pg6HyCZe9RGQZhR7ZfKdQUaSK6G751H86Hj4Y1Nw=;
        b=W0nM6ffiD9D+rK99XBl/t6mnsG5+iRzpDYL6RZhwCQ3B7KG9fE9R1vHoUHln1Iz4ww
         bY0Yn6WZ+ZAv2sMF4FKrEbUmmrB57FGA9mFFAe2cjM4rodiScYmzqUYP7EeT8kLGEtm4
         /ZcCFD2SSHTFf4AuiAqxB1B0B1PExay6kn07cGv8dKlKldF9AW9u8ocK8NV3Msx/5aoY
         AIRoWjCgB169YWOn/FFdBwjfjmqHiCe5jFkL+q7E52XNdcvE16N9hOmDgDDrsmziBMBE
         WewpxvzJoEK+mpwmyNaRIGPQM1tNVrEQAexlpt46M+VkEZ0u8FVNqaPrzlyjEddbdO0S
         6Djw==
X-Gm-Message-State: ANoB5pniNdCqTVDETIGZx7VH4TzNwUdQ6H/Gdo83xWtS5IYTfCl1fzfQ
	GvqHjf1hyBTCrn5dn3KUo+CQGUieIgLIBr4VGGDbuPaJT4+pi+7/t55pn5xz8bF9rV7nASXB033
	IEFTECosxO/Q//4kS/B+SCh+trWd8Lx3dh92GgKVEwcI=
X-Received: by 2002:a67:ce12:0:b0:3ad:9714:5d75 with SMTP id s18-20020a67ce12000000b003ad97145d75mr39536684vsl.77.1670323148956;
        Tue, 06 Dec 2022 02:39:08 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4cUeNKmGdXVLA6X9buYSxafC1NlN9zBrzcpjrS4ND+WQZsoBpcnv1A1LpypKpiHWopac0rR5uFVRZHCcRQfKY=
X-Received: by 2002:a67:ce12:0:b0:3ad:9714:5d75 with SMTP id
 s18-20020a67ce12000000b003ad97145d75mr39536673vsl.77.1670323148771; Tue, 06
 Dec 2022 02:39:08 -0800 (PST)
MIME-Version: 1.0
References: <20221129132208.4337-1-hch@lst.de> <20221129132208.4337-5-hch@lst.de>
In-Reply-To: <20221129132208.4337-5-hch@lst.de>
From: Eric Curtin <ecurtin@redhat.com>
Date: Tue, 6 Dec 2022 10:38:52 +0000
Message-ID: <CAOgh=FyTsAgXMOuPhh-YG1Cj3QH6_6vwB9cWrxk6XTchE5P_mg@mail.gmail.com>
Subject: Re: [PATCH 4/9] nvme-pci: remove nvme_disable_admin_queue
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, asahi@lists.linux.dev, 
	linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_023913_144051_69D5C445 
X-CRM114-Status: GOOD (  17.54  )
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
> nvme_disable_admin_queue has only a single caller, and just calls two
> other funtions, so remove it to clean up the remove path a little more.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

> ---
>  drivers/nvme/host/pci.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 84226dce9b3b92..c6a02210d22b46 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1496,14 +1496,6 @@ static void nvme_suspend_io_queues(struct nvme_dev *dev)
>                 nvme_suspend_queue(&dev->queues[i]);
>  }
>
> -static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
> -{
> -       struct nvme_queue *nvmeq = &dev->queues[0];
> -
> -       nvme_disable_ctrl(&dev->ctrl, shutdown);
> -       nvme_poll_irqdisable(nvmeq);
> -}
> -
>  /*
>   * Called only on a device that has been disabled and after all other threads
>   * that can check this device's completion queues have synced, except
> @@ -2711,7 +2703,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>
>         if (!dead && dev->ctrl.queue_count > 0) {
>                 nvme_disable_io_queues(dev);
> -               nvme_disable_admin_queue(dev, shutdown);
> +               nvme_disable_ctrl(&dev->ctrl, shutdown);
> +               nvme_poll_irqdisable(&dev->queues[0]);
>         }
>         nvme_suspend_io_queues(dev);
>         nvme_suspend_queue(&dev->queues[0]);
> --
> 2.30.2
>
>


