Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9960ECAAD8
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 07:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jnv2ZmZIrMdU4+ORBQMYYqeQ5sYAavk3951y4o5SGNY=; b=BqCG7YrNzyOtyIZWly5+4nhOz2
	INj6/FYMWnR99gb/0FclpZGyT20Bztl15FDWEVio30vQvlT7enZnaO8z6Y5oyMPGhH4sP6IUgu/D3
	06BHjrzCkKGtn7oDxU3rlOQOqs0ZDf29E9oicoFqtk30mBY62MxAYa8k3Hfwt5Xrx3L76hxnm5IZQ
	GIymG//hepi3rJ791z3CI0qbcitP0UvdRdCVw386OFMbxJq+6NeSt8MBfGDa69NdLmqRJ+YW/Gw4s
	9C7YEMfO8L0kk4PvSRXf420C9unnU5NULx1p/mg0MN6RvbAdTeXY73wwyZhd74FfLlhOqrODzok1i
	4Zck1xJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSw21-00EvST-4Q; Tue, 30 Aug 2022 07:51:33 +0000
Received: from out0.migadu.com ([94.23.1.103])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSvvb-00Es7t-A4
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 07:44:57 +0000
Message-ID: <7e3252ca-c713-ceff-a960-33378534aadf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1661845481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jnv2ZmZIrMdU4+ORBQMYYqeQ5sYAavk3951y4o5SGNY=;
	b=OachzibjkZ7tqJWWlqW3xHbGsQeyPfJRy/EJ3iShT2ay8ufpunPbmtId1dhY8WlFlVpRyK
	v7ysOacN3u4O7ppRw9GGbNtHKobQzqikJl4M05pcrk/f0F3CqQEU1ObrjlnfUShxwmWfrS
	LQzyw9QWUnaaSeFaQpXTXSS0WU/HX/0=
Date: Tue, 30 Aug 2022 15:44:31 +0800
MIME-Version: 1.0
Subject: Re: [PATCH blktests] nvme: add dh module requirement for tests that
 involve dh groups
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hannes Reinecke <hare@suse.de>
References: <20220829083614.874878-1-sagi@grimberg.me>
 <20220830044632.j7k45lhdlyvksrxh@shindev>
 <05548286-8d18-e3b4-06db-640c9d6b1399@grimberg.me>
 <ad345e98-a448-3983-fea8-294bf5558875@linux.dev>
 <9e623544-8954-4b62-e97c-d5917fb43937@grimberg.me>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jackie Liu <liu.yun@linux.dev>
In-Reply-To: <9e623544-8954-4b62-e97c-d5917fb43937@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_004456_215732_2F6774EA 
X-CRM114-Status: GOOD (  10.60  )
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

My fault, my config file becomes y because NVME_CORE is also y.
sorry to bother you.

-- 
Jackie Liu

在 2022/8/30 15:37, Sagi Grimberg 写道:
> 
>> Hi Sagi.
>>
>> 在 2022/8/30 15:05, Sagi Grimberg 写道:
>>>
>>>> Hi Sagi,
>>>>
>>>> On Aug 29, 2022 / 11:36, Sagi Grimberg wrote:
>>>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>>> ---
>>>>>   tests/nvme/043 | 1 +
>>>>>   tests/nvme/044 | 1 +
>>>>>   tests/nvme/045 | 1 +
>>>>>   3 files changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/tests/nvme/043 b/tests/nvme/043
>>>>> index 381ae755f140..87273e5b414d 100755
>>>>> --- a/tests/nvme/043
>>>>> +++ b/tests/nvme/043
>>>>> @@ -16,6 +16,7 @@ requires() {
>>>>>       _have_kernel_option NVME_TARGET_AUTH
>>>>>       _require_nvme_trtype_is_fabrics
>>>>>       _require_nvme_cli_auth
>>>>> +    _have_driver dh_generic
>>>>>   }
>>>>
>>>> Do you see failure without this check?
>>>
>>> Yes, if dh_generic is built as a module (CONFIG_CRYPTO_DH=m).
>>
>> Maybe I don't understand correctly, but I think when NVME_AUTH=y
>> CONFIG_CRYPTO_DH can only be built in.
>>
> 
> No.
> 
> In my .config:
> -- 
> ...
> #
> # NVME Support
> #
> CONFIG_NVME_COMMON=m
> CONFIG_NVME_CORE=m
> CONFIG_BLK_DEV_NVME=m
> CONFIG_NVME_MULTIPATH=y
> # CONFIG_NVME_VERBOSE_ERRORS is not set
> CONFIG_NVME_HWMON=y
> CONFIG_NVME_FABRICS=m
> CONFIG_NVME_RDMA=m
> CONFIG_NVME_FC=m
> CONFIG_NVME_TCP=m
> CONFIG_NVME_AUTH=y
> CONFIG_NVME_TARGET=m
> CONFIG_NVME_TARGET_PASSTHRU=y
> CONFIG_NVME_TARGET_LOOP=m
> CONFIG_NVME_TARGET_RDMA=m
> CONFIG_NVME_TARGET_FC=m
> CONFIG_NVME_TARGET_FCLOOP=m
> CONFIG_NVME_TARGET_TCP=m
> CONFIG_NVME_TARGET_AUTH=y
> # end of NVME Support
> ...
> #
> # Public-key cryptography
> #
> CONFIG_CRYPTO_RSA=y
> CONFIG_CRYPTO_DH=m
> CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
> CONFIG_CRYPTO_ECC=m
> CONFIG_CRYPTO_ECDH=m
> # CONFIG_CRYPTO_ECDSA is not set
> # CONFIG_CRYPTO_ECRDSA is not set
> # CONFIG_CRYPTO_SM2 is not set
> # CONFIG_CRYPTO_CURVE25519 is not set
> # CONFIG_CRYPTO_CURVE25519_X86 is not set
> -- 

