Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8A8C87FCA
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Aug 2025 15:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K/A9C8/bVgIC1L6UfQS08Wm98G+tK+gmaXMJoj3JOjM=; b=N8WI70E7LtG7WleNAMSwdF9xGa
	ITiNgBc9u2Uvyr6+MMJC6jkgPu1kcyURTcC1yUTgvnM2BdoH9Y7gm39OQE00Fk6eK+qx3O3a6RmtO
	n9Q31e7+WDWsP0UOfZSXqZG5y1OcyOr0eY7h6y31OnWMuXzGW7OiJxXl9/Mgpyl2nbUUMazRJFp1X
	8JIggbQEXMRpwUB+UgXoxaAvuhNr+CaUAHqZYs0F3v15iza6NhmuJ+017cOXFcnvDUu3cyKJnEXbw
	mb9r/tcDZXqzn8HQfXgVwgwkg88m8RAXsQ/AxAzu+BNUt25aNZ/B9O64w3Zf4FnZo+UXArGtkdmfP
	uKHqVE8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uk26B-00000000uWe-1dVZ;
	Thu, 07 Aug 2025 15:00:07 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujo7e-0000000GsYg-1iLs
	for linux-nvme@lists.infradead.org;
	Thu, 07 Aug 2025 00:04:43 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-32138e0d9adso417065a91.2
        for <linux-nvme@lists.infradead.org>; Wed, 06 Aug 2025 17:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754525082; x=1755129882; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K/A9C8/bVgIC1L6UfQS08Wm98G+tK+gmaXMJoj3JOjM=;
        b=aI1hlqgboutLmJKKV0pTMVhZaeaQ85aqRjZTNZY8QKo9Eh+d6RnNP+lRPLOBZcIBQq
         xeFznY0uAuTNCkkfgpoK7J8yz3qDJMHTrHei+bZEPNnK4ZEslHtaat5oKJkONoGdf0cn
         RejSwmM1cl8Vohc9qF9rBro3aQ2a633B7rr1l/SEGUR2QuoSjTFSYNtjS2TEj57c8Ppz
         SYIv1IuAQ6j6UsDQp2m2AI52Axpr5FJAyMox98EcmiQEtcWF6DRDj1wYxV4HBN4oEpp/
         pOdftD4rVSMQoF3KFiFWZXRWTvIDgERdbCJ9i6ZMRBK6621EqGRMOBd+Uu0LcDB3AjXO
         Zq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754525082; x=1755129882;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K/A9C8/bVgIC1L6UfQS08Wm98G+tK+gmaXMJoj3JOjM=;
        b=vnhQ2PNWzX5emoKSukuN5gkQgr060yoAIju+68ag3/OTe/bWRRtYI9c0q8cjkRG5Xw
         cSrEB8GUHV7V+ZdKeaw3sup25yCjBtHDkcqlorB8LgL/+2Y/H6FP4stfHUCS2sqowRQ7
         nbiK68en1iURvtPIqa2vf3Rd1EZAiyoMvGwiJFzB/gKR1sZv2iKvf6jv3K04pgpz427W
         hcV9aF+I4EoTQJPbPcgXaTPv4CFLyKTj6Hc62RnVsaGUipk/eF3DIWoibw2PsveR81Fs
         PkvwsVpNk7LapYH0iXoMBgcK3xu4kHE/vOxDrqEw0g1rNGYZbUoudHBh9L6j+FRO/sN0
         XK8w==
X-Forwarded-Encrypted: i=1; AJvYcCWE3mQEU1Xddu3euh571FmZgTc+NG/q6t/ny3YV5qfu8UT67dOhNuDgwM+bFBCPgA69ObbWLJbq053X@lists.infradead.org
X-Gm-Message-State: AOJu0Yy8pOfXYg9pfsLhCuqqnvDPKxwdHoMQsn7QsN0f6QbqqqxVjXCQ
	I9VOEV0Q2PcqENVEpWaFQziVDkh5Ze91j58FDh+2+OlJtVJZBOuI7Hrr
