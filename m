Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87424C0218A
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 22:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n2DanCW+1sqlcit4d1OBCz7BXKAc65KcBrTtJwUkCFE=; b=J/ztybV0+kOBlLmdoUMXDH8Gv+
	OrmUrqvrx71gE2EiPzRlkQWb/HVYRcjHoN2DBFeR5utZMGGumWShj+DXysBvQhoOaknqKrgAjppCt
	ufXkrU0IBNznykDPIRlXFnB1GcwhJlu+/I3dSBJNjjjDwdtu51zZeadONO/dsNJKYOfP1PCI8jhNn
	QyTPcMlSA+0/yDo+miVgyozc2yCWrIUfn2tNshh+VMCraaPrc23wNaokct1MMbcgGBC+h2Gain2vc
	uwNT1GKBMy6DkVV9FzGngWQx0MsArXHH1Qk50Va9JiSC0XaAd+0KLNDMekf5eA5H0Z/iXPGkDP+zC
	5FJ+lrJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tctfW-00000005su9-3DqY;
	Tue, 28 Jan 2025 22:02:50 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tctfT-00000005stn-42Nx
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 22:02:49 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2f2f5e91393so1459603a91.0
        for <linux-nvme@lists.infradead.org>; Tue, 28 Jan 2025 14:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1738101766; x=1738706566; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2DanCW+1sqlcit4d1OBCz7BXKAc65KcBrTtJwUkCFE=;
        b=cYksuxuW4TPaBxa+OtXtzcf1Lfcez4xqQMxP18rkpMEEVqI2hV2JeJuJy/PgBx+8DT
         Y0pvh5tV4h8GyTpHND5H3ExW3+0d1qi5FX6DJvLhO2LClotm8YsXVdqj+NlrkBfbyCbG
         V5jiWBuWbgXw/ytJ8BJr4xdhspa8ne59jxcPm/G1s6+V9zOpvrjW7AmHlfz9u6nOcTje
         di1Q4k2E/sICpDOE0PZoGUq4egoDQQ275UeGxI3YqbL48snzzanZQEu5WufsykjEoxgF
         y2u6b/9Xx+NiD/xxb946wrLUpy2Mjvv5ejfsj33CLgva4qmUc1sUimf0WOuO1WYiSVNc
         X25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738101766; x=1738706566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2DanCW+1sqlcit4d1OBCz7BXKAc65KcBrTtJwUkCFE=;
        b=BLYX6ViXFAzZcpOUGJCPwzWrMwHTxUr+rbI3/DzhY2dmlyuXDGHHSxOxvpAP24HTJW
         1qr7WKXJaUE6TTWLI4de3aBsj/uXum+QLD1sARlm4Vig1mrRjL3umhLmL7Ce62uS5AsN
         OMU7jHQ9vxjjqdaIpUoGc3YFNgdsgcN0aL+Cc8CgHnxB/v08Vtr66NGFu19I2HFTbtCk
         PmCeqGOZOjuyu7kiCE6zjtFF2XfkW2vQIPL4sjmyeuYwc6bUn9KlS4wVjteCA7cWcL/x
         Jpk7z8aL+kM0BwHbVVKPsTz7VynPtP8IUX4zpMpWZWwIKWM6sAm3zOSn02htfAHJUM1+
         ZEHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgFwB7dw9qb4i9/6HrCx2buYAsY0b7F35Zczue5RiLdOcRuqIxRfysOYgeLEiZYZTiDsXCjHeF7o+o@lists.infradead.org
X-Gm-Message-State: AOJu0Yyytza+4PzWmvERKUVa2pHqF+cnYI4jT29GmIjGQ8ZyjG0c2KB9
	05W1s8u8iU4lHjvaVrjcOx722uKDz11eXzrHchCrcFGoZ/xhYPKVYCP7tCeve6ByPSro9yJICAq
	i2/9AInY1YZY2CR8eBLsZTP7NvLrpWnvr7bYk31/1oh5SMKV2tOI=
X-Gm-Gg: ASbGncsEutr4/A3S2Is9rqq2OkbjBTl/7F6W+876L84M1kL1omyNWJfxEs+cmhckc7V
	setAy7MnpMgpanbzO/58UWklDrF+1Wmcqw9R9k98Yc0Y/Ju0Jpo5g7xHWaNWS4+NRL8jvyUg=
X-Google-Smtp-Source: AGHT+IFVIkYC5yZnk0qrshrvUSnPRlVsVTNbc2qRWm6qS6Z5EZQ10RZEaDf+FyonAij+42Ka1UrDpYxJe0ih4fZD4jU=
X-Received: by 2002:a17:90b:3d47:b0:2ea:5e0c:2844 with SMTP id
 98e67ed59e1d1-2f83ac79218mr360770a91.5.1738101766250; Tue, 28 Jan 2025
 14:02:46 -0800 (PST)
MIME-Version: 1.0
References: <20250124184311.1642797-1-csander@purestorage.com>
 <9ea74200-7cbc-4a30-9503-864dcec9b45d@suse.de> <CADUfDZoT7JW+d+j6YNmWJ3CKZ45gbvcUSsE6boZwE1C3iXw2_g@mail.gmail.com>
 <f75c62ce-04a7-4bc0-ae77-8ed80842bf37@suse.de>
