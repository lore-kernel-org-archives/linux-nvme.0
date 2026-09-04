Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022FBC624DE
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2026 16:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N1hoE3BcOuTiBC0ROHOK0Yvi5yLAEC063uLBYyUjYyI=; b=lpBgNHiJYcj3Qtsw23uKi4yidv
	Hp4UUfgW7RdO+jdQ2/A2qc7x0NpMPSNCdpcVAMNV+Izv7LSolsn8eLd0FL2mxwxh5B1mIF0WTw9m4
	qPVX04t0MngbmSRG/yDQmJAhZnjsNJqsDE7++wqUaXKWRNfqpBSEMeogVG7m2tBcySEpqx2c0O5uG
	ROP1XcYZk+1OAycg+sUCaOznNACgQ35V4r+tty6iYbLLmj4HzW4BtnFgd9yKv4v4T05pkzOptdqSU
	SBzV8fyLb4xrdLXWD56lPfgWhW4Rljfdt9YvTVz2NeblSgJJd8TDdxoUeSp75hUjsbkdG9lE7huUj
	FPkZBWMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2WR3-00000002fzN-10m7;
	Fri, 04 Sep 2026 16:06:37 +0000
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2WQy-00000002fxj-31U8
	for linux-nvme@lists.infradead.org;
	Fri, 04 Sep 2026 16:06:36 +0000
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-52d5bfa4bafso15870671cf.3
        for <linux-nvme@lists.infradead.org>; Fri, 04 Sep 2026 09:06:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788537991; cv=none;
        d=google.com; s=arc-20260327;
        b=XOw+hR6UE0zk2DVVPPbQOw6MSHbDboJ86yHbZMhr5bbw8UaVaFHCSZUr3Go5Td7KDH
         4FIn+9b3MfZkjHXpdZ5GstcdvR0jLMkpjYg1Kmhnf+A+HVrtrIFEftit3GFjIF/z68nE
         22tQYRndT1Lcdx/8gBZ+EkGs8ZDzf9NYgx0U++WOyE72LlvaXag8up/1qhffJJyRSqtu
         7hNQG0854b1VrRSITxM2+2tLN417UZz7+5QmfyxVtPlz4y9ZjFcpoomZCABnsSZPZ5Xf
         yN0XIrx9byoIfq3oYDTnrJsjoxbX2+WXtahO0miwHQZadzHkl0sNb64uM111LfCbG8S8
         Ra1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N1hoE3BcOuTiBC0ROHOK0Yvi5yLAEC063uLBYyUjYyI=;
        fh=PvQzzTv7m+IJ3biyD4lYld+IVEBmP0iLtPtHaU08TEc=;
        b=dsxfNuI/Rv8L5U29lkKtmH2zaHQBL4d60HN7IidictP5GohyryNhCKlDvGGbKf4t8h
         XSyCmTgOrw0cGq0lMWbHMj27QnwA+EYXc8sR4giljzQZMR++T2fQWnw462upKirYsZaF
         W0sJsv8nM/9xPF1dapwMvEPmOH++FrKKNj6KdxeJsnRCJ8ygjlZcDerf+hOT5n5h3TTS
         ovoJGjaC+amALP3Fw3rrsZZXHokkbsebHntq1YSebeEHVXO3M4SGsU7BOGRJBGOZhy3k
         iWipuKzOORVTRcnjgdl6VYr+iBZPd4D+oX3ZnI6IkHrhUlZzfhzd/VbNvVhb2InjLY7y
         yjNQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788537991; x=1789142791; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N1hoE3BcOuTiBC0ROHOK0Yvi5yLAEC063uLBYyUjYyI=;
        b=fe9OwlAYg5LnmFAiaqcfjp227ZUQyNDS3rOBqiVgu0K7Ic8HgzxUVKraVlLdwy9VXL
         AQ8ZXsboeX9nynlIWwn6bCSUNifq7bZc2p38x7KzXqTup337fmJzg99hTbDOY4S+B60H
         xriBEX0nFeeiUmrMTH/A90nOidPs6Fnj8uPjnvlQ+lE13M+wdPw+VvLQ9ZdoTcpO96Ys
         AY8sUOqpzF30UIjN/4OSGERVqUx1YIQCz08ymTMnLtSgE9RWfgm2vTqhjZwJ+G6WtVVq
         hf5DRpo0dYVehDkbAwGu8vloWZ0qWLx3sc5qt6cMCQhNXf+zAn2KkAVe0N8tt5TxI5JG
         fcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788537991; x=1789142791;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N1hoE3BcOuTiBC0ROHOK0Yvi5yLAEC063uLBYyUjYyI=;
        b=rNMC1KXwLpB8RSGi7tJjZT8fQtyfTyDBX1POmaDAYfdDVUktD7uYzXCraUjZEHWBjo
         LXfmn3uSLwx/UbQO2h/IEEweg3/sMC7V2fYg4Fuufle8baxq9IU2rx5ZBgkop1j6Nfyn
         oVmBV0bmLPa8nmeeQsgt3CY0hwWaq8UODdGrP2Cq1bF7hr6rZTsJ2D1AJiySI46+ro12
         Qo0O9jh7T5ws1tJL+ZGxYJe5N2+1kHzeK73W5F6lQ9KHL5yYz4yyKWI4BYhKAeZ6mNo7
         84CZvg4t+l1na7mzrmBkOFxWeYd+9id3cV6YS/I1O4tfkMQ+OjNofZq/GNK75nmknldO
         yvDg==
