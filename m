Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E4FECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 13:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OdU3u6wzZmocp5tZSwYqltcmWHipqTKw0DDdD/SmmaY=; b=WrgiEa2q5B7iJJ3SOTkE1MPmp2
	CHTIf46wrXvy4crh79u7/eAHAkxjUjA8L9SN9jUtNgZJcDezIsTvViCVaIvCagaMPcEPB7lCAs7tR
	Z3ipBTwlcwsvuOQ+BIM1J2FoXZUyOouXJZ7a7vukj+TV6fVp8rj1KHk8fFX1pbpNMJEBuB0MWBBnv
	dtdsuPEQvLxGTvSikfXWrUM59+aRNfWqZ5XKEGeVrLemG2MTCyBByomVw9Iq//4ZJpQJ6RSEuhn3y
	yJ6sxZ8B1wbQ3inseGFD0vX3imYhe1QomHYh8vlWwjfzNMBlnrMirRaVdgGRBCzGJ+KYYyExHH0J3
	EHlJCCjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVYlm-00DsgS-Ep; Tue, 06 Sep 2022 13:37:38 +0000
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVYlc-00DsTP-DH
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 13:37:30 +0000
Received: by mail-yb1-xb34.google.com with SMTP id g5so16808378ybg.11
        for <linux-nvme@lists.infradead.org>; Tue, 06 Sep 2022 06:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=OdU3u6wzZmocp5tZSwYqltcmWHipqTKw0DDdD/SmmaY=;
        b=lJwDQe0Vnqq5O7cdI3o8+7A1FCgOdBaDFGHE0RPGwPR1IswVsJQqG5ewENqlUfqo+e
         nIwyGBPI18eEWySYZwI7EkCJ4u0Y5A1wUfOH8hsOD+Da37jX4Ya3B4S3ym8hsI4Q+RPp
         khvmeSkT7Tm5Zz8S3sfU29gOyE2WoUlHYxjeb43xW3FL+ZqJRX+VJzCO8d4ZvpEkb5Dc
         /QDmmXhL1oDc1nU/kldcA5VBpueEPvNitZI9rLnSKP5ZK+P6ioA9oz+dUD3JrFYP3bOA
         qcBehcoht2kCXVwXiWyxJp7xmahWviM8Cf4V9x9MtdAFZe+w7W84PIwG8ADU2BvYC2C6
         b57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=OdU3u6wzZmocp5tZSwYqltcmWHipqTKw0DDdD/SmmaY=;
        b=efMWgAzKXSrFaHR0nk/I+etw5N9w31B7jrO+SUmFDgtYDGJ5me0uqFUnr2leMXCL75
         gM9+9NHQQtHkyQElfN0XW7oEqOsa+r8TJ+1+HLoBsNJz96cpPM2DxHv3aeVoIHhmmj3K
         SmT8e8TlpHoPpJXc8LuAmzU2T46y9FMzdC+u9bav8Umms/U49hrKF2EOAqgi/znszIdC
         RICK84cg/gfWx55tRlit2ZYnGNtQ16tbS/bKibxCQ8EAyeFYqpUklHPaz5Zz1y29ClQU
         uJ4OrkH0OXls8Yo2QE6bduMkPBVrAPDoaMeWeTijTxWjwgqn0Atfq0Yd4cJRM+Blihtw
         8G3w==
X-Gm-Message-State: ACgBeo04W91AL/D+tvnGY2eEGmsJ/qQyh81rI3edi2v0MrNG3blka8WD
	2CmK12DR9+7247Qe+L6yUffCfsB9i7cFXGLcIxKa4DEUPS3xBzO3
