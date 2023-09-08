Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFD8EE57DE
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Sep 2023 08:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RKpdGP4GJUi9D8lTX4PYfauNu8/kDXBQFp9hqB4BgSc=; b=BfvDRdma010SzsNu8LInwmMzv7
	h8G+b3VnXMrX+OauXf0lkv06HkpxhaG5t2RKtimqxn1srPfxiJ5c4OuD+SmQGrRIOGsO2IPSJ3PXi
	camDza5a8KA4Cc3V+PXYFE4aaXVpYWrihDpkkCG2G5qYLiSDUgcBojQiTb3AVc7lVOHS18QCy5TaG
	KmQNGUydw+VeoZU2I2W0JaxUq7cEv+EXqMaJwoRsl5f8zF7a/dKVGYDGyJOJagjXzxJxKpBSIcpa4
	pTrQZeDRKG8PJUZKbIyK2D7nTAdd11hZyPIKfN+dh51uNfpdLN+BAWgUEbWFWanf26Za76qdB2564
	fsUA7suQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeWYA-00DI8n-1K;
	Fri, 08 Sep 2023 08:09:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeWY6-00DI6K-1T
	for linux-nvme@lists.infradead.org;
	Fri, 08 Sep 2023 08:09:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694160542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RKpdGP4GJUi9D8lTX4PYfauNu8/kDXBQFp9hqB4BgSc=;
	b=Z5/qKsvTzKrzQcODD0mzmDRcAi8wCog1/l2f/7LfV9NRqswquXi0rzQ8TaXIQ0A2Pe3hvD
	kxeBHL82YSkbD4P4hqTck/6zL8B7nCBIPtBMMzZHfWgKilgUr62IGpmi7a79z8mzzsj91o
	WGbH3bo5Rnv1Vj4lzvDs6OU0U1gODX4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-2ulXB7WZPHyC4k0ol6xKFw-1; Fri, 08 Sep 2023 04:08:55 -0400
X-MC-Unique: 2ulXB7WZPHyC4k0ol6xKFw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-26f533e6ec8so2488710a91.0
        for <linux-nvme@lists.infradead.org>; Fri, 08 Sep 2023 01:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694160534; x=1694765334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKpdGP4GJUi9D8lTX4PYfauNu8/kDXBQFp9hqB4BgSc=;
        b=NoGFFyUlmI6JUdfCMHk5wF96c2ujafpXwdx0J7MaTdv+BtBiFoeK7P56dCyn+M2XHE
         qlKJlKHveFdY6JZatZe3G6+R9btYz/uzR5UqeM1OAvIJFSdesFiUV77sxQSh9kVafTW7
         IAh+BSVkiW8ob9G9jNZ0qfXSPJn71kUeqyYJ8AOx9WDn1ZR8iGGSD9IZ/Ig2Lxi5bgzl
         uhKdkyjm2cmyseU9rEO3QTakRtwQM66Tdt0EevmkOWBsycHcNxHqnc8d1qIr79UP/GG1
         ppWV+z369tritOSGFONBIoiWFoP3OuVk7Wd4+YeFcRyYRO8GRu00TkOGhE2dC1JMNspn
         IY4Q==
X-Gm-Message-State: AOJu0YykPbKHVRLSI5US45p5DVgxoE/PSAjw/K3wFS9fMgfiJ9asi2qQ
	pOkfK/9x8kozZgpoguA/njcParqTJTRcY5ynqTzm/EX1yZdEe8BPNLZXXFNxNdLWGn7z6BdgQVk
	EezLa68ljC9UMmk7bCjiIQcl9fzx4PVhm2TAWAtX3uF4=
X-Received: by 2002:a17:90a:f60b:b0:26f:e9fd:8287 with SMTP id bw11-20020a17090af60b00b0026fe9fd8287mr1881650pjb.20.1694160534375;
        Fri, 08 Sep 2023 01:08:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmMUGyQAnnrfDGQqBcwUhh3wUJP4vqc4mniDQn8SEGARHmCNEaxFU8ijmU9qCekWtw7gYaRVycCFA7mzxFAlg=
