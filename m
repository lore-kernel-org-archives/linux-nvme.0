Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34969ECAAD3
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Sep 2022 12:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TfgI/7MgYi984ZJwKtq0zAJhXHQAHq2c7r+wAra1Gus=; b=vOzXWWwQ6h9zUPfwaJiaLJporX
	RZWoDjMEcphvXeUyV0a39WYbnC6lQP2fw5EtRAEj/RRlcNnWrzpw+gqi1QlSuGgPKUG9MR4vkVD1N
	gARYpGMTfCMLoaLqUIi+gIli75nkFBMVz7KSDs+1Et8Lxwb7BbFeBntzT/jijsfrb4+xeJk5zOj+y
	VdO59fowFkJ01HHj+kGJCcdIb13nbxZHk8pRpUMpZ/YmIXv0SETurbZYSzNvsajSuL3mK2GZtbC00
	zKRwLp7Jj4b+UAwnkAmLOlE/Jhiyykb2sHX9mQVsdhFR6F72mLUOdeNC5HTpIBIIvH201zBNy4Grd
	Fivyxzgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTjSa-00BkGy-EI; Thu, 01 Sep 2022 12:38:16 +0000
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTjST-00BkFj-W7
	for linux-nvme@lists.infradead.org; Thu, 01 Sep 2022 12:38:14 +0000
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-33dc31f25f9so335062287b3.11
        for <linux-nvme@lists.infradead.org>; Thu, 01 Sep 2022 05:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TfgI/7MgYi984ZJwKtq0zAJhXHQAHq2c7r+wAra1Gus=;
        b=rxUOk0Y5l0k934OAIBpplZ/ICkXQVazPzzpmiRnLdO4HoHu5npr7/EX9Epb/NYLvwR
         BaPU9Vf9pV7Ko0X+BfejBstYnqo9s50EF+xRkGW670iIiLnaW39JP2kisn2/VTdSqPR5
         nMEKuRvHPzEVsVhE3YMIKR3HAheVdYC7x6G1Vw3KGqk7DJIZ3fEvOpiddoYZhciT5BZg
         9rtHyYf1IGHyIUiq2yT3j/J57FWkouAzgQg2S3CiTM3vv/E5rGM/JT/UMKvfYjqH+onp
         kbz0mERZCLPYwDjztAd27wKcg+7UOe7c1cu+OpbD7meABipZR1GDcPFzZbB1ySmJuCT9
         vLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TfgI/7MgYi984ZJwKtq0zAJhXHQAHq2c7r+wAra1Gus=;
        b=6QNj4PUPNvhsP1zwRlCpe0ZFVCflWI/mSedJgO8eFBO1fOjR7gIq2v15uT6g+BJzLq
         5vWsETe1XyV7HjohoNKNXZP8PMZdpKO5cp6gBZ+VN5P0KuIozDr57T16xrQfRz2pmSIN
         atsulgVYKhh+q/208Y81tIm1QTuDgWGOmCnL8G5Dijm4IsYsBS6TWQW7KeQXkU3/F6sv
         KLet9/9l55yWK8Ly62ZcxTTk7qqAfU0QgTsQQHXFV9a3N0L4yD7qu/6F8UIYdiQZOF13
         LvU/94weKzpnWyNhEN6t51M6q0uvx4IY4EBoZJoO7Gk/QrrCoV+cy4/VrzhPV0+JNSjP
         hLHQ==
X-Gm-Message-State: ACgBeo2GF9UFY6McXp475w1ayLtMPYQvaGQW+D8khw8cesNZA/JuFqnJ
	H84BqkvhhnyH9K5++YqpuSUctOStZHxzMRESDF3v7/5dEQYxers0
X-Google-Smtp-Source: AA6agR6mE3ciWTyJlugAzq+K0a/9Po4ufV7Rv2r2wrvuAVBROmk16dNTegLSKtrSNo+OyvuKPS2E3ritLBTK++hWDd8=
X-Received: by 2002:a81:a008:0:b0:33d:8599:f7a with SMTP id
 x8-20020a81a008000000b0033d85990f7amr22560620ywg.478.1662035885716; Thu, 01
 Sep 2022 05:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHex0cqr8Sn1ydFjRbwkG8LOMqBXEHL2YpYu_vO8658xLzouww@mail.gmail.com>
 <eb6b09b6-c899-e3b8-3217-02f8833818cd@grimberg.me> <CAHex0coajr37Xe_XE3sx+kgNosOD_d8N_SQcK=hT4NDAM8suBg@mail.gmail.com>
 <ca7d5545-4630-59eb-3e50-6ca0594ba7c7@grimberg.me> <CAHex0coXdbR28S1PPSGuqJRH2JFZ4VpTg8NzfWFpHyBehK2urw@mail.gmail.com>
 <CAHex0cqVOuSXf759Wdr3NS5gGCve+J-TUSNsvvbEpS7ONvFhMw@mail.gmail.com> <715a183c-f888-74f2-9217-b9b430f16d1e@grimberg.me>
In-Reply-To: <715a183c-f888-74f2-9217-b9b430f16d1e@grimberg.me>
From: Jonathan Nicklin <jnicklin@blockbridge.com>
Date: Thu, 1 Sep 2022 08:37:30 -0400
Message-ID: <CAHex0crz1FGrQKnWCrWTCWJ_GsMn5iMmNMtq-BN+nDDUajshdg@mail.gmail.com>
Subject: Re: nvme-tcp: i/o errors and stalled host from failure to send
 command pdus
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_053810_097268_99B87668 
X-CRM114-Status: GOOD (  18.74  )
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

