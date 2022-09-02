Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9D8ECAAD5
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Sep 2022 13:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kc7MD3vwQjwW5tIa6EOiXPJosi9jFwiRxk6g3yTCQdc=; b=0NtL40HwV/4gcJtQIxTWE8mJD9
	0K1C+L/IYJGip/l2bibwd9okS/xMhuMdkMf3kQAu4liAU2fLQC2F8wQHryVi9NeZIlvulXILAb+/B
	Ql8CMg4GV3F5h71Ft2A+mPqcdFXVPJBaAIS1A0EIxy1pOrdMf1b7K5xImKLlZr0C3TnCLPzwTc2oV
	DZ+H+VQALbJz311h5430QLE8PwhMffuDuf+ExQiBqcv5GKJEf/vEo0UmSGn6dWH8OTpLAY/sLBBFI
	eF3V67LfMchtQae3DMv1FedWH+mBj0e8aabbAWCnaZTxAgpakmDq+QgbXI9zvmXWiai7yHkRxvtcv
	2FuwCQYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oU72C-005Fir-Cw; Fri, 02 Sep 2022 13:48:36 +0000
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oU729-005FZR-Ux
	for linux-nvme@lists.infradead.org; Fri, 02 Sep 2022 13:48:35 +0000
Received: by mail-yb1-xb32.google.com with SMTP id 130so3160677ybw.8
        for <linux-nvme@lists.infradead.org>; Fri, 02 Sep 2022 06:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Kc7MD3vwQjwW5tIa6EOiXPJosi9jFwiRxk6g3yTCQdc=;
        b=L5W4qk6PrGtnvXCEZUooExRIWfiHmTobZz4jAWp8e4ARTEcHtCowVnV8O5WbSljLt9
         xiT14Q0T0XmOYeS86lqLyTMPtyC5DYWMQPG8HPTAZYdkfq/Ul/KbVRFkPjmPEoFcmGWa
         EQ7JUv62T5uRcRh/zGGOYN+nBfcPxA2Sb1rt52Ioj+ekGQH4UJZfEyj/K/GZZNiN5FEp
         8rUlxROhnVf19N21k2hoQqiFbPfY/HrLtaVWi4yaF429bp7eAwEe4Jc2PLga7uk+rwkz
         b2z6byEgCcQ1c68L2C7zamryOZinPUA3ms39Yy8f5oKUIVilqWnpXDByJiDSbh2PcuSC
         Ef1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Kc7MD3vwQjwW5tIa6EOiXPJosi9jFwiRxk6g3yTCQdc=;
        b=GiZWIr83XgD63uLl64k4oknl/Psd9YMx6RFVPkHw1rj7stkwZMDL+9cQsR+xZtMupw
         iUyCqslfME8Nb1hhxqrKPQauv/7Qa9AqjT9d0g3ORJAxo58YQ/1pIIyqGtm2Lbk90yAI
         FDwMVfFG5u6QTcHIt9PnmnpHT5QVuhzqSdgFSnThlf6WkXiijXEG1XA0IyQuUV+TFVnY
         4uSaspz5V0PSAxpn06HhgtMgQAzmCoKf+/Kt6LoGb55t7gc3sRAaao/r1KFT0yGQqScO
         55us+95ymI/TaKGbZjqbtFqxo2cKAMeIP7Ip6ilFTYfwlE6ocCQbVRMde2PMZzmzx94q
         DScw==
X-Gm-Message-State: ACgBeo1FyAzGxd5Gp/KBw+3A0Uo7yoLcG/tD19XzzhSja9xZ3VZXGFF/
	O4UjBRVfDiL/gVsCMj4lJMnfbh4bEbIMRnsLQ5n3Yw==
