Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EB8C0218A
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jan 2025 18:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ae/htGEhYNLGEzk6TQeSW1nn3OVytirQ6lh21WzeZpE=; b=ejFhbJwaFvgjGG8bhKr6ydNpHh
	/wzGLTaCMPWokksv/lvY7uJpXpWMF7ZDnZDzTIDH+DRll9lgAuNsdfUo7Lb3vJ/jxFfcPkXxnXy7d
	wSkCx/PaUPPD0NSWGQzzqIHdU7leA5T+jguRjc5U/i3GtgnzZ2I6QJxirumLgG7U478c8ip6yHk9B
	x0vXQaLFTFJfHFox/52ygm0AltDfBTmNVDU3IVcAe+5MWgGNiXwAj1lqwVQdv03D3DOSrFeCNbyAE
	XInp9XaGYkqd/VnlVOb7iJ1DNzWHdo+9QhzVl+NzLDijFmjmWbTr17cKEn6y0mIDj9brXHU8MZEgS
	HTyHVBgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcTVT-00000002zVh-31g6;
	Mon, 27 Jan 2025 18:06:43 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcTVR-00000002zUh-07Lw
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jan 2025 18:06:42 +0000
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2f45244a81fso1153107a91.1
        for <linux-nvme@lists.infradead.org>; Mon, 27 Jan 2025 10:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1738001200; x=1738606000; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ae/htGEhYNLGEzk6TQeSW1nn3OVytirQ6lh21WzeZpE=;
        b=LswenRDELElyrMiWOT1ccIvDg2tddGS6qnfbI/134Ncr6OTl4XV9Hyb1taXe5Kpxyv
         M8UcJ3O+2wxfGd+Pg9PMMINJCWsEAORct6FeqTs1eV12sJTroSAo6ra46RGZCJ6MwewQ
         ArtGQWWRQinSKXuEpYBtmFifjBS55sY7pmOL3NP8o5UDRpVg7iV3oT8zFmiya85PTQwJ
         BOFPDRG3sEG7oTh5wXqAfjH8RZfMSj9fLt6XwtgQitN4BsinlXs2Fs9Z1f5OKt6D2rgc
         1SQdw6JgsrvQMiVnmS3XbJWlz4fy/D07/7H7tEtXkGErb0e1QDC1NQI0xuUQR1OHqRvA
         TTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738001200; x=1738606000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ae/htGEhYNLGEzk6TQeSW1nn3OVytirQ6lh21WzeZpE=;
        b=HEKPeqqoFE9vDlj4KjTMa0f9mRX4kYOfAEGPQOK5PV2iMS1jNsn5fwF5VvuZHtddkV
         G9wXRoqpGrs/KodzElLlTIu7/fW+gDN8OjfHY+t2786BHpcCPC2ZxFCyrGMtTE1BkTvH
         0RzhEthPjO6aQTprG5X+mfNPaR2QEQ2yk2uUnb2S4Lf0qchXb7YoTV59KdYzfVlhHCgg
         b4IC3B1J7k6oW/tzTojPi+RfqWi/Oci5P+FBhlF8rElKIDrZtFoIInVwh49AkG7G7/QY
         D5Sfwa93r6iyEZnDJYNlK/C7xmGVjPZFN1giIEgzZKEno9UCLTEa3xhQRIaOGx2MUvy4
         D8NA==
X-Forwarded-Encrypted: i=1; AJvYcCV4zHQ2JD1RXmtSA6QKt8uiEwbWugdA+ER7+/+gR1lwZmKdGRunoMAW9d9Q7TG7Pg2Yew1amDRKCY3j@lists.infradead.org
X-Gm-Message-State: AOJu0Yw7nMejHTEzOQcHwhXrciwsQv5Uitq3GxQyRo7eKQhw1jyP+C7N
	jXRkmWGomLj12BJIzW/jrs6KYIwUqPiPtXcX6sWGgSPYdFjY4Z9xSsqKFkY6Mec8ak+Mpvx02fh
	h+w1uZRha+TQLWSf0PYIvGCT1zwJHmJStg7CI+A==
X-Gm-Gg: ASbGncv43aAoy1kxKZ4dMSPLp93wwXP6ww7NOv7u5kWtDXW8aKq/iClVImh/FWZzwdN
	+qOUAc75s12KgBTg+Q+ditsPVXU9ubpuhFCNUB4FcYGBzwjvNNaIBNtAsDdhLbw==
X-Google-Smtp-Source: AGHT+IF0hfJECW3TS6eSdidmpKgRLtLR7+EBGEEBP2xzHFrEqZQPWsMJ/8s2ZtrkaQVYF6Hw87S4nWdvVtQRiANPnBA=
X-Received: by 2002:a17:90b:2e03:b0:2ee:c059:7de6 with SMTP id
 98e67ed59e1d1-2f782c82dbamr22673385a91.2.1738001199999; Mon, 27 Jan 2025
 10:06:39 -0800 (PST)
MIME-Version: 1.0
References: <20250124184311.1642797-1-csander@purestorage.com>
 <9ea74200-7cbc-4a30-9503-864dcec9b45d@suse.de> <80138543-2b15-47bf-9b0a-d959ce79001f@suse.de>
