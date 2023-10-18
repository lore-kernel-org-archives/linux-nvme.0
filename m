Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08378CDB47E
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 19:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xe+WwJ6TjShLaMsrzNtVCcWAREyM/H61H6plgYB/UgQ=; b=SLsucuLbczk29BT3S5YNNesPef
	OMdgH3fGtdJZdsMKNOJNqHG5MVtK3NuKVQbZFmxHGerX6+995vDwR9zh4TZkII/kISSjte8hzdk4L
	QsmjStq2bbIPL6vb+Jf5p8r66bKFRfUG1jvzaKgT0cRCFGnfPBdGplEVXSiGuZ0G6gV1/isI5+8jN
	yeDOuIWNOHTav+Z26LwwaIOg5TPgiXOvD9CKzAtOBvtekSfegyJ6IjZYg7krjGwfg/IXFglWB68MF
	6r4Z1GkbQF2ogYPk79sLYkHgogsyFVfLS7KLEXHIDkV0HRyFPxuVmvBVxDrJ0Y5EYrAIj3AJVxhlE
	i2loZV0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtCVn-00FZPo-0S;
	Wed, 18 Oct 2023 19:47:23 +0000
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtCVj-00FZOQ-25
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 19:47:22 +0000
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7a66bf80fa3so19463139f.0
        for <linux-nvme@lists.infradead.org>; Wed, 18 Oct 2023 12:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697658435; x=1698263235; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xe+WwJ6TjShLaMsrzNtVCcWAREyM/H61H6plgYB/UgQ=;
        b=EAZxvm2bwon2H0VngM4bzsWudPk+TI7I4K0h0nkGucDdEcz9b07RKtZui9NaVFV78i
         G+behYqGqb3N/FwiBKXZ8/cv9/FnDx6Jgc9HuvrUnO9yKMVMMpuSjR9cgBaPdcyBNsgL
         0+xLZRjyYVvTdYO+yIsKBrpE3zcogYqmWb78A9U85lX4P9x4nBmteTDXJC6Z6odaiWM7
         pkOWg0VSjnmP5xudgpmiqhs0nYUZ7LQg2tn5zQSGoH8j6XI8AX/ZNIgv1KbGARbdT5tP
         8MLH0LlkAnqao6niA26lAJ5Ru3ewnKbRiLwGjEGGijn8j4wCmWNOoUEgZ4fX/k1MHLbx
         abfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697658435; x=1698263235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xe+WwJ6TjShLaMsrzNtVCcWAREyM/H61H6plgYB/UgQ=;
        b=RSuyYNNUflyNuLhjFdUqn4P6wWuD/RA3Ja0/lFd6ywLrcWEx/WfQdY5+HCXMyfeyjB
         6cIaVKPYBJAVNz7TniLYnjN3Xf25OAtlzIk75Zr0jEgwAiZyViXNvGt3sck6aaYtzWfR
         78IYAUrFgNEEyxfyK7aWbv7fcBgoAA80SiThrbCStb+EGmWjdHpaNsG0SHuy6auHAJ7Z
         aNBDn2YxW7XzVQTef9SFqjAJdCV9Q1qGwCzRSphJYDE1a3vdkG4GI8T7sz+aiRwdAY5+
         x6xz+mJYh9CqDPHAU4P4mEXX8Qa8h3hMkedWahrxR+f8HalzA8BXO88/DEv1GwKvc6N+
         TS3g==
X-Gm-Message-State: AOJu0YxxpMaUf17iJndaMiuq3fgk08arzKvQgmRRjnjz+95N7npsmBwE
	XfXqGwxzCsj4wzqAqzti4SHRl0Aj5huLYdhbdduBdA==
X-Google-Smtp-Source: AGHT+IFIaGUs0BoLHivk6UR9XoMXp2jhACDG4KjAjXRigOKsOUcuE8lxydS7zLBOQdnIFV6vSFdKRg==
X-Received: by 2002:a05:6e02:350c:b0:357:a23c:b99b with SMTP id bu12-20020a056e02350c00b00357a23cb99bmr393804ilb.3.1697658435078;
        Wed, 18 Oct 2023 12:47:15 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b14-20020a92dcce000000b0034aa175c9c3sm1307007ilr.87.2023.10.18.12.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 12:47:14 -0700 (PDT)
Message-ID: <c5474fb6-d825-40dc-99b7-bd1eafb1267c@kernel.dk>
Date: Wed, 18 Oct 2023 13:47:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Unprivileged sgl-only passthrough
Content-Language: en-US
To: Kanchan Joshi <joshiiitr@gmail.com>, Keith Busch <kbusch@kernel.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, gost.dev@samsung.com
References: <CGME20231018183620epcas5p26ab74bdd1f2739ef3ec1ee2431329dc4@epcas5p2.samsung.com>
 <20231018183003.41174-1-joshi.k@samsung.com>
 <2f6cdecc-d51b-4cbf-a0dd-ccd22fac8a98@kernel.dk>
 <ZTAzaJ_4zrFF3Tag@kbusch-mbp>
 <CA+1E3rJ1FNOCYQDq7oT5je85723sanD-d9L3u=Ta6kmz45q3vw@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CA+1E3rJ1FNOCYQDq7oT5je85723sanD-d9L3u=Ta6kmz45q3vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_124719_899325_35B8F8A1 
X-CRM114-Status: GOOD (  16.25  )
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

On 10/18/23 1:44 PM, Kanchan Joshi wrote:
> On Thu, Oct 19, 2023 at 1:05?AM Keith Busch <kbusch@kernel.org> wrote:
>>
>> On Wed, Oct 18, 2023 at 12:40:35PM -0600, Jens Axboe wrote:
>>> On 10/18/23 12:30 PM, Kanchan Joshi wrote:
>>>> Patch 1: Prep. Adds the meta-transfer ability in nvme-pci
>>>> Patch 2: Enables fine-granular passthrough with the change that i/o
>>>> commands can transfer the data only via SGL.
>>>>
>>>> Requirement:
>>>> - Prepared against block 6.6 tree.
>>>> - The patch in uring-passthrough failure handling is required to see the
>>>>   submission failure (if any)
>>>>   https://lore.kernel.org/linux-nvme/20231018135718.28820-1-joshi.k@samsung.com/
>>>
>>> I didn't have time to follow the previous discussion, but what's the
>>> reasoning behind allowing it for SGL only? IIRC, we do have an inline
>>> vec for a small number of vecs, so presumably this would not hit
>>> alloc+free for each IO? But even so, I would imagine that SGL is slower
>>> than PRP? Do we know how much?
>>
>> SGL for metadata is definitely slower, but it's the only nvme protocol
>> way to directly specify how much memory is actually available for the
>> command's transfer. PRP/MPTR vs SGL is like strcpy() vs strncpy().
>>
>> Similiar to Kanchan's earlier experience though, I haven't found real
>> nvme devices that support the SGL mode for metadata. The scenarios this
>> enables might be pretty limited. :(
> 
> What I found later was that - all the enterprise drives (of samsung)
> support SGL for data/meta.
> I have tested this code on one such SSD and on QEMU.

Maybe a moot point given the status of the product, but it does look
like the gen2 optanes at least do support SGL for metadata.

-- 
Jens Axboe


