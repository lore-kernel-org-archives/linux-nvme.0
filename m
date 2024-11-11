Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B950CD2E9C9
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 09:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aCW5v3P32/jsn24Nz0drAbxGpQVylUQRc9pw47cKgD0=; b=OnST/94qPJ+H+Wuk9ov14camcD
	tW7avKSRg/w0ADsNGISB/v/qb8qlNFK7VVUUfUlbNJXsIgv+qJ6U5doKAuHlS2JsNO0sMuD420dPB
	1blXzt9YgmjRd/70ZnN1KcQN8Y3RfOfYBlWktm5C95I/Hi20d/Liqzah/LVuuxeT0orTSYGRMPalU
	7dItba0cNG+PHyeBOT4ri96JdvzHE3gRTH1hmxP9StT3MkQ1WS/Dfu1j74KMsC1i/zz3NsXskaMGB
	MQWlX6SsBhe5jMYni9pvxkFj6PunbQ51OSJ6DFqKoDiUWhUDPu1YuYF0CfsnaA+s0LNOIxg1G652F
	pQbP5Mxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAQrS-0000000H7sP-3WUa;
	Mon, 11 Nov 2024 09:37:30 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAQrP-0000000H7qz-1hbo
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 09:37:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731317847; x=1762853847;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aCW5v3P32/jsn24Nz0drAbxGpQVylUQRc9pw47cKgD0=;
  b=nLznJbWQVGPuGoAN2zmEiKxhdK/52ADi6rXlnpoyQbJWiFTDuBr167jQ
   A2f3dKCcyl4qRRTkp9Obzzj2SUvJeHvRNj8l3SffH4lroVvvolCdU468/
   mO6FWNzFxfYvOBlYa+P45KlTAFldm6mDu8n5SjWXSlYhSmCbsTfDxGxmj
   e3BXKFTR5sX+QxguEM+jczD10v8q1UKdgAODKQY/rSBChhiNnqzOpmStI
   xu6L0tMeX5X1nCgyG06R3uRnwmS3eDAo6y/bOCY1zsTDMxDUdbq4G7ycz
   h3rIfNLTLjEpWj91HCALFaBGR2zhUJEi2pSFolZJk3BakfqPgOS9HmtjE
   Q==;
X-CSE-ConnectionGUID: R/uqSFuARmK4ysera4Zs/A==
X-CSE-MsgGUID: VgtAtRHCSAa9SBxN7uruPw==
X-IronPort-AV: E=Sophos;i="6.12,144,1728921600"; 
   d="scan'208";a="32158202"
