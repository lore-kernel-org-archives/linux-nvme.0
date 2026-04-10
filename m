Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E178E937E4
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Apr 2026 15:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Y42v4l6XRa4Mc3bL0tysYnB0VcDZSP2r5rXfsoOeKc=; b=ycQYfZ1jQJLBv5HS6f+Dyl/wMs
	KbgRkV4LgOPzSWYzOHvjQXf/nLfBkyaw8lzt18R+aUP+t3N5W5s3W8xOHIurqj0UzlFfLiL9zd2TX
	q3N/21eyKkv+40S+tYJoho2wrb+5Ja7qJcNRM+/Vkd798xWyWldO012YAQwiVNwT/2DNbbJ8NnrBZ
	5YD4qcCNLuIUT2ubeDURc4rwwClsUNOoY7PoSZbHiHW+X+lr/Ovk1Nuyl+PLWKXqkcRPtnRi2LrA5
	jGke9U5dgBHfz5ZcnzW7Szof0b7Yu4XjQL0D2yFILmngDqgxhATXaZMt9lZBqbGKzEv8+oP5W5xPg
	9wxW5JCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBwLO-0000000EQ7x-23w4;
	Sun, 12 Apr 2026 15:03:26 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB1rJ-0000000BUId-2exc
	for linux-nvme@lists.infradead.org;
	Fri, 10 Apr 2026 02:44:38 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-35d9749c26dso1463555a91.2
        for <linux-nvme@lists.infradead.org>; Thu, 09 Apr 2026 19:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775789076; x=1776393876; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Y42v4l6XRa4Mc3bL0tysYnB0VcDZSP2r5rXfsoOeKc=;
        b=gj9KPZTOLKkuMlpEYEQeAvDiwGfOY3WyD9xSQKhAEGy+O6raPoyDdiQzewyCkak0vl
         xYE4yrYPGlRUd2iia6TGD6lhohdOFVeRtR+BrqWcTjNio5f8nyL3AzBKJYWGU9gJjJfT
         fZ1x2K52KSSeoqVj6HzAKcXN4K36YXNebs3VWzgRjV9oykqiy9sKcbjh6GPvXtDlYIef
         tyDvpwr496aUS9SQggSziP8zE5rNJqgM5qcCr4k51wAqgT9Imy+qkG0EOLDtAvvmIf8U
         vWrw7qAtcRK6VPeVEpIfGkWHL5efJpSRj+PlUL41ovPqUjtN0BNJzxskcsSX858bYiK2
         oDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775789076; x=1776393876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Y42v4l6XRa4Mc3bL0tysYnB0VcDZSP2r5rXfsoOeKc=;
        b=Wlf9yksOSVvS0X/UKkY8nHO/2x3cXwVEFYxjX8Cd7x1X6wqU/XHqQLc2D0cN35VrrT
         pxeWWUqC6a29Jegdaog9rxX/KEnVM8MTcE7zJh0K04cLzn9BJNAjRZ/F5Eknie68m1x0
         g6mFg68/+aaUwnhrvoLg0OWHMMxfvwRPqvenXmOpDKqEyzsynkLJAj16n0IcFI6am15O
         momFpVsf1B2Vn0ND//osf5U/jpq+H2mkRSjALpqIaPSY9uDf3DHEHFbqXVfkb33jBLsL
         RdctNZXwpLG+qUShdPny95oWuhY/ofrCUo+/xk9WApTK55uB3jJ4+SRfsPxIP3s1Tdx+
         Oxgg==
X-Forwarded-Encrypted: i=1; AJvYcCWWCPEQShro9VUP79/qrv1o56I7tgol+B6V/SE0aUyOyGH/WYPL22USYUdvuz3c7521NeMhTUol3xFW@lists.infradead.org
X-Gm-Message-State: AOJu0Yw8SkFgydnXH4vyZliMsqQ82GhPG3OEIIU+mWYrRKK7SGnEaQKo
	prNnO+rE6UCiIWz5LkTCbEQJufWW7cTy4Gj2xSYt4/KRKgSs8Bj3Z695
X-Gm-Gg: AeBDietFQEu1LNn+hbbRJgZuslIhK6ZR5Wu/lf5cqPzv+Qtls0I+VDqvqLpnz9fYeBi
	nrJzyNMOyIS4wrsc6uriMEXJojfu4bRiGPmLYhLmX7xHiGoe/QH2Q7ROvL0/UE7RUcptxou0MM3
	Q5Woy2OJu+TwVw06dE4EeHTYivcosDuaKFMXHefGJ1D0i8iL97RZw9c2usB0TEsIXAAFyvv67/f
	NKdhpqyG7PFtlp7VeshUCx+xOppYRrhM3+JEBJIEsraggKDuxkEFrJHLquoHEcRjvcau6jtaT4j
	44h6Wj34QSw9qkBf0ON8d5kfczvnWxTscyWt+HoFPiFFz04kWGzbrnyKLkjsV4A2OchG63UmnNX
	c9WRMootq6rqA6x0LNMhi0n2hsusPQlTmjRI2wzbDo1nn6j9+KmVIw1RO7zaymC8S3WwGUP1Ftu
	aUr6Wn9PGlysQnCrki77dWfvRgBJ3B8aE3tO1L6GUMYFVAHWbKXVLW
X-Received: by 2002:a17:90a:e7ca:b0:359:974a:3d65 with SMTP id 98e67ed59e1d1-35e4285280dmr1485690a91.16.1775789075530;
        Thu, 09 Apr 2026 19:44:35 -0700 (PDT)
