Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531B7C3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Dec 2023 10:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cxv1Az0Y2MtSmBvsW1tKCZjmhh9IH+LHj5TPavDp0/Q=; b=0ciH+jq8iS/TgPAshEOVlGbgfc
	xoPy8vhA0Ar6tWFwOzgeJoAAaSbBG9eFTn2zbSULpMVrFetuWFqBfyxKdaNHB0lfGuan1Gz6Ksgap
	zNcPWuff/SadQP2mvEJ4NAaHRnPP2KyDy2MppP1VVmQZucdnw5fWHNckrIegCZIfgB6xFL8hfecJX
	SAfh5kq8BicnCFIbXtMyXA5WSa88FyImR3Mqm4/WPSA3nrFHHR1V/Mc78yX46/3O+csC+M8jPYnX5
	gKZLKzQV5+v8OxBXrlLN21OEF8h0Jh7W/aenZD51NSvSsSy8x3HQ59Bbku7iuXjH6fMVBs2GjEWnv
	oVA/KF2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rHiRX-00AZru-0G;
	Mon, 25 Dec 2023 10:44:19 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rHiRU-00AZrX-1B
	for linux-nvme@lists.infradead.org;
	Mon, 25 Dec 2023 10:44:17 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d377bd169so11190715e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 25 Dec 2023 02:44:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703501053; x=1704105853;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cxv1Az0Y2MtSmBvsW1tKCZjmhh9IH+LHj5TPavDp0/Q=;
        b=aumxyMTl/shqZyiZtY8glX6YRbWBm+KTaEFxKTFxtzDEXU1eby2eqo528NAi2j9cdl
         /okHV+Yk594UXPEH97RBvv55mjkorEalaLTaEv1UJZpn37Mmoj8yaAEma93JRn5yPE5H
         UT0MyUA2av2QrMLv7QNvoHJQq117USH3nx3WjmskcjuuTSn1Jfnjz3KBL9IvmFV23Bag
         FFJKw5Hf27Ea6SDx+L3x8uP33M1088SRmyJX1htquIoctdXVlQZQthCnhW8iBQgjDZ1U
         V4WgAJtY1qGSbvvE+tDBqp5hK66sv+EuarPVQ/ijIK7SUIdEfqWXbDeW5bEnKKlmL8ot
         8Y9g==
X-Gm-Message-State: AOJu0YzaSDO/QToLhM8yvoa6yaGsMEijPRAaaZxfofNuyzhW8x+Eas0C
	2A6f0+5b+wfhkNAMYzWzZCxXYBsnuQQ=
X-Google-Smtp-Source: AGHT+IE8GTIp7ivP2MKseXIHO1nn0Y0VWjk6sxM618C1fhyumqSkPBsN4c2Pbla3sn5n+CNtt8swNQ==
X-Received: by 2002:a5d:5650:0:b0:333:538a:af10 with SMTP id j16-20020a5d5650000000b00333538aaf10mr5875831wrw.6.1703501053511;
        Mon, 25 Dec 2023 02:44:13 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t16-20020adfe450000000b0033666ec47b7sm10053174wrm.99.2023.12.25.02.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Dec 2023 02:44:13 -0800 (PST)
Message-ID: <ef15a266-d1b6-406b-b956-91cab85e9a4c@grimberg.me>
Date: Mon, 25 Dec 2023 12:44:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: don't set a virt_boundary unless needed
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, marcan@marcan.st, sven@svenpeter.dev,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 James Smart <james.smart@broadcom.com>
Cc: alyssa@rosenzweig.io, asahi@lists.linux.dev,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20231221084853.1175482-1-hch@lst.de>
 <155ec506-ede8-42c7-95f7-e8be32800a8d@grimberg.me>
 <8cfe55f2-4f2e-46f9-bbc8-5ab80d06f3d5@nvidia.com>
 <0f126715-9b51-4e14-8cef-c999f8760e4e@grimberg.me>
 <d5e688be-3419-4cf6-9bd9-bf2c1a6fb092@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <d5e688be-3419-4cf6-9bd9-bf2c1a6fb092@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231225_024416_411299_8D930548 
X-CRM114-Status: GOOD (  35.07  )
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



