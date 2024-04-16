Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD9AC4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 20:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j837pImS/au2+KFwIXh6C9Ky+vR1DmjBQqb++ork+Dc=; b=QJIKFFWfD1+SPSHWZwj0Xy3Edc
	Ey62SeswmklGPRWLpH0xKBfhe/BqjqVmKB1yVQ1yLUcZEhO7uf7wIidCoQqwiZ5ZmT/v0k+VewFAH
	Tk1V76SQGklnSsW4PaefTGDaNVf2uTUYeFOZAK0MRIasmV6Nty7ZG0heTjdUO16xAaSah7e31r+C6
	2g/2iJ+JOJml9Cm68TyykkLiyY8JhYSkpUti/g4/svSMkSKM8h7nl3Qzzbf6GHvXf29McryVjKEm/
	qQs3Nx8IVq9x0FdJS0TghmO/JaiILdqNym/U8AYnyBqRrkGEZIj/zoYbqh+90MxD3GAm4/jtw0yjX
	Bv12oW3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwpSA-0000000DiGh-0hyK;
	Tue, 16 Apr 2024 20:30:54 +0000
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwpS4-0000000DiCr-1JVe
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 20:30:53 +0000
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-283-8fUyrjDEOg2_iWv6kXj3eA-1; Tue, 16 Apr 2024 21:30:38 +0100
X-MC-Unique: 8fUyrjDEOg2_iWv6kXj3eA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 16 Apr
 2024 21:30:09 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 16 Apr 2024 21:30:09 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Aurelien Aptel' <aaptel@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de"
	<hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com"
	<axboe@fb.com>, "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>
CC: "aurelien.aptel@gmail.com" <aurelien.aptel@gmail.com>, "smalin@nvidia.com"
	<smalin@nvidia.com>, "malin1024@gmail.com" <malin1024@gmail.com>,
	"ogerlitz@nvidia.com" <ogerlitz@nvidia.com>, "yorayz@nvidia.com"
	<yorayz@nvidia.com>, "borisp@nvidia.com" <borisp@nvidia.com>,
	"galshalom@nvidia.com" <galshalom@nvidia.com>, "mgurtovoy@nvidia.com"
	<mgurtovoy@nvidia.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: RE: [PATCH v24 03/20] iov_iter: skip copy if src == dst for direct
 data placement
Thread-Topic: [PATCH v24 03/20] iov_iter: skip copy if src == dst for direct
 data placement
Thread-Index: AQHaho0hnJcov98wd0yhfxeOP2ZlzrFra/Yw
Date: Tue, 16 Apr 2024 20:30:09 +0000
Message-ID: <a779982fc59f4b9b94d619d0bb111738@AcuMS.aculab.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-4-aaptel@nvidia.com>
In-Reply-To: <20240404123717.11857-4-aaptel@nvidia.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240416_133048_675548_5D8DE809 
X-CRM114-Status: GOOD (  13.53  )
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

From: Aurelien Aptel
> Sent: 04 April 2024 13:37
>=20
> From: Ben Ben-Ishay <benishay@nvidia.com>
>=20
> When using direct data placement (DDP) the NIC could write the payload
> directly into the destination buffer and constructs SKBs such that
> they point to this data. To skip copies when SKB data already resides
> in the destination buffer we check if (src =3D=3D dst), and skip the copy
> when it's true.
...
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 4a6a9f419bd7..a85125485174 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -62,7 +62,14 @@ static __always_inline
>  size_t memcpy_to_iter(void *iter_to, size_t progress,
>  =09=09      size_t len, void *from, void *priv2)
>  {
> -=09memcpy(iter_to, from + progress, len);
> +=09/*
> +=09 * When using direct data placement (DDP) the hardware writes
> +=09 * data directly to the destination buffer, and constructs
> +=09 * IOVs such that they point to this data.
> +=09 * Thus, when the src =3D=3D dst we skip the memcpy.
> +=09 */
> +=09if (iter_to !=3D from + progress)
> +=09=09memcpy(iter_to, from + progress, len);

How must does this conditional cost for the normal case
when it is true?
I suspect it is mispredicted 50% of the time.
So, while it may speed up your test, the overall system
impact will be negative.

=09David

>  =09return 0;
>  }
>=20
> --
> 2.34.1
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


