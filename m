Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576AFC7619A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Apr 2023 02:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xh3vi0ofSx2QU0YO2XPzgPE7lLpEQCLz4mn3+VeIaYI=; b=HMsqVX39iQzgakRyyMEaNxArNY
	4uJmV6VM+4hb5uVlDEhV4W4EQiHQ7BLzth2eEuzOgzQwwsT7YdB9f6Xh8AyKTpLqAtsuwGuVx1hlA
	5WboZscM+x5umiqZpoLH4sxQMNqUS985vFv5PfnU6hBD+l202K/OI1AHG8P3XY2bDWcFs+xDYAHme
	GdPeDXkabnf9E067Yn9aSfe9IUhJOEVK8wH1XdXxrMTcDU0NgDg5c0feMzESSoeE32AHbn7vVa/UG
	ctWkPCVPkTWbL2srEkTchqc70iEOyR78TB6T/0RORPbwSjkE8RolohFrnyYMrkFBwGTGME/CfTWNF
	HBxe8gxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmQJE-001cjk-2p;
	Wed, 12 Apr 2023 02:34:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmQJ9-001cj3-21
	for linux-nvme@lists.infradead.org;
	Wed, 12 Apr 2023 02:34:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681266840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xh3vi0ofSx2QU0YO2XPzgPE7lLpEQCLz4mn3+VeIaYI=;
	b=Z1Y+1flIyF/Xrs36rBtUBi04spF2sne59Z466IFTu4ctKdZx2eXKySaJ94KX61n/6Avn/u
	UsH7UeuYIyEnt89wjK3Pi2AAa4iqV3gtUUABLSDzFv7zcaWb8UAjuyw6Cv9M1gBP7nyBQr
	eh2ud/tLISWabRrwj/TsI7pyLEtBE+c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-inwUphz5MJKiZgElRWbuDg-1; Tue, 11 Apr 2023 22:33:55 -0400
X-MC-Unique: inwUphz5MJKiZgElRWbuDg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C4E5811E7C;
	Wed, 12 Apr 2023 02:33:54 +0000 (UTC)
Received: from ovpn-8-26.pek2.redhat.com (ovpn-8-26.pek2.redhat.com [10.72.8.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D8F7740C83A9;
	Wed, 12 Apr 2023 02:33:45 +0000 (UTC)
Date: Wed, 12 Apr 2023 10:33:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>,
	lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	hch@lst.de, kbusch@kernel.org, ming.lei@redhat.com
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF Topic] Non-block IO
Message-ID: <ZDYYhE1h1qvCvVmt@ovpn-8-26.pek2.redhat.com>
References: <CGME20230210180226epcas5p1bd2e1150de067f8af61de2bbf571594d@epcas5p1.samsung.com>
 <20230210180033.321377-1-joshi.k@samsung.com>
 <39a543d7-658c-0309-7a68-f07ffe850d0e@kernel.dk>
 <CA+1E3rLLu2ZzBHp30gwXBWzkCvOA4KD7PS70mLuGE8tYFpNEmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3rLLu2ZzBHp30gwXBWzkCvOA4KD7PS70mLuGE8tYFpNEmA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_193403_750762_9EBBE0E3 
X-CRM114-Status: GOOD (  26.28  )
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

On Wed, Apr 12, 2023 at 04:18:16AM +0530, Kanchan Joshi wrote:
> > > 4. Direct NVMe queues - will there be interest in having io_uring
> > > managed NVMe queues?  Sort of a new ring, for which I/O is destaged from
> > > io_uring SQE to NVMe SQE without having to go through intermediate
> > > constructs (i.e., bio/request). Hopefully,that can further amp up the
> > > efficiency of IO.
> >
> > This is interesting, and I've pondered something like that before too. I
> > think it's worth investigating and hacking up a prototype. I recently
> > had one user of IOPOLL assume that setting up a ring with IOPOLL would
> > automatically create a polled queue on the driver side and that is what
> > would be used for IO. And while that's not how it currently works, it
> > definitely does make sense and we could make some things faster like
> > that. It would also potentially easier enable cancelation referenced in
> > #1 above, if it's restricted to the queue(s) that the ring "owns".
> 
> So I am looking at prototyping it, exclusively for the polled-io case.
> And for that, is there already a way to ensure that there are no
> concurrent submissions to this ring (set with IORING_SETUP_IOPOLL
> flag)?
> That will be the case generally (and submissions happen under
> uring_lock mutex), but submission may still get punted to io-wq
> worker(s) which do not take that mutex.
> So the original task and worker may get into doing concurrent submissions.

It seems one defect for uring command support, since io_ring_ctx and
io_ring_submit_lock() can't be exported for driver.

It could be triggered if the request is in one link chain too.

Probably the issue may be workaround by:

	if (issue_flags & IO_URING_F_UNLOCKED)
		io_uring_cmd_complete_in_task(task_work_cb);


Thanks,
Ming


