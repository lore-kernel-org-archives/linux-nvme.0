Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC341ECAAD2
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Sep 2022 22:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aMLxcRb321XDM/HR6/jCRx0a1s3QxrNEwmSaxEh5/z0=; b=yZ0sW7J8ftkcmxSNbhIleAtUNK
	PCXe2VWxrerSjy7Ar/7hvtW69Xn9iNVy+w0KN1DRGXVQnA942CWv/WJnVKWdvdlyTjQHKE4wc/cLt
	zIvx1YX4PEJ5tQD1iQT231fu1+6v52QZ6rOEY8/t7ljpufyNtq4QaMxaPHsR5jqMCSd1+3nPQwZsj
	A96PQ+32VghDDCFpkVyHYcJUw3HkJ/bB7POvky0hEUCfm/Hu4NNssF/iMb70WvPWBHiHNDKHR2mQz
	qZJNDUOYWkIZyboxF1E0Ip+JtBlsJ9reS0is75Hr8YijJiiYnog824FeYZc2mCbGtIUI5RD4uEGth
	U42Ld7aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTt7M-00FZEF-6K; Thu, 01 Sep 2022 22:57:00 +0000
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTt7J-00FZC7-1W
	for linux-nvme@lists.infradead.org; Thu, 01 Sep 2022 22:56:58 +0000
Received: by mail-yb1-xb30.google.com with SMTP id y197so805749yby.13
        for <linux-nvme@lists.infradead.org>; Thu, 01 Sep 2022 15:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=aMLxcRb321XDM/HR6/jCRx0a1s3QxrNEwmSaxEh5/z0=;
        b=omAy27mLiFpXiAbeLsiPq2wzIVPgmz3X3ZYal0ZbmtUAwXbxP4ipE0VtSyS51T5Fyd
         2ru9Ml3BMj66EKTNlv6gAb3/3XHLGTPTryiY+OWMb+g1QX5RDXbw9tI1mq+Y4uiOdJ3G
         rLsQvGd0jcDsjtSRPHaVTRA8k2dIgrlHZc0RJKMl1BfB9rOoHmrVDazwYT2/R8LGSJL6
         OchO84UuWeJP3+WNSwE0xOS4rjVfeDM6hFnEH38Q2NyimMVMQJ2fNAd/40auSzqrUy/I
         +e5F6gxPUgV8L9mJ8sjfLFU/NpaDn6GssBePbrlOMPZWordWrXVHSpTU0QAX3MDTLcPZ
         KoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=aMLxcRb321XDM/HR6/jCRx0a1s3QxrNEwmSaxEh5/z0=;
        b=rYrwUdKWk0KHrUaLJYl30lsUDkK/q/whRbC8kbxuduBFc7Mjj8JGg1UqMRaZPLt4YE
         Vebezh2gN8wjT/jbkVEG75m83Q/b0bqC3/NMDtVpavHf83y4nopLPzDgbw/w3tOj8Zhh
         0Gzv0mgpOfSm1jZrMvkmIBecazeGdFEHnCwgnKWV8IBUTrxSAttFlxzMcCNv4RZxePoX
         1zarX/brY+E94u/163TmJlpE7qChEvyl0FPNl3SyiSQOM72AJbCQ/RF7sDJ+b43+cBfu
         iKb0RFQ5QiyM9FS7xxiP2n1vEQDyz6InNf7Za3WhekelPQPUVqdVjxBr224iZ7GFJIhm
         3SxA==
X-Gm-Message-State: ACgBeo2D/eGX04R/J9U96hIHBth3hvwHSc1PdSloxVUF2EAeB7stDth4
	9+3y01Q95ljGl4EzDhubfRdAWQwtHxNQ3X5AhzjBug==
X-Google-Smtp-Source: AA6agR7ayOPOPBs5mvJtxkKLcz5V9HmFilVSePENjTItCyqodX+pMz0L8qZk/k3EaQhRYzAYxuWuMNk/faz+7FAWSUA=
X-Received: by 2002:a05:6902:572:b0:67c:2af2:3a75 with SMTP id
 a18-20020a056902057200b0067c2af23a75mr19849830ybt.346.1662073013914; Thu, 01
 Sep 2022 15:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHex0cqr8Sn1ydFjRbwkG8LOMqBXEHL2YpYu_vO8658xLzouww@mail.gmail.com>
 <eb6b09b6-c899-e3b8-3217-02f8833818cd@grimberg.me> <CAHex0coajr37Xe_XE3sx+kgNosOD_d8N_SQcK=hT4NDAM8suBg@mail.gmail.com>
 <ca7d5545-4630-59eb-3e50-6ca0594ba7c7@grimberg.me> <CAHex0coXdbR28S1PPSGuqJRH2JFZ4VpTg8NzfWFpHyBehK2urw@mail.gmail.com>
 <CAHex0cqVOuSXf759Wdr3NS5gGCve+J-TUSNsvvbEpS7ONvFhMw@mail.gmail.com>
 <715a183c-f888-74f2-9217-b9b430f16d1e@grimberg.me> <CAHex0crz1FGrQKnWCrWTCWJ_GsMn5iMmNMtq-BN+nDDUajshdg@mail.gmail.com>
 <CAHex0co9JNwFkDpNvPitESYX6-2F8_n8phxzVsZFq2kieYLGJQ@mail.gmail.com>
 <CAHex0cr80EyJXN1gOgEXF9r=_Y8Z5N6=jxw=je_8Px3vab+qtg@mail.gmail.com>
 <376e2073-439b-7113-48f4-862d3404c328@grimberg.me> <CAHex0cq-YzgKVH6RazgPRFi0mJ7n+CsS+Cr-NqLEszZGen8dKg@mail.gmail.com>
