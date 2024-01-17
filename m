Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D97C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 18:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d4/T24RnyFB/ADa9apgCOMR0Hlg54AQd0st7W68AxiE=; b=JSt1YvJ8oOIDpPFcjPY0arLZhV
	dsN52uOsYxtBZnX4kyAE5r3wUstYscL77dupoIB3fx3f+SImCk0KTPByXgyMa/gqMdOMFewf/9ukO
	BMg5qJ6Um+0sTqj4xpcDKUSf7uAZU8Ic5AedclMFSrwTK0PoAtGdQp2vAc5tYvDvG8nqOpGx0DWLH
	4X6SZC29j88nmF4BSdVe7Xhkso1mVrHunxVjQd/b6pnUyKMnSDBCjOOxbWLxAFzyfq00JdGfg69DQ
	Jk/fEvDupsjnhb48B78W0jl1vP07NJbBSto8sp/kDvwOHpZxemO+sZ2G/ektkOUsxHZIk9K0s64gW
	a5O4ZVFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQAYN-000LmV-1W;
	Wed, 17 Jan 2024 18:22:19 +0000
Received: from mail-pf1-f169.google.com ([209.85.210.169])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQAYL-000LlE-0m
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 18:22:18 +0000
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d98ce84e18so9948009b3a.3
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jan 2024 10:22:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705515730; x=1706120530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d4/T24RnyFB/ADa9apgCOMR0Hlg54AQd0st7W68AxiE=;
        b=j1qaXscRzPsdgk4iDJqWeWhO8CJBRo9b9EJDOJ+eQ5dD6YnEDFnCqv6zAd+8rUcGgv
         k0vRcAGgJd7fctRi2q+n3jMFOIZKm1FzUnapUtNJFmpVhQpJEvVJzgFqjaEqf67lSOYb
         RhgjPlZcPwajA+AWqhPDdTPQNA1lHx11SwMUmc3AMLSvsUiTxBkuCMTIZvdD8S0d4gru
         eOWvNcvn38pwLHwlBcZlFZFQ4Q3+hvThW3Ew9NgkHk0/IWJZ5VHWQ8piK8XX0hYinqWC
         xYTW/fpuf+ij8gU42FyXNArmYtwexr7JWVGhl2m6Xe2lzuui54qCxbNWxSzExXqPEK5z
         AY7Q==
X-Gm-Message-State: AOJu0YxnYRDIpbPDqWNIPSNXW3fZn/5J1cF9cH23r+S8echkJawn9JG2
	uWVoAAsG3g9ggRygUU4iETjnMvay9Js=
X-Google-Smtp-Source: AGHT+IFYbqyZvwDBQ8Mkv8SlzrFfh46Y79vWdOi7CaVoyBYiuWFAXxheUzXz7hIxq7nhlrH+i8/L/Q==
X-Received: by 2002:a05:6a00:1d01:b0:6d9:e7d0:327f with SMTP id a1-20020a056a001d0100b006d9e7d0327fmr11472379pfx.23.1705515730356;
        Wed, 17 Jan 2024 10:22:10 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:5421:8f53:45a:4e37? ([2620:0:1000:8411:5421:8f53:45a:4e37])
        by smtp.gmail.com with ESMTPSA id kr8-20020a056a004b4800b006da73b90fe4sm1805094pfb.14.2024.01.17.10.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 10:22:09 -0800 (PST)
Message-ID: <2955b44a-68c0-4d95-8ff1-da38ef99810f@acm.org>
Date: Wed, 17 Jan 2024 10:22:08 -0800
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
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c38ab7b2-63aa-4a0c-9fa6-96be304d8df1@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_102217_285965_EB993975 
X-CRM114-Status: GOOD (  13.38  )
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

On 1/17/24 09:48, Jens Axboe wrote:
>> When posting this patch series, please include performance results
>> (IOPS) for a zoned null_blk device instance. mq-deadline doesn't support
>> more than 200 K IOPS, which is less than what UFS devices support. I
>> hope that this performance bottleneck will be solved with the new
>> approach.
> 
> Not really zone related, but I was very aware of the single lock
> limitations when I ported deadline to blk-mq. Was always hoping that
> someone would actually take the time to make it more efficient, but so
> far that hasn't happened. Or maybe it'll be a case of "just do it
> yourself, Jens" at some point...

Hi Jens,

I think it is something fundamental rather than something that can be
fixed. The I/O scheduling algorithms in mq-deadline and BFQ require
knowledge of all pending I/O requests. This implies that data structures
must be maintained that are shared across all CPU cores. Making these
thread-safe implies having synchronization mechanisms that are used
across all CPU cores. I think this is where the (about) 200 K IOPS
bottleneck comes from.

Additionally, the faster storage devices become, the larger the relative
overhead of an I/O scheduler is (assuming that I/O schedulers won't
become significantly faster).

A fundamental limitation of I/O schedulers is that multiple commands
must be submitted simultaneously to the storage device to achieve good
performance. However, if the queue depth is larger than one then the
device has some control over the order in which commands are executed.

Because of all the above reasons I'm recommending my colleagues to move
I/O prioritization into the storage device and to evolve towards a
future for solid storage devices without I/O schedulers. I/O schedulers
probably will remain important for rotating magnetic media.

Thank you,

Bart.


