Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE52C27C76
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jan 2023 18:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m4wgDIW/eGuUYwqhMzgnbxPkAtDQk87+f75rKjSVPV0=; b=eIIzHR38QLEaqclGnneLvLvJ7o
	SJHuBduoLDRlY+L13he0z7aGSHAtLLQiXHW/bTxVsnz6AjSal67aVdI0dx6nqT4YUbI/s2NYAV60A
	/mqYS5NQPmmXpbWhb6Oa9Kokbr2cJ8D3Xyl1QL62JZWtdZzv7ZzgRDTXpsoycQOaW51wVUe3NuvGf
	68R+xMgghXVb9sxft6FwnPTkvKOBO2oDYDNUA3nKr9Zx5ssom3UdiBWDNHEvUMjFLLqoNW56hCqiy
	F5ifnFgbYi6EkEsZJqx55FWE6Kt4WOsQDuX+Jy8IQf6xXS0H7H23rtCK3Ke4L/lW1edSHoGgideLj
	04LH/7WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKkqv-008NzZ-RT; Wed, 25 Jan 2023 18:50:33 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKkqt-008NyH-2j
	for linux-nvme@lists.infradead.org; Wed, 25 Jan 2023 18:50:32 +0000
Received: by mail-pl1-x635.google.com with SMTP id jm10so18703582plb.13
        for <linux-nvme@lists.infradead.org>; Wed, 25 Jan 2023 10:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m4wgDIW/eGuUYwqhMzgnbxPkAtDQk87+f75rKjSVPV0=;
        b=E2BxWv69dJybm6CluEOps/hlSnYM8kGqxhM5aQQFmluLDgLJvMnLscolFHOlPup4nI
         h+R2Ov1OPQHcCeU4gYLvxlGyexquyceWvaOQU3oivMte/EthKD5bblM0y4mI+jCQSaD7
         29e47HIHZfpqLQ41YSZY9XidI87rX8zpFDOlNrHcuml3SnF+Go6fKoKMiwP90MCyPj6D
         yNWpAA4U8bt50vEWcc+su4SkwbFwUldv34jiggfsUkLvN8z12I+hYN3VeIMoa3q5YBe6
         gFCTGa+m/ld4c3vbL/9cvmFCcTUBYENS0kBSGIldlF8JrtHWBhJHwmvgC9cl0WBqocVZ
         3zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m4wgDIW/eGuUYwqhMzgnbxPkAtDQk87+f75rKjSVPV0=;
        b=UeQ7tZolU0Aj1xt+d7oSV4wDm2HLFSUDk7+UwmCM5ORNrnG9NZ3pa0PyF3+NtkKqXi
         /NtqNSaykGkVOjlvCESHKLvYqtwxozeXTkrf7uNjmZMcONTYjavc33HLH9ieAnsAq0r3
         g70ZzIfqYmgbNw4LCP1hGYQc8SRSRKrE+40het/nS+kDwClSbpLRl6+TY0A5rOP3yXMl
         xKAs5I4t50wxHJw2nGDCo0FFM7TtjzeMvGY32mLa1c4wny5SoMpoIu6IMHjH2oInIVl4
         TIDCytSjcgroEH4+FCDj8QwLCtUAIcyEhJB3qgLhCaU/4DvHLdJYzSjDuc2FAnCz2ik6
         aqTA==
X-Gm-Message-State: AO0yUKXaM+LLPC/A7prKZgPNkiQWfJbrXtqN1pDYtnLLS/Ne9cZlPsUL
	pXbR7XMnSuxvdyMfG81tjlA=
X-Google-Smtp-Source: AK7set+Pdj6YAWdVwosN3kYQ7e4PtDO0EQbBSKdq0JjK1rDtN6JPPkNQN/t/14OMvcOFmODGm2vJ6Q==
X-Received: by 2002:a17:903:111:b0:196:37db:b4c8 with SMTP id y17-20020a170903011100b0019637dbb4c8mr813619plc.29.1674672627426;
        Wed, 25 Jan 2023 10:50:27 -0800 (PST)
Received: from [10.69.46.142] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id jl13-20020a170903134d00b0019117164732sm3970960plb.213.2023.01.25.10.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 10:50:26 -0800 (PST)
Message-ID: <bc26f850-6d3f-5927-0af7-b3649354c479@gmail.com>
Date: Wed, 25 Jan 2023 10:50:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] fc: add a missing release get taken in
 nvmet_fc_alloc_target_assoc
Content-Language: en-US
To: amit.engel@dell.com, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <1674477448-2455014-1-git-send-email-amit.engel@dell.com>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <1674477448-2455014-1-git-send-email-amit.engel@dell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230125_105031_148572_77DD9C91 
X-CRM114-Status: GOOD (  16.65  )
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

On 1/23/2023 4:37 AM, amit.engel@dell.com wrote:
> From: Amit Engel <Amit.Engel@dell.com>
> 
> As part of nvmet_fc_ls_create_association there is a case where
> nvmet_fc_alloc_target_queue fails right after a new
> association with admin queue is created.
> In this case, no one releases the get taken in nvmet_fc_alloc_target_assoc
> This fix is adding the missing get release
> 
> Signed-off-by: Amit Engel <Amit.Engel@dell.com>
> ---
>   drivers/nvme/target/fc.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index ab2627e17bb9..1ab6601fdd5c 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1685,8 +1685,10 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
>   		else {
>   			queue = nvmet_fc_alloc_target_queue(iod->assoc, 0,
>   					be16_to_cpu(rqst->assoc_cmd.sqsize));
> -			if (!queue)
> +			if (!queue) {
>   				ret = VERR_QUEUE_ALLOC_FAIL;
> +				nvmet_fc_tgt_a_put(iod->assoc);
> +			}
>   		}
>   	}
>   

looks good

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james