On 12/25/23 12:36, Max Gurtovoy wrote:
> 
> 
> On 25/12/2023 12:08, Sagi Grimberg wrote:
>>
>>
>> On 12/22/23 03:16, Max Gurtovoy wrote:
>>>
>>>
>>> On 21/12/2023 11:30, Sagi Grimberg wrote:
>>>>
>>>>> NVMe PRPs are a pain and force the expensive virt_boundary checking on
>>>>> block layer, prevent secure passthrough and require scatter/gather I/O
>>>>> to be split into multiple commands which is problematic for the 
>>>>> upcoming
>>>>> atomic write support.
>>>>
>>>> But is the threshold still correct? meaning for I/Os small enough the
>>>> device will have lower performance? I'm not advocating that we keep it,
>>>> but we should at least mention the tradeoff in the change log.
>>>>
>>>>> Fix the NVMe core to require an opt-in from the drivers for it.
>>>>>
>>>>> For nvme-apple it is always required as the driver only supports PRPs.
>>>>>
>>>>> For nvme-pci when SGLs are supported we'll always use them for data 
>>>>> I/O
>>>>> that would require a virt_boundary.
>>>>>
>>>>> For nvme-rdma the virt boundary is always required, as RMDA MRs are 
>>>>> just
>>>>> as dumb as NVMe PRPs.
>>>>
>>>> That is actually device dependent. The driver can ask for a pool of
>>>> mrs with type IB_MR_TYPE_SG_GAPS if the device supports 
>>>> IBK_SG_GAPS_REG.
>>>>
>>>> See from ib_srp.c:
>>>> -- 
>>>>         if (device->attrs.kernel_cap_flags & IBK_SG_GAPS_REG)
>>>>                  mr_type = IB_MR_TYPE_SG_GAPS;
>>>>          else
>>>>                  mr_type = IB_MR_TYPE_MEM_REG;
>>>
>>> For now, I prefer not using the IB_MR_TYPE_SG_GAPS MR in NVMe/RDMA 
>>> since in the case of virtual contiguous data buffers it is better to 
>>> use IB_MR_TYPE_MEM_REG. It gives much better performance. This is the 
>>> reason I didn't add IB_MR_TYPE_SG_GAPS MR support for NVMe/RDMA.
>>
>> I see. I guess it is not *that* trivial then.
>>
>>> I actually had a plan to re-write the IB_MR_TYPE_SG_GAPS MR logic (or 
>>> create a new MR type) that will internally open 2 MRs so if the IO is 
>>> contiguous it will use the MTT/MEM_REG and if it isn't it will use 
>>> the KLM/SG_GAPS.
>>> This is how we implemented the SIG_MR but still didn't make it for 
>>> the IB_MR_TYPE_SG_GAPS MR.
>>
>> Sounds like a reasonable option. But doesn't think mean that the
>> driver will need to scan the page scatterlist to determine what internal
>> mr to use? Even a fallback mechanism can be affected by a given
>> workload. Plus there is the cost of doubling the number of preallocated
>> mrs.
>>
> 
> Scanning the scatterlist is done anyway for mapping purposes so I don't 
> think it will affect the performance.
> The cost of doubling the number of MRs is the what we need to pay to get 
> optimal performance for contig and discontig IOs, I guess..
> 
>>> Actually, I think we should have the same logic in the NVMe PCI driver:
>>> if the IOs can be delivered as PRPs then the driver will prepare SQE 
>>> with PRP. Otherwise, driver will prepare SGL.
>>> I think that doing the check in the driver for each IO is not so bad 
>>> and devices will get benefit from it. Usually HW devices like to work 
>>> with contiguous buffers. If the buffers can't be mapped with PRPs, 
>>> then the HW will work a bit harder and use SGLs (it is better than 
>>> doing a bounce buffer in the block layer).
>>>
>>> I actually did a POC internally for NVMe/RDMA and created sg_gaps 
>>> ib_mr and mem_reg ib_mr and checked the buffers mapping for each IO 
>>> and got a big benefit if the buffers were discontig (used the sg_gaps 
>>> mr). Also the contig buffers performance didn't degraded because of 
>>> the check of the buffers mapping.
>>>
>>> I created a fio flags that in purpose sends discontig IOs for my 
>>> testing.
>>>
>>> WDYT ?
>>
>> Sounds possible. However for rdma we probably want this transparent to
>> the ulp such that all consumers can have this benefit. Also perhaps add
>> this logic in the rdma core so other drivers can use it as well
>> (although I don't know if any other rdma driver supports sg gaps
>> anyways).
>>
>> If this proves to be a good approach, pci can do something similar.
> 
> For RDMA, I plan to do it in the device driver (mlx5) layer and not the 
> ib_core layer. It is unique to our implementation.

Well, SG_GAPS is not intended to be a unique capability (although it is
today in practice I guess).

> 
> For the NVMe PCI case, I suggested doing it unrelated to the NVMe/RDMA 
> solution. The NVMe/PCI is actually the device driver of the PCI device 
> and the scanning of the scatterlist should happen in the device driver.
> I suggest to try this solution since we always debating about thresholds 
> and when to use SGLs.
> Now that Christoph opens the gate for the driver to work with discontig 
> IOs I believe that for *any* discontig IO we should use SGLs and for 
> *any* contig IO we should use PRPs.

Why *any* contig IO? There are certainly cases where sgls would perform
better with sgls than prps I'd assume... For example if a large buffer
is physically contiguous (say a huge page)?

