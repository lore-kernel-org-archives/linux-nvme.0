Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A0DC87FCC
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Jul 2025 15:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=efGuZE+wy/IQW6vpAnhNn2yJPMeIDc4VvmD3tdcVmA0=; b=yZWFhtCXrqU2UvqkkVF4nDQG2D
	/ZuubP/8hAeY8c8O9YPKclz2NYfKj8vbwqgzXLOTrNZNbhzhmU3Ni545EelfHDk65y2DCZl/+Fr9J
	oSp8ipSqsIuqRlQMTHQnFuMzNaNlBPsyKXWK3OpkN0AYB4NkHf0suR3a79ay5K5ZKZTMyhgkSINT1
	CpH9alGijq16/ePpm9ZoxmruUjM0ruWb4S7xfs8QwVgEPLLy1ztvr8oCh6IP+2zL8hhvoagPu02u0
	3B7t2vTSVMxwx5qqFGPjwr+vAPYoq1cCroaNkv8C/170gUSMgk39khYpWA3mfJJw24PUBUX7pvGKT
	X8rEmaJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhVEY-00000003yZX-2LgS;
	Thu, 31 Jul 2025 15:30:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhVEW-00000003yZC-07ge
	for linux-nvme@lists.infradead.org;
	Thu, 31 Jul 2025 15:30:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753975815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=efGuZE+wy/IQW6vpAnhNn2yJPMeIDc4VvmD3tdcVmA0=;
	b=YnzqK7Jg772LZ9BKj9Njue3WI5Fy/55sTUGKddS9XUb0c6TMRXd0g+TrbRSLIY4r7Qr7Tb
	uBJUlFQ5UIhx2YAHPu4N9Bk7rKjSp3DM8fRBaiTcPw8mYVTNmbTuwTrtB0qVNffYFWkIx+
	BEt5CJyzR67G04kFDFWZfUdujVQihLg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-vn-OdI7iPB6usiFeitQlLg-1; Thu, 31 Jul 2025 11:30:13 -0400
X-MC-Unique: vn-OdI7iPB6usiFeitQlLg-1
X-Mimecast-MFC-AGG-ID: vn-OdI7iPB6usiFeitQlLg_1753975812
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ae9bf1c5947so263493966b.0
        for <linux-nvme@lists.infradead.org>; Thu, 31 Jul 2025 08:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753975811; x=1754580611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efGuZE+wy/IQW6vpAnhNn2yJPMeIDc4VvmD3tdcVmA0=;
        b=BYErTxmeKGpBLALZEOMgPJkYSj4lPSYApJ8WQPLW5dOsC+LggF6AOI5KFIPAxTI9c+
         JAr9krVXs76oEJCbyiNLp/ur7thCDSQQvfmDJd2gIw5N4+ctPK96mMC+hLhgUGvYNMdL
         +7RxiCMXFCC/lQoNuZVytWqLYGoSCWLZ21B1OPL7zR+gXCauuhVDgkO9rk0sXmpvv1JU
         wwdAYgciX3R6VQOojNGfwL8t8Ey33MadG9xFTXMlQx2Acm8vyzoMuHPQj7Ktw9m0dxe9
         aqesAd7CKjf1CkrHIouyEUySygJn+09oeaxP7q8Sq/q43+USAinhdp2+TnRyZyf1ToIv
         7KUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6yEE04XUBwCn7QSNhAIIf+P1NWZBRc2jXCVXhjn7mJomTsh4n78UjSuQ+rD7iNG77j8/poua6u3aW@lists.infradead.org
X-Gm-Message-State: AOJu0Yxqf702dHcwFiro+WsvwDEbzsXYA3ItbjeDYNRTVCpYRNLjO4qv
	c0Pp9yY4jIa3/2uQ3vkxhLph4nO29iThYk0H3+9FU65q+TUzpkrHHhcMiKOTdfkJLMeNm9ITU5t
	PMlSazkaBtZQ22AhSSsCQ68bdshIBmJH01ZUlSEn1xMucnyIv/dYMd2HgC1t7SIS7Orx/0Q33ip
	2ca/vs62SpDWomOhiW+G3sA3mX3te1z9ufFSpL0VqXoOE=
