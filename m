Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40226C87FCF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Aug 2025 15:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wn7+MLg+mx7R+loSOdJwKVEpmHzJFAcSmm3zYQYHZK0=; b=bh0uSLYZw7MiWdAmYqr4SXLdTu
	YrxmD27sfjrXP5b5cBu8L92Uk5P9HoM3TRb7FtE2VmaDxBYiVurzttAU7LNdpnR9alEwvEed7csf9
	Jpc+KRhYCx3w9TfYfSZ2BHpAEVIOs5dfT0FXD+0bCp+aQNTTzfP2bGAntNv4m13/6VzG5/aXfVytZ
	TngFW7A39nE84J4ZUSLTfQB4FlGFJLlHwam097fv2uJ8XzlQE2cFay/iyv6KzIlf2WrXt8FAOlhbG
	LZ83+htFSa7K9UzyRJDj67CCIiUMJ35YS0HaVR4b1MItUagMlcTzKhK9l5gOcheAcNbJ/MirQSjKN
	qUzw+8sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uk26C-00000000uZS-2MgL;
	Thu, 07 Aug 2025 15:00:08 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujoH4-0000000GtVG-3ZE9
	for linux-nvme@lists.infradead.org;
	Thu, 07 Aug 2025 00:14:27 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-7426c44e014so437198b3a.3
        for <linux-nvme@lists.infradead.org>; Wed, 06 Aug 2025 17:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754525666; x=1755130466; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wn7+MLg+mx7R+loSOdJwKVEpmHzJFAcSmm3zYQYHZK0=;
        b=nXSj3i2RC4ATarzgUm8pKuaSAhQlxeJsJMm508Y6J5IwoGFtj8BCGCWfNPLTw2/C8r
         JbBSKmYN9RsHk61mlndFKaapP2vpk2X5VbwhA2xL1NXZkBT70mjy8QRQb7zfrajUYC+t
         Rohs7C+sSizSQAUsEMf35939y7qR3l7ZDPoidhyjFzl2YLsUFwqv+2TC5w4nuzI9nGm+
         l9ETxT84uYKlR0vxVmUUCsA/aBCk9rje/j/qXKaCSB6J3dRX2LOLOuwBP15PHpvXDbBY
         nu4p1riYeL7NQ9Poc4TResk6LN8q8hS2hrZG/FIVK7916gpk5n3H2DC+ib5ogYv22YBW
         jN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754525666; x=1755130466;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wn7+MLg+mx7R+loSOdJwKVEpmHzJFAcSmm3zYQYHZK0=;
        b=eOpv9V5vKt9keSuvaKhRiKuAxtiCP6SVwGLKvgKkKZLNpnIwKxceOhHWR3nYF6chk7
         9vwtENhKqUUG3s7QbA9b1s9rdn/ZTukrrUgZ7yuhxOB9gWZ693xYkEcSefRbXOnNjggk
         0MtkgyMWwXi9FDPjPhdPDUFi5GbnfsKM+Nr5t2U/cqXvnBkW0KNya7H66WbiMbfcT8sm
         nS4iFFjkonj2bTDg0MBRiVgFwyPyg7HuXMSmZLKl01UAgXPfEfOLXYqM4XCcJhEUPP+b
         t+zi0Ms5aKMMKMnZx9YnqjSwzVYXglPGxa9EsQDcsoevOj3LvpqD6BLFHaZbQ5QkoYMa
         5n8w==
X-Forwarded-Encrypted: i=1; AJvYcCVmVil1C5JCvKtWNUBMBOP9rpA2+90JAl+h4jnt/u9OexNzdp2PsmB4qW97rKwnOWBBDn2Pvmk4RcPr@lists.infradead.org
X-Gm-Message-State: AOJu0Yzn1TXlikYZrqCgyUPRpGWGFzE0EloKQnM54kh2YjKHNGQU4OPg
	5kFDwqgE2fdOHakP4H4QHMDGPyPEqF1r6vvflir6uNECqofWp5Ymxi5g
