Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F43CA0FED
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Sep 2025 19:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FQ5lKT8MWq9BlErADmClzSG7/N/nbcrdEgrcT5yeDiw=; b=A5XGlWmqSyOIPEzqyBYuHbwgLK
	j98Dl5xgU93XkxLE0ywYlwDZzixyCahKAcDu0dKdlnUyo0jaO9vuMVyxzgLwb3aVVyM/yy3ZfHuyu
	oJIBFhqsX+Sw+lt49Vh0Giy4xjjqPWyz10jhbq1bPM8ilxRSNnBHpvM9tVujum9fd1JduTaimHjvb
	wMKk7/eqsgI3V73nW8lwc0KVNnRCL2rIHSdMHWGUuU5Q6Hmav6vGTaujyf7Nr/WAAe+eeTabKmbVK
	yEVtCdJqtRHBNh1WrDCsbRYS3zBLJDbLs2g8WXp49bzNN5+HFJMKSPvDaPoO/Oxj6r9K/vVmtMwXd
	cO9DxjWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuc8L-00000004A2a-1sWM;
	Fri, 05 Sep 2025 19:30:05 +0000
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuZ1I-000000030TY-2TrC
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 16:10:37 +0000
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-55ce508d4d6so2024029e87.0
        for <linux-nvme@lists.infradead.org>; Fri, 05 Sep 2025 09:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1757088634; x=1757693434; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQ5lKT8MWq9BlErADmClzSG7/N/nbcrdEgrcT5yeDiw=;
        b=aObWzuitnUAX1EEE0CYLAZfGwd4TG4HhEgsQcFChiIayWa91+4NtVxphveAFEg5l9z
         Ph4lYEY7NOgBHKKVT1hSbn/ikLFICcCBhe7DaMPcc81uC5gqdmAMB3SIH4O5au4KqXJf
         X1LNIYIeg84AO+ANrhTNuYSzELedhn64iKJXtweRQxD+A2imeE2vim0ijkhjMy+0txbx
         ILoE4ycD3ZLY9kUATGNmyXw8ir115YAaSmS9AgZ5pVZFldN7M/NGSVJYwPrl6s7ugkKI
         utZgZn/1IGQ61RWYdRu0HumzbhVUzXIaLBCAuPkQO95R6NiaVk0mxcTOJMOQEKIqGAcL
         ol4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757088634; x=1757693434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQ5lKT8MWq9BlErADmClzSG7/N/nbcrdEgrcT5yeDiw=;
        b=TWzTDdyh5GZ91boi6eL6LPfUmeh5DkKwTq3ulmoVvuvxgQzedLHIIW6VYrgYdQOufn
         IoCSYGOa7EhHKCvttkXAaoGawsKSk1vCFXLb+Bk0orNN42k0t7tI03lKj3F/Z5qdFnZ1
         ji9HBFkIXrfE2mX9ohju7nsacdz+aKQo/PDBg60pc9NF8nV9wNT9ATZ1S/EPP4lduTkH
         mlIcovYPt9j7bOYpSkkMd3+ff7vxB239Pg/WZfdymewU97gCjbq9Tj7x+pCa/aRI9U+z
         odX4EvyL2LrgAG/0ynHcxilRTEWMfancA+lO7grqJSe7A//vhkjZl+Jdam895uj2K27H
         fQVA==
X-Forwarded-Encrypted: i=1; AJvYcCV61m9hkdT0SGAR+tdoqayDwtPdZrmVL4Z1aY8IBYHpwV6TDgbuqse/IaQZkKwvl18XCiD3HtZGDdiy@lists.infradead.org
X-Gm-Message-State: AOJu0Yz+zNllTgB6rY31tX81SsWaX3ZWvFNCi4naaYWhEEOe37lDGY8u
	q5Ro+VR9av+4VQl11XGXcbC8QXc/16ux/R8lUFOEMmDm8f6rR5x3IgHImcAol3I9PZJw25Jp+6h
	+zFO9YuLODNA3HWxocby00mNRMNw+PUY=
X-Gm-Gg: ASbGncubmwUThAczAJRdWCyXzPScGpDaoIjjc+yyfncXaWdhTVtdrbAczg9gyqohk9I
	8+h5J27CEJGyMHsnCw6UPXDq4O6gHHkngUwJyper4Z1X4W5hp8djgUteXsqWF7W9fRePAP7KuQj
	8EDX2Q1G03lHsjGaxD5iLx1jcEvNJVa5bIMPxAwcxO/o8hBEGHmiEqtnfRj4CP5ErHwjODeMAjK
	YynBbff4aUpnTCsotSzuW96gxBRlwnw+4THt7dRhQ==
X-Google-Smtp-Source: AGHT+IH4XATrInTUDVReB90YvO/+WxFS3HmfZqUUGXwXcEnfrW4wwIz+ykUEAEhK5InYJjqbQmozqhPkoS3eqY6kZqE=
X-Received: by 2002:a05:651c:1b12:b0:332:2235:911c with SMTP id
 38308e7fff4ca-336caf71358mr68599551fa.37.1757088634191; Fri, 05 Sep 2025
 09:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250731180058.4669-1-okorniev@redhat.com> <20250731180058.4669-4-okorniev@redhat.com>