In-Reply-To: <CAHex0cq-YzgKVH6RazgPRFi0mJ7n+CsS+Cr-NqLEszZGen8dKg@mail.gmail.com>
From: Jonathan Nicklin <jnicklin@blockbridge.com>
Date: Thu, 1 Sep 2022 18:56:18 -0400
Message-ID: <CAHex0co8NidmjzMoeQp8GXy8t6B9cJCA-DoSwO-H5Prae=ZSMg@mail.gmail.com>
Subject: Re: nvme-tcp: i/o errors and stalled host from failure to send
 command pdus
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_155657_121602_6F164913 
X-CRM114-Status: GOOD (  18.11  )
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

On Thu, Sep 1, 2022 at 1:46 PM Jonathan Nicklin
<jnicklin@blockbridge.com> wrote:
>
> nvme_tcp_queue_more() reads queue->mode_requests. So, I supposed
> nvme_tcp_queue_request() is an example where queue->more_requests gets
> read without the send_mutex? queue_work_on() is conditionalized on this.
>
> Apologies in advance if I'm misunderstanding the code.
>
> On Thu, Sep 1, 2022 at 1:02 PM Sagi Grimberg <sagi@grimberg.me> wrote:
> >
> >
> > > Question: queue->more_requests is updated under a lock. However, not
> > > all readers of queue->more_requests acquire the lock. The smp_id/smp_id2
> > > values seem to show that the same queue was being processed on
> > > different CPUs. Is this a race between the kworker and inline
> > > submission?
> >
> > The entire send path in io_work is wrapped with the send_mutex. Which
> > part is not protected with the lock?

Okay, maybe some progress?! What appears to be happening is that
the request marked "last" is being picked up via nvme_tcp_send_all() when
processing the previous command. Consider another trace:

                 CPU
tar-2263    [004] .....   680.671184: nvme_tcp_queue_rq: nvme1: qid=5
tag=5e op=0 data_len=16384
tar-2263    [004] .....   680.671185: nvme_tcp_cmd_pdu: nvme1: qid=5
tag=5e op=0 page_offset=1352 send_len=72
tar-2263    [004] .....   680.671186: nvme_tcp_queue_rq: nvme1: qid=5
tag=5d op=0 data_len=32768
tar-2263    [004] .....   680.671186: nvme_tcp_cmd_pdu: nvme1: qid=5
tag=5d op=0 page_offset=1424 send_len=72
tar-2263    [004] .....   680.671186: nvme_tcp_queue_rq: nvme1: qid=5
tag=5c op=0 data_len=32768
tar-2263    [004] .....   680.671187: nvme_tcp_cmd_pdu: nvme1: qid=5
tag=5c op=0 page_offset=1496 send_len=72
tar-2263    [004] .N...   680.671188: nvme_tcp_queue_rq: nvme1: qid=5
tag=5b op=0 data_len=32768
tar-2263    [004] .N...   680.671189: nvme_tcp_cmd_pdu: nvme1: qid=5
tag=5b op=0 page_offset=1568 send_len=72
kworker/4:0H-38 [004] .....   680.671198: nvme_tcp_queue_rq: nvme1:
qid=5 tag=5a op=0 data_len=16384
tar-2263        [000] .....   680.671199: nvme_tcp_cmd_pdu: nvme1:
qid=5 tag=5a op=0 page_offset=1640 send_len=72

I've added some additional state to the request to print out on
timeout. First, queue->more_requests now tracks the command tag
that asserted more_requests. Second, I recorded the number of commands
issued via nvme_tcp_send_all(). As you can see, when tag 0x5b was
issued, it ended up sending 0x5a as well. More_requests was asserted
by 0x5b when nvme_tcp_try_send_cmd_pdu() processed 0x5a, so we never
actually pushed it out onto the wire.

[  709.457051] nvme nvme1: state: tag 0x5e io_cpu 4 smp_id 4 smp_id2 4 sync 1
 empty 1 lock 1 last 0 more 0 send 1 send_ret 72 send_flags 0x28040
q_send_list 0
 q_req_list 0 q_more_requests 0x5e req_sent 1
[  709.414327] nvme nvme1: state: tag 0x5d io_cpu 4 smp_id 4 smp_id2 4 sync 1
 empty 1 lock 1 last 0 more 0 send 1 send_ret 72 send_flags 0x28040
q_send_list 0
 q_req_list 0 q_more_requests 0x5d req_sent 1
[  709.371665] nvme nvme1: state: tag 0x5c io_cpu 4 smp_id 4 smp_id2 4 sync 1
 empty 1 lock 1 last 0 more 0 send 1 send_ret 72 send_flags 0x28040
q_send_list 0
 q_req_list 0 q_more_requests 0x5c req_sent 1
[  709.312298] nvme nvme1: state: tag 0x5b io_cpu 4 smp_id 4 smp_id2 0 sync 1
 empty 1 lock 1 last 0 more 0 send 1 send_ret 72 send_flags 0x28040
q_send_list 0
 q_req_list 0 q_more_requests 0x5b req_sent 2 !!!
[  709.283534] nvme nvme1: state: tag 0x5a io_cpu 4 smp_id 4 smp_id2 4 sync 1
 empty 0 lock 0 last 1 more 1 send 1 send_ret 72 send_flags 0x28040
q_send_list 0
 q_req_list 0 q_more_requests 0x5b !!! req_sent 0

