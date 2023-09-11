Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CEBEE7FF4
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Sep 2023 15:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TjYmrJjsl3SfHGvoNU0kb/uDqmnjfKb3l9GQBiI06J8=; b=ydHqNijwNIHDQi0pK7fYilvjFK
	0N1W1lzxhrLcBNx0XaR0swFp+xLG7sdYqfxzlu7Exli6kiXu4NxMTXC+9XED76StgcmOLAbCLi/GW
	74Oj7eoGQPD9Oev5uCVvJcyDKC9bvSh9LSGxOxi7N8MH5M6FBAuCQL6IEnRGQDx//ifUowvZS5vFO
	TM9/AOZDcV7u+FKKyH2E/cLewtJtuaVU0vQ4U1x8oz98NY5ZThW802A4DmWyklVNdxnWRoMQx06h2
	g6xqmv8AkvtOzOOMWehJ2cABWlRK3XD1cVtUNcG4E1QQIr0jxNQ3HcljyczBpNne06JKon+c4X2Gh
	9uhOKX9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfj2G-000uxH-2t;
	Mon, 11 Sep 2023 15:41:12 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfj2E-000uwY-1G
	for linux-nvme@lists.infradead.org;
	Mon, 11 Sep 2023 15:41:11 +0000
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40078c4855fso49039015e9.3
        for <linux-nvme@lists.infradead.org>; Mon, 11 Sep 2023 08:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694446866; x=1695051666; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TjYmrJjsl3SfHGvoNU0kb/uDqmnjfKb3l9GQBiI06J8=;
        b=oOjc2u48e3TUBIBDK+026x4jysbrDHM/Dk+rtNLc9VnVwfc6KunexQaRzvwULNKTAb
         Rsz+iOE2j/RqUS3nnfToKhZypK5KvUH/gVIspgsrc2pwFdO1RdoxC3KKjyDRSwrI/xvo
         iRMZ7ULgUtEAYfSsjAIc6Tvbvp+9mSxuQC5OiR8su6Rf0moGH6aHRVWDbPTSCk0Wof4B
         r6RX+iT2TWvrsfIVtMfddYVGGGFPF+B9DiHZRQAnlnn7QybQXMtRMflxBLaI9zr2YhAw
         0wEpErCFo8i3U14Edi0lSBhJv05RO1tfOGG9pW61BPY6ECxANM96D53VJyNnOsE139mF
         GWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694446866; x=1695051666;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TjYmrJjsl3SfHGvoNU0kb/uDqmnjfKb3l9GQBiI06J8=;
        b=wSVTM0IEW0FUvsdMSWNDFhQRvqlBlZpO/X198J0JocgcvNBhk4jSlMd6OMtc32Cr0o
         +RbfVA2ny9YXbj78A3/+ZHVfWhCRo52RAXntpHLIO2XX0EJhp/cyXb6CScRayX1EmcGv
         0XRSQL7h+RetHzC92Lp1k/nRs8EA1sqZH5f0u03HyRcYscClkf9ZP9YMFfkto3unszPL
         BFQX/uRCt/YJOYvJbdpjgs67obdzb8CJZnVlnRMbJ3G0VpKt+VH/1zvPp504hVHlNMpD
         XiLa+Dn3qfFhO21gRseeheAEt6FumEQbn1VBpdMZjzURB1F5YXfDClOz8cnFqgOqegv0
         KEvQ==
X-Gm-Message-State: AOJu0YzAEYnEwqAeJ5jHqn+N8WRRO3PeNJxgsAGUEXOCgfVdh4zzEnvl
	4uAKtosS1oOGah2WwI9Mk74=
X-Google-Smtp-Source: AGHT+IHqM56dQ32aWlcm6F2LZfsLKJXjEIHqvYDsPQJPafx7d0FZvNKolx5YuHnCIio6rpzeuXmtnw==
X-Received: by 2002:a7b:c042:0:b0:401:38dc:8916 with SMTP id u2-20020a7bc042000000b0040138dc8916mr8227931wmc.10.1694446865465;
        Mon, 11 Sep 2023 08:41:05 -0700 (PDT)
Received: from [192.168.1.103] ([185.8.197.9])
        by smtp.gmail.com with ESMTPSA id fl12-20020a05600c0b8c00b00402f745c5ffsm10372450wmb.8.2023.09.11.08.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 08:41:05 -0700 (PDT)
