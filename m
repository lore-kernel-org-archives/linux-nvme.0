Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A5FC3A5AA
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 17:07:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F5A721726
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 17:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZhsYFmD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5A721726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Fi/6ndUrpPCfuaFobNM8f+ZKbkB/6t9KTE4laOr/Kqg=; b=ZhsYFmD+P6byLewccQiERySWW
	GmqP5LVwJKION95GMTjFkdMi0PUA4KbzFBWvrKFwUHBnM7USPMz4M8sntI4HBSGCPcDGNkA2A2QOh
	Y7/L6mLhi/1xwgtPFegM9MjFG5OPkYCL2DboFZx7CqvZvm5g5PDKdew5vrR4VLR0FQBt43Ui+5vCJ
	xauQNahIJMRk+M4CTwDuxfAnwu+MQjBvdVH3MeYzpj4Dv9G5Y4PmHv1GIGWrcXSrknEWCoXXg3jpa
	a7cT4u8Hi7Epjz10N5Yb3qaFR/5gna7sHsrZ9fBbo726akYQmlI1sV/K/SHLHpvPUjA0WTLQsEfDj
	1X847P5yQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5Yl7-0007jD-P0; Wed, 04 Sep 2019 17:07:53 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5Yl5-0007i9-Ft
 for linux-nvme@lists.infradead.org; Wed, 04 Sep 2019 17:07:52 +0000
Received: by mail-pf1-f195.google.com with SMTP id y72so6052688pfb.12
 for <linux-nvme@lists.infradead.org>; Wed, 04 Sep 2019 10:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=doRviDRcuI8ukbxh960Ewx7U5Vu3KSMcpLgAPd33oB4=;
 b=Krx9xRpVMsCRz4DRP67RW37O4Ux4uE656ACwCPATzcl2QTl2j2bfNXfouJYZDGmliz
 kGNzcg+bG9MbThGb8oUSBwWQEG8hV8ddkc1nedeZeBPprVrfdbDnk/OZghOVFD1ms95v
 nPifysWYEiq0Go3KEjIA1tt/3r5/5rj5Bq9iCf8joglv4GAGnx06gHST1hpwuMW5LL+V
 kmPKJaqCkN6yWnVK9JDofkE5CFkP3g4tzdQlbWWGygtJRPJJTfK1gKlx0/Xe7BpA/nW9
 2zsqdfWmb51aAl+UyJdJuGxsMlHo9xiPcLyhu0KlCNmUqm0yR8xps+lW8SqUCeu7XNoq
 dSzQ==
X-Gm-Message-State: APjAAAXQvexxXPBC5Yo1z5rjarHj0HSG/Bz3UEXl23LPkF9uCdj2NKNa
 aGHKBTQvrast/18Z+SReqpM=
X-Google-Smtp-Source: APXvYqxTGX0yWsgvrQzLKsJf9CtThotqfcBWqegNulPltQ1d0FC1QU27SwfyIzRS1iCIIODIqAnaUA==
X-Received: by 2002:aa7:8a83:: with SMTP id a3mr47156125pfc.115.1567616870289; 
 Wed, 04 Sep 2019 10:07:50 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com
 ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
 by smtp.gmail.com with ESMTPSA id 2sm23516255pfa.43.2019.09.04.10.07.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Sep 2019 10:07:49 -0700 (PDT)
Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Ming Lei <ming.lei@redhat.com>
References: <20190827225827.GA5263@ming.t460p>
 <alpine.DEB.2.21.1908280104330.1939@nanos.tec.linutronix.de>
 <20190828110633.GC15524@ming.t460p>
 <alpine.DEB.2.21.1908281316230.1869@nanos.tec.linutronix.de>
 <20190828135054.GA23861@ming.t460p>
 <alpine.DEB.2.21.1908281605190.23149@nanos.tec.linutronix.de>
 <20190903033001.GB23861@ming.t460p>
 <299fb6b5-d414-2e71-1dd2-9d6e34ee1c79@linaro.org>
 <20190903063125.GA21022@ming.t460p>
 <6b88719c-782a-4a63-db9f-bf62734a7874@linaro.org>
 <20190903072848.GA22170@ming.t460p>
 <dd96def4-1121-afbe-2431-9e516a06850c@linaro.org>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <6f3b6557-1767-8c80-f786-1ea667179b39@acm.org>
Date: Wed, 4 Sep 2019 10:07:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dd96def4-1121-afbe-2431-9e516a06850c@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190904_100751_526065_48D2C09C 
X-CRM114-Status: GOOD (  15.44  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-scsi@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Long Li <longli@microsoft.com>,
 John Garry <john.garry@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/3/19 12:50 AM, Daniel Lezcano wrote:
> On 03/09/2019 09:28, Ming Lei wrote:
>> On Tue, Sep 03, 2019 at 08:40:35AM +0200, Daniel Lezcano wrote:
>>> It is a scheduler problem then ?
>>
>> Scheduler can do nothing if the CPU is taken completely by handling
>> interrupt & softirq, so seems not a scheduler problem, IMO.
> 
> Why? If there is a irq pressure on one CPU reducing its capacity, the
> scheduler will balance the tasks on another CPU, no?

Only if CONFIG_IRQ_TIME_ACCOUNTING has been enabled. However, I don't 
know any Linux distro that enables that option. That's probably because 
that option introduces two rdtsc() calls in each interrupt. Given the 
overhead introduced by this option, I don't think this is the solution 
Ming is looking for.

See also irqtime_account_irq() in kernel/sched/cputime.c.

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
