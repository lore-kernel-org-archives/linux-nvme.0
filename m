Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B37C5475B
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Mar 2024 05:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fUf4XEngaBTUDAaqXOXVruzvSf2MWvjUttAP1GfeufI=; b=rhzvAISaZcF1ChjIsGbcqLPWO5
	mWABJD3x8pSAnJenZZ4RQtxVVgsZxX2Su4BcbIE2Jcpg6tkMok0ju1YrZ+7C5liLTlQ3q5rYerZUn
	1XecU+rxnjVK7kmHrO4zigaUeXWaUiXwIul4RyQyjY5m8+BH1YdX6nJnq4SKM2GB7JsBMQkEYJFUV
	Rk23UAzVUmh7gu0CEtR5DGN7ToHtQCaca0IDdkyFBR2Kjn2YHRWkAWk99oSr5HbNF4mK2HBTWPAxw
	+DAXpkuY1708uA/99C/xK04hGwydY8SqjdHvCV3kq2kIyRqwI+VQM7Pk0A6M74iBTxp5zl/0ZT0VX
	zdKrdwiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhkIW-0000000GTNd-1bY1;
	Wed, 06 Mar 2024 05:58:36 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhkIS-0000000GTMT-2310
	for linux-nvme@lists.infradead.org;
	Wed, 06 Mar 2024 05:58:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709704712; x=1741240712;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0Jxd9sZ2Sj9tb7ZskNuULGlvYJZXpT03tt1cg9RGV7M=;
  b=KC1GIXRJPRlm43nMX9aA/boFnned6f/Lehk1CAXpv+YZQwa96YxJlUgv
   /6iXLpoQhAsW+7yd8KXtWuTKUtK63HW9xKPXsPOpt5KDZL3Z9XlVpeP69
   gFkEx5Qi4F0NcpM/IfTnqRO6hAjQ3xkAUGzBnc3LSrOEmIYY2UruL35ju
   ty5RH/79mBd0xkvcNMPJ1Mn9pLX8V0YBo2+JZ1+3Fillcs6Yjj2f2komH
   FaLf+sUVEw23kqaNyis7Gbb6TmEKjrl22nI5XfYMdS2JGk9o4L23JrEzs
   oBlriCoRfFGifegkCvxObYsWEb7edt5DHKlqBbs060/ajDKz01MJKNXWU
   A==;
X-CSE-ConnectionGUID: xPx/V+f4SJOX7ebHIeKt6Q==
X-CSE-MsgGUID: YtlIw/8TSKqDF232G79EBg==
X-IronPort-AV: E=Sophos;i="6.06,207,1705334400"; 
   d="scan'208";a="10909101"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2024 13:58:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AB3njPZ0vGqMVJyAxUOgaaZJabBDPwoFjLsXElS3ygcVGuKNxiuFBAJs/JXst2eAUdu5JJoht80M8dKD6Efm2qv88UKZB/V0v0wRq8RJeGGQsPF51lXK2u61FzehVZ8yPLaW7qcJ4vfrfKxrYlET+ArxFOqUz8mgVmOXs0AxscSnNQxO3LgsJW5HLPk24z2b2xsweCYK5xc6PIhGbx3zN0Rgs33fsqq2myhgoZlJAaMt96FC2bq2Li5ZEnGWwD4jCiB8KKWKxUoAv4c+h+I3/B++o/E/Wt2jLE+K+vlTvcMRcUjk/q/iDDrqba29wSznS2i2fhctu8X/box1JtsxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUf4XEngaBTUDAaqXOXVruzvSf2MWvjUttAP1GfeufI=;
 b=mXDTTtIEJPfwGM/I50ZdjIjbOC7wyLtEJkABNxk/kchgpX2JauKICwUw9/S8O8fANQ7yY+0/NREWhqfryN5avC2i99OjG3yKIstgW3uz0Icma1eYtN42LFUoohgnn+TI2UFoUcsTmBAadg3fitDYk3xuVbDGVZpkde5aUTCf5fuz8u5Mh1ZNndeF0opizAXkt07pCPq/ycsQso8+7Szqrehz3/ukdCseuPk3Wo7HvNky7skB2PV3a7s2AVZ0ksfzKezQQx3+8BQNY1Mxo7o8YijPE4G1DvYKeMgsNQB6dP6Z2wiuUQC5uKWG9g8kxLFMkOaQf7PiOHnRi4mgdQ6vkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUf4XEngaBTUDAaqXOXVruzvSf2MWvjUttAP1GfeufI=;
 b=meze33TPyHhCGvcmQFZYggd/1bSJhaX9QM2mvB3GcZxLsmUF6qii1y49prVhikJfVCYtS500awcEH/wsQcMSWHUey/503/hg82sSg1t7yPnTCLX1+EHY3jOZdAZSax75BzWUv50KHdiMV3Rt3Qlyd8qMPZQWzUGBEMq3TCFr818=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB7080.namprd04.prod.outlook.com (2603:10b6:610:9f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.24; Wed, 6 Mar 2024 05:58:26 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b%4]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 05:58:26 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Daniel
 Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>, Jens Axboe
	<axboe@kernel.dk>, "hch@infradead.org" <hch@infradead.org>, Sagi Grimberg
	<sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: host: fix double-free of struct nvme_id_ns in
 ns_update_nuse()
