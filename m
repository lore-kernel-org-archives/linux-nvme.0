Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A59C021B1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2025 17:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n0YCBoTSFVWPZG3Txe1F+1Vb+wRrAFfxVvQDo450OBg=; b=WB4NfNTqo43OPVLxO+Tqu7958K
	tXrNAnObzb+0sDU/LBEg9BO6Q27dDTevw2XOFg9vEmcqAGc0eil/dgqfEHL/nTiKrZxgkr/pUQNIL
	4N5sqz9mF9UH4GBR7k6pkTRYlg3xayG1Y96ptIKJOilJ7xjkh8SekOE8UO6GuJy8jGCUJoIBXskpH
	o4W4hTQHVsQWKDRWa9/EqCWggVA8fVlcO96S4M4THO7WYY16uMAvWMWH2OnRKhHKWPlm/ymF0vedu
	a9DUvkImjIVduv3Cv8Kr+5xswMEiR3jpES/lL8yHBrjI0gYSi+Em2DMZ6aFK8wyJaH+KMTRYNkTn6
	m4nQb80g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlAB4-000000025Qt-03UF;
	Thu, 20 Feb 2025 17:17:34 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlAB1-000000025QE-2gLL
	for linux-nvme@lists.infradead.org;
	Thu, 20 Feb 2025 17:17:32 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2217875d103so2664705ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 20 Feb 2025 09:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740071850; x=1740676650; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0YCBoTSFVWPZG3Txe1F+1Vb+wRrAFfxVvQDo450OBg=;
        b=C4tjrO9UDsG61PVtSM5j9JFs6qG+A8h5lwiQRMHzQmY+lT5Mssf/GxXsDQ2EyKzA3+
         vcvNqeSaUpDWDT/udk+nO6FNDwZjAKeGmmA+Vki0peeZD3RTfUZXlUYKkqJVXlY3cpcb
         RKnJcQNw4UEpHdAUVu1y0pDJa7EIEVzqW/D8p6UTb1k0FLr7dZ1S1egvTO4wS7GK21md
         yIM/d2ZlGgO8GODkWrWZrDwvgWoCsuSIXreFpsEHUan2SVE5/h1gHboeght6WVR9Xwx/
         wgY7iX6wgzIX22gCpurTqGRIHV1fKk/wmFyUiqSTu68MuebW9fMa4QbvNNhPVC7UFwQG
         FATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740071850; x=1740676650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0YCBoTSFVWPZG3Txe1F+1Vb+wRrAFfxVvQDo450OBg=;
        b=Idq++voxyS16j+zIDHZ8IJgQhX8/aMZTQtD1iKd/aB1MTiKCpn5uNglhpiqqBJV5Pc
         0lZrkI2FGjOxvvcOeRq2rNq1pVI28DgpmeelsosovN8MBcW7mHq3bTbTc1ZoVYTvoqJ0
         giz22L3wWF+XhfaZFvwXEKr8a/96IkvSJbHpNtxJtYLw8l34vr7j4iSKWC0jwwdwu1FP
         330JIPH1UZoRyApfsEZYPotPyAAKBZyRlFLHxuKLBJ00DuLYSrB/rNl9FeoAxu88jSRG
         BGpPFQWWrVAIpG9VUSxUddVUsM3X4UY3CHtWDPHsLXT9E9LtUhM18+R5sDpefoYEP+gR
         uJUw==
X-Forwarded-Encrypted: i=1; AJvYcCWq87iANbTcdk5IAMSlFCp1Cdrk8CVGULOp9w7AhwJxyPyZeTR9OFDmJZYtxJloXgP3nxy91V1L+kAI@lists.infradead.org
X-Gm-Message-State: AOJu0YxruxArei6WxDWzdj4tySdKRzUQVwQOxyhubOasDiqBNPcZtSvB
	mugHtR9Ff9us2VkvISckB7YmqXSRG55kAnJAYXuY7oLMnrWCPwTPzwe+kWIfv/MH4A+6kT46b0g
	eu5Pb0+q5xNiDbyVeXIGKYyIN4eMQ/DdO+vsfxg==
X-Gm-Gg: ASbGncsrtbFMD0DnAqn/cemab87yJFgjvkuMazPRf3tXW/gw0ODrTAnjWSJtYuYuKQP
	5HDPid1b8q6n0QwPktRtu3PZpjzhvEPkc4pdmLFCF8lr6MrGQi9lEKS8+crnPYukjVxkFRHM=
X-Google-Smtp-Source: AGHT+IF65VeWlUVrnbymvlHNX3zXSIzpNbgECKkcivbXI0dUn2nusuQsIEkl4jeVgQh9Mk8/j7AjjecgInfNMXcvruU=
X-Received: by 2002:a17:903:2284:b0:221:7854:7618 with SMTP id
 d9443c01a7336-2217854788amr41128075ad.8.1740071850393; Thu, 20 Feb 2025
 09:17:30 -0800 (PST)
MIME-Version: 1.0
References: <20250220115409.3271289-1-meir.elisha@volumez.com>
In-Reply-To: <20250220115409.3271289-1-meir.elisha@volumez.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 20 Feb 2025 09:17:19 -0800
X-Gm-Features: AWEUYZlC-SZWtBIh484L1aiTzglgk_elksMvYC-nPSSccp8fUm9XAylf5Xx9DKg
Message-ID: <CADUfDZr70ANBX1N0b34=fyHa=fgBzN=kF8hT4hvtzZ5Dv8fH7w@mail.gmail.com>
Subject: Re: [PATCH] nvmet-tcp: Fix a possible sporadic response drops in
 weakly ordered arch
