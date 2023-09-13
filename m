Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8326CA553A
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Sep 2023 10:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Esn3bDVPqFAsAFDnhhKPSrWoO2OiXMkjdGA2/ZknMxY=; b=PpIGI7CYsljQFgZOPWQoptno9M
	IlVqAJ8yoYM40PMEEc0dHNSbkR73Ult9kY/DTmDtXCAU2kuDcKKfcMPgAieTNrJUIKA1tjMS+pe66
	A+nVpx3G6f8opu5rjztNNT3INlfqBZKRMOdSHNo6z8Xm98noKRJ6XYgkTBGOj1K1caxnYlCznsEYi
	1SRvHF1Qej0scG/kVcVoTwV3uOr0hUchiVi52Rb9S0ieV2YVZE9LMkXohXbgKivpnwaCpxpCMpWwe
	LQmrIdbI53oLtfMzazlFlpOJN6A146tVKBSmJmHYF12i99AL2dvJd1U0BgKw0Qlh8Jd71+ybDZDou
	vxvEPy6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgNQm-005egq-1Z;
	Wed, 13 Sep 2023 10:49:12 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgNQh-005efA-2q
	for linux-nvme@lists.infradead.org;
	Wed, 13 Sep 2023 10:49:11 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-401ce65dfc4so20020085e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 13 Sep 2023 03:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694602144; x=1695206944;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Esn3bDVPqFAsAFDnhhKPSrWoO2OiXMkjdGA2/ZknMxY=;
        b=om94brVPeWaWaKA7BTTjNQ+cA6Bt9HEd5c600z18w34TxRazqsypKeBuT7VL2BkE55
         q6XkuzDIdhCcXLJNRdFJNz36ouI4KTUcEkDQD+oy3x8ciTizsGEJE4CEBilIJQ4UzzXm
         Vwlmge9E7XVGredGN3ZcSQg9kxlwlvCmTni1Hb3yNOivPT6qmVTV1lDipTkeXHBTg2qo
         z7xsxUTiSvp3s4gcnp2QxOhfPubjeP2fyhyo/VgAuzB5gEIlOZvZyMRHZjYUoiNz8SGv
         UF0AAaAnPwTEnuYO3ydX5T6P5rLTr6J08Bxs0ejYyK7jo98eDSH4Kic8m0R2J1IO9/PH
         W2gw==
X-Gm-Message-State: AOJu0YwEWNYIMfQwqVWvIv4pLa2jo1OZb4szt8b1cO2t6mwDGuhYzhUi
	fi6IcttmisMKY3djzWUu/Ak=
X-Google-Smtp-Source: AGHT+IG4m9pCndyGDLU5E9jXsiega50BJYoH3R+yUG8SLcQxS5ITG4ubdS76CNbUddekEUl07q0Fbg==
X-Received: by 2002:a05:600c:1da2:b0:401:7d3b:cc84 with SMTP id p34-20020a05600c1da200b004017d3bcc84mr1805926wms.0.1694602144226;
        Wed, 13 Sep 2023 03:49:04 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c021800b003fee53feab5sm1694093wmi.10.2023.09.13.03.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 03:49:03 -0700 (PDT)
Message-ID: <d761c2de-fea3-cbd0-ced8-cee91a670552@grimberg.me>
Date: Wed, 13 Sep 2023 13:49:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v15 05/20] nvme-tcp: Add DDP offload control path
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230912095949.5474-1-aaptel@nvidia.com>
 <20230912095949.5474-6-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230912095949.5474-6-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_034907_929896_45E00095 
X-CRM114-Status: UNSURE (   8.82  )
X-CRM114-Notice: Please train this message.
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


> +static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
> +{
> +	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
> +	int ret;
> +
> +	config.nvmeotcp.pfv = NVME_TCP_PFV_1_0;
> +	config.nvmeotcp.cpda = 0;
> +	config.nvmeotcp.dgst =
> +		queue->hdr_digest ? NVME_TCP_HDR_DIGEST_ENABLE : 0;
> +	config.nvmeotcp.dgst |=
> +		queue->data_digest ? NVME_TCP_DATA_DIGEST_ENABLE : 0;
> +	config.nvmeotcp.queue_size = queue->ctrl->ctrl.sqsize + 1;
> +	config.nvmeotcp.queue_id = nvme_tcp_queue_id(queue);
> +	config.nvmeotcp.io_cpu = queue->sock->sk->sk_incoming_cpu;

Please hide io_cpu inside the interface. There is no reason for
the ulp to assign this. btw, is sk_incoming_cpu stable at this
point?

