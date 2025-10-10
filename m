Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D3CCCA476
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Oct 2025 07:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ft8+GHyPaWE5QNecvMBDFx7PoSv3gOXNdAI64yMkvI4=; b=n7CrZKZ4fQ+kuZBjAE6U7VCGwZ
	XfGQUMngKxwaBzpwsD6E9HWYMp9szRhVyi3H+an9QG8q8vVqExKKzmA9EnL3DTFTnHUO5gZN3Y+ru
	iCUe1W7InuMqpactIwLs4c9Pg3bvmWSCQYxhiaq5XzmFbRG0c4iMGY5XRiAO3vRgWYgZEDh8rjVRl
	WP8+9PVOJAwPWpcg7LGfrq4om0OdIvf0vj8iOauRDDbxZqPtYE0L6SKIPEzaHpa0OMA8nMX1BCIBA
	VWu8xR63OWLfnMqP6Td5TSIGQvYnYn9MV6V+IYkfGjb/segmB4DXAjon5M4zivebQBW7QKxDg5sMV
	W29d/xSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v77Uc-00000007r3C-3UN4;
	Fri, 10 Oct 2025 07:24:46 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v77Ua-00000007r2o-2BCt
	for linux-nvme@lists.infradead.org;
	Fri, 10 Oct 2025 07:24:45 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-3324fdfd54cso1960156a91.0
        for <linux-nvme@lists.infradead.org>; Fri, 10 Oct 2025 00:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760081084; x=1760685884; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ft8+GHyPaWE5QNecvMBDFx7PoSv3gOXNdAI64yMkvI4=;
        b=jF5rboePVggEXwu6VxgiDMqRHVSA9yFe4xaMDW2d0NCYQUeLe34Ia8GaUYiQQ/S8CW
         gtvM47Ge2LO/XTSKuSmGvTg04jj4x7Tqp151GxyDY//UhD0USycVq0Etxo1v2OEjaoR3
         AmDvv0c39v+xsjIyAw9HNhPZNQSZz6/cBWLUp/8mrhuMI99gHpvRrOFs1Uy10ttS4SeG
         G1CLlOhjKb8YgyEG9JMzxruCrj6dgPJK5abX15tG4niwC5PYq/r/x3xabdRevqQuXXqr
         CkpY7Y522BBr3DI2IEGdbv33GbADN9oUZT8BBhx90riuME2ajzXNprRgEZIU3KIQnP9k
         KWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760081084; x=1760685884;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ft8+GHyPaWE5QNecvMBDFx7PoSv3gOXNdAI64yMkvI4=;
        b=HuIVFcq5p6Nm40EXcKZtyMzCuuyN/cXtXCA4rhqVwZTSadgiFgdq91YBP/a0nFU5jP
         1pNBW5mFelYr8dTAHeFE7LTe5IBK2FGfrVMmsNnbVEuMTUatIQLeL8UBGB5+BLeU2Myl
         lQXSsDgio8jJVX60pkI/2Jv9HCny/3CQFWGvKS5v3lQi1ikVB7GL3W+CGDrg5lhsBmJW
         pVpOw0qIjxVa4zd7bZ7TBaifOH77CSozKxPNAMfkOsTxjjP1xcRV+BZll6Fl1AS4lcKf
         a/qfT5217rWslXw5C5eOMf4+49K638qVCqtZ6IOrbAqPK1UvojHiIcW9k5OAm+hsnHae
         ODFg==
X-Forwarded-Encrypted: i=1; AJvYcCVrpGiHajQmgRS9UPwltUXSrng2/uFcrNjUwZD2kAiz1/I7Jw7bKL21AhHckzQCflBLkdQxB+5BXp/4@lists.infradead.org
X-Gm-Message-State: AOJu0Ywz2uzkWst5Tgl2W+lkDsXGVIVwkROuYiQWHJQm+BiCD89mIExA
	A/ks54GHr4mhBToPuEU27EZMsPDmoxxnKytlwosDeh+98/xxPNUnhxmA
