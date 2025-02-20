Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F72BC021B1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2025 18:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C4a45U8FSZW4vBFVTqD1u8zNHtlvUfQFpgUsqPjSx00=; b=SVJAl33lRWi+PSLFRcvp3quO5A
	YMoN66XJfuu/JQyN8UjXkdiaqUljDiA8X0sPH+9IDwL6F1YsQSZ6O7xn30j30htEauEVwGsdv8Uzn
	4+MJlCew5yoDqve80FZSckRvVp4VlKgdN+pdzK5Om+XejUybnZLWgoHuMaqAA3Z72I1/HTC+pd7u0
	itz3iWmAWZcX33iU/b9S7l7N8trzRpRBjlvipqkDppAErJgH0e7dGVBigqKv9LwgY4/5cpQeYVBBW
	rQ4RGOHEVwXRkiNMOtAl4/UPDQgJd515SoN44JlaAal+FxEh+STyniD+lAm0QuYLUAzd75yFVBWsz
	iTxWUfEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlBlY-00000002UlT-0iQk;
	Thu, 20 Feb 2025 18:59:20 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlBkU-00000002UTj-19cO
	for linux-nvme@lists.infradead.org;
	Thu, 20 Feb 2025 18:58:15 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2fbfe16cbf5so312194a91.0
        for <linux-nvme@lists.infradead.org>; Thu, 20 Feb 2025 10:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740077893; x=1740682693; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4a45U8FSZW4vBFVTqD1u8zNHtlvUfQFpgUsqPjSx00=;
        b=a1rYBoWkktYgMR0/4Kwsndtp+Svv9w5zM4ulSnoaRFbwMAtoNWyLwNO+jZX7Q0c0DL
         jPb7VTjXfj+zdiB6XIp9AxIB2uheNH58Mk4NolYu4IQnNB18XdinLnyhp0GR+wsu2J/M
         Koa2EJzy4ww9iTH0dHymV3W/gSTXZMpXZKJDC25w+dCbeFVL5TQI5Z7ApbAm2iitBLuC
         6HU2/68uLhPURviKU6vAHt7PUPCLZ8ujQjtA5gyS6217oSBz+LRjqPZ5SLn3jgHy7Gd4
         +RdnfQaPGc4BF+tbkXqL8jicGYx4HRydw/SOcZ7nklWm28BO8C2ZCfBprxmgW9+/XLRJ
         7BjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740077893; x=1740682693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4a45U8FSZW4vBFVTqD1u8zNHtlvUfQFpgUsqPjSx00=;
        b=Y2qLxbEM2t3ItFT1RJ8J20vDC4l+RVNffxaoQownl4Rnx0leiubnkt1ak738xXhCFe
         WJ7QTitaxKd/yOrNadN9z/zcnjSNdGhgSrTxEo/e3KFf5/TuFYF4Bp68nhQIWS7pY3Uv
         QeSLGtxk422AprGFAijkrxs2pWvS6vsNeD4hXVG8qjD8nIY2NhzLxY3aviKoYuLULzLC
         Jw/IU+KWn6jGa4pdjVnfij8LvzBq70B7nzFyvqgnteiQjLPJIRzz41zILT+iKr1UzRpu
         hpqVjGPLIREP28xUsuhhSRqubjEBzh9n+sith9K5x4V0fugD+CdPMef+iDCQh7La21Gy
         YA4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXC3DdJ39jBBhXdeDwMvxnSI1U0L9+F6PrVdRKhcP09AeGmUavilwPbudKta8jhRCJKdWdYfKF7wo4F@lists.infradead.org
X-Gm-Message-State: AOJu0Yzx6luuY0j8x9adKYhb2uIJ4Ux8ivqjfew/k0aIqGNyJBbQHm8N
	btEU6A9+7gIp1Yg+5MJjvBLXwg5bbJouBtuaUYqqnaDuvaHUjc2ugJEGP67uKCP89uUGeiw2MXe
	MDHs/D07IRVhB9PIlbz2j6y6C9CuFo07bbsPSPQ==
X-Gm-Gg: ASbGncsRtZh3kgBh603YOM9eiaakl0465cyqi0tEV71lVO9k9SYzic5MvpwUCdgNrEu
	3TR7EzVLlCnBjQwVIfK35WA5drga6belmFYbZXhJCz9ztlkbX4GxxCXNovB9gZKVP9mBH4xI=
X-Google-Smtp-Source: AGHT+IEirpFj3l7ERCzd2uCEYPss6OZROj07ggo9BP/a5hIv4rrfHrHZ97rGIVC0tKC+Sn6jXuKFjoDNrhFILxdPpQM=
X-Received: by 2002:a17:90b:1a8c:b0:2fb:f9de:94ac with SMTP id
 98e67ed59e1d1-2fce7b1441bmr143560a91.7.1740077893351; Thu, 20 Feb 2025
 10:58:13 -0800 (PST)
MIME-Version: 1.0
References: <20250220115409.3271289-1-meir.elisha@volumez.com>
 <CADUfDZr70ANBX1N0b34=fyHa=fgBzN=kF8hT4hvtzZ5Dv8fH7w@mail.gmail.com> <25589eeb-8faa-46c2-83b9-de0ff2bd4350@volumez.com>
In-Reply-To: <25589eeb-8faa-46c2-83b9-de0ff2bd4350@volumez.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 20 Feb 2025 10:58:01 -0800
X-Gm-Features: AWEUYZmqRBGaAj96vm25yg6iEu5um1lemgLNeyvbemMFSCybOEaeWK6cDPVSac8
Message-ID: <CADUfDZri3E3Y2uuH9+nDMwRv2eSztcqP53OqUad4SOPJxZi9Rg@mail.gmail.com>
Subject: Re: [PATCH] nvmet-tcp: Fix a possible sporadic response drops in
 weakly ordered arch
