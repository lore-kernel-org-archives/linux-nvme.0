Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DCDC83F01
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Aug 2023 17:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dgT0AIDPZgl26tMkDdsBHDsxRu9I3n2FZzYpBP7cGCg=; b=ou5e/ILwd98HAdgJIKrc5x1GM7
	xMbeCDxZY1rG6IKRfuWs1VetDMikjDruydL8nemyVrwKmgCOA4eHnlWulstF2PCn/ypV7qwsFbrv9
	y/BemG+tUgasmrzVTOiXIrrT1KxuClX7QY7cCfGGTNT5eJQi24q+7kUAxSdl85m3pZLclNCbLCcgi
	oGzQ7Ba4fM+HszFXQKv5k4xt+gSzhmk5QwRBdRunBS/IJYQuBP9k7BSEHRsuqyHChe707chBv7Xtv
	TK5F7uyb4njd3gf3JyoVtIo75p5rjhy6B/z6l12UCi3bCs/OdSRZHJT3pqABX7lAHwyXQdgnutCFf
	Xu26ixLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbPEm-00DvUb-0d;
	Wed, 30 Aug 2023 17:44:16 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbPEi-00DvTt-2t
	for linux-nvme@lists.infradead.org;
	Wed, 30 Aug 2023 17:44:14 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1693417444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dgT0AIDPZgl26tMkDdsBHDsxRu9I3n2FZzYpBP7cGCg=;
	b=29k7LTWIm9DMq2cvAp585AIxhEGIlsLyKObcUcw/Ftj6Gnb0JxrNeCsKWYPEhC5jBGlluy
	TTN4P7SXPLIYqknzbXC17wdPx7yEzlnl1c+zCuQ4Biy8yx0CyKnXuMqsopo1iELeI3kC/5
	FNZc8mernGKPDlvxSrlRYJ4kAqujsv/INchiysSGWixlqOR91dwiR3ffbzVfVoohifacSV
	srJWRs6jtiHQlM1wlBELCX9We22povOiX2MdiqFM2C/vPavcw9aBiE+kUaPedff10RbcHC
	oaMhY6rgB/tEn65wmX0zlxaM5ZtapDQH5B6CzKO5F9Eb7Az2RBVZI0zQ5En/bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1693417444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dgT0AIDPZgl26tMkDdsBHDsxRu9I3n2FZzYpBP7cGCg=;
	b=hTwrnzBqCSxtiJiAB7fbzhJcvQSwOfFyEkhCsz43GY12ZToHHutDY9UB0Sgv+FhnmCgS+P
	0KC25+Gvlqnpa0Bw==
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>, Keith
 Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>, Guangwu Zhang
 <guazhang@redhat.com>, Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH V3] lib/group_cpus.c: avoid to acquire cpu hotplug lock
 in group_cpus_evenly
In-Reply-To: <20230818140145.1229805-1-ming.lei@redhat.com>
References: <20230818140145.1229805-1-ming.lei@redhat.com>
Date: Wed, 30 Aug 2023 19:44:03 +0200
Message-ID: <87edjk5st8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_104413_094073_667D66AA 
X-CRM114-Status: GOOD (  10.41  )
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

Ming!

On Fri, Aug 18 2023 at 22:01, Ming Lei wrote:

> group_cpus_evenly() could be part of storage driver's error handler,
> such as nvme driver, when may happen during CPU hotplug, in which
> storage queue has to drain its pending IOs because all CPUs associated
> with the queue are offline and the queue is becoming inactive. And
> handling IO needs error handler to provide forward progress.
>
> Then dead lock is caused:
>
> 1) inside CPU hotplug handler, CPU hotplug lock is held, and blk-mq's
> handler is waiting for inflight IO
>
> 2) error handler is waiting for CPU hotplug lock
>
> 3) inflight IO can't be completed in blk-mq's CPU hotplug handler because
> error handling can't provide forward progress.
>
> Solve the deadlock by not holding CPU hotplug lock in group_cpus_evenly(),
> in which two stage spreads are taken: 1) the 1st stage is over all present
> CPUs; 2) the end stage is over all other CPUs.

That solves the deadlock, but makes the code racy against a concurrent
hot-add operation which modifies cpu_present_mask. IOW, it introduces a
data race.

The changelog does not explain why this does not matter nor does the
comment.

Thanks,

        tglx



