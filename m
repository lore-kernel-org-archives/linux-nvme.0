Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C522C87FCB
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jul 2025 21:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pUVJK/b8xtvanBoj9VS0jS/GGMLzTsUc4wyzInBkEHc=; b=iJ6k5byXhTca4RgK47unAzawue
	OoEU76a+4SaTbonCQcv4E54UsmmB+PgbQaxZTVQrPgwQR+vvAMSm0ayHfOIQ/5Rl0Wr7RyTC0cuYY
	MmeqzB3UtcLvhjmrq5zmefdV10MAHvMvf+vJfTzXfILNx7XBw+l+zYa2h/nrRCavwJlaa7JN6GvBt
	JSNokxb7Y19MdFZKWslbgbVLexDUhaRktfYUHA1723y0EkdFzYKZBj8pxFhwwsZGl0WhC2iK0GDAq
	O5aaUm9KgJqKWNYsVfZRUz68hBoF/IOA1bYe48ROciCBDw6UBsWW/1wlMAwBaVu4V/AX8mHM69ZLB
	LIkV2r7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhEfl-00000002Vzf-20kM;
	Wed, 30 Jul 2025 21:49:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhETp-00000002Ujb-2wdu
	for linux-nvme@lists.infradead.org;
	Wed, 30 Jul 2025 21:36:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753911416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pUVJK/b8xtvanBoj9VS0jS/GGMLzTsUc4wyzInBkEHc=;
	b=eKoxkTT2+uOkXdEvZuhEURqhMll9V8HSwXZ6PIHVzzPWDUTro0IXqTNYbjvI26+IgTaNSi
	2F9p9rNIb9rTEjZUgQ9XPTlUxh4gKEQRdT/+/2pRi2d2v5hsk/vW0yp0QQodbkMCG7zAsz
	4ItnPBgdqjYEXVJd37jtFWjj3yI2Lqk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-TT5mFNJjNUCnThfisLgjcg-1; Wed, 30 Jul 2025 17:36:55 -0400
X-MC-Unique: TT5mFNJjNUCnThfisLgjcg-1
X-Mimecast-MFC-AGG-ID: TT5mFNJjNUCnThfisLgjcg_1753911414
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-af8f6fe8336so152129566b.1
        for <linux-nvme@lists.infradead.org>; Wed, 30 Jul 2025 14:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753911414; x=1754516214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUVJK/b8xtvanBoj9VS0jS/GGMLzTsUc4wyzInBkEHc=;
        b=bpisxPUi0we0gnpI598sD2Dyu9SeWP6A1EFA3U76nzWl8q2KdcvSx9C5s3rDbjp0ZB
         97D5DCXoUF/ItuwNQ4C96qYTJtiQ0druC/pCj8UOEbKJaGS5JocV4f8r8adBNw5idY/P
         tI2jTl4aWmtjfsWkk6KkMvbPET3OY8vIC2rS20N4s6oxaj5gSuADNOx2YzBge7zf8Qbi
         UZMl9mbB1iZbGeTkJE6K27AKKYNInP8DzU2sDNE5j5DvsKEz/b86Kqtk5xl7TuyEuDrF
         x6vFwSFOC65UojhxKWPR4O+C4xu1QZIz6h+sxBG1s/JQ6BiFRu1LFumKI/mTls+KZMTc
         eGZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUceVorM4B9A2CAnfiusU3nN+dDHUvMsfjAfMBkwrbTGm0XrUHg7D3rtRPzXWsFRLjyHAVLGGV2031L@lists.infradead.org
X-Gm-Message-State: AOJu0Yxf0aGSzSHCjx3LircPP5kRllxoG6twpiMVHZ85euTmXOj7B5ll
	a9TtJwVM0xjndIdxi9vQRwxnA/MzmVsrfYG+ovc+K10YDlrp2D+UFylbgtQu1fz66erbD+jUXHM
	0Yt0JlcOS1hz94NT6zRiGSpmOjHSn1nFMJdLQyW5oZlOnXo85xYs1KeGBPk7mwwVZvw99CMSr4P
	PhRM3YeegR7pa7gTZSdeq3rG+uUmO6th7NONCLoiV3REI=
