Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30BBECAAD3
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Sep 2022 13:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AAxTfwnVYwu5uTQBQNlt03+52hOtiexv4+bddaMvZMI=; b=WmbDVyoBNdtQ/6jnLPzWLmHPXL
	3+KreMncPj30Rd1e+zwdaSjD/6nZ1CZkSnvKdU+Xq+I8RcVtaLob5NIeOfEYyr8mvk1K1HlH9qarV
	iU2o87iIx67koGHYy6OWUhyPXHwUlCZyn+qOB7yZ8fBH1y4bBbZ/RWONqIcWpMAv3V6xptQNUFOoF
	js6lG9emyDVdD6zU/LazE1PblpNXhvAiGeopusqJXG22chw1jUJL64uEO8Sev7zsOB9vZz7/2EOdT
	hCifIl74NOjZCA54t0dlGzr616YxhF0kS+LzBs/8gnIfeHrRG+T5ZtndjO5hk60zOWqM5OKl0AxJd
	RHjJpShA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTkJa-00C4s4-Kd; Thu, 01 Sep 2022 13:33:02 +0000
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTkA3-00BzSP-BT
	for linux-nvme@lists.infradead.org; Thu, 01 Sep 2022 13:23:13 +0000
Received: by mail-yb1-xb2e.google.com with SMTP id c9so8571466ybf.5
        for <linux-nvme@lists.infradead.org>; Thu, 01 Sep 2022 06:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=AAxTfwnVYwu5uTQBQNlt03+52hOtiexv4+bddaMvZMI=;
        b=fwjidVvFzBLhImljbfxcX5/9f6dL++lgGl4JWrpP/hqGAQsFHy8q2Abr3u8SJtinwv
         sxLHNRU3XU7gNlgnzeRAL1Ve2s8/hQKQVbxc7L4z+UZpzq+cc0JyWIis00/gL20acIfJ
         XhinFtn4Qohev3DiWdj9GQp6hzZEzRIadSy7lcNKUUaonJbqtb9TQ0+najehPZNdmZ6x
         PDYeGSwkX7YZ/llwqQsy0Xx7dEn+Lo7pyckJhYHF0rpFiTJO9BvITTqUoDglhGDWb05t
         wex2k6bYaI8YXMCDa2q1Pf0SrYWPHJ5CXvkQQ3QHA4mWfIgjt20jqYQRdvsHIpoByPM/
         HPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=AAxTfwnVYwu5uTQBQNlt03+52hOtiexv4+bddaMvZMI=;
        b=5YGZIn5kwpULE8rxdo6knhTul01dzTCGP3uhmNGEAOg9BhkEayj9LKvl+/tPWY4wfz
         ssnmVlZ6KFKY3sngEqrJvOzEIEZCd1s+7prcUyfFxPmVkpYDKzGTz47y/Nzb71gwsAST
         A+MIPI7FjmVgYj3+Xp/ZUA+B+xGnD4LBogJ7FToh6MgFCPKwIxO9oEgtpERxlbG1VzFX
         jx5Lkj3at2bLhyuKa8qb19e7QI2mC2YnEEv3rNEXGFtOISg+xGopnKw3BMh0KrR1G+46
         m0WGCZd5ull8t3LxNu3cbRJ9wdbsR8GWcTKOXNV/PDX6CVYXdcUeUKTfTd1I3NZizXbh
         mbUA==
X-Gm-Message-State: ACgBeo0fvBJoiYYuhbEtPUS0MNNAY+cMVnZtOHr71YtWkfusmF5J/Zl9
	rOkExUsYIQoxivhfEGvsPJ2xvBQRWgS/vHBDg1uOqyb03dMMxTJA
