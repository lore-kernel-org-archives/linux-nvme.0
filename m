Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226D5C3A5A8
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 17:39:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA62321670
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 17:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j4HFVLGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA62321670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oko5e3PHLs0SEF8Wye7yPsBW71pY+ogt5HX/lrlLkGs=; b=j4HFVLGCs43oGQMYAtfJc4V34
	QMk9pFRB17U61Ry0f5Ekp/wN8qWMXKZNbiwlz/Iaz5/IfnFGNzlVA0stND18JYsRexHbWTbJbECk/
	nF32nSy1GPLtXuV5T1OKQPq54u1MuS6xtROW9EMIr2iP1pId//gVXDI3ne0MjCP/t2vF2y1rXH2QH
	NrIAM1yqsuQ8owRUv3VpZ/L5Ib+uvEBsOSlbHCFm905GNqmPXOTJXUQbqWnPb8jgN8ppvDyR3+Tkv
	t0Zw3MAG4/DzgOef5zshd35TghC4+tD4XDQzW6ESXRxw043D4+mZMf9xKQeOIieIVEoQWbbpXAdjD
	CjjRGrHZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5ZFJ-000324-7g; Wed, 04 Sep 2019 17:39:05 +0000
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5ZFG-00031j-Sy
 for linux-nvme@lists.infradead.org; Wed, 04 Sep 2019 17:39:04 +0000
Received: by mail-pf1-f193.google.com with SMTP id b13so7053279pfo.8
 for <linux-nvme@lists.infradead.org>; Wed, 04 Sep 2019 10:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KnvfsSXVbwlDdjXbwbCBJbJBscMecP2Y83R9nu77QrY=;
 b=WNt9B2kkr3IbWaeSnkewpUcMIFCtydJHYoeMIHmXsiblkxE5K+FAyz/3FLYwSLv/IN
 tD3S9l0ToqIC7gqlbK8sxjvt2VvYasplEKXkTrFJ0xpEtOn08ZaaPcn1KmRDroXu3xVF
 /Gk6HO1y6hMNuNBftpD0RidgbsS61WHDOHSeObo2DJLIri/miGCZz3QHWiKvi/8OS/Iq
 7YsCEPHhzublEr2aVz6cbvLeuuvvcsak39eZnr9BVlPGZdDB3imOqY/tRQ3gGbW+aPgt
 HoOzTDk9MXtDxCVyRNjWebYHNAGdovg1nQvjvgEgr1T5Y0fZCHVdcnaiWic7ClImuYG/
 ynQA==
X-Gm-Message-State: APjAAAW1b+QdogX+bxrEaRvCuBFNR79+AvWcvsQ/uPlCfhlXmT8ml+q9
 WKjGjy9jNxt1YkVBA8k+QVI=
X-Google-Smtp-Source: APXvYqzrk/gkg2yGQWmQ4/JeJVdU8iF4leHlHSGlyvREresBS+YkyH/0INQtThrw0f/ygpLmb9mz8g==
X-Received: by 2002:a63:ff65:: with SMTP id s37mr35380567pgk.102.1567618741236; 
 Wed, 04 Sep 2019 10:39:01 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com
 ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
 by smtp.gmail.com with ESMTPSA id v15sm23521222pfn.69.2019.09.04.10.38.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Sep 2019 10:39:00 -0700 (PDT)
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
 <6f3b6557-1767-8c80-f786-1ea667179b39@acm.org>
 <2a8bd278-5384-d82f-c09b-4fce236d2d95@linaro.org>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <de16de12-fa1a-666c-ea19-fea5d096c1ca@acm.org>
Date: Wed, 4 Sep 2019 10:38:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2a8bd278-5384-d82f-c09b-4fce236d2d95@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190904_103902_937711_50B98E49 
X-CRM114-Status: GOOD (  13.42  )
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
 Sagi Grimberg <sagi@grimberg.me>, linux-scsi@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Long Li <longli@microsoft.com>,
 John Garry <john.garry@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/4/19 10:31 AM, Daniel Lezcano wrote:
> On 04/09/2019 19:07, Bart Van Assche wrote:
>> Only if CONFIG_IRQ_TIME_ACCOUNTING has been enabled. However, I don't
>> know any Linux distro that enables that option. That's probably because
>> that option introduces two rdtsc() calls in each interrupt. Given the
>> overhead introduced by this option, I don't think this is the solution
>> Ming is looking for.
> 
> Was this overhead reported somewhere ?
  I think it is widely known that rdtsc is a relatively slow x86 
instruction. So I expect that using that instruction will cause a 
measurable overhead if it is called frequently enough. I'm not aware of 
any publicly available measurement data however.

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
