Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7B5EB7ED4
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2026 11:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lDZKotLArOoGPbmGkSbdB3knGUn3d/x5zVLs33GH6ak=; b=ryhArZ/slmrEIpTzoTXfwDy22f
	rprUt5xTftJRilueGpWUBNiNe5BrTYWtiKgaozG59e+7rhCjPh1b/IHK6w8Bru12D4U5L0Ipk9Hc4
	oS3CHKUJemjz+9IXBUuU0D1qZMG5EF6Ee0xWTmZk+1t2DbUYxbGKyLF4gORlD5eyO9gd0LqjfWDwO
	8bOJD8njNztbfp/soWr4pYkTV4ES2P/5x/0D+94eMq2vdNS+f/tZkXfY2qMOrL3YXSWy2UfBK/Ae4
	txEzGQUU+3yDev/vdrwxCxS3yIMDHLX2fFAKbY0CV/FiLtnxUnbd1PzCdO/w6hjSckP0c9sCj6TsS
	Suidz5ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxkY6-0000000H75O-0d71;
	Wed, 04 Mar 2026 11:37:54 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxkY3-0000000H752-16WF
	for linux-nvme@lists.infradead.org;
	Wed, 04 Mar 2026 11:37:52 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-65f812e0c83so12668649a12.2
        for <linux-nvme@lists.infradead.org>; Wed, 04 Mar 2026 03:37:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772624269; cv=none;
        d=google.com; s=arc-20240605;
        b=DjUF2myJaGOaMKN8INR29hP9Z+zt5PpJSMs6CEN94HxJs8+PbWYck2xNtDxKlAq5bc
         83YzfUcyZ2a6aeCeQsczMsfXYiSlnvye8G+h3NQnAxzVKHVUhiv1KKiT25yu/M/IC/ls
         3T0T4RN5elbDqJ6mb5Cu0eCiyRvSs9xg5b5o+SEWDZBoJQT+XTTCZyyuJD4t5VuwIzIj
         C3vwiDsW8UurHOGlGYZfgaTYAdeIryMv5CBsfyOXuM48g1VoiQUyaj5NzkMC7Rdj7yQ3
         hJovyAEV8EmwVe/AJYBvp4+e7V2hTs1MMjz4TUhTRIJ9XsHwQ+myayjHoijJdGptt9QR
         oQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lDZKotLArOoGPbmGkSbdB3knGUn3d/x5zVLs33GH6ak=;
        fh=Di/VeHmtv1EDrCZ4zoxf6thPHB3ZtAESAQbMNNVhgPY=;
        b=AqVC5OLboD6r1U9oRnfg0LfQrKkkZI9R1iiLhUdsaS/iUJWhbMYD6nETMY1i7ev+SG
         mvnkt3isWvBBqKdM2g7+0asU5O2rScG8qJnFvqOcwWW/+Nut6dj5aoiiMvIeskjauqRs
         U/2QgCTwlKYGOKQADnPqwHrc7QKjpMSLHwE+I/ZiBzERGP40aQ3HBd4uzuujj6/58fqP
         Kn77iAtGZ5w6A7CFGygkJeEJzl3Glh+UmFSiX0as9dW4nw4sHWFnYDa0rV7gOtSdR5cJ
         GgjwvyFk9QQ5zbhogD1AyBHnnsTfspUX+zHy/ntVege/C2SZAZp2eD/65Wvm4rChQhl2
         0gDg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772624269; x=1773229069; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDZKotLArOoGPbmGkSbdB3knGUn3d/x5zVLs33GH6ak=;
        b=UvMRvkc0UJNWvrPx0wQ5eXNHIJphELIJocSNbs1AF+c7pkdg6SySYdCG+fRVZxQF2P
         9MQW8fY6arIZfSifu+EmvhbEMImIiMkn8tmUrkgVAQQLSvECLIXGVeETzcOJE6kr5Wxt
         m0NxFXSI+sjkFSp+TXUkBJAiQEzhu/XO7OY8taNhbUxShgLhNYzqKX4S84hOrCNf4XiA
         RMOYVkXl3Xi86m4ujamQlqeqay21h2ekATQsovqs9yCF+YucI9XhI+tNFSA/fh7dFoRM
         dcpttsHLFaBUyiKcO89HQzBUYKLvL8CNWDzrS3mao9tjKaUtfzNJqtUJeF6OPLDl6d7T
         2amw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772624269; x=1773229069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lDZKotLArOoGPbmGkSbdB3knGUn3d/x5zVLs33GH6ak=;
        b=wg3YxETfc9fIpKKB9zs2ag1YVkRORr1dn5reE2x3CIFeWrwgw3ugrF3YzGuKS11E1Y
         0K/VYSTWgE2C/gTkf2AS/AxXgq8gUjorney9myTzMb/56/Wank2dMmueM+5vS5vl3jLJ
         OawfHisLMYPiypPlBF2imOn/3eJeBV0nBT+b6ZT8qPKV4otmYhADmtfDOEHIyy4LgIi5
         39VaHmRNHPXJGGa6fmEKVb9zAz65nlTQ0YROrRXpafCfppRa+W7BzIj8sq7WzmJ7azs9
         4A6I5Td9QM2zkyXebCbqx7aTAISFJYBwwtnHlXRJcRf2OaPVn6dnqfziDghkfgQxQBSd
         saQA==
