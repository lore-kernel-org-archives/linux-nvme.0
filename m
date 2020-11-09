Return-Path: <SRS0=mxs5=EP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34411C2D0A3
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 10:24:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B8F320684
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 10:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1Qh/AfiH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOL6IrFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8F320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iLFbGlCvNHSQ7qKHMSxvUU1of9y6x+PNJ5HEzUg4juk=; b=1Qh/AfiHLHNWmMRjeFQxAymjx
	DS/wZgT8o+7wjVWXucXAYHKQQj1zXC4a/riG1CDtHmoWS8X/G7HM50wLqvFLrT5Xlqx3vm/E+WSgw
	oN8uCVwGUfazSmhM4ijlIFRfn3FBlh6ggab6BEk72xoYGsj9HKPqPRYdkB1fCQp3UN9q6aM2f9eDn
	XUgQPtC663NWW9O8jGJzlXsMMATMqKwoc2HF/igPPRz6PlM72VULUJsnfwRl1/A7Qv0mOmtA6ueRX
	8at/7wzACFDysCuwoJyurfJK9LVxGXQQH4Xjk3o4j2pSY63/DVM/Xl2SIfeOQThz/MfiSzISNDsDM
	IkPZbuVvg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kc4L6-0006td-SI; Mon, 09 Nov 2020 10:23:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kc4L3-0006tC-Ju
 for linux-nvme@lists.infradead.org; Mon, 09 Nov 2020 10:23:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604917432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fvP8UJpz4riRKthWscMZ00xlDbEYu80keBJwGqqSMOE=;
 b=TOL6IrFvpfZHZQDKE3adBKZPhGTjLhF8Erqh/dqLzpeuDRd0Gc0YDLr39SLSNSBEVPmxQM
 hRdbDSDL2KRGVnw6I7eBOOKh1279M2A3CgUzohZJ3RN8E0/FxoHVhfu3H++lyAhj2TXogO
 ay5JxaZFei91MltRHRFBRKsvQnYDFkA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-I_sUUytpNla_sXK2O1mUPw-1; Mon, 09 Nov 2020 05:22:29 -0500
X-MC-Unique: I_sUUytpNla_sXK2O1mUPw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C02131084C8F;
 Mon,  9 Nov 2020 10:22:26 +0000 (UTC)
Received: from localhost (ovpn-114-110.ams2.redhat.com [10.36.114.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D8985D9DD;
 Mon,  9 Nov 2020 10:22:10 +0000 (UTC)
Date: Mon, 9 Nov 2020 10:22:09 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 23/24] virtio-blk: remove a spurious call to
 revalidate_disk_size
Message-ID: <20201109102209.GF783516@stefanha-x1.localdomain>
References: <20201106190337.1973127-1-hch@lst.de>
 <20201106190337.1973127-24-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20201106190337.1973127-24-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_052353_691473_E4E411E9 
X-CRM114-Status: GOOD (  16.76  )
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
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-raid@vger.kernel.org, ceph-devel@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Content-Type: multipart/mixed; boundary="===============1748918999420264036=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============1748918999420264036==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7cm2iqirTL37Ot+N"
Content-Disposition: inline

--7cm2iqirTL37Ot+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2020 at 08:03:35PM +0100, Christoph Hellwig wrote:
> revalidate_disk_size just updates the block device size from the disk
> size.  Thus calling it from revalidate_disk_size doesn't actually do
> anything.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/virtio_blk.c | 1 -
>  1 file changed, 1 deletion(-)

Modulo Paolo's comment:

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--7cm2iqirTL37Ot+N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+pGFEACgkQnKSrs4Gr
c8hPvggAiEUoB55Y2NWYKmWp20Pqz66o8MfxgXahkbbIj6hWGOJZ5M8cZD5dmb6h
xlDynJx6PzDey/2EstgMWAWpt5QFnKiPDSY+t/UjxpkAXqacgWSnNXhedkDGlczW
4LP5GspHB7zun1KHAcMpcXo6Uet85t5RPsKZqqkp1hRsIMjzKScj4Kan0b65BS0V
J6vUVDQnwVqn8DI38Ebm0r6TWG3PorXZ/SanjhCB9wbuGw3dX6X9aAk2XY8Ybwa6
34P5kZN1RxaqPNFYU0r3gcIWvi8CdCB6XE1Q4OM0ahxmoN4Y4pJcGA0XDZI1N7ei
35TRtk3FCvvJK8X13zk4enPGeLZiYQ==
=JdMU
-----END PGP SIGNATURE-----

--7cm2iqirTL37Ot+N--



--===============1748918999420264036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============1748918999420264036==--


