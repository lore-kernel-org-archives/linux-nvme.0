Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C355DCCD1AB
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 04:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lj64m4sFpQ+vBQ3pmykp/cp6K9VYRj1HaNi/Sdpj2VM=; b=H+l1njLE0c26+9oG5soLHSSzO6
	eR3EXCiIy8Y1DD6Bn9iuL2sh7wk+rP6NHOVnGaHIdRZlMRpLf6+fLrPognleJvzcFdLev8rvmTf8B
	+7fONhklak9s5idhAabt5x6tD/18QPgRwVfrgO+BOUUKcfCx8PIsTQzuqpic+SG1Q+EX4aiRFJT+h
	Bain/I7iFXBrLeX507O0ug8KApOR23GMVZxeigUm1IbTkETYk6Jo0ziJc9U58dNZAjird6C0k6wol
	FvumcbJxVIsJgsN5V7j553e2VvzW41gwxw+YhsN3g9lx/OXF0xSDUGtb0D5nLjzvU5sGo2dbyD63z
	U19gxCdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBQZW-00000001RiE-3k5N;
	Wed, 22 Oct 2025 04:35:38 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBQZU-00000001RhD-2cSx
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 04:35:37 +0000
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-b50645ecfbbso1254110366b.1
        for <linux-nvme@lists.infradead.org>; Tue, 21 Oct 2025 21:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761107734; x=1761712534; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lj64m4sFpQ+vBQ3pmykp/cp6K9VYRj1HaNi/Sdpj2VM=;
        b=ew9w1CN0ipMklg1m3uHnVmiHxcmuXLjge2lv3GF+QWdj6NuDvt0uWbDEluP2WLWc4a
         bZJ3YtgRJxSUNl457LOX5EPP9m7DXd4gu79T4BdztubBGsY/1ZM1b59y0wNiH3g67EDV
         L5PywekpDWtSywH3wSmK4WROqSd1xna1dv7nvvIxNE4+HnYAZabCgQmJngg1d7ykOS+y
         CHM5KxPwsSXZiks/XWnvOtuuIEcoVo5zkPT7Tuedy82XKXIkWjsk8A96/q3hOCUwwNpX
         jqHZj6hGHZIkQs+Q+QNaFPLdX8kak/ewKGw4FmdEWl+WoeFT0if5uXmkTc7A+97nbZfL
         xlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761107734; x=1761712534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lj64m4sFpQ+vBQ3pmykp/cp6K9VYRj1HaNi/Sdpj2VM=;
        b=dKXaP/DhhCRMNQR4OGC+uWA6v76gATEpbtkrXYKLn9MmdM513vYXv50WM3Rz/OQj6y
         dEB9VQUS5Rx8M89U8Y+urgt7h/LbatTF/wLLLqnqaj86GcVbEQvwqJSg6liS7jwhnz4I
         GhlalCUPiByK4Ukr6F8/3PTK8sp+LFj1a3gseOF3WpkhHBN4l6s4pHiBkSnCCaP7G4qV
         B0l5H/RctPqC2kNz/UifvciMxTfV/SA5WfiVbjAPldJJF1X9KYTnNF5x1rEiLMnC5NBy
         LDEIs4Ci3taMqWxekmfadHYITS9DMhcwkIR9hmHbpiyr5gH9vgWpYevgS0FzvqOfhxd7
         TOKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/kQp4SscRbbjsdGqbx0IzjBB5wfTzEHLbrd3sw6DmxMkD18TChN3hNeDpF1rdQkGoEvNz2mPNjX7p@lists.infradead.org
X-Gm-Message-State: AOJu0YwF0HcAfNPBtRzIAl7a3Do0r7WXCR8uJ5BWgyPdFGr/+azkPqHz
	QPMlMVhJMJFhxhhhc9X+XqYzIvjmAb5e4LNgrYl18zhM4zeLCoR8DZsEo7eNKZxX1AzIXW+jW2x
	Iclg7gnbQZL+YeX9vn13da81KqP1aRvo=
X-Gm-Gg: ASbGncveSX4h2LYJFMkB/VzOOUZV/yBVrv5xMO/cgck8nKPBriFIazqO6JmYmNLyaMq
	eap1BlGFG46Fc0qC9Jh+WNznawoEthHjnWlvcmT9uxdyyxTSs6TAPFkCsviGo2346S+NrnkGh90
	TITBUXPKLARsf2FSyfKQL4XcCSh89GUxDhCEf7M2PXklYJcHljM6hp+AFizXUDLBmzuUCLDelka
	/i4FvQQqyYcCyvSXmteNbn7CvZIIx2vrisZasqPj3VQSqk34DUTexv+H8b0MldYFpD9j6Q3F2k+
	Te3EcUVQdRNnEEJurMv8yPj+ug==
