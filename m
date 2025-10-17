Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EC3CCD199
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Oct 2025 01:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jg3YC8a6su9LqTbpQvqj8XsjlAAqUYFX939NA7tC+rk=; b=0Spo32bXvUCJR5XtCLxi33mi70
	B6Xmy2J4zw/pP6dTVb3M06ehT9Mrhgu7KhxOWY4kUz6dOJrAIhOt6K6jDTrZBkD64AViKGKxyxdcV
	VvTsYiN6rvi8vW5giF1G0eP9Vsrqilvr/UvvACyiec1Ia2/ZY9Y+TO5U76I7oXh0ikIjY0pqAVG6w
	GWCcF5Fuz9cWzqr/BVEoaCOpj6EsnqrVsngV+TQEDuVUkH8UwNXTNSFs8b5Zdj+exU6z7Aqk71vLN
	a3fnJA5rIGqA3skINLNB5IowdP6KYN2fvF1Z1fPG+TPJSuguZqjD4W0WqYwGwunF8CA5FInminbLX
	Cs4MIMSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9Zey-00000006Mkt-178Y;
	Fri, 17 Oct 2025 01:53:36 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9Zev-00000006MkW-3Wz5
	for linux-nvme@lists.infradead.org;
	Fri, 17 Oct 2025 01:53:35 +0000
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-63c1a0d6315so1743617a12.1
        for <linux-nvme@lists.infradead.org>; Thu, 16 Oct 2025 18:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760666011; x=1761270811; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jg3YC8a6su9LqTbpQvqj8XsjlAAqUYFX939NA7tC+rk=;
        b=Q6dQDwlysm7Tq9wjqdVaWFYdKfyyHZ4KGg3QEIGCSkaIjGFomRrYoipi5U4dkt/6rm
         ZafvXBMjDaY61AlMP0Z/NjmtTN+ZHNZRJ5NI41en0tUTrwapJZMab811WHTt7NhooIIZ
         eRo8dJQ3oKkyYGlwuqM3lW7ogdb/vBtEz8NeZFBEbThhCWuKOTVOaQO5ZjYXjoYKMEYR
         crZz+vjiw/JiXkLuEh4hzR+uSh7MIBFatFtn7LQW+sWsHteOHy4znFNVVW5Ja20YgAz3
         KaPEtnWr+dI3UrcWJdC8rz+dRufglIjc9iMZjMb5uZje+yZctAQslzS+m7YRzVMDYbav
         732Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760666011; x=1761270811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jg3YC8a6su9LqTbpQvqj8XsjlAAqUYFX939NA7tC+rk=;
        b=bqZ+0gEY37ak38ErKYZaOVgwFGRrONbHqtC4YDCrejInmMbNYPA2+u2km3fL1C1dO8
         sQkRy9ucPM8HQk8IUIiWIUuopPqRu1gONUYD1f9GNycLQwZu3Ge6TOolycjdXW/GjDgD
         DNjaXcgmvFTFosvCAtRT0Apv1EO6SVyCyvB3SPvcI+z17e37SanPKpTv4pm7R2wllKaE
         dFzn00vXfHX81gmOuLtf97xDuCqLhz7CO9qzRWygsejkkFyEktDGyVD2DkmqaPbKMjK1
         M8r6Io6JdxZv7g6xD4ARtN7LQIchei87dFlStF4410nryytZK8TE3p+QViK68Sf53m/I
         Ae8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaYCxe3voVZh+2gM3XYggjCThLOJCurwcXJvkFPxIR24wUzgk9hPDoxLYfjB9sZ5kSY6f/r2scd/Hy@lists.infradead.org
X-Gm-Message-State: AOJu0YyAZmA0NU16gHo424cO7wcvLLILi2kUfKwMvhAF2hyxWW+N7D0P
	/CJ6Rs4sjSAW8t++aj2Qo9UA9y9xP3EVJJ0hQ7xL/IdUBwavmZWhP+4WMFEAqo2n1cocRV9Fg34
	dpxkAQG/atLFNovCItIvEO7GHLGNIppI=
