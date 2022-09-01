Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D81ECAAD3
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Sep 2022 17:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R6Q7W7w09lP+CGiG02vXfb7QWd7GlPxt1kKFsguh0+s=; b=Q5I4AYP1cHhktEh0K+QMhXeNQJ
	BrofcjtDt8Irkz2NR1qzZuwM+JfLjFRaO7aSQCLjIReew3n3pNQcLveY/ZYfka947STrgrmtm7XrW
	dJUjpy1kESFnYiDJSn1OScNRfUwOcC0HYDQ5M2vqwi+xgVp97qgDNNA99fd5tShMidTbGSoQGXyJ7
	afA7YOf5/Vd0AM14ER7fQwr5/kqpjbHJJjiBwWEcKkS50BzjmP5Rn/RKG4LEuItU3eJE0F22vWKvy
	+PEDZbxXQjYm2QM0+0uUWjbBJjOi0U5MlLecvkAj445Z0d6cXExCo0IjMacvVNUUisdBLQdPgJn1h
	KeP4NQ1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oToCK-00Dekr-Pr; Thu, 01 Sep 2022 17:41:48 +0000
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oToAt-00De1o-RN
	for linux-nvme@lists.infradead.org; Thu, 01 Sep 2022 17:40:21 +0000
Received: by mail-yb1-xb36.google.com with SMTP id f18so9622473yba.1
        for <linux-nvme@lists.infradead.org>; Thu, 01 Sep 2022 10:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=R6Q7W7w09lP+CGiG02vXfb7QWd7GlPxt1kKFsguh0+s=;
        b=C+UsFIYrsJ4DpR1vvJ0+iAd5UvQ1bKx+LjEw0LH2ghzVEkgWfdI3mnBK086z1g7zAs
         /VRrghwXoHbj6uoC4I/9LUcBxh9RQeBV3PklqlHYX/5/fWm3Bd3+NV9rhxiJ01JXpbie
         LRLyfL4ltfXxijiIUtSlEol+bcebXAVMSXpIibSZuSMvGfmdqfQghZAN8MfLarFaAkQc
         WquP2lUw14hUeR/BDs5ja5YSIcpFZYqh5OL6mlltYhVocU9zrO3uCe9qbdV3fzG0tXWD
         EKrmJbA21Dqe6AOCbQ8sh8guqVJdic++1zAiaek42XGGuKmy4bo6wRBLBPSZAE4UQ9hd
         7cKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=R6Q7W7w09lP+CGiG02vXfb7QWd7GlPxt1kKFsguh0+s=;
        b=I6J9v5scN7zMTk3QqBoL3K825khuya8dDPAikg8wyYqRg8c1lwp5Qlu1sAZRBfaDlg
         ybYy/GwNHbOq5DNfDo5Y3Galac8co4kF0g4jYLZIW3ktsqOdVjP6At84oLnvH9BOWHlS
         I9ZHhet69xD9CGkv4fDolYeVcGgs1KYwz/2zDVgU8XHvxY89X3cWuQxhmTMCijSTp28C
         Tgsc1Flb3DgaOJTmdpEtufP8kmPC3dfzDE+TdeD2SAZUXfuwpA8Q/zkwsZI3XiTElvHU
         my3A7UDV8A7igloRo+wVjcvaExTXpaLGC+iGR+dZfQcDqnuoZkIt3HfU0jNg3iJ1sD3J
         F61g==
X-Gm-Message-State: ACgBeo0ZUtwmeGmRMb63cznR9USzgfhc1aKnfr1foAETcdlevYaO54YY
	MLX17KNUnkVmnELs1+2aOb4FGceMU+GuDiRv7QlhNnTpTP3YV+zG