X-Gm-Gg: ASbGncszQSOU4CgHZH0F7g/OHqVnung7gLu7gXeArz41Q9hoHb1aZSzCZ07H/UM6eVE
	1iTa/qzTEUG9d0QfDgwK/WsTsYZhancdIvaVpSGYk5HrKytNSwttvgDbrwRloR4Ip6m0oPzHLdy
	pFdB448F49x1WzcKBVP7C7k8cvB0YKm/fPo8/PWpDn7flCMeREbQLIWm9UXviyN9qfMjoJIblm0
	wXepuW6zyBEnPmVNoBKLO74b21TCld9cR0H+JAMGpmUyAq1eZ5As+NkbS3Uz4vl4D0vI5a3XNT2
	ezu+umaZlKfvhjX37TaN44zCCqzb+XC6IgVA3XggLuCTXEKqPTkwkO3jcrSbCsWlOazCd+6BtzF
	zx1nzt/cctSsLFw3yQOZpWOm4TjlrCgLyk6pCpFTxJQuToZ0=
X-Google-Smtp-Source: AGHT+IE8yf3mW+Zix4aWhzoVPQkRdDv26V46vDKBnE4qstNKDwz/t8jIdzc+kq2t00duIY4+nurXzw==
X-Received: by 2002:a17:90b:2d87:b0:313:f6fa:5bb5 with SMTP id 98e67ed59e1d1-3216752304fmr6652697a91.18.1754525081598;
        Wed, 06 Aug 2025 17:04:41 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32102a5be52sm10378051a91.1.2025.08.06.17.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 17:04:41 -0700 (PDT)
Message-ID: <aa5680f2974cb18e4a7d40266a85727ef43377c4.camel@gmail.com>
Subject: Re: [RFC 2/4] net/tls/tls_sw: use the record size limit specified
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>, alistair.francis@wdc.com, 
	chuck.lever@oracle.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, 	pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, corbet@lwn.net, 	kbusch@kernel.org,
 axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	borisp@nvidia.com, john.fastabend@gmail.com, jlayton@kernel.org,
 neil@brown.name, 	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
 trondmy@kernel.org, 	anna@kernel.org, kernel-tls-handshake@lists.linux.dev,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Date: Thu, 07 Aug 2025 10:04:30 +1000
In-Reply-To: <8ce2c9ce-9636-4888-8d63-2169441addcb@kernel.org>
References: <20250729024150.222513-2-wilfred.opensource@gmail.com>
	 <20250729024150.222513-5-wilfred.opensource@gmail.com>
	 <8ce2c9ce-9636-4888-8d63-2169441addcb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_170442_446599_24BF3FE1 
X-CRM114-Status: GOOD (  17.91  )
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

On Tue, 2025-07-29 at 17:13 +0900, Damien Le Moal wrote:
> On 7/29/25 11:41, Wilfred Mallawa wrote:
> > From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> >=20
> > Currently, for tls_sw, the kernel uses the default 16K
> > TLS_MAX_PAYLOAD_SIZE for records. However, if an endpoint has
> > specified
> > a record size much lower than that, it is currently not respected.
>=20
> Remove "much". Lower is lower and we have to respect it, even if it
> is 1B.
>=20
> > This patch adds support to using the record size limit specified by
> > an
> > endpoint if it has been set.
>=20
> s/to using/for using
>=20
> >=20
> > Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>=20
> > @@ -1045,6 +1046,13 @@ static int tls_sw_sendmsg_locked(struct sock
> > *sk, struct msghdr *msg,
> > =C2=A0		}
> > =C2=A0	}
> > =C2=A0
> > +	if (tls_ctx->tls_record_size_limit > 0) {
> > +		tls_record_size_limit =3D min(tls_ctx-
> > >tls_record_size_limit,
> > +					=C2=A0=C2=A0=C2=A0 TLS_MAX_PAYLOAD_SIZE);
> > +	} else {
> > +		tls_record_size_limit =3D TLS_MAX_PAYLOAD_SIZE;
> > +	}
>=20
> You can simplify this with:
>=20
> 	tls_record_size_limit =3D
> 		min_not_zero(tls_ctx->tls_record_size_limit,
> 			=C2=A0=C2=A0=C2=A0=C2=A0 TLS_MAX_PAYLOAD_SIZE);
>=20
Hey Damien,

Thanks for the feedback! Will amend for V2.

Regards,
Wilfred
>=20
>=20

