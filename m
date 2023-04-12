Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1F9C7619A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Apr 2023 13:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N4hGK+twx2J0sna8Dlsk/TzzUeTzC124CUsz24QOgC8=; b=BXxp1dg1guddxaySj7XxfzeWI2
	B0u/s9vqlhrPreoWTR/iuKVc9af5TU/OKvA2ZKni1YPaeq8Fd4LkiT/M27Tps6CAFk7ATAwAWzYtw
	+lA8aHJ2+C4aAeyAj2JFpngns99ggPMPqBSE991SthcnQs6baFg2uwTOJwUvfih/w7SH7TjZF8IDm
	PXzGM7vkMdaeQ8TaHkS1YiiuozKF8Z5Y5xTqtwooay7AqkixpJQBv1TNRG1+GPzzstWcukMCz/NeE
	my7YbbIKhm94+bC21UTFkwS4AAW87Q1lhegxxS3/qf2nUTjDKUcrT9sL3oCjVj9XN8y5c6Hs5Ti+y
	EuJVdm9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmapP-003ONI-0k;
	Wed, 12 Apr 2023 13:48:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmapN-003OMk-0M
	for linux-nvme@lists.infradead.org;
	Wed, 12 Apr 2023 13:48:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681307280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N4hGK+twx2J0sna8Dlsk/TzzUeTzC124CUsz24QOgC8=;
	b=e6NKTsWgLj3UJT4lcrdaNDv3bI4e98VC2ouIGun91Zw8KFEp9mFJgwzqnG+J5lbecFhPtW
	0OOPvabAUx6h6vo+PqTQZuxPd0g/TjjyDkNCdtJntf7rEkhzO7at3iNKlaxNn/1HYh6p9h
	CbLMcD5wDW6zVTwxdEonCyAw5O2C62A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-jdPnAKeROzWMiaJSZ40rKg-1; Wed, 12 Apr 2023 09:47:54 -0400
X-MC-Unique: jdPnAKeROzWMiaJSZ40rKg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15E688996E0;
	Wed, 12 Apr 2023 13:47:54 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id ADEDC2027043;
	Wed, 12 Apr 2023 13:47:46 +0000 (UTC)
Date: Wed, 12 Apr 2023 21:47:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Kanchan Joshi <joshiiitr@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	hch@lst.de, kbusch@kernel.org, ming.lei@redhat.com
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF Topic] Non-block IO
Message-ID: <ZDa2fUENbykgvyk8@ovpn-8-18.pek2.redhat.com>
References: <CGME20230210180226epcas5p1bd2e1150de067f8af61de2bbf571594d@epcas5p1.samsung.com>
 <20230210180033.321377-1-joshi.k@samsung.com>
 <39a543d7-658c-0309-7a68-f07ffe850d0e@kernel.dk>
 <CA+1E3rLLu2ZzBHp30gwXBWzkCvOA4KD7PS70mLuGE8tYFpNEmA@mail.gmail.com>
 <ZDYYhE1h1qvCvVmt@ovpn-8-26.pek2.redhat.com>
 <20230412132615.GA5049@green5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412132615.GA5049@green5>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230412_064801_219000_E1D26F46 
X-CRM114-Status: GOOD (  33.05  )
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

On Wed, Apr 12, 2023 at 06:56:15PM +0530, Kanchan Joshi wrote:
> On Wed, Apr 12, 2023 at 10:33:40AM +0800, Ming Lei wrote:
> > On Wed, Apr 12, 2023 at 04:18:16AM +0530, Kanchan Joshi wrote:
> > > > > 4. Direct NVMe queues - will there be interest in having io_uring
> > > > > managed NVMe queues?  Sort of a new ring, for which I/O is destaged from
> > > > > io_uring SQE to NVMe SQE without having to go through intermediate
> > > > > constructs (i.e., bio/request). Hopefully,that can further amp up the
> > > > > efficiency of IO.
> > > >
> > > > This is interesting, and I've pondered something like that before too. I
> > > > think it's worth investigating and hacking up a prototype. I recently
> > > > had one user of IOPOLL assume that setting up a ring with IOPOLL would
> > > > automatically create a polled queue on the driver side and that is what
> > > > would be used for IO. And while that's not how it currently works, it
> > > > definitely does make sense and we could make some things faster like
> > > > that. It would also potentially easier enable cancelation referenced in
> > > > #1 above, if it's restricted to the queue(s) that the ring "owns".
> > > 
> > > So I am looking at prototyping it, exclusively for the polled-io case.
> > > And for that, is there already a way to ensure that there are no
> > > concurrent submissions to this ring (set with IORING_SETUP_IOPOLL
> > > flag)?
> > > That will be the case generally (and submissions happen under
> > > uring_lock mutex), but submission may still get punted to io-wq
> > > worker(s) which do not take that mutex.
> > > So the original task and worker may get into doing concurrent submissions.
> > 
> > It seems one defect for uring command support, since io_ring_ctx and
> > io_ring_submit_lock() can't be exported for driver.
> 
> Sorry, did not follow the defect part.
> io-wq not acquring uring_lock in case of uring-cmd - is a defect? The same
> happens for direct block-io too.
> Or do you mean anything else here?

Maybe defect isn't one accurate word here.

I meant ->uring_cmd() is the only driver/fs callback in which
issue_flags is exposed, so IO_URING_F_UNLOCKED is visible to
driver, but io_ring_submit_lock() can't be done inside driver.

No such problem for direct io since the above io_uring details
isn't exposed to direct io code.


Thanks, 
Ming


