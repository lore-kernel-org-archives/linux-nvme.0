Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E72ECAAD3
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Aug 2022 16:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zN11jPaPXDDbIqevs6c1zWtfj990F7oCTXRNyIdjv1c=; b=HvmqDlEycjw+aU1ECxpJP19NzT
	IwgfRjaDpkZZdcdXFxqHnJLach4Yv4TEBq/SgUrK1vLBSABuGVup7kcwvFwGkZizuPOoIZgy6bKKG
	f7mhzfGBScCdEh/KJ0mdRryzHd9dS4PHlDV6OyHk4KcJhWJmL+qNifgfrTt2LBf2MbPtuSG635ocH
	JecqGVupGDJvK+JO6QHv9E/DChs2h3pqfs/T0AoKzBkd0FJga1YjOPaHXeB/gdpCTh/2A5yiGeM2p
	t8lKIN6f1FwaRMRgauCgIVdlBYPc17CiT0UQBZFrwNS2oS1IeQK2y6Kz3v+Sv8PGTVgOpNGu1xh1r
	5nA//4WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTQDW-007CCA-MN; Wed, 31 Aug 2022 16:05:26 +0000
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTQDQ-007CAU-4j
	for linux-nvme@lists.infradead.org; Wed, 31 Aug 2022 16:05:25 +0000
Received: by mail-yb1-xb2b.google.com with SMTP id c9so4832346ybf.5
        for <linux-nvme@lists.infradead.org>; Wed, 31 Aug 2022 09:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=zN11jPaPXDDbIqevs6c1zWtfj990F7oCTXRNyIdjv1c=;
        b=eORWchV7A2HLyTkqukWrLjCB+763Y6EG1AO3+NLLa5aicNMN/e+28PbG4SGAui74MK
         6jd4w42kMqh4+Laozd1ynAxSAiygikcabMQZSjdrafOvSWKCbVls8eiRw9llXFPQFfBm
         6+BGcJFFA65qAN48aPRLmoUWTeGv7TEr3hq7sVPLzVy02Nt9ZavUS5JKFtP7w0Z5PLAP
         oqVyP2YckcDHnBZOYKZ11flfcoRJ9aF9M/KEGnPpZo6ELz1BJD8nFlUwodNj/2puAY0F
         jzLy3bA8FEldBz8i6PRpofrPJcoii2bO9IYqAsIrqCwsp/uz7C7Cxdf92pYWWS48hw+f
         0Bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=zN11jPaPXDDbIqevs6c1zWtfj990F7oCTXRNyIdjv1c=;
        b=QNGPzuq7RLmTRIuXkGfsSpsnZPZUrDOJ1I6k3MBqGlLgDrh8QPb9mJQCUFLbWYvsCq
         V/pZlMT6ESi20DUEloo5vbbKiW++JGHLh+Iu4Vz4SVEBzRrmWbgCNT5C6CKc+4/34iKr
         LS6mSCI4YiGZuv+yzv+a3Y4pz/nVvTP+irnMicFaDZlgAEvZVy2bqo8vJ4CObn4oGMEh
         Hb275GsnrR2tEzbItD12o0AGBPSTRSOkkuocPDzcWet1dqSDakn1uhPg9zaaaAHkjmvL
         zeY5JhFCUYOddsdaufeygY0FfVweu1YLiJZlc8/h9WDzpdj/5YqLHTkMeb4s4rZoPGnx
         BBgQ==
X-Gm-Message-State: ACgBeo23HeUozngee3nUh18GWv4ICbWaIYooXzljskaiSdSdBBaqTROx
	y+g3RoG2C/WMi+ZntTYwuySXza1GpH5aJrhbZsHGqttd96j84Y/h
X-Google-Smtp-Source: AA6agR789g6P6guLtb2MNDXpMzwfpPbQMKjyqK3m8zktbQLdxtYKalfveOdRwUCVKnGTSLk1KEapozMhY8+HVz2r0e4=
X-Received: by 2002:a25:40c9:0:b0:69a:ba91:9fc with SMTP id
 n192-20020a2540c9000000b0069aba9109fcmr13123147yba.443.1661961918033; Wed, 31
 Aug 2022 09:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAHex0cqr8Sn1ydFjRbwkG8LOMqBXEHL2YpYu_vO8658xLzouww@mail.gmail.com>
 <eb6b09b6-c899-e3b8-3217-02f8833818cd@grimberg.me>
In-Reply-To: <eb6b09b6-c899-e3b8-3217-02f8833818cd@grimberg.me>
From: Jonathan Nicklin <jnicklin@blockbridge.com>
Date: Wed, 31 Aug 2022 12:04:42 -0400
Message-ID: <CAHex0coajr37Xe_XE3sx+kgNosOD_d8N_SQcK=hT4NDAM8suBg@mail.gmail.com>
Subject: Re: nvme-tcp: i/o errors and stalled host from failure to send
 command pdus
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220831_090520_264976_3FEEC886 
X-CRM114-Status: GOOD (  30.59  )
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

