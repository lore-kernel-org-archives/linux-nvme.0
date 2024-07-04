Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE13C30653
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jul 2024 09:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GA/ZwXHT3Xt5r7YH7ynzCkoSFBypGnzLwJhO/3azb8M=; b=u5AoL5ReWG6IfJuIcy5qqSXoVA
	zZkHbD3tlgoEqAwDDhmUveuB4KqPo4MNcpnDTio5JlFgv0uVHAveJabKrs+qBfCL9DdffRQBDF8pA
	B7R3QGiv6oF1Mui1IiAvpGrV6Q2FRwdpFeV/SlXqZKW+KCFRPj0fgUy/Ir59uXlnrYIL62kmcD3ug
	tFOMewgXavekK90kw/XSFw/Df4DxC/KzZUBB2aEv26+roTnYyueM5MAEfZETYJwyXKuT3MntvdPE8
	UQVRO39UsqwO+pQMZx5f1dQGSDEuCSA8GuCHTzmszhT3mjooiU/Q10Nnr9BO8tsd0Vtppj/IOIA+g
	QQGj/U4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPIVZ-0000000CiGr-1bfe;
	Thu, 04 Jul 2024 09:12:05 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPIVV-0000000CiGS-2JUS
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jul 2024 09:12:02 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-424ab8c2d95so490115e9.2
        for <linux-nvme@lists.infradead.org>; Thu, 04 Jul 2024 02:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720084320; x=1720689120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GA/ZwXHT3Xt5r7YH7ynzCkoSFBypGnzLwJhO/3azb8M=;
        b=pf6MnD/nwqDZv1x5fx1zx9opnueQhlE3DMmtSv0vs7OMWP7DbSpGADpJBXVuGQ8R5T
         CYYos/tpI7WqR/sMXMBXUdZH7H9M2KfmHspc05zgDcCd3klJOCIiSAf8dKJzzBsD7Y8A
         jykpke0sqgrIKyrsO0dWfLVCsCbwL8p/ecMhdqRzhbli+M9v1NFDUrdyCO/PHEjRoW+u
         TZ88rojbF2JiV2nxkWCu+QIdJ9nvz8w9LeF9zBPgxKtDbpYFRjGcfSUdW2RZDJqhpmcb
         k4ifZPjemwrbiaNRCy8rR4FA0mQRExFrczyoYjNBBE+ieOTJCKeA1bBWKP9PZgsvknKg
         xHHw==
X-Forwarded-Encrypted: i=1; AJvYcCXwfHIcPUN+Ei0sOaVOXyEMWyygAcyfYVikH5m6aFo3gluKI9XmtIEK53LkzfsMja7pBBDEvQNqDoGAU8kMORPuKJQItnDR3cHTqaPccwA=
X-Gm-Message-State: AOJu0Yw6Yb4UrZ5v4omTH45uYvzFdoBVNt7RauyE0DYsr2kTp9vN6yfO
	cIgJTzT28JFZapDWs/wJ0ivT8U1T9472PqPLc+E/7rPJ5ZbYTz3Ud/FOmuCc
X-Google-Smtp-Source: AGHT+IGvzJFaOAtbxEaY09IypEjaBwsM2T5uSkyWFuzXEo22jS5Ti2f6+kmfmYTCdwTPAwZ6jhfP2A==
X-Received: by 2002:a05:6000:1788:b0:360:8490:74d with SMTP id ffacd0b85a97d-3679dd739ecmr742780f8f.5.1720084319691;
        Thu, 04 Jul 2024 02:11:59 -0700 (PDT)
Received: from [10.100.102.67] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd6b4sm17786422f8f.17.2024.07.04.02.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 02:11:59 -0700 (PDT)
Message-ID: <ed21cca6-4d79-4edc-935b-20e342a4d352@grimberg.me>
Date: Thu, 4 Jul 2024 12:11:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] nvme-tcp: switch to 'cpu' affinity scope for unbound
 workqueues
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240703135021.34143-1-hare@kernel.org>
 <20240703135021.34143-5-hare@kernel.org>
 <1259766c-234e-4958-a16f-9de753a4a0b5@grimberg.me>
 <792eeb90-90ba-4750-ab22-622023967eeb@suse.de>
 <2b0dbd25-bfa5-4a0c-842b-50c27b0843a7@grimberg.me>
 <56ebc95e-8c9c-43cb-a849-a1bbdd4a98e6@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <56ebc95e-8c9c-43cb-a849-a1bbdd4a98e6@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_021201_628750_2747C38F 
X-CRM114-Status: GOOD (  22.40  )
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