Thread-Topic: [PATCH] nvme: host: fix double-free of struct nvme_id_ns in
 ns_update_nuse()
Thread-Index: AQHab4HxAfEnA0pIlkm/7CWkvGkrQ7EqMEeAgAAHT4A=
Date: Wed, 6 Mar 2024 05:58:25 +0000
Message-ID: <o4aq2whks4bkb4gixxgjzrogh7hkhg6yruoqmggthavjgyse44@g3lifjv5qxml>
References: <20240306045120.2605223-1-shinichiro.kawasaki@wdc.com>
 <32483687-bde7-4c55-bedc-1bd292138d20@nvidia.com>
In-Reply-To: <32483687-bde7-4c55-bedc-1bd292138d20@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB7080:EE_
x-ms-office365-filtering-correlation-id: 021eac40-8977-4906-14df-08dc3da27071
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w0OFm+7PVpZpqOyCA0jY3Lj4TJmqUAzcRgoIH2SMDTrwDI58U52BVd2uqxxtLQ/xXa0ZbnfjbUInPiPP+tUtgVgKURSE5gqM65UXuhJuWm8PbN7LCRCSMpP8K8TNjmhaq1O8y+xEgtdsB97+iBXpk5gwPmIH4v/C/E3SRO/5+rxPT5vrqsPVXo9Pc3MwBCngoYkuE+U3PY42PgAV2RBvmLrqL0+RrEk8oHNpGMNvFDC88+yznX7tVDPz/42gblRktYCP2lSs1CrDccSAVIpTn4698UBWXvEkthP84rGm8ihH638cXsa5TvZIldgcClo342wnFzXwfUwlQbEqal67A0x4IaZcmADBY5hKLTTq/hvLxGcnhX4zDaMZ9F4u13SqJOW428LOB0hsMeYvs+VL1NkKLJkn785pAxsSvJSCAAtE1rRT3HywUGI4SM1rV6LeUqUHK2Do86DpQNvpHPW+ZL/JtLcB0+DnUXss+pKQjzisMDWL/+GQb48C6RVUwczMrsma7AQ9Wbm4A/y3FK+xbPnDRfuP6yiWC2IrHgaYVtfc5+3PFGawBnnymWZ0LSVPhpdDbf+NVzfdRQ6DbpOnHDTnydIZy8zZqJ1QIz6u92JlY/1kWXg/fD3VY9ebv3nyUzpsB6WZdgItc3uorPFHzwIPuNQD4xo6gWaqqM2OdmuZR94ox97F0V2riEVoaQ3dg5KSI5hkzotpaZdP9OG8c30SaPyUcYFwjwyNqAZY6Vc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6ooQpJ3iNxRLnA6PnDr7XvD9yqZ2IZwqGsrX2n6AklVQFIRQoOK240GFPV?=
 =?iso-8859-1?Q?Y4mXU/KTX3tUR5ggH5wzyWYdT0wkiLQG2whbMALV2MZDppHpgEA3BO8R6e?=
 =?iso-8859-1?Q?gR4BH+CppiUGS4dJyl4l9PGTxG6kaoq4jfzfBE6px3SYvbUw1+ILi9VAuf?=
 =?iso-8859-1?Q?rdZVTRoRp4sp6NpP/rBHWKn+nNjvNubDKuS3nccY9BsxRp8dE4SZtZAwsg?=
 =?iso-8859-1?Q?kBVtw23vhiIfTFurVwxq+VRxiurR31odZ4VDNjS0jjZjpu75i1kif0Te2G?=
 =?iso-8859-1?Q?MPdzDtUt7aOz2q3OaG+UIXce82uSNITXf4SsQwilY3WqdaUaq4gvICbZ+O?=
 =?iso-8859-1?Q?ObBpWMAQrV2IqEIaeyA7a6d6Y2+76Il+VAHGkMl9f2QB2dY3OxNl6uxR14?=
 =?iso-8859-1?Q?fKp/kjd3iQUnjD7pYtYvrn4Uxp5zc7GmVv5PjoGSQwk7WOVuDcQTDm+DjI?=
 =?iso-8859-1?Q?R4YaUROUYQMb2c/AaL9ru8HTj4zIqVACg/khOVqIxb5S0IJk+YfCP6tAfq?=
 =?iso-8859-1?Q?hs4kx79fhNLUphew0jxasVgsstN/HP0g3jCyH6Pu5cZP+YNhwARDE2EZEG?=
 =?iso-8859-1?Q?ezm5cMPNlH7veGsVyD3GhlqsbqZa+sFafd53XUOlkBRUBHtpkj7mboFm43?=
 =?iso-8859-1?Q?xdTXMEiikRkOE4ZX1sz882jP2aXzKXdr3DsRKDWknC9K/hiuGtNvqVC7Na?=
 =?iso-8859-1?Q?aODIS0Ap7kzMEDRanhVq8dKqVJVwGe+J8Jz5gP2tJDRl0y8vDNuSnrjNtT?=
 =?iso-8859-1?Q?JD9MnoNHCcvvljkGhmcE2V/udZSM/VTQIX27vGURcmLaRxOtreqhd3SchO?=
 =?iso-8859-1?Q?ivVhTpO3CUPdLXRtiffedQZyl9etyJRMFHYeM59ZGj7SmWdUo7EqfaTeI+?=
 =?iso-8859-1?Q?okbwEm1p6hZQOvI6wted4LnN5LcrS6hxpxJdHgMIn2oqRoi5uF/RGYQIhi?=
 =?iso-8859-1?Q?6dyNHSblv52dHpvVhR2SVeTYceSt0XXltAIetG2dFsbtHOZLBaeSzakRXj?=
 =?iso-8859-1?Q?fx28D2qhnr3yl6Yru0NbKhTebQqOmwYuDqc0nbWdspdZqxS8+HiujTRZxw?=
 =?iso-8859-1?Q?MYqDGhIvLwiACp3dqxJfpbwmcs4PEB+J1pLf0JckcgkJyeiWS5aXiOBy8z?=
 =?iso-8859-1?Q?Urde5+6h9PXjJXuZPzzV4e5q2yfhZQLKKaejJPRezRIA1ImR0z4W4eD6SU?=
 =?iso-8859-1?Q?L7YJ+1dnaJRZA+wkKaZvgubXkua2syi+5UpDIWFgGY8YiJ7VKJf2ozNUt3?=
 =?iso-8859-1?Q?tGvQr5OT2w8yoOFAO4h7n7g+iGa4SnglveE+0QN9Q92hygF9vQyoI2vQ5M?=
 =?iso-8859-1?Q?tk663WKS3UUDXEExBFrBjwhoUmCvcKTNU+xk2AXrPkJI8BcMy3K4iUNsJZ?=
 =?iso-8859-1?Q?d6hlLnbipVIJU/i+t3MrI2rV67j2iNfohXuwr4ul4UGhlqqBJRX7EQLNEP?=
 =?iso-8859-1?Q?8X+QwJYlytz+CDTbJR0lBdotnGbgT5AYNB1yMLSb0iYM1Bqq8sVaCdfbxZ?=
 =?iso-8859-1?Q?w6CrWHeBJjXQtF3LI2WAYl9gwUBiMZM6cIVf0WpJegXMNQg9HRr2cr0T/a?=
 =?iso-8859-1?Q?sdWQ8W/qrVKeHev1LQnr5M7MTVu8ldz0jLJBkuLXOXtPwdDZwfeN0Oidw+?=
 =?iso-8859-1?Q?hrztUR4DFtk5YAjWa4z+zA9dwQ9TamFXbMxL1LLN6B2CKsCmptASVr5XJD?=
 =?iso-8859-1?Q?EfWzMzPLtmIdjH64Q0Y=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <9061290DEA0B4E4783B0720C6707AD1D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bfcCx6hB2u/K3NZVSEB5E9sYPshr8c2QMaRDZ+zcFZkCguPpMxvx7NFThtI8RaBXR7ssf7m7gW04KtSnviROg4Yrew68luUm1K6BMrfh0QkJT+VQFfVXgfih2VtI7aeQTRD6iHv8SBNJtxv4R97hfnsbqEin9tR/rdN+0jyqGjt72ttx59mKYNa0FDcur0VweC+QowWX4MqrKG5tAIUK+qg+CLBVqQi8TxkAVolXy3a47n0iSXsrDEbBuc2fM5giuqLEaLTbR4uXQpbZO6rjYRbTBXKMurjC9OLVncKeeeaG0olJmeVwCUnZ9grPFZBnYiF4fhdRUBuNytwXfex2Q6VguRlYI3C2KYh6csDmsW6VcwajMmd8oFCFwjkVzBstYNmaFj30qPz0lIX43JemzlOy1FUTSQ4M8wmuA2sWeGqNNofnhv8RNWjYb5jssNbrPkyT5S1C2rc9Wutw5v3ga/QbraZna2jCEJNlt70w1NV540xHZ+VOlGHbngH79kAmcVkEn2Od0gYDck07nDCwS+id+Q9sJZV2iGNCTAgsyKo6Iwhir6CmiAYbX/ULqeTVgt+uhA8FFgncMGekDmt1Gqmmtu+9uDHo+KoKIA63VfL1ihYtF/1tVXUsjVcQCn+v
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021eac40-8977-4906-14df-08dc3da27071
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 05:58:26.0190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gFHBok00bs2ZlAPIMfDSMUJums7Hm44dTlgTQ7VzF3jOZOxuqBouYSk+Q7oOmYReVFmZmOsl7oFHJNp4pXUZRE3jW+3bGXwiEK3GzKLV3zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7080
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_215832_650001_96776D74 
X-CRM114-Status: GOOD (  15.64  )
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

On Mar 06, 2024 / 05:32, Chaitanya Kulkarni wrote:
[...]
> instead of adding a label that is only used once, why not just return ?

That's right. Will post v2.

> something like this totally untested :-
>=20
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index d099218e494a..9e12b66c4405 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -221,11 +221,10 @@ static int ns_update_nuse(struct nvme_ns *ns)
>=20
>  =A0=A0=A0=A0=A0=A0=A0 ret =3D nvme_identify_ns(ns->ctrl, ns->head->ns_id=
, &id);
>  =A0=A0=A0=A0=A0=A0=A0 if (ret)
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_free_id;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>=20
>  =A0=A0=A0=A0=A0=A0=A0 ns->head->nuse =3D le64_to_cpu(id->nuse);
>=20
> -out_free_id:
>  =A0=A0=A0=A0=A0=A0=A0 kfree(id);
>=20
>  =A0=A0=A0=A0=A0=A0=A0 return ret;
>=20
>=20
> -ck
>=20
> =

