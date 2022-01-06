Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323B7C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jan 2022 13:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VD+8/yhLW150WYZcVJ/T6/rWWKqvYBJi2PVbyjDXdaA=; b=YS3JrDmGILWzxqTlGT0wApBWLe
	ZWuVqxNhgM6lbB7jqA5pN93/Mg5MuMx6iNHpDHd7GnJhoVnAH8YTztlQAZYAdqvlNTyOEJOruyGyn
	qq/sBGvPaR98bOfcC2N83RDjyC0gR+rGCuY+SwMKRGQFr0e4bD1YRxkQWhdE+ijxOmpN4sW2FHm1K
	Sr+/v5gpz7aLVmGu+PJ79sAJ9m6vJH0wWplfX1Js03E9N0JiZH8LjhGm8roo3ItQsRSJ+6sDXC94M
	ZwBpACsheA76sf9rvOyY6Me+OsrIoAN+FPKdr1EVufpfmTUdrnbLrLmyD7Q5b7uMwt3KhQGrpN3pR
	6ukQam7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n5T13-000DMq-QD; Thu, 06 Jan 2022 13:41:17 +0000
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n5T0z-000DLJ-Vs
 for linux-nvme@lists.infradead.org; Thu, 06 Jan 2022 13:41:15 +0000
Received: by mail-il1-x131.google.com with SMTP id b1so2104893ilj.2
 for <linux-nvme@lists.infradead.org>; Thu, 06 Jan 2022 05:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VD+8/yhLW150WYZcVJ/T6/rWWKqvYBJi2PVbyjDXdaA=;
 b=z1pm/w27Hg8vjqqb0thh/jsLrL/sb1AyUEJ8iwP5+JWs9vxr6nhBijA/QsWk3rQFeU
 SkHT+LN9Dw0g7IQgB5UICpS0a74LSEcgprAlwNM9vSwJGsMebCWz+gXzpK0wvhWV98By
 HIZpXNYjnPwAe1fLb1N9bVv3iYGGjp38rQymcOFueusdGtpdo8r2gcJkrBxCb0eYS0OS
 njdNW5nv3Mogp3W2M5fAFk38AxozmHt7yQA0K+rXRYLTPbIKwRyS4RORElI98TN0n65q
 IuJ2BDCaQ/qV/zg1uKuppVJvSfJ3UyMU5WX+UQpEr9MSD+imJTebm87zMJG8qxXLtkqU
 nqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VD+8/yhLW150WYZcVJ/T6/rWWKqvYBJi2PVbyjDXdaA=;
 b=gPXT8WeQsBButNty2AhJklUQ3LCNMhEdY8z8pa9zr4kV9PwBFA27ONRdL+KuCPZvAx
 wrKnNOh4rM2slmdORlFUbmLxl+vzV4m2rmoHoFsLeJYGzy8CyBjP8Y22j0xxGNZ4//np
 qryGz2SamXVV6vv7ayuOngDHLqEwzzOM+Bcmb1EGLl1twitpdVwYUIO30FzLmtACgRP5
 deZU0gSdiLN7n4YKv3CZ+a9VlzNvApm0mQ3+WJ4/rhJXOV2oN9e+AWqpNG6bP+2jdKJF
 W3wVdaC05TMtZsCyb0sMLbrWkWK+ZYt0rJqnwK109Ol92BaOajWRbJnKIAnDgvuonRgT
 b2nw==
X-Gm-Message-State: AOAM5320zA0N/1P5N6e7D7piC1CDYK8LezvwtATp2IuW+tV+1Zru8g3r
 23TzLJwCFvBRH2gN38uoOqw0Aw==
X-Google-Smtp-Source: ABdhPJxqKqaVzjsFIPxqzSJppMN1yLhYZfWoI1qJ6AwCp9fPip86kGZUavjtwEXw3yiQrqKDYYGM+w==
X-Received: by 2002:a05:6e02:194b:: with SMTP id
 x11mr3937302ilu.208.1641476470907; 
 Thu, 06 Jan 2022 05:41:10 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id g3sm1111380ilq.1.2022.01.06.05.41.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jan 2022 05:41:10 -0800 (PST)
