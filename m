Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40ABCCA481
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jul 2022 13:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GmgpeWplcw1WbsQRx032i0k26RkjiMbJLvav6Jm4NkU=; b=bhc57ot4YV1dxkuCBYLwbh5OiX
	E1QgDik6pE13qHmBRly8E4opb7tLSjjtMX4T0ISNDNfMbOrryjensP1gY50TMZNP6q0dKMUkMdHJr
	h+WWs7d+P59I/fMyJe4uFTZJCWuH/XU6N8Zn3QJI3wYa0V095laNb2Mz4WG2zW7dY+r+YI68Q/7Wq
	gSyhUfxnYap5G6mAStHIN0G1gcz+koQefenqUJnIxhDjjBxqp6t4zcmjdaib0IALAuso3nsfEzi2b
	atNbLKfbH3cZ9hzRKWZu3Os74ZiYqyX3Ih8fn+Qsir3dny3GetlsdZawSkqIRVSj72W+cP2zZ+mOB
	gJb5wyfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDmqb-008wpF-Bi; Tue, 19 Jul 2022 13:01:09 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDmqU-008wZv-AO
	for linux-nvme@lists.infradead.org; Tue, 19 Jul 2022 13:01:08 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220719130055euoutp01cd23be4f787f01552ea6d1ced93a7318~DPIsLH0aT0935909359euoutp01b;
	Tue, 19 Jul 2022 13:00:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220719130055euoutp01cd23be4f787f01552ea6d1ced93a7318~DPIsLH0aT0935909359euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1658235655;
	bh=GmgpeWplcw1WbsQRx032i0k26RkjiMbJLvav6Jm4NkU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Ufolc5ndJZKxR99s8wkP2wIuiQBtyKHVytMPsWakvFHcIz6JWo2qh5wiHtu9Ns46f
	 bXVWl0r9NMymOb0IchNrL3OVcHi8t6LRwcZHEOwxBeNxBKzGQEGfMI4r4io+ebobvt
	 ctcnl6qalRbXK6zmCkbE+gth4g5l5l1haTAy8ZSA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20220719130055eucas1p1eb7005237d92adb93bd0d51e06af8a63~DPIr4IFFU1070010700eucas1p1W;
	Tue, 19 Jul 2022 13:00:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 93.A7.09664.70BA6D26; Tue, 19
	Jul 2022 14:00:55 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220719130054eucas1p2bab34952fb2792189e1101f2c517dcc9~DPIrZy8D33167831678eucas1p2G;
	Tue, 19 Jul 2022 13:00:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220719130054eusmtrp172caaf117f7ed57ffb23cc6af8698a85~DPIrZJaU12986029860eusmtrp1N;
	Tue, 19 Jul 2022 13:00:54 +0000 (GMT)
X-AuditID: cbfec7f2-d81ff700000025c0-0e-62d6ab0728fe
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id D4.3F.09038.60BA6D26; Tue, 19
	Jul 2022 14:00:54 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220719130054eusmtip2fb679f82514f69901ba50832d5c3a76b~DPIrRbMUx0676206762eusmtip2D;
	Tue, 19 Jul 2022 13:00:54 +0000 (GMT)
Received: from localhost (106.210.248.172) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 19 Jul 2022 14:00:50 +0100
Date: Tue, 19 Jul 2022 15:00:48 +0200
From: Joel Granados <j.granados@samsung.com>
To: Kanchan Joshi <joshi.k@samsung.com>
CC: Christoph Hellwig <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <gost.dev@samsung.com>,
	<k.jensen@samsung.com>, Javier =?utf-8?B?R29uesOhbGV6?=
	<javier.gonz@samsung.com>
