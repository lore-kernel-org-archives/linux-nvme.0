Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EE2C02188
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jan 2025 17:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hp7nzzPHvELQwd2C7EsIGd539TejOurM9SRjIRAKnGk=; b=WbgsqlTsF4djShdkMJGBrW+kOt
	fcPb/Gkl9VlcrqynPvDBPC2eAlb7E+9Qjjz9Wwb9PmiTnsjBre9wMUjhVqA7t+ph+BxVvMUuMZLVa
	WiYYvkIvJx2b77ZCKGvzvqmcBUhk7JW1OaRHQmlTkkj5lCBeI4jNvELL5OiGxPfvlzoO9xjQwcrAS
	9JZ4qUwhlDv1TmdQ97UAPbKwjR0EGU0oz4nXmycLp6rOlvtwTKAGpfYzMxdTW9Mup7dL2Y+y0PE8T
	O4cz811C8gIGKY2IL2asD0eJ/bpks3e/pTFjLMlv+1JjkLj0mciRnwCSqIT9Ed2KRXNqB7drqMq+u
	ra6F+yYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcT5A-00000002uSy-1T0Z;
	Mon, 27 Jan 2025 17:39:32 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcT4j-00000002uN2-3Uix
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jan 2025 17:39:07 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2ee94a2d8d0so958842a91.2
        for <linux-nvme@lists.infradead.org>; Mon, 27 Jan 2025 09:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1737999544; x=1738604344; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hp7nzzPHvELQwd2C7EsIGd539TejOurM9SRjIRAKnGk=;
        b=Kh3MtRaf5Ui0x3P4vGOkdxXVjurLJe1fJswkRNMP9SlFfA3YpISYnGwcEKStchUueK
         9YPXSv4NOcn5vWx8vh/dWpJuUwM+EeeedhKQW9R6tJ0gbsrPicqD/0m447hjQkxB4UC3
         EM8FsjAdrUGVUoWeaeAEvPZ8ROqAzeLgoaYiqqLaxmblWBVFpLL4xhtLY1PXmdAVLG+1
         JQzR5kfIPd6KCq6kSpOzIMCWb8Y0Co0xJoG50KtVo1rRtJvnfwJOX1N50wu+N/e8ICz8
         lkZl3I2hvvHevqdKAylS93G+GXyks84tZMPJqKKzLnxRqBrIGsV4TGWbvVk5UNBc4GTn
         zerg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737999544; x=1738604344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hp7nzzPHvELQwd2C7EsIGd539TejOurM9SRjIRAKnGk=;
        b=PStL6wzpwrU2ccLZKdWOjbb+rE/Aq1T5RsrEGCz7VyvN/yM7lyavSemAqaX5OqcU4S
         0WmlHc26IojB1wzHiRXNcyGs8IQ0hoVxv94Hb6TL3Ly4M4sdYSP3yxWjtwMADCXrRcw4
         LYCBpxXdKxOOAChBJvZiLhfj4hvrLESUV6XTCH+cNqb1WLkcxhVW+mJbNdDz+HBVQneE
         LjOpq95UGF/KiW05p8RSpHDgNgNZfn65QTHc+rha2Ev9VCseA6qlfzCbzQOLxmj7jqbj
         zp8wdRDWh+gm2Pm7l5DCdYP+JyqyG9uY9XfLDS0XFQdKCQGM8gUAcQvWv+hk6fHp+rpC
         rWDg==
X-Forwarded-Encrypted: i=1; AJvYcCXKwLNvGd31PTHFx8DfsqA3WC+Mj8wTA7Dv1qO966no5AnWtI7c02l7WbVxaoTsBJYvjBDLLGON63Cc@lists.infradead.org
X-Gm-Message-State: AOJu0YzwiG44J0MFS2AMpRspy4X/KA9UG69a4FOnUyc2GJuQrt3OfICd
	hu+EbxTWkS61Yfx61XpHQfNoeMbNIt7GvINkJTinzPnHQrktB7ZIqGdtUouUANU9fLRF6cRSIxs
	M/O1S7KtHL/zL0piQTXvv2pqA9xbgelEzt7mEew==
X-Gm-Gg: ASbGncvi9EKzd0rtAyt/4T+wXb3sA3V2B1cd2R1G9zlKJLDvYeoZlMppJw9RL57pCJu
	/Qp0Ok3NB4NmcqTc4rFb1rj9CADDWOj3k/Jb3MeHZopIpQ2AyFQ2ew75NsYlAxg==
