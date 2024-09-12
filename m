Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98192EED601
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 13:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WQ9U3jGO9IhLNkUxZn4R69J3IeP0fVY3Z8M7ghAwVgI=; b=sY16+GaNqczxlRhrtGFL5KtrVm
	obV3nLFg75jk+KxgrZvm8dzS6nAM/vTJy2y1QjTWiq5AX/eLgkuVEu5VhmzWrekg69ohfqDcpMfJW
	oKGHEtsEen2H1/TOunQbPszVGydxWVC1s7ROvyLU689dYfZhkSAlSg8SXICG0MFpyfO6FLNz40xEM
	J7koHLUAMpIuymsKg6u0dgL9MUbZ/FMKQWQlDfKagG9xoHyM1LSN1yD4wvGYtpoNVsQvq5GmbkZKi
	UQ61odFw9t8avuQowDioYcFNgr5UIuco8tFHZsq+hSR76SRsDdrijWhjz+bCwBI9bwTlrQ9I7LRVy
	R90JYonQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sojsJ-0000000DCWv-1kHX;
	Thu, 12 Sep 2024 13:28:43 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sojsG-0000000DCVi-2eUS
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 13:28:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1726147720; x=1757683720;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V0nfrcDy87GEJfgi7flIcCT6ktOLwMCKV+gEf/0royM=;
  b=adHPteXXVemxSiQHatfV3gJFzN1/5TL/rwEuExm/YOxIhUg68foZNVOl
   /xW46RB0tdJkJ03APaXuo5OXIUYwZI4NQPhlFBnGZZy/IUgGO6KCn3SBr
   wEy99OIskqief1l94YiLo+4A6GZij300mXn2oLMNUVzwST1r6bkPUGVNY
   8iSfs7jC2ZWV82/6bXTy2E0FJXBx/y4Mc7hC2hlL2xla09jsDeTVVTkQp
   XC7/BU7uSImFcygb6vLw8sTPZKN1/nlYsAvbrWViCepoTwnQQsLSvnEKb
   jD4Q9uilOu7VJg6ubbsQLmW5kl6sBOv/gqepQLWNJsXa1wAnGC5rgJb+m
   A==;
X-CSE-ConnectionGUID: EJFsvYMvRnyC70jb2mqAng==
X-CSE-MsgGUID: XrjX6PIkTuahoqvbv7kFog==
X-IronPort-AV: E=Sophos;i="6.10,223,1719849600"; 
   d="scan'208";a="25903265"