To: Meir Elisha <meir.elisha@volumez.com>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_091731_725214_DE31B018 
X-CRM114-Status: GOOD (  31.31  )
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

On Thu, Feb 20, 2025 at 3:56=E2=80=AFAM Meir Elisha <meir.elisha@volumez.co=
m> wrote:
>
> The order in which queue->cmd and rcv_state are updated is crucial.
> If these assignments are reordered by the compiler, the worker might not
> get queued in nvmet_tcp_queue_response(), hanging the IO. to enforce the
> the correct reordering, set rcv_state using smp_store_release().
>
> Fixes: bdaf13279192 ("nvmet-tcp: fix a segmentation fault during io parsi=
ng error")
> Signed-off-by: Meir Elisha <meir.elisha@volumez.com>
> ---
>  drivers/nvme/target/tcp.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 7c51c2a8c109..4021468c8857 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -571,10 +571,16 @@ static void nvmet_tcp_queue_response(struct nvmet_r=
eq *req)
>         struct nvmet_tcp_cmd *cmd =3D
>                 container_of(req, struct nvmet_tcp_cmd, req);
>         struct nvmet_tcp_queue  *queue =3D cmd->queue;
> +       enum nvmet_tcp_recv_state queue_state =3D READ_ONCE(queue->state)=
;

Why did this change from queue->rcv_state to queue->state? Doesn't
look like enum nvmet_tcp_recv_state is the correct type for
queue->state either.

> +       /*
> +        * Use an acquire load to ensure that any updates to queue->state=
 are visible
> +        * before loading queue->cmd.
> +        */
> +       struct nvmet_tcp_cmd *queue_cmd =3D smp_load_acquire(&queue->cmd)=
;

Acquire ordering prevents memory operations that come *after* from
being reordered *before*. It does not prevent earlier operations (such
as the load of queue->state) from being reordered after the acquire
load. Additionally, an acquire must pair with a release store *on the
same value* to have any effect. But the release store is to
queue->rcv_state, not queue->cmd.

Correct uses of release-acquire ordering generally look something like this=
:
Thread 1:
Non-atomic store to A
Release-ordering store to B

Thread 2:
Acquire-ordering load from B
Non-atomic load from A

This ensures that if thread 2 observes the new value thread 1 stored
in B, it will also observe the new value in A.

>         struct nvme_sgl_desc *sgl;
>         u32 len;
>
> -       if (unlikely(cmd =3D=3D queue->cmd)) {
> +       if (unlikely(cmd =3D=3D queue_cmd)) {
>                 sgl =3D &cmd->req.cmd->common.dptr.sgl;
>                 len =3D le32_to_cpu(sgl->length);
>
> @@ -583,7 +589,7 @@ static void nvmet_tcp_queue_response(struct nvmet_req=
 *req)
>                  * Avoid using helpers, this might happen before
>                  * nvmet_req_init is completed.
>                  */
> -               if (queue->rcv_state =3D=3D NVMET_TCP_RECV_PDU &&
> +               if (queue_state =3D=3D NVMET_TCP_RECV_PDU &&
>                     len && len <=3D cmd->req.port->inline_data_size &&
>                     nvme_is_write(cmd->req.cmd))
>                         return;
> @@ -847,8 +853,9 @@ static void nvmet_prepare_receive_pdu(struct nvmet_tc=
p_queue *queue)
>  {
>         queue->offset =3D 0;
>         queue->left =3D sizeof(struct nvme_tcp_hdr);
> -       queue->cmd =3D NULL;
> -       queue->rcv_state =3D NVMET_TCP_RECV_PDU;
> +       WRITE_ONCE(queue->cmd, NULL);
> +       /* Ensure rcv_state is visible only after queue->cmd is set */
> +       smp_store_release(&queue->rcv_state, NVMET_TCP_RECV_PDU);

Is this also needed in the other places updating queue->rcv_state and
queue->cmd, e.g. nvmet_tcp_handle_h2c_data_pdu()?

Best,
Caleb

>  }
>
>  static void nvmet_tcp_free_crypto(struct nvmet_tcp_queue *queue)
> --
> 2.34.1
>
> This ordering is critical on weakly ordered architectures (such as ARM)
> so that any observer which sees the new rcv_state is guaranteed to also
> see the updated cmd. Without this guarantee (i.e if the two stores were
> reordered), a parallel context might see the new state while queue->cmd
> still holds a stale value. This could cause the inline-data check to
> return early and ultimately hang the IO.
> Additionally, I reviewed the assembly code for ARM and confirmed that
> the instructions were reordered(unlike x86), reinforcing the need for
> this change.
>
> This scenario was encountered during fio testing, which involved
> running 2 min of 4K random writes using an ARM-based machine as the
> target. We observed hanging I/O typically after 10-20 iterations.
>
> fio config used:
> [global]
> ioengine=3Dlibaio
> max_latency=3D45s
> end_fsync=3D1
> create_serialize=3D0
> size=3D3200m
> directory=3D/mnt/volumez/vol0
> ramp_time=3D30
> lat_percentiles=3D1
> direct=3D1
> filename_format=3Dfiodata.$jobnum
> verify_dump=3D1
> numjobs=3D16
> fallocate=3Dnative
> stonewall=3D1
> group_reporting=3D1
> file_service_type=3Drandom
> iodepth=3D16
> runtime=3D5m
> time_based=3D1
> [random_0_100_4k]
> bs=3D4k
> rw=3Drandwrite
>