X-Google-Smtp-Source: AA6agR76rO/zLv2yvFNyNpNiGQTuOfEIwVKAgaum4VMn2lwgjREYRySJUwNlx97dRhDm5EP4u3JVVqz8ukacDhhYdwg=
X-Received: by 2002:a25:40c9:0:b0:69a:ba91:9fc with SMTP id
 n192-20020a2540c9000000b0069aba9109fcmr20111579yba.443.1662126495107; Fri, 02
 Sep 2022 06:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHex0cqr8Sn1ydFjRbwkG8LOMqBXEHL2YpYu_vO8658xLzouww@mail.gmail.com>
 <eb6b09b6-c899-e3b8-3217-02f8833818cd@grimberg.me> <CAHex0coajr37Xe_XE3sx+kgNosOD_d8N_SQcK=hT4NDAM8suBg@mail.gmail.com>
 <ca7d5545-4630-59eb-3e50-6ca0594ba7c7@grimberg.me> <CAHex0coXdbR28S1PPSGuqJRH2JFZ4VpTg8NzfWFpHyBehK2urw@mail.gmail.com>
 <CAHex0cqVOuSXf759Wdr3NS5gGCve+J-TUSNsvvbEpS7ONvFhMw@mail.gmail.com>
 <715a183c-f888-74f2-9217-b9b430f16d1e@grimberg.me> <CAHex0crz1FGrQKnWCrWTCWJ_GsMn5iMmNMtq-BN+nDDUajshdg@mail.gmail.com>
 <CAHex0co9JNwFkDpNvPitESYX6-2F8_n8phxzVsZFq2kieYLGJQ@mail.gmail.com>
 <CAHex0cr80EyJXN1gOgEXF9r=_Y8Z5N6=jxw=je_8Px3vab+qtg@mail.gmail.com>
 <376e2073-439b-7113-48f4-862d3404c328@grimberg.me> <CAHex0cq-YzgKVH6RazgPRFi0mJ7n+CsS+Cr-NqLEszZGen8dKg@mail.gmail.com>
 <CAHex0co8NidmjzMoeQp8GXy8t6B9cJCA-DoSwO-H5Prae=ZSMg@mail.gmail.com>
In-Reply-To: <CAHex0co8NidmjzMoeQp8GXy8t6B9cJCA-DoSwO-H5Prae=ZSMg@mail.gmail.com>
From: Jonathan Nicklin <jnicklin@blockbridge.com>
Date: Fri, 2 Sep 2022 09:47:39 -0400
Message-ID: <CAHex0cpGJoq7Lf-VgtT3hnUZhLLoenGqK3OTqTKkPg8UpjaDuw@mail.gmail.com>
Subject: Re: nvme-tcp: i/o errors and stalled host from failure to send
 command pdus
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220902_064834_033401_9E211C62 
X-CRM114-Status: GOOD (  24.00  )
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

