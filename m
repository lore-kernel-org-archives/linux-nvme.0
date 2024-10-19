Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB5BD3E194
	for <linux-nvme@archiver.kernel.org>; Sat, 19 Oct 2024 00:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sWuWGHAAelbSJMtiFqn1+UQTsoAFrJ5pUxKEak7CgJU=; b=XuB7Lay4KfFSWiw/OwKFP7+yiY
	R35JD7kBoqSXFHT8a9YjVVfUf1siDUTuF8HQGuFaVn659Xc5b6pbIImYP9rsZSuOHqOke/y0s59Ls
	aM7ffGCENupp4OCUVo+z70Xf/BKzTElzwY+CwmMdMfOKrKoHXJUfXGdKV91SBoWWwGrBh5kYOgGJU
	ARnoQCVG7n6dyubFP2NYRknXXCbigq+JRwzy9nLXDqZqQrTaPK6F0u/65QlDhSD8hSq2F9+8yOtun
	dzXxjTeGr0MlHNNj87geAR0zMwHXVT6a6n8Oo9+atklIhkbUbrhs97cGgZIroZGoZsGPRj+lknumh
	hfcsXT+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1xJE-00000002KnH-0OYg;
	Sat, 19 Oct 2024 00:27:08 +0000
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1xJB-00000002Kmb-2502
	for linux-nvme@lists.infradead.org;
	Sat, 19 Oct 2024 00:27:07 +0000
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3e5f533e1c2so1267257b6e.3
        for <linux-nvme@lists.infradead.org>; Fri, 18 Oct 2024 17:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729297624; x=1729902424; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sWuWGHAAelbSJMtiFqn1+UQTsoAFrJ5pUxKEak7CgJU=;
        b=QFCngWsl6TstPxb3A6DQA4sENYvJSNwoHCRZU5Ml/+G2ObIfrbpp/CUG9+4yg5aaIN
         fmsIJPqLNytyqw1N5er27UDPc1g3eFOJkWK8Z+G/GphP8ST85lttpXDY4SOvniA9kk7Z
         xMkCk6gZzHLB+6gP+Neeaj34ogzo0cybuvkqgGpx7r0RRaA7ZsvWmc9OylaaAjzj7FJd
         cIGqjS1Ur1yrT16/OrELZ/tqG/53j4BCGTloo/7YeOU0XC+JNnsLq0LI2Orcleh0kLXd
         3r8icOUgJghXz8vce1/VDS+6cV5UlW1fIpDA94zxIF4uy1taiVkjpcg+fWaEl0fikBcu
         h3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729297624; x=1729902424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sWuWGHAAelbSJMtiFqn1+UQTsoAFrJ5pUxKEak7CgJU=;
        b=ZKe7gNMU3mZANDPIo7A33hay/85TSbgVKwGT8fe6ASByFoNMF5R99VlWZFtdKRclXV
         16jTEZFuTHb+RihFg4+oFX2p6OTuwnI77XNjTzFZlPIUSkzwbFZednR7F+RgE7CAori5
         6bFiarAaQ5/qgHbCyr/OGUQ4adtY7g7nV/m7ZNd21xd2xBnv+0sjlfurA0X2n5tWkHVP
         RLVxAiZgkbtEJ3dMr17YdaDxq1JNx3f3yRMvVvReE8M9lqu9Blupf10zIuzQ2FtXZfgv
         1lrrpEVVzooTFSkJcxJaBJYpc7gRbBzXo2S8Wg94K7OTiS5EOMWdPL81EGWoccxymPei
         sSuA==
X-Forwarded-Encrypted: i=1; AJvYcCW8E2OkGMq27aUkLslX9U9JCW4Mlaoum5OKUXKzQ6L8ZLUGHRs+rolw1O6upcWoQqdqRHh6TMO5+Nzr@lists.infradead.org
X-Gm-Message-State: AOJu0YxeVYBw6QRW5t1kBzge4wEPevgQp7PWXIw1NGupZOcsz4oZGAJh
	hSXmYPaQhMdl9HyWDcz2cK7BEO0BS0XmJ9Q/uT87wRDcF0YgcaKN
X-Google-Smtp-Source: AGHT+IESX5Hsh4rByt9TT7qRj6nBeyiiqVeM++X9wRFAXHn7aXUasUZUsEjtFPx2JIwhR54muwYLPA==
X-Received: by 2002:a05:6808:bd5:b0:3e6:264:2988 with SMTP id 5614622812f47-3e602d8c1d2mr4171867b6e.35.1729297624025;
        Fri, 18 Oct 2024 17:27:04 -0700 (PDT)
