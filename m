Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD75FB5EBB
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 04:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yaz+A/EpED8k+5GP/Tf3gk+1D/3xSB3xVR5fmMSDj2Y=; b=xg+TXrQKHWXpgH9O19oIvZzH4t
	E8pdfB2IWFuZbNSBmKpq1WzUKNwQN3tcBAKp9082DPpBjhad9P/NDCCQizK16l/J4a0arli1ebkvl
	8WP0iI88Dxq8GQaTHm4EBkBySEvwXHOKGPUcdVZD46se5BsxidxGGEBEyTigT6lNE6nQPWcq4WGSB
	INSFFRVOX+8ZmSQXfKR1LWkT+wDrn0crGoP+OUSm41TV0Mno2gV2H0SK+7ngWcO5sUI5/t98uO2IU
	hUinX8LQVFgOVIZBGWdFTFlDxiJhGC0nCfrEfjJHPzoFgUP9wjk8mc401mQ7dmc1maFNqfogT8VGb
	6MLUyU5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2M7P-00000005Opr-1f68;
	Tue, 17 Mar 2026 04:33:23 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2M7I-00000005OpH-2aOd
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 04:33:21 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-82a15b44c3cso2085524b3a.0
        for <linux-nvme@lists.infradead.org>; Mon, 16 Mar 2026 21:33:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773721995; cv=none;
        d=google.com; s=arc-20240605;
        b=EmHk3xoZ3RYL/6kuiIkWJSyiyp7vb6f+ibyh+iuDItXkMXG4TGkj7WSmg3FZBmalqk
         LF4kZs3n1Wsv9OBpV62COtv+KQWGg9hPjilvVH663R6skyYSoGCyhLanNJ2Js06919M9
         1xnfFmzUm3d/SQqWKHmIpe7tZYeQGKXK1QU/cR1s68JWbz7vigXJDHYDP8cxSTpZUgyi
         kRnvJxAgf59ll8YL/HP3Wg18x7KwVBmodOQK4eRJlIhamGUJ9jFq6QTMOYcXw7cWDzDv
         oamhMUeIYjEA28XeEw7YVX7nX6LDxyQUxQ1FtiqpB5UEOAzwSHUr/TO2tesxfVMG/kAS
         kCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yaz+A/EpED8k+5GP/Tf3gk+1D/3xSB3xVR5fmMSDj2Y=;
        fh=hWRuzTmlz/Ch7uUKOXSGzHwDZtYk6NJD8vREy0UqH2A=;
        b=CWsAB1qMWkr1szAUZKDNKp6tN/cXk9kfe6tEn0/G1IWtQEQFSJzwZ5qwggNeSu5hgs
         1RQCCoRLT2dsUjPGjT0k6k1X7pZERtEqO1poRqiOClVgKegaSEV+QN3gTkzOwm6VuXxR
         DHq35MkqyOlS3FJeQQB2s5ZquV6OndqS+Xmm2iH0HmWX2lFE/YnyKXDhTc8jqIiLcm7v
         qLu1F2Ss4SOFMT4YPaB9y58R8FfWOp4RkkLidrE2o5/t+47jAupEe6wazEJxHrruLLpE
         rGs+dD6ABVP35OrDLik5cLVtpCkmzuFtRi8Huf05APDMfuBamY8rNgE/2DZgXeRai0T+
         wpoQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773721995; x=1774326795; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaz+A/EpED8k+5GP/Tf3gk+1D/3xSB3xVR5fmMSDj2Y=;
        b=JDc996wDkuPOcC68VEYyoIhsc/LTypDkGJgobGcnaoHpVEaN7JP8D4r9r/mocUqCwf
         HVPajb1uCyspy1o50pd3yd5abGE7J9rngOenSaI8og/eYLdLUiCjtUnqT8HujI2oq9vH
         /oFaZDC73X8lacB24uYwszKExxwNZIjrumRgIkeXVhvxXIXGfp4NlrIfEYwS5/7XnNNW
         aObJ2PnZJzJSPnTuCaEFBa8wDGbcLMc+X6J3vB+Y/UsAxC80rKV0s9MkACUE7Jp1/B9B
         6vu7fuPUxb0oywyg5TahZZWLtgT3q+ecj4clQUbAhRwpE5vG3ktMFzBBzFVd0k2CKOYW
         B6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773721995; x=1774326795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yaz+A/EpED8k+5GP/Tf3gk+1D/3xSB3xVR5fmMSDj2Y=;
        b=K62ZFU4aY5YoUt8Ik2qJp2UhBFAZ2d5fQIxvvaK7sbuRzx/LEbre5kIlE/gl5TOkgb
         acqG961fGUXUam7OEk/jUePaqTdpois+SIOygyIRQCRriQ1leyxfzu6wveaPCT2gU1ca
         0D6IJf6e8E89TrU0NO2T/avQdhfKSrLUEmf4S0ZHiuz/fry4MvqbM/M+R+ENRGJGM44V
         2odo26jkBNGsec1KpBWjtkoTphuDg3MIErXCgsnIYQ2G11l+noc7SzJYyUx6bLXhY6Kv
         9+YIj4v7FcibB5mTpvxTiAyiD9oBcXbEXzQdvdz5l14pBeKeuhiaGLKAVkrgTkm24fN0
         5bOg==
