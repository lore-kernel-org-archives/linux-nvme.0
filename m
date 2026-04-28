Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED03FF885A
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2026 03:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kZkwm7HWtoQ8lCCju+d6ItQWY1x+FznqFoaRicFCZek=; b=3yzpnxldaqC31U1Xj9DuDTYk/T
	ymlyrUX/MP+Q0yEl7ksKZVTz9FwgtSl6z9YAGCaMqqXXLiXCw5Nih1XILXU04ZKZzfUyHn3oYCdy8
	4OP5IWh9jObAijyiiTKBXMFkaauVo8rh9JvDBPzGOjmc0TlUwaur7mUu6kcCFS4zinP6ZdlkDYAS+
	xV2T7DgnDAQxuXXb8WwexVnZq/Y+Tj7NIQaBQ/J0pmaUA26WMskgs/2EtIAWgKw7Y6ue0F4YKpXcu
	CyXP0jdyglG1xoRKLE3pHMgh5AUFTLrlKYLjoz/JJZAF3MazFe2eCPtfBgIHNl+0cJonS7QZ7X6Vd
	BlRfYCyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHZYr-00000000W9u-1uQZ;
	Tue, 28 Apr 2026 03:56:37 +0000
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHZYp-00000000W8y-114S
	for linux-nvme@lists.infradead.org;
	Tue, 28 Apr 2026 03:56:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1Ott8tVt8xQavdP4KYDzr780UvPdw92hIn5j+8UIPmzL3MfcviERsswubdcP2uPVydWJPNPAW9As2kN3FM0D1IHrw3AnjUVOSlH891Bsqh/SjQ9W4CR/VlM2CLubyXyAHPRtUtPnONWl+DxxGUxE4orKB7M/2vDeUjUGiyoOzIvk91Ife++IbQEMVu3A1/nI4jx5PLdHBuVUPjdrr5hH9wzOntL0U4lQUeIYBFWlSfuyBc4LssOBtHAOsBknIyiVGhvrtDJY6kZmHp5Mbc3B0+PdC2nyvh28/9eVVFzSDPw2sC5Zz7ypPMpvrA/dzsKOKt4DumtuHsi7n0B2/794A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZkwm7HWtoQ8lCCju+d6ItQWY1x+FznqFoaRicFCZek=;
 b=TWJvOXdBS4F+Ju4oM00NMOf60126l15JdYcL+zPuhGhldU7WFA3OlNKNPM43Vi8QjRq2O1onuMdookkx2eoA33PRaCwoFk3oiQirQINxpi+msAjLcgHd9nIwoAsrF1gPDhsIKs+s9Is9FjIqwS7VbyuHKRX+1LMqfRfsVt1X+k06RQEGnCMr6ssqImPGTgFCdc+XSxL7sQ63F2lQELI3kwFmer1pQkmywItLmwRm9cIzx4H5411XiE8cim246h648ckn3mTdQz93Uak/lWKrlPFwqRWPZZHXw2kl+nZzZF3zNmoVFFpUHoSJuzdHGWlTmy1EY+1SXDIV33P/REL9vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZkwm7HWtoQ8lCCju+d6ItQWY1x+FznqFoaRicFCZek=;
 b=S3McFEuiRQe3dyuhQ6icqviFlDSV74QR5lVv7nRMbDaU47wZM8z0Hp90CzARWKKpTYBYToehGA9Buvu3Bx6IFydl9kaSUnJqaYdFbj1+GqQZHnefLBIhNxshvjymSID2rI9LPFYwjlmlby0vubnNVGgEA1UA+a5VkU3y3bLxnrqvArxIiIeTaUyZF1XdzIeoOQ/34u4YLHTZvnoNYHqw4wIxFvJ6JwtwBQQaZUH7v7goSn1/Z1Ymh0nfUIXoeXOz3UDI8Eae7sSKk3Vr+2JtEiDE6auJlGvSihkYFobdgeFMwI8bKLX5fANwmvxYx7guKPacOglA7w92vv1fSkMhFw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB6236.namprd12.prod.outlook.com (2603:10b6:208:3e4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 03:56:28 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 03:56:28 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Joel Granados <joel.granados@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Keith Busch <kbusch@kernel.org>, Jens
 Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph
 Hellwig <hch@lst.de>, "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH RFC 0/5] nvme: Controller Data Queue (CDQ) support
Thread-Topic: [PATCH RFC 0/5] nvme: Controller Data Queue (CDQ) support
Thread-Index: AQHc097fEsSX4et0Rk6KdNthNngV6rXuLoWAgAAFEYCABQq3AIAAn+0A
Date: Tue, 28 Apr 2026 03:56:28 +0000
Message-ID: <de162155-b03a-4626-a416-3425db9235c7@nvidia.com>
References: <20260424-jag-cdq-lkml-v1-0-d773343a717c@kernel.org>
 <20260424130615.GW3611611@ziepe.ca> <20260424132423.GA15833@lst.de>
 <ieeora3jekprb2h2lhs5xcm3wnchgmd3z7f3c3hf3wl4x6npoa@5uqwtljasa3s>
In-Reply-To: <ieeora3jekprb2h2lhs5xcm3wnchgmd3z7f3c3hf3wl4x6npoa@5uqwtljasa3s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB6236:EE_
x-ms-office365-filtering-correlation-id: 8e21dc6c-12fa-4b25-6da5-08dea4da2077
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003|18096099003;
x-microsoft-antispam-message-info: Led6VlSM/+nOWdJ65Bc4ziWCrq5HHYcsSf38008x0WkSGJa2uBt+ruSt+6THx2/EcrTzXfR1i9sBAZM/cMf2IPnkJYIjyMKbuiXeOE4HkYC2+5LylvmMMiaxZcBin0oqHnw3qGG3rl2QawZHSq7BMVmbuQJeHZHr+2pyvPEzJca2Sy1U4h/su0Ze9W1atV+mzVyJWQZX0Yja0g3j18MPqs/qrC7XbLZVRZSu/e5FfyZVcYMWTpwhSX89mf3SWGmnLSqLys9kbht7xKANfnXUpI3aH6PtBw87qvXc1YXPZuunDTkxtjb8IIuvqIGHXZRfW9CjbYvAvj6dtVVj9JCzsZrES/GG0kwDaR/bYA6CGXwDBhKtnmvEjw8bwYlRFbSNyfGJkQ+gezMOpeJ6clgwEKMxowHzlU2fkw5jD1aV3lCtP3TZMT/72lo+mcNlUOC6n9YYiZ17LOUnNd1Hlm0alrnypavha3h4O+qibWeaJl5Gz7aem/7VwUmww2rVsJCWN8Sm6do9VqZ05cfDqKpgXY+vR/KpeNODM4ptNAPnIJY9rs+3Fmwg7QvgjAO/8Rvw+jtMUowiOVjQH/ZIvYBVIYLR3Ia4nj+oJwBo7Thj2gEzjgSw9DxklQEA2G8mIHem+issTHxsKMmYoOv0z8DfIrhDYr1x4tit8XZc+QscEnoJ+j0Iyx0UL1w19HBU3+obCwS+LwDEg6P0w3yfV7V1Oga0EaE12+dwpxGpv2GZ5n6MqBxCrhtHMIwg1eGRyfHP8YCJh3DP+yWEuGuaSUPNrUe7KF4OzyIbGVigVYvhw5c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003)(18096099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UERRYlFGaHBFaS9nOUllRmI1bnI0SG9kOGpTNUtRdGxFcUVpVk53cmtsRTRB?=
 =?utf-8?B?eFhLZ0cwVk9iVFM4YzN1TWZBa1RFcDlXVnh4ZWtGYkFuOGZuODVBdHE1ZFhy?=
 =?utf-8?B?T0x1SmZBbUMyV3F4ZWZTNVlyZ3ZqOXh0L0tacVk0bkJzRHNwdzNKcEVqOVRz?=
 =?utf-8?B?NHZobVdIUzhMUXZOSTEzdnhsZGM3VXBCOHZGTUVBem5oTFRXa09ueVRleU84?=
 =?utf-8?B?R0FaaHFVaGhLdmE0Q2hLQ2dlUDlWd0dML210NVZiWjBscDRYZEJTcU5GR1VH?=
 =?utf-8?B?QmJVZDZpOUZZMzNXRDVLZEs5c0FmNERGdFM0L25JRmNVZ205K3JGK1dBTjhO?=
 =?utf-8?B?ZXdJQjZ0N0xBZDhtY3VFSVUrVGREbzNncEprZXprS09sSVFrWUJLcUFOTGJk?=
 =?utf-8?B?a1J4UHV3QmE4bWdSNWVWQmhOYUZlOU94clkrMGFOTk5FWHlDSTBIOVBpVVZR?=
 =?utf-8?B?UUNUNmNXbzZUWkRFWWNpR1N4dU5yYlFtckNYZWViOUFSNmNyN0Zsa2Z1SUx5?=
 =?utf-8?B?elBXemtmdldLSTNLYmZYVmQwZFdtRldMRW5CeHdGOGpwMXhiSXJWTjVzNDNE?=
 =?utf-8?B?NVR2dGVtQ2JIV3JnNFpvNFh2c2VaV0kwaUIyNHVqYWlVMm1LUVBWVHJuMlcr?=
 =?utf-8?B?K2lNcllPVjk5SlVnS3FUQVFMa1NoQ3BYcDBRWVpRbWhuRTU1R1NLazdsKzZz?=
 =?utf-8?B?aWp2UW5DSCtscm5IZTlkZ2h3Q0VJcm5CU2pPaWJoZzl1UG9Qc2dwajI3Z1Mw?=
 =?utf-8?B?aEgzSEN4aXBMNngyaDQycHBnSWFCdWMyajdRK2IzM2phTUdmZ3h0U0hYOWJp?=
 =?utf-8?B?cXFxQ2NuMzlsRkVuL2x4SU05UEpnQVBZc3hMWndObTJ2a1NFRFVnNXJIbktS?=
 =?utf-8?B?MFhzZ0VaWVhrVG1NRk56bU9rNXJJajd0akNHTWlNMjJzU29MMkgyNUFPUUMr?=
 =?utf-8?B?Z0RCN1FETFFYVmVKMnpseUdycmJmM0laaFo4cFBmWE1QUGF5WW9qSmdIckVz?=
 =?utf-8?B?RDBXQ3JrbTdxcHBib3BCZmNKZXlrejhoc29NWGxqZkF4czN5c3o3ajFEZC9M?=
 =?utf-8?B?enhCUnkyUmRGQjdKb01GQXpjWFFnN3BmVjNmdWtHdENUYmNPNGYrMmV3NzFN?=
 =?utf-8?B?WTlhdEs0S1ZXbVlNc0o1WWUxQlE2cDJXWitFSnpLOUZ3a0tXeWlBUnZXMGRn?=
 =?utf-8?B?dVc3WGdyVGpsNWt4N0hFWW9xRXpkTW1ZUCtRYWZHakRhakQ1dVhxeXBjaC91?=
 =?utf-8?B?RXhWaGpnZjVjUkNQdFk0QkpFYVlzMmM1ZVh1ZGxRb3dESVNNMFZ5WFQ2cjNy?=
 =?utf-8?B?S3dpbTVWRndiSktKMStOaCtycmZJU000RWRmWVg0RUdHeEQ0YnV1bHAxNSt3?=
 =?utf-8?B?Z3Z5eE5CSDYyUHI5aW94SUtuRTd3UTg0TS9hbkQwdk8wZ3owdGgwMHl3K04z?=
 =?utf-8?B?QnJvcitHV2RrTjVuYVAyaHErS0NKaGwrVHJFcXp4TnA1RTRZeXZ5NHVpczYy?=
 =?utf-8?B?WU84R2dzVWFjOGo1eDg3VEhhbTNycGhxcTRmOHNDOERXVjIyaExJbjFXZW54?=
 =?utf-8?B?VGphV1RNYW5XR3Z3R1Uzd243QTFzS2RlZlpsU0JlaDJZaVZFTkU1cHZBVWdl?=
 =?utf-8?B?RXpadlFnYWNRdloyWW5ET01RTUxDUFlpdWVLdEs1dERzd0JjSWpjLzJIYmxV?=
 =?utf-8?B?S2htUENIeVpMT3FkRTI1emFsY0k4d3lldWhhWjNxd2tvREpCQ0Y2QmdmUklJ?=
 =?utf-8?B?SmdQVWljVWc2WGpDb3lkSTNBd3dha1hGcSt5Y2pUelpGMm5EMW82Z2RJMUEz?=
 =?utf-8?B?eDZ3eG5XQkQzMmJkNkUzYm12enczZmhtc1pGNG5TN0ZiaWgvMldmbzQvR1pr?=
 =?utf-8?B?YzlNYThZdk0weWtmcXBqamRYZ1JER1h3YzRIVnFOMmNZNER6SmJjWjBiTXB3?=
 =?utf-8?B?K3B2VVhuVkx4Wkd5L05abXZjMFVnbWF2aldVTTM0aTJxMVpWNVhKbTJkN0Fk?=
 =?utf-8?B?WUtTTUVlMVVQNWQ1dHpuUjk1d28xVHlLOFpGeHhkMVBCSEFVWDNqamZ2aFJP?=
 =?utf-8?B?ZDkrL3p1ZkY1c3hKRjJOaWhBL3p6aTk0ZDgvUmhpTUhNbkJZZDk0ckp1dXEr?=
 =?utf-8?B?cWtSc2xQMm5xNUlNWFdmL2d2L0RaL3IwcTFFM0pBT0c5QUFoMUtycVFRRXNJ?=
 =?utf-8?B?N3VhaFdmS25tdjMyT3hWdFU3clJZZ1NtNHE5eHFsdjU1VHpuV3dZR3NleEJV?=
 =?utf-8?B?MHRjYWUxbHdwZ1laNmlWRGcvbW1DOFBTdElzaXJYcksxMWY3VE5lTUR5QzNX?=
 =?utf-8?B?YmhSbHFEOTdZK01sMDVHYmlnUnlJdGpwY1BIMTNVRGVicndEOVFnUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCE245B93DC0C14189165565528D69B7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e21dc6c-12fa-4b25-6da5-08dea4da2077
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 03:56:28.7590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cFi4ClxNKTZX5DrIuf8r57hUAsmzzpkT5g9pMLa3P7HXgYMFhZgEC6D1W/R9kLK3VLClGF+CAjviIhOucQ/UCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6236
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_205635_288496_5EA8E41A 
X-CRM114-Status: GOOD (  22.75  )
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

T24gNC8yNy8yNiAxMToyNCBBTSwgSm9lbCBHcmFuYWRvcyB3cm90ZToNCj4gT24gRnJpLCBBcHIg
MjQsIDIwMjYgYXQgMDM6MjQ6MjNQTSArMDIwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+
PiBPbiBGcmksIEFwciAyNCwgMjAyNiBhdCAxMDowNjoxNUFNIC0wMzAwLCBKYXNvbiBHdW50aG9y
cGUgd3JvdGU6DQo+Pj4gT24gRnJpLCBBcHIgMjQsIDIwMjYgYXQgMDE6Mzc6NTBQTSArMDIwMCwg
Sm9lbCBHcmFuYWRvcyB3cm90ZToNCj4+Pg0KPj4+PiBUaGVyZSBpcyBob3dldmVyLCBubyBjbGVh
ciBjb25zZW5zdXMgb24gaG93IE5WTWUgTGl2ZSBNaWdyYXRpb24gc2hvdWxkDQo+Pj4+IGxhbmQg
aW4gdGhlIExpbnV4IGtlcm5lbC4gVGhlIDIwMjIgZGlzY3Vzc2lvbiBbMV0gZXhwbG9yZWQgYSBW
RklPLWJhc2VkDQo+Pj4+IGFwcHJvYWNoIGJ1dCByZWFjaGVkIG5vIGNvbmNsdXNpb24sIGxpa2Vs
eSBiZWNhdXNlIHRoZSBzcGVjaWZpY2F0aW9uIHdhcw0KPj4+PiBub3QgeWV0IG1hdHVyZS4NCj4+
PiBZZXMgaXQgd2FzIHBhdXNlZCB1bnRpbCB0aGUgc3BlYyBtYXR1cmVzLCB0aGVuIEkgZXhwZWN0
IGl0IHRvIGdvDQo+Pj4gZm9yd2FyZC4NCj4+IEFuZCBpdCB3aWxsIGhhcHBlbiBpbiB0aGUgbnZt
ZSBzb2Z0d2FyZSB3b3JraW5nIGdyb3VwLiAgV2hpY2ggc2hvdWxkIGJlDQo+PiB1cCBhbiBydW5u
aW5nIGlmIFNhbXN1bmcgaGFkbid0IGRvbmUgZXZlcnl0aGluZyBpbiB0aGUgcG93ZXIgdG8gdG9y
cGVkbw0KPiBUaGVyZSBpcyBub3RoaW5nIHRoYXQgaW5kaWNhdGVzIHRvIG1lIHRoYXQgU2Ftc3Vu
ZyAidG9ycGVkb2VkIiB0aGUNCj4gY3JlYXRpb24gb2YgdGhlIG52bWUgU1cgd29ya2luZyBncm91
cC4NCj4NCj4+IGl0LiAgQmVjYXVzZSBvZiB0aGF0IEkgZG8gbm90IGV4YWN0IFNhbXN1bmcgdG8g
aGF2ZSBhbnkgbWFqb3IgaW1wYWN0IGluDQo+PiBob3cgdGhpcyB3aWxsIGJlIGltcGxlbWVudGVk
IGluIExpbnV4Lg0KPj4NCj4+IE5vdGUgdGhhdCB3ZSBhbHNvIGNhbid0IGRpc2N1c3MgYW55IG9m
IHRoaXMgYXQgTFNGL01NIGluIHB1YmxpYywgc28NCj4gSSBzZWUgbm8gcmVhc29uIG5vdCB0byBo
YXZlIHRoZSBkaXNjdXNzaW9uIGF0IExTRi9NTS4gSXQgaXMgdGhlIHBlcmZlY3QNCj4gdmVudWUg
dG8gdW5wYWNrIHRoZSAocG90ZW50aWFsKSBpbnRlcmFjdGlvbiBiZXR3ZWVuIHRoZSB2ZmlvIGFu
ZCBudm1lDQo+IGRyaXZlcnMuIFJlZ2FyZGxlc3Mgb2Ygd2hhdCBpcyBjdXJyZW50bHkgYnJld2lu
ZyBpbiBOVk1lLCB0aGVyZSBpcyBubw0KPiByZWFzb24gd2h5IHRoZSBmdW5kYW1lbnRhbCBhcmNo
aXRlY3R1cmUgY2Fubm90IGJlIGRpc2N1c3NlZC4gT2YgY291cnNlLA0KPiB3ZSBuZWVkIHRvIGJl
IGNhcmVmdWwgb2Ygd2hhdCBpcyBtZW50aW9uZWQgaW4gcHVibGljLCBidXQgSSBzZWUgdGhhdCBh
cw0KPiBhIGRldGFpbCB0aGF0IGRvZXMgbm90IHByZXZlbnQgZnJvbSBoYXZpbmcgdGhlIGNvbnZl
cnNhdGlvbi4NCj4NCj4gQmVzdA0KPg0KVGhhbmtzIGZvciB5b3VyIHBlcnNwZWN0aXZlIOKAlCBJ
IGFncmVlIHRoYXQgTFNGL01NIGlzIGdlbmVyYWxseSBhDQp2YWx1YWJsZSB2ZW51ZSBmb3IgY3Jv
c3Mtc3Vic3lzdGVtIGRpc2N1c3Npb25zLCBpbmNsdWRpbmcgdmZpbyBhbmQNCm52bWUgaW50ZXJh
Y3Rpb25zLg0KDQpGb3IgY29udGV4dCwgd2UgaW5pdGlhbGx5IGJyb3VnaHQgdGhpcyB0b3BpYyBm
b3J3YXJkIGFzIGFuIFJGQyBpbg0KMjAyMiBhbmQgZm9sbG93ZWQgdXAgd2l0aCBhIGRlZGljYXRl
ZCBzZXNzaW9uIGF0IExTRk1NIDIwMjMNCndoZXJlIHdlIHJlY2VpdmVkIGRldGFpbGVkIGZlZWRi
YWNrIGZyb20gdGhlIGtlcm5lbCBjb21tdW5pdHkuDQpUaGF0IGlucHV0IGhhcyBzaW5jZSBzaGFw
ZWQgdGhlIGN1cnJlbnQgZGlyZWN0aW9uIG9mIHRoZSB3b3JrLg0KDQpHb2luZyBmb3J3YXJkIGRl
dmVsb3BtZW50IGFuZCBkaXNjdXNzaW9uIHdpbGwgaGFwcGVuIE5WTWUgY29uc29ydGl1bQ0KYXBw
cm92ZWQgTlZNZSBMTSBTVyBXRy4gVG8ga2VlcCB0aGUgZGlzY3Vzc2lvbiBmb2N1c2VkIGFuZCBw
cm9kdWN0aXZlLA0KaXQgd291bGQgYmUgaGVscGZ1bCB0byBjb250aW51ZSBkZWVwZXIgYXJjaGl0
ZWN0dXJhbCBhbmQNCmltcGxlbWVudGF0aW9uIGRpc2N1c3Npb25zIHRoZXJlLg0KDQpUaGF0IHNh
aWQsIEnigJltIHZlcnkgb3BlbiB0byBjb2xsYWJvcmF0aW9uIGFuZCB3b3VsZCBiZSBnbGFkIHRv
IHdvcmsNCndpdGggeW91IHRocm91Z2ggdGhlIE5WTWUgTE0gU1cgV0cuIElmIHlvdSBoYXZlIHNw
ZWNpZmljIHF1ZXN0aW9ucw0Kb3IgY29uY2VybnMgYXJvdW5kIHZmaW8vTlZNZSBpbnRlcmFjdGlv
bnMsIHBsZWFzZSBmZWVsIGZyZWUgdG8NCnJhaXNlIHRoZW0gdGhlcmUg4oCUIEnigJlsbCBtYWtl
IHN1cmUgdGhleSByZWNlaXZlIHByb21wdCBhdHRlbnRpb24uDQoNCkFsc28sIHRoZXJlIHNlZW1z
IHRvIGJlIG5vIHJlc3BvbnNlIG9uIHlvdXIgTFNGTU0gdG9waWMsIHNpbmNlIHRoaXMNCndvcmsg
aXMgbW92ZWQgdG8gTlZNZSBMTSBTVyBXRyBpdCB3aWxsIGJlIGdyZWF0IHlvdSBicmluZyB5b3Vy
DQpjb25jZXJucyB0aGVyZS4NCg0KLWNrDQoNCg0K

