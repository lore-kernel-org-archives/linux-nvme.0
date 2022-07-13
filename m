Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26FEC43334
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 09:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YMBBlrU+vWEzr7UQxr3irBBX65t0cMaYnKZXsaT2hUI=; b=0DjqpBfXjQ3Dupo/uOSam28Wlo
	gsXsbO5TVvITsSG9UeHp2kdBaxAC+/YwbM50EaqxW8i66WL2U0YpnATORt41332L5oGbwYPRRi6gM
	3DGZsNGQNJsCUEYSsX/dBGN48uw5NKxw2oh9OrDlzKJvkr1/dYY9Eyt8Tn2KfZyJyEMFSlfD2ec3P
	e0J/5At1wCC2Y7914R0dF9TUY/YOKqbkrYnD0792SUAV5cM+BfVhZLed3/UonWRifu6RC3JXb7jW4
	ht/FWrJj4gJ1w1BVtRcfuBdE8OQleAUPUW86Sefcux5CZ2tlilyIEbyxibOz7JegXgpTIOAghLSGT
	hq01ugZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBYZA-002EEP-Nn; Wed, 13 Jul 2022 09:21:56 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBYZ8-002EDG-8M
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 09:21:55 +0000
Received: by mail-wr1-f51.google.com with SMTP id bk26so14585536wrb.11
        for <linux-nvme@lists.infradead.org>; Wed, 13 Jul 2022 02:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YMBBlrU+vWEzr7UQxr3irBBX65t0cMaYnKZXsaT2hUI=;
        b=SHiR/7Y+p7rQMaBMcQCVH6FgROxChu4SvUVekC3rwQgK0ERMoIQUBx9uVEI79Z4IOi
         IOItBWlSmktwu0qnwCqiSLsOWKNNqzv9+5adsfF2GEg9Na9Wxm38lJCnhJ1TigD1FOXc
         BKo53mVAI8FF9vpAsuERovt47qp14BDqPpc98xOjPiQCf8FY2DYnWnJseCU+cm3eDW3c
         ojyQ2i1VxuHGMr8q2Hee/TXbfbL95PY7KMz5+BV7vqeZpnsFEotdkNbpMo4UmUdcCnD6
         WImmXSDrTSXihIHclYvx+DqTlK5wesb8A0TGqbcJIeQrh3SIFSDc73s/EWnBz8awiys+
         K0xg==
X-Gm-Message-State: AJIora8jd9zdEbc8JPWOCDmuI7iwfQ1IOuY0ZA3jMY65DaPQJLY8RNAO
	HbEIVF3vI1LuI2XiCP7HK3asm08wvow=
X-Google-Smtp-Source: AGRyM1volNw6wA8uhICvTkueL+PAbOVoNJHDCl55UdejQ2jIWyjHAlsZSkTXxP2aRwsZJkkXi4svUg==
X-Received: by 2002:a5d:4f0b:0:b0:21d:705c:caf with SMTP id c11-20020a5d4f0b000000b0021d705c0cafmr2283259wru.55.1657704113008;
        Wed, 13 Jul 2022 02:21:53 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003a2b7b7b233sm1635009wmi.6.2022.07.13.02.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 02:21:52 -0700 (PDT)
Message-ID: <a09f1d0d-09de-6dd6-3810-d6fd5e11f63d@grimberg.me>
Date: Wed, 13 Jul 2022 12:21:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/5] nvme: refactor namespace probing
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Joel Granados <j.granados@samsung.com>,
 kbusch@kernel.org
Cc: joshi.k@samsung.com, linux-nvme@lists.infradead.org,
 gost.dev@samsung.com, k.jensen@samsung.com
References: <20220713054914.1888305-1-hch@lst.de>
 <20220713054914.1888305-4-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220713054914.1888305-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_022154_327123_D75D5B38 
X-CRM114-Status: GOOD (  11.95  )
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


> Change nvme_ns_scan to gather all information needed for generic
> namespace setup into a nvme_ns_info structure.  This structure is filled
> from the Command Set Idependent Identify Namespace data structure if
> it is available or else the legacy Identify namespace structure.
> 
> With that everything related to the NVM command set (and the ZNS command
> set derived from it) can be encapsulated in the nvme_update_ns_info_block
> function while keeping the rest of the namespace probing generic.
> 
> The downside is that we now always issue two Identify Namespace calls for
> each probed namespace instead of usually just a single one previously.

Maybe nvme_ns_info can have a id reference such that 
nvme_update_ns_info_block can reuse it?

Not that I care all that much, but it does seem redundant.

