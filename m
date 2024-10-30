Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39F1D7494E
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 00:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MvOATNsTgqOXLR0Xh+RE4JxFgiTEMMpaaEkfZCmVXcI=; b=2JyaSvnQ0Xu46QVC6b0xo3rHug
	eI5tTD0xwFLVq+Wdh9MoU/QNAZlbp5zAmkFbN/Oy9A/rlJ6X7gjI0dfCPkyMFy0J+D2TgzKUrmy9f
	oQyIOazKtPR9eB074b5fHVja4lRwfEd2XKRorArZ3Y5aopUjDFMgu0u8cGfOJmBry8RWxkFO6oyc2
	ovwV35JCyf9M5GangXzjeRBu7u5nLt7LO8L51+Ra7b6/mjXHPOTqEj/HyzvgN7zm19nZhbXtrD4oL
	xQPIdb5oOvzBHbaaec3vWUkpzbOlr0kYR3nJMHH6NdeQ+OKfCiy/0rV03JxA76sQwgtBe5zyA1pKl
	mTugpk9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5wu1-0000000GN8P-2gqH;
	Wed, 30 Oct 2024 00:49:37 +0000
Received: from mail-dm6nam12on20611.outbound.protection.outlook.com ([2a01:111:f403:2417::611] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5wtx-0000000GN7w-3u5t
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 00:49:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMRNpw6dey3s4bj6K/SZzA53IgY+0JatUyqjbuMo9+GOG2XYh/s0f6e8MGas/eshEZQEV6uFRw5pkE8tA3PZ885f3a7b9DntvFb19q6mUPGB/4NSBo7TokA//eXCg56G52D3O0GQsWFMRDVjxB7wsmiaphYTaHU7Krdq43uY1PqNuHgDz8pzaGCx2PYQETbHQzilfSljQEL5HG+BWIXbd/uH+XLTK6LgYDcSRaId9IiFgjbWa9cFdl87KH9lWThf/FfgilxJzOvUxk+xtspGH7UV35Qy5+27GD/Ntcf6d4Lnb+1h5xB5Gv0Mz4aOqCchGN8UaVisVUWzdFvllhKDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvOATNsTgqOXLR0Xh+RE4JxFgiTEMMpaaEkfZCmVXcI=;
 b=qV1QpnPGbtsmWRHKhNHQwGTSQXv5ga+uQRwWmyGl3BMKeJ8xyyZH5YH62++ESCdeFHqLEaTaWq0V/PQg4DFKOov4c+92M9AoZP1soE0pUZG/NSmelJBuJt/KzYPUtjrbj5HjL+2tog3g934vlnm2292O/zw7LZOx1EZDI3/mh8E21y2x7m3pJCgVq8x4Ewd/C8rT8zf+H5YsTfoQFR9Xc/pBYdG6t3WdoumlJ6D63Bvv9bRAy7AbxWXXjs8R7Bp02Oa6K1pn1/Ri5kgjlFH4XANgWRw47P/EhbwyNBJyTiojmwxN0poRecVdXbwULlZOg3JLgDMIXRdxqjj2gRbnTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvOATNsTgqOXLR0Xh+RE4JxFgiTEMMpaaEkfZCmVXcI=;
 b=crtLCNZSPrIFoxA4tDWqG4tjzCLoeuFxvDFAgCZ2STUEVLA/5wiB/G8YxowGGKyohN0fyodFWMRJgMnyLSTQFP35t3+d0SWdHJp5SqIr+k9YiGn2y7LQ9CP5RLdt0pD4kq/SBh0/3Dm7A9nB2/HxFkj9BZrZ4RuXos0hsTsOxhWfOitkTxLLfaSAWl+XCwWlQyEXNNalidQVT+B3G49Emf/FR7JVAru0RO0cO8AIGLVapK2nzrpgaOhUqv95L6bvRl/CDPalIVLY+ELm5iaDy5ICm+zxxh39DBkYBHN6YAJ5189Z1wOW+1aqQW3I3RVeX4maUMQ4dghdclQc6zq7aA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB8178.namprd12.prod.outlook.com (2603:10b6:510:2b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 00:49:25 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 00:49:24 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: make nvmet_wq visible in sysfs
Thread-Topic: [PATCH] nvmet: make nvmet_wq visible in sysfs
Thread-Index: AQHbKaTLTwHNqlYqyUSj9qyQvVBFD7KdLMyAgAAcXoCAANuwgIAAUv0A
Date: Wed, 30 Oct 2024 00:49:24 +0000
Message-ID: <77e190c8-8fac-4548-b6c0-f6f21b434e30@nvidia.com>
References: <20241029014915.16646-1-kanie@linux.alibaba.com>
 <8b4591d7-f0bd-4e4c-b1b3-1b375f25bda0@nvidia.com>
 <0e90730a-74c0-401a-82bd-92fdbcd2cbe0@linux.alibaba.com>
 <1c6e0bfe-f476-4c07-a67c-b526b325b405@nvidia.com>
In-Reply-To: <1c6e0bfe-f476-4c07-a67c-b526b325b405@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB8178:EE_
x-ms-office365-filtering-correlation-id: d154cabf-5c18-475b-b826-08dcf87cb340
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WHhvY3R2MktBTzlnV2lEd2g5TVEyaWRVUFM0azNXczcxQmtqbWxXU2xDekxH?=
 =?utf-8?B?TmdYVnU4SDE3WGdxMGRUQURGdlBhcWY5amNXcFg5aGlLQTFKRnEwNFpUd2VX?=
 =?utf-8?B?YXplTlFGNTIyNDUvUmZYUGdXOTIrdjZNd0t5SjlLL1NsanB3ZkFoMGVTZ0c2?=
 =?utf-8?B?WG5TMS9oUk5vNkJRRDlKamV3RzREODVFUTd1M0FUdDREclh3ZWF3Q2FrWmpW?=
 =?utf-8?B?OUFXZWlDdysyVlByMDlBRm9BYjk3UXZ2bDdKSklnM3ovZjhZSlhYcDEwVEZx?=
 =?utf-8?B?WTRyNlJRL0ErSFVIU1lwMWNBQ2VPYURaVWhNenAwTEthdlJsZnVtQ1NFMHRs?=
 =?utf-8?B?SHphYmlRYVY1U3lRTHpjbjB2YllIZ045SUVoTnJQdkJJQUEyYUp4bjRSK1Vo?=
 =?utf-8?B?T0s3ZXpVWHlCdFE1emNaMmdmdzRCT3dkb0pZR2dTZkZUWVJ3VldyTXg2Vk9Y?=
 =?utf-8?B?eDEvMWZaL09FbEUzT2M2bU5PT2JpRFVaMGFqMVdDcHE5WTJhaVBqeWk0ZUli?=
 =?utf-8?B?b2M2a0lyQnN0RzhoNmZwYUltdUExT3FybVVETUQ1TFl4ekR2Z24rcmJmK2s5?=
 =?utf-8?B?SjArcmZubWtqZFZRc3dmOFh3YTJqOG9DVUNtTkl6M0tmVjdGclFPb0d6ZVBV?=
 =?utf-8?B?RHRNbU91SFRQQ1Yxb3ZXdjI4Tnk1bjZ1SXI2Q0RNSk1iWlcySXp4TGNRaTFI?=
 =?utf-8?B?WTB3TXJ5eWxqQ01paDRJaVZ0OXVyOG94dVB1VVJaK09IejltQUV1bFVEWTY1?=
 =?utf-8?B?Q0tTc1JSK1JtSXpCV0dZMC8xY2ZXWUlPRWpsSjBYN296NU9TMlk2OXZaZzRD?=
 =?utf-8?B?ZzdwSzlKNVk3OVNlRFBiME8wWlFIamYzSU12MEJVWCtkM3l3YjN0TGt4bXZB?=
 =?utf-8?B?UHVlREMvT2M5d09OT2dVUzJQVDQ0YWR0MFNaK0RRMndLWlFLaHVGdjFldDRo?=
 =?utf-8?B?NFZucTcyTU9yYVNaK2JEZmtaSmRVc29Bc3IzNGIxYmlPZ3B4MExsUzZpRG5m?=
 =?utf-8?B?Sjd6TG1CRzZJMENhaUt3K1pCT29qRHJnQS9jY3ZrbUl3b1Q2OCttZlgvVjlW?=
 =?utf-8?B?RmxXL3J1V3VkTFBSZmRJU1ErRTQ1VUpxY1k3ME5SNnhqTXRTdWl3VmdySzI0?=
 =?utf-8?B?M2I4OHR2ai9QbnFEd3N6aUZlekNmTlNMUHZUdGR6Zml5aTJFT3FLcmM5UkQ5?=
 =?utf-8?B?N3hKa3RIYkVkQUZFcHd6bWQyU0RtTDBzRUNldE1UcVVvYWNFN1Rla2pPWlU1?=
 =?utf-8?B?ZWw0ZEMwdE80SHFxV1hpdEo2ZEk2elR0c0ZmelQwdWZYU09GVkhucUoyMXVY?=
 =?utf-8?B?NWUyVWdZTGY5MkJOdWFTQkdpRis1b0QwVVVqcEZ5dS9SeVY2Uzk4VmUxdXVR?=
 =?utf-8?B?SXFCc0ZQRG9yYkFXTXppTGRyZjZJZTFHWGhlNUtiTG1oVGJaRnN4dEJPcjU1?=
 =?utf-8?B?SDF2Y2lvVWtqNHIzUWlYa05sSHVBdjlBUlZoUysySktPYklZdk1tbzNaajRE?=
 =?utf-8?B?Wm8wQVN0ZUdqeHRxbDUvS29hazVFYkZQa2tqQ2RMVUF0NU9zaWVBQ0h1N0tn?=
 =?utf-8?B?MVpXTUR4QkNTUG5LODZpdFdSMkVLQm4rZzFPOW5EaDZnYUlkdk9BRDhJZCtL?=
 =?utf-8?B?eXJlcFIyYzl2WVhjeHZnVVFEQ0FtckF0SUZSRWQzRG5XTTZydVBONFlBREli?=
 =?utf-8?B?Q29ZTlUyNHR5Y01QREdrcm9ncFlXei95VXZLQ2RCc1RIcUF3dDFCZkZaU2Zx?=
 =?utf-8?B?YXVDK0dtWW5UK2ZlQTlUOFp2WnNtcnUxM2pzTndNdGdlSWFqUFV5ZGFwWlhB?=
 =?utf-8?Q?p29c6e/yUW6EeuG89FsxOyoD5bBCP9PDjdRHo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGkwL0Z0RE1yRTB1bEpubG01UE1OdHNtUFJXcXRYeVphNFZSS1lseW1iV2g3?=
 =?utf-8?B?UWdzWXEybWg5eVVjeWVVV1JlU1krMHJzOE5UdG5FMWw3M29OVFJxcXY1Um1B?=
 =?utf-8?B?Q3BEU25wYjFJZklNSzcwaXJDQVM4YUFsbVRZb3F6M0R2Q0pMWnlNTXZUM3BH?=
 =?utf-8?B?eUxEK3FZdHE5RXlpcEJyS1BGSGxuakJtWm9IWmtWQllHMVZ3UHhjNHJqc2pn?=
 =?utf-8?B?d0RKbStYY0gwdVQ1SjNhUGhPUmllNWR0N01hc1NUTC9LbnJ1V1UzdDYrYUFY?=
 =?utf-8?B?UWpDbTVvSmRUM09jZEtMSzhXaXpkN2xFK0dwenlvbnl1aHE1SHNRclg3b1Zn?=
 =?utf-8?B?MmpVSE5NNkIwSHFUSC9ZL0NFaUl1SmRHMkE4NXA1d3NhSUhQbndGZUJ1cWF2?=
 =?utf-8?B?WDA2RFpFSEpmV2pvdG9uMVU1TVh4T0hNdkFDLzkyTFZaeU41clIyVGdsL2FX?=
 =?utf-8?B?OVYwQnlIaWN2OTF5R0Y4c1BzalpFZ2xRcGtQZUFOdDhXLzg1dXlQbjJzcC81?=
 =?utf-8?B?bENBQjMzQTZXb1JPK0dpak5uL2JVaFRLRlVwd0xCK0dpNEt0eVNGY3pnR1lz?=
 =?utf-8?B?Q0d2YnBIS3hNT0x5aXZNVVBxeGxQWUMzUHBQajVkRVZXQnVVRXg3U1M4Smda?=
 =?utf-8?B?c0pkY2M4eUZWTUlFc0VKaXJObVVxcnp2bHF3SldEdmkvMTZHOE5CS2hSZGox?=
 =?utf-8?B?KytiMTlvY0tYdTFIUnkvcE9xbW9QLzNwQ2FHaENYTEVXQy9GQzRZa0N1SFU4?=
 =?utf-8?B?WXhPWFB5NnlhaHl4bXdqbTJFYXZoRzlwL1hqclpZWXRpUUtYYjJ6TzFQNFVO?=
 =?utf-8?B?TWljSE5tcFZkNk5ZMklIUXlJU0FCVlhwN3dIR3JzS1pxMWk3b2VUQUo2T2Rm?=
 =?utf-8?B?TUgzT0lBSEJGNUgwV1JpU0tmaUdPRllsa1o5SG0rQm1WUzNTU1B0WUdxMCtF?=
 =?utf-8?B?NnJaZmI0Qyt0TEthN1YwWndnUkE0MDdMa3I4dXpQdUtZdmx1a1hxRG9hbi9s?=
 =?utf-8?B?djdGRTlBZDFERi9NU0tTRG5IcldabnAzZzlyUVc3a2pJVS82VnU1TG4xM28r?=
 =?utf-8?B?ZDdYNHNySHg5bWh4eXBWM3ZFd2E5ZjF1amhlWU9LR2V1Yi82RlpxMVNBYTUx?=
 =?utf-8?B?VjRZRyttWmRRR1QwU1oyMDRlZkJ5eDNGMmQxK3RvVWl5Nkg2MldwNkZNbXc3?=
 =?utf-8?B?Yk5LWUZYdjVpbXVSS3FzZzdZMUFaYit4NHhYVjdyb3FocDRTcGRqS0lNeG9D?=
 =?utf-8?B?NTB2ZW9nTndNaWp3U2VXaGtlcWJGVGdYSEdnbHB2WXRmL1NHVWVyOGxhVFg4?=
 =?utf-8?B?ZUJuUWpRcXdWWkVnYUFBcFIvUXdxUVpKSlI3LzcrUEVwNFNTZ091WDBwc0ZU?=
 =?utf-8?B?L2J0b3V0U281aVFONW1qaVVlSnRHcXFqenFDOHczallZOWYxSHdqbUVEUWJY?=
 =?utf-8?B?NTVxcjFCek10d0tTSHVCYTl0bFp4bGpLeEoyMmpxTU55Kzk4VFg4YTV5cStv?=
 =?utf-8?B?WjFHZXZkSkFzQmdIUlIxRGhGTm5LV3pvbDJVQjQ4Q001WDdFdyt5bUk3U0RM?=
 =?utf-8?B?M2pWckVmNGtRSzlaZkEvNkhpQzRvSWhDVGVjVm9vczZKZ2RoYXdsaW9FL3Nm?=
 =?utf-8?B?dFk1ams1T2xvSCtxWkhuWTJGT0Rob0k2NjdMaWRBcjU5WHEwNlE0ZlBxQlI3?=
 =?utf-8?B?TXQzZVNKdSt0U3pvSXV5d3VPd1VBLzRRdE5HSUYza1phRzRPdmdhbnd3L3pu?=
 =?utf-8?B?OUpuUE5oWTNmeTlLempGanpTWVg2NFIrQ2tBcmx0Sk9mUzVDMEl4Y1kxb251?=
 =?utf-8?B?UnN0WnVpb1VwRFFjWGtxMUlKNm56b2dEZHZhY2hSWU1QUVJVb2RDbnZ1cWhC?=
 =?utf-8?B?MTR1bEU2QWw3MThlOGdPS1lkSTVCakF5Vk1aK3lOK080c1B1K015dzJ5cmpE?=
 =?utf-8?B?RE90QVN1WnRJWStZUEFDTTRPVUxxS25CSGFoN2VxN0tSRXRVai9NNU9GY0lo?=
 =?utf-8?B?Z3VzWlUvak9ndG1icDVLMXJJZm13TlA3bUd0NkJUblB4V1ZpcVRHK0hnTk83?=
 =?utf-8?B?U1JHeWU5ZEdlZmxnb0VteVhaTUExeVNtQVA5elNjQU10YWlUcFFIdE5SV1Nz?=
 =?utf-8?Q?uTkkbeUxvSynknNn/MazFSJJT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D894EDEAD7653B459AAF64E5747A4FCA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d154cabf-5c18-475b-b826-08dcf87cb340
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 00:49:24.6246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lgh3Yei8wcJFK9xdomS3n5M9cuRqhuzrw8UI5/WcyQYLEk85mCQLQadZBuD5btx3Izogg7z44rrEenffy4ze9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8178
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_174933_997914_F5E2EFD0 
X-CRM114-Status: GOOD (  15.44  )
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

T24gMTAvMjkvMjQgMTI6NTIsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4gT24gMTAvMjgv
MjQgMjM6NDYsIEd1aXhpbiBMaXUgd3JvdGU6DQo+PiDlnKggMjAyNC8xMC8yOSAxMzowNCwgQ2hh
aXRhbnlhIEt1bGthcm5pIOWGmemBkzoNCj4+PiBPbiAxMC8yOC8yNCAxODo0OSwgR3VpeGluIExp
dSB3cm90ZToNCj4+Pj4gTWFrZSBudm1ldF93cSB2aXNpYmxlIGluIHN5c2ZzLCBhbGxvd2luZyBm
b3IgdHVuaW5nIHRoZSBpdCdzIGF0dHINCj4+Pj4gdGhyb3VnaCBzeXNmcy4NCj4+Pj4NCj4+Pj4g
U2lnbmVkLW9mZi1ieTogR3VpeGluIExpdTxrYW5pZUBsaW51eC5hbGliYWJhLmNvbT4NCj4+Pj4g
LS0tDQo+Pj4gZG8geW91IGhhcHBlbmVkIGhhdmUgYSB1c2VjYXNlIGZvciB0aGlzPw0KPj4+DQo+
Pj4gLWNrDQo+PiBTb21ldGltZXMsIGluIG9yZGVyIHRvIHJlc3BvbmQgcHJvbXB0bHkgdG8gY2Vy
dGFpbiBldmVudHMgb3INCj4+DQo+PiBtYW5hZ2UgY29tbWFuZHMsIHdlIG5lZWQgdG8gcmVzZXJ2
ZSByZXNvdXJjZXMgYW5kIHBhcnRpdGlvbg0KPj4NCj4+IHRoZSBDUFUgY29yZXMuIEZvciBleGFt
cGxlLCBpZiB0aGVyZSBhcmUgNCBjb3JlcyBhdmFpbGFibGUsDQo+Pg0KPj4gd2UgY2FuIGluaXRp
YWxseSBhbGxvY2F0ZSB0aGVtIGJ5IGRlZGljYXRpbmcgb25lIGNvcmUgZm9yDQo+Pg0KPj4gbWFu
YWdlbWVudCB3aGlsZSB0aGUgcmVtYWluaW5nIDMgY29yZXMgYXJlIHNwZWNpZmljYWxseSBmb3Ig
aGFuZGxpbmcgSU8uDQo+Pg0KPj4gQmVzdCBSZWdhcmRzLA0KPj4NCj4+IEd1aXhpbiBMaXUNCj4+
DQo+IEknbSBhd2FyZSBvZiBleHBvc2luZyB0dW5hYmxlcyB0aHJvdWdoIHN5c2ZzIGFuZCBpdCdz
IGJlbmVmaXRzLCBteSBxdWVzdGlvbg0KPiB3YXMgZG8geW91IGhhdmUgYSBzZXR1cCB3aGVyZSB0
aGlzIHNldHRpbmcgaXMgbmVlZGVkIGN1cnJlbnRseSA/DQo+DQo+IEkndmUgYWx3YXlzIGJlZW4g
YXNrZWQgdG8gZm9yIHRoZSB1c2VjYXNlIG9uIGEgcGF0Y2ggd2hlbiB3ZSBleHBvc2UNCj4gc29t
ZXRoaW5nDQo+IG91dCBvZiBrZXJuZWwgdGhhdCBpcyBzb2x2aW5nIHRoZSBwcm9ibGVtIGluIHRo
ZSBkZXBsb3ltZW50IC4uLg0KPg0KPiAtY2sNCj4NCj4NCg0KSWYgb3RoZXJzIGFyZSBva2F5IHRo
ZW4gOi0NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8
a2NoQG52aWRpYS5jb20+DQoNCi1jaw0K