In-Reply-To: <20250731180058.4669-4-okorniev@redhat.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 5 Sep 2025 12:10:21 -0400
X-Gm-Features: Ac12FXzBiQ30iKKbP0zzoq1oKAENaPAn2hm04QJoePVvv8Y4CUwCe8BkLoQZJ38
Message-ID: <CAN-5tyF=5oQLyy7ikbbhFW10OrUfHh0Sr3D=G1nHN+pEsfiSzw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] nvmet-tcp: fix handling of tls alerts
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, trondmy@hammerspace.com, 
	anna.schumaker@oracle.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org, 
	netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, neil@brown.name, 
	Dai.Ngo@oracle.com, tom@talpey.com, hare@suse.de, horms@kernel.org, 
	kbusch@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250905_091036_747545_E605BE9E 
X-CRM114-Status: GOOD (  25.23  )
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

Dear NvME maintainers,

Are there objections to this patch? What's the path forward to
including it in the nvme code.

Thank you.

On Thu, Jul 31, 2025 at 2:01=E2=80=AFPM Olga Kornievskaia <okorniev@redhat.=
com> wrote:
>
> Revert kvec msg iterator before trying to process a TLS alert
> when possible.
>
> In nvmet_tcp_try_recv_data(), it's assumed that no msg control
> message buffer is set prior to sock_recvmsg(). Hannes suggested
> that upon detecting that TLS control message is received log a
> message and error out. Left comments in the code for the future
> improvements.
>
> Fixes: a1c5dd8355b1 ("nvmet-tcp: control messages for recvmsg()")
> Suggested-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Hannes Reinecky <hare@susu.de>
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  drivers/nvme/target/tcp.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 688033b88d38..98cee10de713 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -120,7 +120,6 @@ struct nvmet_tcp_cmd {
>         u32                             pdu_len;
>         u32                             pdu_recv;
>         int                             sg_idx;
> -       char                            recv_cbuf[CMSG_LEN(sizeof(char))]=
;
>         struct msghdr                   recv_msg;
>         struct bio_vec                  *iov;
>         u32                             flags;
> @@ -1161,6 +1160,7 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_=
queue *queue)
>         if (unlikely(len < 0))
>                 return len;
>         if (queue->tls_pskid) {
> +               iov_iter_revert(&msg.msg_iter, len);
>                 ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
>                 if (ret < 0)
>                         return ret;
> @@ -1217,19 +1217,28 @@ static void nvmet_tcp_prep_recv_ddgst(struct nvme=
t_tcp_cmd *cmd)
>  static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
>  {
>         struct nvmet_tcp_cmd  *cmd =3D queue->cmd;
> -       int len, ret;
> +       int len;
>
>         while (msg_data_left(&cmd->recv_msg)) {
> +               /* to detect that we received a TlS alert, we assumed tha=
t
> +                * cmg->recv_msg's control buffer is not setup. kTLS will
> +                * return an error when no control buffer is set and
> +                * non-tls-data payload is received.
> +                */
>                 len =3D sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
>                         cmd->recv_msg.msg_flags);
> +               if (cmd->recv_msg.msg_flags & MSG_CTRUNC) {
> +                       if (len =3D=3D 0 || len =3D=3D -EIO) {
> +                               pr_err("queue %d: unhandled control messa=
ge\n",
> +                                      queue->idx);
> +                               /* note that unconsumed TLS control messa=
ge such
> +                                * as TLS alert is still on the socket.
> +                                */
> +                               return -EAGAIN;
> +                       }
> +               }
>                 if (len <=3D 0)
>                         return len;
> -               if (queue->tls_pskid) {
> -                       ret =3D nvmet_tcp_tls_record_ok(cmd->queue,
> -                                       &cmd->recv_msg, cmd->recv_cbuf);
> -                       if (ret < 0)
> -                               return ret;
> -               }
>
>                 cmd->pdu_recv +=3D len;
>                 cmd->rbytes_done +=3D len;
> @@ -1267,6 +1276,7 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tc=
p_queue *queue)
>         if (unlikely(len < 0))
>                 return len;
>         if (queue->tls_pskid) {
> +               iov_iter_revert(&msg.msg_iter, len);
>                 ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
>                 if (ret < 0)
>                         return ret;
> @@ -1453,10 +1463,6 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_qu=
eue *queue,
>         if (!c->r2t_pdu)
>                 goto out_free_data;
>
> -       if (queue->state =3D=3D NVMET_TCP_Q_TLS_HANDSHAKE) {
> -               c->recv_msg.msg_control =3D c->recv_cbuf;
> -               c->recv_msg.msg_controllen =3D sizeof(c->recv_cbuf);
> -       }
>         c->recv_msg.msg_flags =3D MSG_DONTWAIT | MSG_NOSIGNAL;
>
>         list_add_tail(&c->entry, &queue->free_list);
> @@ -1736,6 +1742,7 @@ static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_=
queue *queue)
>                 return len;
>         }
>
> +       iov_iter_revert(&msg.msg_iter, len);
>         ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
>         if (ret < 0)
>                 return ret;
> --
> 2.47.1
>
>

