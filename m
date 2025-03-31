Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD733C36016
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Mar 2025 21:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h5tQNQGS2hQV/v1fLxsWT+fJU02aH48mVWv2UB3+puo=; b=13TOKbKJ3Q+47WyDp/p7cN2LZS
	423w3L81QvG0keUqW337V3KAlBatvP27z6tbMTHf21PPfqiP4DlP9tAHq96H3tXMgRk9mwF5r5Gfp
	ELfszeRMRi9w39M0/I0yr34hiHs2E15pKZOJmrYeXrAHrUGf7S5roZmpAKyfHrzF9reXxbujuE+MO
	mLAFUffiPaKL4qzT+zl0T/oMLeCuRGbOwDfrI/ynR2wUsE9W1gYgMustlgFCRrtQ+3vRCP4iL3z48
	KbSIu0eioe4gvg36cXiPEySpj5/Aa4+8FaQxaIE38wf7r0OOdgOddsYd90QJJSkYB6ni2e1Ho9AIo
	Rs27h++Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzMV8-00000001Oig-14CE;
	Mon, 31 Mar 2025 21:16:58 +0000
Received: from mail-bn7nam10on20613.outbound.protection.outlook.com ([2a01:111:f403:2009::613] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzMV6-00000001OhN-0qkM
	for linux-nvme@lists.infradead.org;
	Mon, 31 Mar 2025 21:16:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRMF+62pxhxEf6x/CYehzxdfvz3AcExzjHy34UPtHicHqBtlXCsKm0M03siIHwAJTp9njgkCMJL1Iwyk4/D2GOSJC0t5MVdV/Hge5MnvgwuNBaQ+dYT9hYMXT+YmBIvAUeqlhPqRLUVkKW98z0jxqvunYmdKT1c2wejUL8LjIzTlgyEPyqQQfA2PQPSqNSTtItuFoCUCwqD/j1JzPSrL1FNKMUYpbNFzWRLRWiLNLGj5FVHp6ijec+VN/7yEKkDVvaYUX1KbBIoiIkX6ENJNoJ5ZfG//jAK0YaaQyE/aY7952x/OXodneIuW/B/4LKeOTa4W6czhvMUoX2ze40di9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5tQNQGS2hQV/v1fLxsWT+fJU02aH48mVWv2UB3+puo=;
 b=JnUsIrx8tNaNExzQ8LbUdRsNayUretvQaeDJlhFJscowORQF/ifhn6Kw/hqqwrQ+wF/1T6ccsV/l+FW0JNOFecvkU6PsUVF2pXhBLonr3UvrOyy1mDj0+iOFBUha8LK1XnOkn08E133NwTBLN3PMqL+5/AloZK21dJAlI2SRfJtwECNMJ96RzlCUofCVi1QjRR7yjAEdzhNqPbM256RBi8qLhNE+Y37XE9SSquPVKCBB5xIPnjdSzafZ29u3cWBHESAFgdV89TJ63jFlEVnKG/76Uwk09DgApTO2v8UE6JZBedWSUggLtka3ASIA/w6fDYSG3gSn1VAIvoahzh7SNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5tQNQGS2hQV/v1fLxsWT+fJU02aH48mVWv2UB3+puo=;
 b=Zc6wUCigS3YwYEEzQD1Biq+zE9k/EOMgaDW5VX4E76lHWmXf3+1kOSXEHBl8IchEZCOkgzanr2T2GCy5N7X95386LmMk4TxE13ytgee6Q3GVqvNMfnc4KConQFnL/IsFV7T9IoMCPSjOkAmJEzs3053qsQYy7Lw438qEUavwfSLW9d3QdJ8Np7eWM2M6WquhGqs73A3s43XJSZ3+ggODS2aJuqSZALINPuHTacAgSuIw09GzDJHTrMqhVpavao1RtnaeYC2aiko2a9dqEGVpiuEZg+hEG7AKjOzhDW1rgB8mlrBAcTcvCx4GFwY6qMD9IkgntixQTBs5oJaq/W9J+w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB5653.namprd12.prod.outlook.com (2603:10b6:510:132::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 21:16:51 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8534.048; Mon, 31 Mar 2025
 21:16:49 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "wagi@kernel.org" <wagi@kernel.org>,
	"hch@lst.de" <hch@lst.de>, "dwagner@suse.de" <dwagner@suse.de>, Nilay Shroff
	<nilay@linux.ibm.com>
Subject: Re: [PATCH] nvme-cli: attach ns to local controller if none specified
Thread-Topic: [PATCH] nvme-cli: attach ns to local controller if none
 specified
Thread-Index: AQHbonI1MZWmeNQX40W9q2pTBv84TbONtI0AgAAFgICAAAV8gA==
Date: Mon, 31 Mar 2025 21:16:49 +0000
Message-ID: <2fbd6fdd-7977-4499-9539-3d1290506b48@nvidia.com>
References: <20250331190843.2431830-1-kbusch@meta.com>
 <f6567009-341e-44d4-94fd-feb92526d80d@nvidia.com>
 <Z-sBp3YQp60oS-e9@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Z-sBp3YQp60oS-e9@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB5653:EE_
x-ms-office365-filtering-correlation-id: 542aebbb-0fc3-4d93-2079-08dd709959cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VUtiTzIzMEl6ejl4V2pJZWlLSnlDY09FVnBwS0F4OE1mb1VNYzllUEJCaWli?=
 =?utf-8?B?U1c0OVFDN3VWZzJKTXc5SklLUktCMDI0WjNLUVk4bmR4UXB1eGJvNjRTUWxw?=
 =?utf-8?B?NFRnbjV3MVpES25oRTdNcmt3VW5qc05CTDcraEdRS0RvK0hsd2tUenV2bWNO?=
 =?utf-8?B?Qk5TcEFhbnhIUSswOW5EellJM3BYRmJWVG5acDlsd29rb3NNSVNxOTRKdjY4?=
 =?utf-8?B?cU1vQmI4UU51RHNjTFF4KzJmL3BVYnpwSEpIK3pOUDlRd2QySzhYRlExNi9D?=
 =?utf-8?B?SnJ3Z3ZEcGQ4L2tUb0R0SnVvUjFDT2d3Wm9JbXc1Q2VGTDFheUp3cStEaytl?=
 =?utf-8?B?Q1k2T21IUDhvcEZrSzIyRkpkclZBTzZhczJXZHArWXVkM0xUMFh6cnRMbnly?=
 =?utf-8?B?bTlTQnp5Yyt4eWVnSnhNNHVYazIrWUhCZ2g2Y2Y4NTI0di85NWFlWUYraVU2?=
 =?utf-8?B?TmFDTVhXanp4eTdyQ2dCS3JXaWpRTmRVUFZpSnVvd2V6VEdwbEtDWFdVZGFC?=
 =?utf-8?B?bUlobzNFa0thejBjbzI2OTNGSWhoTDZrSDlCZmkwSWFqK1VFM0g4QmdWSkM5?=
 =?utf-8?B?T1pjSDIwaS9uWHdnaUt1VEsybHB4YzlmUU9GZ0Y2TUJHOUx1c3VHR2MwU3ds?=
 =?utf-8?B?aVovVXlqZzU4Mk9peGZxOWFNMEtmdDhWeldpM1YzaGRseWVqdkc5SHJab3Zn?=
 =?utf-8?B?dkxkR3lmQWk0cDBGTUJQUmU0dXl3MmNvcUgzbDJic3B1RzM5MmxudWtycTZQ?=
 =?utf-8?B?VjFwZDFYM2FFVXFrRFZGY0k5cXVTc081Z2JYOHpqaCtWR3E4YWVEZWxMNS9s?=
 =?utf-8?B?blB6Q1duTzZnb0VTalIxb3phZWp1c0tPcEdGZ0ZDSGFmSERFd2l0d2cxZGZ0?=
 =?utf-8?B?d2dvc0NnVU00ai9jdFhodlVlc0JlajZTR0s3bFcvRHc4aktOaUFMYWtxekJx?=
 =?utf-8?B?K1pBVjRCMHpVeXNoR3Y2NmdFQ0pyeXdCdWhrQVgyUnI2YXBWMDR5cFh2NnNH?=
 =?utf-8?B?WGthMHBPTkFnUzIrdkFObjFjdEpRVE51SkhybFhlbTYrUTFmUWVYOWFJZlNr?=
 =?utf-8?B?MFNzbDY4aGJ2VXh4RlhqQWpkUHljQUJSaFVpTEg4WEVyKzdMenpraUlkdnRY?=
 =?utf-8?B?ajJrUTBDZ3hUR3hrRzdBeXdqZlhNL3dPU2NLcEIwRVVaeXpkcjNpSlU3Z3dm?=
 =?utf-8?B?QjdhZlArSDNQb2kvMFdTa212RXR4TElVcTZGdEtITmFOSmxsVVNGeG9NNmtr?=
 =?utf-8?B?UVhhNWh6ekxNQUFyOVRwMEFzSEVpdTRNY1p2elhzTXl6TUE1SUVsYTRnWjdI?=
 =?utf-8?B?WktDWVRja0pmYmFsN2NieGtKOUN1Sm5ST0lkNVRxWmJ4Z3hWNzdjYVlQYUJu?=
 =?utf-8?B?ckVVcXh4M2Z4bEo4eTRVaDJBZC9GTFVndHRZOWVFTUdZRmluVExQWG1MUmhs?=
 =?utf-8?B?ejh4NVlpcE9PWm10aTh1TC83R3kvVmNJM3ZYdnhEb3Y1bDlTTjVqdEwzUXF2?=
 =?utf-8?B?SHBzMzlac2dNZjQ2NTJCVTFLcEFSYlB1NHBoRThFdC9QR2toQ2RJZjY4L2VT?=
 =?utf-8?B?Zmw3dU9BSDQ3K1BCZG9sRncxV0UvMVRyNEMzaFc3eEtBZ1ZaUkFMLzRIMTls?=
 =?utf-8?B?NE8zanZvZjhBOStKSnJwTGVYcnh3RmRoQno3Tm9ZejIxSk9FVGNKT3Fra3dZ?=
 =?utf-8?B?WStZRnViaWtHSXh1ZnRDRDFBeVltVnhFS0lCSGoyQWZ4Y0V5NlYrVHhMR0Fh?=
 =?utf-8?B?VEszTC9ZSUNvQzZXbVJOMUU5aGM0dWd6cXhyQTNEeGZWSE8vMm82U2w2bktq?=
 =?utf-8?B?VFBKS2dnenNudTBIWTJmN3AwTGdjV1diSkRTWFlITFZ1Nk1lbVBTc0NYNzZS?=
 =?utf-8?B?VDNUUEcwQlZ1NWFzdldSUjIzWFBiQVRmNksrd09HRjNIQUhIczlPbVRpbk84?=
 =?utf-8?B?WWR2cU5uRUFZUGx6RElxRm02TnlDM3NFTE9nVEx1UVJrWDg2dXMvL1ZjOXlk?=
 =?utf-8?B?WnNkejhiTk13PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDc3NXYwZlVCUzJkaTA0R0VPRERPY2xwL24yN01PRnhTR3VtRjh0STlmU1RU?=
 =?utf-8?B?YVJyWTlBTzlYaSszdlhUUFFqekN1S2JqeStvN0liTTVVcXhyYjhUQ3ZxZ3Qy?=
 =?utf-8?B?S0NOUEtrRTBDNWgwOElidVVPZXZNS2wycFpZTjlrNG5KZjd5WUZHanNZdVo1?=
 =?utf-8?B?MGYvbnY5cUpQUDBKcytXMDA5TGRoQXJzTXlHd3YxQTU3blVxL3VMeEZKZk9D?=
 =?utf-8?B?TXErQWJrWEZ5bU5GSmZDcUQxdTlMYnhLWEZOR1lyc0NZRnYwZEdOZWxTWXN6?=
 =?utf-8?B?Zm56L0lUWkRSdkJkTlFCdkEzd0w3QUhNWlB5L3JUajE1M1JSaHFGeVZGTnZB?=
 =?utf-8?B?eU5IcENlNzdDMFFaUzBsUjZhaXU1UkpNZGpKelYrVFRaOGY4WWlxRjd0Zm9H?=
 =?utf-8?B?UkxrdWNyVTlkckdadC9OQ2xGNGlkd21GY0l6RXpTYy9JWUZ0MHptam9vbHdX?=
 =?utf-8?B?b1IzeWRKMEJSNS9xa09KWElLbitva3ZRaGI5WXIrZU5sMFRuMmNFSG96TnRH?=
 =?utf-8?B?MW5VcXpjdVkrRENpS2JzYzdDYXVtS1lKMmtwNGFyYVNJUWQvN2M5NTRPM2hn?=
 =?utf-8?B?V2FUUFFySmhGWWViYzVzK0t1QzRLVnRnR01vdHBkZUgybDgvRngwMzh6UEZF?=
 =?utf-8?B?RituQjlEZE83SlZ1b0RYUDcvR0pwV0pBc0t4d0dsNmxZbnJJWkhGRXBUSUFL?=
 =?utf-8?B?UTlqS3JPNjlxYjFnOGFyTVBSN3RUd2FJVnhJcjBINzdHV2Z1MllkNnZOTy9R?=
 =?utf-8?B?UWdXU2dzckJYeWFFaDNaV0c4NElDcWdGRysrTmdWK09NMENTem1iRmx2UXFC?=
 =?utf-8?B?dHpuaytFeDJqT0JWTWo5YTAwTVEydVhVN0VFS1JTZmhndFBoTmt4WXJGME5T?=
 =?utf-8?B?ZFdKUnYvaWtwRGs5ZGRZeEZOZ0VqdFZoQzJLY2Vmdk5mY2ZuWXRPeEM4M0Vq?=
 =?utf-8?B?TjBwSVg0VXkwRmVZYUdORWdLUm03aFc0QXlpVzltZTFOZk9uU3NPVlhBNmd0?=
 =?utf-8?B?QXd4U1ZOVVR5S01kcHdMTjJ5ZHhzWk85SlZmRExnOEZpeUdkWDNPUHJHUVY2?=
 =?utf-8?B?TXhIaUZzQk56NWhlUXRMek0wcHFzUytzZ0pBaW9BMWIrNmNaQ21adUVoTG9s?=
 =?utf-8?B?NE5mOHdQVkZQRTZHbGhWNXVXYUlSRjl6NnpTTHlQZHVDVUZlaXBsUERsWm04?=
 =?utf-8?B?SWJkUEYwNE93WWR2UUF1akx2d2RzUFNuYldNSHFjblJaVERSMHpLSGdETkdZ?=
 =?utf-8?B?MU5NbkttQlhQWTdnM0FDVHcxcmFNMnkvdlIvVWhOZDhWd1ZCZExMbkZaYVBk?=
 =?utf-8?B?MjQrZE5XOFlNbDdrT0FwWUxYMTRVNWptNWkzTFpwb1czQnRlOEVBanJmVjdM?=
 =?utf-8?B?WU5qT0duSEx6TVZQblExMUZsc2wweWVEMXBuWE1GaGZtenR2Uml5S25tNW4v?=
 =?utf-8?B?d2daWXV5Z0M5b2dncmhYVUlqMzJYMXdXMlFxQjBZak5FWkthRk5QMTBtenNn?=
 =?utf-8?B?UnpJbkZrS0k1VnlncXF4YnJ2Q1p5RUlGUXB5cUxONXMzOWdsOVlPakRrNXVG?=
 =?utf-8?B?dW1acXE4TDdVV2FEWTJkZFpKOTBLc2NlZGE0dXpFbU9KYjVGZG5SVjJvckNu?=
 =?utf-8?B?UkhaUXV3bCthM2ZFVGxTZnY1MWdvKzVic1ZVRkxialpXeHhUbkwxeUNoblB2?=
 =?utf-8?B?RTZOVTJIRGdwQWJyQXVIdTcxbkxKVGphbVhQajVGbG5rZjVXWE9IdXdqb1Ro?=
 =?utf-8?B?QjBoL2ZILy96OGNRM2NxdWJIOWFLSzFvVGZ5UkI0UktacitvZ3k5alpFcysr?=
 =?utf-8?B?WEk3Tm1XSUwwRVR1ZkN2OXR6V0VPTmFiOURjQlFsNHlkYUhRVUtlWE1MaXFY?=
 =?utf-8?B?TFV2K3JiditwRkNIL0Uwbi80WjRUajQyejZTZFdOM1gySGdWMjdBT0VoNVMr?=
 =?utf-8?B?cWhDWEg1YkNXVy9seEhMZU9ZUDRKdzZNS0FDaXFaMFFYbDk2Z3MrbjArdUx2?=
 =?utf-8?B?enhzUGJqcEVuSS9JdExXUTV0NG1CVGZneE95cFpvKzRyeEVjUkR2a0xVRjJG?=
 =?utf-8?B?LzA2bVJ5Y1FUTmJaWEVNQlo2UVB6NWlnRWZubjF1b1N1STdnOXk1a1dJNVF6?=
 =?utf-8?B?TzhseGZVNXlJQytidCs3L0xoTFlqVU5tRU1OeGhpb2hzTk1xY05EQmxwTXRM?=
 =?utf-8?Q?J41/aT23yw9HRHleBecYono7oN2Iu70NdF8roSmonzmI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FB745340E2A144EBDF96BF183C8B6F2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 542aebbb-0fc3-4d93-2079-08dd709959cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 21:16:49.5318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q1yxjuPZLzOFxe6XhXZZzur2AFY0DhawwyJ93sL6fu4Q8xFthwgjk9/pgISiiFxunv4zgE1qdi6Oa811OaPsNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5653
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250331_141656_244905_E62A349A 
X-CRM114-Status: GOOD (  18.44  )
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

T24gMy8zMS8yNSAxMzo1NywgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9uIE1vbiwgTWFyIDMxLCAy
MDI1IGF0IDA4OjM3OjMxUE0gKzAwMDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IE9u
IDMvMzEvMjUgMTI6MDgsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPj4+IEZyb206IEtlaXRoIEJ1c2No
PGtidXNjaEBrZXJuZWwub3JnPg0KPj4+DQo+Pj4gQXNzdW1lIHRoZSB1c2VyIG1lYW50IHRvIGF0
dGFjaCB0aGUgbmFtZXNwYWNlIHRvIHRoZSBjb250cm9sbGVyIHRoZQ0KPj4+IGNvbW1hbmQgd2Fz
IHNlbnQgdG8gaWYgdGhlIHVzZXIgZGlkbid0IHByb3ZpZGUgYSBjb250cm9sbGVyIGlkIGxpc3Qu
DQo+Pj4NCj4+PiBTdWdnZXN0ZWQtYnk6IE5pbGF5IFNocm9mZjxuaWxheUBsaW51eC5pYm0uY29t
Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEtlaXRoIEJ1c2NoPGtidXNjaEBrZXJuZWwub3JnPg0KPj4g
dGhpcyB3aWxsIG5vdCBiZSBiYWNrd2FyZCBjb21wYXRpYmxlIGhlbmNlIGFsbCB0aGUgZXhpc3Rp
bmcgZGVwbG95bWVudHMNCj4+IHRoYXQgYXJlIHJlc3VsdGluZyBpbiBlcnJvciBbMV0gd2lsbCBu
b3cgYXR0YWNoIHRoZSBkZWZhdWx0IGNvbnRyb2xsZXIsDQo+PiBJIGJlbGlldmUgdGhhdCBpcyB3
aGF0IGlzIGV4cGVjdGVkID8NCj4gWWVzLCB0aGlzIGNoYW5nZXMgYmVoYXZpb3IuIEkgZG9uJ3Qg
dGhpbmsgYSB1c2VyIHdvdWxkIHB1cnBvc2VmdWxseQ0KPiByZXF1ZXN0IHRvIGF0dGFjaCBhIG5h
bWVzcGFjZSB0byBub3RoaW5nLiBJZiB0aGV5IGV4cGxpY2l0bHkgcmVxdWVzdA0KPiB0aGF0IHZp
YSAnLWMgIiInLCB0aGVuIHRoYXQgcmVxdWVzdCB3aWxsIHN0aWxsIGJlIGhvbm9yZWQuIEJ1dCBp
ZiB0aGV5DQo+IG9taXQgdGhlIGxpc3QgZW50aXJlbHksIEkgdGhpbmsgaXQncyByZWFzb25hYmxl
IHRvIGFzc3VtZSB5b3Ugd2FudCB0aGUNCj4gY29udHJvbGxlciBzZXJ2aWNpbmcgdGhlIGNvbW1h
bmQgdG8gYXR0YWNoIHRoZSBuYW1lc3BhY2UgdG8gaXRzZWxmLg0KPg0KPiBJdCdzIHJlYWxseSBh
IG5pY2Ugd29ya2Zsb3cgb3B0aW1pemF0aW9uIHNpbmNlIHlvdSBjYW4gc2tpcCBmaW5kaW5nIHRo
ZQ0KPiBjb250cm9sbGVyIGlkIHdoZW4geW91IGp1c3Qgd2FudCBsb2NhbCBhdHRhY2htZW50Lg0K
PiAgIA0KDQpZZXMsIHNvbWVvbmUgd2hvJ3MgdXNpbmcgbnZtZS1jbGkgZnJvbSB2ZXJ5IHN0YXJ0
IEkgdG90YWxseSBhZ3JlZSA6KS4NCg0KPj4gaWYgbm90IHRoZW4gZG8gd2UgbmVlZCBhZGQgYSB2
ZXJzaW9uIGNoZWNrIHNvIGl0IHdpbGwgc3RheSBhcyBiYWNrd2FyZA0KPj4gY29tcGF0aWJsZSA/
DQo+IEkgZG9uJ3QgZm9sbG93IHdoYXQgeW91IG1lYW4gaGVyZS4gV2hhdCB2ZXJzaW9uIG9mIHdo
YXQgY29tcG9uZW50IGNvdWxkDQo+IGJlIGNoZWNrZWQgdG8gZ3VpZGUgdGhpcyBiZWhhdmlvcj8N
Cg0KaWYgd2UgY2FuIG9ubHkgZW5hYmxlIHRoaXMgZnVuY3Rpb25hbGl0eSBmb3IgbnZtZS1jbGkv
bGlibnZtZSBmb3IgdGhlIA0KY3VycmVudA0KdmVyc2lvbiBhbmQgYW55IG90aGVyIHZlcnNpb25z
IGFmdGVyIGN1cnJlbnQgdmVyc2lvbi4NCg0KSW4gY2FzZSBudm1lLWNsaSBvciBsaWJudm1lIGhh
cyBhIHZlcnNpb24gYmVsb3cgdGhlIGN1cnJlbnQgdmVyc2lvbiwgdGhlbg0KaXQgY2FuIGZvbGxv
dyB0aGUgb3JpZ2luYWwgYmVoYXZpb3IsIHdpbGwgdGhpcyB3b3JrIG9yIG5vdCA/DQoNCi1jaw0K
DQoNCg==

