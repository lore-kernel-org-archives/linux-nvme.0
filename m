Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3414D2C56A
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 15:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wvlo2uETQ2snXpBq1iCPCkeSnP5byMcjRDdafhy0y68=; b=ZxBLNL3wFlVc66sz1njaro7PiK
	OBTt4sqfhKEcYmKzSvXL1p93JNWxbZEt74RxFAvftWsX7Xc3BJ0uhcnHwbSq9ayAZFrhz9yR7xNQ3
	Xc+dqdxFCQO8R3gnP/0B1ZC1TI1BwvMTmOWOf8svX4TsK7VMa+yHuHX2ghlVPuGG0Y6nReU+5JsSK
	bJzXR87Sjke5vgUD0eSUn9ZIXRmn1MySCkKhvTWuD4qckJgxthX0bIVlHvscTUn5JnlGV3CCGEO84
	tB5KJqWP/Je750gldk25KMwIHl5+w1zUX394gG7QMmrUg/74nkVpPS85nzHsT8Tu30Xa2JHunwCgb
	iao3D2Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Gvm-0000000BGmT-1BZz;
	Tue, 22 Oct 2024 15:36:22 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Guj-0000000BGg0-1w85
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 15:35:18 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so49582365e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 22 Oct 2024 08:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729611315; x=1730216115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wvlo2uETQ2snXpBq1iCPCkeSnP5byMcjRDdafhy0y68=;
        b=W0SysyCVXcNflxbVpsK4VAK103dKODG70Spyg0iWtH2Bp714zX2wwOZnTADKD+5E3Y
         7L0+ypfi8MO8br0v0BPbhQurD1b8dHiCcSYBBDVzxXSA6/PGH0H6P8jx7RHNR6gAX1aM
         7zyh5V+CRNMuvLW/R2aA4M122Lq18bgRk1aSQDeuQMEQ2stix+KnkH5JxxCfI9gifQbk
         MrxvwnAW29edw+Q2jLuyswyQh1xyaHqIZ2hT9S4xYcXn52cGKAaDTb/Ryq0Q8a1VLSmJ
         aohqdeNUixDEcXN0KI4wTujlSlB/YXzw8Wjvo25SNhnThERdIUG35MUrw6/GubX0DT2o
         PEFg==
X-Forwarded-Encrypted: i=1; AJvYcCVEENuMC9Tt80Yl23TqjzMaHt1n+hXr7dyb4wEYuHhsTFDRRKoG1S+UmggXQw6V6fYjSi7SZJ+WmLg1@lists.infradead.org
X-Gm-Message-State: AOJu0Yw5pXRiA9E8zuulQ1TcySvbw7ZZe9gI7E0cCdU/qn5tE/w6K5ZV
	OtqdUv3lGffKLlsOCBzRE81EEWMNWPIbA2oWYSyKhGjhlYMYiz0O
X-Google-Smtp-Source: AGHT+IFM15e8t9aQmJ040Sdj79eaCYPFM1kKKnWe5i4vZVqn/VWSAzCFkq1f17YommJ53VnHhrXKbQ==
X-Received: by 2002:a05:600c:3b98:b0:42c:bd27:4c12 with SMTP id 5b1f17b1804b1-4317ca9b56emr24273035e9.10.1729611315014;
        Tue, 22 Oct 2024 08:35:15 -0700 (PDT)
Received: from [10.100.102.74] ([89.138.78.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f57fc36sm91845765e9.18.2024.10.22.08.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 08:35:14 -0700 (PDT)
Message-ID: <6b00d25e-fe6a-4552-9945-d6181af83137@grimberg.me>
Date: Tue, 22 Oct 2024 18:35:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-sysfs: display max_hw_sectors_kb without requiring
 namespaces
To: Keith Busch <kbusch@kernel.org>, Abhishek Bapat <abhishekbapat@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Prashant Malani <pmalani@google.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241016213108.549000-1-abhishekbapat@google.com>
 <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com>
 <CAL41Mv4_UjsD1ycpNU1xuQJdGWMf2L-SQYs=LupoM9BKurNXCg@mail.gmail.com>
 <Zxe8e2zS5dA61Jou@kbusch-mbp>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Zxe8e2zS5dA61Jou@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_083517_524789_5C93198E 
X-CRM114-Status: GOOD (  20.27  )
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




On 22/10/2024 17:53, Keith Busch wrote:
> On Thu, Oct 17, 2024 at 02:32:18PM -0700, Abhishek Bapat wrote:
>> On Thu, Oct 17, 2024 at 9:40 AM Keith Busch <kbusch@kernel.org> wrote:
>>> On Wed, Oct 16, 2024 at 09:31:08PM +0000, Abhishek Bapat wrote:
>>>> max_hw_sectors based on DMA optimized limitation") introduced a
>>>> limitation on the value of max_hw_sectors_kb, restricting it to 128KiB
>>>> (MDTS = 5). This restricion was implemented to mitigate lockups
>>>> encountered in high-core count AMD servers.
>>> There are other limits that can constrain transfer sizes below the
>>> device's MDTS. For example, the driver can only preallocate so much
>>> space for DMA and SGL descriptors, so 8MB is the current max transfer
>>> sizes the driver can support, and a device's MDTS can be much bigger
>>> than that.
>>>
>>> Anyway, yeah, I guess having a controller generic way to export this
>>> sounds like a good idea, but I wonder if the nvme driver is the right
>>> place to do it. The request_queue has all the limits you need to know
>>> about, but these are only exported if a gendisk is attached to it.
>>> Maybe we can create a queue subdirectory to the char dev too.
>> Are you suggesting that all the files from the queue subdirectory should
>> be included in the char dev (/sys/class/nvme/nvmeX/queue/)? Or that
>> just the max_hw_sectors_kb value should be shared within the queue
>> subdirectory? And if not the nvme driver, where else can this be done
>> from?
> You'd may want to know max_sectors_kb, dma_alignment, nr_requests,
> virt_boundary_mask. Maybe some others.
>
> The request_queue is owned by the block layer, so that seems like an
> okay place to export it, but attached to some other device's sysfs
> directory instead of a gendisk.
>
> I'm just suggesting this because it doesn't sound like this is an nvme
> specific problem.

Won't it be confusing to find queue/ directory in controller nvmeX sysfs 
entry?



