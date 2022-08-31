Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C4FECAAD1
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Aug 2022 20:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aXEtZYF3XawVH0UR3twPFx5HKOElsTx5Bh0QvWj6KEk=; b=zTT5qAeUVVR47OaknGCr9YY8mX
	sVaOgXAKgL2ruxmRrUiDlgP09GminvRrMvn35aUWrgrwetLlOT0nrKqZ7fn80RNDoNGbghrOdyA3R
	0iV/tlekEDwZiGBkKr5W+mRIrBXBBp/mN/PC6RkhcI3bzq4ZOzNL9Dh1Ec3kosWOuLyLZ+YyQSd/d
	aA9emvHuxdHO/f4jLOU5H6H1zOHWzkq6cF6/D4kZ2gD7NHmVAkMwjuGAIceE+bHe18ZxJ4Oo9EAof
	Nfr2eJVa9KUtI+/pcTYTBCOEQRCkvmpSyuVATZgbmE6pT3j7ZnEtuDDZFUl16rPVqoZkqtbsKCPiE
	kmcA2jtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTTx8-00822B-B0; Wed, 31 Aug 2022 20:04:46 +0000
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTTx3-00820S-3I
	for linux-nvme@lists.infradead.org; Wed, 31 Aug 2022 20:04:44 +0000
Received: by mail-yb1-xb2d.google.com with SMTP id g5so5742351ybg.11
        for <linux-nvme@lists.infradead.org>; Wed, 31 Aug 2022 13:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=aXEtZYF3XawVH0UR3twPFx5HKOElsTx5Bh0QvWj6KEk=;
        b=jR9lLewVkulkQyk9Kmefy84LHbaguoi36Ninu666bumEB3QkaMTWupIhGOpKcZGFvR
         dJ7FKjPqKQlV6Lei8759Y90VAYo07JlJcNCwkxbkZ6y1ZEYMzzSt/HThnwEQU9Int82r
         euI7/LnFLwVNBvqO40bgWKzx8gLnbw9C/qlI4ADxshsunvIRV7Mowk5rv6jtJAw8CcK1
         a+KqW4AcjEAUoszllprj2MJ2JkYItfjd23jZzVToix2fUVM7AZZUHMOZECEDBiiz87pD
         pOkz/7Mj53fsGOo88fhILNA125GGAeO7lKeQmxXhqQOAkGYYBQVcK8CEAaDzSyQUYBYV
         HsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=aXEtZYF3XawVH0UR3twPFx5HKOElsTx5Bh0QvWj6KEk=;
        b=c1KqhYaCFPhcbsNjMgrMUCLlYItmofAzawSjJjqhVuMYg+zvbV4dzRw/kHeFw9wLaY
         onr59kLQbfuKrykTxX4R+wo/m5w9B0fvTwKW4WlStxS99vydm7qrN0HRz+NgCVp4wYjh
         Gxb5B6cVORL/Q3QP+QMx/0m/XyDF+i33jTuaghPydn9NrZOrBQ9+wPMJiqJgrF/fXpZr
         Nvl2pblKQ2PDRXfDt1avMHJEbkn4tAltN4+h8ZfJq4jW8B1tDKGlU4my1E3Lqlq1hr0T
         kkGsyICCpoGjhZtw/7I95tvB/+s/TL/V6y9uFRchqAtoX01c3OUOtd2OQOtl4vcsr8t5
         Clqw==
X-Gm-Message-State: ACgBeo2A2IToOH+chDjHz8hWgwhePiZ2edrsq0vWADVhbb+p1aaMgVkW
	cG+KcHSpQmzRUz8es456EGo2WOVONCJuB9YpbFwTtA+2lvIJSQ==
X-Google-Smtp-Source: AA6agR4CJFwg4CQL0q1g53vyJnrSsx1r0JwzqLgkYG7agrwV7eN8DGqBKnQnmM12KoU4rL9o20Ox/fRA7I3KM2cuHOg=
X-Received: by 2002:a25:40c9:0:b0:69a:ba91:9fc with SMTP id
 n192-20020a2540c9000000b0069aba9109fcmr13907449yba.443.1661976277573; Wed, 31
 Aug 2022 13:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHex0cqr8Sn1ydFjRbwkG8LOMqBXEHL2YpYu_vO8658xLzouww@mail.gmail.com>
 <eb6b09b6-c899-e3b8-3217-02f8833818cd@grimberg.me> <CAHex0coajr37Xe_XE3sx+kgNosOD_d8N_SQcK=hT4NDAM8suBg@mail.gmail.com>
 <ca7d5545-4630-59eb-3e50-6ca0594ba7c7@grimberg.me> <CAHex0coXdbR28S1PPSGuqJRH2JFZ4VpTg8NzfWFpHyBehK2urw@mail.gmail.com>