Subject: Re: [PATCH 3/5] nvme: refactor namespace probing
Message-ID: <20220719130048.gkvgei44m3ssqklv@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="mfsej2skdebvajjk"
Content-Disposition: inline
In-Reply-To: <20220719070845.GB22571@test-zns>
X-Originating-IP: [106.210.248.172]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djPc7rsq68lGZyeK2SxcvVRJotJh64x
	Wsxf9pTdYt3r9ywOLB7n721k8di0qpPNY/OSeo/dNxvYAliiuGxSUnMyy1KL9O0SuDJ+rL3P
	VHBPomJuY3YD40KRLkZODgkBE4n10/6wdDFycQgJrGCUeHy3hRHC+cIoMffWLCjnM6PEknW3
	mboY2cFaXguANAsJLGeUWPHBFq5k66+HzBDOVkaJ+38Ws4JUsQioSqyYOZMJxGYT0JE4/+YO
	M4gtIqAu0TH9HBNIA7PAPUaJgxM62EASwgKWEg3/voEV8QqYS3z5+JYJwhaUODnzCQuIzSxQ
	IbH/z3egGg4gW1pi+T8OkDCngJ7E7CkHmCBeU5aY83oHM4RdK7H22Bl2kF0SAv85JKa//csO
	0ish4CLxplkNokZY4tXxLewQtozE6ck9LBB2tsTOKbug5hRIzDo5lQ2i1Vqi70wOhOkocaBX
	CcLkk7jxVhDiRj6JSdumM0OEeSU62oQgZqhJ7GjayjiBUXkWkq9mIflqFsJXEGEdiQW7P7Fh
	CGtLLFv4mhnCtpVYt+49ywJG9lWM4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiBaen0v+Of
	djDOffVR7xAjEwfjIUYVoOZHG1ZfYJRiycvPS1US4RWpvZwkxJuSWFmVWpQfX1Sak1p8iFGa
	g0VJnDc5c0OikEB6YklqdmpqQWoRTJaJg1OqgSn5ySHdHb+/Onu5/1mhvN87LZPTsilvc71A
	yc3222WH+MqC98cb/y+4+k47Ktztiyzn/Jj1i+MtmJ+que84fK8pkT00QCyw11mz+Sy3zJRX
	e6JOm8zvduTzDKhYujvu2fVr025bZC0qls9q2xL5qLpz2yIbtdXtNoHrMveqOBtGTAz3Onv+
	/BfP1y5Nx/Jce56uvPLkvF39PndWyam7nXt+XGNpe2RcZdgWf4y/YHP74x2v+C78MuK8f+ff
	5646B94LxgUfJ4gE/rrvU7z+T+NirxP3A7O2My/ZK+D1rnNGdaKhxH2mA6mhuQ29vOqzzAzb
	ug/aKxsEn3iTtSq2Zbv7k+e391xtcW5SeTwlUomlOCPRUIu5qDgRALZteozGAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xe7psq68lGVy8b2CxcvVRJotJh64x
	Wsxf9pTdYt3r9ywOLB7n721k8di0qpPNY/OSeo/dNxvYAlii9GyK8ktLUhUy8otLbJWiDS2M
	9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DK+XjjHUnBHoqLz40WWBsb5Il2M7BwS
	AiYSrwW6GLk4hASWMkpsPbqftYuREygsI/Hpykd2CFtY4s+1LjaIoo+MEpN3nWaGcLYyShxZ
	uZAZpIpFQFVixcyZTCA2m4COxPk3d8DiIgLqEh3TzzGBNDAL3GOUODihgw0kISxgKdHw7xtY
	Ea+AucSXj2+ZIKaeZ5S4tPcSE0RCUOLkzCcsIDazQJnE6h99QA0cQLa0xPJ/HCBhTgE9idlT
	DjBBnKosMef1DmYIu1bi1f3djBMYhWchmTQLyaRZCJMgwloSN/69ZMIQ1pZYtvA1M4RtK7Fu
	3XuWBYzsqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQIjdduxn1t2MK589VHvECMTB+MhRhWg
	zkcbVl9glGLJy89LVRLhFam9nCTEm5JYWZValB9fVJqTWnyI0RQYjBOZpUST84EpJK8k3tDM
	wNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgWnOppB8TftPbXt7XXnz/e/w
	zIs4liGdb7imwFCrnutwjPy1wsMyrb3cq0rXnEtI4PO+d8T2wd7OVw6WD0K5XK1Vmjhe6O/j
	UP2ZaNzRfj0+8bfDpQ/p+xbevNcutaO3wPTpd9lAveqwvj/vd29K+SI/48n8J+3i2p2lbm9E
	npn2ve8OKUjbc6ri4jtj/dlTriw41tww7b3aPMn6g4qGdef3bKms2F6zSFKofffFP4vnrKjr
	0tYUU+u8+/Rn6NKnrFJrs6cf9hb/4XlcS7jgY5x5tG7kOg4j1kvJAj+uMzOFs3Hdmnnox9RH
	gQuidygdVLh1bFfexr+fin/P8JLe21956YWBLl9BlO4HZxWbfCWW4oxEQy3mouJEABrceVxp
	AwAA
