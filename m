Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145FBC4167B
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Dec 2023 02:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZAI0NuHLd7A7hcfMNmxQThYQE6RIisLpIwIrNRbX2Ig=; b=Ru0MKIL6rirRgy9ph9hKDjqXjE
	f3AqTgMTxN1a4wTDckf8L69qXPvtYo7gL5/DykpmwoN6hY0vMUkQ9RMSzS3UGZ/Th+AnJHW6a40c+
	Br7pK5owxEkHYXRu7pvOYy7WBrEZxQxnI9ZHd76Kdf4WjC/6vh0oWLVgvGyzrt81Q9syppUR693nO
	75COfL8/9OlnaE65UDjgPevktKph6yMN6F24tCR10JNFR8vRc1gnUxbV8LCphc9R/iLxPsRqWI/JN
	hFfhWaehR6vaZUYn9jyzdq6UhQzSQOXuyH7FBoUnjjYPa9gh/kGs4zKmn7e45xLnO4QjhkCUJvJD1
	4g7rrqAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBn4P-00Gxth-07;
	Sat, 09 Dec 2023 02:27:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBn4M-00Gxso-0X
	for linux-nvme@lists.infradead.org;
	Sat, 09 Dec 2023 02:27:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702088868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZAI0NuHLd7A7hcfMNmxQThYQE6RIisLpIwIrNRbX2Ig=;
	b=dcROS5EL9NIOldX0Ji7PEoD6+w0rLlvOGTXyfwprM8bMGhAqNIviJq/AU2Fy95R7BPhZiU
	JmwiaRKmdG3HyNr5N+d9tUXkKYpW59XyCRKLGdjcfbK7/KYWt65FiqnlcoJndGzDHmWRLk
	+LodwA/OuQ9e2atMd7CtK4Txw9XO9Jo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-uIlvz8xnOAONWZ2y1JLgnw-1; Fri, 08 Dec 2023 21:27:43 -0500
X-MC-Unique: uIlvz8xnOAONWZ2y1JLgnw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1757F805844;
	Sat,  9 Dec 2023 02:27:43 +0000 (UTC)
Received: from fedora (unknown [10.72.120.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 773B4492BC6;
	Sat,  9 Dec 2023 02:27:37 +0000 (UTC)
Date: Sat, 9 Dec 2023 10:27:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
	Guangwu Zhang <guazhang@redhat.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH V4 resend] lib/group_cpus.c: avoid to acquire cpu hotplug
 lock in group_cpus_evenly
Message-ID: <ZXPQlIREBiX46trU@fedora>
References: <20231120083559.285174-1-ming.lei@redhat.com>
 <20231120120059.ef0614c2295b2102100cb56e@linux-foundation.org>
 <20231206151246.99bbf0f253b85f053bea9199@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206151246.99bbf0f253b85f053bea9199@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231208_182754_302688_8CEB12C9 
X-CRM114-Status: GOOD (  27.46  )
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

On Wed, Dec 06, 2023 at 03:12:46PM -0800, Andrew Morton wrote:
> On Mon, 20 Nov 2023 12:00:59 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Mon, 20 Nov 2023 16:35:59 +0800 Ming Lei <ming.lei@redhat.com> wrote:
> > 
> > > group_cpus_evenly() could be part of storage driver's error handler,
> > > such as nvme driver, when may happen during CPU hotplug, in which
> > > storage queue has to drain its pending IOs because all CPUs associated
> > > with the queue are offline and the queue is becoming inactive. And
> > > handling IO needs error handler to provide forward progress.
> > > 
> > > Then dead lock is caused:
> > > 
> > > 1) inside CPU hotplug handler, CPU hotplug lock is held, and blk-mq's
> > > handler is waiting for inflight IO
> > > 
> > > 2) error handler is waiting for CPU hotplug lock
> > > 
> > > 3) inflight IO can't be completed in blk-mq's CPU hotplug handler because
> > > error handling can't provide forward progress.
> > > 
> > > Solve the deadlock by not holding CPU hotplug lock in group_cpus_evenly(),
> > > in which two stage spreads are taken: 1) the 1st stage is over all present
> > > CPUs; 2) the end stage is over all other CPUs.
> > > 
> > > Turns out the two stage spread just needs consistent 'cpu_present_mask', and
> > > remove the CPU hotplug lock by storing it into one local cache. This way
> > > doesn't change correctness, because all CPUs are still covered.
> > 
> > I'm not sure what is the intended merge path for this, but I can do lib/.
> > 
> > Do you think that a -stable backport is needed?  It sounds that way.
> > 
> > If so, are we able to identify a suitable Fixes: target?  That would
> > predate f7b3ea8cf72f3 ("genirq/affinity: Move group_cpus_evenly() into
> > lib/").  
> 
> No?  I think this predates 428e211641ed8 ("genirq/affinity: Replace
> deprecated CPU-hotplug functions." also.
> 
> I'll slap a cc:stable on it and I'll let you and the -stable
> maintainers figure it out.

The issue should be introduced since 3ee0ce2a54df ("genirq/affinity: Use get/put_online_cpus
around cpumask operations") in v4.8, but the logic has been changed a lot, so
may take some effort to backport to longterm stables.

The issue is reported from RH QA test, in which both cpu hotplug and
nvme error recovering are triggered at same time, and easy to duplicate
in QE lab, but may be hard to trigger in production environment.

Thanks, 
Ming