To: Meir Elisha <meir.elisha@volumez.com>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_105814_325748_9E2C6A0C 
X-CRM114-Status: GOOD (  35.87  )
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

On Thu, Feb 20, 2025 at 10:29=E2=80=AFAM Meir Elisha <meir.elisha@volumez.c=
om> wrote:
>
> Hi Caleb
>
> Thanks for the review. I'll resend patch after testing.
>
> On 20/02/2025 19:17, Caleb Sander Mateos wrote:
> > On Thu, Feb 20, 2025 at 3:56=E2=80=AFAM Meir Elisha <meir.elisha@volume=
z.com> wrote:
> >>
> >> The order in which queue->cmd and rcv_state are updated is crucial.
> >> If these assignments are reordered by the compiler, the worker might n=
ot
> >> get queued in nvmet_tcp_queue_response(), hanging the IO. to enforce t=
he
> >> the correct reordering, set rcv_state using smp_store_release().
> >>
> >> Fixes: bdaf13279192 ("nvmet-tcp: fix a segmentation fault during io pa=
rsing error")
> >> Signed-off-by: Meir Elisha <meir.elisha@volumez.com>
> >> ---
> >>  drivers/nvme/target/tcp.c | 15 +++++++++++----
> >>  1 file changed, 11 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> >> index 7c51c2a8c109..4021468c8857 100644
> >> --- a/drivers/nvme/target/tcp.c
> >> +++ b/drivers/nvme/target/tcp.c
> >> @@ -571,10 +571,16 @@ static void nvmet_tcp_queue_response(struct nvme=
t_req *req)
> >>         struct nvmet_tcp_cmd *cmd =3D
> >>                 container_of(req, struct nvmet_tcp_cmd, req);
> >>         struct nvmet_tcp_queue  *queue =3D cmd->queue;
> >> +       enum nvmet_tcp_recv_state queue_state =3D READ_ONCE(queue->sta=
te);
> >
> > Why did this change from queue->rcv_state to queue->state? Doesn't
> > look like enum nvmet_tcp_recv_state is the correct type for
> > queue->state either.
> it was by mistake. should be queue->rcv_state.
> >
> >> +       /*
> >> +        * Use an acquire load to ensure that any updates to queue->st=
ate are visible
> >> +        * before loading queue->cmd.
> >> +        */
> >> +       struct nvmet_tcp_cmd *queue_cmd =3D smp_load_acquire(&queue->c=
md);
> >
> > Acquire ordering prevents memory operations that come *after* from
> > being reordered *before*. It does not prevent earlier operations (such
> > as the load of queue->state) from being reordered after the acquire
> > load. Additionally, an acquire must pair with a release store *on the
> > same value* to have any effect. But the release store is to
> > queue->rcv_state, not queue->cmd.
> >
> > Correct uses of release-acquire ordering generally look something like =
this:
> > Thread 1:
> > Non-atomic store to A
> > Release-ordering store to B
> >
> > Thread 2:
> > Acquire-ordering load from B
> > Non-atomic load from A
> >
> > This ensures that if thread 2 observes the new value thread 1 stored
> > in B, it will also observe the new value in A.
>
> Thanks for noticed that.
> >
> >>         struct nvme_sgl_desc *sgl;
> >>         u32 len;
> >>
> >> -       if (unlikely(cmd =3D=3D queue->cmd)) {
> >> +       if (unlikely(cmd =3D=3D queue_cmd)) {
> >>                 sgl =3D &cmd->req.cmd->common.dptr.sgl;
> >>                 len =3D le32_to_cpu(sgl->length);
> >>
> >> @@ -583,7 +589,7 @@ static void nvmet_tcp_queue_response(struct nvmet_=
req *req)
> >>                  * Avoid using helpers, this might happen before
> >>                  * nvmet_req_init is completed.
> >>                  */
> >> -               if (queue->rcv_state =3D=3D NVMET_TCP_RECV_PDU &&
> >> +               if (queue_state =3D=3D NVMET_TCP_RECV_PDU &&
> >>                     len && len <=3D cmd->req.port->inline_data_size &&
> >>                     nvme_is_write(cmd->req.cmd))
> >>                         return;
> >> @@ -847,8 +853,9 @@ static void nvmet_prepare_receive_pdu(struct nvmet=
_tcp_queue *queue)
> >>  {
> >>         queue->offset =3D 0;
> >>         queue->left =3D sizeof(struct nvme_tcp_hdr);
> >> -       queue->cmd =3D NULL;
> >> -       queue->rcv_state =3D NVMET_TCP_RECV_PDU;
> >> +       WRITE_ONCE(queue->cmd, NULL);
> >> +       /* Ensure rcv_state is visible only after queue->cmd is set */
> >> +       smp_store_release(&queue->rcv_state, NVMET_TCP_RECV_PDU);
> >
> > Is this also needed in the other places updating queue->rcv_state and
> > queue->cmd, e.g. nvmet_tcp_handle_h2c_data_pdu()?
> nvmet_tcp_handle_h2c_data_pdu() doesn't set rcv_state to NVMET_TCP_RECV_P=
DU.
> the other context wont exit early in nvmet_tcp_queue_response() so I don'=
t
> think we need it.

Okay. Even if the memory ordering is not required, all stores to
queue->cmd and queue->rcv_state should probably at least be using
WRITE_ONCE() since those values may be concurrently read by
nvmet_tcp_queue_response() on another thread. But that's a
pre-existing issue, so no need to fix it in this patch.

Best,
Caleb

