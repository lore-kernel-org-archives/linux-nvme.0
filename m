Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D89C54E94
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jan 2023 18:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mwAmBoR3cwmddnBmtWsfOPiZ2ePVD6qxgtdrWf9ViTY=; b=lmrNpadJZnbCktYfwYbf6N0szn
	cuKE/YRXPXBR4XVefLCuh31/vOmouuKVw6zNq+PDCdlrTqO8ZCsEsprVPQQkRMU5qh8iFCa3CD4+o
	23KTm7eHKHprgNxnqnaJ9dQLXACgQqvj2r01m7ud8YVA2crjzCjfROsfyM+Z7GuWrjZHzdCzKvplL
	9vcaX3GHjv2f6Mh2nGAN5NNqdv9pgIH+rusZlmSZUticZXHh7dflj5Lg7B6N5XSVU8o1dED+VTnym
	2EtvxceLx51LytMKnuqe7kq/zST3oUj6iv8E9pXKjmeck5Q28mtEMRplHg5Aik3KZgaRbtSXepdFv
	/56IAgVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKOHz-004ybO-0l; Tue, 24 Jan 2023 18:44:59 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKOHv-004yaX-Or
	for linux-nvme@lists.infradead.org; Tue, 24 Jan 2023 18:44:57 +0000
Received: by mail-pl1-x631.google.com with SMTP id c6so15641535pls.4
        for <linux-nvme@lists.infradead.org>; Tue, 24 Jan 2023 10:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mwAmBoR3cwmddnBmtWsfOPiZ2ePVD6qxgtdrWf9ViTY=;
        b=Y9ff5QnNGw8eBRmwllFZm8QcB9PYhIa+upXTjw4WvLIEPz8L00DAII/ivFeTuwE4FI
         4xePUplCsit+4u5zte6Ka3KiZRX2/Tyb4bJRjQUvT4AqhcDQAS6k7FnxdYWiPUmqaSaV
         3RxSJpaGYi6aPCHU3l1VgX5uZ2Lf+eUgRmtT1rN8bj5ap8ckoa2jJjL2tpYjnJJgmpTA
         +2OB01XUUILEPzTUsa9poV/Q1OKhrLoHLxK4QWXywWJtN2Gla28vwhaGrct78yemWmem
         M7otQdeoAzj3g8h0uJ5wfYDDqwZSErgmMnj/YbbN6kUxw8BP4p1LkHcIgtxe1UMXhQuu
         Z/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwAmBoR3cwmddnBmtWsfOPiZ2ePVD6qxgtdrWf9ViTY=;
        b=puds8wiQnhP3/7nAuTBNGsPOM1DDp1cPk3Ei1wSYgLDulryYtGCdo3mU+G/5ZyujBs
         mUd7Xve+YRVY+P0/Gypqq0qTs6MK12au9MXU75mhctbtaDgVysKCOB77IqZbUHLVmK+v
         yk/mkHy/gtkCkvnNhS3fOORv1VFrI6k4sPvTmkMHSpD1jEywsBnpBM4OBK+iDIs4iIlr
         D4uciDbfghWofJ7OAD8C7GSqRIT9FYcCh13A+Yz9o0hKzPc5B6O6F0SkwdxUem9qLB98
         Hn8jZK2Unn5BXzenyQuQprB0LJvSKa31tshHD5GtlLpF0C1I8Bs2PhsCJMoeVZPZ4lav
         9ptg==
X-Gm-Message-State: AFqh2krDsEGzuMEjsUjKwu/R0/mfkM/oaVpsGc8qvCrIb425UjQfCx2g
	PJXBKvmNrsTEJtT3G8VSbXs=
X-Google-Smtp-Source: AMrXdXtq/4VW45A+AceKPhEcsewqwwGH/jP2DLiIAAGGwHPe/hhCFPxQP5RrtM9p3i3hoRKCBel2hA==
X-Received: by 2002:a17:902:d590:b0:193:33d4:181e with SMTP id k16-20020a170902d59000b0019333d4181emr31219259plh.66.1674585893687;
        Tue, 24 Jan 2023 10:44:53 -0800 (PST)
