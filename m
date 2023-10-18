Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B662CDB482
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 19:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fHOmG9Mv1SCkQq6pzPPN9o5GSoRKcWHnFhXiBj3syXU=; b=U0+9tqkmVK+vZBCEewe3L4/3O/
	4vhnB6pPhXb4HRYJSEIW4bRJVsM7aW97IaQDMqRokoh62nTbz8tscfazEABkOEmGuDwdwnKkTMbT/
	pfBaIevWJPjeaMLiiLhOj0/uOTHxLg0EQHHKQm+jq2SL//gGgNh4PUuPvX1YZhqTH7FkCQp2Mlm3G
	gh31pBPhzS9R58DWD9v8iy/6XbvCbjw7McL5k+oAdK5ptSDZbe1ZCEaatLzMCiBfLQX/Y/L1ySYit
	hxLvHgx1CVoVvtYbdlzr+lcCalW7pKWCVq9dwtvdmJ8Q4cCv0TsZdgzeWbGNRFfrheX2eaBmAGB3k
	3YWBb1xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtBy6-00FWlq-1q;
	Wed, 18 Oct 2023 19:12:34 +0000
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtBy2-00FWkt-2E
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 19:12:32 +0000
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7a29359c80bso59330639f.0
        for <linux-nvme@lists.infradead.org>; Wed, 18 Oct 2023 12:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697656348; x=1698261148; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fHOmG9Mv1SCkQq6pzPPN9o5GSoRKcWHnFhXiBj3syXU=;
        b=I51GJkjP1phYlpiAUnA1/uPbimjFV/iUszricY75E3R5ssimyUtqYNYzXoz6limANT
         Jz+lgqh++B6V7KMccctXQT3DXZOCQPOpnM62JQIbgm3voDrLnxR4U+q3+hemnV60oHp+
         zhgTIbrLxE7Xfm129egOb7q3qNFNZCwwhciMhSwHD/M1Li8bANObUNIPC1eAHontXnvt
         JOYaNAkbQmgVyvqHThIC1p4+TTwL3lUQWHiIpPH1yJBIbuBEQcEfKQwQA31nD3b3+qpX
         OLFbKO6s/T0FBt4/13zNARuPaIoZ4Q5+qkR0dRCMvbjwtZ9kHyW1Wm7/qnkLsV+OYG4L
         rRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697656348; x=1698261148;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHOmG9Mv1SCkQq6pzPPN9o5GSoRKcWHnFhXiBj3syXU=;
        b=t8d/EFsSOCROD5Wqajo7BD3t1Ttjm8j7m7Tu4x+Lc97LGxfdsVxnocpFe5BybliDuR
         0PPGL+6SzffQOvDS1KiKis7Rpb2OqxUXvBwJyshVSoO4rhWiVrlog/YiQlGTR+Kp0uMG
         9hl/Ur4m2t5FgSYEUfTX3E9pwe26kLIUlzQTBsr5Y+iuWZixZoC24u94eMAd/2gblWDG
         8FnzlYl0UdwsUDIsls3m6JM3cpmHT7P8Cu/dyzLuDCQ5PaSsyTv+JuDUPcu9sKGT3oon
         DtlRNdWcqHNwCwM7UvwSIeF/HMo7zdMzpiLwYXMq1+QGPFGAmH4DOMft03OlQrPe2PEg
         0iAg==
X-Gm-Message-State: AOJu0Yzg7U8H9hDy+E/E3UXx333w40KjxUAGgZtHAX4u5ZkhVB7wLF6C
	R4eyAY+dp5pt6xaNQzCFrr0dGOBSXEvBj3elfIMRfQ==
X-Google-Smtp-Source: AGHT+IGb0UJkELvjqGAFJT2CzlslSCh++SmyvYe6ILsRNNna+uq0AbjJsduns4ws4QYJbcb8YfJAzQ==
X-Received: by 2002:a5d:9d56:0:b0:79d:1c65:9bde with SMTP id k22-20020a5d9d56000000b0079d1c659bdemr183634iok.1.1697656348485;
        Wed, 18 Oct 2023 12:12:28 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id f10-20020a056638168a00b0042b47e8869bsm1453665jat.49.2023.10.18.12.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 12:12:27 -0700 (PDT)
Message-ID: <0ada1f4f-df57-4be2-8295-696b8cdb720d@kernel.dk>
Date: Wed, 18 Oct 2023 13:12:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Unprivileged sgl-only passthrough
Content-Language: en-US
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, linux-nvme@lists.infradead.org, gost.dev@samsung.com
References: <CGME20231018183620epcas5p26ab74bdd1f2739ef3ec1ee2431329dc4@epcas5p2.samsung.com>
 <20231018183003.41174-1-joshi.k@samsung.com>
 <2f6cdecc-d51b-4cbf-a0dd-ccd22fac8a98@kernel.dk>
 <CA+1E3rJks2GVqNJ_YrUv4g78oNTHc9zkHc7-myPLOGp1U2mJJA@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CA+1E3rJks2GVqNJ_YrUv4g78oNTHc9zkHc7-myPLOGp1U2mJJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_121230_737877_F67D24B5 
X-CRM114-Status: GOOD (  21.71  )
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

On 10/18/23 1:06 PM, Kanchan Joshi wrote:
> On Thu, Oct 19, 2023 at 12:10?AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 10/18/23 12:30 PM, Kanchan Joshi wrote:
>>> Patch 1: Prep. Adds the meta-transfer ability in nvme-pci
>>> Patch 2: Enables fine-granular passthrough with the change that i/o
>>> commands can transfer the data only via SGL.
>>>
>>> Requirement:
>>> - Prepared against block 6.6 tree.
>>> - The patch in uring-passthrough failure handling is required to see the
>>>   submission failure (if any)
>>>   https://lore.kernel.org/linux-nvme/20231018135718.28820-1-joshi.k@samsung.com/
>>
>> I didn't have time to follow the previous discussion, but what's the
>> reasoning behind allowing it for SGL only?
> 
> This was a solution that emerged while discussing how best to fill the
> DMA corruption hole for passthrough.
> With SGL, the buffer length (data/buffer) sanity checks are done by
> the SSD and it fails the IO rather than doing extra transfer.

Yay hardware...

>> IIRC, we do have an inline
>> vec for a small number of vecs, so presumably this would not hit
>> alloc+free for each IO?
> 
> 16b dma_pool_alloc/free for each IO that involves metadata. This is to
> keep the nvme-sgl that points to the metadata buffer.
> Hopefully some ideas can emerge (during the review) to see if we can
> do away with it.

OK, so at least nothing if meta data isn't being used. I know of at
least one use case for meta data and passthrough, so would be nice to at
least have an eye on making that situation better.

>> But even so, I would imagine that SGL is slower
>> than PRP? Do we know how much?
> 
> I do not know at the moment. Plan is to evaluate this soon.
> 
> BTW, SGL-only mode is for unprivileged users only. For root, it
> remains the same as before (prp or sgl depending on the data-transfer
> length).

That's nice at least.

Thanks for the clarifications.

-- 
Jens Axboe


