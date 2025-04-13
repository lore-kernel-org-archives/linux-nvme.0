Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355E5C3601E
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Apr 2025 21:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oY9DAo74r4exJprf7TJtFDjlUJmPXgaf3ueWxOaOJyw=; b=tbuWomtV3TW7wKU+Ygi9koIVbH
	UNWJ7hggNm3+cN8cL1bqOD4aJkPDe2pSHIAyIafD+TFNuCeQ3HHJRYFZ+p8HmYZoHbs6P4z5Nd9nD
	oA6fjD0Lx02VPWD8g0VGPAi8VHNOzJm0lo2qKYw8WOmtUZa4HnqF4D4udkJD5zUQlGhENJ+0k5ulq
	4ALh34/cGc5DvHCMj8R6eihGKLVmE7elaaE782qLv6BuDFqmNBzbK5HUtCmfpxdeD9TbkVgIshqF1
	PIFOqKSlwD3LDfeHkGR2r4BAcV7yY29ItdRwxkZs/BjT3d5F6UXfNB6Um9UyFBH8s9Z47mkdNX5PA
	jH2DLxhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u44z7-00000000By2-1T6v;
	Sun, 13 Apr 2025 21:35:25 +0000
Received: from mail-ej1-f53.google.com ([209.85.218.53])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u44y5-00000000BpU-1PlB
	for linux-nvme@lists.infradead.org;
	Sun, 13 Apr 2025 21:34:22 +0000
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so572432366b.0
        for <linux-nvme@lists.infradead.org>; Sun, 13 Apr 2025 14:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744580059; x=1745184859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oY9DAo74r4exJprf7TJtFDjlUJmPXgaf3ueWxOaOJyw=;
        b=xQsCukPFVjwqKwNckDWPBbHwcxGBBXKaLVKye1atrsFM+ZqRLn6HkLavbRpKSyFmuf
         /Aqd45zeHCTDSlxLpCidr1inP/W5QcHIbcMiNDEt8dRBPFoEBWGGj7cJE4kAP2e4JSd7
         do+mkkSX6hNhmbskGeya/iksYTK2KcgIg9ZnTs7Yca3ACPKP7XDrUmjE+DrQ+pVkEGx3
         S7SI0oqJ3iviVF/0as48hd0ltXsVUXmgBfZKuEbuEJL90jmoJAe1eQ4EfZiOpCA9vMqJ
         Hv59EK9JLlijPoAb10s7N7dkKJarJa9hUHEBlPuJZ7UxzO7GEEddFyK0ubFLtndOIEeF
         zwqA==
X-Forwarded-Encrypted: i=1; AJvYcCXwQ+eD2jkQqe18ScsM1D95LOzzLOkibiFKhkPZUXHHIQDf6t7sZaq0D+VoGrAU3mqjRx05z1Ff7s0Y@lists.infradead.org
X-Gm-Message-State: AOJu0Yx34m9JMatN8VFC38nMd11DivRzem5kGFnMGEKRsbwjx7cxgse1
	x3Xuvzj7uni5Zz6L8cOR8/wZUGTwzpa3xn+atq7K48nXV9TmYhXj
X-Gm-Gg: ASbGncvOJghas4K3qr/XrrBma+A83a7SehMvAELxGSfhy5MPfdRATQoqeN3/4Rb+XVw
	Ho3+eKRX9H0DFa1JzyxVIIA7L8qj2Pj8LBtysY1uzSEoOFKodpK5FwuTsGjeFIH7zQ2BFbsNQep
	mj32YaTyNNuu5xFFPRxjEdgaWPWAObxgqC8fLhOzRt1HNo3HgbAwkwxG5Tbkf9tuaZI88+9Ie36
	ILv5FB9cceTVLNLnolJps8umnAu2abjgemX/LhCravhZKNcwXKLMSa8XmnGHbXxho9TI4gLf6jg
	OkRWO9En7GZRykULyQNDSLJ4EHx/3RZJR5VPeu3F/Rj9SU1PXIvftUYqGSl8W31N14/3+H0eW55
	bIw8Ohwk=
X-Google-Smtp-Source: AGHT+IG0t3nAXqCqb3B24ba6YdgSLbeS24vuu3x39YaNdujNcVKuWQholBtQa6Nc6IHsIuQ3PMT8rQ==
X-Received: by 2002:a17:906:6a0f:b0:ac3:48e4:f8bb with SMTP id a640c23a62f3a-acad36a08dbmr904460266b.41.1744580059293;
        Sun, 13 Apr 2025 14:34:19 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccc2d0sm797099966b.137.2025.04.13.14.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 14:34:18 -0700 (PDT)
Message-ID: <e747a278-7cc9-433f-b093-56487c629d3a@grimberg.me>
Date: Mon, 14 Apr 2025 00:34:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v27 15/20] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer
 registration
To: Aurelien Aptel <aaptel@nvidia.com>, Christoph Hellwig <hch@lst.de>
Cc: Simon Horman <horms@kernel.org>, kuba@kernel.org,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net,
 aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, tariqt@nvidia.com
References: <20250303095304.1534-1-aaptel@nvidia.com>
 <20250303095304.1534-16-aaptel@nvidia.com>
 <20250304174510.GI3666230@kernel.org> <253jz8cyqst.fsf@nvidia.com>
 <20250403044320.GA22803@lst.de> <253cydizv99.fsf@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <253cydizv99.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250413_143421_381094_4F2C9F92 
X-CRM114-Status: GOOD (  10.13  )
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



On 11/04/2025 16:24, Aurelien Aptel wrote:
> Christoph Hellwig <hch@lst.de> writes:
>> Btw, just as a reminder nvme code has to go through the nvme tree, and
>> there is absolutely no consesnsus on this feature yet.
> Sagi, could you give your input on this?

As mentioned before, my personal opinion is in favor of getting this 
upstream. 6 years into nvme-tcp,
some people (which are allergic to rdma) are asking for less CPU 
utilization. This would be an optional
compromise to these users. I've expressed concerns that this offload has 
been poorly designed because
it does not interoperate with TLS (offload nor SW). This is somewhat of 
a turn off. I will say that having this
work with TLS offload would make it a more appealing feature than what 
it is right now.

I think that the hesitance is understandable given the history of 
storage offload engines which never really
justified their own existence.

As mentioned before, I acked the series, as I think that this could 
benefit users, despite adding foreign single-vendor
offload code to the driver (granted, not a niche vendor).