X-Google-Smtp-Source: AA6agR596yhDUE7BVw5j0xuuvg46VK3wI14JzW5ds8Q6qBwK4tISYkHluozBRi9P5KI6Y7F5e0U1MNf4GP8tuUPiJAw=
X-Received: by 2002:a05:6902:1022:b0:695:c571:7da9 with SMTP id
 x2-20020a056902102200b00695c5717da9mr20616126ybt.72.1662038587713; Thu, 01
 Sep 2022 06:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAHex0cqr8Sn1ydFjRbwkG8LOMqBXEHL2YpYu_vO8658xLzouww@mail.gmail.com>
 <eb6b09b6-c899-e3b8-3217-02f8833818cd@grimberg.me> <CAHex0coajr37Xe_XE3sx+kgNosOD_d8N_SQcK=hT4NDAM8suBg@mail.gmail.com>
 <ca7d5545-4630-59eb-3e50-6ca0594ba7c7@grimberg.me> <CAHex0coXdbR28S1PPSGuqJRH2JFZ4VpTg8NzfWFpHyBehK2urw@mail.gmail.com>
 <CAHex0cqVOuSXf759Wdr3NS5gGCve+J-TUSNsvvbEpS7ONvFhMw@mail.gmail.com>
 <715a183c-f888-74f2-9217-b9b430f16d1e@grimberg.me> <CAHex0crz1FGrQKnWCrWTCWJ_GsMn5iMmNMtq-BN+nDDUajshdg@mail.gmail.com>
In-Reply-To: <CAHex0crz1FGrQKnWCrWTCWJ_GsMn5iMmNMtq-BN+nDDUajshdg@mail.gmail.com>
From: Jonathan Nicklin <jnicklin@blockbridge.com>
Date: Thu, 1 Sep 2022 09:22:31 -0400
Message-ID: <CAHex0co9JNwFkDpNvPitESYX6-2F8_n8phxzVsZFq2kieYLGJQ@mail.gmail.com>
Subject: Re: nvme-tcp: i/o errors and stalled host from failure to send
 command pdus
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_062311_443124_02E479D1 
X-CRM114-Status: GOOD (  23.42  )
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

On Thu, Sep 1, 2022 at 8:37 AM Jonathan Nicklin
<jnicklin@blockbridge.com> wrote:
>
> On Wed, Aug 31, 2022 at 7:42 PM Sagi Grimberg <sagi@grimberg.me> wrote:
> >
> >
> > >
> > > Here's a trace including state from nvme_tcp_try_send_cmd_pdu(), like so.
> > >
> > > req->dbg.send = 1;
> > > ret = kernel_sendpage(queue->sock, virt_to_page(pdu), offset, len, flags);
> > > req->dbg.sendpage = ret;
> > >
> > >
> > > nvme-trace.out
> > >
> > > tar-1785    [005] .....   232.768892:nvme_tcp_queue_rq:
> > >   nvme1: qid=6 tag=18 op=0 data_len=20480
> > > tar-1785    [005] .....   232.768894: nvme_tcp_queue_rq:
> > >   nvme1: qid=6 tag=17 op=0 data_len=32768
> > > tar-1785    [005] .N...   232.768895: nvme_tcp_queue_rq:
> > >   nvme1: qid=6 tag=14 op=0 data_len=32768
> > > kworker/5:1H-475     [005] .....   232.768923: nvme_tcp_queue_rq:
> > >   nvme1: qid=6 tag=13 op=0 data_len=32768
> > > kworker/5:1H-475     [005] .....   232.768924: nvme_tcp_queue_rq:
> > >   nvme1: qid=6 tag=12 op=0 data_len=12288
> > > tar-1785    [007] .....   232.769141: nvme_tcp_queue_rq:
> > >   nvme1: qid=8 tag=69 op=0 data_len=20480
> > >
> > >
> > > dmesg.out (reordered to match nvme-trace.out)
> > >
> > > [  262.889536] nvme nvme1: state: tag 0x18 io_cpu 5 smp_id 5 smp_id2 5 sync 1
> > >   empty 1 lock 1 last 0 more 0 send 0 sendpage -1
> >
> > Something is not adding up...
> > lock=1, means that we get into nvme_tcp_send_all(), but somehow we are
> > not able to send it to the wire?
> >
> > I'd look into this and add indication that it is pulled from the
> > req_list, and in turn from the send_list. It looks like it is somehow
> > picked out and silteny dropped, because as long as it is on the list(s)
> > another context should have picked it up at some point...
> >
> > > [  262.889337] nvme nvme1: state: tag 0x17 io_cpu 5 smp_id 5 smp_id2 5 sync 1
> > >   empty 1 lock 1 last 0 more 0 send 0 sendpage -1
> > > [  262.889110] nvme nvme1: state: tag 0x14 io_cpu 5 smp_id 5 smp_id2 7 sync 1
> > >   empty 1 lock 1 last 0 more 0 send 0 sendpage -1
> > > [  262.888864] nvme nvme1: state: tag 0x13 io_cpu 5 smp_id 5 smp_id2 5 sync 1
> > >   empty 0 lock 0 last 0 more 1 send 1 sendpage 72
> > > [  262.888727] nvme nvme1: state: tag 0x12 io_cpu 5 smp_id 5 smp_id2 5 sync 1
> > >   empty 0 lock 0 last 1 more 1 send 1 sendpage 72
>
> Ugh. It was misleading because the send state tracking was
> re-initialized after the direct send case. Here's a better trace with
> more information. It appears as though sendpage() is always called
> with the NOTLAST flag set. I suppose this could mean that there is
> some confusion or race with nvme_tcp_queue_more()?
>
> tar-1872          [004] ..... 389.559784: nvme_tcp_queue_rq:
>  nvme1: qid=5 tag=28 op=0 data_len=16384
> tar-1872          [004] .N... 389.559786: nvme_tcp_queue_rq:
>  nvme1: qid=5 tag=27 op=0 data_len=16384
> kworker/4:2H-1873 [004] ..... 389.559798: nvme_tcp_queue_rq:
>  nvme1: qid=5 tag=26 op=0 data_len=32768
> kworker/4:2H-1873 [004] ..... 389.559798: nvme_tcp_queue_rq:
>  nvme1: qid=5 tag=25 op=0 data_len=32768
> kworker/4:2H-1873 [004] ..... 389.559799: nvme_tcp_queue_rq:
>  nvme1: qid=5 tag=24 op=0 data_len=32768
>
>
> [  419.790505] nvme nvme1: state: tag 0x28 io_cpu 4 smp_id 4 smp_id2 4 sync 1
>  empty 1 lock 1 last 0 more 0 send 1 send_ret 72 send_flags 0x28040
> [  419.790299] nvme nvme1: state: tag 0x27 io_cpu 4 smp_id 4 smp_id2 0 sync 1
>  empty 1 lock 1 last 0 more 0 send 1 send_ret 72 send_flags 0x28040
> [  419.789809] nvme nvme1: state: tag 0x25 io_cpu 4 smp_id 4 smp_id2 4 sync 1
>  empty 0 lock 0 last 0 more 1 send 1 send_ret 72 send_flags 0x28040
> [  419.790065] nvme nvme1: state: tag 0x26 io_cpu 4 smp_id 4 smp_id2 4 sync 1
>  empty 0 lock 0 last 0 more 1 send 1 send_ret 72 send_flags 0x28040
> [  419.789663] nvme nvme1: state: tag 0x24 io_cpu 4 smp_id 4 smp_id2 4 sync 1
>  empty 0 lock 0 last 1 more 1 send 1 send_ret 72 send_flags 0x28040

