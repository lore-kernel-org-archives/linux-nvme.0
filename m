Return-Path: <SRS0=eYGd=M4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07955C4338F
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 14:18:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5BFE61154
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 14:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C5BFE61154
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MYOZ0xT84nEI0KLIQh/OqQF80zLU8oqY5x7NwlNzn1U=; b=Hmki8p98+h0auxOzZ/SiAEusz9
	HNXttBebnPQ+uNmWJznaKZDsLYX3ic847gIhWTBEKYuKYVXLuVMcQxT9M8ysETh85LMU4DQL6Z0Xq
	97ktO7UskkIZafLhzGVrcZ/LV6W6T6dMw4JKFJRMDRtHPvEilRmUXqhi/kVmm0R0T9kZQuPzNANrq
	a1AeUGBA1H3L/XfQ2nQFeIfdlivHnVpUw4JaWtiPkbob4TQdCGEGozaABWbXHlUM3+0kEepjE0bZ1
	EBr/gfG0cKTS+ZT96BDfIwhOvPnwSjXqlRZJFmxs/hhtHVL31i7qMtIhI+lNgxRgKevVcxfjU6H2q
	+imOzRZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBeCK-009pOM-5x; Thu, 05 Aug 2021 14:18:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBeCH-009pMn-5m
 for linux-nvme@lists.infradead.org; Thu, 05 Aug 2021 14:18:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628173086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CgTtaO9aoRpCiTYl9JW5StPBedgaEjV6BwrhWwCNWbE=;
 b=YFvt4FzhwhYrUrOdefEuGzX0UMT7nolo6/xVvNp7yHr3u0sppIKFcg3ZpQ4eUD5LT1JeuJ
 HoNJ5GtIYzOCMIbq3ER30ny1Hc40TY3N7NM3p2vhDAV5SfGaxkg4lDpaB7SJsmlPoO4z2+
 EmribqN9Yg4RGIrPtWSDLjIlpSv+nhY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-c6z6JEHGMJe0DH8ARyr-fg-1; Thu, 05 Aug 2021 10:18:04 -0400
X-MC-Unique: c6z6JEHGMJe0DH8ARyr-fg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F369693925;
 Thu,  5 Aug 2021 14:18:00 +0000 (UTC)
Received: from localhost (unknown [10.39.193.135])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A98375D6A1;
 Thu,  5 Aug 2021 14:17:52 +0000 (UTC)
Date: Thu, 5 Aug 2021 15:17:51 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Geoff Levand <geoff@infradead.org>, Ilya Dryomov <idryomov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Song Liu <song@kernel.org>,
 Mike Snitzer <snitzer@redhat.com>, Coly Li <colyli@suse.de>,
 Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Phillip Lougher <phillip@squashfs.org.uk>,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 linux-um@lists.infradead.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH 08/15] virtio_blk: use bvec_virt
Message-ID: <YQvzD4FlF7+AgrSw@stefanha-x1.localdomain>
References: <20210804095634.460779-1-hch@lst.de>
 <20210804095634.460779-9-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20210804095634.460779-9-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210805_071809_363005_FAF37A0C 
X-CRM114-Status: GOOD (  16.95  )
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
Content-Type: multipart/mixed; boundary="===============2696325163665754087=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--===============2696325163665754087==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZDhkEMoj7rmqL+Fh"
Content-Disposition: inline


--ZDhkEMoj7rmqL+Fh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 04, 2021 at 11:56:27AM +0200, Christoph Hellwig wrote:
> Use bvec_virt instead of open coding it.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/virtio_blk.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ZDhkEMoj7rmqL+Fh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmEL8w8ACgkQnKSrs4Gr
c8jPdgf+PcMouWs94g0uS6wpaN9fVvtvzsyRrLa0a4jPqggbtSulcjUYQzYZ9BGX
1xnrp3ABDt4KhYhX+iAsAxc4LmWEAYUruE6WxqsxaPKE19XcFuwM/tpwcv5U8/x+
2GvsXderla2RbbwTzdCFUf1m538Dw+eqH8+6Dt0Q6QjCC4EAX3ubWU+pX0K5rLNX
d7M7JCyOzOdU/VJYYVQDs1Vkpu/2AFtQT+hnq7veWzgQD+iFkLNZUEBVFm4jRbkC
5cfC+IUVtDkCjhD2offyhX+djtvDy5IZAnHEMv/ulIMmCzc0o1VgEy/5zNiKnjgg
5CdxbrfAKcA734P4gNIy/UD+hGlM6g==
=Cztj
-----END PGP SIGNATURE-----

--ZDhkEMoj7rmqL+Fh--



--===============2696325163665754087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============2696325163665754087==--