X-Gm-Gg: ASbGncuYmgM3jMdSXF7/GYzEQZLeLwqjbLX++WyXHBPKVqJUR7WevuuiKMroLKrPbsK
	OdAa1wiHtwA678aD2WbLerTOc9wS0x7l2OR2pT7uAHHDjBz1sBtbnVZbvTJ1num2ZuP6RCkTceK
	lsk8dzfmYcB/AXS6KWtC/SDZsWS7TnmP1y0L6CcAiVkaWd0iejJJzn4Gpj3wdZrE51OqhEKo6Bh
	lwq9wWyqoOdXoZ5Zp35gcKwGnI5LU+X8keyFlDrSCNMxWdj71fl1o3f3v8Eru8HFBfPamj0t+3p
	PRToj1xAmQ4mUHGw8zpU0PAjanViJJwof78nGptYU2K/XIuWBtfsISLkS9fIm1/Js6xS3Gznmxy
	HEnOIPnem4lGF0loj/U8YR6Oa4Hdzxctcm3a7yvpRVoOJhHQ=
X-Google-Smtp-Source: AGHT+IFv3fICeSVNB66r1CGZa9K57JTbAU/G+cw8lORmFzP1zvxfL+ysyO4WBfOOvQ2rCC3Vekbzqg==
X-Received: by 2002:a05:6a00:2d26:b0:76b:c882:e0a with SMTP id d2e1a72fcca58-76c387f6269mr1193271b3a.5.1754525665892;
        Wed, 06 Aug 2025 17:14:25 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f911sm16602234b3a.47.2025.08.06.17.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 17:14:25 -0700 (PDT)
Message-ID: <7af292c6bb2c42cead77202a9034fcb6111b898c.camel@gmail.com>
Subject: Re: [RFC 0/4] net/tls: add support for the record size limit
 extension
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>, alistair.francis@wdc.com, 
	dlemoal@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, 	pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, corbet@lwn.net, 	kbusch@kernel.org,
 axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	borisp@nvidia.com, john.fastabend@gmail.com, jlayton@kernel.org,
 neil@brown.name, 	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
 trondmy@kernel.org, 	anna@kernel.org, kernel-tls-handshake@lists.linux.dev,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Date: Thu, 07 Aug 2025 10:14:14 +1000
In-Reply-To: <96ca4de7-d647-47ac-b42f-d76284394526@oracle.com>
References: <20250729024150.222513-2-wilfred.opensource@gmail.com>
	 <96ca4de7-d647-47ac-b42f-d76284394526@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_171426_894072_000F4C24 
X-CRM114-Status: GOOD (  21.53  )
X-Mailman-Approved-At: Thu, 07 Aug 2025 07:59:41 -0700
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

Hey Chuck,

On Tue, 2025-07-29 at 09:37 -0400, Chuck Lever wrote:
> Hi Wilfred -
>=20
> On 7/28/25 10:41 PM, Wilfred Mallawa wrote:
> > From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> >=20
> > During a tls handshake, an endpoint may specify a maximum record
> > size limit. As
> > specified by [1]. which allows peers to negotiate a maximum
> > plaintext record
> > size during the TLS handshake. If a TLS endpoint receives a record
> > larger
> > than its advertised limit, it must send a fatal "record_overflow"
> > alert [1].
> > Currently, this limit is not visble to the kernel, particularly in
> > the case
> > where userspace handles the handshake (tlshd/gnutls).
>=20
> This paragraph essentially says "The spec says we can, so I'm
> implementing it". Generally we don't implement spec features just
> because they are there.
>=20
> What we reviewers need instead is a problem statement. What is not
> working for you, and why is this the best way to solve it?
Thanks for the feedback.

Essentially, this is to support upcoming WD NVMe-TCP controller that
implements TLS support. These devices require record size negotiation
as they support a maximum record size less than the current kernel
default. I will add this to my V2 series in more detail.
>=20
>=20
> > This series in conjunction with the respective userspace changes
> > for tlshd [2]
> > and gnutls [3], adds support for the kernel the receive the
> > negotiated record
> > size limit through the existing netlink communication layer, and
> > use this
> > value to limit outgoing records to the size specified.
>=20
> As Hannes asked elsewhere, why is it up to the TLS consumer to be
> aware of this limit? Given the description here, it sounds to me
> like something that should be handled for all consumers by the TLS
> layer.
Yeah great point, I didn't think it through too well. I will address
this in V2 and have the record size limit implemented in the TLS layer
without involving ULPs.

Regards,
Wilfred