Received: from mail-westcentralusazlp17013077.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.6.77])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2024 17:37:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUm3apg1BE2akkRPJ5LnGpKju0Y5DcU3U9wwJza0pZaKhoHD/Vk+YEPPjdwaX1HIANgjVNZ8hfH4kzl4j7hxw2yDVAQ4I3rA7Xos+ia3HfItNnKOx1CmyPgwr3ZOhUWpKTIFf8CkGCJvVrW9xro3iydXZPPsCL4/c7PnITxmxL4RT7VD6dvgrX/94uhYsMtsyTaUMC2vUN6UYanLK/OjXsAVVHdyZ6e/wkBbUK2ckxEKD/iEbdRaaLXv9BfqKUqev58ugnO2y/CabvgTosN3aK60MR+o1Sgkh3vstR4phiJg2w1mo5afXCgfVu8/ZwrZjtTijReGWuHWk9KyFBrf7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCW5v3P32/jsn24Nz0drAbxGpQVylUQRc9pw47cKgD0=;
 b=v+jDJmaVna972+TxdMshfMlS9yDlN94QoHdhicvypdYM6aDJj6YyCBqKDWFpZAjwvIV/Xqf3tHRv8G5uVEg4FNsz7PExqzdgx9xgd9PnjADb/4DvCvqJTTMaIIJhp16zgY97azPkw+J1hEfDmTpNEL2UbUxIDN3T67M+9duohoRnbYa0OY5lFJ23tRQUHNmgOJsCbaqq3XQjVKBeBm4gupjCODyy/mjL0V1gk4N5sk0pgsyteC4k/JfqKCtIH/uFRZ/lRlRXXVzdp9R2xpOlB+g+kvY84bzkLh+1ZnTatt7z5MZl85iNrtrnKrjRVyF1KOSRT/D1RCr6wkQibiGxlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCW5v3P32/jsn24Nz0drAbxGpQVylUQRc9pw47cKgD0=;
 b=GLskJQ7vbnYLvfGZOL9Ky+Z29fi+TLJhuIqIfIF1kC57m7BsGa8WqCQdNZ4Eo2cgmSNh9N70uxalN3m/hmZKD13moloAkX8EY+ZU8RIl8vilmwCv0k8O64w18hzYtuMTltKZuM7TtamrzYALxkOxyER2SRYyYrozfkf94/T13XA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6740.namprd04.prod.outlook.com (2603:10b6:a03:21a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Mon, 11 Nov
 2024 09:37:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 09:37:23 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Javier Gonzalez <javier.gonz@samsung.com>, hch <hch@lst.de>
CC: Matthew Wilcox <willy@infradead.org>, Keith Busch <kbusch@kernel.org>,
	Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "io-uring@vger.kernel.org"
	<io-uring@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "joshi.k@samsung.com" <joshi.k@samsung.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
Thread-Topic: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
Thread-Index: AQHbKhYzHqfk+FHNy0OApJay8pJjFbKo4KEAgAN0q4CAASjNAIAAGeOAgAARnQCAAA29AIAEANkAgAAsYACAAAHdAA==
Date: Mon, 11 Nov 2024 09:37:22 +0000
Message-ID: <81a00117-f2bd-401c-b71e-1c35a4459f9a@wdc.com>
References: <20241029151922.459139-1-kbusch@meta.com>
 <20241105155014.GA7310@lst.de> <Zy0k06wK0ymPm4BV@kbusch-mbp>
 <20241108141852.GA6578@lst.de> <Zy4zgwYKB1f6McTH@kbusch-mbp>
 <CGME20241108165444eucas1p183f631e2710142fbbc7dee9300baf77a@eucas1p1.samsung.com>
 <Zy5CSgNJtgUgBH3H@casper.infradead.org>
 <d7b7a759dd9a45a7845e95e693ec29d7@CAMSVWEXC02.scsc.local>
 <20241111065148.GC24107@lst.de>
 <20241111093038.zk4e7nhpd7ifl7ap@ArmHalley.local>
In-Reply-To: <20241111093038.zk4e7nhpd7ifl7ap@ArmHalley.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB6740:EE_
x-ms-office365-filtering-correlation-id: bbf5c12d-2e4b-4ab1-7e58-08dd023471e6
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MW1vaVl5K1RTNnRPNUdiUVdUQlVtZXNrZ1dxQ2x1cENZUUxUUDB0bnkxZWZm?=
 =?utf-8?B?Y01qY3lhVUNLTFk4U3lLZHVqRk40TG53aFN3aWNnT29wSnVBeVZQY2N6WGNT?=
 =?utf-8?B?K3A2amlPWHYrbjRFVVNSVHZaVGNwZEdNOWpQQkovUHh5ZTQyWjcrb0xrUmd0?=
 =?utf-8?B?ZnZzeWg5c2tGeEpVTEVSVWM3Nnd6a1JCR3g4ZFpyeXFWRlczV1Y2Q0dsUlRR?=
 =?utf-8?B?dk94Wm1tYS8vZXVkTXJKVG1LZ01PcEREYlVzUzM1TVRmQWtpOSsyWkZPb3I1?=
 =?utf-8?B?R0lZYWl1T2JkanBValNUVlRxVlIyWm5ZMXhwb0xPdnBXcVh1ZnZTS2FWR09K?=
 =?utf-8?B?cytGQ1poWkp6cmY3dnJGV1NQdVh2VWp6eXpDUUFCNThTSDJxbGFrUVJ0a3dG?=
 =?utf-8?B?TnBxYjFKYjBuWk9CYjZCRnVSZHNGbzJRL1p4NDlyczVva3JOa2VOQ1JkSFJi?=
 =?utf-8?B?eFgxZ2h0UU5XdkhwV0JyMnRYc1FHRVRuS0RYNm1VV3h2S014Ynd1cFBHak5K?=
 =?utf-8?B?bDIxai85R1I3L2NieHUwc2psYTVNNTdsVmVjd01SU3JDcjV3VjFkWXNianE1?=
 =?utf-8?B?d0h5ZDZqSzNuZWRkaHo1RGJSdmpaYWt4ZGZmZ0RwZ01iNHBBZEhOVHg4czBl?=
 =?utf-8?B?NTRwRHFQSkc5cU1RVFIvN3Azd1lpVC8rcGNFdXV1L0N2S2FUZ3RJUHEzcjRs?=
 =?utf-8?B?UHZ0dmQvSU1CN252eHZ2YWs3a2VBUWY0clF6R3A1S0EvbUZ4UXB6V3BEWG9G?=
 =?utf-8?B?eTI4eTAyL1lFVEFyeCswYU5hV2I3LzJwSHlDTi9GZ0xZZVpiS0p2MXlmUitP?=
 =?utf-8?B?TnNaU2orTXhlcThOSXV5S2I3NGIraHdTVlJ1OG5Jd0VrQUtPY3hTQXVJT1lL?=
 =?utf-8?B?Y25tTUhKcEZTNzkrRDVPTjNXUnNHZ21DZUc4YTh0Y3h0Y3RXSzBIQldGU1hP?=
 =?utf-8?B?ODdoQXpzRkpqV2VnRUptUGU4Q1V6MThpa1dmNDFlZUYwR2xPbE03UzA1aHZz?=
 =?utf-8?B?WDNQYUtJb2lVNVV5N25CYjNLQy9ZU0N3L2dxRXRITEVtVFNZN054ZmRmWVNk?=
 =?utf-8?B?VnJwd0lQUGgyUTAwVDJNaWlWTjZXTVd5dWdyTHlkOGo5MWRNRXprTURtQW5H?=
 =?utf-8?B?a2FFT1R1VzVLWHdQQkxvSjVzUDVSNzFaNGxSd1Vzand4c0JES05xbElVNlRl?=
 =?utf-8?B?TFJHTUFzSUx0MVV0Z1hBREZKeTZ4NWk3RHRGR2J0QUJ2SzNwc2pQVkdYaC9C?=
 =?utf-8?B?MmoxRk5XU3h5QTZCQ0I2L1owTnNZNVFzT3JDOGpUMmw1a0FkTGQ3OWJwMnZD?=
 =?utf-8?B?RGpRT251MVc4VW5aNkgyeFNoWk9KQ2VZRkY4QmRXb1VRYi9XL250MUhWaENX?=
 =?utf-8?B?dFM2ZGpZVFVDWDl2K3lMRXBIUGp0ZXc3YjJXUnJIV0Mxd3FRWVRkbkl1eUdx?=
 =?utf-8?B?OGpxbGovOS9zWUdFR1p2WDVQbE5Bcnp1a2ZZN3pNT1MrdjF2NmdJVGpPWXhX?=
 =?utf-8?B?alRpNm54ZktUNkU1YmdzT0hJZ2ZDSzlnOTJDbnh1cDVRdGIwUWtjcmFIazhY?=
 =?utf-8?B?WjB4Tlg1QjdHRnVYeDc1bTRKcUJCNDAxZ3BvVDFWZDNqNktpTmkvcW1xM2pL?=
 =?utf-8?B?QmkyWk9MTitOK0JnZVFmdGNXUGZEaGdPMy9mTStZUmlwNDY5aXVHUTJuekw4?=
 =?utf-8?B?MkFnOXpoMmNFSUhLUXhvTWhEYmsyQVpXa1pMSEJkbDRONHVnTmdBTTJMcHI1?=
 =?utf-8?B?ei9pUmVETENFMFlFRi9abDYvTE14dDBZYnV3aVVHc0ZGY0hpZHJJV1hvYUxT?=
 =?utf-8?Q?aN2dOvSjNI8lp8LL99bv8WDrtGV6JMQ4c3+7Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anpPa3lNQUxNeHZCSHBkUllBU0pnczdzZW53TTczOFl0NEJ1NHIxUG1RYThh?=
 =?utf-8?B?bDRkR0tWRVJIL0ZIeXJ1b0lXdHlTSmVYVURmeDRoZHlvcjB4VWFwOFBhZjFl?=
 =?utf-8?B?YVExOFB4dnpHNlNiUmRoYUtSWE5Jemh4MVpLc1J4TXBzNXV4L3FZcXF5emR2?=
 =?utf-8?B?Y2Y2d3p4K05aNHh6K2FEcXk1L1dZWFk0dXhEa0pUdW5BelJ1NmFGb0dhdTRQ?=
 =?utf-8?B?SEdveGVjWW5uMWFhcmRiL25FQytlWkR6UHpCT0U5N3RvSGR4WklvQzFoZGhZ?=
 =?utf-8?B?RSszR2FUL1lRNjFiVHFuaFpsSk4xTEk3VnlyTjBPNU1XbTN4T0tPaUtSTU1w?=
 =?utf-8?B?OEdaY0k0VVdhZUFDYTVEVHNvNnB2eE9HR3ZYcXZOQWFwTFRaNEcwV2xhQk5l?=
 =?utf-8?B?QWZaOUcrQmhhbUpVMzdkYklwSUVQcE1USmxaT0J1YUg2dncwVGtGZDFxNjEr?=
 =?utf-8?B?dTBZL1g0L1NyN2ZOS2ZJdENhTDJURHFnUjg5aXdreVBjTHplMWRpc3N5eGYr?=
 =?utf-8?B?MGYrR3FHOFhkNk5LdWgwU3lScUo4Nk9vZGRCYzNkREp3UXFlOVhVRUo0OG9t?=
 =?utf-8?B?Znc3MDV4RjFaenRoNWovRTZ6Rzk1ZFVCQ1lYWDZzZmU1VDliRml4RHlOeGFo?=
 =?utf-8?B?NVE5d1Y0dUZHWHRrUFJKZllTQ2VLRlI5RzFPeWtjblVHV3dQeGFqaGE4amps?=
 =?utf-8?B?eVhMY1huUjM4cjdoZHZySEN4aGtaWEl2dSszc3ZjQ0ZoMGhPVkF1V3BmZzY4?=
 =?utf-8?B?ank1OEVGYTRxRkdhSzJGWm16WE5IRFFFaTdjVjN3SlY4dWFRTW1rV3pOYnNZ?=
 =?utf-8?B?M0RJaCszblBvNWgvL1dLdW1na21NOW9PSnJrMDh5WCtYM1l5cE5QZVJNd2cx?=
 =?utf-8?B?MVVKZEZUV1UvSDRKL2pqc3Q0dVltazlVaHF4NlVYK2k1eW95djJMVkl2Z2J3?=
 =?utf-8?B?MnowcUZsUU02amUwNjJ3VGVObjJFMWFoYlFSRmIrb1RoTzM1djB5dnkvc2M0?=
 =?utf-8?B?bGVjanc0UmwwWFloWVNoNnViSGFRS1BWbXdkdkxibUNOTnJnNHBUY3hETmhQ?=
 =?utf-8?B?K0Z1dWx4WW5oNDh4Y3FYbVRWbFBVVGUyb0UycUo0Yzdva0RhbFVrNDVRRkJ3?=
 =?utf-8?B?bnNtQWZYL2pWUTJiNE1YUjE5S09WeTBMcTdCdkd4QzAxR0c0QmFXSFZ2TkxM?=
 =?utf-8?B?YXN5c3JVK2RvNEVWNG9nYVhhbFNXMVc1R3NFWEJtVkM4NHZsdmVaRDhsNVN0?=
 =?utf-8?B?OS9FeDhzVFVabCtIVnljdmZjamFra1FQN2FzZnVIUzlONEUySVhBWjR4QlVs?=
 =?utf-8?B?dFcrZHM4bnBoZTFyYjlwUEtSSTlpWjMxWlZvL1FjbGxKOCtKbXZSM2pqME9w?=
 =?utf-8?B?ZFR5blNyWERMT1dSck1LY1V5bTdEUk15eFQwN0cvRzRBaldROWFDY0hOQjFn?=
 =?utf-8?B?ZmQyR0I4QjFQSFA5U2NjN3g1NlpwZlhSMFg4clV5NzVnV055V2krb29pRkRh?=
 =?utf-8?B?d1hFdWpjRVFGVVVkMTQ5Y2ZCSktmdWpYdlc5RjljbFk4VFlNc3NQZnRFcnF6?=
 =?utf-8?B?YUM5NUZHZi8xWm1ZcXNqRlhnUU9SNzhXQjcyR2g1cmkvUjlJQ1RRWGVuYzRV?=
 =?utf-8?B?R2gxb0VDdit2MWVBejVKTW5CeGo1cVY1Y3d2OWw5ankrTDQ1M0YxZVJVVW1B?=
 =?utf-8?B?d3poZERvWWpZaUgxb2Z3YWdoZ08xWjc0Sk9LYld4Z2RFM1AvbVBud2lwRWZK?=
 =?utf-8?B?RkxLL0tCYSt2OU80eS9BcnVFeCtBVDU0STlzWUhxa3hOUml3UFVsRWozd21y?=
 =?utf-8?B?VVdSMzVXTXk4WFdNclpQTDlScGJXNk9kWUM0TWc1c0Q5UEZJaHdZSXFQdXJB?=
 =?utf-8?B?Rms5aUxUbisvYlpNczd1YkR1cTJ2OEJ0TmtINUkvS1QrRUlyOWZtZzJCVUNL?=
 =?utf-8?B?TDdaSE51QmVyVXpOd0doNm1raklXUnZiYktuaXBXSHVqT3lRNEtqYVdOTi90?=
 =?utf-8?B?dFJLR2toVnFFK25rQU5zdG16VWthNVR3ZlIyN2JOQ0l0aXRERGg1NW1Pdm5Q?=
 =?utf-8?B?YXpPbWNOMWc2VWpKNTBicjVZK1hmNGhMc3lleGgxRnJkcUxhTk8yYlpvdnVh?=
 =?utf-8?B?eE9YeEordTBGa0xkSFJOcHdhSlFqcXFQR1ppWjBwMHZQa0lzUDIyZXJlN0hr?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2724B370E166EF4985F1453EAB4FE0C3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zfQruwI68cYsIEZdDdLuKNLmf1tK26TL64V4V5DWhDQ0ueeSfZGKbGOeiA9tw1Q3WCXSyKc3b5jHIo2PKzJkEp4ObPXq99vFbLkme4VeQnQakU9A5ragOtP0eC+M41OqWh55G1T93CN/XUvWLyi4IzZ58Pf4P8x+BdTuMAxi7LAoO1VvuDpFvC6W6ZIBtlXoLWxWRXdi0z4ea4f19V7P1YiTBjr4CIVQxZhd1VecLooYcqzCfZV+N127OZJKT4nOyoYwDPRM7Ug1OTAG4HIlx0S0e6reEjHgAmvDlI65l+0/NoxDOjg8NVf6RLGAemFPWuFo0xlTP1Ld2cmP2/gjuQc49+PG+Cr2GAspIzQCoEze9MtZhjb2hIp7goSGi3mcsENM+5Ao61y0rLGzQ4R8kLrQ0ZsKAlfpVGcmHLxAs+Hq90VklBw8vNBZI7nC/2IhVhHgCq7Le2SjmHiI+kMABOpmT9TY4sjss3Y7B0VSXc7MZTPLWdVc5yAGQ3FeV0cGNmzLk4FD14gZ4gfcBIgqNRjBiW8SknlAPD0PtMxs5NVTl9k7GO5DS9LtwV4z7vuZw0hBzbJwQPJ6diYtlDVOZNZJRBTi0tl4h7KUw3zyoMK0E8toDil2GF3erme0NBTZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf5c12d-2e4b-4ab1-7e58-08dd023471e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 09:37:22.8570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y4mukxIlQYa/KFLVD52lkjoId5VQpkgLH/DDXNPur1GdJ6tQY+O5x4iLkBNpQEGj8INOvaR8myFsgHc4B3StJkR4U+sYPQGin8Nb43vqad0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6740
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_013727_499088_67DF2D8D 
X-CRM114-Status: GOOD (  21.55  )
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

T24gMTEuMTEuMjQgMTA6MzEsIEphdmllciBHb256YWxleiB3cm90ZToNCj4gT24gMTEuMTEuMjAy
NCAwNzo1MSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+PiBPbiBGcmksIE5vdiAwOCwgMjAy
NCBhdCAwNTo0Mzo0NFBNICswMDAwLCBKYXZpZXIgR29uemFsZXogd3JvdGU6DQo+Pj4gV2UgaGF2
ZSBiZWVuIGl0ZXJhdGluZyBpbiB0aGUgcGF0Y2hlcyBmb3IgeWVhcnMsIGJ1dCBpdCBpcyB1bmZv
cnR1bmF0ZWx5DQo+Pj4gb25lIG9mIHRoZXNlIHNlcmllcyB0aGF0IGdvIGluIGNpcmNsZXMgZm9y
ZXZlci4gSSBkb24ndCB0aGluayBpdCBpcyBkdWUNCj4+PiB0byBhbnkgc3BlY2lmaWMgcHJvYmxl
bSwgYnV0IG1vc3RseSBkdWUgdG8gdW5hbGlnbmVkIHJlcXVlc3RzIGZvcm0NCj4+PiBkaWZmZXJl
bnQgZm9sa3MgcmV2aWV3aW5nLiBMYXN0IHRpbWUgSSB0YWxrZWQgdG8gRGFtaWVuIGhlIGFza2Vk
IG1lIHRvDQo+Pj4gc2VuZCB0aGUgcGF0Y2hlcyBhZ2Fpbjsgd2UgaGF2ZSBub3QgZm9sbG93ZWQg
dGhyb3VnaCBkdWUgdG8gYmFuZHdpZHRoLg0KPj4NCj4+IEEgYmlnIHByb2JsZW0gaXMgdGhhdCBp
dCBhY3R1YWxseSBsYWNrcyBhIGtpbGxlciB1c2UgY2FzZS4gIElmIHlvdSdkDQo+PiBhY3R1YWxs
eSBtYW5hZ2UgdG8gcGx1ZyBpdCBpbnRvIGFuIGluLWtlcm5lbCB1c2VyIGFuZCBzaG93IGEgcmVh
bA0KPj4gc3BlZWR1cCBwZW9wbGUgbWlnaHQgYWN0dWFsbHkgYmUgaW50ZXJlc3RlZCBpbiBpdCBh
bmQgaGVscCBvcHRpbWl6aW5nDQo+PiBmb3IgaXQuDQo+Pg0KPiANCj4gQWdyZWUuIEluaXRpYWxs
eSBpdCB3YXMgYWxsIGFib3V0IFpOUy4gU2VlbXMgWlVGUyBjYW4gdXNlIGl0Lg0KPiANCj4gVGhl
biB3ZSBzYXcgZ29vZCByZXN1bHRzIGluIG9mZmxvYWQgdG8gdGFyZ2V0IG9uIE5WTWUtT0YsIHNp
bWlsYXIgdG8NCj4gY29weV9maWxlX3JhbmdlLCBidXQgdGhhdCBkb2VzIG5vdCBzZWVtIHRvIGJl
IGVub3VnaC4gWW91IHNlZW0gdG8NCj4gaW5kaWNhY3RlIHRvbyB0aGF0IFhGUyBjYW4gdXNlIGl0
IGZvciBHQy4NCj4gDQo+IFdlIGNhbiB0cnkgcHV0dGluZyBhIG5ldyBzZXJpZXMgb3V0IHRvIHNl
ZSB3aGVyZSB3ZSBhcmUuLi4NCg0KSSBkb24ndCB3YW50IHRvIHNvdW5kIGxpa2UgYSBicm9rZW4g
cmVjb3JkLCBidXQgSSd2ZSBzYWlkIG1vcmUgdGhhbiANCm9uY2UsIHRoYXQgYnRyZnMgKHJlZ2Fy
ZGxlc3Mgb2Ygem9uZWQgb3Igbm9uLXpvbmVkKSB3b3VsZCBiZSB2ZXJ5IA0KaW50ZXJlc3RlZCBp
biB0aGF0IGFzIHdlbGwgYW5kIEknZCBiZSB3aWxsaW5nIHRvIGhlbHAgd2l0aCB0aGUgY29kZSBv
ciANCmV2ZW4gZG8gaXQgbXlzZWxmIG9uY2UgdGhlIGJsb2NrIGJpdHMgYXJlIGluLg0KDQpCdXQg
YXBwYXJlbnRseSBteSB2b2ljZSBkb2Vzbid0IGNvdW50IGhlcmUNCg==