X-Forwarded-Encrypted: i=1; AJvYcCVivoPgOQ2jC/Zz5hxi9D6kyckLJpyaKCWNSImfapnCN9zy+X53kLbf2+sTHT0TUiWxdnJtO/h/+B55@lists.infradead.org
X-Gm-Message-State: AOJu0YwkXdnajOWnFfBZFnw+c+2LtXZ4Tej2DE2EuU08uStSAfl0U7Xk
	SF5l+BhYmj/uBFBFT2yJRBpgSVW71HLT5pGrSwmikkM9MDtkDEB7uU9fwJv3hfH7VaDFcqhVU9H
	Ldh9Z8zcsX9OiktGcE7KjSJwM4Y3rEos=
X-Gm-Gg: ATEYQzzN+s1FP/uXdJPIw8IJoG+kpnq6UqoXFLlYMfe9h+sJSTtKWJmlW2zIvi2oySv
	Eicd8qddbmF7cjWlpIkJstCKXGJ8Ph8lL2A3reZ9loKGYXNWlpixk0W5TCN/bCGUfhEWHMWZKVs
	Dzi/81e1/EKHUxWzglV9A3qsUUDMWiWLbjyDrEXOeNp3zgK/J1bPntB8k9yoZFACa/uJQqpNFTD
	Yh7iYZwABavPHjS/6bXtqPVsK8DKl9A6ZvJR9D22x/jL6pdxI1pGktFZZN0qZMQMiJVbWt0FkVx
	ZySlbipjMTbMzkHwXbYbOtXIS2kNZYJv44nmaw==
X-Received: by 2002:a05:6402:34c9:b0:65f:80cc:a47a with SMTP id
 4fb4d7f45d1cf-660ef7797f6mr858539a12.1.1772624269071; Wed, 04 Mar 2026
 03:37:49 -0800 (PST)
MIME-Version: 1.0
References: <20260304053500.590630-1-alistair.francis@wdc.com>
 <20260304053500.590630-5-alistair.francis@wdc.com> <103c958f-d5f9-47d3-9be8-dd7225368fd5@suse.de>
In-Reply-To: <103c958f-d5f9-47d3-9be8-dd7225368fd5@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Mar 2026 21:37:22 +1000
X-Gm-Features: AaiRm53Rc8hKqaLsyJSSxrm4evktnm3D1AOZXCuqV_7q51qatQHTgMljJH9bALQ
Message-ID: <CAKmqyKPdJ2bgT2JaXi_38obyFTjRQ_rR5EdGmP81so8MEJNRVw@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] nvme-tcp: Support KeyUpdate
To: Hannes Reinecke <hare@suse.de>
Cc: chuck.lever@oracle.com, hare@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, kbusch@kernel.org, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260304_033751_363856_2452AC4D 
X-CRM114-Status: GOOD (  38.06  )
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

