Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B71C3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Dec 2023 19:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6y659o19pXZiJ8P2sCB+gjWvNUcoHRyBvaBABtESx9g=; b=A1B9ho9+vJ7R3Bopzy3bJltmUj
	G9cdzSxG5LRxYjgrY3pA01u025df77PwcAJek5cd7KKe6BP9kE0HKRZemMbFB3Rz2Cl8zyLzow0D6
	iBObYS/HBxSBVw6PSjZq+2ZjpTfzLYPnkaFe0mKZxASptmpYBso/1Ib5J+0d7W4CNmt5mqIHeebMU
	w8RxAHF9/QDdDwnPsHZkdWk2kfoLTeGNpG+AeGUAMjmu7MAtnCnsRLExfky1Yyuk9uNeYP3DTImFb
	nZh2E1RION9M3juEahKYzhMwYkZIjK/9KxgQnZ7D35B+uNqqiG1p9A5+R+Fy2ukjBcHITknHyRGmZ
	U9z1lOSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rG2Fl-000lQB-2r;
	Wed, 20 Dec 2023 19:29:13 +0000
Received: from mail-lf1-f46.google.com ([209.85.167.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rG2Fj-000lPI-0B
	for linux-nvme@lists.infradead.org;
	Wed, 20 Dec 2023 19:29:12 +0000
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e3b11f5a9so16660e87.0
        for <linux-nvme@lists.infradead.org>; Wed, 20 Dec 2023 11:29:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703100549; x=1703705349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6y659o19pXZiJ8P2sCB+gjWvNUcoHRyBvaBABtESx9g=;
        b=bl0FrSWBO418x5mv79jpt3QFCsnpGnGX+Y8bPqWhOJ0XOWKDPPwWMrAN28zhr9ghSD
         733sjKiKpxiggLYDKGcB1jesJGphqayPD4nTlioZqpZdbyBIh/Y+niz3itZBwftguC1Z
         S4TaiClZeNezZFTpWSVqbDU9yPLauSiT9xp95Zw9kk11+63ndKpKBg+UaJOFdY4e2FqZ
         LpnQkn4dZcMroNGWpS+U5WUkAtlKwCLac6md0Ud71RXIF18VpPF31vSpj4xOh6rQ3kxU
         DB4nmBctNJqSn45jDk8JPi+stDbHHEt/gjXaIrdiCoD3yR/21Ih8zDxv/A+0Z08ZcvIH
         WRYw==
X-Gm-Message-State: AOJu0Yw8DXxN+z5HhhL4YjdIv30EPIe/gE/fCVuk8IxASyRUU96WuskE
	28Z37Q0idYAgwXXvWfDBkXw=
X-Google-Smtp-Source: AGHT+IFrE6ZQ4ojzV4DljiNR56TQQI4rq1Gyo4MHLj/AtGeaXDJt5l482we4jcsD0PbiBOnQymeeYA==
X-Received: by 2002:a05:6512:11f0:b0:50e:3ccf:3d43 with SMTP id p16-20020a05651211f000b0050e3ccf3d43mr4393262lfs.5.1703100548359;
        Wed, 20 Dec 2023 11:29:08 -0800 (PST)
Received: from [10.100.102.14] (46-117-87-214.bb.netvision.net.il. [46.117.87.214])
        by smtp.gmail.com with ESMTPSA id fj8-20020a05600c0c8800b004094e565e71sm590550wmb.23.2023.12.20.11.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 11:29:07 -0800 (PST)
Message-ID: <573c2ad1-8407-4c8d-b31d-b89b16f0fea0@grimberg.me>
Date: Wed, 20 Dec 2023 21:29:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme-fabrics: don't check ioccsz/iorcsz for discovery
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, dwagner@suse.de, kbusch@kernel.org,
 hch@lst.de, linux-nvme@lists.infradead.org
Cc: oren@nvdia.com
References: <20231220092745.35325-1-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231220092745.35325-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231220_112911_090958_83A744AF 
X-CRM114-Status: GOOD (  14.37  )
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


> IOCCSZ and IORCSZ are reserved for discovery controllers. Avoid checking
> their values during identify controller phase.
> 
> Fixes: 2fcd3ab39826 ("nvme-fabrics: check ioccsz and iorcsz")
> Reported-by: Daniel Wagner <dwagner@suse.de>
> Tested-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ee2e4c49892d..b218ac88fcf8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3068,14 +3068,14 @@ static int nvme_check_ctrl_fabric_info(struct nvme_ctrl *ctrl, struct nvme_id_ct
>   		return -EINVAL;
>   	}
>   
> -	if (ctrl->ioccsz < 4) {
> +	if (!nvme_discovery_ctrl(ctrl) && ctrl->ioccsz < 4) {
>   		dev_err(ctrl->device,
>   			"I/O queue command capsule supported size %d < 4\n",
>   			ctrl->ioccsz);
>   		return -EINVAL;
>   	}
>   
> -	if (ctrl->iorcsz < 1) {
> +	if (!nvme_discovery_ctrl(ctrl) && ctrl->iorcsz < 1) {
>   		dev_err(ctrl->device,
>   			"I/O queue response capsule supported size %d < 1\n",
>   			ctrl->iorcsz);

I still think we should at least warn (and ignore) for discovery
controllers.