X-Forwarded-Encrypted: i=1; AJvYcCWfNY5fGxghwLWBNASFqK924nKKuj3fMaB2h8nqnd+oc3abWCIJfLAXjiZjtWTP0uIEhxooueuxEWdb@lists.infradead.org
X-Gm-Message-State: AOJu0Yw7KgjkpV7p/+yoqPPWEniN2uplKnfHzOCUiGf89Xg76LIIl2r8
	zP4Z2G/JqctOwMat/ECGEo1I7fm3jlFqgEyqDAJZRJCsOOKu7HpSOKMRAmqF/ScqMDEHfmwqyRX
	ClPoKElnCPSVP14N3auKirA5JIiMdHFc=
X-Gm-Gg: ATEYQzxUj/pmF04/9bXZSfKY+gD8hkew2A7C4/SEKgCikUFXTViyhpMYEoTEaz+j7AD
	WAt7TQpVD33IDh60i7H8YNUiaqATobSAvTuPL331nyDeagZmbfshBxuVnkNVxFb5V9AWCnZLl3y
	YR3JgJQXWySSM3PXvpw5fsTWRv9rmuqXz8jWfNKqLl4Wt63IwYfH9/0oBAdS6HfmbubCzrg6nfB
	e+O9HUhrn5z34BWWVzDDKrXm4WSGnoGbdFOgxyA9qEBQgmRqhpjgC5jdS46qdqy2raPglDUFYJU
	HmsYxz+W/g==
X-Received: by 2002:a05:6a00:6c83:b0:81f:4294:6080 with SMTP id
 d2e1a72fcca58-82a1983f3e3mr13919021b3a.20.1773721995272; Mon, 16 Mar 2026
 21:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260316143936.120999-1-mlombard@redhat.com> <20260316143936.120999-2-mlombard@redhat.com>
In-Reply-To: <20260316143936.120999-2-mlombard@redhat.com>
From: yunje shin <yjshin0438@gmail.com>
Date: Tue, 17 Mar 2026 13:33:04 +0900
X-Gm-Features: AaiRm52l6Uls5KfFcezssIQenVMQ1f_-XPL_HsflIYeamFKEbG-NlKJtGr3zIvQ
Message-ID: <CAMX6_QFffaDv+1HP2YwJbvVjDUbpyWhiaVUdBj0YABO+ASHmvg@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] nvmet-tcp: propagate nvmet_tcp_build_pdu_iovec()
 errors to its callers
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org, dwagner@suse.de, 
	hare@suse.de, sagi@grimberg.me, chaitanyak@nvidia.com, mlombard@arkamax.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_213316_665651_EF125AA8 
X-CRM114-Status: GOOD (  21.53  )
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

Looks good to me.

Reviewed-by: Yunje Shin <ioerts@kookmin.ac.kr>

