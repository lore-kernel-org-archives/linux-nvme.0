Return-Path: <SRS0=X7Om=YL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8649DCA9EB3
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2019 00:59:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A5F92064A
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2019 00:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iMrAf1/h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fE/NT+MI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5F92064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=P737sCK75K2kO8Q1YOYk/R06MUq+kwLZzKSvR5Zz8qM=; b=iMrAf1/hxDh4O7CXh6Txp1PV9
	UttEXm8xXBN6OJywgmhKLtmdOTt/laseHqQhRbRVziwVapg5AJwSRmQj2Zj+zuOWROVy/WYrGt//j
	OmuNyoJB1ZmsM9RiaAJ5g7R5WBOmt0oV50hPfvNhEIAgiA/n9bLCm+m/MPXGdTMgD6URhfLA4DFBy
	FjxDFKgqLPr0RB8YLODMYA83z5YD/9J6glRLNYhglg1/H0b+uyXKWHwJl0NmL0Twv5QSxlkB18cRF
	Ish+SOWAgkJhUtRiQgUjPhpa3sS0MMs0QFgWDOj6bq2YpG0GL9JTeGdccFoJYEZ3NwGvE00+7KZIc
	eiKIjZEzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iLGcH-0006d9-MY; Fri, 18 Oct 2019 00:59:41 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iLGcD-0006co-IF
 for linux-nvme@lists.infradead.org; Fri, 18 Oct 2019 00:59:38 +0000
Received: by mail-pf1-x443.google.com with SMTP id q12so2727900pff.9
 for <linux-nvme@lists.infradead.org>; Thu, 17 Oct 2019 17:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=43dDgYBLEYJQ1P9/9bh9OY638MOTtwqKiabpMZnfyUE=;
 b=fE/NT+MIogbYqz7Lk6H0V/3Z5RysgCOu/aiB67xNxgDJvEhRrY7XdTjAXNVBt3wueh
 Ccf4z0FsRMu+EXgfFoZOpl6xiHATVNO1FncX2qUrQN5ZNQXKlGRZTK1t4PKsU5XQcZaY
 B06tiZ45pjZ9uPN8fz9IT2PERNC/Ge3sRFBRkJhRl+pKSUfMFb/xIsWMWIIqLyBHJ81B
 u4NLuOJhG/kff6zd4svElPKHDlSmZ1LRXteOzsEJ7n+94elOhTkWLL3/U7hPymNAcWtH
 RMP/i7NXzd6Q3WMcj8BCndyCSD7BJQipCoMmwX6qRDm4IJGQlqEcAXxhszk2gZWmkd3r
 PEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=43dDgYBLEYJQ1P9/9bh9OY638MOTtwqKiabpMZnfyUE=;
 b=ko3mWQuO0tGkBy34ADvazRelhA9rWe4MdGMzN1RtSBArsKrZnzIpYcRNefzcFO15mq
 qjuSKXltMZJg4CRMA7SXFfXhznwM59ENMvBvhSadaGzJhzyRZ9MoNOMF+L652QIAjOGh
 OBOmrjfbq8hSSFMmvV7kjK7QH+QlVa3XZh/FIIdPEopVMgTApj6sZnBrZs0camjd0QeT
 ZW9KyO3qY2+QtTzdoYr8ftOeaP6VDF7wSKtbQmB3m3Kus2yTtNu8y0Gmw3oZ8IycwTxW
 fzNNitMUJ8i9t/FBHxqP3UWufRuL3TYajaCwfOEN2mjHEQC4VhwmFFGMm/oyIrLkq5wr
 TGyg==
X-Gm-Message-State: APjAAAXivRNAa6vLI2axu1BvDqZp7RUychLHN+rYJj1vSWDJprqP5g40
 Yc3HsSufMrZq5YjonegOpBQ=
X-Google-Smtp-Source: APXvYqxyAGQWKdQCLF6x4Pd0K7hGPDPNu15BcQ2sfZt5SQzlyIpr2xHErUFlBpKQNcWgjCG9Gw392A==
X-Received: by 2002:a17:90a:8c14:: with SMTP id
 a20mr7755605pjo.77.1571360376519; 
 Thu, 17 Oct 2019 17:59:36 -0700 (PDT)
Received: from pek-khao-d2.corp.ad.wrs.com (unknown-103-217.windriver.com.
 [147.11.103.217])
 by smtp.gmail.com with ESMTPSA id j26sm3795637pgl.38.2019.10.17.17.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 17:59:34 -0700 (PDT)
Date: Fri, 18 Oct 2019 08:59:26 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-pci: Set the prp2 correctly when using more than 4k
 page
Message-ID: <20191018005926.GN27363@pek-khao-d2.corp.ad.wrs.com>
References: <20191017073428.46155-1-haokexin@gmail.com>
 <20191017145554.GA8676@lst.de>
 <20191017173807.GA91017@C02WT3WMHTD6>
MIME-Version: 1.0
In-Reply-To: <20191017173807.GA91017@C02WT3WMHTD6>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191017_175937_630206_6207E635 
X-CRM114-Status: UNSURE (   9.88  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Type: multipart/mixed; boundary="===============1098712692212531516=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--===============1098712692212531516==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DH4/xewco2zMcht6"
Content-Disposition: inline


--DH4/xewco2zMcht6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2019 at 11:38:07AM -0600, Keith Busch wrote:
> On 10/17/19, 1:40 AM, "Kevin Hao" <haokexin@gmail.com> wrote:
> > +	unsigned int offset =3D bv->bv_offset % dev->ctrl.page_size;
>=20
> Can we do this without the modulo in the io path? The page_size is a powe=
r of
> 2, so this should work:
>=20
> 	unsigned int offset =3D bv->bv_offset & (dev->ctrl.page_size - 1);

Sure. V2 is coming soon.

Thanks,
Kevin


--DH4/xewco2zMcht6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAl2pDm4ACgkQk1jtMN6u
sXFUlwf/bpMSmMvC+4ig2hoVFr6CW7Mjuxr8jKVMhTRb0EMiIg75FlY9+hljgIia
KOHcCuhc/ABwn5XmsvEEKVDJKxWuaioQf3MdPytkCj07pzA5WLMGADzS6U4Ib20t
Z4/uBak2TV4GU7+dpQleU8XDX9q2VFWpfrtHlExZ/9i9qV9jdl06LnlyByyS7bB8
MvlQ7i+Kc8x7Fi3W3OPQHe0ahFfXnK85+VZTE3MPWd0ZgkoN16fsjap8pdIB5OQV
BngKLvzgPXXRApK8+MOWARIFRJ+kTPuITmrP4iYHd4e8MIT5F+ypp16PCDl4fSac
oC3rSzkWv4UtY7ge4zu2fIEkOOXYQg==
=4SNl
-----END PGP SIGNATURE-----

--DH4/xewco2zMcht6--


--===============1098712692212531516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============1098712692212531516==--