Received: from mail-mw2nam10lp2045.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.45])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2024 21:28:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqeGym/21NVRTIyr/L2ou4pi6hSd6PN/qgjs5+46GhanKy0aWNh8CwgFHuI5ZKZd1D3DTp+6QiKkrAAwEvUi/vbR8L0VEx2RC0nmJS/SVd0O4vBUQXn3ccC7jR7teNAJwXDAVuGJbhov+FdlcxUbzH8TvHoAPDiWvOMBMKVcle5J0coRpcyj6oFiHNLkZbvmp7gcIbQwrLJrUv80gc8SERSfmm2JvsOWrE4bnKL5KxCgEWrrC5y0+yE6CTj978w/5pfYlCLL9D6UoZQuDn27Hb/RoVIHNOE0qPkm2/LIgPTgjGt1r9AF5R7D15/+Ywz/Si+mnfqf25nLbnalQl+z7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQ9U3jGO9IhLNkUxZn4R69J3IeP0fVY3Z8M7ghAwVgI=;
 b=c+U4fazxDj6il/MDPCwdfyQro4UPWA5anuQj5EBtNyPe9rMZGBHdAjFo+S1yRvjSE9zm/Fg+geZ8KSyfBA0wPb7x5Po0beQdbjgDRQCde06ZiCrLV7A347yriV2YKCvjRPH0n7EhPvKEDktPpP+sVPRdSTCUsY/Rh5IFpC7mcmnO2aGk2wOLhfFNXq5bwBC3kwqUD2ejJEFh5f1gq+4G/5MOo6hdOj7xs3Bl72zeDJrpRmWmPLZW74rbIZkortfqdlGZ18AvbYRT7vapAx9a50mfml8mUrJ44wPxvPXJ/APlTxysZXDyskMbO2VvPD5KS7JL7lN0Gw3zjE7IZPqdSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQ9U3jGO9IhLNkUxZn4R69J3IeP0fVY3Z8M7ghAwVgI=;
 b=s+AY/NeOJ0MPKhXigVx2TPqL2b5ia7f5MXfw5mZ4u8bTDi6idwADThOpRRl8jMTU3EeuGVHxoNRKn8DZ1ESLn1MD9JjYl/quWYjE9eCJjnommbxhYGGTVUrHt1vZAYTTzo3UUj5i2l0792Yr9nOX7RvepVvnQ5xVW/sJ61I0KO4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7904.namprd04.prod.outlook.com (2603:10b6:a03:302::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.18; Thu, 12 Sep 2024 13:28:36 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.7962.016; Thu, 12 Sep 2024
 13:28:36 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: Hannes Reinecke <hare@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, Akinobu
 Mita <akinobu.mita@gmail.com>, Martin Belanger <martin.belanger@dell.com>,
	"hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH] nvme: tcp: avoid race between lock and destroy of
 queue_lock
Thread-Topic: [PATCH] nvme: tcp: avoid race between lock and destroy of
 queue_lock
Thread-Index: AQHbBNzREKULrCYt30e3MBDquy4VTrJTuOkAgAAmIwCAABIcgIAANHMA
Date: Thu, 12 Sep 2024 13:28:35 +0000
Message-ID: <mz7efyxba4h7qui5pfykj2g3d76fwtmco2nyxsbwzhox3th35b@vziif5djzv7p>
References: <20240912062707.1759715-1-shinichiro.kawasaki@wdc.com>
 <f32b1c7f-4c63-4333-9f43-f777115de9ce@grimberg.me>
 <0a699cf1-66a1-4793-874d-05902149f727@suse.de>
 <1eefa343-e2c3-4a50-8bce-16b451bea3cf@grimberg.me>
In-Reply-To: <1eefa343-e2c3-4a50-8bce-16b451bea3cf@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7904:EE_
x-ms-office365-filtering-correlation-id: d421296f-b1f4-49c1-331d-08dcd32ece27
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?aPHDwXkozg6rjFDtKFLUhuyT+Yg/SR+jMheHTtru2DPdaouVXAK2GUQGwA?=
 =?iso-8859-1?Q?3VY+jYGJRlRnpGbQxCHh7yIPN9QiFYrIYYFll/fN/GYgAuukWpGOd7iKiC?=
 =?iso-8859-1?Q?H78kjqP6RrQ9tlBEETMRJVur7P+HCGnNoN9qyShb6OifRVAF7BYZSoQlLF?=
 =?iso-8859-1?Q?NQszV43qXdjbfyXcNKXOMCj7STOEYPSLYkeZrCl2O223GKh7EPN1UTe54D?=
 =?iso-8859-1?Q?/kTVpoV7/OPoH7uRdX0pG58W5wolgsdVcVArCi3Fi6BX+86OB6EWnh1aH1?=
 =?iso-8859-1?Q?3owTmOE+l2OnvWmKMIYSKEl7zcRTHKJy6y3Z7NauVY3avWHls4lSu20qOu?=
 =?iso-8859-1?Q?jp1v0jmVMC1rK2axPs5ZiUpRci0PAVJKIm/kEKZa18FePaYeTqFlHQVREy?=
 =?iso-8859-1?Q?q/RItudTlXV3vS5tFlpAehPiaCUqGFxum4uKTHTl5nLwKVdQBvD4qn9n0T?=
 =?iso-8859-1?Q?tvR2UKQLWqlWLnftEvdoWfpyDoo652z6IOle7cu2LSy2UMajmIPY7MbEbL?=
 =?iso-8859-1?Q?N3Fm5EoOb76RC/cyozlEPl60+uGMNoYwVU99bcgE4b8VC9gHb/1PhQ46jp?=
 =?iso-8859-1?Q?VnyXJdW+c/61p7zKUCbUPoEPNBvGwaBRZOWc4k25D8j3wjTjeqRdCE8q3b?=
 =?iso-8859-1?Q?0w84pV1wLpmpQSzN7UaZCZMVjvWyjWT1WRh/fcBC+pq3+TPZiSU/SQNY50?=
 =?iso-8859-1?Q?l8zSGKKLE62UEbjQbtxoNEi3hJaLJvQGDDAqt6m28uL/MGlSI1w1H9dq/0?=
 =?iso-8859-1?Q?tnuZRyk/nLUBeww+Em5xDcgbi8FrgihfvNJXdbUc4Imtm8EcoWvnLxKvy7?=
 =?iso-8859-1?Q?9HP55UukMfHhOnMZByajSXKQSQv8QE8BLGgxehI74EhVHfDdgAKPdmUKaN?=
 =?iso-8859-1?Q?1otg4N/mgRpWjWwQ9DH/TjJ9sytpc8PS/rWGf+aSXRUo/rIVzqPM75a0f7?=
 =?iso-8859-1?Q?Ot/HqxW7AcbPqvb2fjfoGVTj0xs5uoDqSSQKVcBdzNx6POPLc/K18Vl+2d?=
 =?iso-8859-1?Q?3TTyFygpnjkDSEIn67DXiZYGjf4EZlJkZkYlU8Z60EjlniDCpCDk3c4VAr?=
 =?iso-8859-1?Q?BpTUU8Ef1YO8idhGXso6vo6OF8MSGRhfSJ2HuNqME6oMlNZpWCAi5ZtUdx?=
 =?iso-8859-1?Q?Fh5+KCMETs22xKOkSAuU23/Y8vBtEc4qNDF0+6qC2niESI7JBs7C73FATj?=
 =?iso-8859-1?Q?6MFLdKAhlHKAng1ggaMwaGBbKKJgDTRn1z8G7mczYQDk8kKoDW1v6LTP+O?=
 =?iso-8859-1?Q?Hwswq4AqIkCSZYq2OaTX0Ir8rCddj4AINuTZ3wkLWYoujhECx6mQeoRVhT?=
 =?iso-8859-1?Q?ZlDgvAok809L8/6Nb0mSZLXdG2QJ1ivuMecDpqkpNHvnu/hxfHUx8uzbb1?=
 =?iso-8859-1?Q?jN7hebRl95XHQMcgsp7apgaYz6lDFW402HcwerDLDCHlboVpVx1Ne/RdYj?=
 =?iso-8859-1?Q?F/qDYOFjoNBXyFWH9CNl0FFi4hxxDfh+e51geQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yEoDkQQ7MbWhBHjyoFSJ7qGIIlGo64DlcxB2TRr9PtorTZvsuNHtM6qsKU?=
 =?iso-8859-1?Q?NtW6LpFPyPrxw9LqWkJilVLoHHFoHIsItKnf6ECq4SPJcCOYVZaX2Eeaqr?=
 =?iso-8859-1?Q?m4xWsZSvd1NcTVccY/UdqLwXapJBeEct8qWx/cihFMloBzfYW1yN24lpWA?=
 =?iso-8859-1?Q?kKuPOWHtviTuYtqRtrnKSXRFU6jwmGIXsLzkyEw7u2fz6Ywd0NMMTqMAsO?=
 =?iso-8859-1?Q?bHLFEvLwIdL8uYofYPq47o+vsdmmlAKBuwkJGXmI0SpZimo/q547KAbvHd?=
 =?iso-8859-1?Q?jE70E1W97mQOrEmNt5ss6J2gL+gQnArgl3OlgYPyBroPdKf7xi2gY2fvxS?=
 =?iso-8859-1?Q?v3taZxLaBaYkkdG4mBkb/NDE7rqOw3uXxYa6rpP3vaXL+7M4wJXs0uYcPV?=
 =?iso-8859-1?Q?Xo2BklZeLZc8TMuIXydN4DOcWvnUIOsrGm7KXlgMApT2ZiWDjcmy0TGP8w?=
 =?iso-8859-1?Q?edAmbsoEk1fBvETwgDwGJHQsFZYgaPjSQVJA65nnFTLzqQ1dckxjSAOZLl?=
 =?iso-8859-1?Q?CPcFpj2OnumIAdEx6Yc901HPtq6V8kRDXNHjntPebVq1eVp+DrV8X5eo3C?=
 =?iso-8859-1?Q?uhd9HMrg9E3LtrWO5f5epFqRdfTxMYBoEEnlU4eYU9tzOcxrNNFJkezrA8?=
 =?iso-8859-1?Q?WHFF2ivE7uhE/f3dBzxncDmFrgBj8nFX/okxahRQaWB0VsR1Vgtg9OgmXX?=
 =?iso-8859-1?Q?2jE75wLqVj+jyfHsNdcrtpttMJ2YK8AwZDwBzFoAzUWOtnzE+ppHKcPS4c?=
 =?iso-8859-1?Q?pIoCVV9QNuKyd5xFpDpYx9Uc9f9H0HJRaRCW2Np7wMahprtvx1nsIdNGD5?=
 =?iso-8859-1?Q?yEXgimdAsOy422C9Cdegilk6WGCQQKevYFI4U/5wbMU4WJrCGpU9DlC8Xd?=
 =?iso-8859-1?Q?b6H0ILtG7qsTLYqaAFXS/BNYxJqp0X3qF5Ku4YIV6Xws/0FYBABBSnzlMK?=
 =?iso-8859-1?Q?RYbIy+LZYspfbNL09/iVuVI82arOqImD/EWTa7y2YFpLCNOWShRSRR5OWB?=
 =?iso-8859-1?Q?/OkCD/08BvvuWtIZVccnFO+fZGzwzA4k1Nj2RYlvASdEAX6b/I+xG8imZC?=
 =?iso-8859-1?Q?Pf1PW+i45Hle7ajbgFYyj+5ghSDm2X4Xpunr7fpeYYZ1t/ON1oiRCcH6EO?=
 =?iso-8859-1?Q?rgVxViWY1pxlyrynfU1Ms/fiij2YfWqzk9EpPuAJASZJJlIdEPmYoJ/hTj?=
 =?iso-8859-1?Q?YWoIY8gVAFuR/Nlr5wdTERBjCC1o+5cj8eZlEUEVImV3QOCV7oag/sLjsj?=
 =?iso-8859-1?Q?X5bU4CEBWIXSIGJp5a4tUFOB+5Tm4hLNaF0boF/FyVc8SNzJFsliCgglRm?=
 =?iso-8859-1?Q?6EQF7hTtV5TVRI88kGl8SWip6OEY0pgBONKx/Q34oFnk8ArQV+Frn2Q0c6?=
 =?iso-8859-1?Q?WC455fictCvDtnJzImgZveujhOAz7JEmN4IabQcYqSGsnOGpHLQ7aqXjFy?=
 =?iso-8859-1?Q?wS9jwUNhH6x4wGhbS0Hc0Cv9N3xO+3sUoP+HSMBVgGjn7W+0J5r0EgMXtB?=
 =?iso-8859-1?Q?X5VF9WPKRMf7ZiMjF9T0pYkWtrTMdIykwDP3MXIrL8anzrPx/abPEC1py2?=
 =?iso-8859-1?Q?4QbXYQWBcb5DUW0uMYxjHTZSKSKgGEN3+dOqpynkiwXMh3OyGBItOarbgz?=
 =?iso-8859-1?Q?t1lcFDDS8nVlW0N5Rt3Ff4DbyA8aUPMwHdHJUgG+oV9aLY4QVMgEQHbmiG?=
 =?iso-8859-1?Q?9g4KgZ7gIukETs6od78=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <02D8F496FDCA9C4586133EBD99F89ED0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: un9wyNh4PFZxiWVgv3YcHxPaMfJ/npMZy6Fjq9ayxhhY/O8ghCoy/VH/zw5f4A2YWb2A230WEuIaHYJ8Bruwk0HfjN9klP2PD1Zl0e/9rlBHIrsIx991TXCsTDAjoDX7tbahwnpaoLg5qYDJ6z+ZJI053YuIhuoMKbruim0Ryoaw1PibTyr4OWrlBChbHRyGDUJijZaHbF8rvubxuNPWf8c4dEBTAl8E4XvH8TQzJr1OTUANCpJOb+Z32NtPhhD+a8flXRQ6ylSTgUvCLIWKaMnlTcjJpbxy4ZS4CJIOmdNVY0hlYl1zkA5LJ6IRsfuRZbdcqDKfp5+8VVMaUsVZglyVgvrKzKGin9efbsyT9zydxAVUz4kri2jYLAGgqaq1cdj8+0LKWmmRF6aueIuQ0ZLySk24ld5tqD3VOUPWutUwHKDBmH56c5eC2kKhhUzelUfXQ/p0DKR2lQrK+bFMbnncHk8Z61fK27qNBdC9HF5F369cJaMIXl2lowu+8FJpRvAJKQXd38EWvIpJOrZ47jZervBOULD7SM8pCXNcX5/TBWVOZl0fuOJu3znceZi6svA3BFamlA/oqFOtszMX6QlqLdlwFT6Jz/bkODJmMKM61hQWNwZp+3nhhdSVJWuL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d421296f-b1f4-49c1-331d-08dcd32ece27
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 13:28:36.0160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v/Uwsjt2thEB8VHsWYnWQEYZX0kMJCxzEXQW4H4gpv0uVv9ZRuU2380aJGP28xE6MPX+oirZlgvYMSY+q/DJ/K2mUr96NyMR57af6zLoCPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7904
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_062840_798538_74FFFA00 
X-CRM114-Status: GOOD (  28.12  )
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

On Sep 12, 2024 / 13:20, Sagi Grimberg wrote:
>=20
>=20
>=20
> On 12/09/2024 12:16, Hannes Reinecke wrote:
> > On 9/12/24 08:59, Sagi Grimberg wrote:
> > >=20
> > >=20
> > >=20
> > > On 12/09/2024 9:27, Shin'ichiro Kawasaki wrote:
[...]
> > >=20
> > > This is really not needed.. You can already serialize with:
> > > --=20
> > > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > > index a2a47d3ab99f..91c19d06cae9 100644
> > > --- a/drivers/nvme/host/tcp.c
> > > +++ b/drivers/nvme/host/tcp.c
> > > @@ -1365,6 +1365,10 @@ static void nvme_tcp_free_queue(struct
> > > nvme_ctrl *nctrl, int qid)
> > > =A0=A0=A0=A0=A0=A0=A0=A0 if (!test_and_clear_bit(NVME_TCP_Q_ALLOCATED=
, &queue->flags))
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
> > >=20
> > > +=A0=A0=A0=A0=A0=A0 /* make sure any concurrent .get_address complete=
s */
> > > +=A0=A0=A0=A0=A0=A0 mutex_lock(&queue->queue_lock);
> > > +=A0=A0=A0=A0=A0=A0 mutex_unlock(&queue->queue_lock);
> > > +
> > > =A0=A0=A0=A0=A0=A0=A0=A0 if (queue->hdr_digest || queue->data_digest)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nvme_tcp_free_crypto=
(queue);

I applied this change above only on top of the kernel v6.11-rc7. Unfortunat=
ely,
the WARN was still observed.

> >=20
> > Wouldn't it be sufficient to check for NVME_TCP_Q_LIVE outside of the
> > mutex?
>=20
> I think its intentional, so this serializes against nvme_tcp_stop_queue()

IIUC, NVME_TCP_Q_LIVE in the mutex region is required in nvme_tcp_free_queu=
e(),
and we can not simply move it out of the region.

As a similar idea, I can think of doing the NVME_TCP_Q_LIVE check both in a=
nd
out of the mutex region. The change below does it by adding the check out o=
f the
region:

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a2a47d3ab99f..ba91f98e90f7 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2617,6 +2617,9 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctr=
l, char *buf, int size)
=20
 	len =3D nvmf_get_address(ctrl, buf, size);
=20
+	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
+		return len;
+
 	mutex_lock(&queue->queue_lock);
=20
 	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))

With this change, I repeated the test case 400 times and the WARN was not
observed. Good, this fix might be enough.

Actually, once I had tried the similar fix using the NMVE_TCP_Q_ALLOCATED
flag instead of nvme_TCP_Q_LIVE. In that case, the WARN had not been observ=
ed
during the 400 times repeat. Both showed good result, but as Hannes noted, =
I
agree that the check by NVME_TCP_Q_LIVE is the better because NVME_TCP_Q_LI=
VE
is cleared earlier than NVME_TCP_Q_ALLOCATED, and there will be less chance=
 the
queue_lock gets destroyed before the mutex_lock().

Having said that, I still think there is a very tiny possibility that the
queue_lock gets destroyed between the NVME_TCP_Q_LIVE flag check and the
mutex_lock(). That is why I suggested the new flag NVME_TCP_Q_REFERRED.
Am I overthinking?=

