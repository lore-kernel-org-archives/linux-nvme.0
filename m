Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E75C282EC
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Mar 2025 18:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xo1TLg/iGtpZeupCubZ6nfIM+6vg+zgYsoHTMhN8mGo=; b=gTEJuTtYpq/5mToVRLFB9wDIRa
	ZS4FC1x1J7WNmSbCuy2yktWZqm8fxUFzEolY4YZN5AyanSDuGPh7eH7SAdw+t2goDc0OFMCWmCq3y
	gdLzU+gqPsy6/tAdKzi9sz8XXDLgs5BmX6gRj6mjID81x0/U+euyL7Rp7Ig/p3vj88goA7hGhFtHq
	bETR2Nb9mynpEPTArTClcrwPBIrvwNxix4vBQBTcA5b0Zjbp2mmZ/0pvANF/O6bNUh74HpPr6CQq4
	zkd6eoF5hWWYnI9HQcDK+cO6SwNvd2H1f4SLPo4SREQU9mL5l2Ey4w/Grras4gc7h6NBnIpcuzg3b
	D//QvVag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuEtM-00000003dmC-3o5K;
	Mon, 17 Mar 2025 18:08:48 +0000
Received: from mail-bn8nam12on20608.outbound.protection.outlook.com ([2a01:111:f403:2418::608] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuEiW-00000003cBU-018l
	for linux-nvme@lists.infradead.org;
	Mon, 17 Mar 2025 17:57:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrW+v09w+2vesmhMXtCOgum1rtD9k5SgvxTyS/y3q2NWTmY0OmqLb/TTBLvGYqh8YupiZhWxdFOwE2LN+Rq55u8YijX8jze/dDI+BVuob00IgMcGvltZYsP0z2qXmqcStENEjikgwftO4FHEEy/kmH+EBMCuq7S+24ov/ZVda5sre+3mMlNr/oCZcvJiuoMmN9WxrnJJmLW8RHAqdfbq/hyo6Wzxo0qRhrw3tg+0wNes+VzlOnF3kMBc9WIX3WxttZETdJX3nQoaNnZZ6t9gjqPPqXwz/E74oUP+KVsEfeXhEKfP3cgHMLj5vJ5hqL2VfrXCLqOcArrR9jqcRVVFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xo1TLg/iGtpZeupCubZ6nfIM+6vg+zgYsoHTMhN8mGo=;
 b=IZBM6UAcaE27ZQquk+EkbCESpGz/tC+RylCY5loCijE/DGojxpEfw9w+e3gzLK8kzaX3Jknc46elzYwh5YTA1nATKVjfChrkyIxwvZOpdb2yqxZ2XLYIt/8e3Um7lBq3bSSG8V30FK6smGYpqJ2ipW6r4sklQM8IYYrAK3/6cNMQ7Sx5MmLxFXjxNDBm6JgUFgWz3qvMO7ilvG/++BoWH1/uh7+mAuv8SeG5C4HQRcEF4mc6DwgB2Q6HrtvBzbIv+5ZGHPly2zbo1X16NoMoUMNVdWmzIkwopL51ETfHZuzvOtX5pGSbsSRVU2tFPTdqlGYADawVBPy6eCr60gl6kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xo1TLg/iGtpZeupCubZ6nfIM+6vg+zgYsoHTMhN8mGo=;
 b=iY5zdTuxWJkTdXgnC+9gh/EJA4KDUGxiarcOSZs6PGyzo1gc/Etg66BIG2FVS9Z++T5yM8IIUuKFFn+/bk3DR9ls+vqccv0i+RiJpHcJ1v6OIybkeTfBkG99K1vDjS+V8MoFS8aq8mdowy9mFZRHXAeG/ssUkuUzJcwbPvBw5a2ksuMiJxjqxQnZnX3WYfay36YzJnFGbpJ8j3ykwYntwjcNjsULH43edFGksHtilYa0tZtBSSxMnNA/BKBrW4pPSQN3VIWIXblSI9dzBNlJdfNbAA5TTfdE08fjKjgYw1oBaJOShxtDOxUXXHe2pIvgRsPlWfD3JV9Bnqtu+3D+9g==
Received: from CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20)
 by DS0PR12MB6437.namprd12.prod.outlook.com (2603:10b6:8:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 17:57:30 +0000
Received: from CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::bd89:c3a2:6aba:1788]) by CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::bd89:c3a2:6aba:1788%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 17:57:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v2] nvmet: pci-epf: Always configure BAR0 as 64-bit
Thread-Topic: [PATCH v2] nvmet: pci-epf: Always configure BAR0 as 64-bit
Thread-Index: AQHblyMF+2rO2epk1kavrJyNzEhaZbN3ndKA
Date: Mon, 17 Mar 2025 17:57:30 +0000
Message-ID: <114cc3ee-3bc5-463c-9355-6dd5d69825d6@nvidia.com>
References: <20250317095703.1661633-2-cassel@kernel.org>
In-Reply-To: <20250317095703.1661633-2-cassel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXPR12MB9386:EE_|DS0PR12MB6437:EE_
x-ms-office365-filtering-correlation-id: 7f738998-f1c8-4c8d-8a66-08dd657d2fa6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QmlWRVFrUlNaM0I1VWdTOCtBWlBJQmgwQ0d6Sno4NVdZSzR5a0grdnA4ZEpj?=
 =?utf-8?B?Z2F2YW9Md2hXb29JeThuN3BFR3hnREVYWFpSdVQ2ZnVsa2paNllLOVliMENI?=
 =?utf-8?B?dnhDbmxENUt3TkNoem5PNXl6Z2o0SWt3MTN3bm9lRWN4RnVqdmdrOW5sc0tu?=
 =?utf-8?B?MXJSb2EvQ2psZndOSTdsS294OW9QTGlSa1MvTFhjM1MwZS9BbWgxZUFIQ015?=
 =?utf-8?B?WWNiSkxMejNEMDRTanhxc29sdjRoZm43ZHQvK1FFc0VRaXphSld0aE10T29J?=
 =?utf-8?B?dStCd0JzZlZzWEV5NlVVTjNBUmFmdEh5TUY3QVFjQzJoaUVwemwvdFJYa013?=
 =?utf-8?B?Wm9HYmVIMUFodUdJci9WZVltZkRicUNmbWlXbXhESUFad05iTjRaSkhINThR?=
 =?utf-8?B?ODB0U2MrUEZaSzBBK1V6aE9aY05POGhicGJSS3JUZFB2Y1hXV1NGRzQ1ZUFN?=
 =?utf-8?B?WHl1eDZLQ0g1WUtRSGRFRW5uOVNJcGgzS2UxKzg0RjhaajdzbVZtR2wrV203?=
 =?utf-8?B?WXlJeXlFSGhWVm91U0p0bjZIRHdDWkJndmRlcUNCUG9iMk8wa1RhcGU1T0p6?=
 =?utf-8?B?eEJ2NWZ3NVNFeE0zUk15VTJBQ0JGN2pJTHB1UndEUjFBWXFsMXR3eFRBMXNL?=
 =?utf-8?B?WnpiSnpXVGNTdC9yQWxLQkVLOWZKUTlCMDJzdEdwaTQyN2U3UjNSWGJDMW9D?=
 =?utf-8?B?WDRnamZaWUdBVjhDLzllZzZFcFN5UnAzWndCOXRqKzRzNWZMVlZyM2t5OWZB?=
 =?utf-8?B?VmdFWlZXaUV3NEJKVVVTR3JzMzMwVDQyV0R0bXBsWmV6SEIwTGtSbm50YmpH?=
 =?utf-8?B?MDVETmtPTEgvRnpmbmw2ZHJONVZRMGFnN1U2bmQxWEgxeHl6TGxha0g4QVFR?=
 =?utf-8?B?b09rMFFHSnlweHY3ZE9lR3AzL3NIcFN3bCtmTS9IWlNpR0s2WmxWNTR6cklP?=
 =?utf-8?B?ZmMwWUVxdjUxajVueUFVMGpXZmtpdHM5a1kvOHlsSFZXQ3BWMUwvTHl4L1BE?=
 =?utf-8?B?VkVxZmc2dVVwcm15VjNsVFNESFNMTDV0WE5lZTRFNlBZUDNTRnBWcFY1OHJO?=
 =?utf-8?B?cnhwQ3M2alVaeEdKdzc5YjQ3c01pSElQZ2hjQXRjRk9UQUErcHRpNGJZb0x3?=
 =?utf-8?B?dG82UHNSWldwbjI1LzFEU2xKSG5KOEpnNk1OWmFBQm9KcUpJV2VrYU5tNFVu?=
 =?utf-8?B?dkZiZ2lnVmJnZStDaWJhT2dLNjF4NVVpcEFLQ2d0TGt0Z24yT2h2R1pBaHdw?=
 =?utf-8?B?TWZPWGVqYklxUlpST2pEdFpwbHZJMm1IRnBTWUxOWEkrK05EWFNWOHpmWmpV?=
 =?utf-8?B?UUh3NjVzdGdJR1A2d0JnaWNWTzZTTmZuWFArMm0yRzMrSDZWWmxWY2xtYzJs?=
 =?utf-8?B?ZGxxV2FhdnhtV2FVSVZBZncwMmg2VlVENFR1S2I4S0ZSSnVCMnRTanB4Z3l4?=
 =?utf-8?B?Tm9GNGpoMStEM2lMMS9tREpVUmY4SnVZSFRab3pLcmJ0V21XRVJLMFA4cUVo?=
 =?utf-8?B?ajVlTFJJVjNIWW0vRU10RmZ3YU81R2VtdHM0VHVxM2s0bExaQ0JLSENYRzhK?=
 =?utf-8?B?cEppQ3duby9YK2xWV0FDRUt2VzJYVkZIWUp3S2dVeGRMTDhZOW9VUmhWblRs?=
 =?utf-8?B?RzZPY3dFODI3djBOT3JEK3kxcjAwdzZLZTNWZlJtZ3B0Ym5FZml6OUtjRlYy?=
 =?utf-8?B?YnFGV09tclVnVEJTL2t1allUZWFPYWphZzRTcUp3V2s4QXNHUG1oRzFnNjF4?=
 =?utf-8?B?YUtMUDF3MnhDOE9LRDlqS2sxZjBZMDVpU3dFdzF6eGl2R3dvVWFEd1M0VVh2?=
 =?utf-8?B?M3FaNzhCOXRjenNUSVhIV09oUkN4czgxMVJGakxXVVVtYWFzZFlLK2s2UEUx?=
 =?utf-8?B?RjZiTWN6QmFmc2RKSjVkdXJHcmR2T1lwT21xMyt3QzBOMnkzbHhoeXloemJO?=
 =?utf-8?Q?lL8umPqdqZK84+f0ZWDDYkhHyF6FgPA7?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9386.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0VOdmdDN0ZBTEF6N1NITk81NUxhKzd6OTdIWmJoRlZsYjh5VGtBS3N1VVZw?=
 =?utf-8?B?TGpXRC9GSlFwanZXNS9qdVYwWEZzQnpuUmdKY05hNUdSc1ZmdnhzYTJMZCsy?=
 =?utf-8?B?NEFmM3FNVENrS3YwcStwUWhRS241VDI0VVFtOVRGekdZRTU5U1kvZEhQMDQz?=
 =?utf-8?B?NUhieVZQQy8vb1RYMERqSDdDZjBDQXk2UkZ0NFJwTzk4SVZPYVFnOUZOSkpt?=
 =?utf-8?B?ZjFlRnkyd2hnekZXWDNja0dZZkxlM1h2UUVmQmsvdTV0TWtEOHV4bTREdVpQ?=
 =?utf-8?B?WEErcFBRKzlvQTVycDdXVlhsd0ZVZFdDenlyM1NLaEgveXpCbEZ1NGg0Y1ly?=
 =?utf-8?B?YkJ0RkxtZVBNS1dMenptRGxLb1RjZU1lZDhBMHBwRC84UHZhNnQ4blpqTFF0?=
 =?utf-8?B?UThuQmxGU1llbmhGMDVWTTk2dlROUEpTTUpKY3NGRTVqU0NYbzJvTTA5ekZm?=
 =?utf-8?B?STdjdGYweVliVzh1bTZzdm51aGVaUWxOSXNPUnpyaEhadXBZckIzMUE3eFlq?=
 =?utf-8?B?YWdQTXJ3Z2hxOFBGa2dnNFNpT1dQZUtMRTJuR2N4MkoySzBEeXlUWStxb0lR?=
 =?utf-8?B?SlF1NkhJZVAyQmJHQnllMUJpS0htOGtZN25rNTFudndLZW1PNTlMYTNCUXg4?=
 =?utf-8?B?Yzl1OHd3cnlla1U4Ynl5aHBCQUhaWC9KVVMvTWJtbysrcUdFWVkwZ0cxR2FZ?=
 =?utf-8?B?YzE5NDY0MnM3SWFCV2JhWW9RR0ZkWVltL3NHRUJ2czBXeVRSZkNSZ0hxQ0xK?=
 =?utf-8?B?N256MHBUVjlKVWRDOUNyZVR3THpFUWF4V1dZL3psMnBZbXRrWXJXSWpWR1Vu?=
 =?utf-8?B?R21xKzZWN1Z2M2tEMXp0NzluejgzbmtHdjJ0Qngyb1owZno3ZU9YSSs5KzVk?=
 =?utf-8?B?cWN4R0IrejV5TDNmNm5zYjdBNUppMEVxMzlLUm9UTDRzcjBBc0prNWJ3NU5q?=
 =?utf-8?B?UW1kdDNZWTU3REFrM0VKay9wUWt3Lys3dW5sSXM3NVB1RzczZTRvY1lPV2Mx?=
 =?utf-8?B?WDVDTFBVWXoyRlVTbFVoMW5BSXF3eVA2RWhydXdUL2tkVVd5TEdBZ1dZaXdM?=
 =?utf-8?B?Nkgyd0JhcFdrMTZISDhJYmNLUFZBNGFScVhEWXZiQnNQWlY4VTJjSmNMRmtn?=
 =?utf-8?B?dXovUEhqS1hPMGZPa1VRazVDWkxNVW5NS2tFQ3dIOUNNSnhGZlZQVWRMTVBV?=
 =?utf-8?B?VHZyL3FqN2UwTFpERmJVQyszRHVmTW9WVFhISGZxUTBvZlhRYUZtTXNEVWZ2?=
 =?utf-8?B?MkZBaWZ2Nno3ZGFNYnBjM1ZvQ3RleEFDSHBGeTRKMy9YdUIxMEJ6MWJBZDR4?=
 =?utf-8?B?YWFqRXhGOHJZMi9Pa0tNWjg0bnFuNDhHWEE2VXgwTWlxREl4ZTZpSisyWnox?=
 =?utf-8?B?YVl0VnJvRGNNZnlzTE9YVFNpamJjSDNzT3QwTGtsTk81cnJuNUFUMmhqMjc3?=
 =?utf-8?B?QVFaY01mcDlXSUVHZUljZUY2WCs5Rk5NTnNxVEVJRlpQMlpoVUpLbUwrMDRn?=
 =?utf-8?B?N1BtS0NvbklHaEw1NXNPYVZOeUozQlp1YVBIay83b2tUcXZNeHZveG1TY2Zs?=
 =?utf-8?B?Nm9IWW1ub0Y3MHZHUEZ4dDVIQS9CMjNWaWdXTklDMUtoRkh1amdYckZvWWZa?=
 =?utf-8?B?eEppNmRBN1U3aW4zVjUwRmJFb09Lc0d2clI2NnJKZTJ3bEdRczFkUlNRajJG?=
 =?utf-8?B?L1VKcE1NOHplbUtBb1JHcEcrcVJic0p3TklRZjduNzc3Y3RVV0JrbEZTTlQv?=
 =?utf-8?B?R1kvSlZhZEVqbExYclRFU2RPVXNxTERjSWFnQXMweWZsSFFaM0p6UlJCeThK?=
 =?utf-8?B?a3F1eDQ2TmZBaUNZVUc4RHc5d1BLS0t4aWxtb0RzWm9yQVIzRk93WDNzSjZQ?=
 =?utf-8?B?cnR4bFlTRCtJdHZOdXUwa2hJMmZaVXJneGdjY1gwV25XYXZHeGNHbjgrc3dC?=
 =?utf-8?B?eWlGK0YxTDBDU3R3NDVYZjJPaWNLdnhIWVIwUTlzbDRwWVpXTC9jaUZrZTZV?=
 =?utf-8?B?YlFRS2d6MlRLSnF3alB3cnNVTXZWU0ZHZXRWMTMxOUM5djdzV0d6MU9kcDRl?=
 =?utf-8?B?NnhxTnBLQ1BNY0MwY0JLZXdET2dkbk5CS1hKL2d1YVlZaHF4ZHR5Q0lrQnVm?=
 =?utf-8?Q?J0l0v2KD+J/v4Yes3+GKI2Esv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CA537BEE72D544592420FC4BAE07D50@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9386.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f738998-f1c8-4c8d-8a66-08dd657d2fa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 17:57:30.0538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LKMinc+aUbm2FyHEm0sjMgzDw+k5ddOsrg/PsARZMRu7finCW5eOA66BGkQjFEOzKcrGohrWEbxKiEhivCswxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6437
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250317_105736_046454_BF4C2D7D 
X-CRM114-Status: GOOD (  12.36  )
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

