Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEA4C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jJLCoeErP7NGXA7h4mOmQ4Hs15383nqSKzRthhPOXAk=; b=KsjJi3K8RpHkynd0UoBIlJaaWn
	g/dUB0yUu4uIYczV6JUbsextJPrWfCbxrx6jWU2YcINtTj7qgEgLp8qCQw9/clUhR8KRR1pkVhg5Y
	rF2uo9BksAJVNhOPtAAUyzz/FI8BZHYGuLqDnyeX56r9+fgHMvUArzNUZad8Uv0WpOakj1Pye+Ec6
	WhrF1QSKdXPpZVGy7K2V+XiCqv/+62qk5Dk98yptz8emBBhiECCZ2TW9ibmY4z8GhyS0hRijznUOw
	CrhwSH0sYr6+XnvlJ4oMKR8hMOT/0YOWR8QXi7xFcWrSgJuipGbwOkqNW8zzn+UkviIVE5v/F1tR0
	7OIXPWdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbXp-00AHnA-N3; Wed, 09 Nov 2022 03:14:29 +0000
Received: from mail-pf1-f179.google.com ([209.85.210.179])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbXS-00AHhe-Cn; Wed, 09 Nov 2022 03:14:08 +0000
Received: by mail-pf1-f179.google.com with SMTP id q9so15511723pfg.5;
        Tue, 08 Nov 2022 19:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJLCoeErP7NGXA7h4mOmQ4Hs15383nqSKzRthhPOXAk=;
        b=bgJh+qdhfDgi/Vf8VdDHmK06QumWCbHIexwc5AZjwnwlXYsZDntCy+4sBggBGoLrOF
         EDwgoP64SA2yMYE7bffNShGXXMxjpDKpkJi7CuMnJlGeipQI1ZCYKmUjbKEMQ/csmmlB
         AzA+gkO5sW589UEjQyASoJy4cdIvE9MDhmbEggpe1mikqwwwYBIs9QBks9FKj2syyvs4
         uAbC+EW311h2Y9i6oo/0fVRo3LXlH6I9qKqkZ3RDi4bwuB8Tgmbayo2NtSrY+rQiPOLB
         8pfdV/ZYlZIoonwl4f8j1BA/879pxZ9+pBLFOiyjkaXmfMW+dqjzaj/ikvqm/fyyiYpP
         AF5Q==
X-Gm-Message-State: ACrzQf3dyr62HfsaiP+1hkfA1p9ksZLBq14pfilpON4Pdyh5owk8AEtV
	JZFddEQG+N7+u9JK69lv4GM=
X-Google-Smtp-Source: AMsMyM6szvJKihNjg88j2zjJ1XUR0EB59+9bt2EAuWUthOMRbmz/p6iONvK2qHLMXcizxFahaO2svg==
X-Received: by 2002:a05:6a00:b4f:b0:56d:a232:6da7 with SMTP id p15-20020a056a000b4f00b0056da2326da7mr45572982pfo.22.1667963643954;
        Tue, 08 Nov 2022 19:14:03 -0800 (PST)
Received: from [172.20.3.206] (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709027ec800b0018703bf3ec9sm7661465plb.61.2022.11.08.19.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 19:14:03 -0800 (PST)
Message-ID: <e1225fb6-0cac-ba47-df03-0be84cb3a09b@grimberg.me>
Date: Wed, 9 Nov 2022 05:14:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 11/12] nvme-pci: split the initial probe from the rest
 path
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org
References: <20221108150252.2123727-1-hch@lst.de>
 <20221108150252.2123727-12-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221108150252.2123727-12-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_191406_489491_8A29C3E9 
X-CRM114-Status: GOOD (  31.92  )
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

Nice

