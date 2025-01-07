Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66BCE77197
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 04:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9m8n3NkhDuICYh4rTTD4W/5qimQnUPdKVA9J3VByx8c=; b=X0qIL3AKa6feCi5WoFPa9R4jC5
	HKJLAVAsNDrBc2J2JSXUUtAdBCJWWTaKUhXSvmpgNKrATZgHHzChsTbr+iNUmPeXykNjCwVCSVERT
	tCfXIWvZICyA5i6KqSsaem/hyE87Ot/1oyrKMiLb6WieIqimAyi4Pmdfy3qfkiL8QwALeQweShP0I
	Y9GvyHdk++wz+6uHZecmD0L0FIFqu0hL0POL6s5O7rzqb0rSf0JrPnZcMe9ORZAjChuAAk7aOBpV6
	dJ19MGmzgoUVyR9NbBEtFre0GG4gQ6cOmWI0ETehW4inmjPYeZBlnEwnFv5dpIZrr+d+mkVNhyMYB
	NtUMK+eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV0zg-00000003S26-3E9W;
	Tue, 07 Jan 2025 04:15:04 +0000
Received: from mail-mw2nam04on20601.outbound.protection.outlook.com ([2a01:111:f403:240a::601] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV0g1-00000003Oxa-1ybb
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 03:54:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0t99hwrQBjDElUP+ShfwZz77WhfDrKiVtfQ6j1ZO2+jAwARBqGWysRlBf7cnutV7zeWHGNzEmE2cpnpa8lSlSaF+/mXXpGqi6rSowjT1OvhtqulgtpGkwiGG2EzHTT+6HamMDoS0cO7eIRQnYGEFCH3c3T0EyQWomUvfKKGFi3sHbG0jUTCJhy20p9xqyz8xcHZp8lBJaDRJ0A0velxviGSD/r8EzhzuPO+Xevx+9RkzZpERlDAq6yzqupX1BxhVEv6VZmpHOu4KQhWiDDF4aXOMiACnpJRyGwPZaFo578obvXebK1mUvasI9okfD9EIG6LXtdmchBnedXsAXHJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9m8n3NkhDuICYh4rTTD4W/5qimQnUPdKVA9J3VByx8c=;
 b=Bo4zZmeJlcOF49PhXBxqnWQSWK8wWtTUlS4cFxUI5Ypl/Pb50spzXnUjuxi7VI/DQqLBy8j67jo08N2V0n3Xb4R7U+PEXyGkhf2oVdIZ15CplD4BX0N/Kbs3kQFDxth6cYS2ct5dozA/EcuCNw9EUCrhQGuhaLeI+wD8VMhAkj14JY8lMkXDm6ewJboEd0HLviuWQmrVfz7WdpHygn3lmqYbz5cbKl7VppC5tg97kBqEFECdlQFY2fYXWNf78X9q2zFKTspv6xNurpbF2l/U2F/IWaqoIxjxXJQ1VWvT12M3BmTnojqgSJ+ys4ffPycbe1QF/cyBxYyO8euXZdcdjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9m8n3NkhDuICYh4rTTD4W/5qimQnUPdKVA9J3VByx8c=;
 b=OHJ6+9NRPQErNUIhD103pG1hNQxaGHJ/3ovGvx8Vz2o2e1Hv+/gi5vP54VpAw4ZjxITJP8OCTxp5HCuwoZLGYz5ahtpd7gJM9yWPHNWdyXTvKcHN8IQDE7ZB/ZNyRYFpTkmrt6YjjFfqohpAocopPWuq1Fi3g4CL74/cJsVx2uBmTC4FlMDt9T8At7JRZOewnQCNzxXCSscnd+fCuZ3IL1yagNxmzm9PxqTH4LXDg1JwJv1Vru2a3edVA34Ee8nvDwVQw/GIm4MShJaQ0fxVjZSRRJSnxPltXswtzl7MD1Hauvc8bHq752IvnwO1w6CXjbQTW0YHwTp6mg2Lp94NHA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ0PR12MB6879.namprd12.prod.outlook.com (2603:10b6:a03:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Tue, 7 Jan
 2025 03:54:36 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%6]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 03:54:36 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH v2] nvme-tcp: Fix I/O queue cpu spreading for multiple
 controllers
