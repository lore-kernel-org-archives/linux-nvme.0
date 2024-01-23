Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D5AC47DDB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 14:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=75cy3zssEp2rPaNsGHCEEFCL2n3UbPgvrY96j6PBPS4=; b=v5fqpQgpWfeojO3327iTRisAuQ
	2ecDNr4ViynglmtAx5y0Oixgi1KPTYNishvIt67pCUw1yTP6iukTEgF7MVTUP8dlvnjA4GMrRFDij
	oNmZiI0xUXLnsCQWoaSCBN/H7ZbWjdo0wsOtf2alN9pq6OiCauhE70Ha9EgntlJ6Cy6QTOhpwpAf5
	m8uUfHWZUTK7kZPZy6YNaiKcw4EVEKDZtHE3d186ZBso4Z2lglak9HzDH+ozl/HunnUX8TKy8WbCy
	QwdMgAbbYhMbh3FguVGUt2boq56ifxGoF77kohqG6LQNNGHKziZ1/D3KKg0gbYHcHAPC4Y0/kPSQ7
	ypVrC0kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHZl-00Gl7Z-21;
	Tue, 23 Jan 2024 14:16:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHZi-00Gl4z-1b
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 14:16:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706019384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=75cy3zssEp2rPaNsGHCEEFCL2n3UbPgvrY96j6PBPS4=;
	b=MV2ACZvK+8LN664M5xtaI2VWREIZG9uiLtAmJrawYkc4VxFV9GXetItLAnutYr26R5YHcy
	LF7K4CcKEnGVg1p2/ewwCr6qteSi/eGrIOBUquncP+BE72iWgQRvkdLfMIcWxhGUeMMkkF
	6Qwc+2s9494h0erqFTgY62G/IalzDzY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-IzDKtTLvPmqw7T0dUBtMOw-1; Tue, 23 Jan 2024 09:16:20 -0500
X-MC-Unique: IzDKtTLvPmqw7T0dUBtMOw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1ED2A10B726A;
	Tue, 23 Jan 2024 14:16:19 +0000 (UTC)
Received: from localhost (unknown [10.39.195.153])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 576D51C060B1;
	Tue, 23 Jan 2024 14:16:18 +0000 (UTC)
Date: Tue, 23 Jan 2024 09:16:16 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 11/15] virtio_blk: split virtblk_probe
Message-ID: <20240123141616.GB484337@fedora>
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oB8a124sWRz1YLzS"
Content-Disposition: inline
In-Reply-To: <20240122173645.1686078-12-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_061626_619789_779FDE44 
X-CRM114-Status: GOOD (  14.58  )
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


--oB8a124sWRz1YLzS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 06:36:41PM +0100, Christoph Hellwig wrote:
> Split out a virtblk_read_limits helper that just reads the various
> queue limits to separate it from the higher level probing logic.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/virtio_blk.c | 193 +++++++++++++++++++------------------
>  1 file changed, 101 insertions(+), 92 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--oB8a124sWRz1YLzS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWvyjAACgkQnKSrs4Gr
c8ja0AgAq5E2zDmIm2JQLzkb1yOzqxsO4TvGEPTyDTa7GkumGdesCYk8VI2uzCz/
ek4tut3Sb1TPcr2R6zZBKLSpUMRxmURQC/Y66xLy/LTxy6HmGrcamEEQd5iMDbj0
nEv2cdvekh5L96K9+DRSceuZS0Kw7dXcL4tE2hKE6hov+OAXS3Kxqambvftg6IoF
Ksifm7JxGBuKx1s9CsTDUE3QF5oXL5jT969r1k/2l/jf3yS0QSH7sIbK1h4+MHSV
id47U0I3yANjqYGRpKXW23blqx64x1WIJB1vVs4jrtJdvJnPzb6Iy8XprQZJ5rWK
JHPKPsGnz/m7RTZaq2zfX+NygtBATg==
=4cBN
-----END PGP SIGNATURE-----

--oB8a124sWRz1YLzS--


