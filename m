Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9398AD0D17C
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jan 2026 23:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BgGCIkXheq3oVHzyECengbD2JpcArlkEFA6pADsiduE=; b=sgi/xm3NzTDuPID2Oo0+Ez/RvW
	PGLFr8CAdn4ci1n0vdk/QhO4ZR/noBXoRoCafVNn2fVxKfkas9qQTzmVkuooS3SwVwacBl+bRAu8M
	puOICK4ZN05gKDiMTpLmDXcnCbqqo16WJIiFuM+eB9utlwA1Xjx+OXt13+KnVVwYP4c5hNahvc0b6
	7bh/1IvIsKbNuILkGTrpGgocJmvrgZ9ukvNtzMUQzpAny6oJagbrQwyrUW9eWJ4eJDOIW4PBklqe7
	KopCTNjo0tKFrq1Ebq2VcNcFigAxdmWUA6iW+P+pz3pyLopL3bRCuM+R1AvzI9AqLPRLvm3NKe0oT
	8eikHkIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdceP-0000000FjBY-2gtG;
	Wed, 07 Jan 2026 23:09:13 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdceM-0000000FjBA-0164
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jan 2026 23:09:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1767827350; x=1799363350;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BgGCIkXheq3oVHzyECengbD2JpcArlkEFA6pADsiduE=;
  b=NJO3EK3DnJ11X9cI7J6dl0HlH0LbdaFiqYOf5IIuOB0oFicoWWNlCDyi
   UZ4BLoud7NE+yBUCIk+ubzrfGGD3acJdsRndbhbCHInFGnKvAcN+NRoy/
   7HxGCAjFpK90Rws+4bPBXUqak5rhrgm+C24ivwtEM7Y377xMoS2UQH0Od
   UWM9Bs+rcAC3xsF/9UrWRhOpPLkI1iXHJlRW80Zklz32ltlTXEWBmo7ys
   HEtKXjvEwgvn1SP2akyVudHbkbonkhweE+1OvfbhUWknzBnO6oofc60PC
   5ZST3C2g5uYehvT88luxiq+8GjLHxS6KOSqbCTy26m2VPkLOtpMLfyS3B
   g==;
X-CSE-ConnectionGUID: XUwtVYCNQsSILThKFG4QGg==
X-CSE-MsgGUID: 1jC0uC95SceT8w3jzINeCA==
X-IronPort-AV: E=Sophos;i="6.21,209,1763395200"; 
   d="scan'208";a="139095514"
Received: from mail-northcentralusazon11010046.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.46])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jan 2026 07:09:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2cHTrD8v1ihzpJkO5m8dgqjAxxzyd8Q/DUBbKbofGCHosvzhyimL9+FpCN3qJgirY8OAncJcDdKF4LEICiBUQVs1fKF4ecljGFO4txE2QPQvbK6kJvVJxSe6DrMtahFv0WlRKVboNNzODBujQMmapDVnsRysA9qdo8E758Z859DPPfmGfSIiA8Zabpw5r3w18pGcUXpeaoirDWAemaOTFxmZdLy1ISML5kuoBv+XVME01OxJHobgKCHM+yGIlyILMuGtR0zOxgCCIGFuoLvFttQw5XyDBniyNaR5n4mWGxV2/7qS/EhxXiuh6VHY9yG/Xqe/q/1aAkLThvHcfZD/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgGCIkXheq3oVHzyECengbD2JpcArlkEFA6pADsiduE=;
 b=uScxEMk64hosW9P1oOoJDpmXQZyrxbul+MsU27BMmIPIYUzJ00HNaO0pR+vh7GxJZvPHHEZI9SK1JTJYtsHxe6OFMwqFB/XDDexR/TbuHNvSLC0zduEVqdAMPOXZ6do12JWZnj71WtTGoU5GJx3hJjHe1LZPcZNVP8halPP9qCAw5CHcU8YHUY8BiBFp/KT/t4uJpJ1ELmMFZUEzh3H+plXIUS2mjG4mVzDPlelzs0cdKeVOvy1e0ih8s+9f988JEeXVWpiPln96nckTY4bTS6Odcsk8AWEvypCvpucqmJ56mEFqoqM8iu45lt8qNb+3G2rpuK0IQ6HZSBSu0Owsbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgGCIkXheq3oVHzyECengbD2JpcArlkEFA6pADsiduE=;
 b=IFlAtTRHejhI538BoFBATgihEJoszKFsxd+Vou9E3VygsU6dNy9E+5/gnLCkPiWPb8YAQDf77IAqwwvDzAEHHDVT8Tdo9XyuSAoVhfe7umqHgNWcaW6OIlaPKf+lHXNZ3pOg3f356lClAN2gf+ekWw6eD7MSFELvXFgoyJDZ7mM=
