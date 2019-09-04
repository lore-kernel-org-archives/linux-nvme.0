Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D714EC3A5A9
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 19:47:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD02521726
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 19:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GxHq7DUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD02521726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JyuL1P1o2Qm+4GjzZHA7ohYsQSq5NzcSbcmlTDQmpcA=; b=GxHq7DUzDZj6Rrm1Ge52vXweZ
	HB1uIQx/ro3G9I3NCOt3ooZ+D6GeII+qPsy2pE2/jRUFuBqihLDpLbDc1k1QWsMVFlK7kTc1M1cgy
	rUxC1Z990vSL1BUjouPp62fJlG2Bslow0khG7VA0KJFtULXnZRtwQL9TBZdjnKtsw/qJOe4kU0OGg
	JUc1G24Z4W6yucAaVxiGOdcIvvZj+BZaCGv79+NStRA+LkCGMPkK4ggOajNhvURddU5wrRkG8GALn
	xUInEMhgevhZlZK/GR0VToKQOXZPzA9yXVGQvvOvX3ckl9/0DRhQu/+oYBwkiOs2c+wxkksEjyTKr
	nitGI0B+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5bFP-0006VV-LU; Wed, 04 Sep 2019 19:47:19 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5bFM-0006V6-Om
 for linux-nvme@lists.infradead.org; Wed, 04 Sep 2019 19:47:18 +0000
Received: by mail-pf1-f195.google.com with SMTP id q21so8927200pfn.11
 for <linux-nvme@lists.infradead.org>; Wed, 04 Sep 2019 12:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eVl+9tAIHMvBrQx3eBUEyjTBamIfURj9LIAwDSTkbB0=;
 b=GQgzj+ACTnSXc2sUDq58evbdePgdaLOjagdKcZXheg8b0ZdYzlV5LFgfzInpk1DMxs
 wJziVXg0MdqORxSLIvBHkTzy0DO6s4cOlBUU+zwC17j0pnZ2CNQ7OQYSB7CNCVmsQ9hL
 /gM3H3jFEo5ty7rYER85AoE60zd7t7RkHcAJznc0e55NcdnTl7Hl4v1JLgs2u14m5QhB
 G5ZlSDAgJIUeaMFIH/K1sb05XHMS5twnnWoY2skboqe0lShkmYYre+DWg6m/lKh97cg2
 suIK08pIKDUvzQ4uNGQOZa6dTwhOJfe6hbT+ljfWdjBnPP5GxiZ70G2R+lmiXMguyEDq
 JO/w==
X-Gm-Message-State: APjAAAUlSS0N5J1F+/9pIPSkLqB+02V8Htb4N7n1dAkRD78UtQUaLN45
 pOjvguKHbA80Acrt/hm7AuU=
X-Google-Smtp-Source: APXvYqx+3PI2yKaiUlmIJkEhbY9ZelMh9dTSVitv6do41wzJeS7xqPQb6h7FvJuVpl5L7IOgn6YEcw==
X-Received: by 2002:a63:31c1:: with SMTP id
 x184mr37650267pgx.128.1567626435911; 
 Wed, 04 Sep 2019 12:47:15 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com
 ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
 by smtp.gmail.com with ESMTPSA id m19sm41874829pff.108.2019.09.04.12.47.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Sep 2019 12:47:15 -0700 (PDT)
Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
To: Peter Zijlstra <peterz@infradead.org>
References: <alpine.DEB.2.21.1908281605190.23149@nanos.tec.linutronix.de>
 <20190903033001.GB23861@ming.t460p>
 <299fb6b5-d414-2e71-1dd2-9d6e34ee1c79@linaro.org>
 <20190903063125.GA21022@ming.t460p>
 <6b88719c-782a-4a63-db9f-bf62734a7874@linaro.org>
 <20190903072848.GA22170@ming.t460p>
 <dd96def4-1121-afbe-2431-9e516a06850c@linaro.org>
 <6f3b6557-1767-8c80-f786-1ea667179b39@acm.org>
 <2a8bd278-5384-d82f-c09b-4fce236d2d95@linaro.org>
 <de16de12-fa1a-666c-ea19-fea5d096c1ca@acm.org>
 <20190904180211.GX2332@hirez.programming.kicks-ass.net>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <9b924e48-e217-9c11-c1fb-46c92a82ea2d@acm.org>
Date: Wed, 4 Sep 2019 12:47:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904180211.GX2332@hirez.programming.kicks-ass.net>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190904_124716_804715_E249BF9A 
X-CRM114-Status: GOOD (  14.22  )
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
Cc: Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>,
 John Garry <john.garry@huawei.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-scsi@vger.kernel.org, Long Li <longli@microsoft.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
 Ming Lei <ming.lei@redhat.com>, Keith Busch <keith.busch@intel.com>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/4/19 11:02 AM, Peter Zijlstra wrote:
> On Wed, Sep 04, 2019 at 10:38:59AM -0700, Bart Van Assche wrote:
>> I think it is widely known that rdtsc is a relatively slow x86 instruction.
>> So I expect that using that instruction will cause a measurable overhead if
>> it is called frequently enough. I'm not aware of any publicly available
>> measurement data however.
> 
> https://www.agner.org/optimize/instruction_tables.pdf
> 
> RDTSC, Ryzen: ~36
> RDTSC, Skylake: ~20
> 
> Sadly those same tables don't list the cost of actual exceptions or even
> IRET :/

Thanks Peter for having looked up these numbers. These numbers are much 
better than last time I checked. Ming, would CONFIG_IRQ_TIME_ACCOUNTING 
help your workload?

Does anyone know which CPUs the following text from 
Documentation/admin-guide/kernel-parameters.txt refers to?

tsc=		[ ... ]
		[x86] noirqtime: Do not use TSC to do irq accounting.
		Used to run time disable IRQ_TIME_ACCOUNTING on any
		platforms where RDTSC is slow and this accounting
		can add overhead.

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
