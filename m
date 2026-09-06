Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E85BC79F85
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Sep 2026 00:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d2ywF7i1YLuE7fmN8t9ogckMODufUZ4fcNyHQizBkKI=; b=yzejaSIlTu3s5r6gwoUl/TQn81
	gUjTMi1Ctc1tamyetwCySIf+47midTAx/y/zxEZlM4gOhv6pNxGbLt2mzdQUpmSRVvZB9dTl9mRGx
	7iImZ1/OQhVp4VI0U6Xkd64BE9Y1Ufe5guIEj2VP4Oc04yEtAtVPxyYfQR/7eRwPjzUfrPxC3g8fi
	PxqbC0sWb+VYzeYa7ZwfTuelgUeV3nqN6nWfcq5Vz+NIzi7bNd8/CrUJhu0iukV5POLduHmUUa7aR
	4x0JpcgmXyEOWjQf/6zhnyYNPTozQN3Hl9oKetD3/3IDXkx+59OlHE2KcEcEW0dPJU9LHCcUbSeSC
	SFgy8wQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x30NN-00000004Uyr-0IsV;
	Sun, 06 Sep 2026 00:04:49 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x30NK-00000004UyU-11CJ
	for linux-nvme@lists.infradead.org;
	Sun, 06 Sep 2026 00:04:47 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-499ae1c6471so20950165e9.3
        for <linux-nvme@lists.infradead.org>; Sat, 05 Sep 2026 17:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788653084; x=1789257884;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d2ywF7i1YLuE7fmN8t9ogckMODufUZ4fcNyHQizBkKI=;
        b=TuPHxZt6Yqpjj68Veo7McbjYBJAWHQvCWqcADIXFwFyTZufXSir6bm2twyQH6/VMJA
         xMHnrsR29SbmoaTtDf/XsUGHb1D/cAHvJGQt34FxFlkiTovtZjrypktjziejQovmglo6
         TUZsNLyrXawiWji+yubb0csDw3oyU8CZCGxMNIA/K2fLSCdny9XsCvsZs2kHsOQWBn65
         X00uORj+g/fLHIF+EIk35JYRLlxXhCNiQVl7j9PzYvWy11Ter4DkM89qD2xa14jrIX7C
         B9H8ofANyVGsxQ4ctF9Mz1kqjAcm96WPlPl0/ARrvcSMYNgHx/3aWB6xakxvWFEIoOPo
         L4Jw==
X-Forwarded-Encrypted: i=1; AKwUvByGrP5cEqBQotQZAQlh4KkScAOduLfhgJc90RbuFMMyvpViVB/kbGDTpYhP3p//x8kEsdHJZQoXl4+q@lists.infradead.org
X-Gm-Message-State: AFuF++nhMJsvUVi/c2ENIjRVg9VKjRolcwLM2ANWu3XQre4mBBmzJryP
	1+gHDizNfnIshl94iFTXRNUaiXhW/bYhBHlM1YWSk6g/kRKLg4JjuZ1H
X-Gm-Gg: AYBFou0StkQrCoTRVm+FDhEawfWPDvme5c+vINN4vfZ8IQ6MXx7MCLJwKFlnHX5ucZF
	LaueTkv7Lh6qtfbpWO6J4LJ3ZyKCE9YXvfKf9m1DHhARPVQXxNSWAFu/HQ+vnGAKu4O9Zx5QaYf
	YFZCFhC8sv5nlMLjI6zBGGUVeVfqD7Huk//ZLSScj9epjoEAvj1ljAaay98gtKqu1mUjv48l9MT
	OxWOdPHSlM5SOItSTKyuolEE7+Ew4JPZhTY2GK8Kijoa/gLMPf6DIlQqQf1JzdjqoakKKkg/Arc
	ctQeWgl3mehKTZio3mEjEeO8VTqPs2cNgNdr1Bv4KacKN56mqDu8gdtLzlHatlIOPjxUCFwv7PN
	Hdi8SkkcihCOt04JVAgCHh76oZJuy2lnzkiLVwT6XV3JfKYj2ntZo4qRV0wjaa1Np6wPnk1/XuQ
	IOmJMcucttelUT6zE86kMKgF0Olobg2WApDtehr5hMcF2DV+ELmi9bTaJAsx/b/gdmPHhQspG5p
	sfMAGF4XzQ7XBruSj75gw==
X-Received: by 2002:a05:600c:4e51:b0:49c:ff8d:b548 with SMTP id 5b1f17b1804b1-49cff8db5demr204426225e9.11.1788653083849;
        Sat, 05 Sep 2026 17:04:43 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7740d44sm414491095e9.15.2026.09.05.17.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 17:04:43 -0700 (PDT)
Message-ID: <e940ccd7-3e7c-4118-a66c-1c17c33d2417@grimberg.me>
Date: Sun, 6 Sep 2026 03:04:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH RFC] nvme-tcp: allow multiple queues per hctx
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
References: <20260903152623.614951-1-kbusch@meta.com>
Content-Language: en-US
In-Reply-To: <20260903152623.614951-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260905_170446_309294_B86F3AC1 
X-CRM114-Status: GOOD (  22.33  )
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



On 03/09/2026 18:26, Keith Busch wrote:
> From: Keith Busch<kbusch@kernel.org>
>
> We've observed many workloads may burst large amounts of IO from a one
> thread, which has the nvme tcp driver queue all the work onto a single
> socket and serialized by a single CPU. We can hit a CPU bottleneck
> before saturating the link when this happens.
>
> Provide an option to ask for more queues for each blk-mq hctx. The
> option is provided in the nvme-fabrics connection string by appending
> "queues_per_hctx=N", where N is the number of queues you want to share
> each hctx. The nvme tcp driver will group those queues under that hctx
> and perform a simple round-robin to dispatch the requests and subsequent
> work. The workqueue provided for this is always unbounded, and we
> provide the CPU hint from the original dispatching CPU in order to
> maintain locality for the completion side.
>
> The default is the pre-existing 1 queue per hctx, so this patch should
> be a no-op if you don't explicitly opt into this feature.
>
> Testing with a very capable NIC, a high bandwith workload of QD16 1MB
> reads improved from 7GB/s on the default settings to 24GB/s with 4
> queues per hctx.
>
> For a more IOPs intensive workload, a QD64 4k random read test improved
> from 184k to 252k.
>
> This also gets a tighter grouping on application observed latency,
> significantly bringing in the P99 outliers.
>
> On the down side, there is a minor regression on low depth workloads.

Hmm... While this is a very meaningful boost, we are adding a new IO 
scheduling
logic really deep down at the driver...

Most (though not all) the nvme-tcp implementations that I am aware of, 
usually
avoid this problem by creating a round-robin/queue-depth multipath to 
multiple
controllers (which are actually separate controllers)...

I'm wandering if you guys can do the same --duplicate-connect and setting
mpath with round-robin/queue-depth would get you the same result? Perhaps
we can add this flag to nvme discover/connect-all for simplicity?

BTW, how many cpus/queues do you have in your test keith?

Moreover, I suspect that this is not a problem that is specific for 
nvme-tcp...
I'm not sure creating more 4x queues is the right tool for solving this
single-threaded workload issue. I would expect that the overall number
of connections remain, and nr_hw_queues reducing by a factor of 
queue_per_hctx.

I am wandering if there is any desire to have the block layer adding 
something like hctx
groups which would share a tag space but have multiple hctxs?