X-CMS-MailID: 20220719130054eucas1p2bab34952fb2792189e1101f2c517dcc9
X-Msg-Generator: CA
X-RootMTR: 20220718052850epcas5p24450d4c756d1eb0db6f4cc9c24bb184d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220718052850epcas5p24450d4c756d1eb0db6f4cc9c24bb184d
References: <20220718052503.235270-1-hch@lst.de>
	<CGME20220718052850epcas5p24450d4c756d1eb0db6f4cc9c24bb184d@epcas5p2.samsung.com>
	<20220718052503.235270-4-hch@lst.de> <20220719070845.GB22571@test-zns>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220719_060104_827222_E9606DA1 
X-CRM114-Status: GOOD (  22.01  )
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

--mfsej2skdebvajjk
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 19, 2022 at 12:38:45PM +0530, Kanchan Joshi wrote:
> On Mon, Jul 18, 2022 at 07:25:01AM +0200, Christoph Hellwig wrote:
>=20
> > -static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *=
id)
> > +static int nvme_update_ns_info_block(struct nvme_ns *ns,
> > +		struct nvme_ns_info *info)
> > {
> > -	unsigned lbaf =3D nvme_lbaf_index(id->flbas);
> > +	struct nvme_id_ns *id;
> > +	unsigned lbaf;
> > 	int ret;
> >=20
> > +	ret =3D nvme_identify_ns(ns->ctrl, info->nsid, &id);
> > +	if (ret)
> > +		return ret;
> > +
> > 	blk_mq_freeze_queue(ns->disk->queue);
> > +	lbaf =3D nvme_lbaf_index(id->flbas);
> > 	ns->lba_shift =3D id->lbaf[lbaf].ds;
> > 	nvme_set_queue_limits(ns->ctrl, ns->queue);
> >=20
> > @@ -1967,6 +1995,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns=
, struct nvme_id_ns *id)
> > 		disk_update_readahead(ns->head->disk);
> > 		blk_mq_unfreeze_queue(ns->head->disk->queue);
> > 	}
> > +	kfree(id);
> > 	return 0;
> >=20
> > out_unfreeze:
> > @@ -1980,9 +2009,30 @@ static int nvme_update_ns_info(struct nvme_ns *n=
s, struct nvme_id_ns *id)
> > 		ret =3D 0;
> > 	}
> > 	blk_mq_unfreeze_queue(ns->disk->queue);
> > +	kfree(id);
> > 	return ret;
>=20
> Seems this new function (nvme_update_ns_info_block) requires kfree at one=
 more place?
> This one:
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index bbdf0f95331f..5a917211e377 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2011,8 +2011,10 @@ static int nvme_update_ns_info_block(struct nvme_n=
s *ns,
>=20
>        if (blk_queue_is_zoned(ns->queue)) {
>                ret =3D nvme_revalidate_zones(ns);
> -               if (ret && !nvme_first_scan(ns->disk))
> +               if (ret && !nvme_first_scan(ns->disk)) {
> +                       kfree(id);
>                        return ret;
> +               }
>        }
> =09

Should we also take care to hide the device?
As I read it the call to nvme_revalidate_zones can return a -ENODEV
(through blk_revalidate_disk_zones) which is the original condition to
hide the block device.

> With that-
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>



--mfsej2skdebvajjk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmLWqvoACgkQupfNUreW
QU8WRgv/Xtic7+gcWMdLC0xy6RQ5U9UT+3ZGO0g8QxHDEiy5teCG8o1uJOu6JhzZ
I5QIiBjN7qDCV3UNF7IX+DpHgLjJBCDrlFI17tqisrxnGbV3dSl4iOE+Ou+vhk9F
kKLsSSUA30Y6Yqos1p1vtclb6vSlBsb+459yolktpI+jMDXgNd/5rqpjjW4SZo2J
U0OxtHcZketytOzLLC7GMZUlPdR8Y8Jm6bfhXciL7/sA9JcFEyZiAkS+KsMFVaXF
EQ9t3cWvhdQt8Pci9tLCFNngViTma/td8dE8RF1Roc8o3bJwSp0JsylbS7iJa88w
Q0DcgykhHSsSWQ8a1d1yLBXCTCcKBsWpZKju5GhX2wc4tZGrQISi/4cWsn7yFfNg
zz9CEs90Guvn6GHSOBNgBzvCW9QWvdD3r3dVwS4ArRIARo2ONOLb/r+xCEqzlCSi
p4uwZuV+B9n3rHKGCuRtAvEKHpYjy3vK/QqjAul/7/n/j16n6wFxsk5EsgfFiPFu
fqhtu3O+
=q8Hk
-----END PGP SIGNATURE-----

--mfsej2skdebvajjk--