X-Forwarded-Encrypted: i=1; AKwUvBwhhpOZSMX8MDE4MBUcVf2+EBcSz5dG2tZjHipszSM/3My9BN6r9kUdCmfKf61Ng+nOXhmCeIYKOGsi@lists.infradead.org
X-Gm-Message-State: AFuF++lT/YhQ4WBqu7wL5eiYQ4vwqHe5LuOM0oUmip47b+Ih+SMdTKkQ
	qmIx5YeUXKgMVQhx8Ben+XeGXqF3D/9Gtfvtb0izimKpfvnzQqkZyG8kXkRL5y/pJ/wszh1udgy
	8ZnBIO/PvUXmDEhE1jKca348XOqFPSOIx1vDay1Yctw==
X-Gm-Gg: AYBFou31kSqXgAe1A0szS9DE79dURHXqKm4keWE7Of2kQzEAiEPXAmn4Gxft8VUrd0v
	xP1vylT/9HtBLE4S4OaeohVDVonvH6JJFNhRnvHjAaZwHFWcRdbJRt7w9AkjsMgc1U+JKQXi3O0
	mSHLGK9fZtJnWGVH90sVMkavR759zXV4+dLA0hP/Z1MjOC+9nDN+ECKo1OQ02LCnbWR7ykWkRV4
	by/41fm++kr2lQ4RhFdxZX90CLVJivVzKqbVWOWKWBi074j/G0g3XtF1/2P2J6i/IgsmND40F36
	cMsuA2mlcYo3M3NcmhK/ZUbWwV2cZMaGocSsr/orLAOs
X-Received: by 2002:a05:622a:1801:b0:51e:47a4:4851 with SMTP id
 d75a77b69052e-530548007d2mr71368811cf.8.1788537991012; Fri, 04 Sep 2026
 09:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260824225648.316962-1-sgogte@purestorage.com>
 <20260824225648.316962-3-sgogte@purestorage.com> <c98fe50c-172a-4e53-a30c-5416c40cb23f@grimberg.me>
In-Reply-To: <c98fe50c-172a-4e53-a30c-5416c40cb23f@grimberg.me>
From: "Surabhi Gogte (she/her)" <sgogte@purestorage.com>
Date: Fri, 4 Sep 2026 09:05:54 -0700
X-Gm-Features: AcwNN1XhIVrpE7jN0V-XwLfoyOZss61tkf_W80mr0zcm_FEIDqHY0YVSwMaXnEs
Message-ID: <CAMof9cWdXR_040SDs2N=3ETvdmxvjx+OokfkSDr7DzVbLbuenQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] nvme-tcp: parallelize I/O queue allocation and startup
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mkhalfella@purestorage.com, randyj@purestorage.com, adailey@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260904_090634_787412_288E5A11 
X-CRM114-Status: GOOD (  30.42  )
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