Received: from [10.69.46.142] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902b40700b0019604f3fc3asm1961043plr.265.2023.01.24.10.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 10:44:53 -0800 (PST)
Message-ID: <171ea3d1-3e23-4fb7-8e16-287327757afb@gmail.com>
Date: Tue, 24 Jan 2023 10:44:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] nvme-fabrics: introduce existing_ctrl operation
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, hch@infradead.org, kbusch@kernel.org
Cc: israelr@nvidia.com, chaitanyak@nvidia.com
References: <20230115100341.40347-1-mgurtovoy@nvidia.com>
 <e89cc27a-4b8f-6503-fec9-670de2bb885e@grimberg.me>
 <b26b8444-6195-da79-d7bb-addae0059446@nvidia.com>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <b26b8444-6195-da79-d7bb-addae0059446@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230124_104455_834969_35310F04 
X-CRM114-Status: GOOD (  23.60  )
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

On 1/23/2023 5:34 AM, Max Gurtovoy wrote:
> Hi Sagi,
> 
> On 23/01/2023 14:33, Sagi Grimberg wrote:
>>
>>> The check if the connection request matches an existing controller is
>>> duplicated in several transports (such as RDMA and TCP). Move it to
>>> common code as optional operation.
>>>
>>> Also, this check can be done before creating the controller to simplify
>>> the flow.
>>>
>>> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
>>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>> ---
>>>   drivers/nvme/host/fabrics.c | 7 +++++++
>>>   drivers/nvme/host/fabrics.h | 3 +++
>>>   2 files changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>>> index ce27276f552d..3d5035331b9f 100644
>>> --- a/drivers/nvme/host/fabrics.c
>>> +++ b/drivers/nvme/host/fabrics.c
>>> @@ -1100,6 +1100,13 @@ nvmf_create_ctrl(struct device *dev, const 
>>> char *buf)
>>>       if (ret)
>>>           goto out_module_put;
>>>   +    if (ops->existing_ctrl) {
>>> +        if (!opts->duplicate_connect && ops->existing_ctrl(opts)) {
>>> +            ret = -EALREADY;
>>> +            goto out_module_put;
>>> +        }
>>> +    }
>>> +
>>>       ctrl = ops->create_ctrl(dev, opts);
>>>       if (IS_ERR(ctrl)) {
>>>           ret = PTR_ERR(ctrl);
>>> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
>>> index a6e22116e139..587b92575a9b 100644
>>> --- a/drivers/nvme/host/fabrics.h
>>> +++ b/drivers/nvme/host/fabrics.h
>>> @@ -153,6 +153,8 @@ struct nvmf_ctrl_options {
>>>    *            that would go into starting up that fabric
>>>    *            for the purpose of conneciton to an NVMe controller
>>>    *            using that fabric technology.
>>> + * @existing_ctrl():    optional function pointer that checks if a 
>>> connection
>>> + *             request matches an existing controller.
>>>    *
>>>    * Notes:
>>>    *    1. At minimum, 'required_opts' and 'allowed_opts' should
>>> @@ -170,6 +172,7 @@ struct nvmf_transport_ops {
>>>       int            allowed_opts;
>>>       struct nvme_ctrl    *(*create_ctrl)(struct device *dev,
>>>                       struct nvmf_ctrl_options *opts);
>>> +    bool            (*existing_ctrl)(struct nvmf_ctrl_options *opts);
>>>   };
>>>     static inline bool
>>
>> Maybe do nvmf_existing_ctrl() that iterates with device_for_each_child 
>> and filters by transport?
>>
> do you propose some incremental logic to this series or to change some 
> logic in the existing patches ?
> 
> 
>> This will eliminate the identical code from rdma/tcp and potentially
>> from fc?
> 
> We agreed that FC will use this common code after some cleanup/changes.

no - we agreed FC is better off the way it is and not using the common 
routine. Adding the routine would increase code and add locking for no 
benefit as the same searching has to be repeated in init_ctrl for checks 
other than opts.


> 
> We can't hold improvements to the subsystem if some specific transport 
> has to do some preparations/re-designs to fit common code.
> 

Only way to make this meaningfully common is to have a different list 
mechanism to search through existing controllers.

If we can globalize the controllers so there's a list of them off a 
transport object then doing something like Sagi suggests works, and no 
need for a callout.

-- james