X-Gm-Gg: ASbGnctGEl0XWvNYVQgzhccf+Hxrr4uv9T7QWV/ghctECqnzQy518nNywFMsp/4Kghm
	pp8dXE+pMEuvk1+qdfCQOCr8sUrKerPCfPZA1cpJ4NKTgJ/gE2jH3v3wqtgVIhaBLuzgM5O1Kg2
	4UYvJLwa/6NkNImqq/T0WM0lVpgszqw8CZjUCMgohzpNeQe+JtWiXI3VU=
X-Received: by 2002:a17:907:1b08:b0:ae0:c092:ee12 with SMTP id a640c23a62f3a-af8fd335d47mr514414966b.22.1753911414061;
        Wed, 30 Jul 2025 14:36:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU+UNzcVLnhtqdg3k8t4IZaqUNYX6eJdTyw40q+0juwL6H+y4IHc+PTci+/T9eOlrpvi9mA3LhywAXgNGp8fI=
X-Received: by 2002:a17:907:1b08:b0:ae0:c092:ee12 with SMTP id
 a640c23a62f3a-af8fd335d47mr514411766b.22.1753911413545; Wed, 30 Jul 2025
 14:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250730200835.80605-1-okorniev@redhat.com> <20250730200835.80605-2-okorniev@redhat.com>
 <8753ffaf-0146-45c6-9189-bd8ea3e74e71@oracle.com>
In-Reply-To: <8753ffaf-0146-45c6-9189-bd8ea3e74e71@oracle.com>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Wed, 30 Jul 2025 17:36:42 -0400
X-Gm-Features: Ac12FXzVg6SWdNfy3Rt77NF_wjgPRdWJbcLlHUN8fnoRnafWxUNAbvZ2xJMzMYU
Message-ID: <CACSpFtB2guwTKbt_kC57BKU2DKWu58Dxhn0Y-eVzXWmCnMUWkw@mail.gmail.com>
Subject: Re: [PATCH 1/4] sunrpc: fix handling of server side tls alerts
To: Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, trondmy@hammerspace.com, anna.schumaker@oracle.com, 
	hch@lst.de, sagi@grimberg.me, kch@nvidia.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org, 
	netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, neil@brown.name, 
	Dai.Ngo@oracle.com, tom@talpey.com, hare@suse.de, horms@kernel.org, 
	kbusch@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JfebuXDpkmlOZhNwOZb8mfRYDPw6SDf9tXcLqOl62I4_1753911414
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250730_143657_820440_57F24713 
X-CRM114-Status: GOOD (  28.71  )
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