X-Gm-Gg: ASbGncvZLTgdp5RPl5oQH5sUKKKB3vgc8NHYBEtylouQln3PbTMpZ9AogqZ5EYoCT+B
	c+bQvWidlju0TqM6s/aXG8MlxRl4+5HWKVn0t0QK6hjx6PDIhkQnL6irZUtlkxPtY+biRBpYU7F
	ICTL/2IExsYavynuK68sHhcayWR9Hrmc+iPnp9RXHuQ3TWi2MEK6eIzw==
X-Received: by 2002:a17:906:fe02:b0:ae6:c334:af3a with SMTP id a640c23a62f3a-af91bbff55emr339554366b.6.1753975810998;
        Thu, 31 Jul 2025 08:30:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5c9yIisVqfaFsfCitspiLklBi+v8OwNwd+81HnIxrh0XVGF7Bd2GCjIVQsJ7OLqh9uU8xi9NdthF8zdbYdEE=
X-Received: by 2002:a17:906:fe02:b0:ae6:c334:af3a with SMTP id
 a640c23a62f3a-af91bbff55emr339550366b.6.1753975810480; Thu, 31 Jul 2025
 08:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250730200835.80605-1-okorniev@redhat.com> <20250730200835.80605-4-okorniev@redhat.com>
 <cdeb5e12-5c61-4a95-8e31-c56a3a90d6a3@suse.de>
In-Reply-To: <cdeb5e12-5c61-4a95-8e31-c56a3a90d6a3@suse.de>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Thu, 31 Jul 2025 11:29:58 -0400
X-Gm-Features: Ac12FXyu4ke7AXpdJWvJjWBL1u_s87jJMDfrMGmbaMXP6xuZW7P6B3nrHVs7sWU
Message-ID: <CACSpFtCu+it5n2z=OXRARznR02aU4d3r2z7Sok6WzGt24C6-NQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] nvmet-tcp: fix handling of tls alerts
To: Hannes Reinecke <hare@suse.de>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, trondmy@hammerspace.com, 
	anna.schumaker@oracle.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org, 
	netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, neil@brown.name, 
	Dai.Ngo@oracle.com, tom@talpey.com, horms@kernel.org, kbusch@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hXTae-KPPH-bFfubtUSfxA3cDx_SdbRHtrAL59v8Vbg_1753975812
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250731_083016_152077_9E4EABD7 
X-CRM114-Status: GOOD (  33.57  )
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

