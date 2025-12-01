Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02520D116F3
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 23:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I5v1/VXYzTJjMPpWg21e/KcaL7VxnGFLf4XvfhndU1c=; b=b49Ouugm+LtEG8bV8p4fMnw7Qh
	kYJuduRUGYorrIfw9jCcjl8Dko9SA6pcG6gZbgfgF5B50kDv0vrMib2zMV/5P2m9CGcGCHM9Uv01b
	45A49ncE4rzd7V1WlLFUYTjLmszkExJHnBtykk50iiWV9XXxVhfnok1BqJq7NItNsnuTUQvEz6vtR
	B5FfllCesZgTgI+AFEdO0IiOtgEUW6SXPJDSDfaMmM+ttqiz5Z9OcNdAcL1Y+6IbpzJs3eNnO/dzd
	X6xLVa+KA7QTmtOJJJxueimgZpciWi7GOBwxlvnItxRUYTeu4kNPjc7kPljcVO9RAlx3+zF5MWIHM
	1dSMs47g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQDJ6-00000004cMo-039t;
	Mon, 01 Dec 2025 23:27:48 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQDJ2-00000004cMR-272o
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 23:27:46 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-b7697e8b01aso937844266b.2
        for <linux-nvme@lists.infradead.org>; Mon, 01 Dec 2025 15:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764631662; x=1765236462; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5v1/VXYzTJjMPpWg21e/KcaL7VxnGFLf4XvfhndU1c=;
        b=Fwh3JYZaDln05iP0dkKgIcXgLXoCtFyc4OJV0qLVwn8BdDszZ1HKK1XCK/E323++DQ
         0xB2jwy30NsOyBInnJWVu+6WkLFmrowQPmepx4TL1eNTd0skMelam0RJgZc2fy1uMSBM
         4LNUSPP1ByFjtzWQo0zo9JvJCcaqDxms6H9K7yCH2RD4OCWhi4XmZCxYnVrVvWqadIgC
         pOxzCZd0BBSUkzcDR2IbqRDrthucl2S9iInKBXQWpM0Pv4Old+HRUSuvPqLy8YX1oqg3
         41NS1OprloTlnCtU0sIDqd3xfbubB30/NxqkahoD0u1iB0Ygo8Jk+FqM0rZAxGItuTPo
         aMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764631662; x=1765236462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I5v1/VXYzTJjMPpWg21e/KcaL7VxnGFLf4XvfhndU1c=;
        b=bVXYem4Pb2LZjBatSw5OlvSUTdxxQ2KA+l7AUDUVBLxaA/rnHUteGeKxcwCEMotuPa
         izaXPGzahIqkDv4aK+7Jqb52NK/s5nVV4j+/I3Qu/nvGeigtekx3SQ9ha5dEHSbpGu9R
         n/QMmnbgyYKBuf+8w6XYnX4lg52zfvRKIt08oMakndumZi/JasFHkmzdkHmEZUxc9Ccg
         mD5UYHYY69amWc7FkIYC7ef9W37s1aLb9iBlDOeD0+WnSm8zcO9r2PNMHpIhKDeTNaxu
         Vv3CljrB0juRneBI/B1Sz/FbHxFQxjlsGO7UchdVRzws/0MrEhBD8dBIL0dto7YqJdoY
         nzgA==
X-Forwarded-Encrypted: i=1; AJvYcCWo5JwAGM9EiJ53iIhVjv6xa5Mq9PRIOxiG5P1h+63lH8/CcD+etzBuJlUADFaZHHIr388Edz5UCSFq@lists.infradead.org
X-Gm-Message-State: AOJu0YwizO8VpUbM9hBK1Uv4Ls1A5APa4EZmgTS8zoF983pN0ugwiRtQ
	wH03Tl7CdcRMHzT6I8jM3MFnT8K6ppEXcwR9dY79Hrkw65G7+6VIGe09Kt8ojC1haOR1Yg4hXXx
	QhBRHYly/DIoYIw1W4o6IMg2Au3LqsBI=
X-Gm-Gg: ASbGncsgrfdvaufWUOGIwH8KvXlobmEhRzKGz6VugaofD6GMj6lfT292aCfnO+r/ePi
	QBQVge7AOuQlgSqSBu35LkSAQDh080IgBBB+/ZxQRq3ESRHWj9aBpQgBj58Sz/JniGWRG8TLncg
	9VMDNJxG/MeNdD4b417CRy7Cg4Lvp1oVLVTtz9Qt6fSg8mwbFdRxnMP9M5w9m6khFa+wFyLBVd4
	MVBLjlv+wdEROZ8bNE4qd5ZovWa6Fc1g21Q+EF2oFp5/PA+lrM4gmhdfht89syoVhljlf+Z3+lK
	vWV434rKEVHW+nq+xfJnXaXmHg==
X-Google-Smtp-Source: AGHT+IF9jmZyoLWFSx4hBdg0tZdsiQqccPSCxC9NjkJhrPQdxcaCTCtSHGJiP4lrMAOk35kCgFsaz5zURXiOG0ANOnM=
X-Received: by 2002:a17:907:1b28:b0:b73:6f8c:612b with SMTP id
 a640c23a62f3a-b76715653d5mr4425120366b.16.1764631662278; Mon, 01 Dec 2025
 15:27:42 -0800 (PST)
