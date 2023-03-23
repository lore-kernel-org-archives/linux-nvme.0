Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747E3C6FD1D
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 08:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4ow9+D5UInGlqlXYQuIDu+Hd4xqF0KxdZ2VGKs8tVSc=; b=bkC9g1EyB4l5JOLhooarm2BOzk
	m+f1SqNdNpuJck+jcWKYDmYviLVNQDv+hTrnd9e/JDE8RG9P4WD843zLdEUrDbtITaeTkeP3dJqNK
	g0k/KL4AGxTTH4fXAeUCQqGj1wnnLkWzrt0+hb0zebXaTAzA+IIZH6N37gQHi5dufqnar+XfzHEa8
	hUuZaT+Q8OJRf/l20nnkp0fE/U5gSiYTfpcJBT/eu3epioqkQbLwUBiVrD3qH5kBKpApSA8l/UELE
	hNCP8Np7joS9cgg0SPho9FLezCOBHaKgICXhT6TwbwQEyPjfaDUJKUeZmGm8RoqgCDln4WC0qa2yY
	vOOZ229g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFy2-001DF5-23;
	Thu, 23 Mar 2023 08:06:38 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFy0-001DDx-15
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 08:06:37 +0000
Received: by mail-wr1-f49.google.com with SMTP id m2so19481793wrh.6
        for <linux-nvme@lists.infradead.org>; Thu, 23 Mar 2023 01:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679558792;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ow9+D5UInGlqlXYQuIDu+Hd4xqF0KxdZ2VGKs8tVSc=;
        b=buF+XUvfIwp8XsXV9r9GN6gJ1aB98FL1e4L4i5AptzkqZpqDGEJp9e24fee9fJCTTF
         Yeca769pJBDyEOTurC1vV64w5mufJAeZAH9Bj4jxjwraRLvTCDegJfd+kzAsSxS/bGqr
         OPNLBZ2Myc7cC6M2XTMlxYvLHTu7Zpn29DC02FQ4dLz6XocB/or7JUR7/PykcxBOfcir
         T0vlh1YrLqHmrIfedBZwGa1NQf+hbdZ8c6ihj9yPOg6pDJie0h11ZBCAyWaIKRt53h0J
         HDMrn0rFAlIso7SiimrpJok+uC8cYB/xjrBDbVxerAIOKc6V8WwSDvkYAZbODFcwvrEv
         AROA==
X-Gm-Message-State: AO0yUKV7vMOZe3IXPboVwiH5BoZQaf3BRN2/5ydf7n124apa3fy4TeZl
	csZ0xnVAl4gdFHu2+0wUKLQ=
X-Google-Smtp-Source: AK7set9GmFM49Syo8hEFc2hXvED3X82shSveRzv/IugIwHP6bjowfpHs3HW+LcSmveIDZQec9ZbgGQ==
X-Received: by 2002:a5d:5686:0:b0:2cf:f231:a477 with SMTP id f6-20020a5d5686000000b002cff231a477mr5481211wrv.1.1679558792263;
        Thu, 23 Mar 2023 01:06:32 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r10-20020adfce8a000000b002cefcac0c62sm15690332wrn.9.2023.03.23.01.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 01:06:32 -0700 (PDT)
Message-ID: <aa91c55c-40e8-f4f6-b330-5698b6f4da9a@grimberg.me>
Date: Thu, 23 Mar 2023 10:06:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 7/9] nvme-core: cleanup for nvme_set_latency_tolerance
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de
References: <20230323033636.812758-1-kch@nvidia.com>
 <20230323033636.812758-8-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230323033636.812758-8-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_010636_372650_A1236BE5 
X-CRM114-Status: GOOD (  15.82  )
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


> Remove the extra line before default in the swicth and add a break
> at the end of default in the swicth which is a standard practice.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 06dac97c5b0f..fdcba1dc583d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2594,9 +2594,9 @@ static void nvme_set_latency_tolerance(struct device *dev, s32 val)
>   	case PM_QOS_LATENCY_ANY:
>   		latency = U64_MAX;
>   		break;
> -
>   	default:
>   		latency = val;
> +		break;
>   	}
>   
>   	if (ctrl->ps_max_latency_us != latency) {