X-Google-Smtp-Source: AGHT+IEeyZ0OK7zv54urFZM1f8MCrHGyzZRON5a7TV40RRcQwMXmZaFe1yvlLvMEGQNBgrAsqphASz43HyxXocPfJbc=
X-Received: by 2002:a17:90b:2d46:b0:2ee:a558:b6bf with SMTP id
 98e67ed59e1d1-2f7e3fd9825mr13612294a91.8.1737999544518; Mon, 27 Jan 2025
 09:39:04 -0800 (PST)
MIME-Version: 1.0
References: <20250124184311.1642797-1-csander@purestorage.com> <9ea74200-7cbc-4a30-9503-864dcec9b45d@suse.de>
In-Reply-To: <9ea74200-7cbc-4a30-9503-864dcec9b45d@suse.de>
From: Caleb Sander <csander@purestorage.com>
Date: Mon, 27 Jan 2025 09:38:53 -0800
X-Gm-Features: AWEUYZn4yICEKlLG1bc3votdXLwp7vZgKEe7EWeGv69PLj1Gnr1aK8X1zCT4gRg
Message-ID: <CADUfDZoT7JW+d+j6YNmWJ3CKZ45gbvcUSsE6boZwE1C3iXw2_g@mail.gmail.com>
Subject: Re: [PATCH v4] nvme-tcp: fix connect failure on receiving partial
 ICResp PDU
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250127_093906_034386_D974272A 
X-CRM114-Status: GOOD (  34.29  )
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

On Sun, Jan 26, 2025 at 11:37=E2=80=AFPM Hannes Reinecke <hare@suse.de> wro=
te:
>
> On 1/24/25 19:43, Caleb Sander Mateos wrote:
> > nvme_tcp_init_connection() attempts to receive an ICResp PDU but only
> > checks that the return value from recvmsg() is non-negative. If the
> > sender closes the TCP connection or sends fewer than 128 bytes, this
> > check will pass even though the full PDU wasn't received.
> >
> > Ensure the full ICResp PDU is received by checking that recvmsg()
> > returns the expected 128 bytes.
> >
> > Additionally set the MSG_WAITALL flag for recvmsg(), as a sender could
> > split the ICResp over multiple TCP frames. Without MSG_WAITALL,
> > recvmsg() could return prematurely with only part of the PDU.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
> > ---
> > v4: keep recvmsg() error return value
> > v3: fix return value to indicate error
> > v2: add Fixes tag
> >
> >   drivers/nvme/host/tcp.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index e9ff6babc540..56679eb8c0d6 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -1446,15 +1446,18 @@ static int nvme_tcp_init_connection(struct nvme=
_tcp_queue *queue)
> >       iov.iov_len =3D sizeof(*icresp);
> >       if (nvme_tcp_queue_tls(queue)) {
> >               msg.msg_control =3D cbuf;
> >               msg.msg_controllen =3D sizeof(cbuf);
> >       }
> > +     msg.msg_flags =3D MSG_WAITALL;
> >       ret =3D kernel_recvmsg(queue->sock, &msg, &iov, 1,
> >                       iov.iov_len, msg.msg_flags);
>
> But won't we have to wait for a TCP timeout now if the sender sends less
> than 128 bytes? With this patch we always wait for 128 bytes, and
> possibly wait for TCP timeout if not.

Yes, if the NVMe/TCP controller sends less than 128 bytes, we need to
wait for it to send the remainder of the ICResp PDU. That's just how
the NVMe/TCP protocol works. If we want to protect against
buggy/malicious controllers that don't send a full ICResp, we need a
timeout mechanism. That's the purpose of the existing
`queue->sock->sk->sk_rcvtimeo =3D 10 * HZ;` in nvme_tcp_alloc_queue().
Note that recvmsg() timing out was already possible in the original
code if the controller didn't send anything on the TCP connection
after accepting it.

> Testcase for this would be nice ...
>
> And I need to check if secure concatenation is affected here; with
> secure concatenation we need to peek at the first packet to check
> if it's an ICRESP or a TLS negotiation.

Are you saying that with secure concatenation we don't know in advance
whether the connection is using TLS between the TCP and NVMe/TCP
protocol layers? Wouldn't the host already need to know that when it
sent its ICReq PDU?
If TLS is being used, my assumption was that `struct kvec iov` will
receive the decrypted (NVMe/TCP protocol) bytes rather than the
encrypted (TLS protocol) bytes. If that's not the case, then I think
there would be another existing bug, as the code interprets the
received bytes as an ICResp PDU regardless of whether TLS is in use.

Thanks,
Caleb

