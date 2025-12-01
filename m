Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB0ED111A8
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 04:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AMVbFQJwrtDT4Z0LvdOkvQwxkH7n3jhJLvQGPrvBilI=; b=IxEQ+zghXJ9GBU9Joeiatc1Eix
	CZUjx3+ojjqlcjZeZC/UDb+Co9x9v7LzN6jMAauNzR43b3IZKNYleu9ARI2yfZRZzGpaNqb+MSx3V
	nYkeecHKmFr4xI45Mx5kUpPfXr0T1s1nG1ZkgrIKo/sfLDJ6iTRJP/c/+yCd5RJ0nYJjuqPdU9b98
	+8kxNuHzjrLNC8hCdlvFDcGxwBysLqDoU6xQ5yB8k+i6u5xYRv21pZKBsv/qCmWsyv6Ndgy0b6yeF
	MlkXJtWpU5mcVQZhL0uE0rATveQ3fKYO1vFUyz94urBZ2mp0lBvdB2NPD8YxOg0glGJfjDpJldnzr
	VFpdMICg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPvN3-00000002tPF-0IrS;
	Mon, 01 Dec 2025 04:18:41 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPvN0-00000002tOO-1Sfn
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 04:18:39 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-b737502f77bso510721466b.2
        for <linux-nvme@lists.infradead.org>; Sun, 30 Nov 2025 20:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764562716; x=1765167516; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMVbFQJwrtDT4Z0LvdOkvQwxkH7n3jhJLvQGPrvBilI=;
        b=ZUEHKP08m3o0RFzyEZSeLDVBK+G+steYmz814v5/1C6qWk/qCokCCsv1Po3q4+KNtJ
         wxQe/O1DXp4zO36Lve3ckpDCPXQcVP3H6EQGmq0kREDcnWHiplY8TWXwwNynzelfIXv0
         iuez3B7i36wkKRLZZzNYOvWE7CqtXyDCgV/Y1mBJuUK87aPMbMszEBVyqpmhrJYpLQEK
         +7fGcZ7eJhOPCy2JTL8+UWDTD6wIoXXmARE4harp3+ah1sE74zBfHuvLyUWDIXQz6XCw
         CnPiLkVxV141fK9LJy0isfZqXB6aUZ0mZNx3lfpAghlaun3IZu3gBvvOjbHKPbpuDZJx
         N49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764562716; x=1765167516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AMVbFQJwrtDT4Z0LvdOkvQwxkH7n3jhJLvQGPrvBilI=;
        b=oeGHTaXLyaTpx8v4YP8LMBjGG5vi+maCHx3/RApEb3fcBt+PiHTcNToB1cb+rZpWy8
         A/ghH2fmPuXsu0Pl5o69t0Wo6uOGyh+kCdkcvFAkyQT70tKBIYjQQOGmJ76kLFqsnCEz
         aAvOIuubAYX/IEnLNn+a9ZGW6l+ckPeXoGYLLZXacRixeocunB3YT9ay2Eh8rVsGWoQ7
         GkHA6Qp+OBVKBQl7L64OpSuAprQw1j4ZCth+bcpNcesgQtKC3ycRewFGqnZVWq2d9x9V
         omRkeQ8N4aoWPCT04Dhkql98TfY0nsGauP5hYn0oeof1aPY4xXCqrZ3BOk7L8Y9t7dok
         GqNg==
X-Forwarded-Encrypted: i=1; AJvYcCXlooTVbaILiMiEXh2ErPtoRYArwme2Ywn1rlOl4XIOrukJLQWZDyv0yIavaBm/JRFUtIbQy6Z6/ty5@lists.infradead.org
X-Gm-Message-State: AOJu0YwZiZQrwyjSuAK1yHgZEQAqG7DfV3qO2iAAqPABBOXfDTTYjQH9
	NZBb0hMPxTicWjCLSk9KPTz855dVVjD6HyJjHY6purfO9No/wANlFtxP06z3zj93sTeNgw8ODai
	G+L6rP/ejnTCRPN/pgewQrnEtiBYC5mg=
X-Gm-Gg: ASbGncuL69YtUwJt9uAJIycHe2Xn9TbsM0S3sU1CiifFiJdl2Ub+oPl8xTUfPbvq6dt
	WcZlKfky/9r6li1UhvSeBkiHDuSPNkN4HMBMMFuoB6zJYnjcISHORnxG8ZYo+UFy4CrJv+uQqtX
	bNUuwtXhKd2NGAQR0Sq75S/vn7OsnZ6noZ3JFC8EIRRgAP6Ma1Ox8fLc7awN7o8BiFZOYKjo1hy
	Q7bpu+O4Gtd247YoJqSItg4tIXU1qX8Jha9WlYp3wafonLUdfjAwWaPwgswYPNssiXASyXBehu8
	nh8u6BMRV+2p7I0vn3uIryRrUD8se9inPqh1
X-Google-Smtp-Source: AGHT+IEeTiNhj2dkL9zHMBWy2MWadxfl3ORIHTFpBD3euUzlvLmeTWg5W0jv/zpi7B8w/lH1Tab+xDdjnzwufYN3YuM=
X-Received: by 2002:a17:907:3c96:b0:b73:9368:ad5e with SMTP id
 a640c23a62f3a-b76c5515082mr2667474566b.34.1764562715362; Sun, 30 Nov 2025
 20:18:35 -0800 (PST)
MIME-Version: 1.0
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-6-alistair.francis@wdc.com> <f7a91a49-9f82-492a-8bf9-520ee1c832ba@suse.de>
In-Reply-To: <f7a91a49-9f82-492a-8bf9-520ee1c832ba@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 1 Dec 2025 14:18:08 +1000
X-Gm-Features: AWmQ_bnRvWBaRf_AYOX9GVK2GmdKNpGnJ5WeFBVDhtY-flit1CL2pb-FbNx9lsA
Message-ID: <CAKmqyKPU2w2GrzdMtMn1rO8auOpDCTovQH04P8RxptA45Oy6XQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] nvme-tcp: Support KeyUpdate
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
X-CRM114-CacheID: sfid-20251130_201838_419717_DC7D1208 
X-CRM114-Status: GOOD (  34.59  )
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

On Thu, Nov 27, 2025 at 11:31=E2=80=AFPM Hannes Reinecke <hare@suse.de> wro=
te:
>
> On 11/12/25 05:27, alistair23@gmail.com wrote:
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
>
> Errm. 'hdr' is of type 'struct nvme_tcp_hdr', and that most certainly
> does not define TLS_HANDSHAKE_KEYUPDATE. I think you should evaluate the
> cmsg type here.
>
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
> This is not correct; reading the control message implies a kernel
> memory allocation as message buffer, not an interator (as it's the
> case here).

I don't follow what you mean

Alistair