On Wed, Aug 31, 2022 at 7:42 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >
> > Here's a trace including state from nvme_tcp_try_send_cmd_pdu(), like so.
> >
> > req->dbg.send = 1;
> > ret = kernel_sendpage(queue->sock, virt_to_page(pdu), offset, len, flags);
> > req->dbg.sendpage = ret;
> >
> >
> > nvme-trace.out
> >
> > tar-1785    [005] .....   232.768892:nvme_tcp_queue_rq:
> >   nvme1: qid=6 tag=18 op=0 data_len=20480
> > tar-1785    [005] .....   232.768894: nvme_tcp_queue_rq:
> >   nvme1: qid=6 tag=17 op=0 data_len=32768
> > tar-1785    [005] .N...   232.768895: nvme_tcp_queue_rq:
> >   nvme1: qid=6 tag=14 op=0 data_len=32768
> > kworker/5:1H-475     [005] .....   232.768923: nvme_tcp_queue_rq:
> >   nvme1: qid=6 tag=13 op=0 data_len=32768
> > kworker/5:1H-475     [005] .....   232.768924: nvme_tcp_queue_rq:
> >   nvme1: qid=6 tag=12 op=0 data_len=12288
> > tar-1785    [007] .....   232.769141: nvme_tcp_queue_rq:
> >   nvme1: qid=8 tag=69 op=0 data_len=20480
> >
> >
> > dmesg.out (reordered to match nvme-trace.out)
> >
> > [  262.889536] nvme nvme1: state: tag 0x18 io_cpu 5 smp_id 5 smp_id2 5 sync 1
> >   empty 1 lock 1 last 0 more 0 send 0 sendpage -1
>
> Something is not adding up...
> lock=1, means that we get into nvme_tcp_send_all(), but somehow we are
> not able to send it to the wire?
>
> I'd look into this and add indication that it is pulled from the
> req_list, and in turn from the send_list. It looks like it is somehow
> picked out and silteny dropped, because as long as it is on the list(s)
> another context should have picked it up at some point...
>
> > [  262.889337] nvme nvme1: state: tag 0x17 io_cpu 5 smp_id 5 smp_id2 5 sync 1
> >   empty 1 lock 1 last 0 more 0 send 0 sendpage -1
> > [  262.889110] nvme nvme1: state: tag 0x14 io_cpu 5 smp_id 5 smp_id2 7 sync 1
> >   empty 1 lock 1 last 0 more 0 send 0 sendpage -1
> > [  262.888864] nvme nvme1: state: tag 0x13 io_cpu 5 smp_id 5 smp_id2 5 sync 1
> >   empty 0 lock 0 last 0 more 1 send 1 sendpage 72
> > [  262.888727] nvme nvme1: state: tag 0x12 io_cpu 5 smp_id 5 smp_id2 5 sync 1
> >   empty 0 lock 0 last 1 more 1 send 1 sendpage 72

Ugh. It was misleading because the send state tracking was
re-initialized after the direct send case. Here's a better trace with
more information. It appears as though sendpage() is always called
with the NOTLAST flag set. I suppose this could mean that there is
some confusion or race with nvme_tcp_queue_more()?

tar-1872          [004] ..... 389.559784: nvme_tcp_queue_rq:
 nvme1: qid=5 tag=28 op=0 data_len=16384
tar-1872          [004] .N... 389.559786: nvme_tcp_queue_rq:
 nvme1: qid=5 tag=27 op=0 data_len=16384
kworker/4:2H-1873 [004] ..... 389.559798: nvme_tcp_queue_rq:
 nvme1: qid=5 tag=26 op=0 data_len=32768
kworker/4:2H-1873 [004] ..... 389.559798: nvme_tcp_queue_rq:
 nvme1: qid=5 tag=25 op=0 data_len=32768
kworker/4:2H-1873 [004] ..... 389.559799: nvme_tcp_queue_rq:
 nvme1: qid=5 tag=24 op=0 data_len=32768


[  419.790505] nvme nvme1: state: tag 0x28 io_cpu 4 smp_id 4 smp_id2 4 sync 1
 empty 1 lock 1 last 0 more 0 send 1 send_ret 72 send_flags 0x28040
[  419.790299] nvme nvme1: state: tag 0x27 io_cpu 4 smp_id 4 smp_id2 0 sync 1
 empty 1 lock 1 last 0 more 0 send 1 send_ret 72 send_flags 0x28040
[  419.789809] nvme nvme1: state: tag 0x25 io_cpu 4 smp_id 4 smp_id2 4 sync 1
 empty 0 lock 0 last 0 more 1 send 1 send_ret 72 send_flags 0x28040
[  419.790065] nvme nvme1: state: tag 0x26 io_cpu 4 smp_id 4 smp_id2 4 sync 1
 empty 0 lock 0 last 0 more 1 send 1 send_ret 72 send_flags 0x28040
[  419.789663] nvme nvme1: state: tag 0x24 io_cpu 4 smp_id 4 smp_id2 4 sync 1
 empty 0 lock 0 last 1 more 1 send 1 send_ret 72 send_flags 0x28040