On 11/8/22 17:02, Christoph Hellwig wrote:
> nvme_reset_work is a little fragile as it needs to handle both resetting
> a live controller and initializing one during probe.  Split out the initial
> probe and open code it in nvme_probe and leave nvme_reset_work to just do
> the live controller reset.
> 
> This fixes a recently introduced bug where nvme_dev_disable causes a NULL
> pointer dereferences in blk_mq_quiesce_tagset because the tagset pointer
> is not set when the reset state is entered directly from the new state.
> The separate probe code can skip the reset state and probe directly and
> fixes this.
> 
> To make sure the system isn't single threaded on enabling nvme
> controllers, set the PROBE_PREFER_ASYNCHRONOUS flag in the device_driver
> structure so that the driver core probes in parallel.
> 
> Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> Reported-by: Gerd Bayer <gbayer@linux.ibm.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/pci.c | 139 ++++++++++++++++++++++++----------------
>   1 file changed, 83 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 1b3c96a4b7c90..1c8c70767cb8a 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2821,15 +2821,7 @@ static void nvme_reset_work(struct work_struct *work)
>   	result = nvme_pci_enable(dev);
>   	if (result)
>   		goto out_unlock;
> -
> -	if (!dev->ctrl.admin_q) {
> -		result = nvme_pci_alloc_admin_tag_set(dev);
> -		if (result)
> -			goto out_unlock;
> -	} else {
> -		nvme_start_admin_queue(&dev->ctrl);
> -	}
> -
> +	nvme_start_admin_queue(&dev->ctrl);
>   	mutex_unlock(&dev->shutdown_lock);
>   
>   	/*
> @@ -2854,9 +2846,6 @@ static void nvme_reset_work(struct work_struct *work)
>   		 */
>   		memset(dev->dbbuf_dbs, 0, nvme_dbbuf_size(dev));
>   		memset(dev->dbbuf_eis, 0, nvme_dbbuf_size(dev));
> -	} else {
> -		if (dev->ctrl.oacs & NVME_CTRL_OACS_DBBUF_SUPP)
> -			nvme_dbbuf_dma_alloc(dev);
>   	}
>   
>   	if (dev->ctrl.hmpre) {
> @@ -2869,37 +2858,23 @@ static void nvme_reset_work(struct work_struct *work)
>   	if (result)
>   		goto out;
>   
> -	if (dev->ctrl.tagset) {
> -		/*
> -		 * This is a controller reset and we already have a tagset.
> -		 * Freeze and update the number of I/O queues as thos might have
> -		 * changed.  If there are no I/O queues left after this reset,
> -		 * keep the controller around but remove all namespaces.
> -		 */
> -		if (dev->online_queues > 1) {
> -			nvme_start_queues(&dev->ctrl);
> -			nvme_wait_freeze(&dev->ctrl);
> -			nvme_pci_update_nr_queues(dev);
> -			nvme_dbbuf_set(dev);
> -			nvme_unfreeze(&dev->ctrl);
> -		} else {
> -			dev_warn(dev->ctrl.device, "IO queues lost\n");
> -			nvme_mark_namespaces_dead(&dev->ctrl);
> -			nvme_start_queues(&dev->ctrl);
> -			nvme_remove_namespaces(&dev->ctrl);
> -			nvme_free_tagset(dev);
> -		}
> +	/*
> +	 * Freeze and update the number of I/O queues as thos might have
> +	 * changed.  If there are no I/O queues left after this reset, keep the
> +	 * controller around but remove all namespaces.
> +	 */
> +	if (dev->online_queues > 1) {
> +		nvme_start_queues(&dev->ctrl);
> +		nvme_wait_freeze(&dev->ctrl);
> +		nvme_pci_update_nr_queues(dev);
> +		nvme_dbbuf_set(dev);
> +		nvme_unfreeze(&dev->ctrl);
>   	} else {
> -		/*
> -		 * First probe.  Still allow the controller to show up even if
> -		 * there are no namespaces.
> -		 */
> -		if (dev->online_queues > 1) {
> -			nvme_pci_alloc_tag_set(dev);
> -			nvme_dbbuf_set(dev);
> -		} else {
> -			dev_warn(dev->ctrl.device, "IO queues not created\n");
> -		}
> +		dev_warn(dev->ctrl.device, "IO queues lost\n");
> +		nvme_mark_namespaces_dead(&dev->ctrl);
> +		nvme_start_queues(&dev->ctrl);
> +		nvme_remove_namespaces(&dev->ctrl);

Is this needed? isn't nvme_remove coming soon?
In fact, shouldn't all these calls be in nvme_remove?

