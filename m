Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D772FC3271E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jul 2024 14:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z64nphf6PXKbn/1OY15U6vVfp7b90LBW827QOgtbhks=; b=jpzPFhuE29yLFpIX4Ek/ut/WHi
	Ahv5ZsKqgkDX+MVes26cbaHCfZVmte0Oh53FUkjihtzcFmuK3Ru9QLlTnv2sm8SCTmDYmpO6RvCIr
	gsxHWi3PYSYe/IIu5mBZz5EDTDt9Xp8EKBWEWk/TfLW0XQasDknUbepy7RfAmJBLkUVnwSyQ/bOy8
	iLmVe1JWx4zCH+9ma8hpCWyf4Xyv7fHmHu7bjCmtuw78AUYV/G1EQPry2yjbpo0/DMd4U3EyrNCRq
	XSaDBQ2xhOeHhQmRDgsBmcpH+4GhO0bSnqEvd+IQwjbKGFL4HGSNSPwBio/819vfvc3I/5NDh1Ewn
	zssajCyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQpYl-000000046oI-0mTg;
	Mon, 08 Jul 2024 14:41:43 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQpYj-000000046nS-0dlq
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jul 2024 14:41:42 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4265d1b9e2aso2528165e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 08 Jul 2024 07:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720449699; x=1721054499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z64nphf6PXKbn/1OY15U6vVfp7b90LBW827QOgtbhks=;
        b=DSzaR37TpBIwyFg373fNEE4RH3b0+qSt7pY8ioZ894XJpajYRs1ezL87o09II1rCur
         8wbK+5O74DMCVwsQYraA8xlpYd9nmk+r7y/a2xzF+XJ9OCWR2LujOIZdc/pK1uxqzJdZ
         tvyoOFyRuyIfsREsEuRsgoepeE6aLMeyy5lgHyAm1cBIgzX8JxQy+/OskOUaDCY1I4eJ
         dzMQ85iFN2+A+USNw4uwoMxFZ6BFjPIDDRfYJwJJsVxm/MM1cyZy4eQmjS5ZPSQd8h7Y
         9Noh05PnOcUHEFmxksI67guDWlJNH+Sr1Knusk0PjeYZWZ/dWR3gZT6q2New4uXcRQb0
         vJ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmaNPEgDqjhY18PrBdO+hPN8p3sKFXseaUF/SWoswk3FTZ0Q8ziqDhAHuwOmRZ0QeoPoG/+WJlW7ocLRzuTgs2d+Su+E6bPgTlFvB/9Iw=
X-Gm-Message-State: AOJu0YyQ1aMUqZF+VmfukMkOGcgzNuRxWh7CsehhkQVJswxZDEm5LhqW
	ekaOeUGNw2hsF4FhDj+Vn1hWf8QPOrdiqAusLIFZixabl9u7L1T/
X-Google-Smtp-Source: AGHT+IHaTJr7aT9WdiYIDDf0+pK2Q/7wshJYsuwmZchD7qnaBXXRfJdIpIAWt27aBKtjZhIuKhMBCw==
X-Received: by 2002:a05:6000:1543:b0:35f:247e:fbce with SMTP id ffacd0b85a97d-367cdde6ec0mr40328f8f.1.1720449699196;
        Mon, 08 Jul 2024 07:41:39 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a1540508sm10551964f8f.66.2024.07.08.07.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 07:41:39 -0700 (PDT)
Message-ID: <0a5c8524-f435-4263-be8d-21dd7cfb3459@grimberg.me>
Date: Mon, 8 Jul 2024 17:41:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-tcp: per-controller I/O workqueues
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240708071013.69984-1-hare@kernel.org>
 <20240708071013.69984-4-hare@kernel.org>
 <15107646-6467-46af-8fd8-5d83225612ee@grimberg.me>
 <bfc5f071-a151-4f2a-95f7-a94b5e385dd8@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <bfc5f071-a151-4f2a-95f7-a94b5e385dd8@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_074141_211128_BB1B1520 
X-CRM114-Status: GOOD (  16.61  )
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



On 08/07/2024 15:48, Hannes Reinecke wrote:
> On 7/8/24 14:12, Sagi Grimberg wrote:
>>
>>
>> On 08/07/2024 10:10, Hannes Reinecke wrote:
>>> From: Hannes Reinecke <hare@suse.de>
>>>
>>> Implement per-controller I/O workqueues to reduce workqueue contention
>>> during I/O and improve I/O performance.
>>>
>>> Performance comparison:
>>>                 baseline rx/tx    blk-mq   multiple workqueues
>>> 4k seq write:  449MiB/s 480MiB/s 524MiB/s 540MiB/s
>>> 4k rand write: 410MiB/s 481MiB/s 524MiB/s 539MiB/s
>>> 4k seq read:   478MiB/s 481MiB/s 566MiB/s 582MiB/s
>>> 4k rand read:  547MiB/s 480MiB/s 511MiB/s 633MiB/s
>>
>> I am still puzzled by this one.
>>
>> This is for 2 controllers? or more?
>> It is intresting that the rand read sees higher boost from the seq read.
>> Is this a nature of the SSD? What happens with null_blk ?
>>
> See the patchset description.
> Two controllers, one subsystem.

Can we try with null_blk as well?
Not that I'm dismissing the nvme numbers.

>
>> CCing Tejun. Is it possible that using two different workqueues
>> for a symmetrical workload is better than a single global workqueue?
>
> Yes, that is the implication.
> It might simply due to the fact that the number of workers in a 
> workqueue pool is limited to 512:
>
> workqueue.h:      WQ_MAX_ACTIVE           = 512,    /* I like 512, 
> better ideas? */
>
> so by using a workqueue per controller we effectively raise the number
> of possible workers. And we're reducing the concurrency between 
> controllers, as each controller can now schedule I/O independent on
> the other.
>
> Let me check what would happen if I increase MAX_ACTIVE ...

Umm, do you have concurrency of more than 512 active? you have 64 queues 
in your setup no.
Maybe I'm missing something...

