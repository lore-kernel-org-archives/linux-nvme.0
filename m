Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71AEC47258
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 20:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7/Uu3y14KMTzvtlTvNxfEaBtVLCjSK7ZE6fv/xcZI+A=; b=MSeeBeeR3iLycEJk5Z3mzvZyz1
	PBHuv82mFgmbm4FSsrwgj6yPwW301nnF53Ve0eucRHEUMXkeyib+kIgut/PVQdV8c3McwEtOjS2cA
	29V4PFCEiMm6kzCmzf5oL8zxFCHJ9bOmrDDztQU7cXJLJnii0VCmslEq1oki7UxuhEZPy8AXRpcRb
	MfqK4vkqdH7TkvJv5jceoM8XESua9u3HuuC45E58MGGaOMPWXC2wDyFVC3iWaE2f1JgKDPzgd2on+
	78wcvcxfO8Ez5k/mAVpNsZK9MFE2TdCnXWbw1jv2cfX00WUN7oXq38ziq81OtpSoeTGcHYY+L2aKO
	woVWFhKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQCMW-000dXu-2v;
	Wed, 17 Jan 2024 20:18:12 +0000
Received: from mail-pj1-f41.google.com ([209.85.216.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQCMU-000dV3-0v
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 20:18:11 +0000
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28d0052beb0so7044000a91.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jan 2024 12:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705522684; x=1706127484;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/Uu3y14KMTzvtlTvNxfEaBtVLCjSK7ZE6fv/xcZI+A=;
        b=dYzkcmRjewW4N3eKq+AeTH+wfWf9EvPqNQGid7NNjQWf3c7mHOYd26TggvFkU9Lw4h
         SH7MLwvPgJ9Ajswe3q+WHYuVRQBHKHghuwUU04Jr7c9vo22ivszgmjIEGvbbZ1LHrpGA
         nFN1P4lmu/71P+Lajb8nTy09Dbn4X6D0nmGqmxqtKhORQ+SSslCe+2CXGmm1gBGzcAJt
         kkbB2GxZRHNjSl+jL9WhXV0yx0OQ/UX1qpw/XzkPIpX0npXo5hn2AmZn4xeYjQljETW9
         Qh5JWsL0U//O0/B3qtodz/R8m4Rwj0MnOuJL0xT+BYk5yRlj4V7yOuxocz8NyA0PQXgB
         CtHg==
X-Gm-Message-State: AOJu0YyIGAQkk/zPgCGeSb1IuWLJ8iaDE/I3KClw0U1jhwfQdev5jtLx
	f6XN616k8/+EuVTcjGE/6vI=
X-Google-Smtp-Source: AGHT+IEBz6MpQH028iW4X2ZIVqDX48bTejSFEsIGLJt70ISnKU/drkjZjIUzkCKIDiA43ofqp3+BgQ==
X-Received: by 2002:a17:90a:4bc5:b0:28e:71a1:82d2 with SMTP id u5-20020a17090a4bc500b0028e71a182d2mr2197109pjl.63.1705522683567;
        Wed, 17 Jan 2024 12:18:03 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:718b:ab80:1dc2:cbee? ([2620:0:1000:8411:718b:ab80:1dc2:cbee])
        by smtp.gmail.com with ESMTPSA id i14-20020a17090332ce00b001d6f04f2b5dsm59533plr.30.2024.01.17.12.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 12:18:03 -0800 (PST)
Message-ID: <39dfcd32-e5fc-45b9-a0ed-082b879a16a4@acm.org>
Date: Wed, 17 Jan 2024 12:18:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Improving Zoned Storage Support
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <5b3e6a01-1039-4b68-8f02-386f3cc9ddd1@acm.org>
 <cc6999c2-2d53-4340-8e2b-c50cae1e5c3a@kernel.org>
 <43cc2e4c-1dce-40ab-b4dc-1aadbeb65371@acm.org>
 <c38ab7b2-63aa-4a0c-9fa6-96be304d8df1@kernel.dk>
 <2955b44a-68c0-4d95-8ff1-da38ef99810f@acm.org>
 <9af03351-a04a-4e61-a6d8-b58236b041a3@kernel.dk>
 <276eedc2-e3d0-40c7-b355-46232ea65662@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <276eedc2-e3d0-40c7-b355-46232ea65662@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_121810_323651_BB07D761 
X-CRM114-Status: GOOD (  12.59  )
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

On 1/17/24 12:06, Jens Axboe wrote:
> Case in point, I spent 10 min hacking up some smarts on the insertion
> and dispatch side, and then we get:
> 
> IOPS=2.54M, BW=1240MiB/s, IOS/call=32/32
> 
> or about a 63% improvement when running the _exact same thing_. Looking
> at profiles:
> 
> -   13.71%  io_uring  [kernel.kallsyms]  [k] queued_spin_lock_slowpath
> 
> reducing the > 70% of locking contention down to ~14%. No change in data
> structures, just an ugly hack that:
> 
> - Serializes dispatch, no point having someone hammer on dd->lock for
>    dispatch when already running
> - Serialize insertions, punt to one of N buckets if insertion is already
>    busy. Current insertion will notice someone else did that, and will
>    prune the buckets and re-run insertion.
> 
> And while I seriously doubt that my quick hack is 100% fool proof, it
> works as a proof of concept. If we can get that kind of reduction with
> minimal effort, well...

If nobody else beats me to it then I will look into using separate
locks in the mq-deadline scheduler for insertion and dispatch.

Bart.