On Thu, Sep 1, 2022 at 6:56 PM Jonathan Nicklin
<jnicklin@blockbridge.com> wrote:
>
> On Thu, Sep 1, 2022 at 1:46 PM Jonathan Nicklin
> <jnicklin@blockbridge.com> wrote:
> >
> > nvme_tcp_queue_more() reads queue->mode_requests. So, I supposed
> > nvme_tcp_queue_request() is an example where queue->more_requests gets
> > read without the send_mutex? queue_work_on() is conditionalized on this.
> >
> > Apologies in advance if I'm misunderstanding the code.
> >
> > On Thu, Sep 1, 2022 at 1:02 PM Sagi Grimberg <sagi@grimberg.me> wrote:
> > >
> > >
> > > > Question: queue->more_requests is updated under a lock. However, not
> > > > all readers of queue->more_requests acquire the lock. The smp_id/smp_id2
> > > > values seem to show that the same queue was being processed on
> > > > different CPUs. Is this a race between the kworker and inline
> > > > submission?
> > >
> > > The entire send path in io_work is wrapped with the send_mutex. Which
> > > part is not protected with the lock?
>
> Okay, maybe some progress?! What appears to be happening is that
> the request marked "last" is being picked up via nvme_tcp_send_all() when
> processing the previous command. Consider another trace:
>
>                  CPU
> tar-2263    [004] .....   680.671184: nvme_tcp_queue_rq: nvme1: qid=5
> tag=5e op=0 data_len=16384
> tar-2263    [004] .....   680.671185: nvme_tcp_cmd_pdu: nvme1: qid=5
> tag=5e op=0 page_offset=1352 send_len=72
> tar-2263    [004] .....   680.671186: nvme_tcp_queue_rq: nvme1: qid=5
> tag=5d op=0 data_len=32768
> tar-2263    [004] .....   680.671186: nvme_tcp_cmd_pdu: nvme1: qid=5
> tag=5d op=0 page_offset=1424 send_len=72
> tar-2263    [004] .....   680.671186: nvme_tcp_queue_rq: nvme1: qid=5
> tag=5c op=0 data_len=32768
> tar-2263    [004] .....   680.671187: nvme_tcp_cmd_pdu: nvme1: qid=5
> tag=5c op=0 page_offset=1496 send_len=72
> tar-2263    [004] .N...   680.671188: nvme_tcp_queue_rq: nvme1: qid=5
> tag=5b op=0 data_len=32768
> tar-2263    [004] .N...   680.671189: nvme_tcp_cmd_pdu: nvme1: qid=5
> tag=5b op=0 page_offset=1568 send_len=72
> kworker/4:0H-38 [004] .....   680.671198: nvme_tcp_queue_rq: nvme1:
> qid=5 tag=5a op=0 data_len=16384
> tar-2263        [000] .....   680.671199: nvme_tcp_cmd_pdu: nvme1:
> qid=5 tag=5a op=0 page_offset=1640 send_len=72
>
> I've added some additional state to the request to print out on
> timeout. First, queue->more_requests now tracks the command tag
> that asserted more_requests. Second, I recorded the number of commands
> issued via nvme_tcp_send_all(). As you can see, when tag 0x5b was
> issued, it ended up sending 0x5a as well. More_requests was asserted
> by 0x5b when nvme_tcp_try_send_cmd_pdu() processed 0x5a, so we never
> actually pushed it out onto the wire.
>
> [  709.457051] nvme nvme1: state: tag 0x5e io_cpu 4 smp_id 4 smp_id2 4 sync 1
>  empty 1 lock 1 last 0 more 0 send 1 send_ret 72 send_flags 0x28040
> q_send_list 0
>  q_req_list 0 q_more_requests 0x5e req_sent 1
> [  709.414327] nvme nvme1: state: tag 0x5d io_cpu 4 smp_id 4 smp_id2 4 sync 1
>  empty 1 lock 1 last 0 more 0 send 1 send_ret 72 send_flags 0x28040
> q_send_list 0
>  q_req_list 0 q_more_requests 0x5d req_sent 1
> [  709.371665] nvme nvme1: state: tag 0x5c io_cpu 4 smp_id 4 smp_id2 4 sync 1
>  empty 1 lock 1 last 0 more 0 send 1 send_ret 72 send_flags 0x28040
> q_send_list 0
>  q_req_list 0 q_more_requests 0x5c req_sent 1
> [  709.312298] nvme nvme1: state: tag 0x5b io_cpu 4 smp_id 4 smp_id2 0 sync 1
>  empty 1 lock 1 last 0 more 0 send 1 send_ret 72 send_flags 0x28040
> q_send_list 0
>  q_req_list 0 q_more_requests 0x5b req_sent 2 !!!
> [  709.283534] nvme nvme1: state: tag 0x5a io_cpu 4 smp_id 4 smp_id2 4 sync 1
>  empty 0 lock 0 last 1 more 1 send 1 send_ret 72 send_flags 0x28040
> q_send_list 0
>  q_req_list 0 q_more_requests 0x5b !!! req_sent 0

I'm not quite sure of all of the mechanics of command submission... but it
looks like if we are preempted in nvme_tcp_queue_request(), subsequent commands
pile up on the req_list. When rescheduled, we drain the req_list with
more_reqests set, which prevents us from pushing the bits onto the wire.

Take notice of the "N" flag in the traces and the fact that the
starting cpu "smp_id" is different from the ending cpu "smp_id2" for
the associated tag.

