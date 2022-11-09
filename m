Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8883C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 02:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jo4xR/pUNsKnj3WjKfoigi4Co6csB1ZmrHFREpcuF1s=; b=SZchEuYGdX+E4mZbXcWw/vQhCT
	I3w8tWYGjqCJVwz0Bytg67tfcQAvLz1QVnEIppgDQNQBTWmSCGn57GKzeq+9U2bcQcAimRFqDHw8t
	vJR85ygR7nRfxcbKwSDAeIKV5sRNAvj/r8dgIQ6meWgUSKrxbKKSbLZ8UVfnEuIjVAGdX3wRsUeEN
	kcrWkdC1IfItSAEhfABwjz/ESXcVCWf+TN3JUKyyLbPaZ55TmOHtbgIIRzh5PbnjzXM9ibveGxvJR
	53rYm6NXBfijszSudL6EmqPqwXs7Xt2UQng+Yqj9FhoPJgSZhAkLEmaJCo9B5GR/tLdQwLpxvkNXA
	wnFLn/aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbIy-00A8AM-1j; Wed, 09 Nov 2022 02:59:08 +0000
Received: from mail-pl1-f174.google.com ([209.85.214.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbIg-00A83Z-Ek; Wed, 09 Nov 2022 02:58:51 +0000
Received: by mail-pl1-f174.google.com with SMTP id j12so15870668plj.5;
        Tue, 08 Nov 2022 18:58:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jo4xR/pUNsKnj3WjKfoigi4Co6csB1ZmrHFREpcuF1s=;
        b=Jas8EhYF8GU7kNBgR68KXclZjyNRxeQxUw57O0viLtuyr0cQFldNjOgk0IyC87qWxB
         4oGaJvrukeeVMWIlNFLY0SLsOCLpaYhP7Jn1rZFaNQYWIvOiDJ7O/pHjdVe3/Vj7aKEn
         g+LQahC1iwUbNEVaWaBtYCzqBluDfzN7nLp6ceCVNV3fHTBQZ9DgNrPyzasKHrSuWUy3
         duOMvpvZs1+oSKuMgutaTZfiT9JDWv8PRICbiIJp/oYpZzOUy/jMotshH1N9GEmRPPY+
         qSO2tVaImuasVz6Rfx1eIYN37Snujyk5Pgy084o/a0duL9VezBaHQoGRLET393gAn64a
         szRQ==
X-Gm-Message-State: ACrzQf3e7uzEUNm0jD/daP7HMkgbcN2DHj+/yfsrFWoECdgnVP3LI2lE
	S2gLIMrLzvJaJJFFycekCxc=
X-Google-Smtp-Source: AMsMyM7nNKpM2sqfnSpNiB1PxHaW474pn/nGKUEXugWnJj0STNbTE3okVoUAy3CfZb/aYCmV3NyTvA==
X-Received: by 2002:a17:902:eccc:b0:186:5f09:f9 with SMTP id a12-20020a170902eccc00b001865f0900f9mr58623695plh.6.1667962729090;
        Tue, 08 Nov 2022 18:58:49 -0800 (PST)
Received: from [172.20.3.206] (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id pv3-20020a17090b3c8300b001fd6066284dsm44220pjb.6.2022.11.08.18.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 18:58:48 -0800 (PST)
Message-ID: <679cf80b-3e30-e393-d5c4-d3941e853bfb@grimberg.me>
Date: Wed, 9 Nov 2022 04:58:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 04/12] nvme-pci: put the admin queue in
 nvme_dev_remove_admin
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org
References: <20221108150252.2123727-1-hch@lst.de>
 <20221108150252.2123727-5-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221108150252.2123727-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_185850_537665_3FCBFA7F 
X-CRM114-Status: GOOD (  16.42  )
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


> Once the controller is shutdown no one can access the admin queue.  Tear
> it down in nvme_dev_remove_admin, which matches the flow in the other
> drivers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/pci.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c8f6ce5eee1c2..f526ad578088a 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1747,6 +1747,7 @@ static void nvme_dev_remove_admin(struct nvme_dev *dev)
>   		 */
>   		nvme_start_admin_queue(&dev->ctrl);
>   		blk_mq_destroy_queue(dev->ctrl.admin_q);
> +		blk_put_queue(dev->ctrl.admin_q);
>   		blk_mq_free_tag_set(&dev->admin_tagset);
>   	}
>   }
> @@ -2774,8 +2775,6 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
>   
>   	nvme_dbbuf_dma_free(dev);
>   	nvme_free_tagset(dev);
> -	if (dev->ctrl.admin_q)
> -		blk_put_queue(dev->ctrl.admin_q);

Is the check here valid? meaning can we get here with
a NULL admin_q?

In any event, looks good
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

