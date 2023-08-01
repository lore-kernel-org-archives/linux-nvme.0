Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC96C0015E
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Aug 2023 07:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jLwN2mBj+aeKsUvSBKWYPfBwfhA4dyGih0jqe5esi/I=; b=DokkLYEnOjAhU4hos5KNLweCCl
	7oHStbojXn8+bFZYAo8kS1UwshSmCD2SNcv/uwrIZJWLV+t8VIJGLTATjhkhx4K6IbjSfoP7yOaZ6
	WV3EQVmIfzuPCiMPjdgPM+vIZuMMQij3KnMOHWnsHg/abMRHnc7t/YMtd5xd6CiJB3Bb+kJzhtWxn
	EERvLpk461wO3FaTxbPu1gDYta5jh1s5Sfb42is2otkhHanEUlqkHCGGugMdzzGNsIg3X/aCrLXWM
	BI9nA8Ec5cA455/r7gsVWd4qbhePNGYIdOJ9IQp1X28eyLTOe2iDIWbZPO08HJ3yxo25222e9w29j
	RC6WeapA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQjtx-000YtW-2m;
	Tue, 01 Aug 2023 07:34:41 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQjtt-000Ysi-1e
	for linux-nvme@lists.infradead.org;
	Tue, 01 Aug 2023 07:34:38 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3fe23319695so3705445e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 01 Aug 2023 00:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690875275; x=1691480075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLwN2mBj+aeKsUvSBKWYPfBwfhA4dyGih0jqe5esi/I=;
        b=LYngKBS5lwZDSf8VaODnrxQvhNPj3E6Ukc/BaHrDhFaMrvx0PHTNXrHeCHCuspUZu8
         GQyEwoDTDfNzGFMecrXK5L1/l0WxhUeWWxN9nedwBepKHwGFG+jd87crP0PVRcM2Jum7
         Q/rBpnWEmAKC6kK/q/aK2T7bYuSkVSkZfSAsalSBiKPmB1alQPS/EVyyF3n6ahkR5hHk
         wG+jaj3fWDIofo50ucLtRAuR8wlqIWxLGodVP1gAwZ7lYCYXL3sqzZwWVb+dPZiwmNll
         ltrpM+czZBHuRnGfMhsPsnSNwSpmd7t8ntTefsfEHq0uFVZ2lW4GKXT/9FkhHOT890Q8
         gekw==
X-Gm-Message-State: ABy/qLZisJaEngRB1e1KWtyqrbpC+yABLorOl3A37utnCH7PxVHmOZ2s
	7wJ7zcg7DC7gKh8AO9ifee1VHEr4VIA=
X-Google-Smtp-Source: APBJJlFb3o/iXfuCPe6lWQ1gUAUkBzQ0b7rUrLgoQeqIHTilVi337MIMtMouBza3MUjRgy+fPuD32A==
X-Received: by 2002:a05:600c:1d14:b0:3fb:3dd9:89c with SMTP id l20-20020a05600c1d1400b003fb3dd9089cmr7778472wms.0.1690875274815;
        Tue, 01 Aug 2023 00:34:34 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k14-20020adfe3ce000000b00317643a93f4sm15228792wrm.96.2023.08.01.00.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 00:34:33 -0700 (PDT)
Message-ID: <a9c7ae46-6243-89bc-752a-b8d043e7cbae@grimberg.me>
Date: Tue, 1 Aug 2023 10:34:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] nvmet-tcp: pass iov_len instead of sg->length to
 bvec_set_page()
Content-Language: en-US
To: "hch@lst.de" <hch@lst.de>, Varun Prakash <varun@chelsio.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Rakshana S <rakshanas@chelsio.com>
References: <20230727150550.5851-1-varun@chelsio.com>
 <d0badb81-782c-52c8-2b05-06ca6c696157@grimberg.me>
 <BN9PR12MB532469A81B5D3F6C297F91C9BC05A@BN9PR12MB5324.namprd12.prod.outlook.com>
 <20230731193813.GA13587@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230731193813.GA13587@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230801_003437_549475_3C4D6982 
X-CRM114-Status: GOOD (  10.96  )
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



On 7/31/23 22:38, hch@lst.de wrote:
> On Mon, Jul 31, 2023 at 06:30:33PM +0000, Varun Prakash wrote:
>> checkpatch.pl was reporting following CHECK warning so I fixed the alignment.
> 
> checkpatch.pl is unfortunately not much more useful than Markus Elfring
> these days.  Opening brace alignment is a common style and makes sense
> in some places, but tab-based alignment often is much easier to maintain.

Yea, this warning in particular is not something that we are
maintaining. Care to respin the patch?