In-Reply-To: <f75c62ce-04a7-4bc0-ae77-8ed80842bf37@suse.de>
From: Caleb Sander <csander@purestorage.com>
Date: Tue, 28 Jan 2025 14:02:34 -0800
X-Gm-Features: AWEUYZlVaJgLkEjZ59HhdDCKFdwc0qDcvuDQ2KBLJh2K6l9bkF4eVYzdSCxEaeY
Message-ID: <CADUfDZrvHmYQgqu5GiQDrAg_MOEiRigCLCmBSO6jeyd1z+Q-JQ@mail.gmail.com>
Subject: Re: [PATCH v4] nvme-tcp: fix connect failure on receiving partial
 ICResp PDU
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_140248_039624_A1D38D47 
X-CRM114-Status: GOOD (  42.09  )
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

On Tue, Jan 28, 2025 at 12:28=E2=80=AFAM Hannes Reinecke <hare@suse.de> wro=
te:
>
> On 1/27/25 18:38, Caleb Sander wrote:
> > On Sun, Jan 26, 2025 at 11:37=E2=80=AFPM Hannes Reinecke <hare@suse.de>=
 wrote:
> >>
> >> On 1/24/25 19:43, Caleb Sander Mateos wrote:
> >>> nvme_tcp_init_connection() attempts to receive an ICResp PDU but only
> >>> checks that the return value from recvmsg() is non-negative. If the
> >>> sender closes the TCP connection or sends fewer than 128 bytes, this
> >>> check will pass even though the full PDU wasn't received.
> >>>
> >>> Ensure the full ICResp PDU is received by checking that recvmsg()
> >>> returns the expected 128 bytes.
> >>>
> >>> Additionally set the MSG_WAITALL flag for recvmsg(), as a sender coul=
d
> >>> split the ICResp over multiple TCP frames. Without MSG_WAITALL,
> >>> recvmsg() could return prematurely with only part of the PDU.
> >>>
> >>> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> >>> Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
> >>> ---
> >>> v4: keep recvmsg() error return value
> >>> v3: fix return value to indicate error
> >>> v2: add Fixes tag
> >>>
> >>>    drivers/nvme/host/tcp.c | 5 ++++-
> >>>    1 file changed, 4 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> >>> index e9ff6babc540..56679eb8c0d6 100644
> >>> --- a/drivers/nvme/host/tcp.c
> >>> +++ b/drivers/nvme/host/tcp.c
> >>> @@ -1446,15 +1446,18 @@ static int nvme_tcp_init_connection(struct nv=
me_tcp_queue *queue)
> >>>        iov.iov_len =3D sizeof(*icresp);
> >>>        if (nvme_tcp_queue_tls(queue)) {
> >>>                msg.msg_control =3D cbuf;
> >>>                msg.msg_controllen =3D sizeof(cbuf);
> >>>        }
> >>> +     msg.msg_flags =3D MSG_WAITALL;
> >>>        ret =3D kernel_recvmsg(queue->sock, &msg, &iov, 1,
> >>>                        iov.iov_len, msg.msg_flags);
> >>
> >> But won't we have to wait for a TCP timeout now if the sender sends le=
ss
> >> than 128 bytes? With this patch we always wait for 128 bytes, and
> >> possibly wait for TCP timeout if not.
> >
> > Yes, if the NVMe/TCP controller sends less than 128 bytes, we need to
> > wait for it to send the remainder of the ICResp PDU. That's just how
> > the NVMe/TCP protocol works. If we want to protect against
> > buggy/malicious controllers that don't send a full ICResp, we need a
> > timeout mechanism. That's the purpose of the existing
> > `queue->sock->sk->sk_rcvtimeo =3D 10 * HZ;` in nvme_tcp_alloc_queue().
> > Note that recvmsg() timing out was already possible in the original
> > code if the controller didn't send anything on the TCP connection
> > after accepting it.
> >
> Hmm. With checking the code 'rcvtimeo' is only evaluated if MSG_WAITALL
> is _not_ set. Makes me wonder why we do set it...
> But that's beside the point.

I am not seeing where sk_rcvtimeo is ignored when MSG_WAITALL is used,
can you point me to the code?
It is certainly ignored for *non-blocking* recvmsg() (MSG_DONTWAIT),
but I don't see why it would be ignored for MSG_WAITALL. man 7 socket
also suggests it applies to all blocking socket I/O.

static inline long sock_rcvtimeo(const struct sock *sk, bool noblock)
{
        return noblock ? 0 : sk->sk_rcvtimeo;
}

In tcp_recvmsg_locked():
timeo =3D sock_rcvtimeo(sk, flags & MSG_DONTWAIT);

>
> >> Testcase for this would be nice ...
> >>
> >> And I need to check if secure concatenation is affected here; with
> >> secure concatenation we need to peek at the first packet to check
> >> if it's an ICRESP or a TLS negotiation.
> >
> > Are you saying that with secure concatenation we don't know in advance
> > whether the connection is using TLS between the TCP and NVMe/TCP
> > protocol layers? Wouldn't the host already need to know that when it
> > sent its ICReq PDU?
>
> No, the host doesn't need to know. TLS is enabled by the lower
> layers.
>
> But upon further checking, I guess it'll be okay with secure
> concatenation.
>
> Nevertheless, I would vastly prefer to have a receive loop here
> instead of waiting to receive the full amount as per MSG_WAITALL.
> The entire tcp code is using nonblocking calls, so I'd rather
> keep it that way and implement a receive loop here.

The driver uses non-blocking socket I/O in the I/O path, but not the
connect path. nvme_tcp_init_connection() is already using blocking
socket I/O to send the ICReq PDU and receive the ICResp. I suppose we
could change the connect path to register poll interest and use
non-blocking operations, but that seems like a more involved code
change and orthogonal to the issue of receiving the full ICResp.

Best,
Caleb

