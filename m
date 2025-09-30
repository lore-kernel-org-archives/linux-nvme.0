Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA529CAC5B9
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Sep 2025 03:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4W8yXloJuYhwlVVugWbIXgOKlZZRsiUX8wxWOIWUDUU=; b=OqEDExDbPw7kmDaMJkk/tyqPXy
	hqXroQiyU2VD5HydyTeYBox1zho8Z6Rm+QxwxVumEGkbJE0b4p6Qqvi3gC60JAFNSqRjBvn78DAOP
	5kE+erZCXza7IJiP4TsjOmaXdxcC7NHBhHETCoLieaa1o3nGP4+b5nugdfeoLCUeiAqW+JO5vDsaD
	pywqz2DV5+Zok8oPRdnBAcAX+dYwnOBSVImJ0hvdMu/5KQY0IykOsA68sslQURHBHkLgnlKdSwNpl
	n4SOgJPph35f9bR5gM48yrt04B7QBz8CLoZ5YR01WQ3MMAKJhEz3KhyxzzE1+b3o8HBnsLgBOrhNd
	0C8jNAgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3RK2-000000042r2-224j;
	Tue, 30 Sep 2025 03:46:38 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3RK0-000000042qb-1BCI
	for linux-nvme@lists.infradead.org;
	Tue, 30 Sep 2025 03:46:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759203996; x=1790739996;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4W8yXloJuYhwlVVugWbIXgOKlZZRsiUX8wxWOIWUDUU=;
  b=WOGOX49NhMkHUcvK4APC+nBbDAe2w7fr9I+sLcYMSvxlUDNuh2zhJodb
   aaN/mGQ24a+3t8RqF5nAopzB3g5uRUVLOqkc9RYhce1tRKYFqox7DZ4oE
   ZGWdZ8dGq+zUtPZZWSpUMmtu2rIDppnGsZPBg2nzSwJc+de9Phe3gllc9
   7jn2K4p0bG+uMFnMZ5QsQGCP/WtyWfM4+aAfDFnKrQubljczA3WzXGJ55
   e3A1hPEV0E9W2QxDXUiszPc84ro6ijSC3/j4eJTj4d+WXVNfUzWqQyka2
   Py9W7X/CO7rxTERkAm7tfqsWluOv5hsyaj6htJprh3YPtUKq8AaUZs69e
   w==;
X-CSE-ConnectionGUID: 9klinPIuQoCHNpvTXa6Plg==
X-CSE-MsgGUID: K0uFCbQtTF+k+JOc4E43UQ==
X-IronPort-AV: E=Sophos;i="6.18,303,1751212800"; 
   d="scan'208";a="131714965"
