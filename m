Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEB5C43458
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2026 11:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7RbE0Nv3PqcWEvg1NZK6t1ZxnUn6Kyl+33LgQxDmYXI=; b=lup/QvAGmwyEOQPnAwWT6rQa0P
	NVyyegCZIi/npENsrahDT2LsOEDFS+fumGehPHi1zZTvX7d/HgjH2yY5EHbuXDIqgTUU7ekQW+2Qq
	u/fzribLCMa93XAUPwCFaaugdFMu0yWmubpXQ1HdwLDJKFTDmcM/vPW5XlDbz/O5WPjYnYtpGU1Tm
	tApsz2EiWLVpA8S4kHD3Fs7ILLa9eelwI+YfJ5lbugAm6xPAYLt8LfEgOhC+qo1sY00F529WqxPa4
	fmy5A8WtI49ZY/BTwFPaMxKCYR2ZDUzpLuJJUW7/1z4xc2En2GKJ46QaAdiSl5IUhbVBwp8huwIq+
	lJ6OD6sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjbRj-0000000BhEN-3UyH;
	Tue, 14 Jul 2026 11:37:07 +0000
Received: from fout-b1-smtp.messagingengine.com ([202.12.124.144])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjbRg-0000000BhE0-0Pyz
	for linux-nvme@lists.infradead.org;
	Tue, 14 Jul 2026 11:37:05 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 1D8331D00169;
	Tue, 14 Jul 2026 07:37:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 14 Jul 2026 07:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784029019;
	 x=1784115419; bh=7RbE0Nv3PqcWEvg1NZK6t1ZxnUn6Kyl+33LgQxDmYXI=; b=
	DIdZ3qJDNjFfCq4vVsWQ87xJiw3qZ5c7YL3vGL4qywkWZjEIN7uYZaZPgR1g5kWK
	zCwiJGs2kcDMs+kKUnEnt5+l4ZAYNe6+ixyMRLMvh/j35WEBZlh6nkyWov9CcQl9
	iFO4asR5sMES6GvXJHll6mWHJLZEyXfus6rkbxbjm/Rq1ZFRX75Tzef5cZ3Ydlyz
	CMjjUmWYkaX9K3qC6XknGqMr4hVpQEu6L8djFyjbR/Q9cX9Iau8UDzdFVBYEdSFC
	MkomefYe7mDOxVsoHS9jwp37FYFsLvuPPrmx7TgHeX9lKGcB5KmSlJ2RA+pBdmTa
	Yxk+oL0dQ/udPcMqbBWYhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784029019; x=1784115419; bh=7RbE0Nv3PqcWEvg1NZK6t1ZxnUn6Kyl+33L
	gQxDmYXI=; b=Z1xmThv1CYV1tNrSnZEi0QiOlbH+i7cdpdojeV31lnk0o8tWWgw
	VuCcKnbphyhooTP1ke5JtxtCykYynYAgZDt2v5Oc/fZsNT25N1pLzjkMY1ZyPA8Q
	mOXHggO+0G8d3chlmhbJgfemnWyoUKTw9Jg9ZA/G1Ztmxj/iRDgGxwaBxSTLnAUT
	UmYFpbQ+DyTebINyw60T56YoaByJwORTvC3ybWlGQkShD58rHzK7Bryu8r8wG4cd
	KT9yICHSimzQ22YJ5mi3wuhccZ2n4nvoP5nBtEzgwSEu61B1oiGawwb9YAncUDUk
	05iz8nn//Dw7ZjraRfvZ9d+7Echhjez4JzQ==
X-ME-Sender: <xms:Wx9WauHLaHt_gupfLLE40lPICHUHoourcg8bHJ6R1w-k8ZB3RzE7fw>
    <xme:Wx9WavC2sU3qmnjz5XAdxkTFVgvmMnj-Em4YnBO3nV-C8CO0HLooevmK0eEOUtI-V
    PibthgL5grIeVdpTGDagMwFyWkNozDfvtahLCl1sf2ezE6r>
