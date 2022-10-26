Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE124C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 12:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F0crHdE2hZ9v6vZdx+/Bi6/efznl0nuytc8l/nV3BRY=; b=atQoRmguHIEoYYscuRDe0ddNCj
	khoSmd6xnLAQLcjM7Cnv0uSg+Lyg40F5V94sjIrHD8+VewD3qnrkSPQ52HylMXj5so3rcUNVsUR56
	o6uqY36m9DMcHHFjI13GBvyjQksvrkuxHYNjGOc6dz4ZMXIMqOYU2qjmeGtOhFvHZmSkbMYDdf4YO
	S6j2vQak0YWvjPZQKxkCbIYFFgT+hLfoBVJ94vvHFqPjgFL1J93+gARQO+qsGzr0lrENEcjD3geny
	sWN3fy/ygM/6VT6sX5F4Az+RnvNc0oMgr2R0xcaHid2voYKnXwyCxLzQH9+huwO5jE5isWfek8xkm
	pvMR/g3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onfwv-009Jmb-36; Wed, 26 Oct 2022 12:56:01 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onfwr-009Jke-EV
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 12:55:58 +0000
Received: by mail-wr1-f41.google.com with SMTP id bp11so25620030wrb.9
        for <linux-nvme@lists.infradead.org>; Wed, 26 Oct 2022 05:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F0crHdE2hZ9v6vZdx+/Bi6/efznl0nuytc8l/nV3BRY=;
        b=QVWvMplNIw86DmBuNsRjv/TKwTNvmU2jl1NmZY1i1RXYjKpuw8RPhHpKIAgmvCTG8s
         w8o+UktsLD0FPzEE8w0t3QFZMWOWNMyx8ks+KM3bVrT7KXeri+khd0vOY/3lgTtoZ+m7
         83QK3f1P8Aj4zKWROT446oPLAYICHY/8jcM3CvkKwrjBpFNHh8pOdAWHQd47flRZ4igQ
         9ZH/e5ixn0ZRsxFRvXvY1pV/t+zYLjWLt0vasQC8X2EbfKfQQ5z+TaRggEq/76acFahI
         4eThOvKMG9lIbPA9J4wTK5u6nKO3ivwCiXjEU+wo986zYbUnUZsFZtPkiMnp71i81FmO
         aFUA==
X-Gm-Message-State: ACrzQf1dBoMz5TTbmfJlNGzMtISsoCZg3fthKohuQdUTMjQCJVQKoztV
	4OtdlWVnYvRa7AAVqtUMATillticL+8=
X-Google-Smtp-Source: AMsMyM5RkIWFpdjuQfuwzSBjuJDQWcLER6jVaPYuEUh5BKRgzHF7Vet6+OIlHKVHeV9X4LXdwj6u0g==
X-Received: by 2002:a05:6000:1561:b0:22e:6c59:e347 with SMTP id 1-20020a056000156100b0022e6c59e347mr29585871wrz.519.1666788956039;
        Wed, 26 Oct 2022 05:55:56 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o1-20020a05600c338100b003a3170a7af9sm1811759wmp.4.2022.10.26.05.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:55:55 -0700 (PDT)
Message-ID: <5ad559f0-d6c3-54c8-da0d-910b24d159b4@grimberg.me>
Date: Wed, 26 Oct 2022 15:55:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 10/17] nvme-pci: mark the namespaces dead earlier in
 nvme_remove
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-11-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025144020.260458-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_055557_518875_616A312D 
X-CRM114-Status: GOOD (  22.92  )
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


> When we have a non-present controller there is no reason to wait in
> marking the namespaces dead, so do it ASAP.  Also remove the superflous
> call to nvme_start_queues as nvme_dev_disable already did that for us.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/pci.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8ab54857cfd50..bef98f6e1396c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3244,25 +3244,19 @@ static void nvme_remove(struct pci_dev *pdev)
>   	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
>   	pci_set_drvdata(pdev, NULL);
>   
> +	/*
> +	 * Mark the namespaces dead as we can't flush the data, and disable the
> +	 * controller ASAP as we can't shut it down properly if it was surprise
> +	 * removed.
> +	 */
>   	if (!pci_device_is_present(pdev)) {
>   		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
> +		nvme_mark_namespaces_dead(&dev->ctrl);

Don't you need to start the queues as well here?

>   		nvme_dev_disable(dev, true);
>   	}
>   
>   	flush_work(&dev->ctrl.reset_work);
>   	nvme_stop_ctrl(&dev->ctrl);
> -
> -	/*
> -	 * The dead states indicates the controller was not gracefully
> -	 * disconnected. In that case, we won't be able to flush any data while
> -	 * removing the namespaces' disks; fail all the queues now to avoid
> -	 * potentially having to clean up the failed sync later.
> -	 */
> -	if (dev->ctrl.state == NVME_CTRL_DEAD) {
> -		nvme_mark_namespaces_dead(&dev->ctrl);
> -		nvme_start_queues(&dev->ctrl);
> -	}
> -
>   	nvme_remove_namespaces(&dev->ctrl);
>   	nvme_dev_disable(dev, true);
>   	nvme_remove_attrs(dev);

