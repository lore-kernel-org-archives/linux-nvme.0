Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880E4C2BBCA
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jun 2024 07:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iSI7fj3SMbgXLwqwSqXjXKJNJqsQgRCaFKgsC6I5fZU=; b=4Z7/jETe9hjRaGdQgAp+MmKCTZ
	SIa8i1+5uVZceIGpO3+lsNExOYtstFqTSPzsF1VtzDoukvcyRnCxmSXuG51j2mq7gGgDvPmfpMt8Y
	1KE8c0wSNgNFFWaoIuFyXhbRuiKkeaiZut0vsUPcMi6nXKVnFZmBABIpc50JbnP9j4GbroBeHGNHS
	rZ3kpHoAat+t6Gw2YsEIFF5uXKl3M3py5nqOgf6XhShbMftqWJ1LT10PmJrcE8/JlOeZGk2weI21H
	mhqfdrdjuFXwyh9RQKoTUXWlFRe5+C3TqWq0qiNnMSrLkcgCazDll08XrH8wchrJP/4QEA+2+W9Kr
	xDbAFlNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM0HJ-00000001tXF-0GwB;
	Tue, 25 Jun 2024 07:07:45 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM0H9-00000001tRc-0RRv
	for linux-nvme@lists.infradead.org;
	Tue, 25 Jun 2024 07:07:42 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719299250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iSI7fj3SMbgXLwqwSqXjXKJNJqsQgRCaFKgsC6I5fZU=;
	b=ipv+GCo/a3XKt1bVhJ8qHmQ5iX9Y3xQeAwTl/NVuKmfo3NwwWPQ4ZG+8oJfO6PUR/YrrRV
	qzcPbG2cqMmLO3jzlf3kxT3KrpJ/HSBr8DwOgIHJ0Zgo770WTAClKqwUE8pJyIpRtpqsn8
	+C/RtY6LHcyXj61YjXH+LSSOOy5L0Jf6l7lVR71qp5J06nzqXRsc7BifCtuuC2chCMIfHK
	ccTgrQBT55cPvqX827TetCpeLSAFybY18O4YDXVtuwUBajpQN7AR3PWlzYPZV8FLPAIswh
	6z/3dQxrXIDT1lvoBnoMiLHntKaIo4Gg4iHl5Ud9S94WGbOl3GhdeumZ5Ssxaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719299250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iSI7fj3SMbgXLwqwSqXjXKJNJqsQgRCaFKgsC6I5fZU=;
	b=T+H7/aRCp62Ttz3TJuYUoPdXWA9RMxgNdzwdKonscOY2UYnMchLq93iXOKqY8hFfo3KAYU
	fYuHJypFsZD1HqDw==
To: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, Frederic Weisbecker <fweisbecker@suse.com>,
 Mel Gorman <mgorman@suse.de>, Sridhar Balaraman
 <sbalaraman@parallelwireless.com>, "brookxu.cn" <brookxu.cn@gmail.com>,
 Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] sched/isolation: Add io_queue housekeeping option
In-Reply-To: <55315fc9-4439-43b0-a4d2-89ab4ea598f0@suse.de>
References: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de>
 <20240621-isolcpus-io-queues-v1-1-8b169bf41083@suse.de>
 <20240622051156.GA11303@lst.de>
 <x2mjbnluozxykdtqns47f37ssdkziovkdzchon5zkcadgkuuif@qloym5wjwomm>
 <20240624084705.GA20292@lst.de>
 <sjna556zvxyyj6as5pk6bbgmdwoiybl4gubqnlrxyfdvhbnlma@ewka5cxxowr7>
 <55315fc9-4439-43b0-a4d2-89ab4ea598f0@suse.de>
Date: Tue, 25 Jun 2024 09:07:30 +0200
Message-ID: <878qyt7b65.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240625_000735_825945_BDD4E5D3 
X-CRM114-Status: GOOD (  18.08  )
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

On Tue, Jun 25 2024 at 08:37, Hannes Reinecke wrote:
> On 6/24/24 11:00, Daniel Wagner wrote:
>> On Mon, Jun 24, 2024 at 10:47:05AM GMT, Christoph Hellwig wrote:
>>>> Do you think we should introduce a new type or just use the existing
>>>> managed_irq for this?
>>>
>>> No idea really.  What was the reason for adding a new one?
>> 
>> I've added the new type so that the current behavior of spreading the
>> queues over to the isolated CPUs is still possible. I don't know if this
>> a valid use case or not. I just didn't wanted to kill this feature it
>> without having discussed it before.
>> 
>> But if we agree this doesn't really makes sense with isolcpus, then I
>> think we should use the managed_irq one as nvme-pci is using the managed
>> IRQ API.
>> 
> I'm in favour in expanding/modifying the managed irq case.
> For managed irqs the driver will be running on the housekeeping CPUs 
> only, and has no way of even installing irq handlers for the isolcpus.

Yes, that's preferred, but please double check with the people who
introduced that in the first place.

Thanks,

        tglx

