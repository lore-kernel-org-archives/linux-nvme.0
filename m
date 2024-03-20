Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1174FC54E67
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Mar 2024 10:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CN58u+/n2F3Ys0dhczNgOif/Qz40ovyZGT7dFSjoewg=; b=zE61X3hJ584Vtyu/tZqjhvJr2p
	yz+t2EFWfQaSboiRqCvnBzvZjHF1z1Wn5j3N8oOegutUzYOARK/0hJCPSwpZ/x0lxFEgK0+2sH56N
	WyP3yzvKDc+4dSSgmVRiXQ1kYF2pPGjOODKBxnJB7GoskqJUQ1M6Jua458uSfZpxzYGu9TteQuhpA
	451TTP+ZUfTkADCOvkQRCO2+IndBtUCnwJmR6sv/yXPvTUh88csx1nJZBR/5uCmv8BTcvz6/P3zPO
	7GP9UQW4PYH4+JMKMeFXSMBGea5Gc2R0KVrhzw8tcWsKGw4qTxnkde2bB+Na3sr/hM2jL4w9TEIlP
	NF7usRoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmtRg-0000000GpPO-1IUT;
	Wed, 20 Mar 2024 10:45:20 +0000
Received: from mail-lj1-f169.google.com ([209.85.208.169])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmtRa-0000000GpOk-23bV
	for linux-nvme@lists.infradead.org;
	Wed, 20 Mar 2024 10:45:16 +0000
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d49871732fso10810451fa.1
        for <linux-nvme@lists.infradead.org>; Wed, 20 Mar 2024 03:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710931510; x=1711536310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CN58u+/n2F3Ys0dhczNgOif/Qz40ovyZGT7dFSjoewg=;
        b=s+IpO/ohxyXmQN+hpU7CBWBz0nJ0K1SrKNii4hxCPlGb0uCbMoQ0JHLNHtWXLw81OC
         Roi6goXAzZr/CSpikGdYLmED+s5P+dLUPYOtn5gvjWvpl2Q8jDR/ZsMVC+603k8XtVI0
         G3QOZB8/hB7tbau5A16jOGPvyyecWPNA2RgBTMenb6SVSAwgBQoF0Bdm8q/ciEBXVzPc
         6wFAIAIUBKPrSpVvVklcBJCoOh8pxJLzn/+ppnLodTxfYMtfva3Yefa2iY+V6ccyHijS
         BEbbM3ajJBuBMgVBz0CfdbXposu/cf8sVrg5qBuObZw9/yS12DWmZWSlsjFB82SlnAEr
         59bg==
X-Gm-Message-State: AOJu0Ywnq+PBqgLZaiWI5GGADekFJGbpmK0tMIvqOgcUgJC+hnPbcgIz
	BuwkesU3JDfBCLRE2sOmCC5WI6RW3h01ehN5wH0CroW5WaO+jUpz
X-Google-Smtp-Source: AGHT+IHw3X/+ZICiggx9a6efFBSvDkE6AGpq5rYtthnsmRvSHEzhL+B6JDn2pfFsZqJM1JWVCFhAkA==
X-Received: by 2002:a2e:8691:0:b0:2d4:7575:4aa3 with SMTP id l17-20020a2e8691000000b002d475754aa3mr3414537lji.4.1710931510270;
        Wed, 20 Mar 2024 03:45:10 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id hn25-20020a05600ca39900b0041462a42c82sm1761016wmb.17.2024.03.20.03.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 03:45:09 -0700 (PDT)
Message-ID: <bca94901-3d77-4779-851f-d121efff3fbf@grimberg.me>
Date: Wed, 20 Mar 2024 12:45:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-rdma: remove NVMET_RDMA_REQ_INVALIDATE_RKEY flag
Content-Language: he-IL, en-US
To: Guixin Liu <kanie@linux.alibaba.com>, hch@lst.de, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20240320092035.22546-1-kanie@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240320092035.22546-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_034514_776614_E9F61A18 
X-CRM114-Status: GOOD (  16.45  )
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



On 20/03/2024 11:20, Guixin Liu wrote:
> We can simply use invalidate_rkey to check instead of adding a flag.
>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/nvme/target/rdma.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index f2bb9d95ecf4..d0bc72c75471 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -53,7 +53,6 @@ struct nvmet_rdma_cmd {
>   
>   enum {
>   	NVMET_RDMA_REQ_INLINE_DATA	= (1 << 0),
> -	NVMET_RDMA_REQ_INVALIDATE_RKEY	= (1 << 1),
>   };
>   
>   struct nvmet_rdma_rsp {
> @@ -722,7 +721,7 @@ static void nvmet_rdma_queue_response(struct nvmet_req *req)
>   	struct rdma_cm_id *cm_id = rsp->queue->cm_id;
>   	struct ib_send_wr *first_wr;
>   
> -	if (rsp->flags & NVMET_RDMA_REQ_INVALIDATE_RKEY) {
> +	if (rsp->invalidate_rkey) {
>   		rsp->send_wr.opcode = IB_WR_SEND_WITH_INV;
>   		rsp->send_wr.ex.invalidate_rkey = rsp->invalidate_rkey;
>   	} else {
> @@ -905,10 +904,8 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma_rsp *rsp,
>   		goto error_out;
>   	rsp->n_rdma += ret;
>   
> -	if (invalidate) {
> +	if (invalidate)
>   		rsp->invalidate_rkey = key;
> -		rsp->flags |= NVMET_RDMA_REQ_INVALIDATE_RKEY;
> -	}
>   
>   	return 0;
>   

Who clears invalidate_rkey between executions?
I think you need to clear right after nvmet_rdma_get_rsp()