X-Gm-Gg: ASbGncuLgwWoAsHymUTJBs8Ach4SpfzeLUe1rD8bG+mkAZ97mIdvPZFqhP55ANu4j3R
	Acd7AQFGQmBs5trTvMke8YvtqZI0sCuFoxOp968fojryXxUOpm/XLyK0JKoX+TM5fwwz3KbTlCY
	9iYYm4qBc0J8ULpFmyb2da/KetwDkz//nFfkasaoQqP0pFYtMayIDMicEZaAVar4rLB9QRHavKp
	gDz6kZVDiDo4V6GZe59JP8isnFFLMxisSauS+lBCfIyC/b4WEvPcGUaxMQ6m3P8eV50Z17a5nww
	Rr1+NRMotZvwCNbcQRsTK5bQC+0jK5WJFBjbaDSIFHhfLQerrFpEenpTIBeWw7rysRtFHiWxCZi
	U1bBua/cn7OL8YwWV+IyYR7ddm1bbq5jpt7T+L+as4FxHHUQPDNaYHHpx
X-Google-Smtp-Source: AGHT+IFA9+vMUY6ByW+p1IF2nfK0SeJw3kFZAH0hcme8c+WfP183AXo+6f19C2sWzvxtw6EiZAMrPQ==
X-Received: by 2002:a17:90b:3e8d:b0:32c:38b0:593e with SMTP id 98e67ed59e1d1-33b5114d3d4mr13407741a91.5.1760081083631;
        Fri, 10 Oct 2025 00:24:43 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678ddcc604sm1540479a12.11.2025.10.10.00.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 00:24:43 -0700 (PDT)
Message-ID: <49f098d8cdaecaf05e4e751a71bebaefd62f6fdc.camel@gmail.com>
Subject: Re: [PATCH v2] nvme/tcp: handle tls partially sent records in
 write_space()
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Date: Fri, 10 Oct 2025 17:24:38 +1000
In-Reply-To: <33dd4088-2a48-4dbd-a374-e2204aff3941@suse.de>
References: <20251010042514.704249-2-wilfred.opensource@gmail.com>
	 <33dd4088-2a48-4dbd-a374-e2204aff3941@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251010_002444_581660_24F1F33A 
X-CRM114-Status: GOOD (  25.69  )
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

On Fri, 2025-10-10 at 09:03 +0200, Hannes Reinecke wrote:
> On 10/10/25 06:25, Wilfred Mallawa wrote:
> > From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> >=20
> > With TLS enabled, records that are encrypted and appended to TLS TX
> > list can fail to see a retry if the underlying TCP socket is busy,
> > for
> > example, hitting an EAGAIN from tcp_sendmsg_locked(). This is not
> > known
> > to the NVMe TCP driver, as the TLS layer successfully generated a
> > record.
> >=20
> > Typically, the TLS write_space() callback would ensure such records
> > are
> > retried, but in the NVMe TCP Host driver, write_space() invokes
> > nvme_tcp_write_space(). This causes a partially sent record in the
> > TLS TX
> > list to timeout after not being retried.
> >=20
> > This patch fixes the above by calling queue->write_space(), which
> > calls
> > into the TLS layer to retry any pending records.
> >=20
> > Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
> > Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > ---
> > V2:
> > =C2=A0=C2=A0=C2=A0=C2=A0 - Unconditionally invoke TLS write_space(). Th=
is means we
> > don't need
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to export tls_is_partially_sent_re=
cord()
> > ---
> > drivers/nvme/host/tcp.c | 5 +++++
> > =C2=A0 1 file changed, 5 insertions(+)
> >=20
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index 1413788ca7d5..6016510577bd 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -1079,8 +1079,13 @@ static void nvme_tcp_write_space(struct sock
> > *sk)
> > =C2=A0=20
> > =C2=A0=C2=A0	read_lock_bh(&sk->sk_callback_lock);
> > =C2=A0=C2=A0	queue =3D sk->sk_user_data;
> > +
> > =C2=A0=C2=A0	if (likely(queue && sk_stream_is_writeable(sk))) {
> > =C2=A0=C2=A0		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> > +		/* Ensure pending TLS partial records are retried
> > */
> > +		if (nvme_tcp_queue_tls(queue))
> > +			queue->write_space(sk);
> > +
> > =C2=A0=C2=A0		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue-
> > >io_work);
> > =C2=A0=C2=A0	}
> > =C2=A0=C2=A0	read_unlock_bh(&sk->sk_callback_lock);
>=20
> Minus the whitespace change:
>=20
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Ah only just saw this, sent a V3 with the white-space fixed. Thanks for
the review!

Regards,
Wilfred

>=20
> Cheers,
>=20
> Hannes