Received: from mail-westcentralusazon11010018.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.18])
  by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2025 11:46:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5nP9H9eTJz/9A8rwpQ4ChgJnJr+6b4h6DVW7y1oz7bg7ibVGWxy+1VTSs1NIxiwAAOumekIUxYljImfcbkGANM9b5vre/WJGzhKkD6ejs810ncy2lskc7abcgPiqqBiJyBZCxuQXrOlzJ8wRFhy+/BeT7L5T/Uxa0K1/wJk6vP26VDuen51/fs5jSjDdCI2s6Skh6J2R2XDb7732x1QKM7fmtsFCpMn3L2LaZrMuIZhfIViZW8zuY9LvNyLSRHk/+fPpx74WZDFTKBtpUwYUweL5TYhCTGLIvlJnhAX+G0VAFbZTk4HoHXYam7GbxI5zhPdXwJIfNgWe+cMY8youA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4W8yXloJuYhwlVVugWbIXgOKlZZRsiUX8wxWOIWUDUU=;
 b=xyIADxNqYb+BfZRe4vPDYt8OdkCrxrZVOxIynft79zk2oPdWWPdxJy8WgI0pfi0ds1yIIIGp3KVB9PS97HmQMCCFBhr4Sh2whyrcfUZ8YXhCLYIMtvKVIw3w1lizEyXubsJTb4oy0YgXB+VcSdM+xKSqMinRrDlc7+Ojwso4NH7dNSxd1BTRZEODTqilGAa9nDh9JtF5f5rj2zhhSA7GVs7bnPCPBTp/3a6N6ZMXsCCrI27kc6aMWOMWvvRFLtUmrY6KaX+YijcdN2uNceAFP/NQUUFbwpYOZecn2ZYMTHfmbs3lqtlcIEh/0NJqHCMbJLpHwOy3UzaSmk/eGVAB+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4W8yXloJuYhwlVVugWbIXgOKlZZRsiUX8wxWOIWUDUU=;
 b=Nh8K+aZS0NFsgJzqAdfVU8qjhVi41AOK/1viPRpfiKV0E5NV6yVMFlkwNeL63B/FVhHa/Mxx/sTflQvQquTsMeeKEnCKcTshqbWtWa+BnScsspWMyH3nWQ5zvzgHq78LHtt2y4yhujszoSvfqXZl0rHwSIKUk3kBBhiEtrlUVy4=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DM6PR04MB6494.namprd04.prod.outlook.com (2603:10b6:5:1b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 03:46:33 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 03:46:33 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
CC: "dwagner@suse.de" <dwagner@suse.de>, Johannes Thumshirn
	<Johannes.Thumshirn@wdc.com>, "kch@nvidia.com" <kch@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"israelr@nvidia.com" <israelr@nvidia.com>, hch <hch@lst.de>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>
Subject: Re: [PATCH 0/4] NVMe: add support for mlx5 RDMA HW and test
 enhancements
Thread-Topic: [PATCH 0/4] NVMe: add support for mlx5 RDMA HW and test
 enhancements
Thread-Index: AQHcMG4/GH6wPXF7fkGmaPyFFkCN3rSrGMIA
Date: Tue, 30 Sep 2025 03:46:33 +0000
Message-ID: <dmq4iblsx5h36pws4tmdfamvpotelyfh7og3qfyug65on6xled@mljaekurredo>
References: <20250928115125.38383-1-mgurtovoy@nvidia.com>
In-Reply-To: <20250928115125.38383-1-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DM6PR04MB6494:EE_
x-ms-office365-filtering-correlation-id: 70872d33-b735-45bb-0e58-08ddffd3f2c3
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021|27256017;
x-microsoft-antispam-message-info: =?us-ascii?Q?CvdFwe6aNhEfyhkRsBIUsjgda/NGSqJBBqz5LSLZcMiqi3W62J7wNPeWO44z?=
 =?us-ascii?Q?i7dWGQpAQZKw2bMB6Ounx7puaZEecyVjejp5Ib4VlR26M7X+T2atgaRZi0Rn?=
 =?us-ascii?Q?tM2WOwcwHUvKnaYOU03JG1tW1gN3SomzQxQ9pPpD04XdPBpUtgDoshNHxBbn?=
 =?us-ascii?Q?8AOzyzKf6Q8/aUs0IvA1bpFGhSDOFBdQkoSpD9az81SdWzKq9ZGXbTpXUmmf?=
 =?us-ascii?Q?jHiOTfwnx0tJfXNtZnSi7xmrJasU8vsU3pgomoR/lPyaGrbTJNVtzt5tPL1a?=
 =?us-ascii?Q?kdDqa4BMdwOS5swNccq4dIyo70EQqy7MbWKPfAbYcq9da0acz0bW4I4XEIuJ?=
 =?us-ascii?Q?PcqtnrRPJBJ/I8CK7WrcoQrlXJ8rHSkozNP57ZbfhQgaEIVKN07GsHMFKFMS?=
 =?us-ascii?Q?HU6RKKLYqkpsba0Otf/2nOP5mqvYi6EOBcPa0Al2Yer5Xb/fyvy4q0275EHr?=
 =?us-ascii?Q?fU8h7w3BAy4QgLhYbEoHTMYXSHdp4rjaJPMM+MkXPZWhsB04hGph2tHvwiPA?=
 =?us-ascii?Q?K1HDrtEDWFxeOTrffvPXTosIWbB3zHHi9K5Ur7JVNw2VIURyMmp1OXLNxbkm?=
 =?us-ascii?Q?OZl7o4HGAkhcT+kau71PN9YexSJXSvv1WyaLrKYeV8mLMZ2y3Ge9NwqIDyLH?=
 =?us-ascii?Q?AmsCkckFTn1jxw3xXCbsNgEY3SHH3ecfaxak5hyzo4xO5djPu5wTsI3NgRHd?=
 =?us-ascii?Q?5StVCDnw0Y+PCg2PJSBUJF2Ad5LpWzgwkdiEtZJDfx0PFsP94VMOMtvihO08?=
 =?us-ascii?Q?njS+BLbWo7Iey64/vxdD6fhv+GiOsuFWhAPcf+ss9leHUw21wA8v7xecoMVy?=
 =?us-ascii?Q?YyQlOMmJXlV/LTUQdTDOGyh/gMkyxtxBz0q7gbWP3ufSbDquc17E47PuMy9C?=
 =?us-ascii?Q?xL+Vk5YO6HFJPSsI2fxtyIVNSgyX3/nAQI5ZlQVoqRgCAUSo/6XUlHlRlxiP?=
 =?us-ascii?Q?+goeHyqz8u4AaxEZH11m0/wfHzurva2TJVheX5Lt++QnjwF/5EGrXMklhjPx?=
 =?us-ascii?Q?26n9zpzhRW41zcRrtI7HxRaMm1teoq5DhtJ2kzm83Y5mhp1faVWP4NUOfwrw?=
 =?us-ascii?Q?kNEG7Hu4gpcrh/P38DbjaN+9QWxhe683s25Ur/3dSKj0i1xB6/KwEah7y5QR?=
 =?us-ascii?Q?Ra5TEmaN9g8fsbTBXx3FrjRmCnd2ez5Ds13lJbxpQEtxDUrT8ZBh7oZ5+l9W?=
 =?us-ascii?Q?JLvumEWYPCGoUHcB3Fh4HO54MDtCXAgwba07rA2BUp9/gyPUfvuu97JEtqCx?=
 =?us-ascii?Q?YQrNcYiDU9iIAHfwEcu+AhRGueVSVkiPdurhCRWf9IWpOFMwBXdKUIv0cQrW?=
 =?us-ascii?Q?NAznNy3rNRYmmCPsSZ7pPCAs90WJDMUEG1R3nKvd/GQowtp9hy90DNiQOlt1?=
 =?us-ascii?Q?61/4J27BnL/M2vyn8uQ1lwXbRRSndK7/o+fUP17P0VsvTW3dOs4RarCMR/b5?=
 =?us-ascii?Q?hIei4TF9CnR2eMHCdGo2O+S1vXIl6DwUQnZ5FbAB8Egq/rhIbnTZ4ArTyBnG?=
 =?us-ascii?Q?HR0PpDc48KOEiGHiChsfC25izty4o7yNe4HdgKIzJSm1seDmo8GAS0pb2w?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021)(27256017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w9RZxwM3SkySpEGXZ7aKk5ecal2dvplAjml/vQOTeIxaCYBGoke0g2UOpnUx?=
 =?us-ascii?Q?swzg0j/0GqNyNKqCXx+nLDWzxA9zmg4EniMVePelf5dfvINQPukOoWkns7Lr?=
 =?us-ascii?Q?gMOvgn5m8WiD7VuaoPns/TdPD6zGaodmld91Uhc841FcxRxGlzpyeu9yotpF?=
 =?us-ascii?Q?v9f0+mcr58ygqxH9wDHDyYQVInYtVwwfbGPjPG773V4b1/2D7h3Ug0GDAU7Q?=
 =?us-ascii?Q?NW/IFoPBrZTrmrki7YSG1wDZ3MfmIn0eWxxYyQ4QEkTdfcdYzEciqVzahxyD?=
 =?us-ascii?Q?X28sRg/Y793XKV66kjWH243QLiAulTCsH2xGxddLzWPoOt/NWhwHolJbTqNU?=
 =?us-ascii?Q?rvpubNxx+ymAvKNDMKsTwGPjTGZV5uv+O16bT4ZRFLriR1Px0o8PdwOahJTS?=
 =?us-ascii?Q?bfwBzrHom83LodVyjMbsM2pUrK13IVBVJ30BT5b4hKxms6lFub/MDERsFrXC?=
 =?us-ascii?Q?aD5Cj4JKjWo8oH/WXEssoWzX1tLC+9IF4SkVhzkMKAGJnYOQRSvEPC3w4UQB?=
 =?us-ascii?Q?f8Nr8axKYG/94SY4wmE637tX1t9z7LA+Du7MmW42UJIWaQnuqiCRnJeiX6Lc?=
 =?us-ascii?Q?qGN+D2JjGoSZkGh2Bk+5zyUUGR6t3GD3KA9KnskL3cuQOfDgPRJSzDsJpk2b?=
 =?us-ascii?Q?55mLuxUtCLDLC8YqwrH6YP3kkJcH4QRMMq9797BmWsjT1ja760z9JxNXhSjr?=
 =?us-ascii?Q?9gnOt1Ffl/HQncR/YKIz9Qi2rmTL1Dd8XnRE/j++Bb5Pb01JuFYtorojhyc/?=
 =?us-ascii?Q?Qxknx0QltuOqhdtyeqFLolvffG0dvqMvH0WGwAm4xzSrhKyke1H0pbVWPqH9?=
 =?us-ascii?Q?Eko4ETZ1Z0AWhCFoiKVuD/H9ZXeQRCaECKbOWQpJOGLOG2txFXaW7ZEM8W6H?=
 =?us-ascii?Q?0LFbybQXExX2aFKqA0vNvPiuO8ZL9dVZd4RRl2KG+siwDD+2YlHiT0h/IwWL?=
 =?us-ascii?Q?kUOMRai3bMzL8KzI4dFEZ7pqYFcyHwDghFMcVaLAx1Wha5lfZM6FWAhnKHGU?=
 =?us-ascii?Q?AqRil7Awv/YRQWD6KNTdXZFO42+FivcIZdq2FFtlZtzmp/yYtcwrXmn/ctW4?=
 =?us-ascii?Q?Jb2wx9bl0ShyrO+6fkC9LD0Yq2+zNwK3dsswloUHPg9wLcTCfrhoRUvspPN/?=
 =?us-ascii?Q?B04mTUaP78NVYvBXsxGcV1zI6ykVp1TTsav4DzmCXeoIyFk4xgPgFpXDcJZd?=
 =?us-ascii?Q?j6zHyH5zDGw2CiguSYcQqq72pQbOCHsqYoK/FGekAaC9sl1qedSSIg/sXUHg?=
 =?us-ascii?Q?JRnuEOWeOQNvXa3nevVdEKYih/+IHMOwVs1s2egJl48gLU5k8JI6JH2uitzB?=
 =?us-ascii?Q?Kxp0kv68fC5d9QcS8Q1PsJWqLPME1Kute28OK3eyxw9wQrz0GSUmbZ0W/EW5?=
 =?us-ascii?Q?kRerjyU2EWkSER/pSRWHITSs0lNby98CloaCe1/PHGRX+pXxOGJjZfXxjeyq?=
 =?us-ascii?Q?/wQocQkM8ooN6E4NI4QUo2z8Rej8CsPUGaAZLck+EtXzoJ7e/WgOdoBl7VLY?=
 =?us-ascii?Q?MC2NqGBH6THlUWQHFbeN6YrYmF4MBOyxHNFfclhz3FR4mGJqChJ5EYM+Vd7q?=
 =?us-ascii?Q?EhqtcsMPBPzgc55Ezs8qifBYsqEh0C7F4rm5E9BP9WYRFKtMB8xg6eZTkQva?=
 =?us-ascii?Q?tbAjtteo8ahEpOyHeOWbatA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C01D9DA3D2B59746905CB0CF94DFB9EB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BdrvtfmkVQGR/VrHcxntaf3QSxqXVI/3V6HQ0chS50CLbH+PQwYUfhxKUDUIEpjcey2+cQP6CCk417Avnzi1Uhqum5iNtZJCQjKFZRIPmUcT1z7NByb/MBEp0+34tnxzq9345/EqrrkDZmrx5QBcIqmPEtqjCXBxml8d9l6XIaFv9IHlA8szhv3uf95i+3SFBFo4AFSIAtZXCNSB8d/qNPugsoJ1WoNSsUkOxDFRjAeBxEHXAOMAdTfJXLGecWo5z+jCbdiVbkVL8VJsbHCSUVTvQfb0u3/GDJmntbNayB1ES6NUsFnAlkqz5BoKstR/5SM1BtwTemr55N4cq67F8tAEcVUnlFuK073PxOl4J3SWfjd7Fhc2Gd4hp4K71jpzJKU3druGi5HLYLJybDoiYI9ipRv/y4MTpOHZJjv5rWkDLtOoTajZymUwKKtu8X+2i/TWKra3DHwoWJGGvGw/kmbeqXcWXaVVFJDt+vuhhA7kcwl/ELRD0NxGPg6ROFqBNMLMSQ9j7ApBR7XFyeeZ4EP5e9ulrwLC07sA8GrSU8ilU6+wAXcHHVI8YYg1EXUvKbWiSnGqJT+yTxiDehZ/9fJSyN5EBGUrOQIRm/2iWt+bLsGGBXXTPAE84yrz01x4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70872d33-b735-45bb-0e58-08ddffd3f2c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 03:46:33.2222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6XpvmFz540rbb3UnDBtzW5+cDywZ9RwQXRi8EzfpLaWtRx41cFX/TthbWE0okvt3hGqcX2YGpUDwOes8JKp3qwerHSQLhMm/pnFfiijg7uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6494
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250929_204636_387488_362F5E30 
X-CRM114-Status: GOOD (  12.14  )
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

Max, thanks for the series. I made two comments on the patches. One more ni=
t
comment is about the patch subject: please add the prefix 'blktests' to cla=
rify
that the patches are for blktests, like "[PATCH blktests]". Thanks!=