Received: from [192.168.1.22] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e602a47df4sm621930b6e.40.2024.10.18.17.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 17:27:03 -0700 (PDT)
Message-ID: <7ec51cc8-b64f-4956-b4e6-4b67f1a8fa76@gmail.com>
Date: Fri, 18 Oct 2024 19:27:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/4] shut down devices asynchronously
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lukas Wunner <lukas@wunner.de>
Cc: Michael Kelley <mhklinux@outlook.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, David Jeffery <djeffery@redhat.com>,
 Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nathan Chancellor <nathan@kernel.org>, Jan Kiszka <jan.kiszka@seimens.com>,
 Bert Karwatzki <spasswolf@web.de>
References: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
 <BN7PR02MB41480DE777B9C224F3C2DF43D4792@BN7PR02MB4148.namprd02.prod.outlook.com>
 <SN6PR02MB41571E2DD410D09CE7494B38D4402@SN6PR02MB4157.namprd02.prod.outlook.com>
 <2024101809-granola-coat-9a1d@gregkh> <ZxInC1U7WiB7FNkJ@wunner.de>
 <2024101808-subscribe-unwrapped-ee3d@gregkh>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <2024101808-subscribe-unwrapped-ee3d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241018_172705_574227_7828C23E 
X-CRM114-Status: GOOD (  24.56  )
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

On 10/18/2024 4:37 AM, Greg Kroah-Hartman wrote:
> On Fri, Oct 18, 2024 at 11:14:51AM +0200, Lukas Wunner wrote:
>> On Fri, Oct 18, 2024 at 07:49:51AM +0200, Greg Kroah-Hartman wrote:
>>> On Fri, Oct 18, 2024 at 03:26:05AM +0000, Michael Kelley wrote:
>>>> In the process, the workqueue code spins up additional worker threads
>>>> to handle the load.  On the Hyper-V VM, 210 to 230 new kernel
>>>> threads are created during device_shutdown(), depending on the
>>>> timing. On the Pi 5, 253 are created. The max for this workqueue is
>>>> WQ_DFL_ACTIVE (256).
>> [...]
>>> I don't think we can put this type of load on all systems just to handle
>>> one specific type of "bad" hardware that takes long periods of time to
>>> shutdown, sorry.
>>
>> Parallelizing shutdown means shorter reboot times, less downtime,
>> less cost for CSPs.
> 
> For some systems, yes, but as have been seen here, it comes at the
> offset of a huge CPU load at shutdown, with sometimes longer reboot
> times.
> 
>> Modern servers (e.g. Sierra Forest with 288 cores) should handle
>> this load easily and may see significant benefits from parallelization.
> 
> "may see", can you test this?
> 
>> Perhaps a solution is to cap async shutdown based on the number of cores,
>> but always use async for certain device classes (e.g. nvme_subsys_class)?
> 
> Maybe, but as-is, we can't take the changes this way, sorry.  That is a
> regression from the situation of working hardware that many people have.
> 
> thanks,
> 
> greg k-h

Thank you both for your time and effort considering this.  It didn't 
occur to me that an extra few 10s of milliseconds (or maxing out the 
async workqueue) would be an issue.

To answer your earlier question (Michael), there shouldn't be a 
possibility of deadlock regardless of the number of devices. While the 
device shutdowns are scheduled on a workqueue rather than run in a loop, 
they are still scheduled in the same order as they are without this 
patch, any any device that is scheduled for shutdown should never have 
to wait for device that hasn't yet been scheduled. So even if only one 
device shutdown could be scheduled at a time, it should still work 
without deadlocking--it just wouldn't be able to do shutdowns in parallel.

And I believe there is still a benefit to having async shutdown enabled 
even with one core. The NVMe shutdowns that take a while involve waiting 
for drives to finish commands, so they are mostly just sleeping. 
Workqueues will schedule another worker if one worker sleeps, so even a 
single core system should be able to get a number of NVMe drives started 
on their shutdowns in parallel.

I'll see what I can to do limit the amount of stuff that gets put on the
workqueue, though.  I can likely limit it to just the asynchronous 
device shutdowns (NVMe shutdowns), plus any devices that have to wait 
for them (i.e., any devices of which they are dependents or consumers).