On Wed, Jul 30, 2025 at 4:59=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 7/30/25 4:08 PM, Olga Kornievskaia wrote:
> > Scott Mayhew discovered a security exploit in NFS over TLS in
> > tls_alert_recv() due to its assumption it can read data from
> > the msg iterator's kvec..
> >
> > kTLS implementation splits TLS non-data record payload between
> > the control message buffer (which includes the type such as TLS
> > aler or TLS cipher change) and the rest of the payload (say TLS
> > alert's level/description) which goes into the msg payload buffer.
> >
> > This patch proposes to rework how control messages are setup and
> > used by sock_recvmsg().
> >
> > If no control message structure is setup, kTLS layer will read and
> > process TLS data record types. As soon as it encounters a TLS control
> > message, it would return an error. At that point, NFS can setup a
> > kvec backed msg buffer and read in the control message such as a
> > TLS alert. Scott found that msg iterator can advance the kvec
> > pointer as a part of the copy process thus we need to revert the
> > iterator before calling into the tls_alert_recv.
> >
> > Reported-by: Scott Mayhew <smayhew@redhat.com>
> > Fixes: 5e052dda121e ("SUNRPC: Recognize control messages in server-side=
 TCP socket code")
> > Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
> > Suggested-by: Scott Mayhew <smayhew@redhat.com>
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  net/sunrpc/svcsock.c | 43 +++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 35 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> > index 46c156b121db..e2c5e0e626f9 100644
> > --- a/net/sunrpc/svcsock.c
> > +++ b/net/sunrpc/svcsock.c
> > @@ -257,20 +257,47 @@ svc_tcp_sock_process_cmsg(struct socket *sock, st=
ruct msghdr *msg,
> >  }
> >
> >  static int
> > -svc_tcp_sock_recv_cmsg(struct svc_sock *svsk, struct msghdr *msg)
> > +svc_tcp_sock_recv_cmsg(struct socket *sock, unsigned int *msg_flags)
> >  {
> >       union {
> >               struct cmsghdr  cmsg;
> >               u8              buf[CMSG_SPACE(sizeof(u8))];
> >       } u;
> > -     struct socket *sock =3D svsk->sk_sock;
> > +     u8 alert[2];
> > +     struct kvec alert_kvec =3D {
> > +             .iov_base =3D alert,
> > +             .iov_len =3D sizeof(alert),
> > +     };
> > +     struct msghdr msg =3D {
> > +             .msg_flags =3D *msg_flags,
> > +             .msg_control =3D &u,
> > +             .msg_controllen =3D sizeof(u),
> > +     };
> > +     int ret;
> > +
> > +     iov_iter_kvec(&msg.msg_iter, ITER_DEST, &alert_kvec, 1,
> > +                   alert_kvec.iov_len);
> > +     ret =3D sock_recvmsg(sock, &msg, MSG_DONTWAIT);
> > +     if (ret > 0 &&
> > +         tls_get_record_type(sock->sk, &u.cmsg) =3D=3D TLS_RECORD_TYPE=
_ALERT) {
> > +             iov_iter_revert(&msg.msg_iter, ret);
> > +             ret =3D svc_tcp_sock_process_cmsg(sock, &msg, &u.cmsg, -E=
AGAIN);
> > +     }
> > +     return ret;
> > +}
> > +
> > +static int
> > +svc_tcp_sock_recvmsg(struct svc_sock *svsk, struct msghdr *msg)
> > +{
> >       int ret;
> > +     struct socket *sock =3D svsk->sk_sock;
> >
> > -     msg->msg_control =3D &u;
> > -     msg->msg_controllen =3D sizeof(u);
> >       ret =3D sock_recvmsg(sock, msg, MSG_DONTWAIT);
> > -     if (unlikely(msg->msg_controllen !=3D sizeof(u)))
> > -             ret =3D svc_tcp_sock_process_cmsg(sock, msg, &u.cmsg, ret=
);
> > +     if (msg->msg_flags & MSG_CTRUNC) {
> > +             msg->msg_flags &=3D ~(MSG_CTRUNC | MSG_EOR);
> > +             if (ret =3D=3D 0 || ret =3D=3D -EIO)
> > +                     ret =3D svc_tcp_sock_recv_cmsg(sock, &msg->msg_fl=
ags);
> > +     }
> >       return ret;
> >  }
> >
> > @@ -321,7 +348,7 @@ static ssize_t svc_tcp_read_msg(struct svc_rqst *rq=
stp, size_t buflen,
> >               iov_iter_advance(&msg.msg_iter, seek);
> >               buflen -=3D seek;
> >       }
> > -     len =3D svc_tcp_sock_recv_cmsg(svsk, &msg);
> > +     len =3D svc_tcp_sock_recvmsg(svsk, &msg);
> >       if (len > 0)
> >               svc_flush_bvec(bvec, len, seek);
> >
> > @@ -1018,7 +1045,7 @@ static ssize_t svc_tcp_read_marker(struct svc_soc=
k *svsk,
> >               iov.iov_base =3D ((char *)&svsk->sk_marker) + svsk->sk_tc=
plen;
> >               iov.iov_len  =3D want;
> >               iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, want);
> > -             len =3D svc_tcp_sock_recv_cmsg(svsk, &msg);
> > +             len =3D svc_tcp_sock_recvmsg(svsk, &msg);
> >               if (len < 0)
> >                       return len;
> >               svsk->sk_tcplen +=3D len;
>
> Fwiw, I've already pulled 1/4 into nfsd-testing. But 4/4 might not apply
> until the others are in the tree. We might want these to go through a
> single tree.
>
> Or, can we delay 4/4 until 6.18 ?

Delaying 4/4 until 6.18 sounds fine to me.

>
>
> --
> Chuck Lever
>


