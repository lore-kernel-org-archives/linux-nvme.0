Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC60DC83F2B
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Aug 2023 08:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k8MlZdnaiAdZ4cakYlJruX/gxcGJziK5klvRHpw3VpE=; b=J65SKBHdQuWy5a67pBH3h86mTQ
	OX5DLHFFIxIn31vVvmZBlw5njQ7Bb+6DxBZGhQYg76NssjmrOSt/5T/bczjIi3kz3PmTuLZQYt5av
	Q7c5cHBW4xiK9hv4m48BNS31kska1deH7JM0hqsrSSxS1Rk+s8LOgFpauTH+iOkx5MYtpETNn2rFV
	VSN9UpYkAAi/KrVQx/2XSMA56EstAWSpHK3jNE+zi/23YD9aem22rfdCkRZW7t1I4QVfMaw2b7kpQ
	MdM49PFe7cMhxtcVHrB5mk3CGksALzW6Vuj+1nWNBTUHXGmz5BgPzeU504ac4LcLgk+WqNO5Ad4sm
	dl3fn5xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbcq2-00Es1h-24;
	Thu, 31 Aug 2023 08:15:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbcpz-00Es0x-2U
	for linux-nvme@lists.infradead.org;
	Thu, 31 Aug 2023 08:15:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693469733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k8MlZdnaiAdZ4cakYlJruX/gxcGJziK5klvRHpw3VpE=;
	b=QT4te4Ftv9uChLxqbZkdYqUfg8gbyuL6O3+hvBPHqj01Z7rNhG+3GhSJ7cPdYTUYtUvpXI
	EA5nMb+5GYWUyyHAqrIDzsxdCoGSl3FoJRQF8Nvh/jYRkfoPXNzF7KCr5/refK6YZBUzTn
	GAcetHfrf7JYTPxj3ld5eL47GuBIWqc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-PR_aoCsnN9qO8bp-awPALg-1; Thu, 31 Aug 2023 04:15:26 -0400
X-MC-Unique: PR_aoCsnN9qO8bp-awPALg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9F3B8022E4;
	Thu, 31 Aug 2023 08:15:25 +0000 (UTC)
Received: from fedora (unknown [10.72.120.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EEC792026D35;
	Thu, 31 Aug 2023 08:15:19 +0000 (UTC)
Date: Thu, 31 Aug 2023 16:15:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
	Guangwu Zhang <guazhang@redhat.com>,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH V3] lib/group_cpus.c: avoid to acquire cpu hotplug lock
 in group_cpus_evenly
Message-ID: <ZPBLy41y0NQTJ6Bw@fedora>
References: <20230818140145.1229805-1-ming.lei@redhat.com>
 <87edjk5st8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edjk5st8.ffs@tglx>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230831_011535_901406_879C8FC9 
X-CRM114-Status: GOOD (  22.52  )
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

Hello Thomas,

On Wed, Aug 30, 2023 at 07:44:03PM +0200, Thomas Gleixner wrote:
> Ming!
> 
> On Fri, Aug 18 2023 at 22:01, Ming Lei wrote:
> 
> > group_cpus_evenly() could be part of storage driver's error handler,
> > such as nvme driver, when may happen during CPU hotplug, in which
> > storage queue has to drain its pending IOs because all CPUs associated
> > with the queue are offline and the queue is becoming inactive. And
> > handling IO needs error handler to provide forward progress.
> >
> > Then dead lock is caused:
> >
> > 1) inside CPU hotplug handler, CPU hotplug lock is held, and blk-mq's
> > handler is waiting for inflight IO
> >
> > 2) error handler is waiting for CPU hotplug lock
> >
> > 3) inflight IO can't be completed in blk-mq's CPU hotplug handler because
> > error handling can't provide forward progress.
> >
> > Solve the deadlock by not holding CPU hotplug lock in group_cpus_evenly(),
> > in which two stage spreads are taken: 1) the 1st stage is over all present
> > CPUs; 2) the end stage is over all other CPUs.
> 
> That solves the deadlock, but makes the code racy against a concurrent
> hot-add operation which modifies cpu_present_mask. IOW, it introduces a
> data race.

Good catch, we can annotate it with data_race(), and I think here the
readonly access to cpu_present_mask is fine, and we have many such usage,
such as for_each_present_cpu().

> 
> The changelog does not explain why this does not matter nor does the
> comment.

OK, I will document the change, such as:

There isn't difference compared with holding cpu hotplug lock, because the cpu
hp state is always changed even though cpu_present_mask isn't updated
with the lock. And all CPUs are always covered during the spread, the difference
is just that it is done in 1st stage or 2nd stage.

If you don't object, I will post next version with above change.


Thanks,
Ming


