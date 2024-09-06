Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94396CE7AA6
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 03:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p7OiFhf5viv8I4e9JYtu1x7nO/WI3SI6YXFuBiXkh38=; b=EMoR6V+grAUPAti1C6p1WniJj0
	qxbjbN4nQWL+uNxKqMEJzBgrFz0+AKtJh/JAcx70mjZ2SZIP7xvXLWy1ZnIdh/AYOx9kJD9hLd2sU
	iv+3lowK1DCM+jI21GBis1JGSvsEtDCRk6gsoMxqCoVtwxikBZQhqGWOYTGAHBGuBci6RYiQBBgCc
	9cwskq9RZh2ZNnOB5rPFqlvITtNKC2mY+PYRz5zKyZZTyFKsIz6GXei1UfVt5h3Z/Oh5+CrBRA91X
	xd5h4Q9t2vOsJE35A+MtVnXqSlkVzy244whnAcjzoCW3nLRl6PcBKrkgYaqALN5PHTR6BpgUno07o
	29D7SOAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smPP1-0000000AUfB-18MX;
	Fri, 06 Sep 2024 03:12:51 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smPOy-0000000AUed-3p34
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 03:12:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725592368; x=1757128368;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=p7OiFhf5viv8I4e9JYtu1x7nO/WI3SI6YXFuBiXkh38=;
  b=bBaTWqznm5IEDOFlGaumAdEmXOK5efPt64F17O7hz98ArBj6UXvim5sx
   uQjPzZ24uIylsazJSgZLq4cyHkJAJR2aLiSu33G4wRiZpM+lB0j90oZOg
   Ic5r8qhG6cchKXWIdCJJOpFTI0uUSi1ZtE78J1BgZHjOnn3Ziu9cVrDm4
   2h+cFhBVMVla+4YcwYzIhHRw7Cmxn5LGoB45tO+clwsOxioJeaIk+cLdt
   yzPj+6i8U1hnnAf2EOKGEwSchwZRXt88k7LWpkD4PeKwSKDJ+7RqpxX1t
   xW3iVFnJPCWltI4n/jcY6hm5V1ndf7YQfpKBAwBOhzRIiWxImMAmSFjJ5
   A==;
X-CSE-ConnectionGUID: FjmKww5mR3mr8rzpWUJS6A==
X-CSE-MsgGUID: dmx/9QxhQVCfeYBq+bwDIQ==
X-IronPort-AV: E=Sophos;i="6.10,206,1719849600"; 
   d="scan'208";a="26868669"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2024 11:12:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pebFPkts/1IrcESjqe4GjgRhAtjvYCoW/H99Iewq5EIWx7HFKTFDvAzS0QXucB1IXVuld2xMXdfw5Tse20KrSNj3ou/IXLalnUShtE6J4ycQyyNuk6ZpCic+oyNGH4quDx6Ygs+iJOEpVlKlfik90+i3qeIbptJRwbIiSQ39h4FCt8pXjOVhaSM8WEpqYW9+9hqT/pPkHrq2OPMKXUGchKeXQ7JmvjnN23EoovPJ0G7GqtaVqS84i8Ut7yqBvzJpeIlhaJKlKLicy3S17vuDnvkrircqSoCxHyEoXoaqJYRtB9bodNnaHiai46z0IjDGFi3OTUW5s+VvCeWnTt6P0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7OiFhf5viv8I4e9JYtu1x7nO/WI3SI6YXFuBiXkh38=;
 b=AFBZ+66sUv0e5dban3P7SBWUUCifEbqrbtVQmklGWqKyzO1CuAcPYUeQXn9aMlknmfMTOMLs3J8/WUFB/g9F7ShNVO04pXK21B8zhOIfLumvtjUkjTSUxpmR1xR7cdFJhlFYMQ0cyUWbIoD3Z9IE66U6FVW9az+6rDWOuJpQ6yull3QvkVUCYmfWus1cYcgAqlSQQxM0SCchVVuQohELOzAJqtRQkK7X1yVk3fpvGd2RrkIjGuyIJ0mdNWH0pG21mJ2k14Xl9mVsknnlaYJ38SS9TQYN+Q35QlwzB0H3bn6hEeghjUK7tp1OrY90HHIZWi8fgQ969VXtuGx7ZTL6fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7OiFhf5viv8I4e9JYtu1x7nO/WI3SI6YXFuBiXkh38=;
 b=KgTdOnRydgiVJ/pA2ZllzxWnMfVd/duK0tC3eAbEtV2KRF5PpDzbC7TmrMhle7CWOUnniSWy/t7jY6X+8DYSh/FXWJpU5BBSQJ7QpdvnDCnurE86F+AG3lDPcACycpmmQtcRwN2v+K2LHVN3VJfcizCSeVVMCAd0+dCcRGe4h84=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DS1PR04MB9558.namprd04.prod.outlook.com (2603:10b6:8:21e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Fri, 6 Sep 2024 03:12:39 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 03:12:39 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Martin Wilck <martin.wilck@suse.com>
CC: Nilay Shroff <nilay@linux.ibm.com>, Chaitanya Kulkarni
	<Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>, Daniel Wagner
	<dwagner@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH v4 1/3] blktests: nvme/{033-037,039}: skip passthru tests
 on multipath devices