T24gMy8xNy8yNSAwMjo1NywgTmlrbGFzIENhc3NlbCB3cm90ZToNCj4gTlZNZSBQQ0llIFRyYW5z
cG9ydCBTcGVjaWZpY2F0aW9uIDEuMSwgc2VjdGlvbiAyLjEuMTAsIGNsYWltcyB0aGF0IHRoZQ0K
PiBCQVIwIHR5cGUgaXMgSW1wbGVtZW50YXRpb24gU3BlY2lmaWMuDQo+DQo+IEhvd2V2ZXIsIGlu
IE5WTWUgMS4xLCB0aGUgdHlwZSBpcyByZXF1aXJlZCB0byBiZSA2NC1iaXQuDQo+DQo+IFRodXMs
IHRvIG1ha2Ugb3VyIFBDSSBFUEYgd29yayBvbiBhcyBtYW55IGhvc3Qgc3lzdGVtcyBhcyBwb3Nz
aWJsZSwNCj4gYWx3YXlzIGNvbmZpZ3VyZSB0aGUgQkFSMCB0eXBlIHRvIGJlIDY0LWJpdC4NCj4N
Cj4gSW4gdGhlIHJhcmUgY2FzZSB0aGF0IHRoZSB1bmRlcmx5aW5nIFBDSSBFUEMgZG9lcyBub3Qg
c3VwcG9ydCBjb25maWd1cmluZw0KPiBCQVIwIGFzIDY0LWJpdCwgdGhlIGNhbGwgdG8gcGNpX2Vw
Y19zZXRfYmFyKCkgd2lsbCBmYWlsLCBhbmQgd2Ugd2lsbA0KPiByZXR1cm4gYSBmYWlsdXJlIGJh
Y2sgdG8gdGhlIHVzZXIuDQo+DQo+IFRoaXMgc2hvdWxkIG5vdCBiZSBhIHByb2JsZW0sIGFzIG1v
c3QgUENJIEVQQ3Mgc3VwcG9ydCBjb25maWd1cmluZyBhIEJBUg0KPiBhcyA2NC1iaXQgKGFuZCB0
aG9zZSBFUENzIHdpdGggLm9ubHlfNjRiaXQgc2V0IHRvIHRydWUgaW4gZXBjX2ZlYXR1cmVzDQo+
IG9ubHkgc3VwcG9ydCBjb25maWd1cmluZyB0aGUgQkFSIGFzIDY0LWJpdCkuDQo+DQo+IFRlc3Rl
ZC1ieTogRGFtaWVuIExlIE1vYWw8ZGxlbW9hbEBrZXJuZWwub3JnPg0KPiBGaXhlczogMGZhYTBm
ZTZmOTBlICgibnZtZXQ6IE5ldyBOVk1lIFBDSSBlbmRwb2ludCBmdW5jdGlvbiB0YXJnZXQgZHJp
dmVyIikNCj4gU2lnbmVkLW9mZi1ieTogTmlrbGFzIENhc3NlbDxjYXNzZWxAa2VybmVsLm9yZz4N
Cg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52
aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

