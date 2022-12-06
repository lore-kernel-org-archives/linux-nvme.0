Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6761C3A5A7
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 16:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f7tva0QRnvY34jr6F4y3N6frBD9DljEnyo24Q5FToPc=; b=eaB8ZDzqU86CD2j4GE4St3J/SL
	GKocsOqh8NKrxo3HUSc89B552Ut+XPK8S1zgRq080W4mENEJbk1zC9BSVZbFVxAGelATO3tigCj7V
	woF9+IdOsknu3QuNjmUN1tEYVxhbz6nduNMsUt9/38pRuxJHJF43HfSUsCzqTe0v4VYR3xvIR8uvJ
	Y1yBRZpkxW/5skGaRh6UgtnfiaWoZiqnrmcESviVwMP74x3/vaURB1T9MHdncvCxEkH1sOHyuheeY
	94O1hOYp00HUiDQTi/gYdSzobNbS1dZEeovMuKAJEAqMXXTaMSW+6wAYbNdg8WhpHgJsIac/br3Ig
	XZsaLZ3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2at2-00EvOj-4G; Tue, 06 Dec 2022 16:33:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2asz-00EvIm-Jf
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 16:33:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670344413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f7tva0QRnvY34jr6F4y3N6frBD9DljEnyo24Q5FToPc=;
	b=Y3SnTmMGBFX2rcuNWf2IlQxLtsmyTBvM2cogLTIvy//w25PgxBE/Z2FbnbKm0ild+TO3y9
	EFJTPP4PrpklFlacNS52L73ZMRH0ndcPawZ5qeT+sEi6qOw75qf4/kO4RxFIySaGSYYtXd
	GkU1fGwW84W5QcpuEISmFDr/lhjKERM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-NHrOxJHpO8e_BNKhHHWkEQ-1; Tue, 06 Dec 2022 11:31:49 -0500
X-MC-Unique: NHrOxJHpO8e_BNKhHHWkEQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B84DD86EB63;
	Tue,  6 Dec 2022 16:31:48 +0000 (UTC)
Received: from localhost (unknown [10.39.193.218])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 090482028CE4;
	Tue,  6 Dec 2022 16:31:47 +0000 (UTC)
Date: Tue, 6 Dec 2022 11:31:44 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
	dm-devel@redhat.com, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <Y49ucLGtCOtnbM0K@fedora>
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Kf1ZFtRxkbtTQRVa"
Content-Disposition: inline
In-Reply-To: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_083337_836786_7E8CABB2 
X-CRM114-Status: GOOD (  14.64  )
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


--Kf1ZFtRxkbtTQRVa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 05, 2022 at 06:20:34PM +0200, Alvaro Karsz wrote:

I don't like that the ioctl lifetime struct is passed through
little-endian from the device to userspace. The point of this new ioctl
is not to be a passthrough interface. The kernel should define a proper
UABI struct for the ioctl and handle endianness conversion. But I think
Michael is happy with this approach, so nevermind.

> @@ -219,4 +247,8 @@ struct virtio_scsi_inhdr {
>  #define VIRTIO_BLK_S_OK		0
>  #define VIRTIO_BLK_S_IOERR	1
>  #define VIRTIO_BLK_S_UNSUPP	2
> +
> +/* Virtblk ioctl commands */
> +#define VBLK_GET_LIFETIME	_IOR('r', 0, struct virtio_blk_lifetime)

Does something include <linux/ioctl.h> for _IOR()? Failure to include
the necessary header file could break userspace applications that
include <linux/virtio_blk.h>.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Kf1ZFtRxkbtTQRVa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmOPbnAACgkQnKSrs4Gr
c8iLOggAsIIn2qOsdq8S+xOJLEgfRN7/BoDt8YZ8CMsipVZs0G2Y6iVOhZFBNe98
W/edX+RVO5c7C8wPToA0QPqxO3hw7I/g6ztXeAm4KTx2mduzxQilJRDipEfpFOXV
OnW7IUGMedQPrwbMNqeT32QpFk/OVicOH/QguVDmQajXMIPUSvfBCnsSm8aHDl9p
YvADYVTPdoxJt3OTCGKXU7pfUwSC6/w8KVfxk3jnNKkuCDoEEeuCgkhyEc+CpGlo
i6z4bn23yupNn/d9CPROsEYRSB07OI8iAj7n6r1QMP2TG9+dOHgA4nnd0kcSWwYO
ZOnWHf2RJzEb34YNO5Bm0pio+X7vYQ==
=PdE9
-----END PGP SIGNATURE-----

--Kf1ZFtRxkbtTQRVa--