X-Received: by 2002:a17:90a:f60b:b0:26f:e9fd:8287 with SMTP id
 bw11-20020a17090af60b00b0026fe9fd8287mr1881639pjb.20.1694160533952; Fri, 08
 Sep 2023 01:08:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230726142939.10062-1-guoqing.jiang@linux.dev>
 <CAHj4cs9LppxseFzZe-fj7tDaeKd0x8t8Wr-aYcjXAU-8FyfoiQ@mail.gmail.com> <a403c942-5b1c-c7f7-243b-81545f7f83ad@linux.dev>
In-Reply-To: <a403c942-5b1c-c7f7-243b-81545f7f83ad@linux.dev>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 8 Sep 2023 16:08:41 +0800
Message-ID: <CAHj4cs_RiEb4SNdZ12xqEDgu7n-pObO6iUe8MMY6tq9xO6SLRQ@mail.gmail.com>
Subject: Re: [PATCH RFC] nvmet-tcp: add new workqueue to surpress lockdep warning
To: Guoqing Jiang <guoqing.jiang@linux.dev>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_010906_586905_2C611C0B 
X-CRM114-Status: GOOD (  21.28  )
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

On Thu, Sep 7, 2023 at 4:12=E2=80=AFPM Guoqing Jiang <guoqing.jiang@linux.d=
ev> wrote:
>
> Hi Yi,
>
> On 9/7/23 14:41, Yi Zhang wrote:
> > Tested-by: Yi Zhang <yi.zhang@redhat.com>
> >
> > Confirmed below issue was fixed by this patch:
>
> Thanks a lot for the test!
>
> And I had got another similar lockdep warning about nvmet-rdma.

Yeah, I've filed this one last year, but still not get one solution.
https://lore.kernel.org/linux-rdma/13441b9b-cc13-f0e0-bd46-f14983dadd49@gri=
mberg.me/



