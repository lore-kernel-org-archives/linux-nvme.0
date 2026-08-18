Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C79C5DF67
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2026 03:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IfH7c8kTzp6wH0vAYWfww4deq65sIQ786Q6YWOnOtGI=; b=cJR5hK2d8up1nPfFPUJPPvSn6s
	a4eIEG+n76PWUJusoTWFsAia+L4FTIZ15Q+4Em5M5R4GdyFOGgmQj9Xu4RrmPd1P8XFPEtgXMOdtv
	2C0dGA15YrBQIAT0SNbdJbNIpI8psj9WIZ1ijsaNxlFqJzCUpwZgoHJPRpGGzZ0XyMWELIR96B6qZ
	3KNp9+R1DJ6/qjowgxGmgEZlP3Ui5Ab8zr5TJfftW2XXFnTRkhDpM5l3wv38wjVml8LhH2AMIehkQ
	4s6482R+4R6HNVkSthRHUT2cAlinlbUUuI5NgMUHeEMLNzTaRpdBbn6oZrlV5gKYnyZRjZi7T4HCr
	QWDuboPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwADe-000000079lb-19tI;
	Tue, 18 Aug 2026 03:10:30 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwADb-000000079lD-0VWU
	for linux-nvme@lists.infradead.org;
	Tue, 18 Aug 2026 03:10:28 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2cace91f112so48310775ad.0
        for <linux-nvme@lists.infradead.org>; Mon, 17 Aug 2026 20:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1787022625; x=1787627425; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IfH7c8kTzp6wH0vAYWfww4deq65sIQ786Q6YWOnOtGI=;
        b=Sf6sUn5IqrDM+7piOMWgjKPlvTBM68YjmcsY5g8knHKOWdiccIZZXakcbbjJcWn/0C
         PYkmp/3fjCe3GzcXLC8T1yXhr3Dvrixo+mAMcts+RtZPYGHTr4EEtIlEVhkgsQKhglQG
         aCxXYiFQakS4RJHn1vJV2AqSHqXPTi713BOyoEN8g+bQIRG+0c5c1O0QsdJxK8d+vcqn
         glkDetDpznbHiihEX9DuN6hHC2gLX7t/I0OwcDE84z+yc6NCi0viamSOa79CG6V7QonS
         F8HrIK22SZXamr9dQtq2ZUEaMLeh5wB99bxjeL8U3b53NUb5c2QnLNt4RUGqYyGA2YbO
         X2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787022625; x=1787627425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IfH7c8kTzp6wH0vAYWfww4deq65sIQ786Q6YWOnOtGI=;
        b=H5N8FAirFJY/PcNji3wCA0wql2lf9psYWzCZ1dcn15B0EGYEYCHP99lNMdLbZ34HOq
         8SRZcffhp4rSg6RvMqgM63WCTsIneEBpWDhu/w5oLZ32QfNnhdFutM16L1MLXsDjx0cQ
         PDlWplZRkelD5FFBLfzQ+gO9YqjSJ8llfxJhJTZUYOU/WTRhImv1Y02ak1gwbSlDNfDK
         i7sFQKt0t7gb++Y0h3Nv7kdsZC65Zz4VU5mtLMoFaw1qL95inSCH5/hk0v4idxysikYi
         rJaxujI4okekSYtqmiicUChk/Vz2V6vIFx+1eaznIbj1fD024vKs6czifF1Ke/YLnERu
         NrVw==
X-Forwarded-Encrypted: i=1; AHgh+RoF3wFFtvheLMNT2pEY+GOZ3lf8GAQv8oAKI6V7P4W+vW7i4W/vtdIAEamXeRsVcxMPvBUubEE40gvH@lists.infradead.org
X-Gm-Message-State: AOJu0Yzkh/cNFApDgFRH1b9TjK0awl2I+oCtTGTwwrMS8wSZqVmq2PF5
	MeOsWpcc2qx7CYDzbrDtGTgjS77/p0KSGnBu7aazQxX3qIz571XugL4pvQIbfJ84k6E=