X-Google-Smtp-Source: AA6agR6YfvNcxRKrfUwhZxga34wHPLCgiRYJgNqdRdz4dypgxldhSGnl8FIUkJwRiF7yZNTBAYK1lStkghJyAEk4gNM=
X-Received: by 2002:a05:6902:572:b0:67c:2af2:3a75 with SMTP id
 a18-20020a056902057200b0067c2af23a75mr34959876ybt.346.1662471445263; Tue, 06
 Sep 2022 06:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHex0cqr8Sn1ydFjRbwkG8LOMqBXEHL2YpYu_vO8658xLzouww@mail.gmail.com>
 <CAHex0coajr37Xe_XE3sx+kgNosOD_d8N_SQcK=hT4NDAM8suBg@mail.gmail.com>
 <ca7d5545-4630-59eb-3e50-6ca0594ba7c7@grimberg.me> <CAHex0coXdbR28S1PPSGuqJRH2JFZ4VpTg8NzfWFpHyBehK2urw@mail.gmail.com>
 <CAHex0cqVOuSXf759Wdr3NS5gGCve+J-TUSNsvvbEpS7ONvFhMw@mail.gmail.com>
 <715a183c-f888-74f2-9217-b9b430f16d1e@grimberg.me> <CAHex0crz1FGrQKnWCrWTCWJ_GsMn5iMmNMtq-BN+nDDUajshdg@mail.gmail.com>
 <CAHex0co9JNwFkDpNvPitESYX6-2F8_n8phxzVsZFq2kieYLGJQ@mail.gmail.com>
 <CAHex0cr80EyJXN1gOgEXF9r=_Y8Z5N6=jxw=je_8Px3vab+qtg@mail.gmail.com>
 <376e2073-439b-7113-48f4-862d3404c328@grimberg.me> <CAHex0cq-YzgKVH6RazgPRFi0mJ7n+CsS+Cr-NqLEszZGen8dKg@mail.gmail.com>
 <CAHex0co8NidmjzMoeQp8GXy8t6B9cJCA-DoSwO-H5Prae=ZSMg@mail.gmail.com>
 <CAHex0cpGJoq7Lf-VgtT3hnUZhLLoenGqK3OTqTKkPg8UpjaDuw@mail.gmail.com>
 <7881a1cf-483c-3e70-18db-d02a5f8606fa@grimberg.me> <CAHex0cpMw1HEkSxdXsXTRtqw13PBVOmxGRtzyRBJai8nKAv+iA@mail.gmail.com>
 <7444389a-f52c-f7ed-3290-b209fb5f2acf@grimberg.me>
In-Reply-To: <7444389a-f52c-f7ed-3290-b209fb5f2acf@grimberg.me>
From: Jonathan Nicklin <jnicklin@blockbridge.com>
Date: Tue, 6 Sep 2022 09:36:49 -0400
Message-ID: <CAHex0cre4FLEKspyHvpRshLepbsK5ouXnnK6Lb1Oq7pS+Jfyeg@mail.gmail.com>
Subject: Re: nvme-tcp: i/o errors and stalled host from failure to send
 command pdus
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_063728_548436_5C6EB62E 
X-CRM114-Status: GOOD (  44.51  )
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

Not a problem. Is it possible to get this fix committed back into the last few
longterm kernels? It seems like anyone running nvme/tcp could benefit from
this fix.

