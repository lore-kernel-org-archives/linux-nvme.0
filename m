Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288F0C7619A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 23:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M0CkMqYq+hUDaj5V0hhmDO1UTL5tLPTAw4HpqPGo/CI=; b=JPa3Wz8lk766DeHm3OHRoR6El+
	rygU7EaA+krR6OM+jEN+N5PS0XgoL1nf7qnzwBXSwVsd4d9ZLbKQuERCtkZNQjkkxtPtEfFSZPlGK
	fVYmHrcpNQ0wrehVqQJffGa0cuvP7sgnMZ2k8gSK3MjWWigipz8cfvYK1NBQSxpuAvXrPMHDomoXs
	xEAROwlJPWFCY+5FVM3QLZKtkcBq1uDMlESbj1WPPuwOsiETNwrE5n+SIcr+rkUHyDH1bvRKWemAb
	o5gtHt8/ZQiSc1p5izHnuRzddMjvfYdnN9iBpxhkKgRw/ln0khGjE0j9oDZSYAGUWBW4uA1VMRCMm
	ty13w6vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmNQI-001LWr-2A;
	Tue, 11 Apr 2023 23:29:14 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmNQC-001LVl-1f
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 23:29:09 +0000
Received: by mail-wm1-x32a.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so13109193wmb.3
        for <linux-nvme@lists.infradead.org>; Tue, 11 Apr 2023 16:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681255746; x=1683847746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0CkMqYq+hUDaj5V0hhmDO1UTL5tLPTAw4HpqPGo/CI=;
        b=J3LVgwoNptw8bLlvE41uEG2j9TStrqHfFmkNM6ZeN/M4Nm7cEKyqL4PoocH7sjia4K
         pmJCOY0Fcah03z3qiU5733K/51RLO11+fXGsh6oThEdOkujyg1PJLP/Z1V/HMzVmYgMG
         yHH3baF+ux6fjywMOlkIFwK9Dd3mFTOHXXurmP+fyqJ/09BKbnqsweeDE5YPrjHccoOH
         OtJHdtkNvpGsCbm+hsQ0kA08LIDZ1iVVUiRg0cOtyl+7X29/1W2AF2RsWvo3Ba0ifrLW
         uN5naQd1ruuU6z5zDFdPdgGNWjJbvD0mTR5ol480+J+obbxotva53tnV7wMjs7q4wlfe
         rUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681255746; x=1683847746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0CkMqYq+hUDaj5V0hhmDO1UTL5tLPTAw4HpqPGo/CI=;
        b=Ff0kRv/BoXUrUlkpDxMEzStycRwPq2W1garfaRypvJqo4kf6ZV9UUsKbweW146IHpV
         fOs0biNT5hsigfXaMIx+xN4+lkVjFEvM5PgacpwPelyd4Q9mdQ2gR4hpZiAzP6+R+fKn
         v34kwiAF+99emQ3yZmQ2TQnBLonPhBbbHgvA/oUn5eZ/j1JFjcRp8IDfdJVe/RfdXz5M
         2eU7YoFt9MlnT0XQATmYhdOKb+W4hLYxUohy0U3t4WG55CubtWfwJ/KQ4BuBqjkG8icF
         TLtkOA9FDPCcnhQnUJxjea3ELooHJcq8+NV0YdMZam3bq1Br9T6UPym1wiGCFbyfCkxr
         jK6w==
X-Gm-Message-State: AAQBX9d+TyO8iBl6+FTQYSJtVHd9NyN+plbd+B16sQ2UUr8G9AiGrVQ8
	Rxpb5HoUePPxl0I1NB63pFPTlKPOjmt3/muqacY=
X-Google-Smtp-Source: AKy350a1/csCz3HEkVzqo/HDghWSl2B+ymjb4pAz7T2EVD2DK+b9INtbNQYEaj+mLr1tmIiLdpbp4f4mFehjNbzhVfw=
X-Received: by 2002:a05:600c:3797:b0:3ef:66ec:1e73 with SMTP id
 o23-20020a05600c379700b003ef66ec1e73mr2652309wmr.6.1681255745960; Tue, 11 Apr
 2023 16:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230210180226epcas5p1bd2e1150de067f8af61de2bbf571594d@epcas5p1.samsung.com>
 <20230210180033.321377-1-joshi.k@samsung.com> <39a543d7-658c-0309-7a68-f07ffe850d0e@kernel.dk>
 <CA+1E3rLLu2ZzBHp30gwXBWzkCvOA4KD7PS70mLuGE8tYFpNEmA@mail.gmail.com> <09a546bd-ec30-f2db-f63f-b7708e6d63a1@kernel.dk>
In-Reply-To: <09a546bd-ec30-f2db-f63f-b7708e6d63a1@kernel.dk>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Wed, 12 Apr 2023 04:58:41 +0530
Message-ID: <CA+1E3rKrXOOBEaRb4pfE29wmhRP-fcUcSwQ4gobKGRxMGyS8jg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF Topic] Non-block IO
To: Jens Axboe <axboe@kernel.dk>
Cc: Kanchan Joshi <joshi.k@samsung.com>, lsf-pc@lists.linux-foundation.org, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	io-uring@vger.kernel.org, hch@lst.de, kbusch@kernel.org, ming.lei@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_162908_590585_ED9AF973 
X-CRM114-Status: GOOD (  24.67  )
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

On Wed, Apr 12, 2023 at 4:23=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 4/11/23 4:48=E2=80=AFPM, Kanchan Joshi wrote:
> >>> 4. Direct NVMe queues - will there be interest in having io_uring
> >>> managed NVMe queues?  Sort of a new ring, for which I/O is destaged f=
rom
> >>> io_uring SQE to NVMe SQE without having to go through intermediate
> >>> constructs (i.e., bio/request). Hopefully,that can further amp up the
> >>> efficiency of IO.
> >>
> >> This is interesting, and I've pondered something like that before too.=
 I
> >> think it's worth investigating and hacking up a prototype. I recently
> >> had one user of IOPOLL assume that setting up a ring with IOPOLL would
> >> automatically create a polled queue on the driver side and that is wha=
t
> >> would be used for IO. And while that's not how it currently works, it
> >> definitely does make sense and we could make some things faster like
> >> that. It would also potentially easier enable cancelation referenced i=
n
> >> #1 above, if it's restricted to the queue(s) that the ring "owns".
> >
> > So I am looking at prototyping it, exclusively for the polled-io case.
> > And for that, is there already a way to ensure that there are no
> > concurrent submissions to this ring (set with IORING_SETUP_IOPOLL
> > flag)?
> > That will be the case generally (and submissions happen under
> > uring_lock mutex), but submission may still get punted to io-wq
> > worker(s) which do not take that mutex.
> > So the original task and worker may get into doing concurrent submissio=
ns.
>
> io-wq may indeed get in your way. But I think for something like this,
> you'd never want to punt to io-wq to begin with. If userspace is managing
> the queue, then by definition you cannot run out of tags.

Unfortunately we have lifetime differences between io_uring and NVMe.
NVMe tag remains valid/occupied until completion (we do not have a
nice sq->head to look at and decide).
For io_uring, it can be reused much earlier i.e. just after submission.
So tag shortage is possible.

>If there are
> other conditions for this kind of request that may run into out-of-memory
> conditions, then the error just needs to be returned.

I see, and IOSQE_ASYNC can also be flagged as an error/not-supported. Thank=
s.

