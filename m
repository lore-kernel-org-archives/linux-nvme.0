Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9F1C2BB3F
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 20:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aIv8yb+/tKWqV05d2RvY4diJdtjepSEmXYNuaS4bJl4=; b=uG0/K1vd05r2gZsbaWo5+wwPeF
	Qyl6OI7qQGv+n9E49qXnFQtHxSY/tTKSdbEmFD9ZEybBgcUobiuXDheTlqF5+osQgFK/0lONB9h8m
	PaWIaj9q2uXsI4vMdk+rm/57XpkKwZ+3QS2s7OeC376STwo0XheHPY+MvAatDEWELnd7+mTLCeHwD
	qIQwuDOuGlt7+KTYsBMNYeXIPuKfMKl4E46Vfmjdgh2nvueEhGL3cCed+t/9qSwL8+QA0kG6C/9/q
	h1dRF++RAeGjyrq/L1PbfIf4N+dKj6AIfRF7e5bGsun/R0yAdSN27dhDq4g4ehptPTJhOAImLWIGB
	ua0u3syQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5ASL-00EkdO-2b;
	Mon, 20 Nov 2023 20:01:17 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5ASB-00EkZQ-1d
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 20:01:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 66A80CE1050;
	Mon, 20 Nov 2023 20:01:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5989AC433C8;
	Mon, 20 Nov 2023 20:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1700510461;
	bh=biW/bVGnRij9I2dtfarXJBwQG+bK+6YfrHHXjNnRcqk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tBqvHymbJhTUUeKJhYJ1zIxZgWcGaOQ3jNVvGf5SBCrH2TEz16QpYtyZ2qiwDEG8t
	 9eXkoqI92DPoAUCAnimFT+g/P3R2oH/KfI8gvXcAYbwe6ipA8r1ZYllhlmEyl1x6aF
	 ecfZ4iSYbwr2eS9Tb4Kbt1ltQF+m3fCR9yFVN/Cs=
Date: Mon, 20 Nov 2023 12:00:59 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>, Guangwu Zhang
 <guazhang@redhat.com>, Chengming Zhou <zhouchengming@bytedance.com>, Jens
 Axboe <axboe@kernel.dk>
Subject: Re: [PATCH V4 resend] lib/group_cpus.c: avoid to acquire cpu
 hotplug lock in group_cpus_evenly
Message-Id: <20231120120059.ef0614c2295b2102100cb56e@linux-foundation.org>
In-Reply-To: <20231120083559.285174-1-ming.lei@redhat.com>
References: <20231120083559.285174-1-ming.lei@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_120107_733999_E29FF462 
X-CRM114-Status: GOOD (  16.54  )
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

On Mon, 20 Nov 2023 16:35:59 +0800 Ming Lei <ming.lei@redhat.com> wrote:

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
> 
> Turns out the two stage spread just needs consistent 'cpu_present_mask', and
> remove the CPU hotplug lock by storing it into one local cache. This way
> doesn't change correctness, because all CPUs are still covered.

I'm not sure what is the intended merge path for this, but I can do lib/.

Do you think that a -stable backport is needed?  It sounds that way.

If so, are we able to identify a suitable Fixes: target?  That would
predate f7b3ea8cf72f3 ("genirq/affinity: Move group_cpus_evenly() into
lib/").  



