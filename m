Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F25AC77B7E
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jun 2023 10:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LDwezFQWmcLAquyL0LxEisgI9TzgOcGc+0Z+VpYOXt4=; b=ZnP8shoGYdwTzsOCOP5gDPdKA9
	EPTcRUybog2lup0+x5oTiJXrLJjSq1YofzxfCiSr81Cac0IiStxP4YM6nzZ3tMWsoqujo0iKIB7pz
	jmlCWNCNNiiPdWZ+Q63dKpv/N3SWP9WTdmFGIu2Y0rPflbhfyALDjqXRItGely84hjPFTIte0X29m
	csyjRdC1IuW8Wx4wiZzAWYvAGyn/xDoDnekdbDEjh5EThXT4o0dw4pn/gUoh+jsX1n6hyY+eLHbQh
	wrpdpEjp7hILkRuCxA/+Okp2OpP3KHt0qBhIoyCcFLgLOT3brB2Q2ZIr1Yadt9OjaaEG4wY9uqrIl
	GCt+uo5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4fYB-0030tz-0K;
	Thu, 01 Jun 2023 10:28:59 +0000
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4fY7-0030no-1e
	for linux-nvme@lists.infradead.org;
	Thu, 01 Jun 2023 10:28:57 +0000
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-318-0fhv99D0OlqPvimtjd92WA-1; Thu, 01 Jun 2023 11:28:49 +0100
X-MC-Unique: 0fhv99D0OlqPvimtjd92WA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 1 Jun
 2023 11:28:45 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 1 Jun 2023 11:28:45 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christoph Hellwig' <hch@lst.de>, Daniel Gomez <da.gomez@samsung.com>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, "Sagi
 Grimberg" <sagi@grimberg.me>, Pankaj Raghav <p.raghav@samsung.com>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] nvme: Increase block size variable size to 32-bit
Thread-Topic: [PATCH] nvme: Increase block size variable size to 32-bit
Thread-Index: AQHZk8CokMhanTXaB0ibg7NXJWn+ba91vvfg
Date: Thu, 1 Jun 2023 10:28:45 +0000
Message-ID: <e203876fc20d4c7b932bbff35e8b5e1e@AcuMS.aculab.com>
References: <CGME20230530154254eucas1p241e57af99e4d4ee0e1a677904c3db68c@eucas1p2.samsung.com>
 <20230530154231.8313-1-da.gomez@samsung.com> <20230531130325.GE27468@lst.de>
In-Reply-To: <20230531130325.GE27468@lst.de>
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
X-CRM114-CacheID: sfid-20230601_032855_831844_1031A408 
X-CRM114-Status: UNSURE (   7.33  )
X-CRM114-Notice: Please train this message.
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

From: Christoph Hellwig
> Sent: 31 May 2023 14:03
>=20
> > +=09u32 bs =3D 1 << ns->lba_shift;
>=20
> Make that 1 a 1U so that we're not going to run into sign extension
> issues when using up all bits in the u32 :)

Not 'sign extension' but obscure integer shift/conversion issues
that really only affect 1's compliment and sign-overpunch cpu.
I'm not even sure gcc/clang support any non 2's compliment systems.

> Otherwise looks good:

Probably improves the generated code as well.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