Received: from SA1PR04MB8303.namprd04.prod.outlook.com (2603:10b6:806:1e4::17)
 by CH2PR04MB6919.namprd04.prod.outlook.com (2603:10b6:610:9a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 23:09:03 +0000
Received: from SA1PR04MB8303.namprd04.prod.outlook.com
 ([fe80::8719:e407:70e:f9e1]) by SA1PR04MB8303.namprd04.prod.outlook.com
 ([fe80::8719:e407:70e:f9e1%5]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 23:09:03 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: hch <hch@lst.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "dlemoal@kernel.org" <dlemoal@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme/host: fixup some typos
Thread-Topic: [PATCH v2] nvme/host: fixup some typos
Thread-Index: AQHcffkVzSJWAc40hUe0hEKD9dpRJ7VGf24AgAAGyYCAAC0pgIAApeaA
Date: Wed, 7 Jan 2026 23:09:03 +0000
Message-ID: <80d2135c5bb4430a35c0eb9cd59138b4f4811547.camel@wdc.com>
References: <20260105040829.732046-2-wilfred.opensource@gmail.com>
		 <20260107100920.GA26943@lst.de>
		 <7db5ef3b6980270c948f6bd5dd9685e15493302c.camel@wdc.com>
	 <20260107131515.GB7575@lst.de>
In-Reply-To: <20260107131515.GB7575@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR04MB8303:EE_|CH2PR04MB6919:EE_
x-ms-office365-filtering-correlation-id: 093c1350-ede0-4598-091b-08de4e41bffd
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?N3U5c1M1SU5CZG1XZVlTdi9aejhTQk1NMlZsSXF1N2pPZFovSVFZR2l1cWNu?=
 =?utf-8?B?b3pyekNyVHpONFhETkt6U2Q0UWcvbkxWanhTK3owaW5zOVhBUEdWVEI2Mkc1?=
 =?utf-8?B?WndzUE5aZHZDN09MRW8wTVJkekZ3UEVkRjJFbU1yTmhZa01DdUJyQ2ZwM1ZP?=
 =?utf-8?B?NnhGU0VrVHk4U3YxVVkrUThvcGRUN3hyeDYrelRIUjd3TDVMYlB4UnlwZGlQ?=
 =?utf-8?B?aU1GVEhiMlRjd0lXTVhCdEtDaVhhbWpEVVp0UjNZVytaTzZ6YkxGRzdiRHBO?=
 =?utf-8?B?bUVNQmtyMVM5ZDNFT0ZZc0YvNmFKZlpaYTZzWXF6THdXSTRRS3ZoSThpdEZt?=
 =?utf-8?B?bnBBOFpDNm9SL0dKanZEbGdDMjRLQmFmTmtZSW5LZlAzZG9UbktoT0VRS3Fs?=
 =?utf-8?B?Wm5UemtRSlNXOE50VWNoMi96MEFwcFg0V3hXZkFrTUZSZGJyRG00cU40TE4x?=
 =?utf-8?B?eGd1QTNrWHoyRjU5UjQ5QmZlZEpXa0lJK2hQZ3lQTmNja3IxUlpXcW5Zdkln?=
 =?utf-8?B?c2dKbWFtVGdWcWljZnkybUV5TFJVWE1uRmt4aE16RzVOZTBLYys3aW41OVpu?=
 =?utf-8?B?NWludmhqUDlvNi9JY2lSZkpqVzViK0ZkSjRNVXBLQ3BLT3hnYTNQWklUK2tT?=
 =?utf-8?B?QVlzeERlU3BLSFAzOUdEVHU4YU9WVGZLQkhaYVF1TEpURjUzenJlL2VPMFpR?=
 =?utf-8?B?dzRSNnZsM2R0V0pTSG4yZ2hjTVlzM0UxYk83N2JkYU9hcEptdVBsSmEzMkNj?=
 =?utf-8?B?YkwzWjkycGRmRnJNbjh1NVFMcmc0aXhvVFI1YWk3RS9Udkc4SGNKQjdUUEFI?=
 =?utf-8?B?aTlHWFVBZTJrZm9meStpeEZOdkR1dmdJczZjYzl5TzVjSEQrblFFVTZWNStT?=
 =?utf-8?B?YllLaDZaTmhlU1VyV2NNNVQxblAzaUdUaFUrOERNZnU5V2crb0xUaGg4b2Er?=
 =?utf-8?B?YitCTmFxakpmaHNyejlydCtxakRRWXg4anJnY0NyWTE0TW5jSGdCMndFL3RZ?=
 =?utf-8?B?eTlFL2t6aE1XYzhtcDhMWmh0c2l3T1dNU09JelM3c2x6Nk5CSVZnYnVVZk0v?=
 =?utf-8?B?REdMdGFVUkp6dEowczNwQU8xNlBPb25GMVNrTWZMaW02cjIwT0lzZjR4Wlhp?=
 =?utf-8?B?eHVGYTIrMmF5eGNzZ0xlVVhlay9PR1Q3d3N6dVRYbkxseDN4RlIzY0x3UUIr?=
 =?utf-8?B?aWdGY0RQblNHNlJJTElDeEM5Ti9QdEdHa1VRcnBuNzFoczh1QVFkeEF5aytl?=
 =?utf-8?B?WklBY1o0RDZNc09YZjBUakYwU0plb013UU0vdzYvMmxEWkExLzM0dHZCYWQ4?=
 =?utf-8?B?eUtwN1JFU0xqVkdkc0NaOHdFelJEUFc2U3RlOWl4ZHV0YkVtakRUSk11Nzli?=
 =?utf-8?B?VXh5cXNoWDlLRENPSC93YXZJWEt0K2JKdlpBa3NIUlo4b1RWcmlBeFEzNUhw?=
 =?utf-8?B?SVdpWHRMRnFRWWV3dWdSV0hubGw3VU50djNhY1NVQ3IzRUIwNzJrNngwQnln?=
 =?utf-8?B?TWMwWmJ5SmQ5Q25NczRsQ3h3UHZrdXNxUDZkZ0NqUGd3dGIwcTN3U0dxR2VK?=
 =?utf-8?B?ZHlzTnhCMU5jRnI1YStiNGxqRDZ5VWhYQlNIY29NSWJaRjJpOXV0ZGVvWEZQ?=
 =?utf-8?B?ZUdwL2doTkZGNmk4T2Z0Uy9VTjJDa1UrbHdvZCtXVEFhaklBZVdKc3hQNUpp?=
 =?utf-8?B?Zm93azJqdWZBdTJBbHA1R0V3ZFkzR3VSc3F4RW93cHdURjlYanB6OTBLV1R0?=
 =?utf-8?B?aWtoRXVsM25sN0hzMFVGajN1VXJoRkFwYTF3VzFwaVZNVWRsaEs4Q2k1enNn?=
 =?utf-8?B?RXZhRG5kTGp0N2h0a29zQlUxWkt4d0p1R1FhMy81dEc1ZVVwWDZ4OUZKcU9R?=
 =?utf-8?B?L09vSHNjaXZrbFRFSW1iWTFFOGUzVUJmR3hoZUpBY3lDcnVZQ1Z1RW5rZ1NO?=
 =?utf-8?B?UEFKaE5rMCtBSUNib0xTMkh1R2pmWjM1QWovTnZ5ZDhrTVpqeUd5cVZuUmxs?=
 =?utf-8?B?MTd3VDF1WXQ4UE8yd1pJQVZIOVpPOXEveGplOW8wMis2NW9HZFBLTkgxNE96?=
 =?utf-8?Q?0DtZv3?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB8303.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vk9rK0ZxODJZQ1dwR2M0K1BXSkMvTENMS1h4K21kQXJ5djdXQnFrK09NMXl5?=
 =?utf-8?B?dUJzWUsveFprM1RRRng1UENoZUQ3THhaZmcxUXd0c1d0NVI5TjM4RVd2WDFM?=
 =?utf-8?B?T1ZMTXRtNzYxaWFVQnloazZCQTF6cEZVcVdXTk5FUUJVWktTeEp5NEtoU2RN?=
 =?utf-8?B?bU5LdmNlQ1MwbnRpSnVQYmp6TGl4eUk3cGowZFE1OHJ3a1Y1b2h4T0k1K1V2?=
 =?utf-8?B?aExrN3VINElYazJFTGxJT3QxWndTSWFBa0FQdHFMRnpmTFU1dkFMY0phNm9w?=
 =?utf-8?B?L2t4c3pXK0lnZ1M5KzVSb2Q1RGd2UFZ3VklZUDZSaFV6eUhqWEh6L1NRa2wr?=
 =?utf-8?B?eGV2MlRBV3IrTjVFTm55RE9lOUt3SHZ3QTlzVDExUDVzMzVmVC90N20vZTNN?=
 =?utf-8?B?aU5sTEFacWM2YnZRTHVER2tUeWRjQVljQVppK1VzZEJUR1JWZEU1b3E4OGMz?=
 =?utf-8?B?L2xwb1M4dTlsVW9sWkZHeC9pb0JncmgvSTZ1bW85MkJNMWo1clhLNysyY1cv?=
 =?utf-8?B?MVI1OXQvTUgzR1FFNXY2L0p4RkdNaXpMc0F5c1R5K2FhTFF1VUhCdnVHTWVz?=
 =?utf-8?B?bXF0UWUyUS9RRklxNEkvZ2pIbS92NE5NdHU1UlZhKzJBYmV2UFE0Rkd0VE5L?=
 =?utf-8?B?a1lnbUE5M1BobjMrNjhSdUpCTk5MNXdrbzhhMkQ4bGxVcTVMbkUzMVVyTkZp?=
 =?utf-8?B?TWd5M1Ewdkc3S0YvV01rbFNwZ2FIMm9hVElnemt5TVgrbW52Q0VLQWY4cHNK?=
 =?utf-8?B?cGlKTVVPQWYya2ExakdMcS9RYjJjVnhWclVtSE94ajFDNUlFQ3hZdmlLOTA4?=
 =?utf-8?B?NllLMnpNTEZaNHFHYTR3b0djNVFiNEEzNlk3SDlFajU1bjZiWUZGRnJlSGg0?=
 =?utf-8?B?azV0b2dQeUtUa1JDWHNhdk5YOVdPdUxxV2kwUVVoRjAyaG5qZk81SE9SeE5V?=
 =?utf-8?B?WXpSdW02TkprdCtDNjYxWjFpNTBvaTc3QmU1eUJmMTBLdWZNWGNTNXpJMlRl?=
 =?utf-8?B?ald4bG14djZPVGxsVk9VQm1YekprZGcrMGo2M2FGQS9pV2g1V2hwRSsybGZK?=
 =?utf-8?B?L0Q3Sk1DdGg5RW1OTUd6ZlptT3M2cldYMDQzUjF5ZEE4Vmlrc0FhYkhoTVI2?=
 =?utf-8?B?VjBUUkUvK1A1WUpJYi9GTDVvZ1pFUVE0cVNuNHZ4c2xlcU0wTGRPUzI4bFFo?=
 =?utf-8?B?aFB6SzhDS016OUE2RnhreWprOEs1UE1vbTdFMzJ4dXJSN0NiSHBoSGF5OHR4?=
 =?utf-8?B?ZmhaeTFjUjd5UVBhakhoWFBYdFVSQ0RUaWFUOVAxcWMvTDdMWnpQTEgyVC81?=
 =?utf-8?B?Kyt5d1ZTZzN1Q0ltUDRqbWJZbXpHVFBHTk8rSVFFNjY3SmRrcTdFU3lFWEtn?=
 =?utf-8?B?a1lic0lGUGhjZGgzeURDSStXeGp1bXVjQ0RhazVaSncyWFQrNitjU0Nhc0xF?=
 =?utf-8?B?SmVUOHkxV0I5VC95dVpoL1VFMkNkZ0o5Ni9IbmZUQkQ3VFlrS25JeG1TUXA2?=
 =?utf-8?B?Y0EwVURSc1hoeWhwaUZ2b3grbTdRTHUvVld4UEMrcFVKRFJ2QjhxRlVVYkRs?=
 =?utf-8?B?c0FuNEtYVkRQYVlCQjNXdGhLbWYvUmxycFVoVlRKSkZSYXN3UGk4SlJnYzZI?=
 =?utf-8?B?dXpUUjNFeWI2U3I2OGR4Ky9Bc3hZTDF1ODdXN2ZYcCt1eDQzd0laM3hxVVRO?=
 =?utf-8?B?V3dMNnRaODkxV1lTb2R2em9hMVdjK29pb1ZIcStXNmxJTHRXa2I2ZWd5Q0U3?=
 =?utf-8?B?M1MzVEQ4QVNJUmtzUGR6L0lzTzRTd1dKcFBvWE9JWjB2UU1WQjhQbkgrZnBs?=
 =?utf-8?B?S3paS0h2b0pyYXFLU3lVZFp0RnVVSXJMUEtzYXJPSWVERlhodnJlclgwdVU3?=
 =?utf-8?B?dWVHSjMwZG90QW9ScnhCeVR3Q1pvMWZxRlovZDJpTUw5Y2d3eWVTS3EzbkNW?=
 =?utf-8?B?d1JOTDIrTGpFRE5GeCtuNDVXdnhVbkJuOE9xb0FnZlUwVENpY1NxSi9PZllD?=
 =?utf-8?B?MUlUcmQwMUJZNUxLM2ZmdmxHS0lScU5yc3paempZSzBEYjVRMWNFd1ZCQjlz?=
 =?utf-8?B?STlQL05XY3N3d0V1c0p5Nm0wMnZMVVpBSW1GSVRaRnlVM2VWaVdreGFjVk82?=
 =?utf-8?B?dUhpUzRkd2x1REtydGJHTVVhN0IvSDBSeGJXb0ZPWkpJaFBhY1pjbUFZOUE2?=
 =?utf-8?B?OWNLbGYrRmg2TzVHM0V0VGkwWjZGUUhKQytnTVRzUnFWaTNFbms2aGJQQ3lr?=
 =?utf-8?B?bENLZk9PbnB4RGYxUjhxeWFLYjdFaTgrMXFUc2VzYjdJM2dSR2svdEZ3UGtB?=
 =?utf-8?B?enZPZzhqd3RWczEvS1RlaHUzZ2dJRmNFRlh1RHYrM1hEM2ovT1Q1aXBiNmV5?=
 =?utf-8?Q?TDDN/n9wMOGGPGfo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64B1F7FE953E544A9EA579DD3C7966F7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WuXX17n1bjYCJRkKVuqmvsgQ7uaxPIck+0Q2OOU7SGGNnJtOaH9N8sLISzOTIMLBRJ5ldxrz5zE7HK5Uk6G4xY8dyNrvZWVH7Y1qYYHnNyqmsAm9ub+GhZt+4yIh2bXUPq25vaVBAiRoNiEwQO/8gEjx9FJqPvQNG4bSHB26PPMlKZYbX+yCrOo2o5xjI0iXdu6fsLw6shHLL4FOLV4yfdTNQR9Cij1QYUa0j/7ny6PCc+kpsUsaQnRNXVl73fw6fth6aOPKdmNrxKgb4Ho2YVg8iB/QDac1tAS/23iai/Jr0pAAUrkaHkvGzSHy53dPoHEAesNPUiJjNIvITN38RpRP8R6cWUjcv9OnEadcE8qyQCYuBI9e6r56KOQNeLZlCJSnfu/sdMhgOll7fVNx68MfX71aR/Alvk/8l4hm6wno1fLWzgiyZpOd3hcMH/kEdUYekqo3//fm6HcIBm6TGDQKwYKVW+nxKyoMxEjdl7wivtlerlpgGaz9e9auBSrxtttQ2uzWz8CMFRuFjtX5r9k08iZU/9fM5Wel94S9WYw9WMPNiTL4/EqHR4nSFJ/hmJO8uNQf8T/TGuA2QLWI9IH+2CH91OMP7OUvYbtpoqxp/ODSJB7dQyaqdRnrIAdv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB8303.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 093c1350-ede0-4598-091b-08de4e41bffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 23:09:03.3978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v0w1+IFyXl7Cc47JzFlAg/FgSPzX8FoHm2uNh3MR6LKtTFAeM0wTFwOouN7tXrMX3rQOypa3SXpr6sWY54RM4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6919
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260107_150910_079213_A5A0689A 
X-CRM114-Status: GOOD (  16.15  )
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

T24gV2VkLCAyMDI2LTAxLTA3IGF0IDE0OjE1ICswMTAwLCBoY2ggd3JvdGU6DQo+IE9uIFdlZCwg
SmFuIDA3LCAyMDI2IGF0IDEwOjMzOjM3QU0gKzAwMDAsIFdpbGZyZWQgTWFsbGF3YSB3cm90ZToN
Cj4gPiA+IEkgZG9uJ3Qgc2VlIGEgdHlwbyBoZXJlLCBqdXN0IGEgcmVmb3JtYXR0aW5nIHRvIGEg
ZGlmZmVyZW50DQo+ID4gPiBjb21tZW50DQo+ID4gPiBzdHlsZSBub3QgdmVyeSBjb21tb25seSB1
c2VkIGluIHRoZSBudm1lIGNvZGUuDQo+ID4gDQo+ID4gSXQncyBqdXN0IHRoZSBleHRyYSB3aGl0
ZSBzcGFjZSBiZWZvcmUgdGhlICJUaGlzIGF2b2lkcyIuIElzIHRoYXQNCj4gPiBub3QgYQ0KPiA+
IHR5cG8/DQo+IA0KPiBEb3VibGUgc3BhY2VzIGFmdGVyIHRoZSBlbmQgb2YgYSBzZW50ZW5jZSBp
cyBjb21tb24gc3R5bGUgZm9yIGZpeGVkDQo+IHdpZHRoIGZvbnQgdGV4dCBhbmQgcmVjb21tZW5k
ZWQgYnkgdmFyaW91cyAodXN1YWxseSBvbGRlcikgY29kaW5nDQo+IGd1aWRlbGluZXMuwqAgQnV0
IGV2ZW4gdHlwZXNldHRpbmcgZm9yIHZhcmlhYmxlLXNpZGVkIGZvbnRzIHNvbWV0aW1lcw0KPiBh
ZGQgZXh0cmEgc3BhY2UsIGluIFRlWCB0aGlzIGlzIGtub3duIGFzICJmcmVuY2ggc3BhY2luZyIN
Cj4gDQoNCkFoIEkgc2VlLCB0aGFua3MgZm9yIGxldHRpbmcgbWUga25vdyENCg0KV2lsZnJlZA0K