MIME-Version: 1.0
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-6-alistair.francis@wdc.com> <1184961b-5488-4150-b647-29ed363e2276@grimberg.me>
In-Reply-To: <1184961b-5488-4150-b647-29ed363e2276@grimberg.me>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 2 Dec 2025 09:27:15 +1000
X-Gm-Features: AWmQ_bk8CEM-2dviwMQHZxPcd6nv4bajHpJYpbv7ORWXtEq1tzS6ym3A8-DNYFg
Message-ID: <CAKmqyKPe_o8Yaa0uNd-PeGgT1GONwuLxjATRHW9a-6DV7c=4nA@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] nvme-tcp: Support KeyUpdate
To: Sagi Grimberg <sagi@grimberg.me>
Cc: chuck.lever@oracle.com, hare@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, kbusch@kernel.org, 
	axboe@kernel.dk, hch@lst.de, kch@nvidia.com, hare@suse.de, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_152744_589193_F6192F85 
X-CRM114-Status: GOOD (  38.75  )
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

On Mon, Dec 1, 2025 at 8:31=E2=80=AFAM Sagi Grimberg <sagi@grimberg.me> wro=
te:
>
>
>
> On 12/11/2025 6:27, alistair23@gmail.com wrote:
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
>
> I see this is on top of Hannes recvmsg patch. Worth noting in the patch
> here at least.
>
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
> >   drivers/nvme/host/tcp.c | 85 +++++++++++++++++++++++++++++++++-------=
-
> >   1 file changed, 70 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index 4797a4532b0d..5cec5a974bbf 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -172,6 +172,7 @@ struct nvme_tcp_queue {
> >       bool                    tls_enabled;
> >       u32                     rcv_crc;
> >       u32                     snd_crc;
> > +     key_serial_t            handshake_session_id;
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
> > @@ -976,10 +986,26 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_=
queue *queue)
> >
> >               ret =3D sock_recvmsg(queue->sock, &msg, msg.msg_flags);
> >               if (ret < 0) {
> > -                     dev_err(queue->ctrl->ctrl.device,
> > -                             "queue %d failed to receive request %#x d=
ata",
> > -                             nvme_tcp_queue_id(queue), rq->tag);
> > -                     return ret;
> > +                     /* If MSG_CTRUNC is set, it's a control message,
> > +                      * so let's read the control message.
> > +                      */
> > +                     if (msg.msg_flags & MSG_CTRUNC) {
> > +                             memset(&msg, 0, sizeof(msg));
> > +                             msg.msg_flags =3D MSG_DONTWAIT;
> > +                             msg.msg_control =3D cbuf;
> > +                             msg.msg_controllen =3D sizeof(cbuf);
> > +
> > +                             ret =3D sock_recvmsg(queue->sock, &msg, m=
sg.msg_flags);
> > +                     }
> > +
> > +                     if (ret < 0) {
> > +                             dev_dbg(queue->ctrl->ctrl.device,
> > +                                     "queue %d failed to receive reque=
st %#x data, %d",
> > +                                     nvme_tcp_queue_id(queue), rq->tag=
, ret);
> > +                             return ret;
> > +                     }
> > +
> > +                     return 0;
> >               }
> >               if (queue->data_digest)
> >                       nvme_tcp_ddgst_calc(req, &queue->rcv_crc, ret);
> > @@ -1384,15 +1410,39 @@ static int nvme_tcp_try_recvmsg(struct nvme_tcp=
_queue *queue)
> >               }
> >       } while (result >=3D 0);
> >
> > -     if (result < 0 && result !=3D -EAGAIN) {
> > -             dev_err(queue->ctrl->ctrl.device,
> > -                     "receive failed:  %d\n", result);
> > -             queue->rd_enabled =3D false;
> > -             nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> > -     } else if (result =3D=3D -EAGAIN)
> > -             result =3D 0;
> > +     if (result < 0) {
> > +             if (result !=3D -EKEYEXPIRED && result !=3D -EAGAIN) {
> > +                     dev_err(queue->ctrl->ctrl.device,
> > +                             "receive failed:  %d\n", result);
> > +                     queue->rd_enabled =3D false;
> > +                     nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> > +             }
> > +             return result;
> > +     }
> > +
> > +     queue->nr_cqe =3D nr_cqe;
> > +     return nr_cqe;
> > +}
> > +
> > +static void update_tls_keys(struct nvme_tcp_queue *queue)
> > +{
> > +     int qid =3D nvme_tcp_queue_id(queue);
> > +     int ret;
> > +
> > +     dev_dbg(queue->ctrl->ctrl.device,
> > +             "updating key for queue %d\n", qid);
> >
> > -     return result < 0 ? result : (queue->nr_cqe =3D nr_cqe);
> > +     flush_work(&(queue->ctrl->ctrl).async_event_work);
> > +
> > +     ret =3D nvme_tcp_start_tls(&(queue->ctrl->ctrl),
> > +                              queue, queue->ctrl->ctrl.tls_pskid,
> > +                              HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
>
> No need to quiesce the queue or anything like that? everything continues
> as usual?

Everything just continues as usual. Besides a drop in throughput
waiting for the KeyUpdate you don't notice it. For testing I trigger
an update every 30 packets, it's slow but works

> Why are you flushing async_event_work?

I think that's just leftover from earlier, I'll remove it

Alistair