X-Gm-Gg: ASbGncsd9FS8dk6hku7V7EbywAcFXPWYdj2kYmcHvgp0GxAoEk6qm/G0VjgeZznlUi1
	PHPWAPTAp7fC17Ewou86plM5Y0wVZQ2MpTGI6/SJLK9jfXstICewdpQw1m9Bc3roig2yxCG4mnk
	wjpcBGcHJEU57hUxswHjiptFyZbpTdPIYqxJwjlFKsENmyB6ukr8ynCcex+fu9KAL4fyPM0clTh
	//pHiEwxakTMca4TK1/1UJfsqNaW2NIumMYxyVtzT9mp19bt28p0dNuwQqECZkZAYHwLQuopMC9
	TPXJ7+NvqZMIwLA=
X-Google-Smtp-Source: AGHT+IEwGE2DyBw79hahqoYYl+Io8sAm9x+p/Mvm4N2Yz5vRAjrfFya1X4ses6e0GFt/zr8ZT03UC+13/oAZmSfJwPQ=
X-Received: by 2002:a05:6402:3506:b0:63c:11cd:be57 with SMTP id
 4fb4d7f45d1cf-63c1f626e7cmr1509380a12.5.1760666011447; Thu, 16 Oct 2025
 18:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
 <20251003043140.1341958-8-alistair.francis@wdc.com> <591a7eb8-563c-4368-b868-880ed081a432@suse.de>
In-Reply-To: <591a7eb8-563c-4368-b868-880ed081a432@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Oct 2025 11:53:04 +1000
X-Gm-Features: AS18NWAQRox_cHhQyvz94xO43zDLu8kahziESzW1tlno9LjS2bcAJiNBl10LBPE
Message-ID: <CAKmqyKNupEy8dj4B9a8NWymVJTQs_mpeQynLSdCPrO3rBYnByA@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] nvmet-tcp: Support KeyUpdate
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
X-CRM114-CacheID: sfid-20251016_185333_946073_EB32D301 
X-CRM114-Status: GOOD (  36.37  )
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