Thread-Topic: [PATCH v4 1/3] blktests: nvme/{033-037,039}: skip passthru tests
 on multipath devices
Thread-Index: AQHa/h6DBk3k5R7yNk+mFTOvfHGIk7JKGQEA
Date: Fri, 6 Sep 2024 03:12:38 +0000
Message-ID: <uphcypfsyzq3qe4bipl2bgi5b5aqwxi47koxu3y4bsc3g2vper@2q5znariabty>
References: <20240903162930.165018-1-mwilck@suse.com>
In-Reply-To: <20240903162930.165018-1-mwilck@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DS1PR04MB9558:EE_
x-ms-office365-filtering-correlation-id: 3916f550-c591-4a47-3006-08dcce21c38a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?YrcwxyUi/+TjRJtvsOlFzvTwyxXi+YyLyE7xMLox7kXGK8SFS/tV9dbq/mrw?=
 =?us-ascii?Q?9FgpfbczzH8UyXdtIk0dDCSawnl6PFp1l5lJvxAVkrUdoamHSfyfMQXpQxfq?=
 =?us-ascii?Q?C7tm0tfXtpQOQZuV0n0tKOUfTJmGq95vv5UdWwbgaxPznn4EOsTW0pzBx91i?=
 =?us-ascii?Q?2BIxWwqS2/aUe+ndQAVXXzGorL/xLWSKdX0P24LgnPgu5Muo1vtLJryTGcg7?=
 =?us-ascii?Q?CrVrRI9Gmpo7V8CXKKwzSEST2fDC33KVGNPvXTlttVUWZtMik9P5ovhOcZ2O?=
 =?us-ascii?Q?cYoKtYe/O9GSwpanuvUtmomA/54posPioYdtD46+MAETlWZgKcwiH6H6hi0G?=
 =?us-ascii?Q?SLITZbzVhDvnq0yIemvuI5k8FBwrUDLq+lv2r7N3coTIKXHrRmkIHIfkdIcH?=
 =?us-ascii?Q?sOTJMUVkwPbjbzH4R9R/OudbF6TTadLM9KRoU+3F4mZuPvLZZxX1sDGhQNXp?=
 =?us-ascii?Q?IHFbB/xymObptREER5VLkRXPq0/J7LDuMefdAYD8gaaEF6REZcgkEH1O8gaF?=
 =?us-ascii?Q?DO4GeJO/LgGMFZvHXgZ+8qns+4VP+Glpc6EPg6RP9rs8VoANcfAO/NnFW5cL?=
 =?us-ascii?Q?YbtF1SXDya//ahJyMcraYaD1FF8bj3z0z95XcgWyq15NLyjiU5JhXxYbMiHA?=
 =?us-ascii?Q?UDdAma2qopq3qjheUXtpRyS8GH1pnsLXbYPeAD94mFopPZIgKI/H8Vc8F0wv?=
 =?us-ascii?Q?IOmEOfWqJC2S1F8mSsNVvdSWzaIMmqRxgyI65VNnCud0IrwUcOfdgJIMAoQ3?=
 =?us-ascii?Q?/9jOMI9s4CcDdnQDBkNxa79jCqRkNmhYC8cwKmUpAjglYePd3ku0u4eLBTIr?=
 =?us-ascii?Q?1gXmzlxDEucDpYAWfyxRL5KpErBbYv0NEE2aDG77kVw7AF3IUIsu0qgleaKX?=
 =?us-ascii?Q?D4GSjVwUdWMbKojpzvu/b4wk0Cbv+MCFwA864Ggl71H5mSMz1xzDtzk75clY?=
 =?us-ascii?Q?FcToDZ1ZoRcS8i1dUvyAuWKX4/rTHDWZOTl/ctKTUuzXxGfOfafI3MHjw1Td?=
 =?us-ascii?Q?E0OEjvlSZFh1SN6x/xEbQI8cuLeBPVUSBPtFoz86CGJEl7VAtaNnyZ3rA9e/?=
 =?us-ascii?Q?8k9EKRyK9rtCbLYaOy3GSTwTFm0oOSMbKvIEVHqJBE17CbGb3IHxttOyHtCk?=
 =?us-ascii?Q?PkcNy1RgZCf7hoXQqUE63EUTL0UP4JBMiT6vkIQ8SB7DKQ2045LSdjr70FSN?=
 =?us-ascii?Q?zM5meiGXNLX9557kP3SacG7dVYREUYZNzFyaMR0m59RGgSeIEhsBMTDgSfMo?=
 =?us-ascii?Q?Q74wPFjdNwe486lfAfCsLNMzAbt5vS0GH8Px3aMakqcg9nER5lRUPgTMeOtP?=
 =?us-ascii?Q?jIWIYn7/qCuLS/21mbhTM++HSltnbDThfj8xHeBwHYCSJom3khrYislPmIRn?=
 =?us-ascii?Q?ZTEEU6o6kEOJDovED2moKSXCqPIcHZUFKyJ5ZYRWVvwvT/a4ag=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kn4mt0n7v5zHQQHbIGUtQ60kpsiV0Lk3PRjJllSUrNePeGtuNAXfrS0UNigS?=
 =?us-ascii?Q?g8kxHD4dl/kyAlA6Al8gYgaK85bg2Jcr/v08UQ06Tx7VuOodgkA7x3WVBlMt?=
 =?us-ascii?Q?j6GlonhV4JGcrZqfYE5piyhWTbe0CeShTfeWlqcdu1eU7gHzLKqqCshPxvLC?=
 =?us-ascii?Q?Fm718ynw5tQWkraLOHm1GCAaRShu9pTiIBTfFKw5OJh7O0Kg+Vkv+rMlObMb?=
 =?us-ascii?Q?c25/L/jB2NxB0LcDOQYNlV6if21ABwwv/pEYIS4mC6IBQRAQtKXImGzpPfMh?=
 =?us-ascii?Q?Aactf416YdHvVtofna2ni7Oro7413MQqV3vQjOnig9dAm2+u1Jf08nXEKDCd?=
 =?us-ascii?Q?u1UthfqusRRw5w1yOlwOhtBPDQ/w8Y/WYUvc2Dq2ELrtucB/ypWSS4ZF0HbE?=
 =?us-ascii?Q?5Nf1TDiK2XDnkT1gtXHBvsirjoOLedvOZ71R3ARX76JTmWTHoJKxTeRMKsKg?=
 =?us-ascii?Q?rQgV2z6txVt+8irHFxjP6c2k58chF01sPIBdz79LJ95Nn+wUXVxvAfR//Iod?=
 =?us-ascii?Q?AI3M50kzxS9yXKYsn76BGSAcllQb0PEU3hZKaRX3jLV2r6aRrfwE6/RS6InB?=
 =?us-ascii?Q?7USh88YIeL5wsbJtujk/ukT9UeGiB+pC6hvKRsMivfYeH3gTVN9eRxGVAQQ/?=
 =?us-ascii?Q?0EXPNcymNbxJv2KROXjKLJ2bBN0tZyy54XPDOLfe1WYUmPec1uWh8+Ix7PyP?=
 =?us-ascii?Q?pc7+gvl8TQS7Hf26TJdoPQ9D5XOGFNkE/RE3iFbwIu5jPbdP6q2RoCy8ynSk?=
 =?us-ascii?Q?DDARjcDjvaFz0OGTN40J3gGJDVBmBr68+wJsa3Rqt7XuPgYsVT9Pt7RBGQHA?=
 =?us-ascii?Q?eRL/w30i4ij4xa0VTodefE89C6HXxiXrAAm5CG8EJIBfA53g+ZWkd60GXp2h?=
 =?us-ascii?Q?dU9eLoCAgykkxLCN7eWIYGtfr2L6/s/YLaf3/tLuaH5eeJiRSELQVqElyiQ1?=
 =?us-ascii?Q?JQB1A7wW4UXTZh9O8ds7tz7uQIV+kUvnP9/3j8icZOurqmN5FJCdDNSMQF42?=
 =?us-ascii?Q?vD626kugFXSJCV0Zzmm5/uMNGEsdHiYkD1CTiRzIBaFh/2s4paInoD//GE4S?=
 =?us-ascii?Q?RVjYIlkRA1jXSfXePbH/leP62fKcetCEqNVlyi26932TMB4M+tG6DQ4CxCEL?=
 =?us-ascii?Q?P0KA3sHiVxtMqJY1WXVcIALuXDTVM6G8WDgkAWBsloOgBE7YrFtVzjr+RYqL?=
 =?us-ascii?Q?9qnmQxRdLTVNL3YFhB55FOl5cdwN3EMRAqBb2RC0Xmzn8H2NF70ttnUie4jo?=
 =?us-ascii?Q?VjrE/Bg3nubVwTwo3sRCRqUOLiVV9h2PiG+9ymrfdVe2Ik+/15IXmfpqT71J?=
 =?us-ascii?Q?qfqGaty9JBbxPXqj3r7VYghMCvCb1T3VUS/wuNGnrOCfqPLiS5EYLl5o6kKj?=
 =?us-ascii?Q?JT9kXj/0fI0yNDwtV16MCzk4YIK6GNuYsPQfSZn9mpjhfJxxh8Sd9uZp9ZT9?=
 =?us-ascii?Q?xwhEgXFZlJIPjkhOZ4irxDPsq8oZGdqcbxlgKguUjtI154x748GewSJNfMwk?=
 =?us-ascii?Q?9yAd92ERJ58LJm7yW+oJ9JtnOROxIFOYKOb/rmqhz8cBwsgzZYppXmQ3usbW?=
 =?us-ascii?Q?VBPQu8Cb8ZFbFjjPPejuUcZu2ckSj/J0tsbSOoczT9NitFgr0PF1Uz8TttS2?=
 =?us-ascii?Q?YtWvKba9tK50/6EhsKeguY8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F063D9F98FC0544B8F361C3A349BF09E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5nuGBGzsBgVhDks9BtdQ5BUSulRSABlG13sV23jBaQTou7PiDvPr5FsF8+nm9JY9pNKY+Tk16zZ2ZKfkC6dUpNUW6mj0U2Oezk/roFy/jp5Xb9F5f4I4DOqg8ekyAUZ2CV2Hjw6fwDt+ohdBOcDG0MogRz9GGIvm42NiZI0Wu01xnJb4cUcJqpqBGb0YIPTGTNBNZPUpiPMoaWnS5RZjQIUINvXSu2rPXKRlDf2puwUDY3AiyuSwTNXZs3rl8OdlhMmEUoNcSr4KAX+q3Rr8EVQiDr2+VlPfdrOnGrq5Dcsny6TZQ4jae1NcXZIdpAX6vCSojEv9xBYW57hC8YRGjQA+JuqRCT0ynWiqCVBf7EVtOhzMx1D2cW17Kx8/tOdfxofXhvY9A1BsvHCHY92iF4ebHiYNYiT83VDmKMswbI2K4tFR7HS7sH5MZaaUOsxbUq3Cri0Xr+IPcJRkz51tS4WMWb1JzuwTiewOG1GTyVQ9jq7j2FdsTysZh64pE2L/Jn1qRXfx06D+g/EYT/zyMK97XVJLDV8jTQIAzyMMFahyLL7am56ln3ui6792yBgDhiHeoTk6B/ZoCbsd3OsGOgm242vSXDSvTPaOzfJVTWdVvfTeLQzBc6KqKImiQYbf
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3916f550-c591-4a47-3006-08dcce21c38a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 03:12:38.9329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y18IwswNT7NRisj1b9onB9K6lAMEyRGRVLlzdKYpNPD6ZzpYUEsl6A4tqi/Q1J8rGorhL9NHVB12lk71Wsa5Z+SLXgC7igs2e+PK1w82IvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9558
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240905_201248_992123_EF4DBB8D 
X-CRM114-Status: GOOD (  11.61  )
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

On Sep 03, 2024 / 18:29, Martin Wilck wrote:
> NVMe multipath devices have no associated character device that
> can be used for NVMe passtrhu. Skip them.
>=20
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
> v3: improve patch subject (Shinichiro Kawasaki)
> v2: used more expressive function name for non-multipath test (Daniel Wag=
ner)

I applied the seires. Thank you for this work!

(I removed the prefix "blktests:" from the commit titles, which I think
redundant.)=