Additional tracing suggests it could be a race or issue with
queue->more_requests.

[  675.762509] nvme nvme1: state: tag 0x5f io_cpu 1 smp_id 1 smp_id2 1 sync 1
  empty 1 lock 1 last 0 more 0 send 1 send_ret 72 send_flags 0x28040
  q_send_list 0 q_req_list 0 q_more_requests 1
[  675.720866] nvme nvme1: state: tag 0x5e io_cpu 1 smp_id 1 smp_id2 5 sync 1
  empty 1 lock 1 last 0 more 0 send 1 send_ret 72 send_flags 0x28040
  q_send_list 0 q_req_list 0 q_more_requests 1
[  675.679256] nvme nvme1: state: tag 0x5d io_cpu 1 smp_id 1 smp_id2 1 sync 1
  empty 0 lock 0 last 0 more 1 send 1 send_ret 72 send_flags 0x28040
  q_send_list 1 q_req_list 0 q_more_requests 1
[  675.621054] nvme nvme1: state: tag 0x5c io_cpu 1 smp_id 1 smp_id2 1 sync 1
  empty 0 lock 0 last 0 more 1 send 1 send_ret 72 send_flags 0x28040
 q_send_list 1 q_req_list 0 q_more_requests 1
[  675.593414] nvme nvme1: state: tag 0x5a io_cpu 1 smp_id 1 smp_id2 1 sync 1
  empty 0 lock 0 last 1 more 1 send 1 send_ret 72 send_flags 0x28040
  q_send_list 0 q_req_list 0 q_more_requests 1