Subject: Re: [PATCHv2 1/3] block: introduce rq_list_for_each_safe macro
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, sagi@grimberg.me
References: <20211227164138.2488066-1-kbusch@kernel.org>
 <20211229173902.GA28058@lst.de>
 <20211229205738.GA2493133@dhcp-10-100-145-180.wdc.com>
 <99b389d6-b18b-7c3b-decb-66c4563dd37b@nvidia.com>
 <20211230153018.GD2493133@dhcp-10-100-145-180.wdc.com>
 <2ed68ef8-5393-80ae-1caa-c00d108aec8c@nvidia.com>
 <20220103181552.GA2498980@dhcp-10-100-145-180.wdc.com>
 <ac74ac4c-15f3-997e-ecd2-5e704a5b4573@nvidia.com>
 <20220105172625.GA3181467@dhcp-10-100-145-180.wdc.com>
 <02a943c0-2919-a4d4-6044-7a6349b9aaf5@nvidia.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <42380959-7a72-1df1-9b6a-dede8cdaebe9@kernel.dk>
Date: Thu, 6 Jan 2022 06:41:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <02a943c0-2919-a4d4-6044-7a6349b9aaf5@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220106_054114_071028_0189D3AA 
X-CRM114-Status: GOOD (  26.62  )
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

On 1/6/22 3:54 AM, Max Gurtovoy wrote:
> 
> On 1/5/2022 7:26 PM, Keith Busch wrote:
>> On Tue, Jan 04, 2022 at 02:15:58PM +0200, Max Gurtovoy wrote:
>>> This patch worked for me with 2 namespaces for NVMe PCI.
>>>
>>> I'll check it later on with my RDMA queue_rqs patches as well. There we have
>>> also a tagset sharing with the connect_q (and not only with multiple
>>> namespaces).
>>>
>>> But the connect_q is using a reserved tags only (for the connect commands).
>>>
>>> I saw some strange things that I couldn't understand:
>>>
>>> 1. running randread fio with libaio ioengine didn't call nvme_queue_rqs -
>>> expected
>>>
>>> *2. running randwrite fio with libaio ioengine did call nvme_queue_rqs - Not
>>> expected !!*
>>>
>>> *3. running randread fio with io_uring ioengine (and --iodepth_batch=32)
>>> didn't call nvme_queue_rqs - Not expected !!*
>>>
>>> 4. running randwrite fio with io_uring ioengine (and --iodepth_batch=32) did
>>> call nvme_queue_rqs - expected
>>>
>>> 5. *running randread fio with io_uring ioengine (and --iodepth_batch=32
>>> --runtime=30) didn't finish after 30 seconds and stuck for 300 seconds (fio
>>> jobs required "kill -9 fio" to remove refcounts from nvme_core)   - Not
>>> expected !!*
>>>
>>> *debug pring: fio: job 'task_nvme0n1' (state=5) hasn't exited in 300
>>> seconds, it appears to be stuck. Doing forceful exit of this job.
>>> *
>>>
>>> *6. ***running randwrite fio with io_uring ioengine (and  --iodepth_batch=32
>>> --runtime=30) didn't finish after 30 seconds and stuck for 300 seconds (fio
>>> jobs required "kill -9 fio" to remove refcounts from nvme_core)   - Not
>>> expected !!**
>>>
>>> ***debug pring: fio: job 'task_nvme0n1' (state=5) hasn't exited in 300
>>> seconds, it appears to be stuck. Doing forceful exit of this job.***
>>>
>>>
>>> any idea what could cause these unexpected scenarios ? at least unexpected
>>> for me :)
>> Not sure about all the scenarios. I believe it should call queue_rqs
>> anytime we finish a plugged list of requests as long as the requests
>> come from the same request_queue, and it's not being flushed from
>> io_schedule().
> 
> I also see we have batch > 1 only in the start of the fio operation. 
> After X IO operations batch size == 1 till the end of the fio.

There are two settings for completion batch, you're likely not setting
them? That in turn will prevent the submit side from submitting more
than 1, as that's all that's left.

>> The stuck fio job might be a lost request, which is what this series
>> should address. It would be unusual to see such an error happen in
>> normal operation, though. I had to synthesize errors to verify the bug
>> and fix.
> 
> But there is no timeout error and prints in the dmesg.
> 
> If there was a timeout prints I would expect the issue might be in the
> local NVMe device, but there isn't.
> 
> Also this phenomena doesn't happen with NVMf/RDMA code I developed
> locally.

There would only be a timeout if it wasn't lost. Keith's patches fixed a
case where it was simply dropped from the list. As it was never started,
it won't get timed out.

-- 
Jens Axboe


