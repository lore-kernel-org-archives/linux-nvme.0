Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962F0C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dcdjS5v23NWDIN34HXjSC3sLXETcq7/HOJuYeuBBLvE=; b=VKB1qI8UawUdW/pHkrNyp5o9tA
	ThdU92FhICJtyWS+M9pHlYCWe//eC2UBPHkccugkW+4UVY6qbLlVaEc83aFnXkorO5KlxLoqjPI4q
	pKOMVs14/OclkvWs7r5gIP7KNsJksRvDtsyGjPZiQMcKeq7ajvLbRePi1/vkUO0IBsSmmfu76PCep
	ca6v9Vpe7XmJqocrz8bhfOWADvmclWRuJHHDGtL3gr/sFKFDjgB5YWLZeWyf7eRGQcAmjbhhXu+Wo
	6GcGpnSLZTUZCnq5qUNrv8uCKSrblwgU/Pz3QpLXVJURCadM3PjcMU/6EwsTTuEd/38cJVlX1lBGM
	B9WLp3SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbNT-00ADhY-WC; Wed, 09 Nov 2022 03:03:48 +0000
Received: from mail-pf1-f171.google.com ([209.85.210.171])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbN5-00ADKv-7x; Wed, 09 Nov 2022 03:03:26 +0000
Received: by mail-pf1-f171.google.com with SMTP id q9so15494810pfg.5;
        Tue, 08 Nov 2022 19:03:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcdjS5v23NWDIN34HXjSC3sLXETcq7/HOJuYeuBBLvE=;
        b=36brw8hqsQVg8vX028/ahCWRy8bccUByVW2OdKl0oLv8+gIFEc7eZGpci5WP/5R8Q9
         PYgw4j38YCZ76hpk/WqMT3gQQK17qEC+vOa45U0GAsJGYpWpz5NeXEQw44hB+8jB4le8
         s+W8IS+xQ8ToTLH/NKWltX4MEZ7pQP3+RH1n4PqJR47F/3+KGAm/5GeveuZH7IfP7xbm
         SWp3n4UUrVb9Tk12wIcLnF30t2AZeDwXuZsHha8w9h+pd+R3eqI/4xNtlxbruNWe0HQV
         ZzAYjNqw8UmSrp7mD+TN0xbeefxWLxWy2HXMGVRSbuzIhlm42KDXiVtgbcO8HaHAHTip
         kAVQ==
X-Gm-Message-State: ACrzQf0rclgTtFH7/9Ae9JWWvPn1vy6NshmPyHVwjT96wCyDUpnKU8eS
	2QGrtyfD8m0wGg67TumG/9M=
X-Google-Smtp-Source: AMsMyM5+MGdwWFZnw4M/ggM3Igi/BOocV5GwjBEXtUBC9nlJxOgA0sgtfrW4+2f2+RMbxtn+qkJenA==
X-Received: by 2002:a05:6a00:35c9:b0:54c:9e75:ab7 with SMTP id dc9-20020a056a0035c900b0054c9e750ab7mr1114323pfb.82.1667963000957;
        Tue, 08 Nov 2022 19:03:20 -0800 (PST)
Received: from [172.20.3.206] (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id y27-20020aa79afb000000b0056dc34467b8sm7079932pfp.154.2022.11.08.19.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 19:03:20 -0800 (PST)
Message-ID: <b3cea6d6-f76e-8295-3537-a5b125b74bf4@grimberg.me>
Date: Wed, 9 Nov 2022 05:03:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 07/12] nvme-pci: factor out a nvme_pci_alloc_ctrl helper
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org
References: <20221108150252.2123727-1-hch@lst.de>
 <20221108150252.2123727-8-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221108150252.2123727-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_190323_332131_55370D7E 
X-CRM114-Status: GOOD (  19.64  )
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



On 11/8/22 17:02, Christoph Hellwig wrote:
> Add a helper that allocates the nvme_dev structure up to the point where
> we can call nvme_init_ctrl.  This pairs with the free_ctrl method and can
> thus be used to cleanup the teardown path and make it more symmetric.
> 
> Note that this now calls nvme_init_ctrl a lot earlier during probing,
> which also means the per-controller character device shows up earlier.
> Due to the controller state no commnds can be send on it, but it might
> make sense to delay the cdev registration until nvme_init_ctrl_finish.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/pci.c | 81 +++++++++++++++++++++++------------------
>   1 file changed, 46 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index f7dab65bf5042..e1f60b1c6918f 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2777,6 +2777,7 @@ static void nvme_free_tagset(struct nvme_dev *dev)
>   	dev->ctrl.tagset = NULL;
>   }
>   
> +/* pairs with nvme_pci_alloc_ctrl */
>   static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
>   {
>   	struct nvme_dev *dev = to_nvme_dev(ctrl);
> @@ -3090,19 +3091,23 @@ static void nvme_async_probe(void *data, async_cookie_t cookie)
>   	nvme_put_ctrl(&dev->ctrl);
>   }
>   
> -static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +static struct nvme_dev *nvme_pci_alloc_ctrl(struct pci_dev *pdev,
> +		const struct pci_device_id *id)

kinda weird that nvme_pci_alloc_ctrl return struct nvme_dev. Patch looks
fine though...

