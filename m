Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF54C3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Dec 2023 10:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kx588i4yzmdYc9Oocn+w8D3CjoGy7wR8PfTjDxzWDnY=; b=QOtrTIxsgFwrksVk2VOnQVo1gE
	vXTz6tCai6solaEKjejHKkLztfwUcnJOi+Gz0h+iGrCDyP+9Us5S1KGkQ7Gn/AZI/niou9f2OySqx
	zbsdOYKTg50Z2bK8gPAD0mNHDI7zSPZS8z9td+BCP2VgQHzdOhkoQ6LHX4qd8OS8bmi5MJC8iA8NH
	fr0C89eh1QWOivY/vIpIMzR3Skkne23dzitJX7HXheeMx2iNDiBsVttkfP5eXF+Nl4erLE/cXmyYs
	ejDnSelLcp7JjpokSmkLSE7uuAZ/LenftFj2psRD0/EXlV+sZpaGVWBfxBAD78dr62/bfzKAJ14/Y
	8oRaidBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rHhtE-00AW1k-3D;
	Mon, 25 Dec 2023 10:08:53 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rHhtC-00AW1G-2J
	for linux-nvme@lists.infradead.org;
	Mon, 25 Dec 2023 10:08:52 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d4ef21007so4992475e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 25 Dec 2023 02:08:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703498926; x=1704103726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kx588i4yzmdYc9Oocn+w8D3CjoGy7wR8PfTjDxzWDnY=;
        b=snIuWmpsITga9MFlFFxCsFu0pVLBYWbNI7JR41E4lRxTumd314UdBjaPlPY7RMp+ec
         p3/lYnvYa+ccHrmr/qhY5fX72Eu5Nb+PR4sQ+QVUaA+1M4gO3zEL9fck57EXGko3uM1b
         OpJhSmyfifZHhPdLpwuLUNayeJAb/9zmR5bUQcK+Nvdbi4oCEgVYZRUJpjXy+FhORXnF
         nslCm6vjQShCHr9bh5nn0juIZ18nUVL4pavUJTGHswNqqLqBAMe/sokH/YKDwKBwFSfD
         IF2ca/jbhJO7oOsN3wSVaMLMBj44sqS3E0puTtvRIkOt/iDexV5moTP7YnI3pbkG0RK4
         /umA==
X-Gm-Message-State: AOJu0YzfZJY6GwQ/xeqU/meFDzRDfMj4Txxp+jf3vlmuRQmdMyQWtzHM
	Mta/U5hhVKeVggjup3agyFg=
X-Google-Smtp-Source: AGHT+IE9k4irEk8nSBKLXVXvh8jnlU0qiIkoxFAVJbqc6cVw6khHs/N2QvaHUgLvnirPqchknnn0/w==
X-Received: by 2002:a05:600c:1c07:b0:40d:3dfb:1cbe with SMTP id j7-20020a05600c1c0700b0040d3dfb1cbemr7373379wms.2.1703498926162;
        Mon, 25 Dec 2023 02:08:46 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c4f5200b0040d547aa413sm5098154wmq.17.2023.12.25.02.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Dec 2023 02:08:45 -0800 (PST)
Message-ID: <0f126715-9b51-4e14-8cef-c999f8760e4e@grimberg.me>
Date: Mon, 25 Dec 2023 12:08:43 +0200
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
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <8cfe55f2-4f2e-46f9-bbc8-5ab80d06f3d5@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231225_020850_753867_8D095357 
X-CRM114-Status: GOOD (  31.30  )
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



On 12/22/23 03:16, Max Gurtovoy wrote:
> 
> 
> On 21/12/2023 11:30, Sagi Grimberg wrote:
>>
>>> NVMe PRPs are a pain and force the expensive virt_boundary checking on
>>> block layer, prevent secure passthrough and require scatter/gather I/O
>>> to be split into multiple commands which is problematic for the upcoming
>>> atomic write support.
>>
>> But is the threshold still correct? meaning for I/Os small enough the
>> device will have lower performance? I'm not advocating that we keep it,
>> but we should at least mention the tradeoff in the change log.
>>
>>> Fix the NVMe core to require an opt-in from the drivers for it.
>>>
>>> For nvme-apple it is always required as the driver only supports PRPs.
>>>
>>> For nvme-pci when SGLs are supported we'll always use them for data I/O
>>> that would require a virt_boundary.
>>>
>>> For nvme-rdma the virt boundary is always required, as RMDA MRs are just
>>> as dumb as NVMe PRPs.
>>
>> That is actually device dependent. The driver can ask for a pool of
>> mrs with type IB_MR_TYPE_SG_GAPS if the device supports IBK_SG_GAPS_REG.
>>
>> See from ib_srp.c:
>> -- 
>>         if (device->attrs.kernel_cap_flags & IBK_SG_GAPS_REG)
>>                  mr_type = IB_MR_TYPE_SG_GAPS;
>>          else
>>                  mr_type = IB_MR_TYPE_MEM_REG;
> 
> For now, I prefer not using the IB_MR_TYPE_SG_GAPS MR in NVMe/RDMA since 
> in the case of virtual contiguous data buffers it is better to use 
> IB_MR_TYPE_MEM_REG. It gives much better performance. This is the reason 
> I didn't add IB_MR_TYPE_SG_GAPS MR support for NVMe/RDMA.

I see. I guess it is not *that* trivial then.

> I actually had a plan to re-write the IB_MR_TYPE_SG_GAPS MR logic (or 
> create a new MR type) that will internally open 2 MRs so if the IO is 
> contiguous it will use the MTT/MEM_REG and if it isn't it will use the 
> KLM/SG_GAPS.
> This is how we implemented the SIG_MR but still didn't make it for the 
> IB_MR_TYPE_SG_GAPS MR.

Sounds like a reasonable option. But doesn't think mean that the
driver will need to scan the page scatterlist to determine what internal
mr to use? Even a fallback mechanism can be affected by a given
workload. Plus there is the cost of doubling the number of preallocated
mrs.

> Actually, I think we should have the same logic in the NVMe PCI driver:
> if the IOs can be delivered as PRPs then the driver will prepare SQE 
> with PRP. Otherwise, driver will prepare SGL.
> I think that doing the check in the driver for each IO is not so bad and 
> devices will get benefit from it. Usually HW devices like to work with 
> contiguous buffers. If the buffers can't be mapped with PRPs, then the 
> HW will work a bit harder and use SGLs (it is better than doing a bounce 
> buffer in the block layer).
> 
> I actually did a POC internally for NVMe/RDMA and created sg_gaps ib_mr 
> and mem_reg ib_mr and checked the buffers mapping for each IO and got a 
> big benefit if the buffers were discontig (used the sg_gaps mr). Also 
> the contig buffers performance didn't degraded because of the check of 
> the buffers mapping.
> 
> I created a fio flags that in purpose sends discontig IOs for my testing.
> 
> WDYT ?

Sounds possible. However for rdma we probably want this transparent to
the ulp such that all consumers can have this benefit. Also perhaps add
this logic in the rdma core so other drivers can use it as well
(although I don't know if any other rdma driver supports sg gaps
anyways).

If this proves to be a good approach, pci can do something similar.

