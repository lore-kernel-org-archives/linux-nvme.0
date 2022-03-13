Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBA5C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Mar 2022 13:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mhYIHk6RZvOBEJoFd+fXCZDP0rR0k+TpwDlwBsasWCA=; b=XitoiR1PLBrFu22c6e4rvRaOVH
	bh4f0zJTy6Heo0U7B5/WiDSBqkGMb8vI4FnE3umtgvLOhVLFlH8vSCDctfEBBGkSTMK0WDdaDsf3D
	X09/bwRFCQ0VDSf/7JoEY/YumEeNM5+nNuND8vhopLS9hPeBK2jauVau7VkuwPwctUwjrTPsR4NGt
	mJByPzuWCqEsZ2F3US2BSoNE8qWNN/rvrgrjywm3fOyo235o86UqXpt1sMqFg772T16dG1OF7n2Ws
	lMqh3vxTa6sAFrVrFXOc5c5fm00b6Cpl+JBbjFEJeKXKbPl4rVxnGE7BDutNHGwR2agwEa8SccBAp
	1manRsLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTO42-002oss-CD; Sun, 13 Mar 2022 13:15:14 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTO3z-002os4-L7
 for linux-nvme@lists.infradead.org; Sun, 13 Mar 2022 13:15:12 +0000
Received: by mail-wr1-f51.google.com with SMTP id q14so19927991wrc.4
 for <linux-nvme@lists.infradead.org>; Sun, 13 Mar 2022 06:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=mhYIHk6RZvOBEJoFd+fXCZDP0rR0k+TpwDlwBsasWCA=;
 b=uZf7xSQyIe+A/8kZasrhiMsJgLZcyc09FJPzJIAZQ/f9nyBkkklrkOvJ9gQqHkANHB
 +Z1AHFy5E3xzCAYyl4rMfSBrAqDVCXc6Jtq6JFRyLBeNncNvaoRk4KlvLo/8qbF30t/W
 6ZSppKpn8RUX/JAiRCXhe58wVQRfUpScw8MG0y2i9df3Jp7twFxKBmOtVGIqfIHj9r1P
 GtFhuN3Q2z9b1joQVp4ZiS/wRye8yHBq3GJmo3nKOUIvgnjeDTQWb65mfiW61zEGR/3K
 To+PU9jsvBgVnCIR9uDRpcXyUuS30n8u3AWZJhHfovCl4sInVhT8784B8ziuC+81RbmI
 8lkQ==
X-Gm-Message-State: AOAM530M3z7QMsGE2zzcmJYUF3sO8l55vQCgLGA2lqir3lyDA7Cce2sm
 PJ9N5kyXvsQQ0BuUp8/Qsto=
X-Google-Smtp-Source: ABdhPJwJls2diJe5yJAS9vqyHqZIlubrGoHrrE/yx5oZatBg0JjCyBkdCn9k0bDcR9BrlE8GZ9Wytg==
X-Received: by 2002:adf:b60c:0:b0:1f0:227d:bce with SMTP id
 f12-20020adfb60c000000b001f0227d0bcemr13342122wre.313.1647177310253; 
 Sun, 13 Mar 2022 06:15:10 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 r1-20020a5d4941000000b001ed89dcacbbsm11024621wrs.23.2022.03.13.06.15.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Mar 2022 06:15:09 -0700 (PDT)
Message-ID: <1bbc81a0-19f0-433b-28c2-b22d28176e37@grimberg.me>
Date: Sun, 13 Mar 2022 15:15:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvme: Fix zns drives without append support to export
 correct permissions
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Johannes Thumshirn <johannes.thumshirn@edc.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 kanchan Joshi <joshi.k@samsung.com>, Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>, linux-nvme@lists.infradead.org
References: <CGME20220311201638eucas1p18b9c5ecb3442b5a53bba233591d34db0@eucas1p1.samsung.com>
 <20220311201608.275384-1-p.raghav@samsung.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220311201608.275384-1-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220313_061511_726170_F32238BE 
X-CRM114-Status: GOOD (  21.16  )
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



On 3/11/22 22:16, Pankaj Raghav wrote:
> This commit 2f4c9ba23b88 ("nvme: export zoned namespaces without Zone
> Append support read-only") exported zoned namespaces without append support
> to be marked as ro. It does it by setting NVME_NS_FORCE_RO to the
> ns->flags in nvme_update_zone_info and later nvme_update_disk_info will
> check for this flag and set the disk as ro.
> 
> But later this commit 73d90386b559 ("nvme: cleanup zone information
> initialization") rearranged nvme_update_disk_info to be called before
> nvme_update_zone_info thereby not marking the disk as ro. The call order
> cannot be just reverted because nvme_update_zone_info sets certain queue
> parameters such as zone_write_granularity that depend on the prior call
> to nvme_update_disk_info.
> 
> Call nvme_update_disk_info after nvme_update_zone_info again so that the
> permission for ZNS drives are marked correctly.
> 
> Fixes: 73d90386b559 ("nvme: cleanup zone information initialization")
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   drivers/nvme/host/core.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 51c08f206cbf..67a78653b07c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1913,6 +1913,11 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>   		ret = nvme_update_zone_info(ns, lbaf);
>   		if (ret)
>   			goto out_unfreeze;
> +		/* nvme_update_zone_info might set the namespace to be marked
> +		 * as read-only. Call nvme_update_disk_info so that the disk
> +		 * is updated with the appropriate permission.
> +		 */
> +		nvme_update_disk_info(ns->disk, ns, id);

There is a call just above this, why add another call?