On Wed, Mar 4, 2026 at 5:40=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrote=
:
>
> On 3/4/26 06:34, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > If the nvme_tcp_try_send() or nvme_tcp_try_recv() functions return
> > EKEYEXPIRED then the underlying TLS keys need to be updated. This occur=
s
> > on an KeyUpdate event as described in RFC8446
> > https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3.
> >
> > If the NVMe Target (TLS server) initiates a KeyUpdate this patch will
> > allow the NVMe layer to process the KeyUpdate request and forward the
> > request to userspace. Userspace must then update the key to keep the
> > connection alive.
> >
> > This patch allows us to handle the NVMe target sending a KeyUpdate
> > request without aborting the connection. At this time we don't support
> > initiating a KeyUpdate.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> > v7:
> >   - Use read_sock_cmsg instead of recvmsg() to handle KeyUpdate
> > v6:
> >   - Don't use `struct nvme_tcp_hdr` to determine TLS_HANDSHAKE_KEYUPDAT=
E,
> >     instead look at the cmsg fields.
> >   - Don't flush async_event_work
> > v5:
> >   - Cleanup code flow
> >   - Check for MSG_CTRUNC in the msg_flags return from recvmsg
> >     and use that to determine if it's a control message
> > v4:
> >   - Remove all support for initiating KeyUpdate
> >   - Don't call cancel_work() when updating keys
> > v3:
> >   - Don't cancel existing handshake requests
> > v2:
> >   - Don't change the state
> >   - Use a helper function for KeyUpdates
> >   - Continue sending in nvme_tcp_send_all() after a KeyUpdate
> >   - Remove command message using recvmsg
> >
> >   drivers/nvme/host/tcp.c | 59 ++++++++++++++++++++++++++++++++++++++++=
-
> >   1 file changed, 58 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index 8b6172dd1c0f..ade11d2ac9ef 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -171,6 +171,7 @@ struct nvme_tcp_queue {
> >       bool                    tls_enabled;
> >       u32                     rcv_crc;
> >       u32                     snd_crc;
> > +     key_serial_t            handshake_session_id;
> >       __le32                  exp_ddgst;
> >       __le32                  recv_ddgst;
> >       struct completion       tls_complete;
> > @@ -1361,6 +1362,59 @@ static int nvme_tcp_try_send(struct nvme_tcp_que=
ue *queue)
> >       return ret;
> >   }
> >
> > +static void update_tls_keys(struct nvme_tcp_queue *queue)
> > +{
> > +     int qid =3D nvme_tcp_queue_id(queue);
> > +     int ret;
> > +
> > +     dev_dbg(queue->ctrl->ctrl.device,
> > +             "updating key for queue %d\n", qid);
> > +
> > +     ret =3D nvme_tcp_start_tls(&(queue->ctrl->ctrl),
> > +                              queue, queue->ctrl->ctrl.tls_pskid,
> > +                              HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
> > +
> > +     if (ret < 0) {
> > +             dev_err(queue->ctrl->ctrl.device,
> > +                     "failed to update the keys %d\n", ret);
> > +             nvme_tcp_fail_request(queue->request);
> > +     }
> > +}
> > +
> > +static int nvme_tcp_recv_cmsg(read_descriptor_t *desc,
> > +                           struct sk_buff *skb,
> > +                           unsigned int offset, size_t len,
> > +                           u8 content_type)
> > +{
> > +     struct nvme_tcp_queue *queue =3D desc->arg.data;
> > +     struct socket *sock =3D queue->sock;
> > +     struct sock *sk =3D sock->sk;
> > +
> > +     switch (content_type) {
> > +     case TLS_RECORD_TYPE_HANDSHAKE:
> > +             if (len =3D=3D 5) {
> > +                     u8 header[5];
> > +
> > +                     if (!skb_copy_bits(skb, offset, header,
> > +                                        sizeof(header))) {
> > +                             if (header[0] =3D=3D TLS_HANDSHAKE_KEYUPD=
ATE) {
> > +                                     dev_err(queue->ctrl->ctrl.device,=
 "KeyUpdate message\n");
> > +                                     release_sock(sk);
> > +                                     update_tls_keys(queue);
> > +                                     lock_sock(sk);
> > +                                     return 0;
> > +                             }
> > +                     }
> > +             }
> > +
> > +             break;
> > +     default:
> > +             break;
> > +     }
>
> I think a simple 'if' condition would be sufficient here, or do you have
> handling of other TLS record types queued somewhere?
> And we should log unhandled TLS records.

I like this approach as it makes it really easy to handle more types
in the future. I don't have any more record types queued anywhere so I
can change it to an if statement.

Good point about logging unhandled records

Alistair

>
> > +
> > +     return -EAGAIN;
> > +}
> > +
> >   static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
> >   {
> >       struct socket *sock =3D queue->sock;
> > @@ -1372,7 +1426,8 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queu=
e *queue)
> >       rd_desc.count =3D 1;
> >       lock_sock(sk);
> >       queue->nr_cqe =3D 0;
> > -     consumed =3D sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb=
);
> > +     consumed =3D sock->ops->read_sock_cmsg(sk, &rd_desc, nvme_tcp_rec=
v_skb,
> > +                                          nvme_tcp_recv_cmsg);
> >       release_sock(sk);
> >       return consumed =3D=3D -EAGAIN ? 0 : consumed;
> >   }
> > @@ -1708,6 +1763,7 @@ static void nvme_tcp_tls_done(void *data, int sta=
tus, key_serial_t pskid,
> >                       ctrl->ctrl.tls_pskid =3D key_serial(tls_key);
> >               key_put(tls_key);
> >               queue->tls_err =3D 0;
> > +             queue->handshake_session_id =3D handshake_session_id;
> >       }
> >
> >   out_complete:
> > @@ -1737,6 +1793,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *n=
ctrl,
> >               keyring =3D key_serial(nctrl->opts->keyring);
> >       args.ta_keyring =3D keyring;
> >       args.ta_timeout_ms =3D tls_handshake_timeout * 1000;
> > +     args.ta_handshake_session_id =3D queue->handshake_session_id;
> >       queue->tls_err =3D -EOPNOTSUPP;
> >       init_completion(&queue->tls_complete);
> >       if (keyupdate =3D=3D HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
>
> Otherwise looks good.
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

