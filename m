Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E478E77173
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 07:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GeWgdQ3CZtCvhjln9ZKvGc1HWW3nMcSaMoDfgU2SCxY=; b=aN4NhLJcBoADRTPgRdkMqLmaB8
	s1GKQZP+pWVYEwCt4EV1QTLwLXTlL9N1+YtCvl5DDeApu/kOtYi2ufM/MNFvaS9jzSQSuPLpAz1BW
	YCJYdC2c5yDr0EUVVNnJbJPS97bAbsDZc4hemyr2eXmVUw8i+qiaxUMQUtBCGI3Qkgn2JnL8E8vJ3
	KToE1Z/Fs6XD3SVkNKTeWpVU9RNt0aHx73R8WmbD17kC2mn0SJqv4YZTi/EdzLhsdpxS3RoVA3pD3
	Tp3Lf8honAxtmOf9+oM5eCkv274nT36g/ZyjjJYMDSkQCzeFMB9eELW8sbldxdQAIe9FiZZVrXPiT
	wd4QF39w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKY1o-00000006geZ-3jr3;
	Mon, 09 Dec 2024 07:18:00 +0000
Received: from mail-sn1nam02on2060e.outbound.protection.outlook.com ([2a01:111:f403:2406::60e] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKY1l-00000006gdQ-2G5W
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 07:17:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDsEgUbHBMmM4W42O+Cv5QAtBTpsV+h1OxK4Uy6sX5pxXj4Ojy6WDT+dUxdSi+llqWNpHXQLbYX+k3DGEkvoQ0LUiR36idQ2bX7iN30Jjt5QiZfIr/R7qGQbqTZEIimC/IE1qQHNZyvbTmEJ5V2ruCvfI8bWjlpjQqPDeuZ25Vl9NbihNnlW1XSLw+J7gcOchhJzw0DwceqHTbuw1uk4geLU9kN03yroZLQiLkEuVDAOcjItnCKI5vau02gwOPr04Icy00hmP6W3HN3AFsmf0tbOe/iVw41SRuIqSQSNJrtTNBgWGX0bup5Usq6sDtB3qJztHM6s79hGKGfUmMNDAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeWgdQ3CZtCvhjln9ZKvGc1HWW3nMcSaMoDfgU2SCxY=;
 b=mpMzA+6l+70mitSBAxz3bxV1FGl3ojENeCqawbGO8NmBM/Z2LR538727F8AEkzm3SbCu7f0hAl2zT+jYPysu9f2V+dEUN5TukJg3Yf0vX0nBZnlcWcSbArJeuYgubaPBtQ4Szza6rCumtpBS1D/2dCcY+U3984TskZYLKrWuDKjBAgNhYRQ9mcjo5AHf9UjgB0TKk+ao8qH+n3LYR/asp4+RhvXPW0hGvDNTqXzGgxjQJ2hta2esJi9BZeUd1okKiXVewjyKFt9679lIGIhEWA4dmLhKydyhFP53go0z/s54WTQxvPh5ysfK8U5JqsB9HwfpZlvE3AXeLRPMwuKDdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeWgdQ3CZtCvhjln9ZKvGc1HWW3nMcSaMoDfgU2SCxY=;
 b=dgtDZ6M46OCTpFKwh6AH4mlA9vpU0HY9TWuJHsQa6leZ2HtZRzKnPSTPDowad9ndm/yDI6AwCjFMqOfR+2ZqeBMCnJ+13yI18W/Vm4sEuhkEDMglE8wXUMPscbzm6eDRPiMWoz9St44EIX/+tbI43AAENB29IcJieufRUYIKzgYAcROI7rcpFwDLAlKtq5UDvUdfFYdnIhKo7inm3mPjTEW/j2kxy0gJjsDPL5OFZFxlIhAN1ty2VuRP1sEQd3KZHzrm0ozoLSZ9hkdAhPp9dyckDkmSNfS+keM2Hk786unRcCSRkrtAwM91FvT0NFc3VfMZFbv5WJbNKQbj4/iBGg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH2PR12MB4328.namprd12.prod.outlook.com (2603:10b6:610:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 07:17:52 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 07:17:52 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Baruch Siach <baruch@tkos.co.il>, Keith Busch <kbusch@kernel.org>, Jens
 Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-pci: fix comment typo
Thread-Topic: [PATCH] nvme-pci: fix comment typo
Thread-Index: AQHbSWVFPiVlLYIVGEiRJKWXzG+JXLLdgiAA
Date: Mon, 9 Dec 2024 07:17:52 +0000
Message-ID: <697127b5-5ded-4528-bc4e-bdad95f110b9@nvidia.com>
References: <6460798716383804d15e987b0c218bf9969b33d2.1733657672.git.baruch@tkos.co.il>
In-Reply-To: <6460798716383804d15e987b0c218bf9969b33d2.1733657672.git.baruch@tkos.co.il>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH2PR12MB4328:EE_
x-ms-office365-filtering-correlation-id: 43073deb-7085-4f13-98c4-08dd1821986e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZkR4dDZYUE5aR0JreEtMblA0YmV3R2RUM2dDR2Q3MHBQTlpKdjRxVWI3YUxJ?=
 =?utf-8?B?bktBenRycEJYT2wxYnNXU3dxMW5McSs0K1lTeThlREIvSTFMQ0pDTUFGTW43?=
 =?utf-8?B?eitWOStUMVRySnpHQ0s3NERQZEJzMjVvQXU5SHJLQkRrYnA5cUJlWEJVeXJu?=
 =?utf-8?B?VWwyVkk1SU9DNVdjRG5nRHhuQzBqSFJHMmFJK3ZYblVpbWNiY0R4ajAxZktX?=
 =?utf-8?B?UHZ2YkdpcVZFREhZYzB2L2s4dFc2RWQwT3FRNWRhMGNhektVUE01ZXlJdG91?=
 =?utf-8?B?UXpXOUhPMGthZ3k1dG5wenVBWDM0ZzEvZjEwK2lFRDcyTXcrc0JvK3BrcmUw?=
 =?utf-8?B?Q3ZBdis5a09vbmRheUltWjgzUnlyU3VMYTc1aGhPZnY4T1Nvb2cxRW5wL0NJ?=
 =?utf-8?B?bjYra3o2dnZDejY5dThVSTlwd2I2dXhidVVuaVFhU01UTVRHdjhENlVuNHFP?=
 =?utf-8?B?YXkrZHdQTTZnUzIzV2FLb1VlMy92WG9iT0dKU1dGazV1aXVlM3NnNFAwaDRK?=
 =?utf-8?B?R1NOd2JUTzNCL0tuMEU0VWxUQ1N4aGQ0a1Q4RzJFczMrNW1ObTl1V2c1TzhQ?=
 =?utf-8?B?NnczT3VnTWhqUFpMdHhEQUJvZWt5ZkduRFEvL1J0b2Q5aGNmZENkbDVNdk9G?=
 =?utf-8?B?TmtDbVM0cHlYayswZzcrUk4zam1lQXJLTWFVL0RVa0hmb3hJenpNTzI4V25Q?=
 =?utf-8?B?NFd0cXI3QnZtcHBOK1I2aW9DT2JmM1U4L3ljV3JuZGhhVUU3N0hFVW96bmhV?=
 =?utf-8?B?NjZBS0dtVEp3bzBFU0ZCbmh0S1ZNQ2RaQlgrSEYyWWlRUzhmc1Y3K3R5ck96?=
 =?utf-8?B?dDV0RnU5T0JnVHRFeE1IRGxmeEduMFgzV3Izc3R5WXNFci81amdobEhZNldV?=
 =?utf-8?B?eWkyN0tiTkFRc2dnaVMxUVhBcm5Zb0xOQTd4VFNndXdlOW41TEtEd2VZeDJM?=
 =?utf-8?B?THZ0TVg5aDh4bE5OMmlwenU2QmdUUGxVZ1lKa25Id0FtSTFEcGNDOVRrMk85?=
 =?utf-8?B?QzRGUXJKRUx1Z0dzS0hRUEM0UFNTMy9nL2p5V3FIQmhHVnhjWkhJY2MwVmJn?=
 =?utf-8?B?K1ZyR3o0bGFrQ0xma0cwMUFqdGVhT29jRmxYZ090NTNXRFFhL2tzR0pJbkVN?=
 =?utf-8?B?YXkzMkptbnFiVzYrdXpzY0pzV2piZk40dnpqUjZXUGEwZk9BT1lHR2xWSVN5?=
 =?utf-8?B?YjJlcHV1c284YjZTdjZiTWZKdlAyNHlkWGpqbWlIdzJEN3hDbnZXaUNQUjNs?=
 =?utf-8?B?Wmw5c0xkcjcvNHN2RWlGQml6NEtmT095WVhnRlUyZnlGWFlUeXRUaGNUbFpP?=
 =?utf-8?B?UU9SM3drSnhTTnVYZHkyZ0FiVDU0NlJ5eUhSVkFEems3ank2RUQza2pGeEtr?=
 =?utf-8?B?b2llcWxUS1dFZ0dqRFZBKzFXdkpUWVk3Sk5CajhFRTBEaHZ2TlpWcTREK2Q5?=
 =?utf-8?B?NTdTZ082VHQyRlNKTE1NS2c0MytFZXROY2o2ZnRWS2gzR3NMMVN0TFdsR0pC?=
 =?utf-8?B?VExReVV4SjBWL1NxcmRFdFQ0dDFKTXBTcDY5OU1kdWVMRXpZOERReS94ajlh?=
 =?utf-8?B?b2x0OUV4VjF3dFdPODBtUWVKa3oxZHpjT01rZ3BtZm9Hei9xNG5laGMyUDNo?=
 =?utf-8?B?dk1hWHY1aWF3V1ZNZXVxWnRNVmFEUzlKdjZkMmFWUXNIZS9abEtYSDFDMzVm?=
 =?utf-8?B?aGZxWlRYaktQc2lHbkZzUUNLODl6ckRiU0tad3ZHSGU0TkN6enJNNUpVNTQr?=
 =?utf-8?B?QTdkTFBJVXc3Q2g2L2ZrQ0pHR0xwYjhIdTgxM1FaWm5ER0dGdW56ZFZLRE43?=
 =?utf-8?B?cTJDTm1FYURHSUxRVkg3N0FFL2EvdHMzb0p3eEdxZ3dwL0s5a2F6WEZMQW92?=
 =?utf-8?B?VS80S3hrVTAyZ01KWEI5YktPdmZMZFVaVVpzMGVwUGp2b1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3BjY29EcWhBQWhxWTZVZGRiTjhjS1lGOVJyeThhWjgvY3U2MzlMWFg3TFQy?=
 =?utf-8?B?OGxDbHdTVERMOEcxand0ZTFsZTZRRXJsUmhBZXp6TjVlM0paQmxJQ1R2WHNi?=
 =?utf-8?B?ZS9lUG44aHlCRkNMSldMdmFzZ1ljQWRmejIwczB3Zm1UR2U1eWdvZVpueFZR?=
 =?utf-8?B?RUVCS2VEN0FUbVgwekxxenBDQ1hjNUhqeEdIU2RYcVAzRkpwWmxYRkFZNDhq?=
 =?utf-8?B?dkxrdms0ajVXZ2VGQ0dqRWVqSFhwS3NSL3dCN3NEVVgyN3pwWWZ1NWpwZVZL?=
 =?utf-8?B?SUQ4NFFVNHFiWGJBOVlTcnZYcFJWekZBTjR6T0ZoTVN3TWFVdUVzQWRZNkho?=
 =?utf-8?B?aEp5MTI0V3dFYXhOVHNVbFc3QVB0ZXZkcmVqQXdEL2ltc00yZU81TlZScVJ6?=
 =?utf-8?B?cUZYMkhTZ08yaFpMZ2cwNDNuZnpWWWpZMXQvL3A3V1JDam1qbHNPMGVaMVZE?=
 =?utf-8?B?T0k1WVl5OWNNZ3c5UGdVNTlTMitydjFycE5sbklTR2svcVhoeGM5SEgxdDRm?=
 =?utf-8?B?MEJoYk9YR3IzdVNKaHROMDRDNEJ5MWM3T3RVM29VUzB2V1NKODVaWWhGQnBJ?=
 =?utf-8?B?RGFtQy9zRGs4VjdwUDNBeGhnU2U2RDR3ZDNsWm1zT1AwcTlaY3VsOUxPWW9E?=
 =?utf-8?B?dU02S0Zma0d1WTBPaTBZL0NYWTlmNjByMUt6czVwbkhuZjQ2Y05HRVFNTWVo?=
 =?utf-8?B?cHViWjcyMGdvd2VyOTFIQnpaSXZQblJKci9pNTFXSUdGbGhOZmJyc04zaUVV?=
 =?utf-8?B?dFB3bTg2TFJ0SmdNc3JFZitHajlmSU82Z211WUg1OWVPZ1d3VXl5MHBJTTY4?=
 =?utf-8?B?OXNWTTNaVmZxWk13WUxXQ3FYRUZvZ3k3RmY1UmRhYUJ2OVdDTHpFNXgwNTdh?=
 =?utf-8?B?Vmk2SkxGb0FmUEFZckxicDFFNHNzRjdEUVZZVlF0VnZwdEI0MGxVeG15YXM2?=
 =?utf-8?B?YWNKbW9mUlhBRkNobmQ2bS9pQTFVSHdMNXJnN0FwTkpoaG5SS1Y1WWhQbG5H?=
 =?utf-8?B?dlo4VzlYenZlRUdlNFlseHIzTXVxeE9PeTBZK2J3aHFtaDZRRFF3OSt0QUxj?=
 =?utf-8?B?bzNrRjE1K3ludHUvYmdSMTI3Kzh2cHIxL3RmQ3dtM011WkZKczdLUm9PNkhj?=
 =?utf-8?B?NVhjckQ1Q3dJU3JTYU9rWm8xZTduQzRUa2FTY1VxK2ZjTWtQTk9UZU9SNjNY?=
 =?utf-8?B?SUlYQUNFZXd2S2dWVnRpeDRvS3hXQXZVY09rRmFxRURHcEZTUG1XMmFPOExS?=
 =?utf-8?B?KzJQbjBBRGgxK2JlNFBLNnd3MzFsQXpLVVA4Myt2MlcyRGJVR0RscFQ2Z1BP?=
 =?utf-8?B?THdyTFEvcVJxM0cybUQvKytyckErVFloMStQbnExUi94WlNxZFFMSHFvNXpS?=
 =?utf-8?B?OHphVEpNZUVIcml2OHhndHkxeWN1T1Q0dldVcG1tNVpZaTFTc3o3RHFmK3JP?=
 =?utf-8?B?UktQcXpNaDBENDdERnFpcDBRYTZKYnlGMm9NTGFGdHpHdktvUXpQMWVmR2hh?=
 =?utf-8?B?a3dxQjc1QUsyM1pQMXY2ZCthNGtPa25CQ25YOHFKN05NWHUzQzgxR1NhTVZ4?=
 =?utf-8?B?VldzNjlFK3c1UXRYd1FicGFzSzVKZE5Xd0ZVWkpXaFU0ZFl0cWxoVFZmLy9h?=
 =?utf-8?B?OFN5UGhaZm5Ud0NWbzZvY1JzL0dlWDIycnBTS2Q5eE5NZGMzUHNJTURVR2Fm?=
 =?utf-8?B?a25Nd0MvdFlKLy9HbzZtOWtUMzdQY1YwUFNHUnBLWEkvODNlUTVPUlVZWE9n?=
 =?utf-8?B?UWcxM0E5K2pZVlNUUWpWakNYdXhaTkFzTUtjTFNWMmNqaTRmcm42VzdCelRh?=
 =?utf-8?B?M3ovUXlZTm5NU1pITUdzZU1GdE5YM3UvRk4zQUtvemRONTBWZDNaM1RKUW9o?=
 =?utf-8?B?RUd2OW5xZjlMMTE5WXZYUEcwMDZZb0QrQUhmVFdOaUJwYUZGMHhMTnAwazhF?=
 =?utf-8?B?R2o2UnRVYVJDeTRVZ2JEV2tZQUlPTVNuYkswaklQQmJNR2Y5VUExMFVTd2tU?=
 =?utf-8?B?VmZoSyt4UzJMZWdEa3B6ajJwN0x4bHhYQ0dWV01tam55d05PaGJRbU9kMDl0?=
 =?utf-8?B?UGhSV2pKb244em1HbkcxMUt2NWlzaUttUkR4UkVVa2U0WDlweitjVDh4ZUov?=
 =?utf-8?B?dkNrd1pxek9ScnA3UGZMOWdpQW9uTmJHbkg2MlhRUDBnVG5QNGFCc3NEUWZW?=
 =?utf-8?Q?RSmszo/O6QcCg9kX067DqfybX8YHIw1erhU6nLvtwTp2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65CCA81EBA25EF4985D8B16746D34E59@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43073deb-7085-4f13-98c4-08dd1821986e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 07:17:52.6324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rX1j3zLLd9q82zYhRMkVqFihUTDAAO0Eodtydkhg3g679srrJcSwx8JCgg2xYCWz7LQIRQmwk8oe6t2n9Tjjhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4328
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241208_231757_575205_053C8B82 
X-CRM114-Status: UNSURE (   7.49  )
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

T24gMTIvOC8yNCAwMzozNCwgQmFydWNoIFNpYWNoIHdyb3RlOg0KPiBlbnZlbnQgLT4gZXZlbnQu
DQo+DQo+IFNpZ25lZC1vZmYtYnk6IEJhcnVjaCBTaWFjaDxiYXJ1Y2hAdGtvcy5jby5pbD4NCg0K
TG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRp
YS5jb20+DQoNCg==

