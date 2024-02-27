Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3DBC5478C
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Feb 2024 06:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/aIAMlfaDyaVqt5JwBM3CoOUNpAdEfGAQzRyppdxX5k=; b=MM1d/Rk5uZgpm0LIyx4OlY6YMZ
	GwrqiZmlpkzNkD1uJh6iwXKusITzzWHrKSfBgRqkoUWoMUzcVuqmxlHFb8+wDjOYqRqVFVZK1r3e9
	GnpSGDG5///tteSNm7WgEEs0DCquRRt9EY+X/aIG8tOUX7FY74QUmTg1vM9me3aX2UFcp3ZBW2+sg
	AtYtupevMBuk8Zuyqm3siPsoNP7hcrsD7Hdx8JeGiybxFOJarXPbKkZUQtg4iCxOJ+5O8uuY3za6x
	1afZyGwSCOTgRzy0ssgDM0k6QfW3XMEPBw4OwrTT3xt78dKNFLs56GjRNzfqiS01iB4eHz4r6GAhb
	xGuPFPNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reqbL-00000003wCn-4BhE;
	Tue, 27 Feb 2024 06:06:04 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reqbJ-00000003wC3-20vc
	for linux-nvme@lists.infradead.org;
	Tue, 27 Feb 2024 06:06:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709013958; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=/aIAMlfaDyaVqt5JwBM3CoOUNpAdEfGAQzRyppdxX5k=;
	b=HPqFQnuGoMce3P93GTqYHPvP59JpCWTbHagKc4UqffLaj0KIINLDkgzThR1HwkKpUsG95A+zspKYHbWDKwAETXaSZZ8IDS+Njv+6uEPH1ggGcRAuyPxB3T18DE7ghC8XPJb26CYFHSPPgpBDGevmi3FgBcVmXZn6ucKvP9khTGU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W1LdhCY_1709013943;
Received: from 30.178.84.101(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W1LdhCY_1709013943)
          by smtp.aliyun-inc.com;
          Tue, 27 Feb 2024 14:05:57 +0800
Message-ID: <d245791b-a0ec-47fd-9dee-ef1eef622bf7@linux.alibaba.com>
Date: Tue, 27 Feb 2024 14:05:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-fabrics: check max outstanding commands
Content-Language: en-GB
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
References: <20240223033004.55756-1-kanie@linux.alibaba.com>
In-Reply-To: <20240223033004.55756-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_220601_697812_8D3F1E99 
X-CRM114-Status: GOOD (  14.60  )
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

Hi,

     Gentle ping...

Best Regards,

Guixin Liu

在 2024/2/23 11:30, Guixin Liu 写道:
> Maxcmd is mandatory for fabrics, check it early to identify the root
> cause instead of waiting for it to propagate to "sqsize" and "allocing
> queue".
>
> By the way, change nvme_check_ctrl_fabric_info() to
> nvmf_validate_identify_ctrl().
>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/nvme/host/core.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0a96362912ce..5cdd22f591f9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3084,7 +3084,8 @@ static int nvme_init_effects(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   	return 0;
>   }
>   
> -static int nvme_check_ctrl_fabric_info(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
> +static int nvmf_validate_identify_ctrl(struct nvme_ctrl *ctrl,
> +				       struct nvme_id_ctrl *id)
>   {
>   	/*
>   	 * In fabrics we need to verify the cntlid matches the
> @@ -3117,6 +3118,11 @@ static int nvme_check_ctrl_fabric_info(struct nvme_ctrl *ctrl, struct nvme_id_ct
>   		return -EINVAL;
>   	}
>   
> +	if (!ctrl->maxcmd) {
> +		dev_err(ctrl->device, "Maximum outstanding commands is 0\n");
> +		return -EINVAL;
> +	}
> +
>   	return 0;
>   }
>   
> @@ -3232,7 +3238,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
>   		ctrl->iorcsz = le32_to_cpu(id->iorcsz);
>   		ctrl->maxcmd = le16_to_cpu(id->maxcmd);
>   
> -		ret = nvme_check_ctrl_fabric_info(ctrl, id);
> +		ret = nvmf_validate_identify_ctrl(ctrl, id);
>   		if (ret)
>   			goto out_free;
>   	} else {