On 7/3/24 18:50, Hannes Reinecke wrote:
> On 7/3/24 17:09, Sagi Grimberg wrote:
>>
>>
>> On 03/07/2024 18:01, Hannes Reinecke wrote:
>>> On 7/3/24 16:22, Sagi Grimberg wrote:
>>>>
>>>>
>>>> On 03/07/2024 16:50, Hannes Reinecke wrote:
>>>>> We should switch to the 'cpu' affinity scope when using the 
>>>>> 'wq_unbound'
>>>>> parameter as this allows us to keep I/O locality and improve 
>>>>> performance.
>>>>
>>>> Can you please describe more why this is better? locality between 
>>>> what?
>>>>
>>> Well; the default unbound scope is 'cache', which groups the cpu 
>>> according to the cache hierarchy. I want the cpu locality of the 
>>> workqueue items to be preserved as much as possible, so I switched
>>> to 'cpu' here.
>>>
>>> I'll get some performance numbers.
>>>
>>>> While you mention in your cover letter "comments and reviews are 
>>>> welcome"
>>>> The change logs in your patches are not designed to assist your 
>>>> reviewer.
>>>
>>> I spent the last few weeks trying to come up with a solution based 
>>> on my
>>> original submission, but in the end I gave up as I hadn't been able to
>>> fix the original issue.
>>
>> Well, the last submission was a discombobulated set of mostly 
>> unrelated patches...
>> What was it that did not work?
>>
>>> This here is a different approach by massaging the 'wq_unbound' 
>>> mechanism, which is not only easier but also has the big advantage that
>>> it actually works :-)
>>> So I did not include a changlog to the previous patchset as this is 
>>> a pretty different approach.
>>> Sorry if this is confusing.
>>
>> It's just difficult to try and understand what each patch 
>> contributes, and most of the time the patches
>> are under-documented. I want to see the improvements added, but I 
>> also want them to be properly reviewed.
>
> Sure. So here are some performance number:
> (One subsystem, two paths, 96 queues)
> default:
> 4k seq read: bw=365MiB/s (383MB/s), 11.4MiB/s-20.5MiB/s 
> (11.0MB/s-21.5MB/s), io=16.0GiB (17.2GB), run=24950-44907msec
> 4k rand read: bw=307MiB/s (322MB/s), 9830KiB/s-13.8MiB/s 
> (10.1MB/s-14.5MB/s), io=16.0GiB (17.2GB), run=37081-53333msec
> 4k seq write: bw=550MiB/s (577MB/s), 17.2MiB/s-28.7MiB/s 
> (18.0MB/s-30.1MB/s), io=16.0GiB (17.2GB), run=17859-29786msec
> 4k rand write: bw=453MiB/s (475MB/s), 14.2MiB/s-21.3MiB/s 
> (14.8MB/s-22.3MB/s), io=16.0GiB (17.2GB), run=24066-36161msec
>
> unbound:
> 4k seq read: bw=232MiB/s (243MB/s), 6145KiB/s-9249KiB/s 
> (6293kB/s-9471kB/s), io=13.6GiB (14.6GB), run=56685-60074msec
> 4k rand read: bw=249MiB/s (261MB/s), 6335KiB/s-9713KiB/s 
> (6487kB/s-9946kB/s), io=14.6GiB (15.7GB), run=53976-60019msec
> 4k seq write: bw=358MiB/s (375MB/s), 11.2MiB/s-13.5MiB/s 
> (11.7MB/s-14.2MB/s), io=16.0GiB (17.2GB), run=37918-45779msec
> 4k rand write: bw=335MiB/s (351MB/s), 10.5MiB/s-14.7MiB/s 
> (10.0MB/s-15.4MB/s), io=16.0GiB (17.2GB), run=34929-48971msec
>
> unbound + 'cpu' affinity:
> 4k seq read: bw=249MiB/s (261MB/s), 6003KiB/s-13.6MiB/s 
> (6147kB/s-14.3MB/s), io=14.6GiB (15.7GB), run=37636-60065msec
> 4k rand read: bw=305MiB/s (320MB/s), 9773KiB/s-13.9MiB/s 
> (10.0MB/s-14.6MB/s), io=16.0GiB (17.2GB), run=36791-53644msec
> 4k seq write: bw=499MiB/s (523MB/s), 15.6MiB/s-18.0MiB/s 
> (16.3MB/s-19.9MB/s), io=16.0GiB (17.2GB), run=27018-32860msec
> 4k rand write: bw=536MiB/s (562MB/s), 16.7MiB/s-21.1MiB/s 
> (17.6MB/s-22.1MB/s), io=16.0GiB (17.2GB), run=24305-30588msec
>
> As you can see, with unbound and 'cpu' affinity we are basically on par
> with the default implementations (all tests are run with per-controller
> workqueues, mind).

I'm puzzled that the seq vs. rand vary this much when you work against a 
brd device.
Are these results stable?

> Running the same workload with 4 subsystems and 8 paths will run into
> I/O timeouts for the default implementation, but perfectly succeed with
> unbound and 'cpu' affinity.
> So definitely an improvement there.

I tend to think that the io timeouts are caused by a bug, not by "non 
optimized" code. io timeouts
are eternity for this test, which makes me think we have a different 
issue here.

