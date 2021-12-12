Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE7AC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Dec 2021 09:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=63Fe77A4ncsWacoO6GqvOVHtud7k2hvikOMys/KL5cc=; b=zyk8f8EAuE26q0elZEeDTQ4tgb
	BGZnUUufDLbUAcDTqNp5zy8ycEp4usuNnatkknASGUNo7WtGMLhjacAKH8FxHbpZUqnF8nVfbsdR/
	q/tzjmmkVFuFt5VD1iIFQqPE1/LCeFYutkGZpCc3dIyLCU9vgTT9ocdouSNd4h7jOilvlpnjo9XSg
	byq5FcQTvrnUE1SWicVAEYFAnTu7kCe6QMckLSsOTS3/MeRHIu1xmJbsJwtPQA5FnGzBP9wOXyV/1
	c/fBxs3sgDUXPSguCRtUOn41BtGNgPXVqvjbCvSDz11hV473t5ABPmeTEA+/RzL9RqG9QPBUUwrFd
	6WD+DMkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwL3m-006E7s-8a; Sun, 12 Dec 2021 09:22:22 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwL3k-006E7P-3W
 for linux-nvme@lists.infradead.org; Sun, 12 Dec 2021 09:22:21 +0000
Received: by mail-wr1-f43.google.com with SMTP id d9so22176980wrw.4
 for <linux-nvme@lists.infradead.org>; Sun, 12 Dec 2021 01:22:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=63Fe77A4ncsWacoO6GqvOVHtud7k2hvikOMys/KL5cc=;
 b=fL5Rlcd0b/VSkLFPA99ZSOEZAIYW0cK5WWOhFd9lJyQzLg43qsoA2lV39S241d4cUJ
 JiYR3dYv0KOCGtOAQc9xkS0g5c2ZcT/wK8/ep6uR8PZOXMKyRM12hP4pgwgnJ894uae1
 2FX5dscHCxZakpTpHMBM7dYCvYwIcEuFqEhL+9X4GvG1XovfbX4SMVP6SkrzITKCqXZ0
 a+S3OcDO63QMK5kTPGpayK3G2kB2vJo9t/Ioce12tBo2St54bnj226/MbC1KiZyJKmh5
 4EkWmNKMgxwOHxulhm00wfTYEO3H83a0lEQR2EgKVWK4OdVO8GGAuWcm04ARbF5RPNsh
 +7oQ==
X-Gm-Message-State: AOAM531ZUHbCYSMnNadVvMQCkOdWDAx8ha5vq51bHJj9f3AwR8431U+x
 Yc6y2yF7zr9a5gcic81hIMbNPnHBR/I=
X-Google-Smtp-Source: ABdhPJwpQU5ljfaPAovR6Z1Ukaau+zNYXRiLBk82Kw+KFEfkIihyz/4B5KfLrOIO5KNCXHYGS8Hi0Q==
X-Received: by 2002:a5d:6781:: with SMTP id v1mr24779309wru.239.1639300938600; 
 Sun, 12 Dec 2021 01:22:18 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id k13sm7052988wri.6.2021.12.12.01.22.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Dec 2021 01:22:18 -0800 (PST)
Subject: Re: [PATCH 3/3] nvme: add KConfig options for debug features
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, kbusch@kernel.org, hch@lst.de
Cc: linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
References: <20211210112116.9299-1-chaitanyak@nvidia.com>
 <20211210112116.9299-4-chaitanyak@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c467d85d-77da-fdff-53e9-938a7bf01763@grimberg.me>
Date: Sun, 12 Dec 2021 11:22:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211210112116.9299-4-chaitanyak@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211212_012220_187362_04447EDB 
X-CRM114-Status: GOOD (  17.66  )
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


> From: Chaitanya Kulkarni <kch@nvidia.com>
> 
> Add KConfig menu option to enable and disable gencounter debug
> feature that uses config NVME_DEBUG_USE_CID_GENCTR.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/Kconfig | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index dc0450ca23a3..dfa2609b7006 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -1,4 +1,14 @@
>   # SPDX-License-Identifier: GPL-2.0-only
> +menu "Debug (Enable driver debug features)"
> +config NVME_DEBUG_USE_CID_GENCTR
> +	bool "Enable command ID gen counter for spurious request completion"
> +	depends on NVME_CORE
> +	help
> +	  The NVM Express driver will use generation conunter
> +	  when calculating the command id. This is needed to debug the
> +	  spurious request completions coming from a buggy controller.

This is not just to debug - it is also to protect against such a
controller. What is the purpose of this config option anyways?
The main distributions will (as they should) enable it anyways...

