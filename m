Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4F2ECAAA3
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Aug 2022 22:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A1GDSS4ZswYZdPLm/xFYMxcSzWgFZQdBzdkCHj25ONs=; b=ZNPs3wlRSNuGM2b5pMBPe3mih0
	4PXIhpp23a7r3AAOGeK7/euUFxsHAflPgMSHYUUkfKLT70N9cL1pptcqQYnE1qdj4unoBDbJrjL1F
	womQ/yDKd6w37us9BJ9AqhaE1q9nYLsiwIQelCgzEET/CSAizL5kd5rkeCsFM8o0f7e0ZT2/X/BKZ
	gZ0sVeOdOnq8ZOap1v4fIhIe9t411kJkfoZtR/5n+KNVHUiDBFLxQE/OVf9uEk8soP2Wuw2qrVN3E
	ZwmowTd5STKtthgCGQOsN0xoIKa+zfTcAd/5sh+eHKO5K/Lnywwyl4QgFP2qsg3nneI3G73mWf+pl
	Wy5FkYwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRKwL-003hPS-1n; Thu, 25 Aug 2022 22:03:05 +0000
Received: from mail-pf1-f176.google.com ([209.85.210.176])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRKkU-003arS-5C
	for linux-nvme@lists.infradead.org; Thu, 25 Aug 2022 21:50:51 +0000
Received: by mail-pf1-f176.google.com with SMTP id t129so2369088pfb.6
        for <linux-nvme@lists.infradead.org>; Thu, 25 Aug 2022 14:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=A1GDSS4ZswYZdPLm/xFYMxcSzWgFZQdBzdkCHj25ONs=;
        b=s+rUqi+DlOn1W0Fr+ktM/IHa3Jb88aa2Yo1MTGkpoBCVT4ocGSbQ/AyMsqpUFg8FgU
         c5yNTMcPeLn+J6sUgKkR3fKK7s6JTlI2aG+0D6eCswey8BQld6Hq23bxuWgy+5eo2+qO
         +fjUU5/YC7JQ4G+xcP9FGW3DS50plO2f/NGOY3kTTYaOPQStLEbB4skQ/mk3pLJoc+9P
         Mg41cleaiYJTEUhnAW8LKXsoJ/Q3AH69r3e46k5UnHxsqqbHuU35VD2ATlIiwG1RoccQ
         DK4iV/RKrU4484ZEe1k30IsRtGParXsBA1gNYUxDTD4dYzUrEseTxQBPDg+C+7CZuk68
         4z5w==
X-Gm-Message-State: ACgBeo21t1AFrmF/dNsg2ftKKd3Zc4yzRPKHfvNndqR7BP1v42hSgmoT
	rUfqumTPWty9UEv4jpCnzc4=
X-Google-Smtp-Source: AA6agR4mlNQNlswjcYi/OOqa2VKdvYxaaS8E9JPwi6wD85RRMAlmfsBiW/v3/FllaJ/9tjyjR3F0Cw==
X-Received: by 2002:a63:e20c:0:b0:42b:4467:e0f4 with SMTP id q12-20020a63e20c000000b0042b4467e0f4mr874532pgh.576.1661464248859;
        Thu, 25 Aug 2022 14:50:48 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:349c:3078:d005:5a7e? ([2620:15c:211:201:349c:3078:d005:5a7e])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090332cc00b001713af9e85dsm36928plr.180.2022.08.25.14.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 14:50:48 -0700 (PDT)
Message-ID: <1dcffde8-ded6-b665-58a4-0f9f091b2a8e@acm.org>
Date: Thu, 25 Aug 2022 14:50:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [dm-devel] [PATCH v12 08/13] dm-zoned: ensure only power of 2
 zone sizes are allowed
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, agk@redhat.com, snitzer@kernel.org,
 axboe@kernel.dk, damien.lemoal@opensource.wdc.com, hch@lst.de
Cc: pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com, gost.dev@samsung.com,
 jaegeuk@kernel.org, matias.bjorling@wdc.com,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121909eucas1p113c0c29f7e28d0ee3e1161f7da243baf@eucas1p1.samsung.com>
 <20220823121859.163903-9-p.raghav@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220823121859.163903-9-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220825_145050_266225_E2D7D7F5 
X-CRM114-Status: UNSURE (   9.39  )
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

On 8/23/22 05:18, Pankaj Raghav wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> dm-zoned relies on the assumption that the zone size is a
> power-of-2(po2) and the zone capacity is same as the zone size.
> 
> Ensure only po2 devices can be used as dm-zoned target until a native
> support for zoned devices with non-po2 zone size is added.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