On Wed, Aug 31, 2022 at 5:02 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > Hello,
>
> Hey Jonathan,
>
> > We've seen sporadic I/O errors with nvme-tcp in our lab when testing
> > with kernel versions 5.15 through 5.19. Using a combination of tracing
> > events and network traces, we can see nvme_setup_cmd() trace events
> > that do not result in transmitted commands PDUs.
> >
> > Here's a snippet of the relevant portion of the nvme trace. The
> > following events are the last of tens of thousands of successully
> > executed reads...
> >
> > tar-9004    [004] ..... 22457.614117: nvme_setup_cmd:
> >    nvme1: disk=nvme1c1n1, qid=5, cmdid=53272, nsid=1, flags=0x0, meta=0x0,
> >    cmd=(nvme_cmd_read slba=15760448, len=55, ctrl=0x8000, dsmgmt=7, reftag=0)
> > tar-9004    [004] ..... 22457.614118: nvme_setup_cmd:
> >    nvme1: disk=nvme1c1n1, qid=5, cmdid=61463, nsid=1, flags=0x0, meta=0x0,
> >    cmd=(nvme_cmd_read slba=15760384, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> > tar-9004    [004] ..... 22457.614119: nvme_setup_cmd:
> >    nvme1: disk=nvme1c1n1, qid=5, cmdid=16406, nsid=1, flags=0x0, meta=0x0,
> >    cmd=(nvme_cmd_read slba=15760376, len=7, ctrl=0x8000, dsmgmt=7, reftag=0)
> > tar-9004    [004] ..... 22457.614119: nvme_setup_cmd:
> >    nvme1: disk=nvme1c1n1, qid=5, cmdid=28693, nsid=1, flags=0x0, meta=0x0,
> >    cmd=(nvme_cmd_read slba=15760312, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> > tar-9004    [004] ..... 22457.614119: nvme_setup_cmd:
> >    nvme1: disk=nvme1c1n1, qid=5, cmdid=40980, nsid=1, flags=0x0, meta=0x0,
> >    cmd=(nvme_cmd_read slba=15760248, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> >
> > The following 5 commands are issued to nvme, but never make it to the
> > wire. The wire state was verified manually using tcpdump on the host and
> > trace events on the target. Perhaps the "need-resched" marker in the
> > trace and the context switch to the kernel worker are relevant
> > to the failure?
> >
> > tar-9004    [004] .n... 22457.614171: nvme_setup_cmd:
> >    nvme1: disk=nvme1c1n1, qid=5, cmdid=61469, nsid=1, flags=0x0, meta=0x0,
> >    cmd=(nvme_cmd_read slba=15760704, len=55, ctrl=0x8000, dsmgmt=7, reftag=0)
> > kworker/4:1H-8668    [004] ..... 22457.614183: nvme_setup_cmd:
> >    nvme1: disk=nvme1c1n1, qid=5, cmdid=45084, nsid=1, flags=0x0, meta=0x0,
> >    cmd=(nvme_cmd_read slba=15760640, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> > kworker/4:1H-8668    [004] ..... 22457.614184: nvme_setup_cmd:
> >    nvme1: disk=nvme1c1n1, qid=5, cmdid=28699, nsid=1, flags=0x0, meta=0x0,
> >    cmd=(nvme_cmd_read slba=15760632, len=7, ctrl=0x8000, dsmgmt=7, reftag=0)
> > kworker/4:1H-8668    [004] ..... 22457.614184: nvme_setup_cmd:
> >    nvme1: disk=nvme1c1n1, qid=5, cmdid=40986, nsid=1, flags=0x0, meta=0x0,
> >    cmd=(nvme_cmd_read slba=15760568, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> > kworker/4:1H-8668    [004] ..... 22457.614184: nvme_setup_cmd:
> >    nvme1: disk=nvme1c1n1, qid=5, cmdid=16409, nsid=1, flags=0x0, meta=0x0,
> >    cmd=(nvme_cmd_read slba=15760504, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> >
> > The reads above eventually timeout and recover after reset. Here are
> > the related reset messages.
> >
> > [22486.420606] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760568, 64 blocks, I/O
> > Error (sct 0x3 / sc 0x71)
> > [22486.429326] I/O error, dev nvme1c1n1, sector 15760568 op 0x0:(READ)
> > flags 0x4084700 phys_seg 1 prio class 0
> > [22486.439262] nvme nvme1: queue 5: timeout request 0x1b type 4
> > [22486.461788] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760632, 8 blocks, I/O
> > Error (sct 0x3 / sc 0x71)
> > [22486.470440] I/O error, dev nvme1c1n1, sector 15760632 op 0x0:(READ)
> > flags 0x4084700 phys_seg 1 prio class 0
> > [22486.480386] nvme nvme1: queue 5: timeout request 0x1c type 4
> > [22486.486256] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760640, 64 blocks, I/O
> > Error (sct 0x3 / sc 0x71)
> > [22486.494994] I/O error, dev nvme1c1n1, sector 15760640 op 0x0:(READ)
> > flags 0x4084700 phys_seg 2 prio class 0
> > [22486.504946] nvme nvme1: queue 5: timeout request 0x1d type 4
> > [22486.510822] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760704, 56 blocks, I/O
> > Error (sct 0x3 / sc 0x71)
> > [22486.519563] I/O error, dev nvme1c1n1, sector 15760704 op 0x0:(READ)
> > flags 0x4080700 phys_seg 2 prio class 0
> > [22486.529723] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760504, 64 blocks, I/O
> > Error (sct 0x3 / sc 0x71)
> > [22486.538610] I/O error, dev nvme1c1n1, sector 15760504 op 0x0:(READ)
> > flags 0x4084700 phys_seg 2 prio class 0
> >
> > To further aid in debugging, I resurrected Keith's nvme_tcp tracing event
> > patch from a ways back. If my understanding is correct,
> > nvme_tcp_cmd_pdu() is being called for the commands in question.
> >
> > I've isolated the failure to a scenario we can reproduce at will
> > in about a minute of runtime. Is there any additional debug that we can
> > provide to help locate the bug?
>
> Would be interesting to understand if for these requests,
> nvme_tcp_queue_request scheduled io_work or not (can be marked on the
> command and printed during the timeout expiration). If not, would be
> interesting to understand why.

Okay, here's a repro with a bit more context. I recorded the state
from nvme_tcp_queue_request() in the request and printed it out as you
suggested. I also added trace events for nvme_tcp_queue_rq() to make
it easier to match the state.

- lock is the return value of trylock() (if executed)
- more is the return value of nvme_tcp_queue_more(if executed)
- this_cpu is raw_smp_processor_id();

Here's the trace output for the failed requests with the associated
completion messages (from dmesg) stitched in.

  tar-2153 [001] .....   536.383588: nvme_tcp_queue_rq:
    nvme1: qid=2 tag=5 op=0 data_len=32768
  tar-2153 [001] .....   536.383588: nvme_setup_cmd:
    nvme1: disk=nvme1c1n1, qid=2, cmdid=8197, nsid=1, flags=0x0, meta=0x0,
      cmd=(nvme_cmd_read slba=9950336, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
  dmesg.out           [  565.574700] nvme_tcp_queue_request()
    state: tag 0x5 io_cpu 1 this_cpu 1 lock 1 sync 1 empty 1 last 0 more 1

 tar-2153  [001] .N...   536.383594: nvme_tcp_queue_rq:
   nvme1: qid=2 tag=4 op=0 data_len=32768
 tar-2153  [001] .N...   536.383594: nvme_setup_cmd:
   nvme1: disk=nvme1c1n1, qid=2, cmdid=16388, nsid=1, flags=0x0, meta=0x0,
     cmd=(nvme_cmd_read slba=9950272, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
 dmesg.out            [  565.540965] nvme_tcp_queue_request()
   state: tag 0x4 io_cpu 1 this_cpu 5 lock 1 sync 1 empty 1 last 0 more 1

kworker/1:0H-23  [001] .....   536.383619: nvme_tcp_queue_rq:
  nvme1: qid=2 tag=3 op=0 data_len=32768
kworker/1:0H-23  [001] .....   536.383619: nvme_setup_cmd:
  nvme1: disk=nvme1c1n1, qid=2, cmdid=24579, nsid=1, flags=0x0, meta=0x0,
    cmd=(nvme_cmd_read slba=9950208, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
dmesg.out              [  565.490597] nvme_tcp_queue_request()
  state: tag 0x3 io_cpu 1 this_cpu 1 lock 0 sync 1 empty 0 last 0 more 1

kworker/1:0H-23  [001] .....   536.383620: nvme_tcp_queue_rq:
  nvme1: qid=2 tag=2 op=0 data_len=32768
kworker/1:0H-23  [001] .....   536.383620: nvme_setup_cmd:
  nvme1: disk=nvme1c1n1, qid=2, cmdid=40962, nsid=1, flags=0x0, meta=0x0,
    cmd=(nvme_cmd_read slba=9950144, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
dmesg.out                   [  565.470687] nvme_tcp_queue_request()
  state: tag 0x2 io_cpu 1 this_cpu 1 lock 0 sync 1 empty 0 last 1 more 1

Does this shed any light on the issue?