>
>
> [ 1218.508847] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ 1218.508849] WARNING: possible circular locking dependency detected
> [ 1218.508852] 6.5.0-rc3+ #16 Tainted: G           OE
> [ 1218.508854] ------------------------------------------------------
> [ 1218.508856] kworker/1:3/357 is trying to acquire lock:
> [ 1218.508858] ffff8e32b919fc20 (&id_priv->handler_mutex){+.+.}-{3:3},
> at: rdma_destroy_id+0x1c/0x40 [rdma_cm]
> [ 1218.508877]
>                 but task is already holding lock:
> [ 1218.508878] ffffb5dbc0c67e40
> ((work_completion)(&queue->release_work)){+.+.}-{0:0}, at:
> process_one_work+0x236/0x590
> [ 1218.508887]
>                 which lock already depends on the new lock.
>
> [ 1218.508888]
>                 the existing dependency chain (in reverse order) is:
> [ 1218.508890]
>                 -> #3 ((work_completion)(&queue->release_work)){+.+.}-{0:=
0}:
> [ 1218.508894]        process_one_work+0x28c/0x590
> [ 1218.508898]        worker_thread+0x52/0x3f0
> [ 1218.508901]        kthread+0x109/0x140
> [ 1218.508904]        ret_from_fork+0x46/0x70
> [ 1218.508908]        ret_from_fork_asm+0x1b/0x30
> [ 1218.508911]
>                 -> #2 ((wq_completion)nvmet-wq){+.+.}-{0:0}:
> [ 1218.508915]        __flush_workqueue+0xc5/0x4f0
> [ 1218.508917]        nvmet_rdma_cm_handler+0xa50/0x1080 [nvmet_rdma]
> [ 1218.508924]        cma_cm_event_handler+0x4f/0x170 [rdma_cm]
> [ 1218.508933]        iw_conn_req_handler+0x2ad/0x3f0 [rdma_cm]
> [ 1218.508942]        cm_work_handler+0xbe2/0xe80 [iw_cm]
> [ 1218.508948]        process_one_work+0x2bd/0x590
> [ 1218.508951]        worker_thread+0x52/0x3f0
> [ 1218.508954]        kthread+0x109/0x140
> [ 1218.508956]        ret_from_fork+0x46/0x70
> [ 1218.508959]        ret_from_fork_asm+0x1b/0x30
> [ 1218.508961]
>                 -> #1 (&id_priv->handler_mutex/1){+.+.}-{3:3}:
> [ 1218.508966]        __mutex_lock+0x8d/0xd20
> [ 1218.508969]        mutex_lock_nested+0x1b/0x30
> [ 1218.508971]        iw_conn_req_handler+0x137/0x3f0 [rdma_cm]
> [ 1218.508980]        cm_work_handler+0xbe2/0xe80 [iw_cm]
> [ 1218.508986]        process_one_work+0x2bd/0x590
> [ 1218.508989]        worker_thread+0x52/0x3f0
> [ 1218.508991]        kthread+0x109/0x140
> [ 1218.508993]        ret_from_fork+0x46/0x70
> [ 1218.508996]        ret_from_fork_asm+0x1b/0x30
> [ 1218.508998]
>                 -> #0 (&id_priv->handler_mutex){+.+.}-{3:3}:
> [ 1218.509002]        __lock_acquire+0x1523/0x2590
> [ 1218.509007]        lock_acquire+0xd6/0x2f0
> [ 1218.509009]        __mutex_lock+0x8d/0xd20
> [ 1218.509011]        mutex_lock_nested+0x1b/0x30
> [ 1218.509013]        rdma_destroy_id+0x1c/0x40 [rdma_cm]
> [ 1218.509022]        nvmet_rdma_free_queue+0x38/0xf0 [nvmet_rdma]
> [ 1218.509028]        nvmet_rdma_release_queue_work+0x1a/0x70 [nvmet_rdma=
]
> [ 1218.509033]        process_one_work+0x2bd/0x590
> [ 1218.509036]        worker_thread+0x52/0x3f0
> [ 1218.509039]        kthread+0x109/0x140
> [ 1218.509040]        ret_from_fork+0x46/0x70
> [ 1218.509043]        ret_from_fork_asm+0x1b/0x30
> [ 1218.509045]
>                 other info that might help us debug this:
>
> [ 1218.509046] Chain exists of:
>                   &id_priv->handler_mutex --> (wq_completion)nvmet-wq
> --> (work_completion)(&queue->release_work)
>
> [ 1218.509052]  Possible unsafe locking scenario:
>
> [ 1218.509053]        CPU0                    CPU1
> [ 1218.509055]        ----                    ----
> [ 1218.509056] lock((work_completion)(&queue->release_work));
> [ 1218.509058] lock((wq_completion)nvmet-wq);
> [ 1218.509061] lock((work_completion)(&queue->release_work));
> [ 1218.509063]   lock(&id_priv->handler_mutex);
> [ 1218.509065]
>                  *** DEADLOCK ***
>
> The happens because nvmet_rdma_cm_handler receives
> RDMA_CM_EVENT_DISCONNECTED
> event then the call chain is triggered.
>
> 1. nvmet_rdma_queue_disconnect -> __nvmet_rdma_queue_disconnect
> 2.                                                             ->
> queue_work(nvmet_wq, &queue->release_work)
> 3. -> nvmet_rdma_release_queue_work
> 4.      -> nvmet_rdma_free_queue
> 5.          -> nvmet_rdma_destroy_queue_ib
> 6.              -> rdma_destroy_id
>
> If cm_handler receives RDMA_CM_EVENT_CONNECT_REQUEST event at the same
> time, which
> means the path nvmet_rdma_queue_connect -> flush_workqueue(nvmet_wq) can
> happen
> between 1 and 6.
>
> Besides make similar change like this patch, another option might be
> check queue state before
> flush workqueue. Thoughts?
>
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -1582,7 +1582,8 @@ static int nvmet_rdma_queue_connect(struct
> rdma_cm_id *cm_id,
>                  goto put_device;
>          }
>
> -       if (queue->host_qid =3D=3D 0) {
> +       if (queue->state =3D=3D NVMET_RDMA_Q_LIVE &&
> +           queue->host_qid =3D=3D 0) {
>                  /* Let inflight controller teardown complete */
>                  flush_workqueue(nvmet_wq);
>          }
>
> Thanks,
> Guoqing
>


--
Best Regards,
  Yi Zhang


