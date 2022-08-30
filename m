Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED52ECAAD8
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 07:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZFPWfeE0yXbuggxT46Q1b3hKokdSGBesKVyjgo3kSI0=; b=ertNoE0nfQd8sAB8Vw+QDR14Qb
	T4h/2K3Z1oEwBlPpuxH8CRbEr2uk8tCN7oOuEKRtboPO3wlTphHp2MBpG6kRqw+a+nwyOCgbiosCj
	ENPHS+f2j2Vg618iP9LtvEq0XaGl2QABt5lgpJCM9dnv0Dsp2U0qgdo15Pxu+fVCk6+DAEqsQaQ8A
	MPw0v5e+4Ug0aJyVaE5JfffNG/LGNKC/Tqn1KZ6GYYxRA0sMQJEjpsPu0eecxxaCU95GS7TtT08eE
	MNIw1SHkzf6XUJg2SwZv9Ub4yx1xwCeZMJ4IIULrSK9dZSFOYCqHaay+fBPEsxUvmQO8YtA4kaEZM
	12K1/q/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSvq2-00EpI6-Tv; Tue, 30 Aug 2022 07:39:11 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSvoq-00EokH-4D
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 07:37:57 +0000
Received: by mail-wm1-f52.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso5628936wmb.2
        for <linux-nvme@lists.infradead.org>; Tue, 30 Aug 2022 00:37:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ZFPWfeE0yXbuggxT46Q1b3hKokdSGBesKVyjgo3kSI0=;
        b=HF28xGTie0PqeheiEmViaCc/5v/tikSY7N07qLR5oazz90Zz4eU7wBdD3YnXkZS83H
         hnKNawHUVuao+2iW/Nt7pY7sA08zaKQslPCwOwkN281CJw4qiJOE6X78m2btmwxw19n4
         c8fnQfKAECCPO7rXTFy7w/R3ntzGA8D/MMCtsr2HAnWwVik5oaA5zT/3xcGy3SNuhTlE
         RCDU8yyNa/3OaipgOG7cGPY/hIXK4NYx+K0idrlmO0yU4YB4gcNiMm73asgEu0HzhKCh
         nguHNNT4QInIZ0ovw03MIwSq0A4G4Nwj277+Um5svezqFqda4xy9+8TzC6leJ01sYxYp
         qguw==
X-Gm-Message-State: ACgBeo1vWDLOTHzrhugx0dSUSGpPI/kbhXDNrQsF7O5gPkkkZCF131t7
	4tSmv5DbWNY+HI9Ksf4xgB0=
X-Google-Smtp-Source: AA6agR7yr/iKDu9FRAb7cd/Ze89ntvZQiON0HT1xlo7cCAA880Gh1sOFpkqDauFDQFCGGJ71TPQlhw==
X-Received: by 2002:a1c:7518:0:b0:3a5:1681:b175 with SMTP id o24-20020a1c7518000000b003a51681b175mr8434130wmc.139.1661845073389;
        Tue, 30 Aug 2022 00:37:53 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id c10-20020a05600c0a4a00b003a845621c5bsm6474356wmq.34.2022.08.30.00.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 00:37:52 -0700 (PDT)
Message-ID: <9e623544-8954-4b62-e97c-d5917fb43937@grimberg.me>
Date: Tue, 30 Aug 2022 10:37:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH blktests] nvme: add dh module requirement for tests that
 involve dh groups
Content-Language: en-US
To: Jackie Liu <liu.yun@linux.dev>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hannes Reinecke <hare@suse.de>
References: <20220829083614.874878-1-sagi@grimberg.me>
 <20220830044632.j7k45lhdlyvksrxh@shindev>
 <05548286-8d18-e3b4-06db-640c9d6b1399@grimberg.me>
 <ad345e98-a448-3983-fea8-294bf5558875@linux.dev>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ad345e98-a448-3983-fea8-294bf5558875@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_003756_195727_91C7975C 
X-CRM114-Status: GOOD (  13.43  )
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


> Hi Sagi.
> 
> 在 2022/8/30 15:05, Sagi Grimberg 写道:
>>
>>> Hi Sagi,
>>>
>>> On Aug 29, 2022 / 11:36, Sagi Grimberg wrote:
>>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>> ---
>>>>   tests/nvme/043 | 1 +
>>>>   tests/nvme/044 | 1 +
>>>>   tests/nvme/045 | 1 +
>>>>   3 files changed, 3 insertions(+)
>>>>
>>>> diff --git a/tests/nvme/043 b/tests/nvme/043
>>>> index 381ae755f140..87273e5b414d 100755
>>>> --- a/tests/nvme/043
>>>> +++ b/tests/nvme/043
>>>> @@ -16,6 +16,7 @@ requires() {
>>>>       _have_kernel_option NVME_TARGET_AUTH
>>>>       _require_nvme_trtype_is_fabrics
>>>>       _require_nvme_cli_auth
>>>> +    _have_driver dh_generic
>>>>   }
>>>
>>> Do you see failure without this check?
>>
>> Yes, if dh_generic is built as a module (CONFIG_CRYPTO_DH=m).
> 
> Maybe I don't understand correctly, but I think when NVME_AUTH=y
> CONFIG_CRYPTO_DH can only be built in.
> 

No.

In my .config:
--
...
#
# NVME Support
#
CONFIG_NVME_COMMON=m
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
CONFIG_NVME_HWMON=y
CONFIG_NVME_FABRICS=m
CONFIG_NVME_RDMA=m
CONFIG_NVME_FC=m
CONFIG_NVME_TCP=m
CONFIG_NVME_AUTH=y
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_PASSTHRU=y
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_RDMA=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
CONFIG_NVME_TARGET_TCP=m
CONFIG_NVME_TARGET_AUTH=y
# end of NVME Support
...
#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set
--