X-ME-Received: <xmr:Wx9WajwKv-bobG9As7YjRNvisWNxEcTNwnVpKSlIXLNW6jQrCrpKxDO9gVtsMTzeHFtlhSaKWYGS7EY4FrIuf-h_mCsJAtPrZUE>
X-ME-Proxy-Cause: dmFkZTEFCIzIQMCd2MkWM2GVRPXPZcLLdFwqIvCqn7GNb/FgdSTRcwIq2bs70YB4KkszA0
    2Uu3wp1FwQ9/V4n2J5vOU4vaQRgdzlHw0yPwcCuCso7VIxmXCWYu8IUyjRtDnMApMYk63Q
    8YAp2R6L/gdWyVzjJB87R229XAVEhDPaYGFpcWlQAY4dDV31/3M34n7UFcBai4hWiu/l76
    kgXWXllMALS0ldoYIP/4pPVV6OAtxoGSSxcgVBT79/xhnOGimo4VmNFxG8cGmqmy6BJYYt
    cpa0mAteMx2JSNzl8dQSJVHtsmy/mpEFdof5T3KEXOGFqfC6F1gRed+oxwEL3Ys64vPppm
    IEgImoAdzdXUaJGEhUB8BBAixpojp7+95yQn1EnMWiQVVtkqNA+YQsajUpPkfAazrpFKUs
    Ax38yXkVmSI/xr2lCJ4OQnKslwH0zeLS0wNN5UZxT1ExwypRmjKdf8Rz4FVvv/RVxoekI9
    M8Y3Sdt1btLcUD3dmPWYSWxLvIpOe8hvsyPdBQLWEgUkhC5RYQ3/CbYW/allvTEPNUgywj
    IEhCg+ViWQhF6EhvLi9xgc5hqyVQsCgoEmDao6ceqs3QfuiRdJHbI3vZPXP3LwFfisEczt
    oMNSe68bgBKoH379/ecqFep3N7MwTcJu0IioGwoEwcB59EnXNjrYBSJANnKg
X-ME-Proxy: <xmx:Wx9Waj6HJ1HZy5pwxQMmH2l_QJSPJlgFBfNW-CIsuFaA-ZuaGhyMlw>
    <xmx:Wx9WakwcY3m5WIs76-FAIFGMVngiHN81kPKXOj8-RufKbZ5tvNLbVg>
    <xmx:Wx9WandveogwV-gWTqPYujKe2VvHtfP3RdF1wvcvqBjOQ_ycW5lAKA>
    <xmx:Wx9WapDKK83ncNPhj7-FAJLXBG9TPlkhPdMcFKoG_02C97GSFFWnXw>
    <xmx:Wx9WarWWotNXlr6sYu6OniZPRL6HhYOWATfOo8neVOEkPT05SnvjLu8m>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 07:36:57 -0400 (EDT)
Date: Tue, 14 Jul 2026 13:36:55 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Roger Pau Monne <roger.pau@citrix.com>, xen-devel@lists.xenproject.org,
	Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: fix parameter order in nvme_free_sgls() call
Message-ID: <alYfV2l-7p4Y3eX-@mail-itl>
References: <20260127195907.34563-1-roger.pau@citrix.com>
 <aXokOX20HMD0E_PM@kbusch-mbp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G/yGk+MB9HjdayeF"
Content-Disposition: inline
In-Reply-To: <aXokOX20HMD0E_PM@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_043704_456573_CEA47BF7 
X-CRM114-Status: GOOD (  16.52  )
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


--G/yGk+MB9HjdayeF
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 13:36:55 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Roger Pau Monne <roger.pau@citrix.com>, xen-devel@lists.xenproject.org,
	Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: fix parameter order in nvme_free_sgls() call

On Wed, Jan 28, 2026 at 07:59:05AM -0700, Keith Busch wrote:
> On Tue, Jan 27, 2026 at 08:59:06PM +0100, Roger Pau Monne wrote:
> > The call to nvme_free_sgls() in nvme_unmap_data() has the sg_list and s=
ge
> > parameters swapped.  This wasn't noticed by the compiler because both s=
hare
> > the same type.  On a Xen PV hardware domain, and possibly any other
> > architectures that takes that path, this leads to corruption of the NVMe
> > contents.

On Wed, Jan 28, 2026 at 09:49:58AM +0100, Christoph Hellwig wrote:
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>=20
> but maybe we can reword the subject to sound less harmless, e.g.:
>=20
> nvme-pci: DMA unmap the correct regions in nvme_free_sgls

On Wed, Jan 28, 2026 at 07:59:05AM -0700, Keith Busch wrote:
> Thanks, applied to nvme-6.19 with updated subject.

Hi,

I think this wants to be included in v6.18 too, as it also has the
faulty commit. And indeed, I do hit this issue when running 6.18.38.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--G/yGk+MB9HjdayeF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmpWH1cACgkQ24/THMrX
1yyenAf9FWpkwva0hdfgfqEDIy6a/Hgllhx36/HeJWibLzeDbTJFYpwU8I+qDTRh
fFCn1CT9lYNxu4O0IFtCTBiktCI/J7aFuZXIvFak2viOU9Jc06fYF5q+dEgwnZm2
m/glL8tOsJDW9TCtxqzvn5Zvjb7eGZCqKZeQFQmlcDWgTsXLssyoTrYJBoK3EyKV
XqJooQme6+zH6s6S0ACyaBWq/5W6MmWsa6awJ2RlhDFOX3LgKjXY6TMAIXkCVjj5
VHOepitO3/fFqVu2QpICN89638kG9JCZsG53x/dUSVrtdpBVZhXVYkzMTT2ViDUu
P7FaNiGtA2F7sbx1kImZcp8q0pSQrA==
=7k8S
-----END PGP SIGNATURE-----

--G/yGk+MB9HjdayeF--