On Mon, Sep 5, 2022 at 11:06 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
>
> On 9/5/22 17:54, Jonathan Nicklin wrote:
> > On Mon, Sep 5, 2022 at 4:50 AM Sagi Grimberg <sagi@grimberg.me> wrote:
> >>
> >>
> >>
> >> On 9/2/22 16:47, Jonathan Nicklin wrote:
> >>> On Thu, Sep 1, 2022 at 6:56 PM Jonathan Nicklin
> >>> <jnicklin@blockbridge.com> wrote:
> >>>>
> >>>> On Thu, Sep 1, 2022 at 1:46 PM Jonathan Nicklin
> >>>> <jnicklin@blockbridge.com> wrote:
> >>>>>
> >>>>> nvme_tcp_queue_more() reads queue->mode_requests. So, I supposed
> >>>>> nvme_tcp_queue_request() is an example where queue->more_requests gets
> >>>>> read without the send_mutex? queue_work_on() is conditionalized on this.
> >>>>>
> >>>>> Apologies in advance if I'm misunderstanding the code.
> >>>>>
> >>>>> On Thu, Sep 1, 2022 at 1:02 PM Sagi Grimberg <sagi@grimberg.me> wrote:
> >>>>>>
> >>>>>>
> >>>>>>> Question: queue->more_requests is updated under a lock. However, not
> >>>>>>> all readers of queue->more_requests acquire the lock. The smp_id/smp_id2
> >>>>>>> values seem to show that the same queue was being processed on
> >>>>>>> different CPUs. Is this a race between the kworker and inline
> >>>>>>> submission?
> >>>>>>
> >>>>>> The entire send path in io_work is wrapped with the send_mutex. Which
> >>>>>> part is not protected with the lock?
> >>>>
> >>>> Okay, maybe some progress?! What appears to be happening is that
> >>>> the request marked "last" is being picked up via nvme_tcp_send_all() when
> >>>> processing the previous command. Consider another trace:
> >>>>
> >>>>                    CPU
> >>>> tar-2263    [004] .....   680.671184: nvme_tcp_queue_rq: nvme1: qid=5
> >>>> tag=5e op=0 data_len=16384
> >>>> tar-2263    [004] .....   680.671185: nvme_tcp_cmd_pdu: nvme1: qid=5
> >>>> tag=5e op=0 page_offset=1352 send_len=72
> >>>> tar-2263    [004] .....   680.671186: nvme_tcp_queue_rq: nvme1: qid=5
> >>>> tag=5d op=0 data_len=32768
> >>>> tar-2263    [004] .....   680.671186: nvme_tcp_cmd_pdu: nvme1: qid=5
> >>>> tag=5d op=0 page_offset=1424 send_len=72
> >>>> tar-2263    [004] .....   680.671186: nvme_tcp_queue_rq: nvme1: qid=5
> >>>> tag=5c op=0 data_len=32768
> >>>> tar-2263    [004] .....   680.671187: nvme_tcp_cmd_pdu: nvme1: qid=5
> >>>> tag=5c op=0 page_offset=1496 send_len=72
> >>>> tar-2263    [004] .N...   680.671188: nvme_tcp_queue_rq: nvme1: qid=5
> >>>> tag=5b op=0 data_len=32768
> >>>> tar-2263    [004] .N...   680.671189: nvme_tcp_cmd_pdu: nvme1: qid=5
> >>>> tag=5b op=0 page_offset=1568 send_len=72
> >>>> kworker/4:0H-38 [004] .....   680.671198: nvme_tcp_queue_rq: nvme1:
> >>>> qid=5 tag=5a op=0 data_len=16384
> >>>> tar-2263        [000] .....   680.671199: nvme_tcp_cmd_pdu: nvme1:
> >>>> qid=5 tag=5a op=0 page_offset=1640 send_len=72
> >>>>
> >>>> I've added some additional state to the request to print out on
> >>>> timeout. First, queue->more_requests now tracks the command tag
> >>>> that asserted more_requests. Second, I recorded the number of commands
> >>>> issued via nvme_tcp_send_all(). As you can see, when tag 0x5b was
> >>>> issued, it ended up sending 0x5a as well. More_requests was asserted
> >>>> by 0x5b when nvme_tcp_try_send_cmd_pdu() processed 0x5a, so we never
> >>>> actually pushed it out onto the wire.
> >>>>
> >>>> [  709.457051] nvme nvme1: state: tag 0x5e io_cpu 4 smp_id 4 smp_id2 4 sync 1
> >>>>    empty 1 lock 1 last 0 more 0 send 1 send_ret 72 send_flags 0x28040
> >>>> q_send_list 0
> >>
> >> What is the difference between smp_id and smp_id2? where is each
> >> taken?
> >
> > smp_id2 is taken immediately after the direct send case (after unlock). It just
> > confirms that we were preempted and rescheduled.
> >
> > smp_id = raw_smp_processor_id();
> > if (queue->io_cpu == smp_id && sync && empty) {
> >          lock = mutex_trylock(&queue->send_mutex);
> >          if (lock) {
> >              nvme_tcp_send_all(queue, &sent);
> >              mutex_unlock(&queue->send_mutex);
> >          }
> > }
> > smp_id2 = raw_smp_processor_id();
>
> Got it.
>
> >
> >>
> >>>>    q_req_list 0 q_more_requests 0x5e req_sent 1
> >>>> [  709.414327] nvme nvme1: state: tag 0x5d io_cpu 4 smp_id 4 smp_id2 4 sync 1
> >>>>    empty 1 lock 1 last 0 more 0 send 1 send_ret 72 send_flags 0x28040
> >>>> q_send_list 0
> >>>>    q_req_list 0 q_more_requests 0x5d req_sent 1
> >>>> [  709.371665] nvme nvme1: state: tag 0x5c io_cpu 4 smp_id 4 smp_id2 4 sync 1
> >>>>    empty 1 lock 1 last 0 more 0 send 1 send_ret 72 send_flags 0x28040
> >>>> q_send_list 0
> >>>>    q_req_list 0 q_more_requests 0x5c req_sent 1
> >>>> [  709.312298] nvme nvme1: state: tag 0x5b io_cpu 4 smp_id 4 smp_id2 0 sync 1
> >>>>    empty 1 lock 1 last 0 more 0 send 1 send_ret 72 send_flags 0x28040
> >>>> q_send_list 0
> >>>>    q_req_list 0 q_more_requests 0x5b req_sent 2 !!!
> >>>> [  709.283534] nvme nvme1: state: tag 0x5a io_cpu 4 smp_id 4 smp_id2 4 sync 1
> >>>>    empty 0 lock 0 last 1 more 1 send 1 send_ret 72 send_flags 0x28040
> >>>> q_send_list 0
> >>>>    q_req_list 0 q_more_requests 0x5b !!! req_sent 0
> >>>
> >>> I'm not quite sure of all of the mechanics of command submission... but it
> >>> looks like if we are preempted in nvme_tcp_queue_request(), subsequent commands
> >>> pile up on the req_list. When rescheduled, we drain the req_list with
> >>> more_reqests set, which prevents us from pushing the bits onto the wire.
> >>>
> >>> Take notice of the "N" flag in the traces and the fact that the
> >>> starting cpu "smp_id" is different from the ending cpu "smp_id2" for
> >>> the associated tag.
> >>
> >> According to the trace, 0x5a came after 0x5b, and 0x5a was last=1, which
> >> means it should have cleared NOLAST and push it all down the wire,
> >> however it had it set.
> >>
> >> What happens here is that 0x5b execution sets queue->more_requests=true
> >> for the lifetime of its execution and that is wrong.
> >>
> >> To prove the theory can you try this patch?
> >> --
> >> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> >> index 3e3ebde4eff5..644def671df4 100644
> >> --- a/drivers/nvme/host/tcp.c
> >> +++ b/drivers/nvme/host/tcp.c
> >> @@ -121,7 +121,6 @@ struct nvme_tcp_queue {
> >>           struct mutex            send_mutex;
> >>           struct llist_head       req_list;
> >>           struct list_head        send_list;
> >> -       bool                    more_requests;
> >>
> >>           /* recv state */
> >>           void                    *pdu;
> >> @@ -320,7 +319,7 @@ static inline void nvme_tcp_send_all(struct
> >> nvme_tcp_queue *queue)
> >>    static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
> >>    {
> >>           return !list_empty(&queue->send_list) ||
> >> -               !llist_empty(&queue->req_list) || queue->more_requests;
> >> +               !llist_empty(&queue->req_list);
> >>    }
> >>
> >>    static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
> >> @@ -339,9 +338,7 @@ static inline void nvme_tcp_queue_request(struct
> >> nvme_tcp_request *req,
> >>            */
> >>           if (queue->io_cpu == raw_smp_processor_id() &&
> >>               sync && empty && mutex_trylock(&queue->send_mutex)) {
> >> -               queue->more_requests = !last;
> >>                   nvme_tcp_send_all(queue);
> >> -               queue->more_requests = false;
> >>                   mutex_unlock(&queue->send_mutex);
> >>           }
> >> --
> >>
> >> The downside here, is that commands now that are queued in a batch,
> >> will not have NOLAST set, which means that they will be sent directly
> >> to the wire...
> >>
> >> I'll need to think about the correct way to optimize for this case,
> >> however there is an argument that they might as well just be sent
> >> asap (i.e. give up batching).
> >>
> >> Alternatively, perhaps remember this in the lifetime of the command
> >> however this needs careful attention because network sends are also
> >> driven from r2t sent by the controller...
> >
> > I can confirm that ignoring queue->more_requests resolves the issue. I've run
> > about 300 iterations without issue. Pre-fix, the problem reproduced almost
> > immediately (1-3 runs).
>
> Thanks a lot Jonathan for reporting this issue and helping to resolve
> it. Appreciate the effort.
>
> I'll send a patch, can reply with your Tested-by tag?