Thread-Topic: [PATCH v2] nvme-tcp: Fix I/O queue cpu spreading for multiple
 controllers
Thread-Index: AQHbXu+DtG1cWjqDgkG4HPUraI+E1bMKsd0A
Date: Tue, 7 Jan 2025 03:54:36 +0000
Message-ID: <ad29db09-5643-4399-ba79-c2a2eb21e620@nvidia.com>
References: <20250104212711.37779-1-sagi@grimberg.me>
In-Reply-To: <20250104212711.37779-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ0PR12MB6879:EE_
x-ms-office365-filtering-correlation-id: 3288c027-d848-42a5-a31f-08dd2ecf00f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dVU2cEdsUTJxa3FwbkdiUVFROXZmM0o4bGIweGNKS3dhcEtNb2pmRE5yRTls?=
 =?utf-8?B?Y2hDVEZhUmFmSHVCS2dsSkNRUit3L3FheGFCZ0N2b3hmdDI4cm1OeDRiSWJo?=
 =?utf-8?B?S3hmM2ZZWldWb1N2czkvN1VUZEw0Qi96MUNBek1zMGUwb09tOVRmbWdDU0NP?=
 =?utf-8?B?dzFqdHZITDRyNUFmY1JWZVV1NW80MWZYVU8vcnZXbnE2NSs3OTRWMkhnRGE4?=
 =?utf-8?B?b1RiYllGdlFyTFRVQ0VwZnNhOGNUU205NERjbGpNbldSSU5NdHBDeUJBWmNB?=
 =?utf-8?B?L2k0VXBOTVRYTkVSc3FpTmkxWUcxblBwQklyZWNsdkNzYjJXV0k2WnlYbTlp?=
 =?utf-8?B?aThheHkySlo3WFNoQ0JJcm9CZjZGMzhldmZhTmhFRE5HVCtYQlY5WjJLQklW?=
 =?utf-8?B?c2taQ3hJSVJpbktNTDJYVWgxNVVZQ3o2Q2ZXN3AzQUdzRDF0RFVGdEJUNTVC?=
 =?utf-8?B?OGt2MklhU013YWgwUk1lOTI3SEFsVTFQUlVGOUEza0VqWVJaUFVsWjN2TW5X?=
 =?utf-8?B?c0hqeDRVd21DbTh1ZVN2N0JFQzd0aVU5Zkl4by8rLzJnbFlaTUVFWkxsQys5?=
 =?utf-8?B?WS8rdTZLdG5vb1dJYnlZK252RUN4bDAwTVZzR0xjV1NTNzF4eHl3RGE5blF5?=
 =?utf-8?B?MWNPNnE2OFFLcGtQNXd5d1k0UUFQYkJnOU5vSHNWL3pLY3hCNGZiczIwY1p5?=
 =?utf-8?B?S3JnWmREaGVmSkdPaUl1ME9vbFFUOFZMVXQwUi9OK2VNNHZYVFpYT2NBUTZm?=
 =?utf-8?B?bE9CcnQ0YVdiTGMyREkwSHhJZDRwcitNVzF2bjVURVVsTlhpWkFXR25JZUZi?=
 =?utf-8?B?am85alJjaXpabVpRa1Q0ZlpJd0tUdFBkQ1BwTlhCd1h6Sm16T1FCdlRNNWhu?=
 =?utf-8?B?RS9TL1ZiT3ljVnZwQ3pKWVpTR1pkUXN0M3E4MGhEUmdpT20vMVJHYjlmZHl5?=
 =?utf-8?B?SzI2VC9McTMyOXdZd2F0S3Bpak5uZ3hDVFNWazIxSE9SV2JhblUxdUJIZzdh?=
 =?utf-8?B?L1NicmRkTXlJVnhyTWxvcU9vb1VNUCtEMXAyQnJ3SDVGZ3k4WDhHNlBzeE5l?=
 =?utf-8?B?TjB1ekY4cm9jRExxempuZVROV1pPSHV6SmlVRlgyMnhBNUltTm80c3ZwSVA1?=
 =?utf-8?B?NHNEU1NXd3ZyVmRWc0NVaVpSN255cCs0amZlU2lVNTlLWkNBbVFyZnVSajVn?=
 =?utf-8?B?NWF1T2p4M1NyOUhnZGhrTlRjU1cyTnRxUW9pMURITXMxNmhMVXVlc0FpVW5K?=
 =?utf-8?B?clF4LzBQSEQxNFVBSmlLdis4aEFpZzJMZW0vMkxRTnZCenFwVkNvWTJBWWFN?=
 =?utf-8?B?UU9LZElwSHdUb3A1d3lIK080bFY2TU9aeldEbk5PYVJ6bDJTZzUvN0pmeG92?=
 =?utf-8?B?enQ0bzNvVThsamNzdVZQajVJL29oMFpRbFE3ZVIzTVBXQUNLK3FzQUt2VjA2?=
 =?utf-8?B?OFV5NTE3S2VQbUZZRVExemwxTmZMQXloeWZVNVlmcHFpN3JLdDM3d2FVVlVs?=
 =?utf-8?B?TE1tR3ZBRHNjbHQ0TVFVbHIyWkU0YjIzTUVBRU13S0JzUTlBbUVxZDc4RXBB?=
 =?utf-8?B?dk9YRDJpLzVTeHc1YmMrQmRzdkIxNmJrUE9WbGljNTBqZDMxcXc1Qkh5NTlj?=
 =?utf-8?B?QlJNaFVBQi9xWlZoRmVUT0JaTUVoRzZSWlNWMTNVRmN6Y05BQjhsL09ENXZ6?=
 =?utf-8?B?eVRldTk1SzJmeHVyQTNTVElvb3RJaW5OcThXZDEzWnJ5YVl5OFhKcldxcG1j?=
 =?utf-8?B?aG11V2U2SnZqaGx6RFFVeXB1b3VTcGRwWW9DSy9QcjAyUUpRRHRNQmJNTENz?=
 =?utf-8?B?ZDA0WmJnOHdKSGk2ZVhDUStHU1p0VDhkK3UyS29xb0lMalVuUjFsdUwzSmlk?=
 =?utf-8?B?bVV0MnBOY3grWEh5Tjloem1HL2FwMDgzYXZjRXI3OUEwZlF2Q3JaNDZMeHQ5?=
 =?utf-8?Q?YciJF8UWi+0t7Ed+zDGowVSl8Dv/EK+l?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnR2UkpKTU5nU1ZjMFdrWHMwTEpGZ3h1YktBNzM2NXRCL1YxRWpUaWxXc3h3?=
 =?utf-8?B?UzVvZkIxR1hDT2F2VFpjQnVFTmdhUWpVM3dkWTlxOFcvcFBucjNueWZiVFA1?=
 =?utf-8?B?dGVQYWhuYzFsUDBQcytCMTg0UjlYMGNBVk1sSHRuZEUydTVoRkFleUxnTE0y?=
 =?utf-8?B?OG9tZVU4Yjd4ak4vU1pXKzFScEtGRHVoZWtMVjJDZFJ1bmwydXZIVDlsVzEw?=
 =?utf-8?B?emU4N1hOdlV1T1BBQ25TcG9SWWJaZTRzekg3RWhLVEI4VVNVZk5KZlZDdEsv?=
 =?utf-8?B?bzVXY2MxRTVjSUVHMkVXUk90ZTdTVkl6Wi9xRko3ek53K0NmZE9LYSs1OVRz?=
 =?utf-8?B?dGRkSTRJeWo0amU2K1ZIb3BqYXRlSEMyUFBuSXlzSkZXOGo2VVpkd2h0d0Jw?=
 =?utf-8?B?elNxdHNaNlZLSk5FbGFBSzFCa2lnVCt0cUVRTXV4SGE3Rk0rUmY0dFNXR2lQ?=
 =?utf-8?B?cEhHK1BxUytzZjUyeDBUVkNBdDR6NlBwaUxBMjUzN2lEMnplU0ZWTVFrTTd5?=
 =?utf-8?B?MFdLT0Y4d01hT0JiZFE3ZEx5K3lGaER0QTRQSWxSVFU1SE9UV1JWcUVCcVQr?=
 =?utf-8?B?UmcxeFFZRDdlYTNLTFVYK3hGUm1GQ0NSRVBpMGd1KzdBMHlFMjJTMnRrNVB3?=
 =?utf-8?B?YWRxMTJnengzNnlYczdSR3VBUVZhYVBOQzJydTYwZkgwOEp4RmtmUVR0TDlm?=
 =?utf-8?B?eU5NU2h3UTJkMFVzY01mODR1Nk80amRNNTdHUnV3ZmJaZFFCczhxTEFTVlFx?=
 =?utf-8?B?RzJuTzJ0cWxPakJtd050NkJRdEFyRTJBNDZUV25qTjZCeXQySjVsWFNOeGE0?=
 =?utf-8?B?OTdaS2VHeU1xeE0xNE5DZkR3S1RRQUtvckk4emxTRk5NMUkwQXlTYU11NmVz?=
 =?utf-8?B?VjdRQ2E5MldobklvdFNUQk9KcGFTaXQxOXFWb3lwTXdDa3lHL0s1bTI2YWRv?=
 =?utf-8?B?MWhmUWcycGtBaFFLK2JnMWJKK21Jd0xjelg2QWtvRmZmaHNSaGNvdXowcjVz?=
 =?utf-8?B?NWw2Sy8vZWdoQkZXdTcwSVFQVWR4S2plSmJ6bk5CZzRIdlRRZWhRcmZTNmNP?=
 =?utf-8?B?TWFGRHcxVGsvMm91TGowV3kzeElrQnhTRzZnVTBjU2JFSlk4TXpac3U1Y0d1?=
 =?utf-8?B?YW4yMFMwTXFnUVduRDdzNFl4V3I2bGVuVDQyU1hQcDNtZllvbkpYTlhmVnBp?=
 =?utf-8?B?RFYwOHdINWJVellRdHZKTFVLRGxySFU2b2lTcTV0MSs3RGlBVnZ1ckxHa0dh?=
 =?utf-8?B?aXhBS0ltNDNkTjlMZFdZV21vVjNPMC82SkluNTVlUlhBazcycml6Ylk0THpq?=
 =?utf-8?B?OE1ybDloOVJ4MUNjMDY4WCtIV040SWpkQmhzdmczdmhzckRBUCtHYWNSR01p?=
 =?utf-8?B?dC9maWJmZFNURFh1WkM3UjhHaURFeDF2RTU5SFd4eHNpMVFubWxFbDlIREhy?=
 =?utf-8?B?Z1lSbG1ObVBkRDdKOXF4SGVJaE1wQ0tzRUdtR0lTLzVTV0NLMTYrMkxCa1Ji?=
 =?utf-8?B?bFhVYkdPQ0dBdml4ZkJBa3djeFNLSkRUc2ozNFJ1bVd5b0ZUMGZLb0FXU1F2?=
 =?utf-8?B?a2ZTTTBlWHhuRzFyaU9NaU5XVUd3bjlsVTQzcVI2TFI5bzAvUEZYWnQreHhq?=
 =?utf-8?B?OXdMQzRJU09KV04rYUxZSUdreGlvR3g1dDlJZVp2dEZxYmJaZ09PeE45R2l0?=
 =?utf-8?B?bmNWTDNxSGI0b3paR1ZnNUJhOFV6bzVjWlhUSndXcFRIUThiM1g4UTJLK3Vz?=
 =?utf-8?B?NXgwUEZXNDBOY0hDbnEwWWtkOWZ6WnIyYzBkODJBMjk5Z09jcFdYcGJldDJp?=
 =?utf-8?B?N3p3SFNZQVVyeWZVS1BpdWo0S2RIWExZNy93WUdMSW5qano2QmViR3R2SDVX?=
 =?utf-8?B?cUYrVk96WWkyNmo5cWI2eWxpSmhmcVFiTGhUaHhVUHNJRWpjZ3RZdjZKYzZW?=
 =?utf-8?B?a3UwUDhkelVrbmQ4MkhnZk5VL0NXZEMyOFU1djY4d0M5RmZELzgzaFFsaCtS?=
 =?utf-8?B?UkdBNnowRTkvUlByQTNSVHQzNlk3Uks2OUZJR3RPZ0pDVEhqeGZnSmNoeURw?=
 =?utf-8?B?SEdIL21zeG9rRnRVN25MbnJEYkFHY0FLR0k5bi9Na2pWTVNQUHJtUUZpTG9U?=
 =?utf-8?B?QktrcHNDMjF3QU1TQzdkTkU3czJqUG5OS0Uyc2RINHpQK2VodGxiRVVNZ1ZQ?=
 =?utf-8?Q?RaNIev99WwYt9m8fFGjcfSlE00rNWpw7qAVGaVf06zN6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA81527194DD1D4DB5BA226BAF3D316A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3288c027-d848-42a5-a31f-08dd2ecf00f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 03:54:36.5444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GKr6OhgRYYQgBrqj17ydx9QM7VvDSQe2WZkmDs3c57nRO7U+rVZaCr0yRdwDP5geHxNkSf95at+Olsr3PMAyvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6879
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_195445_510296_ED72D526 
X-CRM114-Status: GOOD (  21.20  )
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

