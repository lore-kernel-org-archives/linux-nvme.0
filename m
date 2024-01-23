Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95B7C47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 14:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TlcL1UcCgDVT7MhGuA928CkmMK0FKDd9MTFr+LYjIzE=; b=1Ah1mgj7x6V8/n4Vm9uX8l4i6t
	GRRsvciLTQ9HuMCwv6MYuAQVHrYBeWjZ7Ext/35pvF9cTsMeU+sqnQ27m8UmfGkMYqb3IX5Sy+Enx
	gpZMasyg0fiZ+E45g4CLmjxiKAt2a0xcbA7XxbPdhTyfOyABsRd4jGwfhAFjhcoVeMcLgjMNiL1Pe
	RYWeKV2PdEXvXjrPVOfaDs6wusoVwnB0rcnEMRARuIb8raNNT6f1VZ4tpaf3N4+Yy1iyT1GodmUef
	tjSyi4mGnEkgXytyBv/U3XSta0CgI8t3HYhlHl96EAWMVBgPZ4RwR/GUfxclMPlgBnnjGjF33qETA
	kxegQWTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHdJ-00GmKG-0D;
	Tue, 23 Jan 2024 14:20:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHdG-00GmIe-1S
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 14:20:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706019605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TlcL1UcCgDVT7MhGuA928CkmMK0FKDd9MTFr+LYjIzE=;
	b=hOGFqVncMfko3NqdaHF6O3/9bzmo+sUnpJfSPNnM1Aiit3iB+HZcqeCscFNZDReY/0V26S
	w7BO2iqCrhkXV9z4o6KxB4ekrmMINgUig83BoUqjM+zdFEF6XaUO3kHX/o20rF2tWgkCEc
	3Q2w7jR8KAoEdrqR4q0CHpdHrltWZbE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-JXZltlc9N36DPttQDoWOvw-1; Tue, 23 Jan 2024 09:20:00 -0500
X-MC-Unique: JXZltlc9N36DPttQDoWOvw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23B5E86C149;
	Tue, 23 Jan 2024 14:19:53 +0000 (UTC)
Received: from localhost (unknown [10.39.195.153])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 79DC640D1B64;
	Tue, 23 Jan 2024 14:19:52 +0000 (UTC)
Date: Tue, 23 Jan 2024 09:19:50 -0500
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
Subject: Re: [PATCH 12/15] virtio_blk: pass queue_limits to blk_mq_alloc_disk
Message-ID: <20240123141950.GC484337@fedora>
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mDtWIMHGvnCXc65y"
Content-Disposition: inline
In-Reply-To: <20240122173645.1686078-13-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_062006_565610_D944C9A6 
X-CRM114-Status: GOOD (  16.91  )
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


--mDtWIMHGvnCXc65y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 06:36:42PM +0100, Christoph Hellwig wrote:
> Call virtblk_read_limits and most of virtblk_probe_zoned_device before
> allocating the gendisk and thus request_queue and make them read into
> a queue_limits structure instead.  Pass this initialized queue_limits
> to blk_mq_alloc_disk to set the queue up with the right parameters
> from the start and only leave a few final touches for zoned devices
> to be done just before adding the disk.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/virtio_blk.c | 130 ++++++++++++++++++-------------------
>  1 file changed, 64 insertions(+), 66 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--mDtWIMHGvnCXc65y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWvywYACgkQnKSrs4Gr
c8gzVwf9EKmoB088HuY7OLUbPNpCcZjXyWI+2X1VMsWjo6oMgMLBkwloYqFJXkuK
9iRxRmOeQ45ohORcQPhB/NbK2imZw/dA8CQaej6vUvXBVVJNM2bigRGPu+enbl+m
wT//j9fZFJLQrBuDMoOrbB5d13+ypPScTquwMs3FB0LEG2FvwJFRIX4YWMVAI/Rt
vd21AdV6AZcs6xBCLZIDAZgKaoWOqceI4n8lAp0tyEYJ+X/DIE21l6vF+fIQ6XMx
ZLm2g4WwHvxxaNfylNY4dsi5o6aGOvu+30LNd8+s4o2K5McAQ9IuOCNb858jLDw2
7KM3LbCZ1OT7KHY0fmETesHh+K9HOw==
=xF5e
-----END PGP SIGNATURE-----

--mDtWIMHGvnCXc65y--