In-Reply-To: <80138543-2b15-47bf-9b0a-d959ce79001f@suse.de>
From: Caleb Sander <csander@purestorage.com>
Date: Mon, 27 Jan 2025 10:06:28 -0800
X-Gm-Features: AWEUYZmKqMjE7QydNkglDbbi1mHRqf8wiKrhUXQPuCm3Ayl77xReA4S5kDwZyJc
Message-ID: <CADUfDZr2GnkOK5uKwj2Tm+1v-Hk4k0md203nyReqHmrfmJZ7Dw@mail.gmail.com>
Subject: Re: [PATCH v4] nvme-tcp: fix connect failure on receiving partial
 ICResp PDU
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250127_100641_073411_3308FCC9 
X-CRM114-Status: GOOD (  37.40  )
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

On Mon, Jan 27, 2025 at 12:09=E2=80=AFAM Hannes Reinecke <hare@suse.de> wro=
te:
>
> On 1/27/25 08:37, Hannes Reinecke wrote:
> > On 1/24/25 19:43, Caleb Sander Mateos wrote:
> >> nvme_tcp_init_connection() attempts to receive an ICResp PDU but only
> >> checks that the return value from recvmsg() is non-negative. If the
> >> sender closes the TCP connection or sends fewer than 128 bytes, this
> >> check will pass even though the full PDU wasn't received.
> >>
> >> Ensure the full ICResp PDU is received by checking that recvmsg()
> >> returns the expected 128 bytes.
> >>
> >> Additionally set the MSG_WAITALL flag for recvmsg(), as a sender could
> >> split the ICResp over multiple TCP frames. Without MSG_WAITALL,
> >> recvmsg() could return prematurely with only part of the PDU.
> >>
> >> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> >> Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
> >> ---
> >> v4: keep recvmsg() error return value
> >> v3: fix return value to indicate error
> >> v2: add Fixes tag
> >>
> >>   drivers/nvme/host/tcp.c | 5 ++++-
> >>   1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> >> index e9ff6babc540..56679eb8c0d6 100644
> >> --- a/drivers/nvme/host/tcp.c
> >> +++ b/drivers/nvme/host/tcp.c
> >> @@ -1446,15 +1446,18 @@ static int nvme_tcp_init_connection(struct
> >> nvme_tcp_queue *queue)
> >>       iov.iov_len =3D sizeof(*icresp);
> >>       if (nvme_tcp_queue_tls(queue)) {
> >>           msg.msg_control =3D cbuf;
> >>           msg.msg_controllen =3D sizeof(cbuf);
> >>       }
> >> +    msg.msg_flags =3D MSG_WAITALL;
> >>       ret =3D kernel_recvmsg(queue->sock, &msg, &iov, 1,
> >>               iov.iov_len, msg.msg_flags);
> >
> > But won't we have to wait for a TCP timeout now if the sender sends les=
s
> > than 128 bytes? With this patch we always wait for 128 bytes, and
> > possibly wait for TCP timeout if not.
> > Testcase for this would be nice ...
> >
> > And I need to check if secure concatenation is affected here; with
> > secure concatenation we need to peek at the first packet to check
> > if it's an ICRESP or a TLS negotiation.
> >
> And wouldn't this patch be sufficient here?

If the controller sends the ICResp across multiple TCP packets, the
recvmsg() will only receive the first one. There are 2 different
problematic outcomes:
- The validation of the icresp buffer may fail because it hasn't been
fully initialized from the PDU
- Even if the validation passes, the remaining bytes of the PDU are
still in the socket buffer. Subsequent receive operations will return
those bytes instead of the following PDUs they meant to receive.

It is important to receive the full ICResp to avoid connection
establishment failure, and to ensure there are no remaining bytes in
the socket buffer.

>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 841238f38fdd..85b1328a8757 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1451,12 +1451,13 @@ static int nvme_tcp_init_connection(struct
> nvme_tcp_queue *queue)
>          }
>          ret =3D kernel_recvmsg(queue->sock, &msg, &iov, 1,
>                          iov.iov_len, msg.msg_flags);
> +       if (ret =3D=3D 0)
> +               ret =3D -ENOTCONN;

It is possible for ret to be positive but less than sizeof(ICResp).
For example, a controller is allowed to send the 8-byte Common Header
and the 120-byte ICResp PDU Specific Header in separate TCP packets.
In that case, recvmsg() would only receive the Common Header and
return 8. We need to receive the full 128 bytes of the ICResp PDU
before processing it and receiving subsequent PDUs from the socket.

>          if (ret < 0) {
>                  pr_warn("queue %d: failed to receive icresp, error %d\n"=
,
>                          nvme_tcp_queue_id(queue), ret);
>                  goto free_icresp;
>          }
> -       ret =3D -ENOTCONN;
>          if (nvme_tcp_queue_tls(queue)) {
>                  ctype =3D tls_get_record_type(queue->sock->sk,
>                                              (struct cmsghdr *)cbuf);
>
> icresp validity is checked later in the code, so if we haven't received
> a full icresp we _should_ fail those tests. And then we don't really
> have to check how many bytes we've received.

The ICResp is only validated up to the MAXH2CDATA field. The
validation would fail if that field is 0, so it is true that we would
catch a recvmsg() that received 12 bytes or fewer. However, the
remaining 115 bytes of the ICResp PDU are not validated, so a passing
validation does not ensure all 128 bytes were received from the
socket.

Thanks,
Caleb