X-Google-Smtp-Source: AA6agR5Aja9SBOir2HRvjzKz4Ueo0kXLlNUKzIkK5zQtIEJ4TrtO7hWJXW6lWCLWYsjBmGpDVTvsIxDw2iJ4XcOgzLY=
X-Received: by 2002:a05:6902:572:b0:67c:2af2:3a75 with SMTP id
 a18-20020a056902057200b0067c2af23a75mr18946148ybt.346.1662054017956; Thu, 01
 Sep 2022 10:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHex0cqr8Sn1ydFjRbwkG8LOMqBXEHL2YpYu_vO8658xLzouww@mail.gmail.com>
 <eb6b09b6-c899-e3b8-3217-02f8833818cd@grimberg.me> <CAHex0coajr37Xe_XE3sx+kgNosOD_d8N_SQcK=hT4NDAM8suBg@mail.gmail.com>
 <ca7d5545-4630-59eb-3e50-6ca0594ba7c7@grimberg.me> <CAHex0coXdbR28S1PPSGuqJRH2JFZ4VpTg8NzfWFpHyBehK2urw@mail.gmail.com>
 <CAHex0cqVOuSXf759Wdr3NS5gGCve+J-TUSNsvvbEpS7ONvFhMw@mail.gmail.com>
 <715a183c-f888-74f2-9217-b9b430f16d1e@grimberg.me> <CAHex0crz1FGrQKnWCrWTCWJ_GsMn5iMmNMtq-BN+nDDUajshdg@mail.gmail.com>
 <6cf7127b-561d-b59f-1dc0-aefae9ad7e76@grimberg.me>
In-Reply-To: <6cf7127b-561d-b59f-1dc0-aefae9ad7e76@grimberg.me>
From: Jonathan Nicklin <jnicklin@blockbridge.com>
Date: Thu, 1 Sep 2022 13:39:42 -0400
Message-ID: <CAHex0cpjga-Pt6pDqOuBAN45CFqk+qBdBaFOzN8MLWqxUb5Pew@mail.gmail.com>
Subject: Re: nvme-tcp: i/o errors and stalled host from failure to send
 command pdus
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_104019_923809_ACF849B9 
X-CRM114-Status: GOOD (  33.70  )
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

Of course! The workload is a test from a suite of data consistency tests
we run. The test walk's a directory and generates a checksum of the
contents. So, it is pretty much read-only. The underlying filesystem
is XFS. The kernel is 5.19.5. To repro, I'm just running the following
in a loop.

umount /mnt/nvme
mount /dev/nvme1n1 /mnt/nvme
find /mnt/nvme/linux-5.18.3 | LC_ALL=C sort | sudo tar -Pcf - -T -
--no-recursion | md5sum

This is on a 4-core intel CPU, with hyperthreading (4+4), 100G
Mellanox (all interrupts bound to core0)


