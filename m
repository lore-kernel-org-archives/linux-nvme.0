Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2A9C5321E
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Aug 2024 10:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l7V6BAddGgkfxAgYPTJasOV4P7ESflLm7+jnMT7oxdY=; b=jicRVxPYBdsggPuInmrFRyjy2w
	PXJ58EeGAyhilgz3Loy8PhE2mEKkx/2EE8l4GUqRVVHZTihEIqsXfR2Gv+XUBduhv/6OX9iwNzh6V
	Zj/7oy/N3KLA0GGACHyDGq1FWvRz6SCYdc/28JARbqvZht0LILZVKqvmzMvQ8SMYZJhnbMi67AWQx
	LZ8ip/L6WhhKR2QuEuvKH+56YMKsV6N1uoWAQ7W9wdbJ/qOKKS6uIaz+zrtWjmORbyRwZD/mHwpJq
	t2yKYai5pPcmKQIq2WH4yHVdw0qAQbhJ5/BMEi1qoQaPLSOc3QC1CrksE+3truopU7FnVgWV6RBVM
	AZaLUCMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siX9R-00000006y0c-27lH;
	Mon, 26 Aug 2024 10:40:45 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siX9P-00000006xzh-0I2H
	for linux-nvme@lists.infradead.org;
	Mon, 26 Aug 2024 10:40:44 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428ec6c190eso36338545e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 26 Aug 2024 03:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724668841; x=1725273641;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7V6BAddGgkfxAgYPTJasOV4P7ESflLm7+jnMT7oxdY=;
        b=sw3TcOLFEF1mzyejb24wasiCsNMByLXrBTFNQdr55F0yDsx+h+4E5qaeUs46k3NXjH
         aH9uOKVOxTnX7tN0mzJuP/rOFuiQv8ciu6Zn88yOn9oAvsiS0g0gPwNedkNQnSuJz6ze
         u4MJDuy+o6z8tEWooK3gGY0qcPFDp5IucrrGABRt+ZuN3XvlDjkpf6Rxd83PdbT8nYbD
         ex21y/hAFJto7JEXQehwaVgUXk6huTqweM5wefMLTW3CACVcZERgulXAqw7kCXX4tZPL
         LaYA65iZ0m8poaGdgwKG1d0S5pNEikq8OupTe1OXUbl3njnFhdbx/1uJk9QG8VQO29l5
         DeMw==
X-Forwarded-Encrypted: i=1; AJvYcCX5GRWmUtnEs/vNF4UUvA9srQKatDV+WYmSCtuB8P8Uw+8rH8SKL2m9RwDKYP7V2UI3q0EcfMXnH0DF@lists.infradead.org
X-Gm-Message-State: AOJu0Yw4vbrIyw8VMKUEs3tIFxrJIruSuFCPSi74+AtqGjMwTgM1g1NE
	LE0bt8XSUVUeKSkIMBgRjdING3DMvNs2fDcDng/PLNyJ+NZZBgXb
X-Google-Smtp-Source: AGHT+IE8D2+FuVX2t4AxfbOp7NjdWIjJygJcoVOwKAzc4i9UNB4FCzNAXYrDXwWLYM+mCEYUQ2RB/A==
X-Received: by 2002:a05:600c:4e4f:b0:426:61af:e1d3 with SMTP id 5b1f17b1804b1-42acc9fdd69mr65622145e9.31.1724668841053;
        Mon, 26 Aug 2024 03:40:41 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac517a490sm150720085e9.31.2024.08.26.03.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 03:40:40 -0700 (PDT)
Message-ID: <bc8a07ee-bf04-477f-a38d-b8e5ffed2fc3@grimberg.me>
Date: Mon, 26 Aug 2024 13:40:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-rdma: send cntlid in the RDMA_CM_REQUEST Private
 Data
To: Niklas Cassel <cassel@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: kamaljit.singh1@wdc.com, dlemoal@kernel.org,
 linux-nvme@lists.infradead.org
References: <20240815201131.1439811-2-cassel@kernel.org>
 <ZsxKfZCxfNfSXzGI@ryzen.lan>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZsxKfZCxfNfSXzGI@ryzen.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_034043_146773_BF054625 
X-CRM114-Status: GOOD (  16.90  )
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




On 26/08/2024 12:27, Niklas Cassel wrote:
> On Thu, Aug 15, 2024 at 10:11:31PM +0200, Niklas Cassel wrote:
>> When sending a RDMA_CM_REQUEST, the NVMe RDMA Transport Specification
>> allows you to populate the cntlid field in the RDMA_CM_REQUEST Private
>> Data.
>>
>> The cntlid is returned by the target on completion of the first
>> RDMA_CM_REQUEST command (which creates the admin queue).
>>
>> The cntlid field can then be populated by the host when the I/O queues
>> are created (using additional RDMA_CM_REQUEST commands), such that the
>> target can perform extra validation for additional RDMA_CM_REQUEST
>> commands.
>>
>> This additional error code and error message is also added, such that
>> nvme_rdma_cm_msg() will display the proper error message if the target
>> fails the RDMA_CM_REQUEST command because of this extra validation.
>>
>> Signed-off-by: Niklas Cassel <cassel@kernel.org>
>> ---
>>   drivers/nvme/host/rdma.c  | 2 ++
>>   include/linux/nvme-rdma.h | 6 +++++-
>>   2 files changed, 7 insertions(+), 1 deletion(-)
> Hello NVMe maintainers,
>
> is there any chance of getting this picked up?

Keith will probably pick it up for 6.12...