X-Google-Smtp-Source: AGHT+IEZ3WUWSBwKFpcrNZdWHcs2uENHhK+jxYuhPktOZEvX65BdGAZNuCfRsdi3SwrTO654hvsTxTI1H3lWOnGyc2U=
X-Received: by 2002:a17:907:3f25:b0:b40:5dac:ed3f with SMTP id
 a640c23a62f3a-b6472b6047fmr2009158266b.7.1761107734076; Tue, 21 Oct 2025
 21:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
 <20251017042312.1271322-6-alistair.francis@wdc.com> <dc19d073-0266-4143-9c74-08e30a90b875@suse.de>
In-Reply-To: <dc19d073-0266-4143-9c74-08e30a90b875@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Oct 2025 14:35:07 +1000
X-Gm-Features: AS18NWBbcQHf212IwDSHi_pCF6tkVLcWMLdXbgbTquHdoKUeBkgiVMl2L0_vC_o
Message-ID: <CAKmqyKNBN7QmpC8Lb=0xKJ7u9Vru2mfTktwKgtyQURGmq4gUtg@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] nvme-tcp: Support KeyUpdate
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
X-CRM114-CacheID: sfid-20251021_213536_719081_71AB2350 
X-CRM114-Status: GOOD (  41.20  )
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

On Mon, Oct 20, 2025 at 4:22=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 10/17/25 06:23, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > If the nvme_tcp_try_send() or nvme_tcp_try_recv() functions return
> > EKEYEXPIRED then the underlying TLS keys need to be updated. This occur=
s
> > on an KeyUpdate event.
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
> > Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
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
> >   drivers/nvme/host/tcp.c | 60 ++++++++++++++++++++++++++++++++++------=
-
> >   1 file changed, 51 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index 2696bf97dfac..791e0cc91ad8 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -172,6 +172,7 @@ struct nvme_tcp_queue {
> >       bool                    tls_enabled;
> >       u32                     rcv_crc;
> >       u32                     snd_crc;
> > +     key_serial_t            user_session_id;
> >       __le32                  exp_ddgst;
> >       __le32                  recv_ddgst;
> >       struct completion       tls_complete;
> > @@ -858,7 +859,10 @@ static void nvme_tcp_handle_c2h_term(struct nvme_t=
cp_queue *queue,
> >   static int nvme_tcp_recvmsg_pdu(struct nvme_tcp_queue *queue)
> >   {
> >       char *pdu =3D queue->pdu;
> > +     char cbuf[CMSG_LEN(sizeof(char))] =3D {};
> >       struct msghdr msg =3D {
> > +             .msg_control =3D cbuf,
> > +             .msg_controllen =3D sizeof(cbuf),
> >               .msg_flags =3D MSG_DONTWAIT,
> >       };
> >       struct kvec iov =3D {
> > @@ -873,12 +877,17 @@ static int nvme_tcp_recvmsg_pdu(struct nvme_tcp_q=
ueue *queue)
> >       if (ret <=3D 0)
> >               return ret;
> >
> > +     hdr =3D queue->pdu;
> > +     if (hdr->type =3D=3D TLS_HANDSHAKE_KEYUPDATE) {
> > +             dev_err(queue->ctrl->ctrl.device, "KeyUpdate message\n");
> > +             return 1;
> > +     }
> > +
> >       queue->pdu_remaining -=3D ret;
> >       queue->pdu_offset +=3D ret;
> >       if (queue->pdu_remaining)
> >               return 0;
> >
> > -     hdr =3D queue->pdu;
> >       if (unlikely(hdr->hlen !=3D sizeof(struct nvme_tcp_rsp_pdu))) {
> >               if (!nvme_tcp_recv_pdu_supported(hdr->type))
> >                       goto unsupported_pdu;
> > @@ -944,6 +953,7 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_qu=
eue *queue)
> >       struct request *rq =3D
> >               nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
> >       struct nvme_tcp_request *req =3D blk_mq_rq_to_pdu(rq);
> > +     char cbuf[CMSG_LEN(sizeof(char))] =3D {};
> >
> >       if (nvme_tcp_recv_state(queue) !=3D NVME_TCP_RECV_DATA)
> >               return 0;
> > @@ -973,12 +983,14 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_=
queue *queue)
> >               memset(&msg, 0, sizeof(msg));
> >               msg.msg_iter =3D req->iter;
> >               msg.msg_flags =3D MSG_DONTWAIT;
> > +             msg.msg_control =3D cbuf,
> > +             msg.msg_controllen =3D sizeof(cbuf),
> >
> Watch out. This is the recvmsg bug Olga had been posting patches for.
> Thing is, if there is a control message the networking code will place
> the control message payload into the message buffer. But in doing so
> it expects the message buffer to be an iovec, not a bio vec.
>
> To handle this properly you'd need to _not_ set the control buffer,
> but rather check for 'MSG_CTRUNC' in msg_flags upon return.
> Then you have to setup a new message with msg_control set and
> a suitable msg_len (5 bytes, wasn't it?) and re-issue recvmsg
> with that message.

Fixed

>
> And keep fingers crossed that you don't get MSG_CTRUNC on every
> call to recvmsg() ...
>
> >               ret =3D sock_recvmsg(queue->sock, &msg, msg.msg_flags);
> >               if (ret < 0) {
> > -                     dev_err(queue->ctrl->ctrl.device,
> > -                             "queue %d failed to receive request %#x d=
ata",
> > -                             nvme_tcp_queue_id(queue), rq->tag);
> > +                     dev_dbg(queue->ctrl->ctrl.device,
> > +                             "queue %d failed to receive request %#x d=
ata, %d",
> > +                             nvme_tcp_queue_id(queue), rq->tag, ret);
> >                       return ret;
> >               }
> >               if (queue->data_digest)
> > @@ -1381,17 +1393,42 @@ static int nvme_tcp_try_recvmsg(struct nvme_tcp=
_queue *queue)
> >               }
> >       } while (result >=3D 0);
> >
> > -     if (result < 0 && result !=3D -EAGAIN) {
> > +     if (result =3D=3D -EKEYEXPIRED) {
> > +             return -EKEYEXPIRED;
> > +     } else if (result =3D=3D -EAGAIN) {
> > +             return -EAGAIN;
> > +     } else if (result < 0) {
> >               dev_err(queue->ctrl->ctrl.device,
> >                       "receive failed:  %d\n", result);
> >               queue->rd_enabled =3D false;
> >               nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> > -     } else if (result =3D=3D -EAGAIN)
> > -             result =3D 0;
> > +     }
> >
> >       return result < 0 ? result : (queue->nr_cqe =3D nr_cqe);
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
> > +     flush_work(&(queue->ctrl->ctrl).async_event_work);
> > +
> > +     ret =3D nvme_tcp_start_tls(&(queue->ctrl->ctrl),
> > +                              queue, queue->ctrl->ctrl.tls_pskid,
> > +                              HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
> > +
> > +     if (ret < 0) {
> > +             dev_err(queue->ctrl->ctrl.device,
> > +                     "failed to update the keys %d\n", ret);
> > +             nvme_tcp_fail_request(queue->request);
> > +             nvme_tcp_done_send_req(queue);
> > +     }
> > +}
> > +
> >   static void nvme_tcp_io_work(struct work_struct *w)
> >   {
> >       struct nvme_tcp_queue *queue =3D
> > @@ -1414,8 +1451,11 @@ static void nvme_tcp_io_work(struct work_struct =
*w)
> >               result =3D nvme_tcp_try_recvmsg(queue);
> >               if (result > 0)
> >                       pending =3D true;
> > -             else if (unlikely(result < 0))
> > -                     return;
> > +             else if (unlikely(result < 0)) {
> > +                     if (result =3D=3D -EKEYEXPIRED)
> > +                             update_tls_keys(queue);
> > +                     break;
> > +             }
> >
> >               /* did we get some space after spending time in recv? */
> >               if (nvme_tcp_queue_has_pending(queue) &&
> > @@ -1723,6 +1763,7 @@ static void nvme_tcp_tls_done(void *data, int sta=
tus, key_serial_t pskid,
> >                       ctrl->ctrl.tls_pskid =3D key_serial(tls_key);
> >               key_put(tls_key);
> >               queue->tls_err =3D 0;
> > +             queue->user_session_id =3D user_session_id;
>
> Hmm. I wonder, do we need to store the generation number somewhere?
> Currently the sysfs interface is completely oblivious that a key update
> has happened. I really would like to have _some_ indicator there telling
> us that a key update had happened, and the generation number would be
> ideal here.

I don't follow.

The TLS layer will report the number of KeyUpdates that have been
received. Userspace also knows that a KeyUpdate happened as we call to
userspace to handle updating the keys.

Alistair

>
> >       }
> >
> >   out_complete:
> > @@ -1752,6 +1793,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *n=
ctrl,
> >               keyring =3D key_serial(nctrl->opts->keyring);
> >       args.ta_keyring =3D keyring;
> >       args.ta_timeout_ms =3D tls_handshake_timeout * 1000;
> > +     args.user_session_id =3D queue->user_session_id;
> >       queue->tls_err =3D -EOPNOTSUPP;
> >       init_completion(&queue->tls_complete);
> >       if (keyupdate =3D=3D HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
>
> Chers,
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