On Mon, Mar 16, 2026 at 11:39=E2=80=AFPM Maurizio Lombardi <mlombard@redhat=
.com> wrote:
>
> Currently, when nvmet_tcp_build_pdu_iovec() detects an out-of-bounds
> PDU length or offset, it triggers nvmet_tcp_fatal_error(cmd->queue)
> and returns early. However, because the function returns void, the
> callers are entirely unaware that a fatal error has occurred and
> that the cmd->recv_msg.msg_iter was left uninitialized.
>
> Callers such as nvmet_tcp_handle_h2c_data_pdu() proceed to blindly
> overwrite the queue state with queue->rcv_state =3D NVMET_TCP_RECV_DATA
> Consequently, the socket receiving loop may attempt to read incoming
> network data into the uninitialized iterator.
>
> Fix this by shifting the error handling responsibility to the callers.
>
> Fixes: 52a0a9854934 ("nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu=
_iovec")
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>  drivers/nvme/target/tcp.c | 51 ++++++++++++++++++++++-----------------
>  1 file changed, 29 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index acc71a26733f..1fbf12df1183 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -351,7 +351,7 @@ static void nvmet_tcp_free_cmd_buffers(struct nvmet_t=
cp_cmd *cmd)
>
>  static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue);
>
> -static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
> +static int nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>  {
>         struct bio_vec *iov =3D cmd->iov;
>         struct scatterlist *sg;
> @@ -364,22 +364,19 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_=
tcp_cmd *cmd)
>         offset =3D cmd->rbytes_done;
>         cmd->sg_idx =3D offset / PAGE_SIZE;
>         sg_offset =3D offset % PAGE_SIZE;
> -       if (!cmd->req.sg_cnt || cmd->sg_idx >=3D cmd->req.sg_cnt) {
> -               nvmet_tcp_fatal_error(cmd->queue);
> -               return;
> -       }
> +       if (!cmd->req.sg_cnt || cmd->sg_idx >=3D cmd->req.sg_cnt)
> +               return -EPROTO;
> +
>         sg =3D &cmd->req.sg[cmd->sg_idx];
>         sg_remaining =3D cmd->req.sg_cnt - cmd->sg_idx;
>
>         while (length) {
> -               if (!sg_remaining) {
> -                       nvmet_tcp_fatal_error(cmd->queue);
> -                       return;
> -               }
> -               if (!sg->length || sg->length <=3D sg_offset) {
> -                       nvmet_tcp_fatal_error(cmd->queue);
> -                       return;
> -               }
> +               if (!sg_remaining)
> +                       return -EPROTO;
> +
> +               if (!sg->length || sg->length <=3D sg_offset)
> +                       return -EPROTO;
> +
>                 u32 iov_len =3D min_t(u32, length, sg->length - sg_offset=
);
>
>                 bvec_set_page(iov, sg_page(sg), iov_len,
> @@ -394,6 +391,7 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tc=
p_cmd *cmd)
>
>         iov_iter_bvec(&cmd->recv_msg.msg_iter, ITER_DEST, cmd->iov,
>                       nr_pages, cmd->pdu_len);
> +       return 0;
>  }
>
>  static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
> @@ -931,7 +929,7 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_qu=
eue *queue)
>         return 0;
>  }
>
> -static void nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
> +static int nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
>                 struct nvmet_tcp_cmd *cmd, struct nvmet_req *req)
>  {
>         size_t data_len =3D le32_to_cpu(req->cmd->common.dptr.sgl.length)=
;
> @@ -947,19 +945,23 @@ static void nvmet_tcp_handle_req_failure(struct nvm=
et_tcp_queue *queue,
>         if (!nvme_is_write(cmd->req.cmd) || !data_len ||
>             data_len > cmd->req.port->inline_data_size) {
>                 nvmet_prepare_receive_pdu(queue);
> -               return;
> +               return 0;
>         }
>
>         ret =3D nvmet_tcp_map_data(cmd);
>         if (unlikely(ret)) {
>                 pr_err("queue %d: failed to map data\n", queue->idx);
>                 nvmet_tcp_fatal_error(queue);
> -               return;
> +               return -EPROTO;
>         }
>
>         queue->rcv_state =3D NVMET_TCP_RECV_DATA;
> -       nvmet_tcp_build_pdu_iovec(cmd);
>         cmd->flags |=3D NVMET_TCP_F_INIT_FAILED;
> +       ret =3D nvmet_tcp_build_pdu_iovec(cmd);
> +       if (unlikely(ret))
> +               pr_err("queue %d: failed to build PDU iovec\n", queue->id=
x);
> +
> +       return ret;
>  }
>
>  static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
> @@ -1011,7 +1013,10 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nv=
met_tcp_queue *queue)
>                 goto err_proto;
>         }
>         cmd->pdu_recv =3D 0;
> -       nvmet_tcp_build_pdu_iovec(cmd);
> +       if (unlikely(nvmet_tcp_build_pdu_iovec(cmd))) {
> +               pr_err("queue %d: failed to build PDU iovec\n", queue->id=
x);
> +               goto err_proto;
> +       }
>         queue->cmd =3D cmd;
>         queue->rcv_state =3D NVMET_TCP_RECV_DATA;
>
> @@ -1074,8 +1079,7 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp=
_queue *queue)
>                         le32_to_cpu(req->cmd->common.dptr.sgl.length),
>                         le16_to_cpu(req->cqe->status));
>
> -               nvmet_tcp_handle_req_failure(queue, queue->cmd, req);
> -               return 0;
> +               return nvmet_tcp_handle_req_failure(queue, queue->cmd, re=
q);
>         }
>
>         ret =3D nvmet_tcp_map_data(queue->cmd);
> @@ -1092,8 +1096,11 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tc=
p_queue *queue)
>         if (nvmet_tcp_need_data_in(queue->cmd)) {
>                 if (nvmet_tcp_has_inline_data(queue->cmd)) {
>                         queue->rcv_state =3D NVMET_TCP_RECV_DATA;
> -                       nvmet_tcp_build_pdu_iovec(queue->cmd);
> -                       return 0;
> +                       ret =3D nvmet_tcp_build_pdu_iovec(queue->cmd);
> +                       if (unlikely(ret))
> +                               pr_err("queue %d: failed to build PDU iov=
ec\n",
> +                                       queue->idx);
> +                       return ret;
>                 }
>                 /* send back R2T */
>                 nvmet_tcp_queue_response(&queue->cmd->req);
> --
> 2.53.0
>