In-Reply-To: <CAHex0coXdbR28S1PPSGuqJRH2JFZ4VpTg8NzfWFpHyBehK2urw@mail.gmail.com>
From: Jonathan Nicklin <jnicklin@blockbridge.com>
Date: Wed, 31 Aug 2022 16:04:01 -0400
Message-ID: <CAHex0cqVOuSXf759Wdr3NS5gGCve+J-TUSNsvvbEpS7ONvFhMw@mail.gmail.com>
Subject: Re: nvme-tcp: i/o errors and stalled host from failure to send
 command pdus
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220831_130441_191776_3F7F3D24 
X-CRM114-Status: GOOD (  45.69  )
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

On Wed, Aug 31, 2022 at 3:06 PM Jonathan Nicklin
<jnicklin@blockbridge.com> wrote:
>
> Something about the logged state didn't make sense to me. Sure enough,
> I had a bug in the state tracking. Here's another attempt.
>
> I also added in"smp_id2", which is raw_smp_processor_id() recorded
> immediately after the direct send case. Is it interesting to point out that the
> CPU appears to change for the first command to go missing.
>
> Here's the arrangement of smp_id and smp_id2.
>
>     smp_id = raw_smp_processor_id();
> if (queue->io_cpu == smp_id && sync && empty) {
>         lock = mutex_trylock(&queue->send_mutex);
>         if (lock) {
>             queue->more_requests = !last;
>             nvme_tcp_send_all(queue);
>             queue->more_requests = false;
>             mutex_unlock(&queue->send_mutex);
>         }
> }
>     smp_id2 = raw_smp_processor_id();
>
> Here's the new trace with dmesg outputs:
>
> tar-1825    [005] .....   430.572846: nvme_tcp_queue_rq:
>  nvme1: qid=6 tag=2f op=0 data_len=32768
> tar-1825    [005] .N...   430.572849: nvme_setup_cmd:
>  nvme1: disk=nvme1c1n1, qid=6, cmdid=45103, nsid=1, flags=0x0, meta=0x0,
>   cmd=(nvme_cmd_read slba=9917888, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
>
> dmesg.out [  459.626849] nvme nvme1:
>  state: tag 0x2f io_cpu 5 smp_id 5 smp_id2 2 sync 1 empty 1 lock 1 last 0 more 0
>                  ^^^^^^^^ ^^^^^^^^ ^^^^^^^^^
>
> kworker/5:2H-1827    [005] .....   430.572913: nvme_tcp_queue_rq:
>  nvme1: qid=6 tag=2e op=0 data_len=32768
> kworker/5:2H-1827    [005] .....   430.572913: nvme_setup_cmd:
>  nvme1: disk=nvme1c1n1, qid=6, cmdid=16430, nsid=1, flags=0x0, meta=0x0,
>   cmd=(nvme_cmd_read slba=9917824, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
>
> dmesg.out [  459.593681] nvme nvme1:
>  state: tag 0x2e io_cpu 5 smp_id 5 smp_id2 5 sync 1 empty 0 lock 0 last 0 more 1
>
>
> kworker/5:2H-1827    [005] .....   430.572914: nvme_tcp_queue_rq:
>  nvme1: qid=6 tag=2d op=0 data_len=32768
> kworker/5:2H-1827    [005] .....   430.572914: nvme_setup_cmd:
>  nvme1: disk=nvme1c1n1, qid=6, cmdid=28717, nsid=1, flags=0x0, meta=0x0,
>   cmd=(nvme_cmd_read slba=9917760, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
>
> dmest.out [  459.560506] nvme nvme1:
>  state: tag 0x2d io_cpu 5 smp_id 5 smp_id2 5 sync 1 empty 0 lock 0 last 0 more 1
>
>
> kworker/5:2H-1827    [005] .....   430.572914: nvme_tcp_queue_rq:
>  nvme1: qid=6 tag=29 op=0 data_len=32768
> kworker/5:2H-1827    [005] .....   430.572914: nvme_setup_cmd:
>  nvme1: disk=nvme1c1n1, qid=6, cmdid=24617, nsid=1, flags=0x0, meta=0x0,
>   cmd=(nvme_cmd_read slba=9917696, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> dmest.out [  459.540904] nvme nvme1:
>  state: tag 0x29 io_cpu 5 smp_id 5 smp_id2 5 sync 1 empty 0 lock 0 last 1 more 1
>
>
> On Wed, Aug 31, 2022 at 2:50 PM Sagi Grimberg <sagi@grimberg.me> wrote:
> >
> >
> >
> > On 8/31/22 19:04, Jonathan Nicklin wrote:
> > > On Wed, Aug 31, 2022 at 5:02 AM Sagi Grimberg <sagi@grimberg.me> wrote:
> > >>
> > >>
> > >>> Hello,
> > >>
> > >> Hey Jonathan,
> > >>
> > >>> We've seen sporadic I/O errors with nvme-tcp in our lab when testing
> > >>> with kernel versions 5.15 through 5.19. Using a combination of tracing
> > >>> events and network traces, we can see nvme_setup_cmd() trace events
> > >>> that do not result in transmitted commands PDUs.
> > >>>
> > >>> Here's a snippet of the relevant portion of the nvme trace. The
> > >>> following events are the last of tens of thousands of successully
> > >>> executed reads...
> > >>>
> > >>> tar-9004    [004] ..... 22457.614117: nvme_setup_cmd:
> > >>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=53272, nsid=1, flags=0x0, meta=0x0,
> > >>>     cmd=(nvme_cmd_read slba=15760448, len=55, ctrl=0x8000, dsmgmt=7, reftag=0)
> > >>> tar-9004    [004] ..... 22457.614118: nvme_setup_cmd:
> > >>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=61463, nsid=1, flags=0x0, meta=0x0,
> > >>>     cmd=(nvme_cmd_read slba=15760384, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> > >>> tar-9004    [004] ..... 22457.614119: nvme_setup_cmd:
> > >>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=16406, nsid=1, flags=0x0, meta=0x0,
> > >>>     cmd=(nvme_cmd_read slba=15760376, len=7, ctrl=0x8000, dsmgmt=7, reftag=0)
> > >>> tar-9004    [004] ..... 22457.614119: nvme_setup_cmd:
> > >>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=28693, nsid=1, flags=0x0, meta=0x0,
> > >>>     cmd=(nvme_cmd_read slba=15760312, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> > >>> tar-9004    [004] ..... 22457.614119: nvme_setup_cmd:
> > >>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=40980, nsid=1, flags=0x0, meta=0x0,
> > >>>     cmd=(nvme_cmd_read slba=15760248, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> > >>>
> > >>> The following 5 commands are issued to nvme, but never make it to the
> > >>> wire. The wire state was verified manually using tcpdump on the host and
> > >>> trace events on the target. Perhaps the "need-resched" marker in the
> > >>> trace and the context switch to the kernel worker are relevant
> > >>> to the failure?
> > >>>
> > >>> tar-9004    [004] .n... 22457.614171: nvme_setup_cmd:
> > >>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=61469, nsid=1, flags=0x0, meta=0x0,
> > >>>     cmd=(nvme_cmd_read slba=15760704, len=55, ctrl=0x8000, dsmgmt=7, reftag=0)
> > >>> kworker/4:1H-8668    [004] ..... 22457.614183: nvme_setup_cmd:
> > >>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=45084, nsid=1, flags=0x0, meta=0x0,
> > >>>     cmd=(nvme_cmd_read slba=15760640, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> > >>> kworker/4:1H-8668    [004] ..... 22457.614184: nvme_setup_cmd:
> > >>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=28699, nsid=1, flags=0x0, meta=0x0,
> > >>>     cmd=(nvme_cmd_read slba=15760632, len=7, ctrl=0x8000, dsmgmt=7, reftag=0)
> > >>> kworker/4:1H-8668    [004] ..... 22457.614184: nvme_setup_cmd:
> > >>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=40986, nsid=1, flags=0x0, meta=0x0,
> > >>>     cmd=(nvme_cmd_read slba=15760568, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> > >>> kworker/4:1H-8668    [004] ..... 22457.614184: nvme_setup_cmd:
> > >>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=16409, nsid=1, flags=0x0, meta=0x0,
> > >>>     cmd=(nvme_cmd_read slba=15760504, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> > >>>
> > >>> The reads above eventually timeout and recover after reset. Here are
> > >>> the related reset messages.
> > >>>
> > >>> [22486.420606] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760568, 64 blocks, I/O
> > >>> Error (sct 0x3 / sc 0x71)
> > >>> [22486.429326] I/O error, dev nvme1c1n1, sector 15760568 op 0x0:(READ)
> > >>> flags 0x4084700 phys_seg 1 prio class 0
> > >>> [22486.439262] nvme nvme1: queue 5: timeout request 0x1b type 4
> > >>> [22486.461788] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760632, 8 blocks, I/O
> > >>> Error (sct 0x3 / sc 0x71)
> > >>> [22486.470440] I/O error, dev nvme1c1n1, sector 15760632 op 0x0:(READ)
> > >>> flags 0x4084700 phys_seg 1 prio class 0
> > >>> [22486.480386] nvme nvme1: queue 5: timeout request 0x1c type 4
> > >>> [22486.486256] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760640, 64 blocks, I/O
> > >>> Error (sct 0x3 / sc 0x71)
> > >>> [22486.494994] I/O error, dev nvme1c1n1, sector 15760640 op 0x0:(READ)
> > >>> flags 0x4084700 phys_seg 2 prio class 0
> > >>> [22486.504946] nvme nvme1: queue 5: timeout request 0x1d type 4
> > >>> [22486.510822] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760704, 56 blocks, I/O
> > >>> Error (sct 0x3 / sc 0x71)
> > >>> [22486.519563] I/O error, dev nvme1c1n1, sector 15760704 op 0x0:(READ)
> > >>> flags 0x4080700 phys_seg 2 prio class 0
> > >>> [22486.529723] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760504, 64 blocks, I/O
> > >>> Error (sct 0x3 / sc 0x71)
> > >>> [22486.538610] I/O error, dev nvme1c1n1, sector 15760504 op 0x0:(READ)
> > >>> flags 0x4084700 phys_seg 2 prio class 0
> > >>>
> > >>> To further aid in debugging, I resurrected Keith's nvme_tcp tracing event
> > >>> patch from a ways back. If my understanding is correct,
> > >>> nvme_tcp_cmd_pdu() is being called for the commands in question.
> > >>>
> > >>> I've isolated the failure to a scenario we can reproduce at will
> > >>> in about a minute of runtime. Is there any additional debug that we can
> > >>> provide to help locate the bug?
> > >>
> > >> Would be interesting to understand if for these requests,
> > >> nvme_tcp_queue_request scheduled io_work or not (can be marked on the
> > >> command and printed during the timeout expiration). If not, would be
> > >> interesting to understand why.
> > >
> > > Okay, here's a repro with a bit more context. I recorded the state
> > > from nvme_tcp_queue_request() in the request and printed it out as you
> > > suggested. I also added trace events for nvme_tcp_queue_rq() to make
> > > it easier to match the state.
> > >
> > > - lock is the return value of trylock() (if executed)
> > > - more is the return value of nvme_tcp_queue_more(if executed)
> > > - this_cpu is raw_smp_processor_id();
> > >
> > > Here's the trace output for the failed requests with the associated
> > > completion messages (from dmesg) stitched in.
> > >
> > >    tar-2153 [001] .....   536.383588: nvme_tcp_queue_rq:
> > >      nvme1: qid=2 tag=5 op=0 data_len=32768
> > >    tar-2153 [001] .....   536.383588: nvme_setup_cmd:
> > >      nvme1: disk=nvme1c1n1, qid=2, cmdid=8197, nsid=1, flags=0x0, meta=0x0,
> > >        cmd=(nvme_cmd_read slba=9950336, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> > >    dmesg.out           [  565.574700] nvme_tcp_queue_request()
> > >      state: tag 0x5 io_cpu 1 this_cpu 1 lock 1 sync 1 empty 1 last 0 more 1
> >
> > This is strange...
> > cpu matches, and the lock is taken, this means that the request should
> > have been sent immediately to the wire...
> >
> > However last=0, this will make the send marked with MSG_SENDPAGE_NOTLAST
> > which means the network stack will not send it right away...
> >
> > >
> > >   tar-2153  [001] .N...   536.383594: nvme_tcp_queue_rq:
> > >     nvme1: qid=2 tag=4 op=0 data_len=32768
> > >   tar-2153  [001] .N...   536.383594: nvme_setup_cmd:
> > >     nvme1: disk=nvme1c1n1, qid=2, cmdid=16388, nsid=1, flags=0x0, meta=0x0,
> > >       cmd=(nvme_cmd_read slba=9950272, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> > >   dmesg.out            [  565.540965] nvme_tcp_queue_request()
> > >     state: tag 0x4 io_cpu 1 this_cpu 5 lock 1 sync 1 empty 1 last 0 more 1
> >
> > Same here... sent down the network stack, but with MSG_SENDPAGE_NOTLAST.
> >
> > > kworker/1:0H-23  [001] .....   536.383619: nvme_tcp_queue_rq:
> > >    nvme1: qid=2 tag=3 op=0 data_len=32768
> > > kworker/1:0H-23  [001] .....   536.383619: nvme_setup_cmd:
> > >    nvme1: disk=nvme1c1n1, qid=2, cmdid=24579, nsid=1, flags=0x0, meta=0x0,
> > >      cmd=(nvme_cmd_read slba=9950208, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> > > dmesg.out              [  565.490597] nvme_tcp_queue_request()
> > >    state: tag 0x3 io_cpu 1 this_cpu 1 lock 0 sync 1 empty 0 last 0 more 1
> >
> > Here, the queue is not empty, so we are not sending right away, and its
> > also not the last in the batch, so we are also not queueing io_work, we
> > will wait for the last request in the batch to schedule io_work, to send
> > the batch to the network.
> >
> > > kworker/1:0H-23  [001] .....   536.383620: nvme_tcp_queue_rq:
> > >    nvme1: qid=2 tag=2 op=0 data_len=32768
> > > kworker/1:0H-23  [001] .....   536.383620: nvme_setup_cmd:
> > >    nvme1: disk=nvme1c1n1, qid=2, cmdid=40962, nsid=1, flags=0x0, meta=0x0,
> > >      cmd=(nvme_cmd_read slba=9950144, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> > > dmesg.out                   [  565.470687] nvme_tcp_queue_request()
> > >    state: tag 0x2 io_cpu 1 this_cpu 1 lock 0 sync 1 empty 0 last 1 more 1
> >
> > Here again, the queue is not empty, and its the last request in the
> > batch, so we should have scheduled io_work to send the queued requests
> > in the send_list along.
> >
> > These are not necessarily requests that were one after the other,
> > however the last request, should have flushed all the prior ones...
> >
> > Can you add an indication that a command was actually sent to the wire
> > (i.e. nvme_tcp_try_send_cmd_pdu() sends the entire cmd pdu).
>
> Something about the logged state didn't make sense to me. Sure enough,
> I had a bug in the state tracking. Here's another attempt.
>
> I also added in"smp_id2", which is raw_smp_processor_id() recorded
> immediately after the direct send case. Is it interesting to point out that the
> CPU appears to change for the first command to go missing.
>
> Here's the arrangement of smp_id and smp_id2.
>
>     smp_id = raw_smp_processor_id();
> if (queue->io_cpu == smp_id && sync && empty) {
>         lock = mutex_trylock(&queue->send_mutex);
>         if (lock) {
>             queue->more_requests = !last;
>             nvme_tcp_send_all(queue);
>             queue->more_requests = false;
>             mutex_unlock(&queue->send_mutex);
>         }
> }
>     smp_id2 = raw_smp_processor_id();
>
> Here's the new trace with dmesg outputs:
>
> tar-1825    [005] .....   430.572846: nvme_tcp_queue_rq:
>  nvme1: qid=6 tag=2f op=0 data_len=32768
> tar-1825    [005] .N...   430.572849: nvme_setup_cmd:
>  nvme1: disk=nvme1c1n1, qid=6, cmdid=45103, nsid=1, flags=0x0, meta=0x0,
>   cmd=(nvme_cmd_read slba=9917888, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
>
> dmesg.out [  459.626849] nvme nvme1:
>  state: tag 0x2f io_cpu 5 smp_id 5 smp_id2 2 sync 1 empty 1 lock 1 last 0 more 0
>                  ^^^^^^^^ ^^^^^^^^ ^^^^^^^^^
>
> kworker/5:2H-1827    [005] .....   430.572913: nvme_tcp_queue_rq:
>  nvme1: qid=6 tag=2e op=0 data_len=32768
> kworker/5:2H-1827    [005] .....   430.572913: nvme_setup_cmd:
>  nvme1: disk=nvme1c1n1, qid=6, cmdid=16430, nsid=1, flags=0x0, meta=0x0,
>   cmd=(nvme_cmd_read slba=9917824, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
>
> dmesg.out [  459.593681] nvme nvme1:
>  state: tag 0x2e io_cpu 5 smp_id 5 smp_id2 5 sync 1 empty 0 lock 0 last 0 more 1
>
>
> kworker/5:2H-1827    [005] .....   430.572914: nvme_tcp_queue_rq:
>  nvme1: qid=6 tag=2d op=0 data_len=32768
> kworker/5:2H-1827    [005] .....   430.572914: nvme_setup_cmd:
>  nvme1: disk=nvme1c1n1, qid=6, cmdid=28717, nsid=1, flags=0x0, meta=0x0,
>   cmd=(nvme_cmd_read slba=9917760, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
>
> dmest.out [  459.560506] nvme nvme1:
>  state: tag 0x2d io_cpu 5 smp_id 5 smp_id2 5 sync 1 empty 0 lock 0 last 0 more 1
>
>
> kworker/5:2H-1827    [005] .....   430.572914: nvme_tcp_queue_rq:
>  nvme1: qid=6 tag=29 op=0 data_len=32768
> kworker/5:2H-1827    [005] .....   430.572914: nvme_setup_cmd:
>  nvme1: disk=nvme1c1n1, qid=6, cmdid=24617, nsid=1, flags=0x0, meta=0x0,
>   cmd=(nvme_cmd_read slba=9917696, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> dmest.out [  459.540904] nvme nvme1:
>  state: tag 0x29 io_cpu 5 smp_id 5 smp_id2 5 sync 1 empty 0 lock 0 last 1 more 1
>
>
> On Wed, Aug 31, 2022 at 2:50 PM Sagi Grimberg <sagi@grimberg.me> wrote:
> >
> >
> >
> > On 8/31/22 19:04, Jonathan Nicklin wrote:
> > > On Wed, Aug 31, 2022 at 5:02 AM Sagi Grimberg <sagi@grimberg.me> wrote:
> > >>
> > >>
> > >>> Hello,
> > >>
> > >> Hey Jonathan,
> > >>
> > >>> We've seen sporadic I/O errors with nvme-tcp in our lab when testing
> > >>> with kernel versions 5.15 through 5.19. Using a combination of tracing
> > >>> events and network traces, we can see nvme_setup_cmd() trace events
> > >>> that do not result in transmitted commands PDUs.
> > >>>
> > >>> Here's a snippet of the relevant portion of the nvme trace. The
> > >>> following events are the last of tens of thousands of successully
> > >>> executed reads...
> > >>>
> > >>> tar-9004    [004] ..... 22457.614117: nvme_setup_cmd:
> > >>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=53272, nsid=1, flags=0x0, meta=0x0,
> > >>>     cmd=(nvme_cmd_read slba=15760448, len=55, ctrl=0x8000, dsmgmt=7, reftag=0)
> > >>> tar-9004    [004] ..... 22457.614118: nvme_setup_cmd:
> > >>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=61463, nsid=1, flags=0x0, meta=0x0,
> > >>>     cmd=(nvme_cmd_read slba=15760384, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> > >>> tar-9004    [004] ..... 22457.614119: nvme_setup_cmd:
> > >>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=16406, nsid=1, flags=0x0, meta=0x0,
> > >>>     cmd=(nvme_cmd_read slba=15760376, len=7, ctrl=0x8000, dsmgmt=7, reftag=0)
> > >>> tar-9004    [004] ..... 22457.614119: nvme_setup_cmd:
> > >>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=28693, nsid=1, flags=0x0, meta=0x0,
> > >>>     cmd=(nvme_cmd_read slba=15760312, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> > >>> tar-9004    [004] ..... 22457.614119: nvme_setup_cmd:
> > >>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=40980, nsid=1, flags=0x0, meta=0x0,
> > >>>     cmd=(nvme_cmd_read slba=15760248, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> > >>>
> > >>> The following 5 commands are issued to nvme, but never make it to the
> > >>> wire. The wire state was verified manually using tcpdump on the host and
> > >>> trace events on the target. Perhaps the "need-resched" marker in the
> > >>> trace and the context switch to the kernel worker are relevant
> > >>> to the failure?
> > >>>
> > >>> tar-9004    [004] .n... 22457.614171: nvme_setup_cmd:
> > >>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=61469, nsid=1, flags=0x0, meta=0x0,
> > >>>     cmd=(nvme_cmd_read slba=15760704, len=55, ctrl=0x8000, dsmgmt=7, reftag=0)
> > >>> kworker/4:1H-8668    [004] ..... 22457.614183: nvme_setup_cmd:
> > >>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=45084, nsid=1, flags=0x0, meta=0x0,
> > >>>     cmd=(nvme_cmd_read slba=15760640, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> > >>> kworker/4:1H-8668    [004] ..... 22457.614184: nvme_setup_cmd:
> > >>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=28699, nsid=1, flags=0x0, meta=0x0,
> > >>>     cmd=(nvme_cmd_read slba=15760632, len=7, ctrl=0x8000, dsmgmt=7, reftag=0)
> > >>> kworker/4:1H-8668    [004] ..... 22457.614184: nvme_setup_cmd:
> > >>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=40986, nsid=1, flags=0x0, meta=0x0,
> > >>>     cmd=(nvme_cmd_read slba=15760568, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> > >>> kworker/4:1H-8668    [004] ..... 22457.614184: nvme_setup_cmd:
> > >>>     nvme1: disk=nvme1c1n1, qid=5, cmdid=16409, nsid=1, flags=0x0, meta=0x0,
> > >>>     cmd=(nvme_cmd_read slba=15760504, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> > >>>
> > >>> The reads above eventually timeout and recover after reset. Here are
> > >>> the related reset messages.
> > >>>
> > >>> [22486.420606] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760568, 64 blocks, I/O
> > >>> Error (sct 0x3 / sc 0x71)
> > >>> [22486.429326] I/O error, dev nvme1c1n1, sector 15760568 op 0x0:(READ)
> > >>> flags 0x4084700 phys_seg 1 prio class 0
> > >>> [22486.439262] nvme nvme1: queue 5: timeout request 0x1b type 4
> > >>> [22486.461788] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760632, 8 blocks, I/O
> > >>> Error (sct 0x3 / sc 0x71)
> > >>> [22486.470440] I/O error, dev nvme1c1n1, sector 15760632 op 0x0:(READ)
> > >>> flags 0x4084700 phys_seg 1 prio class 0
> > >>> [22486.480386] nvme nvme1: queue 5: timeout request 0x1c type 4
> > >>> [22486.486256] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760640, 64 blocks, I/O
> > >>> Error (sct 0x3 / sc 0x71)
> > >>> [22486.494994] I/O error, dev nvme1c1n1, sector 15760640 op 0x0:(READ)
> > >>> flags 0x4084700 phys_seg 2 prio class 0
> > >>> [22486.504946] nvme nvme1: queue 5: timeout request 0x1d type 4
> > >>> [22486.510822] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760704, 56 blocks, I/O
> > >>> Error (sct 0x3 / sc 0x71)
> > >>> [22486.519563] I/O error, dev nvme1c1n1, sector 15760704 op 0x0:(READ)
> > >>> flags 0x4080700 phys_seg 2 prio class 0
> > >>> [22486.529723] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760504, 64 blocks, I/O
> > >>> Error (sct 0x3 / sc 0x71)
> > >>> [22486.538610] I/O error, dev nvme1c1n1, sector 15760504 op 0x0:(READ)
> > >>> flags 0x4084700 phys_seg 2 prio class 0
> > >>>
> > >>> To further aid in debugging, I resurrected Keith's nvme_tcp tracing event
> > >>> patch from a ways back. If my understanding is correct,
> > >>> nvme_tcp_cmd_pdu() is being called for the commands in question.
> > >>>
> > >>> I've isolated the failure to a scenario we can reproduce at will
> > >>> in about a minute of runtime. Is there any additional debug that we can
> > >>> provide to help locate the bug?
> > >>
> > >> Would be interesting to understand if for these requests,
> > >> nvme_tcp_queue_request scheduled io_work or not (can be marked on the
> > >> command and printed during the timeout expiration). If not, would be
> > >> interesting to understand why.
> > >
> > > Okay, here's a repro with a bit more context. I recorded the state
> > > from nvme_tcp_queue_request() in the request and printed it out as you
> > > suggested. I also added trace events for nvme_tcp_queue_rq() to make
> > > it easier to match the state.
> > >
> > > - lock is the return value of trylock() (if executed)
> > > - more is the return value of nvme_tcp_queue_more(if executed)
> > > - this_cpu is raw_smp_processor_id();
> > >
> > > Here's the trace output for the failed requests with the associated
> > > completion messages (from dmesg) stitched in.
> > >
> > >    tar-2153 [001] .....   536.383588: nvme_tcp_queue_rq:
> > >      nvme1: qid=2 tag=5 op=0 data_len=32768
> > >    tar-2153 [001] .....   536.383588: nvme_setup_cmd:
> > >      nvme1: disk=nvme1c1n1, qid=2, cmdid=8197, nsid=1, flags=0x0, meta=0x0,
> > >        cmd=(nvme_cmd_read slba=9950336, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> > >    dmesg.out           [  565.574700] nvme_tcp_queue_request()
> > >      state: tag 0x5 io_cpu 1 this_cpu 1 lock 1 sync 1 empty 1 last 0 more 1
> >
> > This is strange...
> > cpu matches, and the lock is taken, this means that the request should
> > have been sent immediately to the wire...
> >
> > However last=0, this will make the send marked with MSG_SENDPAGE_NOTLAST
> > which means the network stack will not send it right away...
> >
> > >
> > >   tar-2153  [001] .N...   536.383594: nvme_tcp_queue_rq:
> > >     nvme1: qid=2 tag=4 op=0 data_len=32768
> > >   tar-2153  [001] .N...   536.383594: nvme_setup_cmd:
> > >     nvme1: disk=nvme1c1n1, qid=2, cmdid=16388, nsid=1, flags=0x0, meta=0x0,
> > >       cmd=(nvme_cmd_read slba=9950272, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> > >   dmesg.out            [  565.540965] nvme_tcp_queue_request()
> > >     state: tag 0x4 io_cpu 1 this_cpu 5 lock 1 sync 1 empty 1 last 0 more 1
> >
> > Same here... sent down the network stack, but with MSG_SENDPAGE_NOTLAST.
> >
> > > kworker/1:0H-23  [001] .....   536.383619: nvme_tcp_queue_rq:
> > >    nvme1: qid=2 tag=3 op=0 data_len=32768
> > > kworker/1:0H-23  [001] .....   536.383619: nvme_setup_cmd:
> > >    nvme1: disk=nvme1c1n1, qid=2, cmdid=24579, nsid=1, flags=0x0, meta=0x0,
> > >      cmd=(nvme_cmd_read slba=9950208, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> > > dmesg.out              [  565.490597] nvme_tcp_queue_request()
> > >    state: tag 0x3 io_cpu 1 this_cpu 1 lock 0 sync 1 empty 0 last 0 more 1
> >
> > Here, the queue is not empty, so we are not sending right away, and its
> > also not the last in the batch, so we are also not queueing io_work, we
> > will wait for the last request in the batch to schedule io_work, to send
> > the batch to the network.
> >
> > > kworker/1:0H-23  [001] .....   536.383620: nvme_tcp_queue_rq:
> > >    nvme1: qid=2 tag=2 op=0 data_len=32768
> > > kworker/1:0H-23  [001] .....   536.383620: nvme_setup_cmd:
> > >    nvme1: disk=nvme1c1n1, qid=2, cmdid=40962, nsid=1, flags=0x0, meta=0x0,
> > >      cmd=(nvme_cmd_read slba=9950144, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> > > dmesg.out                   [  565.470687] nvme_tcp_queue_request()
> > >    state: tag 0x2 io_cpu 1 this_cpu 1 lock 0 sync 1 empty 0 last 1 more 1
> >
> > Here again, the queue is not empty, and its the last request in the
> > batch, so we should have scheduled io_work to send the queued requests
> > in the send_list along.
> >
> > These are not necessarily requests that were one after the other,
> > however the last request, should have flushed all the prior ones...
> >
> > Can you add an indication that a command was actually sent to the wire
> > (i.e. nvme_tcp_try_send_cmd_pdu() sends the entire cmd pdu).

Here's a trace including state from nvme_tcp_try_send_cmd_pdu(), like so.

req->dbg.send = 1;
ret = kernel_sendpage(queue->sock, virt_to_page(pdu), offset, len, flags);
req->dbg.sendpage = ret;


nvme-trace.out

tar-1785    [005] .....   232.768892:nvme_tcp_queue_rq:
 nvme1: qid=6 tag=18 op=0 data_len=20480
tar-1785    [005] .....   232.768894: nvme_tcp_queue_rq:
 nvme1: qid=6 tag=17 op=0 data_len=32768
tar-1785    [005] .N...   232.768895: nvme_tcp_queue_rq:
 nvme1: qid=6 tag=14 op=0 data_len=32768
kworker/5:1H-475     [005] .....   232.768923: nvme_tcp_queue_rq:
 nvme1: qid=6 tag=13 op=0 data_len=32768
kworker/5:1H-475     [005] .....   232.768924: nvme_tcp_queue_rq:
 nvme1: qid=6 tag=12 op=0 data_len=12288
tar-1785    [007] .....   232.769141: nvme_tcp_queue_rq:
 nvme1: qid=8 tag=69 op=0 data_len=20480


dmesg.out (reordered to match nvme-trace.out)

[  262.889536] nvme nvme1: state: tag 0x18 io_cpu 5 smp_id 5 smp_id2 5 sync 1
 empty 1 lock 1 last 0 more 0 send 0 sendpage -1
[  262.889337] nvme nvme1: state: tag 0x17 io_cpu 5 smp_id 5 smp_id2 5 sync 1
 empty 1 lock 1 last 0 more 0 send 0 sendpage -1
[  262.889110] nvme nvme1: state: tag 0x14 io_cpu 5 smp_id 5 smp_id2 7 sync 1
 empty 1 lock 1 last 0 more 0 send 0 sendpage -1
[  262.888864] nvme nvme1: state: tag 0x13 io_cpu 5 smp_id 5 smp_id2 5 sync 1
 empty 0 lock 0 last 0 more 1 send 1 sendpage 72
[  262.888727] nvme nvme1: state: tag 0x12 io_cpu 5 smp_id 5 smp_id2 5 sync 1
 empty 0 lock 0 last 1 more 1 send 1 sendpage 72

