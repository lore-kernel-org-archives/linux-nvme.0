Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7544DC27C79
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 03:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m3mVOlE8X03VcFujwgTUstJqoq0FTNeRmucJ5uXzzb4=; b=F03wGTPqzhmMNZATNK1etmjjJG
	7If4E+uCyNZfDY2AE3f5935ghw0Y3ocN65h+qv0nZfgCucMHhGJ3zRiPqqA1sF3ubIZC3hDzaZWUz
	33fpQhgtHr5lwu7vqF5qH1oBVZD/bWcy40oqC4CQCyKLnLJFzDdLhizvjU1V3RIPc1LeotxTOYNNR
	Ic/WTAIrojaKCAn322IlLg4XGNefQm1LjwmU8oBPnqqp4zXX4/5GsYMpecfC5wCcas0aPJEhJygBQ
	rsWGdgJClXl1NnYNc+csv5+qfqJY6p+HF1TTvg3vomI1vVMbL9V/6uerWOgs3PTbYHqPIh0llW0Dw
	TDfo36LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHEyE-0000000AwAv-2NqG;
	Wed, 12 Jun 2024 03:48:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH3iB-00000009O1e-42IH
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 15:47:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718120822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m3mVOlE8X03VcFujwgTUstJqoq0FTNeRmucJ5uXzzb4=;
	b=VQDBZESqBTO7FcO7aAiodA3LBZ2t6Dg9wApVrFwIEhrUrxzrPzlYEuyoZt23yKqdPzDDeO
	tAcgWl4WjZIkMf1+zVoTnR/krSWwJCdiZypLG6BIKoy696yCIzaNHeakVptCeEq1DOGYiA
	OWfIYndfzgbCNprhcvef8t3E3l184g8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-M7gCHZsfNvaRoPk4wQQxjw-1; Tue,
 11 Jun 2024 11:43:27 -0400
X-MC-Unique: M7gCHZsfNvaRoPk4wQQxjw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8414F1956068;
	Tue, 11 Jun 2024 15:43:15 +0000 (UTC)
Received: from localhost (unknown [10.39.193.36])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD4331954AC1;
	Tue, 11 Jun 2024 15:43:10 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:43:09 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Weinberger <richard@nod.at>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org,
	drbd-dev@lists.linbit.com, nbd@other.debian.org,
	linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org,
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 08/26] virtio_blk: remove virtblk_update_cache_mode
Message-ID: <20240611154309.GA371660@fedora.redhat.com>
References: <20240611051929.513387-1-hch@lst.de>
 <20240611051929.513387-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RRHJimCDVdpqhQ+7"
Content-Disposition: inline
In-Reply-To: <20240611051929.513387-9-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_084704_141800_63717B0C 
X-CRM114-Status: GOOD (  15.91  )
X-Mailman-Approved-At: Tue, 11 Jun 2024 20:48:17 -0700
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


--RRHJimCDVdpqhQ+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 07:19:08AM +0200, Christoph Hellwig wrote:
> virtblk_update_cache_mode boils down to a single call to
> blk_queue_write_cache.  Remove it in preparation for moving the cache
> control flags into the queue_limits.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/virtio_blk.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--RRHJimCDVdpqhQ+7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZocI0ACgkQnKSrs4Gr
c8gYxQf+MiHN7lIto5cvBArHuLRaYXdHSqN8WkOxjyk6pKDVJN3zByol4IsQ1or0
gi3U/1yXaU1lyM8v76HhRI789ZE9OXHiRD8iKWM54w0uldvJLPNzByqsrvapKvmR
XjYyMxgp/uFJZ4qxg3nonI2Fa2FzSjqA/ct/sTYj8AbXOsOEK/bUZasvnrwUuIhP
FwODujdCtfIpzMvn4c262LUiz3TOY+p3nH/CSKsYZwR5xiUbbZCf30PKrwN4RcmU
ti4hIKoOJcLH5gjgeXpfx7jOM/6Qr7eQrEelsDnuMAKYXC9WMj48+O6Cf8mFja4M
N1txQKX0NepjOjzDmydD5Dx/69S/sg==
=ehtQ
-----END PGP SIGNATURE-----

--RRHJimCDVdpqhQ+7--