Message-ID: <c766f724-709d-42c1-b0eb-a7a543d28bd6@gmail.com>
Date: Mon, 11 Sep 2023 17:41:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible nvme regression in 6.4.11
Content-Language: en-US
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Genes Lists <lists@sapience.com>, Ricky WU <ricky_wu@realtek.com>,
 Keith Busch <kbusch@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "arnd@arndb.de" <arnd@arndb.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
References: <5f968b95-6b1c-4d6f-aac7-5d54f66834a8@sapience.com>
 <ZN050TFnKZ54LJ5v@kbusch-mbp.dhcp.thefacebook.com>
 <30b69186-5a6e-4f53-b24c-2221926fc3b4@sapience.com>
 <570d465a-7500-4b58-98f0-fd781c8740cc@sapience.com>
 <ZOZEwafA8+tknJNT@kbusch-mbp.dhcp.thefacebook.com>
 <7cf188d0-77b4-4e80-8da6-2045a7f29866@sapience.com>
 <180a2bbd2c314ede8f6c4c16cc4603bf@realtek.com>
 <903830f8-9f9a-4071-9ced-761a55018c5a@sapience.com>
 <97cee217-e438-4fff-836a-186f59d6d256@sapience.com>
 <fa82d9dcbe83403abc644c20922b47f9@realtek.com>
 <5d38cf11-114a-4997-a0fc-4627402468f8@sapience.com>
 <d544fac1-ed2b-4417-8edd-1a81ed8a41d6@leemhuis.info>
From: Augusto Zanellato <augusto.zanellato@gmail.com>
Autocrypt: addr=augusto.zanellato@gmail.com; keydata=
 xjMEZCx4GxYJKwYBBAHaRw8BAQdAzs3qNoRVWI59ACofZ+2FP0XVrKXcrRfYi3Xx/hdJTD7N
 L0F1Z3VzdG8gWmFuZWxsYXRvIDxhdWd1c3RvLnphbmVsbGF0b0BnbWFpbC5jb20+wo8EExYI
 ADcWIQRnOxq9z5pFgCWryKMFxh3iHhl5WAUCZCx4GwUJBaOagAIbAwQLCQgHBRUICQoLBRYC
 AwEAAAoJEAXGHeIeGXlYmMkA/2/c5wdsNA+3y88FFwa5V9l9HJzpJD+nWeL64xakeqdAAP4q
 vg0/NOcUpbnpqZErpTV0eIaylMusdNX7yZ//esUCDs44BGQseBsSCisGAQQBl1UBBQEBB0Cp
 5irXwYE8Jp0e5N34LQc2MiiJ5MRPeAMMe1RddSpcYAMBCAfCfgQYFggAJhYhBGc7Gr3PmkWA
 JavIowXGHeIeGXlYBQJkLHgbBQkFo5qAAhsMAAoJEAXGHeIeGXlYyIQBAJ58AJfxKmn/XFjW
 YU4T0cI/FhDGsDktTghE06r4RDCDAP9lyXA3dJTRhscI0IbQQQq2hGoMv+9u+3nOJQDlpP1w Aw==
In-Reply-To: <d544fac1-ed2b-4417-8edd-1a81ed8a41d6@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_084110_432230_495B2EA6 
X-CRM114-Status: UNSURE (   8.53  )
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

Hi,

I'm also experiencing the issue described in this thread, just wanted to 
chime in with regards to

> Anyway, 6.4.y will likely be EOL in a week or two. Which bears the
> question: are 6.5.y and 6.6-rc1 working better for you?

I can confirm that the issue is still happening and preventing correct 
boot on both 6.5.2 (Arch Linux package version 6.5.2.arch1-1) and on 
6.6-rc1 (Arch Linux package linux-mainline built from AUR).

For reference: the affected machine is a Dell XPS 15 9560 with the 
latest firmware revision (1.31.0) as of time of writing this email, the 
NVMe drive is a Sabrent Rocket4 1TB drive, but the issue also happens 
with the OEM provided Toshiba XG4.

Thanks,

Augusto


PS: it's my first time here in LKML, feel free to tell me if I did 
anything wrong :)