T24gMS80LzI1IDEzOjI3LCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0KPiBTaW5jZSBkYXktMSB3ZSBh
cmUgYXNzaWduaW5nIHRoZSBxdWV1ZSBpb19jcHUgdmVyeSBuYWl2ZWx5LiBXZSBhbHdheXMNCj4g
YmFzZSB0aGUgcXVldWUgaWQgKGNvbnRyb2xsZXIgc2NvcGUpIGFuZCBhc3NpZ24gaXQgaXRzIG1h
dGNoaW5nIGNwdQ0KPiBmcm9tIHRoZSBvbmxpbmUgbWFzay4gVGhpcyB3b3JrcyBmaW5lIHdoZW4g
dGhlIG51bWJlciBvZiBxdWV1ZXMgbWF0Y2gNCj4gdGhlIG51bWJlciBvZiBjcHUgY29yZXMuDQo+
DQo+IFRoZSBwcm9ibGVtIHN0YXJ0cyB3aGVuIHdlIGhhdmUgbGVzcyBxdWV1ZXMgdGhhbiBjcHUg
Y29yZXMuIEZpcnN0LCB3ZQ0KPiBzaG91bGQgdGFrZSBpbnRvIGFjY291bnQgdGhlIG1xX21hcCBh
bmQgc2VsZWN0IGEgY3B1IHdpdGhpbiB0aGUgY3B1cw0KPiB0aGF0IGFyZSBhc3NpZ25lZCB0byB0
aGlzIHF1ZXVlIGJ5IHRoZSBtcV9tYXAgaW4gb3JkZXIgdG8gbWluaW1pemUgY3Jvc3MNCj4gbnVt
YSBjcHUgYm91bmNpbmcuDQo+DQo+IFNlY29uZCwgZXZlbiB3b3JzZSBpcyB0aGF0IHdlIGRvbid0
IHRha2UgaW50byBhY2NvdW50IG11bHRpcGxlDQo+IGNvbnRyb2xsZXJzIG1heSBoYXZlIGFzc2ln
bmVkIHF1ZXVlcyB0byBhIGdpdmVuIGNwdS4gQXMgYSByZXN1bHQgd2UgbWF5DQo+IHNpbXBseSBj
b21wdW5kIG1vcmUgYW5kIG1vcmUgcXVldWVzIG9uIHRoZSBzYW1lIHNldCBvZiBjcHVzLCB3aGlj
aCBpcw0KPiBzdWJvcHRpbWFsLg0KPg0KPiBXZSBmaXggdGhpcyBieSBpbnRyb2R1Y2luZyBnbG9i
YWwgcGVyLWNwdSBjb3VudGVycyB0aGF0IHRyYWNrcyB0aGUNCj4gbnVtYmVyIG9mIHF1ZXVlcyBh
c3NpZ25lZCB0byBlYWNoIGNwdSwgYW5kIHdlIHNlbGVjdCB0aGUgbGVhc3QgdXNlZCBjcHUNCj4g
YmFzZWQgb24gdGhlIG1xX21hcCBhbmQgdGhlIHBlci1jcHUgY291bnRlcnMsIGFuZCBhc3NpZ24g
aXQgYXMgdGhlIHF1ZXVlDQo+IGlvX2NwdS4NCj4NCj4gVGhlIGJlaGF2aW9yIGZvciBhIHNpbmds
ZSBjb250cm9sbGVyIGlzIHNsaWdodGx5IG9wdGltaXplZCBieSBzZWxlY3RpbmcNCj4gYmV0dGVy
IGNwdSBjYW5kaWRhdGVzIGJ5IGNvbnN1bHRpbmcgd2l0aCB0aGUgbXFfbWFwLCBhbmQgbXVsdGlw
bGUNCj4gY29udHJvbGxlcnMgYXJlIHNwcmVhZGluZyBxdWV1ZXMgYW1vbmcgY3B1IGNvcmVzIG11
Y2ggYmV0dGVyLCByZXN1bHRpbmcNCj4gaW4gbG93ZXIgYXZlcmFnZSBjcHUgbG9hZCwgYW5kIGxl
c3MgbGlrZWxpaG9vZCB0byBoaXQgaG90c3BvdHMuDQo+DQo+IE5vdGUgdGhhdCB0aGUgYWNjb3Vu
dGluZyBpcyBub3QgMTAwJSBwZXJmZWN0LCBidXQgd2UgZG9uJ3QgbmVlZCB0byBiZSwNCj4gd2Un
cmUgc2ltcGx5IHB1dHRpbmcgb3VyIGJlc3QgZWZmb3J0IHRvIHNlbGVjdCB0aGUgYmVzdCBjYW5k
aWRhdGUgY3B1DQo+IGNvcmUgdGhhdCB3ZSBmaW5kIGF0IGFueSBnaXZlbiBwb2ludC4NCj4NCj4g
QW5vdGhlciBieXByb2R1Y3QgaXMgdGhhdCBldmVyeSBjb250cm9sbGVyIHJlc2V0L3JlY29ubmVj
dCBtYXkgY2hhbmdlDQo+IHRoZSBxdWV1ZXMgaW9fY3B1IG1hcHBpbmcsIGJhc2VkIG9uIHRoZSBj
dXJyZW50IExSVSBhY2NvdW50aW5nIHNjaGVtZS4NCj4NCj4gSGVyZSBpcyB0aGUgYmFzZWxpbmUg
cXVldWUgaW9fY3B1IGFzc2lnbm1lbnQgZm9yIDQgY29udHJvbGxlcnMsIDIgcXVldWVzDQo+IHBl
ciBjb250cm9sbGVyLCBhbmQgNCBjcHVzIG9uIHRoZSBob3N0Og0KPiBudm1lMTogcXVldWUgMDog
dXNpbmcgY3B1IDANCj4gbnZtZTE6IHF1ZXVlIDE6IHVzaW5nIGNwdSAxDQo+IG52bWUyOiBxdWV1
ZSAwOiB1c2luZyBjcHUgMA0KPiBudm1lMjogcXVldWUgMTogdXNpbmcgY3B1IDENCj4gbnZtZTM6
IHF1ZXVlIDA6IHVzaW5nIGNwdSAwDQo+IG52bWUzOiBxdWV1ZSAxOiB1c2luZyBjcHUgMQ0KPiBu
dm1lNDogcXVldWUgMDogdXNpbmcgY3B1IDANCj4gbnZtZTQ6IHF1ZXVlIDE6IHVzaW5nIGNwdSAx
DQo+DQo+IEFuZCB0aGlzIGlzIHRoZSBmaXhlZCBpb19jcHUgYXNzaWdubWVudDoNCj4gbnZtZTE6
IHF1ZXVlIDA6IHVzaW5nIGNwdSAwDQo+IG52bWUxOiBxdWV1ZSAxOiB1c2luZyBjcHUgMg0KPiBu
dm1lMjogcXVldWUgMDogdXNpbmcgY3B1IDENCj4gbnZtZTI6IHF1ZXVlIDE6IHVzaW5nIGNwdSAz
DQo+IG52bWUzOiBxdWV1ZSAwOiB1c2luZyBjcHUgMA0KPiBudm1lMzogcXVldWUgMTogdXNpbmcg
Y3B1IDINCj4gbnZtZTQ6IHF1ZXVlIDA6IHVzaW5nIGNwdSAxDQo+IG52bWU0OiBxdWV1ZSAxOiB1
c2luZyBjcHUgMw0KPg0KPiBGaXhlczogM2YyMzA0ZjhjNmQ2ICgibnZtZS10Y3A6IGFkZCBOVk1l
IG92ZXIgVENQIGhvc3QgZHJpdmVyIikNCj4gU3VnZ2VzdGVkLWJ5OiBIYW5uZXMgUmVpbmVja2U8
aGFyZUBrZXJuZWwub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJnPHNhZ2lAZ3Jp
bWJlcmcubWU+DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fy
bmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