On Thu, Jul 31, 2025 at 2:10=E2=80=AFAM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 7/30/25 22:08, Olga Kornievskaia wrote:
> > Revert kvec msg iterator before trying to process a TLS alert
> > when possible.
> >
> > In nvmet_tcp_try_recv_data(), it's assumed that no msg control
> > message buffer is set prior to sock_recvmsg(). Hannes suggested
> > that upon detecting that TLS control message is received log a
> > message and error out. Left comments in the code for the future
> > improvements.
> >
> > Fixes: a1c5dd8355b1 ("nvmet-tcp: control messages for recvmsg()")
> > Suggested-by: Hannes Reinecke <hare@suse.de>
> > Reviewed-by: Hannes Reinecky <hare@susu.de>
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >   drivers/nvme/target/tcp.c | 30 +++++++++++++++++++-----------
> >   1 file changed, 19 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> > index 688033b88d38..055e420d3f2e 100644
> > --- a/drivers/nvme/target/tcp.c
> > +++ b/drivers/nvme/target/tcp.c
> > @@ -1161,6 +1161,7 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tc=
p_queue *queue)
> >       if (unlikely(len < 0))
> >               return len;
> >       if (queue->tls_pskid) {
> > +             iov_iter_revert(&msg.msg_iter, len);
> >               ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
> >               if (ret < 0)
> >                       return ret;
> > @@ -1217,19 +1218,28 @@ static void nvmet_tcp_prep_recv_ddgst(struct nv=
met_tcp_cmd *cmd)
> >   static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
> >   {
> >       struct nvmet_tcp_cmd  *cmd =3D queue->cmd;
> > -     int len, ret;
> > +     int len;
> >
> >       while (msg_data_left(&cmd->recv_msg)) {
> > +             /* to detect that we received a TlS alert, we assumed tha=
t
> > +              * cmg->recv_msg's control buffer is not setup. kTLS will
> > +              * return an error when no control buffer is set and
> > +              * non-tls-data payload is received.
> > +              */
> >               len =3D sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
> >                       cmd->recv_msg.msg_flags);
> > +             if (cmd->recv_msg.msg_flags & MSG_CTRUNC) {
> > +                     if (len =3D=3D 0 || len =3D=3D -EIO) {
> > +                             pr_err("queue %d: unhandled control messa=
ge\n",
> > +                                    queue->idx);
> > +                             /* note that unconsumed TLS control messa=
ge such
> > +                              * as TLS alert is still on the socket.
> > +                              */
>
> Hmm. Will it get cleared when we close the socket?

If the socket is closed then any data on that socket would be freed.

> Or shouldn't we rather introduce proper cmsg handling?

That would be what I have originally proposed (I know that was on the
private list). But yes, we can setup a dedicated kvec to receive the
TLS control message once its been detected and then call
nvme_tcp_tls_record_ok().

Let me know if proper cmsg handling is what's desired for this patch.

> (If we do, we'll need it to do on the host side, too)

I can see that the host doesn't have any TLS alert handling now. If
the only place where (TLS) traffic is read from is in host/tcp.c
nvme_tcp_init_connection(), then that's seems like an easy case
because it uses a kvec to back the kernel_recvmsg() msg structure. If
the ctype is tls alert, you can call tls_alert_recv() and pass in the
"iov".  -- assuming patch#4 already went in by that time)

>
> > +                             return -EAGAIN;
> > +                     }
> > +             }
> >               if (len <=3D 0)
> >                       return len;
> > -             if (queue->tls_pskid) {
> > -                     ret =3D nvmet_tcp_tls_record_ok(cmd->queue,
> > -                                     &cmd->recv_msg, cmd->recv_cbuf);
> > -                     if (ret < 0)
> > -                             return ret;
> > -             }
> >
> >               cmd->pdu_recv +=3D len;
> >               cmd->rbytes_done +=3D len;
> > @@ -1267,6 +1277,7 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_=
tcp_queue *queue)
> >       if (unlikely(len < 0))
> >               return len;
> >       if (queue->tls_pskid) {
> > +             iov_iter_revert(&msg.msg_iter, len);
> >               ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
> >               if (ret < 0)
> >                       return ret;
> > @@ -1453,10 +1464,6 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_=
queue *queue,
> >       if (!c->r2t_pdu)
> >               goto out_free_data;
> >
> > -     if (queue->state =3D=3D NVMET_TCP_Q_TLS_HANDSHAKE) {
> > -             c->recv_msg.msg_control =3D c->recv_cbuf;
> > -             c->recv_msg.msg_controllen =3D sizeof(c->recv_cbuf);
> > -     }
>
> As you delete this you can also remove the definition of 'recv_msg'
> from nvmet_tcp_cmd structure.

You mean 'recv_cbuf', right? recv_msg would still be needed by the code.

I can send v2 with that change. Whether or not cmsg handling is needed
in v2 I'd need a confirmation on. Given I'm working on compile only
mode, I'd rather keep changes to minimal.

> >       c->recv_msg.msg_flags =3D MSG_DONTWAIT | MSG_NOSIGNAL;
> >
> >       list_add_tail(&c->entry, &queue->free_list);
> > @@ -1736,6 +1743,7 @@ static int nvmet_tcp_try_peek_pdu(struct nvmet_tc=
p_queue *queue)
> >               return len;
> >       }
> >
> > +     iov_iter_revert(&msg.msg_iter, len);
> >       ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
> >       if (ret < 0)
> >               return ret;
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich
>


