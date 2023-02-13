Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD05C636D7
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 10:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pH0ZPRW44cRqRjeRqfvW1keJmEULHDXfxjp1kWDi+Po=; b=D5BTQsFrZ+ioA97DDl1gCfqYgO
	CrNboywjrjQCc/FhpRO4J0vzHzST/NtnqCIfxHPosuy+cRV6xGbjEox6dFpCn6C6jP5s4t3vOuD4H
	mtXPjZCbo/iOb9RePNNJlVmVYc0o3wUp791K+nbJjTw1ldcxycgnVT33VSg6/gEsCBUuJkTsm2juX
	jCBM0qpo1FCBFSLmKkMsxSGUl2Lj37GKTnyoGdOVVGKAiroRrogEhvAL8gcWPJNomcUFs2FtoRMLS
	Ilk/Fly1BhC57xtPHpbsEEi9D98eyfOgrdAHmy6SGsJbgb7M/ik4oPQbNbmqn2XEbrsw+kx6fuVGr
	L4707bsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRVz3-00E6MS-MH; Mon, 13 Feb 2023 10:22:53 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRVyz-00E6LR-Ei
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 10:22:51 +0000
Received: by mail-wm1-f53.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso8582828wms.4
        for <linux-nvme@lists.infradead.org>; Mon, 13 Feb 2023 02:22:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pH0ZPRW44cRqRjeRqfvW1keJmEULHDXfxjp1kWDi+Po=;
        b=PlsvSQnBQQ2rW9G3WWhiwirk/U2cNn/xAzJB4sW8/DXSPaYN7R0pKvHI4wn41W7cGu
         invaPYqBEOa3LXwDDzdzhA6vG+K3fwyDdMofAS3eCn36JI8RZ8d1HaBLU1HrUL82AACZ
         6QdcTCIl5IUFWnYUcQuJXfqyOe2uqJWhwc7Ya+D4qz9rE4VgURXkZ56wdetfbnJGGnS+
         pbU12SFF97xLF8xAvILYt0+CcXZDvb+6p1wxslDogiP5rM/eONMxXROhge59BQ/vAjP2
         YaJM85or+mQQKHkavGHsZJtkTQykOPHyZkYXYv4BT/2b2+6qpwMOYGrACeCbh4cgQLZH
         tiJA==
X-Gm-Message-State: AO0yUKU5HA1Ey378vVOS6rIg1QxUpP2hm4/dfhFL4FqcP3Fp0rcnaAp5
	7rgxrz1Zijy5PJFLlJ3uwx4=
X-Google-Smtp-Source: AK7set855zDTrzmCyVYGzn5OjOWDS/iJyZa3b6uAkBb7ZHmxAI2ur5qAxgInbrxDSjmXxU8eVdBl2w==
X-Received: by 2002:a05:600c:5108:b0:3db:35e3:baf6 with SMTP id o8-20020a05600c510800b003db35e3baf6mr22572396wms.4.1676283767754;
        Mon, 13 Feb 2023 02:22:47 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o16-20020a5d6850000000b002bfbda53b98sm10140041wrw.35.2023.02.13.02.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 02:22:47 -0800 (PST)
Message-ID: <fa0f909e-9d3c-ff0d-d887-a3ce838c0769@grimberg.me>
Date: Mon, 13 Feb 2023 12:22:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] Add quirk for ADATA SX6000PNP
Content-Language: en-US
To: Ivan Rubinov <soltime@riseup.net>, kbusch@kernel.org, axboe@fb.com,
 hch@lst.de, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <96afa026-e1a9-0ce5-d9ff-36f7e5c1a5b2@riseup.net>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <96afa026-e1a9-0ce5-d9ff-36f7e5c1a5b2@riseup.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_022249_659113_42CD3E72 
X-CRM114-Status: GOOD (  14.22  )
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


> From: Ivan Rubinov <linuxkernelpatch8234@riseup.net>
> Date: Fri, 10 Feb 2023 14:59:41 +0300
> Subject: [PATCH] Add quirk for ADATA SX6000PNP

Is this referencing to a bugzilla or other?

> 
> Signed-off-by: Ivan Rubinov <linuxkernelpatch8234@riseup.net>
> ---
>   drivers/nvme/host/pci.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c734934c407c..c63443d531b3 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3365,6 +3365,8 @@ static const struct pci_device_id nvme_id_table[] = {
>       { PCI_VDEVICE(INTEL, 0x0953),    /* Intel 750/P3500/P3600/P3700 */
>           .driver_data = NVME_QUIRK_STRIPE_SIZE |
>                   NVME_QUIRK_DEALLOCATE_ZEROES, },
> +    { PCI_DEVICE(0x10ec, 0x5763),   /* ADATA SX6000PNP */
> +        .driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN | 
> NVME_QUIRK_BOGUS_NID, },
>       { PCI_VDEVICE(INTEL, 0x0a53),    /* Intel P3520 */
>           .driver_data = NVME_QUIRK_STRIPE_SIZE |
>                   NVME_QUIRK_DEALLOCATE_ZEROES, },