On Sun, Aug 30, 2026 at 3:00=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
>
>
> On 25/08/2026 1:56, Surabhi Gogte wrote:
> > Similar to commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue
> > allocation and startup"), refactor nvme tcp I/O queue setup to use asyn=
c
> > API, combining allocation and startup into a single parallel operation
> > per queue. This reduces connection and reconnection setup time when
> > there are delays in establishing connections, which is especially
> > important for high-core-count hosts.
> >
> > Key changes:
> > - Use async API to facilitate parallel calls for io queue setup.
> > - Add nvme_tcp_setup_ctx for propagating errors from async workers.
> > - Remove nvme_tcp_start_io_queues() and __nvme_tcp_alloc_io_queues();
> >    their logic is folded into nvme_tcp_setup_io_queues() and
> >    nvme_tcp_configure_io_queues().
> > - Allocate the io tag set before the queues so that the queue range is
> >    known, and only set up the reconnect grow case if the queue count
> >    actually increased.
> > - Serialize the cpu scan and claim in nvme_tcp_set_queue_io_cpu() with =
a
> >    spinlock, as concurrent callers would otherwise select the same cpu.
> >    The per-cpu counters no longer need to be atomics.
> > - Use init_net in nvme_tcp_alloc_queue() instead of the namespace of
> >    current, which is no longer the connecting task once the allocation
> >    runs from a worker. A controller is not guaranteed to be tied to a
> >    namespace, as the reconnect and error recovery paths already run fro=
m
> >    a workqueue in init_net.
>
> Well, I think this is breaking 1be52169c3488ef98582ed553ab35cefa3978817
>
Trying to understand how this breaks the commit 1be52169c348. Added my
understanding later in the thread.

> > @@ -154,6 +156,12 @@ struct nvme_tcp_queue {
> >   static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
> >   static LIST_HEAD_GUARDED(nvme_tcp_ctrl_list, nvme_tcp_ctrl_mutex);
> >
> > +struct nvme_tcp_setup_ctx {
>
> nvme_tcp_queue_setup_ctx?
>

Yeah, can rename it.

> > +     spin_unlock(&nvme_tcp_cpu_queues_lock);
> >   out:
> >       dev_dbg(ctrl->ctrl.device, "queue %d: using cpu %d\n",
> >               qid, queue->io_cpu);
> > @@ -1846,7 +1856,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl =
*nctrl, int qid,
> >               queue->cmnd_capsule_len =3D sizeof(struct nvme_command) +
> >                                               NVME_TCP_ADMIN_CCSZ;
> >
> > -     ret =3D sock_create_kern(current->nsproxy->net_ns,
> > +     ret =3D sock_create_kern(&init_net,
>
> I don't think we can just change this...

Passing init_net explicitly does change behavior on the synchronous connect
path. However, with queue allocation now moved into an async worker,
current->nsproxy->net_ns resolves to init_net in that context anyway, so
the initial connect path already loses the caller's netns regardless of
which argument is passed.

If the goal is to actually preserve the caller's netns through the full
ctrl lifecycle - initial connect, reconnect, and error recovery; it can
be pinned at ctrl creation like:

    nvme_tcp_alloc_ctrl():
            to_tcp_ctrl(ctrl)->net =3D get_net(current->nsproxy->net_ns);

    nvme_tcp_free_ctrl():
            put_net(to_tcp_ctrl(ctrl)->net);

    nvme_tcp_alloc_queue():
            sock_create_kern(to_tcp_ctrl(ctrl)->net, ...);

This captures the caller's netns while still in userspace context, then
carries it through all async paths =E2=80=94 so reconnect and error recover=
y
also honor the original netns rather than falling back to the kworker's
init_net.

Is this approach preferred?