Received: from fedora ([2001:250:3c1e:503:ffff:ffff:74aa:4903])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e35156445sm4526177a91.14.2026.04.09.19.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 19:44:34 -0700 (PDT)
Date: Fri, 10 Apr 2026 10:44:15 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me, mst@redhat.com, aacraid@microsemi.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	liyihang9@h-partners.com, kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com,
	ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com,
	tglx@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com,
	bigeasy@linutronix.de, yphbchou0911@gmail.com, wagi@kernel.org,
	frederic@kernel.org, longman@redhat.com, chenridong@huawei.com,
	hare@suse.de, kch@nvidia.com, steve@abita.co, sean@ashe.io,
	chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Subject: Re: [PATCH v10 13/13] docs: add io_queue flag to isolcpus
Message-ID: <adhj_w11cpMfeEgN@fedora>
References: <20260401222312.772334-1-atomlin@atomlin.com>
 <20260401222312.772334-14-atomlin@atomlin.com>
 <ac8l-w8ERG1YN2Wm@fedora>
 <nxe24ixebb4lm2d5w4aubhtwr23df6mumqd663axj35oswdiyv@amtqhtsidyr4>
 <adMoon3Zf6gO-UbA@fedora>
 <zawhqvn53mcp4wf7axsmuq4cg73upxs5h2zgrfta5dpat3sfy4@zctfbz2ttz5m>
 <CAFj5m9JE5e4DRGbzQFxDdZWU76ZPQ3G+C9JpLu0mhTB6aesZ9g@mail.gmail.com>
 <a566smu6morqeefqal23eek4ibezfuiwhs774xtxhyyclpbtsx@uzzwgbzmwdjd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a566smu6morqeefqal23eek4ibezfuiwhs774xtxhyyclpbtsx@uzzwgbzmwdjd>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260409_194437_690059_50711805 
X-CRM114-Status: GOOD (  29.87  )
X-Mailman-Approved-At: Sun, 12 Apr 2026 08:03:19 -0700
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

On Thu, Apr 09, 2026 at 09:45:04PM -0400, Aaron Tomlin wrote:
> On Thu, Apr 09, 2026 at 11:00:09PM +0800, Ming Lei wrote:
> > How can the isolated core be scheduled for running polling task?
> > 
> > Who triggered it?
> > 
> > > loop waiting for the hardware completion. This would completely monopolise
> > > the core and destroy any real time isolation guarantees without the user
> > > space application ever having requested it.
> > 
> > No.
> > 
> > IOPOLL queue doesn't have interrupt, and the ->poll() is only run from
> > the submission context.  So if you don't submitted polled IO on isolated
> > CPU cores, everything is just fine.  This is simpler than irq IO actually.
> 
> Yes, you are entirely correct. The ->iopoll() is indeed executed strictly
> within the submission context. In the example below, the file operations
> iopoll callback is iocb_bio_iopoll():
> 
>       // file->f_op->iopoll(&rw->kiocb, iob, poll_flags)
>       iocb_bio_iopoll(&rw->kiocb, iob, poll_flags)
>       {
>         struct bio *bio
> 
>         bio = READ_ONCE(kiocb->private)
>         if (bio)
>           bio_poll(bio, iob, flags)
>             if (queue_is_mq(q))
>               blk_mq_poll(q, cookie, iob, flags)
>               {
>                 if (!blk_mq_can_poll(q))
>                   return 0
> 
>                 blk_hctx_poll(q, q->queue_hw_ctx[cookie], iob, flags)
>                 {
>                     int ret
> 
>                     do {
>                         ret = q->mq_ops->poll(hctx, iob)
>                         if (ret > 0)
>                             return ret
>                         if (task_sigpending(current))
>                             return 1
>                         if (ret < 0 || (flags & BLK_POLL_ONESHOT))
>                             break
>                         cpu_relax()
>                     } while (!need_resched())
> 
>                     return 0
>                 }
>               }
> 
> If an application on an isolated CPU does not explicitly submit a polled
> I/O request, it will not poll. Thank you for correcting me on this.

Great, you finally get the point.

> 
> > Can you share one example in which managed irq can't address?
> 
> Without io_queue, the block layer maps isolated CPUs to these queues, and
> the device will fire unmanaged interrupts that can freely land on isolated

For unmanaged interrupts, user can set irq affinity on housekeeping cpus
from /proc or kernel command line.

Why is unmanaged interrupts involved with this patchset?

> CPUs, thereby breaking isolation. By applying the constraint via io_queue
> at the block layer, we restrict the hardware queue count and map the
> isolated CPUs to the housekeeping queues, ensuring isolation is maintained
> regardless of whether the driver uses managed interrupts.
> 
> Does the above help?

As I mentioned, managed irq already covers it:

- typically application submits IO from housekeeping CPUs, which is mapped
  to one hardware, which effective interrupt affinity excludes isolated
  CPUs if possible.

I'd suggest to share some real problems you found instead of something
imaginary.

> 
> > > >
> > > > IMO, only two differences from this viewpoint:
> > > >
> > > > 1) `io_queue` may reduce nr_hw_queues
> > > >
> > > > 2) when application submits IO from isolated CPUs, `io_queue` can complete
> > > > IO from housekeeping CPUs.
> > >
> > > Acknowledged.
> > 
> > Are there other major differences besides the two mentioned above?
> 
> I believe the above is sufficient. Please let me know your thoughts.

Both two are small improvement, not bug fixes. However the user has to pay
the cost of potential failing of offlining CPU. Not mention the little 
complicated change: `19 files changed, 378 insertions(+), 48 deletions(-)`

But I won't object if you can update the commit log/kernel command line
doc and fix the issue found in review.

Thanks,
Ming

