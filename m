Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41F9C47077
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 01:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gb6SX3T6t7XN0s2imQMt+9x7IH416QzU3AT9JpDJn+U=; b=a4sx9i/rrbP+EmGBPPuVBklEGt
	7nzghmVMw4etrbvYpzcMgCxFwEely32DVEIHiU4dVO5wwRrGi5ieyvtsY8Gpz/AbqsVYfO3SNFUvY
	g9jzS1sX+0pSmxlYVkw2XWiV7D1ziCdHKgwc1qRe6ZBchyemPz846RYS/GYirIK/7DJklAa37qmO7
	5aBIMyYQdYF8lIo036FJscZM9X03oCXOdgzQ0q0KOpFVXtBmtAXX3bOLGdvHNwkrGMYRbEkMkyOYM
	Mi9gqLo7Lbu/CbVXgIQzyvQT0qhiXtOsOUHLCpf0VS3HVj7iwg5utlQoBWd70l6ZhhxLXMorkWUT6
	Lgx5E0dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPucu-00E9A9-1q;
	Wed, 17 Jan 2024 01:21:56 +0000
Received: from mail-pf1-f174.google.com ([209.85.210.174])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPucr-00E99l-1M
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 01:21:55 +0000
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6d9b37f4804so6849606b3a.1
        for <linux-nvme@lists.infradead.org>; Tue, 16 Jan 2024 17:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705454511; x=1706059311;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gb6SX3T6t7XN0s2imQMt+9x7IH416QzU3AT9JpDJn+U=;
        b=Y9fOiB5d0vPPBcXQd2F3YyVpNGwyTHiiiHvxJATxqa9hsQk3C49bhLLzKKk23FhkiA
         IAKNIgase/E/OM8U1SNjuGEDCrlOwp0uGzv75DMrXHVPlhFunKkFwtSdUFhapOWTmuO+
         srpZ/YubI4WZzgVY83RufHQHyb6yPzlGdac4OVmHGg6U9xVbYySBhc9Qcr0w5+nkw9TC
         IDT1LyIjut7pVjuqrscsjdoZstHKlu1ikHl8E609ALP/GTxiBaajr9Miti5F4mde9vZ8
         43KCpee5/1f19X4ynQTaoGsW+en58AQbxxVFLd+pW/j4aqVZYXHi9bOFt8W9rGtD6enB
         mr5g==
X-Gm-Message-State: AOJu0YwmAWq+5NdCwBdk63miKMC5AxaGVH3MrFTYM7ln8SfPA5NwDlZP
	nWEfaNg2mjWwxVWRz5JczL4=
X-Google-Smtp-Source: AGHT+IHQtIiqkOE1p4vpwtBpPQgd9t0yN4o2W6HSHuJlqYOLTZHKMW6+7NDdyA3Wj59PEg0m9wvwiQ==
X-Received: by 2002:a05:6a21:3399:b0:19b:42ea:314f with SMTP id yy25-20020a056a21339900b0019b42ea314fmr108129pzb.16.1705454511265;
        Tue, 16 Jan 2024 17:21:51 -0800 (PST)
Received: from ?IPV6:2601:647:4d7e:54f3:667:4981:ffa1:7be1? ([2601:647:4d7e:54f3:667:4981:ffa1:7be1])
        by smtp.gmail.com with ESMTPSA id y12-20020a62b50c000000b006dab86e675esm211486pfe.185.2024.01.16.17.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 17:21:50 -0800 (PST)
Message-ID: <a6e6859a-eabf-437a-b81f-d47c3365498f@acm.org>
Date: Tue, 16 Jan 2024 17:21:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Improving Zoned Storage Support
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <5b3e6a01-1039-4b68-8f02-386f3cc9ddd1@acm.org>
 <cc6999c2-2d53-4340-8e2b-c50cae1e5c3a@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <cc6999c2-2d53-4340-8e2b-c50cae1e5c3a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240116_172153_459638_081D9E6E 
X-CRM114-Status: GOOD (  20.61  )
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

On 1/16/24 15:34, Damien Le Moal wrote:
> On 1/17/24 03:20, Bart Van Assche wrote:
>> File system implementers have to decide whether to use Write or Zone
>> Append. While the Zone Append command tolerates reordering, with this
>> command the filesystem cannot control the order in which the data is
>> written on the medium without restricting the queue depth to one.
>> Additionally, the latency of write operations is lower compared to zone
>> append operations. From [2], a paper with performance results for one
>> ZNS SSD model: "we observe that the latency of write operations is lower
>> than that of append operations, even if the request size is the same".
> 
> What is the queue depth for this claim ?

Hmm ... I haven't found this in the paper. Maybe I overlooked something.

>> The mq-deadline I/O scheduler serializes zoned writes even if these got
>> reordered by the block layer. However, the mq-deadline I/O scheduler,
>> just like any other single-queue I/O scheduler, is a performance
>> bottleneck for SSDs that support more than 200 K IOPS. Current NVMe and
>> UFS 4.0 block devices support more than 200 K IOPS.
> 
> FYI, I am about to post 20-something patches that completely remove zone write
> locking and replace it with "zone write plugging". That is done above the IO
> scheduler and also provides zone append emulation for drives that ask for it.
> 
> With this change:
>   - Zone append emulation is moved to the block layer, as a generic
> implementation. sd and dm zone append emulation code is removed.
>   - Any scheduler can be used, including "none". mq-deadline zone block device
> special support is removed.
>   - Overall, a lot less code (the series removes more code than it adds).
>   - Reordering problems such as due to IO priority is resolved as well.
> 
> This will need a lot of testing, which we are working on. But your help with
> testing on UFS devices will be appreciated as well.

That sounds very interesting. I can help with reviewing the kernel
patches and also with testing these.

Thanks,

Bart.