X-Gm-Gg: AR+sD13jEa1mLJ0MXAbt7GZ05P/+2ets0SaNBc1CjCgqtZ6wgkcvlbWe2QQgdMatCWG
	L59hDjZ1AmjymYm07AYjziC4LlKGs3eKkkFOR9CyRbS3benKq0MNTwF3AtLqiTgLmNFFH1Y9aip
	4ZEsDZUTmS1ZqqEoRS0A5h1IFiEPCJfvK5HOES/8hdroGtiOQS2c8nlTi/017GIgvToufMzfO7d
	K6J4twjnZuTalpKtc8fqqUh7QNpB8hzn+fylMy5yKNdmi8U2s2SxdgXK/yj2T6Vg8qzjAjUYF96
	rN1FT3ESm3q6tzTej03Fr5DzLzIqPJf+HEmxnKgwQzek7s+cG1psaddSnPO/mKUepL6tgs/tuvM
	pRpY235UHe6hVceJVDeWVVXWl0eomZkLs+wF9RVJeOab/SIzQTofMVbESkby4XAS03KFLQBO4T5
	2V/vOzB0Rm9YjAuZ7Pb2sesNGiGtaWvzsvTV5o0dXT4qjxtW4WeB4fOpwN5dmGRKEiq5G6pyW9t
	5oceHsMdtPNPkS+d3yOI/hr6i4r+o9LFw==
X-Received: by 2002:a17:903:1b4d:b0:2d0:cc92:f7af with SMTP id d9443c01a7336-2d3b0de7f65mr350843165ad.9.1787022625295;
        Mon, 17 Aug 2026 20:10:25 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([67.208.231.220])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3267be8e272sm10327083eec.17.2026.08.17.20.10.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Aug 2026 20:10:24 -0700 (PDT)
From: Saravanan D <saravanand@crusoe.ai>
To: Christoph Hellwig <hch@lst.de>
Cc: Saravanan D <saravanand@crusoe.ai>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: pin io_cpu to submitter cpu
Date: Mon, 17 Aug 2026 20:09:57 -0700
Message-ID: <20260818031010.98141-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817075743.GA20887@lst.de>
References: <20260806023947.94680-2-saravanand@crusoe.ai> <20260817075743.GA20887@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_201027_195742_F2FFE52E 
X-CRM114-Status: GOOD (  22.89  )
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

On Mon, 17 Aug 2026 09:57:44 +0200 Christoph Hellwig <hch@lst.de> wrote:

> On Wed, Aug 05, 2026 at 07:39:44PM -0700, Saravanan D wrote:
> > Adopt the submitting CPU of non passthrough requests as io_cpu. The
> > submitter is a member of the map group by construction, and the
> > nvme_tcp_cpu_queues accounting moves with each adoption. Passthrough
> > commands do not participate since the io queue Connect arrives from an
> > arbitrary group CPU via blk_mq_alloc_request_hctx(), so the first real
> > read or write decides.
>
> connect isn't the only passthrough command.  All your above reasoning
> would apply to at least user passthrough commands as well.  Maybe
> special casing connect is the better idea here?
>
Agreed. User passthrough commands are submitted from a real task on the
submitting CPU, so they should adopt like any other read or write.
Connect is the only passthrough command on an I/O queue that should
be skipped, since it is injected on an arbitrary CPU by
blk_mq_alloc_request_hctx().

For v2 I will drop the blk_rq_is_passthrough() guard and special case
connect.

        cmd = nvme_req(rq)->cmd;
        if (nvme_is_fabrics(cmd) &&
            cmd->fabrics.fctype == nvme_fabrics_type_connect)
                return;

so user passthrough I/O adopts normally.

> >
> > Queues outlive the workloads that submit through them, so adoption
> > re-arms after 30 seconds of queue quiet. An idle queue is reclaimed by
> > its next submitter, while a busy queue keeps a stable io_cpu and
> > cannot ping pong between two live submitters. Concurrent writers
> > on different CPUs serialize on a cmpxchg on io_cpu.
> >
> > The behavior is opt in via the new wq_adopt module parameter, default
> > off and runtime writable. wq_unbound takes precedence when both are
> > set.
>
> I think you want this as an option at queue connect time.  Any specific
> reason you picked the global module parameter?
>
>
No strong reason. I followed the wq_unbound precedent and the parameter
was handy to toggle at runtime while testing. An option at connect
time is the better fit as this falls under controller policy, so for
v2 I will add an NVMF_OPT_ fabrics option and gate on queue->ctrl->opts.
With this pivot, we can avoid flipping the policy on a live connection.

Thanks for the review.