On Thu, Sep 1, 2022 at 1:00 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >>> Here's a trace including state from nvme_tcp_try_send_cmd_pdu(), like so.
> >>>
> >>> req->dbg.send = 1;
> >>> ret = kernel_sendpage(queue->sock, virt_to_page(pdu), offset, len, flags);
> >>> req->dbg.sendpage = ret;
> >>>
> >>>
> >>> nvme-trace.out
> >>>
> >>> tar-1785    [005] .....   232.768892:nvme_tcp_queue_rq:
> >>>    nvme1: qid=6 tag=18 op=0 data_len=20480
> >>> tar-1785    [005] .....   232.768894: nvme_tcp_queue_rq:
> >>>    nvme1: qid=6 tag=17 op=0 data_len=32768
> >>> tar-1785    [005] .N...   232.768895: nvme_tcp_queue_rq:
> >>>    nvme1: qid=6 tag=14 op=0 data_len=32768
> >>> kworker/5:1H-475     [005] .....   232.768923: nvme_tcp_queue_rq:
> >>>    nvme1: qid=6 tag=13 op=0 data_len=32768
> >>> kworker/5:1H-475     [005] .....   232.768924: nvme_tcp_queue_rq:
> >>>    nvme1: qid=6 tag=12 op=0 data_len=12288
> >>> tar-1785    [007] .....   232.769141: nvme_tcp_queue_rq:
> >>>    nvme1: qid=8 tag=69 op=0 data_len=20480
> >>>
> >>>
> >>> dmesg.out (reordered to match nvme-trace.out)
> >>>
> >>> [  262.889536] nvme nvme1: state: tag 0x18 io_cpu 5 smp_id 5 smp_id2 5 sync 1
> >>>    empty 1 lock 1 last 0 more 0 send 0 sendpage -1
> >>
> >> Something is not adding up...
> >> lock=1, means that we get into nvme_tcp_send_all(), but somehow we are
> >> not able to send it to the wire?
> >>
> >> I'd look into this and add indication that it is pulled from the
> >> req_list, and in turn from the send_list. It looks like it is somehow
> >> picked out and silteny dropped, because as long as it is on the list(s)
> >> another context should have picked it up at some point...
> >>
> >>> [  262.889337] nvme nvme1: state: tag 0x17 io_cpu 5 smp_id 5 smp_id2 5 sync 1
> >>>    empty 1 lock 1 last 0 more 0 send 0 sendpage -1
> >>> [  262.889110] nvme nvme1: state: tag 0x14 io_cpu 5 smp_id 5 smp_id2 7 sync 1
> >>>    empty 1 lock 1 last 0 more 0 send 0 sendpage -1
> >>> [  262.888864] nvme nvme1: state: tag 0x13 io_cpu 5 smp_id 5 smp_id2 5 sync 1
> >>>    empty 0 lock 0 last 0 more 1 send 1 sendpage 72
> >>> [  262.888727] nvme nvme1: state: tag 0x12 io_cpu 5 smp_id 5 smp_id2 5 sync 1
> >>>    empty 0 lock 0 last 1 more 1 send 1 sendpage 72
> >
> > Ugh. It was misleading because the send state tracking was
> > re-initialized after the direct send case. Here's a better trace with
> > more information. It appears as though sendpage() is always called
> > with the NOTLAST flag set. I suppose this could mean that there is
> > some confusion or race with nvme_tcp_queue_more()?
>
> I don't know yet...
>
> > tar-1872          [004] ..... 389.559784: nvme_tcp_queue_rq:
> >   nvme1: qid=5 tag=28 op=0 data_len=16384
> > tar-1872          [004] .N... 389.559786: nvme_tcp_queue_rq:
> >   nvme1: qid=5 tag=27 op=0 data_len=16384
> > kworker/4:2H-1873 [004] ..... 389.559798: nvme_tcp_queue_rq:
> >   nvme1: qid=5 tag=26 op=0 data_len=32768
> > kworker/4:2H-1873 [004] ..... 389.559798: nvme_tcp_queue_rq:
> >   nvme1: qid=5 tag=25 op=0 data_len=32768
> > kworker/4:2H-1873 [004] ..... 389.559799: nvme_tcp_queue_rq:
> >   nvme1: qid=5 tag=24 op=0 data_len=32768
> >
> >
> > [  419.790505] nvme nvme1: state: tag 0x28 io_cpu 4 smp_id 4 smp_id2 4 sync 1
> >   empty 1 lock 1 last 0 more 0 send 1 send_ret 72 send_flags 0x28040
> > [  419.790299] nvme nvme1: state: tag 0x27 io_cpu 4 smp_id 4 smp_id2 0 sync 1
> >   empty 1 lock 1 last 0 more 0 send 1 send_ret 72 send_flags 0x28040
>
> Here lock=1, which means that we send inline, however last=0, which
> means that more requests are coming and corresponds with NOLAST flag.
>
> > [  419.789809] nvme nvme1: state: tag 0x25 io_cpu 4 smp_id 4 smp_id2 4 sync 1
> >   empty 0 lock 0 last 0 more 1 send 1 send_ret 72 send_flags 0x28040
> > [  419.790065] nvme nvme1: state: tag 0x26 io_cpu 4 smp_id 4 smp_id2 4 sync 1
> >   empty 0 lock 0 last 0 more 1 send 1 send_ret 72 send_flags 0x28040
>
> here lock=0, but last=0 as well, so we add the request to req_list and
> _not_ trigger io_work, again because more requests are coming.
>
> > [  419.789663] nvme nvme1: state: tag 0x24 io_cpu 4 smp_id 4 smp_id2 4 sync 1
> >   empty 0 lock 0 last 1 more 1 send 1 send_ret 72 send_flags 0x28040
>
> Here lock=0, last=1, and we have requests that are queued (more=1), so
> we add the the req_list, and schedule io_work. Now sending the last
> 3 commands happens asynchronously, so by the time that we get to send
> to the wire, it is possible that more requests got queued, which
> may explain why NOLAST flag is set...
>
> So we cannot know for sure... You can add what is nvme_tcp_queue_more
> at the time the flag is determined, but according to the code, it is
> set if more requests are queued in req_list/send_list.
>
> At some point, we'd expect to send with a request that has NOLAST
> flag cleared. Would be interesting to make sure that we are getting
> there.
>
> BTW, is this a read-only workload? filesystem? can you share more
> about the workload?