On Mon, Oct 6, 2025 at 4:48=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrote=
:
>
> On 10/3/25 06:31, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > If the nvmet_tcp_try_recv() function return EKEYEXPIRED or if we receiv=
e
> > a KeyUpdate handshake type then the underlying TLS keys need to be
> > updated.
> >
> > If the NVMe Host (TLS client) initiates a KeyUpdate this patch will
> > allow the NVMe layer to process the KeyUpdate request and forward the
> > request to userspace. Userspace must then update the key to keep the
> > connection alive.
> >
> > This patch allows us to handle the NVMe host sending a KeyUpdate
> > request without aborting the connection. At this time we don't support
> > initiating a KeyUpdate.
> >
> > Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> > v3:
> >   - Use a write lock for sk_user_data
> >   - Fix build with CONFIG_NVME_TARGET_TCP_TLS disabled
> >   - Remove unused variable
> > v2:
> >   - Use a helper function for KeyUpdates
> >   - Ensure keep alive timer is stopped
> >   - Wait for TLS KeyUpdate to complete
> >
> >   drivers/nvme/target/tcp.c | 90 ++++++++++++++++++++++++++++++++++++--=
-
> >   1 file changed, 85 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> > index bee0355195f5..fd59dd3ca632 100644
> > --- a/drivers/nvme/target/tcp.c
> > +++ b/drivers/nvme/target/tcp.c
> > @@ -175,6 +175,7 @@ struct nvmet_tcp_queue {
> >
> >       /* TLS state */
> >       key_serial_t            tls_pskid;
> > +     key_serial_t            user_session_id;
> >       struct delayed_work     tls_handshake_tmo_work;
> >
> >       unsigned long           poll_end;
> > @@ -186,6 +187,8 @@ struct nvmet_tcp_queue {
> >       struct sockaddr_storage sockaddr_peer;
> >       struct work_struct      release_work;
> >
> > +     struct completion       tls_complete;
> > +
> >       int                     idx;
> >       struct list_head        queue_list;
> >
> > @@ -836,6 +839,11 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp=
_queue *queue,
> >       return 1;
> >   }
> >
> > +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> > +static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue);
> > +static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w);
> > +#endif
> > +
> >   static int nvmet_tcp_try_send(struct nvmet_tcp_queue *queue,
> >               int budget, int *sends)
> >   {
>
> And we need this why?
>
> > @@ -844,6 +852,13 @@ static int nvmet_tcp_try_send(struct nvmet_tcp_que=
ue *queue,
> >       for (i =3D 0; i < budget; i++) {
> >               ret =3D nvmet_tcp_try_send_one(queue, i =3D=3D budget - 1=
);
> >               if (unlikely(ret < 0)) {
> > +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> > +                     if (ret =3D=3D -EKEYEXPIRED &&
> > +                             queue->state !=3D NVMET_TCP_Q_DISCONNECTI=
NG &&
> > +                             queue->state !=3D NVMET_TCP_Q_TLS_HANDSHA=
KE) {
> > +                                     goto done;
> > +                     }
> > +#endif
> >                       nvmet_tcp_socket_error(queue, ret);
> >                       goto done;
> >               } else if (ret =3D=3D 0) {
>
> See my comment to the host patches. Handling an incoming KeyUpdate is
> vastly different than initiating a KeyUpdate. _and_ the network stack
> will only ever return -EKEYEXPIRED on receive.
> So please split the patches in handling an incoming KeyUpdate and
> initiating a KeyUpdate.

Ok, removed from both.

>
> > @@ -1110,6 +1125,45 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
> >       return false;
> >   }
> >
> > +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> > +static int update_tls_keys(struct nvmet_tcp_queue *queue)
> > +{
> > +     int ret;
> > +
> > +     cancel_work(&queue->io_work);
> > +     queue->state =3D NVMET_TCP_Q_TLS_HANDSHAKE;
> > +
> > +     /* Restore the default callbacks before starting upcall */
> > +     write_lock_bh(&queue->sock->sk->sk_callback_lock);
> > +     queue->sock->sk->sk_data_ready =3D  queue->data_ready;
> > +     queue->sock->sk->sk_state_change =3D queue->state_change;
> > +     queue->sock->sk->sk_write_space =3D queue->write_space;
> > +     queue->sock->sk->sk_user_data =3D NULL;
> > +     write_unlock_bh(&queue->sock->sk->sk_callback_lock);
> > +
> We do have a function for this ...
>
> > +     nvmet_stop_keep_alive_timer(queue->nvme_sq.ctrl);
> > +
> > +     INIT_DELAYED_WORK(&queue->tls_handshake_tmo_work,
> > +                       nvmet_tcp_tls_handshake_timeout);
> > +
> > +     ret =3D nvmet_tcp_tls_handshake(queue, HANDSHAKE_KEY_UPDATE_TYPE_=
RECEIVED);
> > +
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D wait_for_completion_interruptible_timeout(&queue->tls_com=
plete, 10 * HZ);
> > +
> > +     if (ret <=3D 0) {
> > +             tls_handshake_cancel(queue->sock->sk);
> > +             return ret;
> > +     }
> > +
> > +     queue->state =3D NVMET_TCP_Q_LIVE;
> > +
> > +     return ret;
> > +}
> > +#endif
> > +
> >   static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
> >               struct msghdr *msg, char *cbuf)
> >   {
> > @@ -1135,6 +1189,9 @@ static int nvmet_tcp_tls_record_ok(struct nvmet_t=
cp_queue *queue,
> >                       ret =3D -EAGAIN;
> >               }
> >               break;
> > +     case TLS_RECORD_TYPE_HANDSHAKE:
> > +             ret =3D -EAGAIN;
> > +             break;
>
> Shouldn't this be rather -EKEYEXPIRED?

It shouldn't be. The TLS layer returns -EKEYEXPIRED and we update the
keys. TLS_RECORD_TYPE_HANDSHAKE occurs after the KeyUpdate when the
NVMe layer reads the KeyUpdate message, but we have already acted on
the KeyUpdate from the -EKEYEXPIRED returned by the TLS layer.
Basically the TLS layer handles decoding the KeyUpdate (already in
mainline) and returning -EKEYEXPIRED which kicks off the KeyUpdate.
This is just us clearing the message from the TLS buffer.

Alistair

