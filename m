Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820A2FCC9C6
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 05:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=guGXzUFnHR3v/TR+5v3+p615GzH2Iyvuy4erFVmzyds=; b=oY4phvOxKmWDZ563+TFT7kDjsY
	wZNid5uNhR6bQI+mNjtk9Hu0SXbINpHlquAD3U4tcrZvVlQfFRWJmvMNfxkuuC0Vdi8RGJnDzRgOt
	ynULxHFov8Qes5biTXG3BbSet0EYF/8iT8Uj8I4OHuhd7O7urimmRdnZuVR+ZdWQ3aG8daAmNyDn1
	XCw5wOZOvNNmLXHzQKXoUIyuTg7fkXFT41/sErh28R8Vmhq0fozRuzcQ4CkAWfikpH1e7F7NOHiZl
	USrxuR9fgHxX5NTlJzMlsVMzaQGBZwt4INzg9+6Xjg5uOp4SgoZ+RCIVgYsZM9I/w3mGY17k1U7mS
	YQJ5UPAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzpta-00000008kd5-2eoc;
	Tue, 10 Mar 2026 05:44:42 +0000
Received: from mail-eastus2azon11010018.outbound.protection.outlook.com ([52.101.56.18] helo=BN1PR04CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzptX-00000008kcN-3k6H
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 05:44:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoXta7OyI7fTVlUeqMEbr3K9EvjhEnb+QkIHin7DWf6dgc87ruwlLhMw88+kddrWWr3XqkHkDv+1imV3PzMjEHWOmREQNvqEKBnKHHFWjSmhKhByvS4MczF0UoCe5nxH3y71gcqYPw4WeXtgQujfnfTfJBhrxOg/8YUpxndGLSCXDX4vzR4QTIBSIXE8x8FOyAkFi0UxKO/NmHNhj6idRBkr/g9DdK/RA7iftHfOUyx/mC1Y6h4FdvBE/fiN26tapr5bG5n2Z4huwYZ5Ab7vdHy63WGmIl/AlPTRqfo0o+Qol5tKhFMK30v2fVApYkN597rmOMltOFkmAjVlOneh2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guGXzUFnHR3v/TR+5v3+p615GzH2Iyvuy4erFVmzyds=;
 b=B4LkLmoRw9R4d2swaCK3SlUm452QsMgBx9/i9YykBamg4FIM0Slc4Rk+yK7oo1SIrDAniXFbmKvi+cC5fOlDpdGOwX9Z6GC4ZkrwrhZPRETXNv36n8YCE5Zr6k7X7OjUikzIOtfIrUmi9Y1bh4+kyJBFEGdkOPq2icNJ2RPXRq/06hieogboORg6QI8Ago4sBxIvSi9KcOwoQouDoQY9EdUbiwKtcp/R6B0FZYfPjIbhq8v/s3LaC1OUYxwkVJk2B4FmYfILBuRu8s8YKEW14ml2VajtKft3zMDcx0Tyvu3ZUDigl6Jlv9E++xMGBMh5qb8STwZVhml3tyY9Go2+sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guGXzUFnHR3v/TR+5v3+p615GzH2Iyvuy4erFVmzyds=;
 b=h2Ip5likyym2i9OwrVj+KnqjYQ5AvnGKLdYBCz0ZIKPUGwBwhjj8JVTfWOTkhvQp3GQgrDgV4QGtpBiA4cshSUYu5D6ae9y+V6gBNulCkG03sfwi4wrlpj/1T6Su9JtEcsbgm6c1aEamH16LUs76UcvfcwujxhbKbzEEevcZrLlrhoRaeELNcURjLvCpvbwBnbAdluiS/vaoAneEMz7jiGHUEk6byryj2vm1A6QE6DXMs9HHPhJW2vt5PVWMTVbsZ1thVFIs6zWN6HqbPG4VUqDnZMqAtpkgmx8qZH2zt5yfAujCHBjD+cVjbl5QqzLicf0hKgr4M6klIT3N6DM3NQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB7239.namprd12.prod.outlook.com (2603:10b6:303:228::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 05:44:34 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9678.016; Tue, 10 Mar 2026
 05:44:34 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>
CC: "wagi@monom.org" <wagi@monom.org>, "shinichiro.kawasaki@wdc.com"
	<shinichiro.kawasaki@wdc.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2] nvmet: move async event work off nvmet-wq
Thread-Topic: [PATCH V2] nvmet: move async event work off nvmet-wq
Thread-Index: AQHcptixhf7e+Xh4a0aud5WZEflxqrWnVD+A
Date: Tue, 10 Mar 2026 05:44:34 +0000
Message-ID: <010359e2-c219-4e2e-8b5b-5e86eda5653f@nvidia.com>
References: <20260226043003.160555-1-kch@nvidia.com>
In-Reply-To: <20260226043003.160555-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB7239:EE_
x-ms-office365-filtering-correlation-id: 1f7d7b02-8a75-45c2-8a98-08de7e681bd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700021;
x-microsoft-antispam-message-info: WoIvv+CTW7yiyR2zKqh3qbwgHDN4MuVqiU38YfoMqeHPrwW8mfXLDSFppOwic9Xrsz1fHgCn8ZcfQXxwIaADfkNykFOfzOk8uk8JWVLeXRfUls+hyPwe7cPmtwPbCWDHxtt2nGR7ir/C48KXYO60Mu9vWUOzToTY6rWM0zAbVy1BFadpNX8oD/mQWuDPd/4jlsv3Kho4sy/TO8YuEk2pSTH0BVV/ffwm9PUxeCkE4XqrrkOHe7YNAjGnejRQEn51suvP4ILpCvRT4Cn7Q39Vdn8PN6JAgMlyWrYoGHIcNL7d97XBnZ9huRmgjN3Ei5BLS1U6oBaHgRJ1l5i+pBHeF2qA419TGkz1NhYMYL3rctaNQBptLyPDNl6JlCloUSf9tPuQkEMU4LtqQvJmctN+QAZwbq/3zkbloLufnVgDndjVBkhQ6rOTMGuC1NPWUxu/KlymVYKdi/mKx1SzL2b9x/RRGpTM7/IgYdgdroa08onwXR2r8AKQfzehI0tW2nR9uw2setA3tiJXfekET3d0RWj+43+sqo/McbXt/pfLDfWb5q/rtxbhvkpgKHkGmVXpMkpHOoiETRtTYb8S0eJlf5/9ubu1dypcnAAiLpwf8kcLwn5j++ygQaJClWGLdD+Z+oQgsNTXJrhrRw7rKUCs3cNyT2mM80s33OQNMqpSWRcm+hJL4sDo7B2bEHRQ7oOE7iclvU6stM3ycllvDBXxXOHJhyK324l6KBPXOv9idApE/k2EB9thLEvSo53PGhzyljPXfo2Blujwgl/gAjXIfPjNP13nIC5aSCboCJrZ9II=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVRIVElvUUZNRUJMamVjeUZkcHpOam5Tc051ZktDeVJ5N25pOW52RUI2eXpU?=
 =?utf-8?B?RUJVWEQxbzNkWTZ2dzNNcFBoQTVwektHVXUrZ2RxTG8yWGxsNVlJbFg1Z3BV?=
 =?utf-8?B?K2FFdnFrOHgzY1lVSHpyTHN0WGNmeVhjcHE0eWRPTmduV2FNbzczRzBsNURr?=
 =?utf-8?B?dlk4anp1WTBjZXJTOFBtRWlEcEhiSlpMVWErcytkSzVDOTNKRDVwc3A2VXUr?=
 =?utf-8?B?TWRLTHgxU0pPU0xiWE1oK0JPTFlyNFJ5Z3h1ci9nYzNwUlhvQjNCM0R1azZp?=
 =?utf-8?B?ZnM0c01rOC9oMXVFMUF5VEtiSEtXdS8zK1A0UFhCekJwQnZqUkpndU5hQWdp?=
 =?utf-8?B?bWR3SDBJeHRSQXc5WXVmaXE4YmFKRVZHdG9pUFNBeWI3alcwbjYvQXZFK0w3?=
 =?utf-8?B?cHpZeUxLajRGREhaUG9nUnhNU21JKzdSb1BKTlhYbG1HOVVoVmFMNmJjUFNP?=
 =?utf-8?B?R1BLcnZ5TEh0N0hkMElQL015OUhFczZRb0Z0d1RDa2RQVG1mL1BLbHZUTHB0?=
 =?utf-8?B?MjI3MkNjQ0lKUm81SktpMDEzUjJXQ3laK05mMHdJbTFQOWl5M2x6dXlmeXh6?=
 =?utf-8?B?cHVCSEhaaDlTbjZJSnlUNk9LQnhQT2ZQSHl6dit1bFdodmYxVmVFK29pZGJX?=
 =?utf-8?B?NlV6TEpSdFVoTkt2NzhOK2V2NE9rZE5XVmU3b0QxWDAySW05ZWIrYVpzZDM0?=
 =?utf-8?B?cERKanloWXVqNndVWkxGa1ZOSHdSc2dyZTFYallCWjlXRWI5TjFqR1JKVmxR?=
 =?utf-8?B?cWtOdlNTdVE5anQvRGQxRnV3R25xbzZLMUg5MzAzUE82bzcvWTNxUTdmd3Jh?=
 =?utf-8?B?K0xPa3NHRmU1WGZ3ekxZbnpubEZoWjNVSm8yaTA2cVU2MU5jZ0oxWVVCMEdQ?=
 =?utf-8?B?cmRnRm9UZ2ZZYVUzUEZBZFNmTWNMdWQrRko2em5nS211Qm5PbzduRzNLd1Qy?=
 =?utf-8?B?OWRUNDVndEl1MXY1WXdMSTF2TitHNm95V2phRmprSlorajN6MW9LQUZDNG5p?=
 =?utf-8?B?NTMydklDUjFqR3BzMmtZSnhmM0pMU3VLdHlKUUIvZ3hKbDhJeFNpcUprTUw1?=
 =?utf-8?B?N2UvQUhxb0lDcS9TQmxJLzl0Um82by9hNXpJNkNyK1NZR2JyanFoK0lPeFVu?=
 =?utf-8?B?ZVBsdURjbkplRHRuZWw4eUx0Zkg2NWtFN0VoZHZhT1BwV0RhL05mUTNhSEZR?=
 =?utf-8?B?NEgvZXVsUTduQklWRTRzdXA0V1MvOVN4NUlmWFJ5dTVMZUc0RjBRUWdYNmQz?=
 =?utf-8?B?cTdERkJ5SVpSRzd2RGdlYVBxbEUvVGc3dUppdElsRVBMYTRuN3NuVUcxaUpx?=
 =?utf-8?B?YTYwajVscjAzc3haeVlVbnlFQ3Z1WWI5WXRRU2VoQXc4UDV6UHhvTS9sSVdh?=
 =?utf-8?B?akt0STB4Z0pCWklzK0ZDWDlMaGNDL21FZk5ESXNCeGg2eEZFN28zQkpNZGRy?=
 =?utf-8?B?VXJPTVo3cEJnYnJySFhLNXMwMHJxWHkrQnBFZFhOUTNTbENBZHdMb1Z6MHdI?=
 =?utf-8?B?RU93VFl2UXFBSWU2cDNCK3QrdFdROTd1Wnp5NWdkZnJSWE5xazJXL29pMEdD?=
 =?utf-8?B?dGdLMVR4ZHl3OW0vQ2xlWDB4TW1lOVVQWkNxT1d2U3lmOTlQS0N4VlkwTUNB?=
 =?utf-8?B?Tkg3eFJ0dysycWkrMkpxVVdac2M0cE1FUFNPZ2NEUFRnT3R6Y3FqMDFlb2pt?=
 =?utf-8?B?amd6ZWhSOXNnMnpuV0hlVEE0eGtUMWc0RzhOTHZYZ2JlYXBIRUs2MUVqQW1k?=
 =?utf-8?B?N3lVZUlFeGs4SnNjdE90bGNmaHdsQ1M1bG9ocm9Kc0U1NWxKM2wwbmx1b0Ew?=
 =?utf-8?B?ankxa1YwUFN0ejZLcm42QW5tUjVIWlB4aDl1YmNoSGpaNUJjWVJRdnpubjFQ?=
 =?utf-8?B?UWQxZmhySy80Y0U5R1Y0THRETkkyZFAreXA5bnpVdnhmU3Z6SURuOEZhWTF5?=
 =?utf-8?B?YkRPMWlyL25qRjVaa1kzNzByNXpGYXJaOFpkSmwxNDJnNGtWd0NmUGw2bEwv?=
 =?utf-8?B?dFlpM3Azb3FsU1dHK2hyZGtmdVF6MkdqQXNsMFJMTVBzeUd3Q2psb0NOeFdt?=
 =?utf-8?B?ZjhwS0Z2OTk1eUFsL2ZFOW1xUDc5K3hIK3Z0dGlxU2xmQTdnbkVXeGRhbzYx?=
 =?utf-8?B?dnJYY1VMSktWZHlkcTdQZ3hUWTVseDRaY1VvdWlvNGpyeHMxYzNCMGFMaExq?=
 =?utf-8?B?bFNteGhIWjJIZHFubzg2NzhoQVNxUkczUGRacjVPaXlENllQSG9YUEFoMDB2?=
 =?utf-8?B?dWxwN2RKdmNOeU1UdmF5TG42K0ZlUUw1bmdHdUh2MXltenRMVjAxbVdYa3M2?=
 =?utf-8?B?QjRqMUs3YWxkQUhnNVNnS05LZVp5NkVvbERDVFZNcThuRzZ0c2tmK2FWVjFq?=
 =?utf-8?Q?3++GRKOJmhrBLITEMLRAnVM3s0vuwxbx2LXGM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3416370996509249ACD283D5AADD2321@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7d7b02-8a75-45c2-8a98-08de7e681bd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 05:44:34.1313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjjEfKtdSsa7YclENuptUxnJA9KfeDBuCXwVm5nXGG5hqp6BwtqGtJHTt5M0xZSQffaELUkVIm4kIH/0kNORQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7239
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260309_224439_934047_9ABE08F2 
X-CRM114-Status: GOOD (  10.77  )
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

T24gMi8yNS8yNiAyMDozMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBGb3IgdGFyZ2V0
IG52bWV0X2N0cmxfZnJlZSgpIGZsdXNoZXMgY3RybC0+YXN5bmNfZXZlbnRfd29yay4NCj4gSWYg
bnZtZXRfY3RybF9mcmVlKCkgcnVucyBvbiBudm1ldC13cSwgdGhlIGZsdXNoIHJlLWVudGVycyB3
b3JrcXVldWUNCj4gY29tcGxldGlvbiBmb3IgdGhlIHNhbWUgd29ya2VyOi0NCj4NCj4gQS4gQXN5
bmMgZXZlbnQgd29yayBxdWV1ZWQgb24gbnZtZXQtd3EgKHByaW9yIHRvIGRpc2Nvbm5lY3QpOg0K
PiAgICBudm1ldF9leGVjdXRlX2FzeW5jX2V2ZW50KCkNCj4gICAgICAgcXVldWVfd29yayhudm1l
dF93cSwgJmN0cmwtPmFzeW5jX2V2ZW50X3dvcmspDQo+DQo+ICAgIG52bWV0X2FkZF9hc3luY19l
dmVudCgpDQo+ICAgICAgIHF1ZXVlX3dvcmsobnZtZXRfd3EsICZjdHJsLT5hc3luY19ldmVudF93
b3JrKQ0KPg0KPiBCLiBGdWxsIHByZS13b3JrIGNoYWluIChSRE1BIENNIHBhdGgpOg0KPiAgICBu
dm1ldF9yZG1hX2NtX2hhbmRsZXIoKQ0KPiAgICAgICBudm1ldF9yZG1hX3F1ZXVlX2Rpc2Nvbm5l
Y3QoKQ0KPiAgICAgICAgIF9fbnZtZXRfcmRtYV9xdWV1ZV9kaXNjb25uZWN0KCkNCj4gICAgICAg
ICAgIHF1ZXVlX3dvcmsobnZtZXRfd3EsICZxdWV1ZS0+cmVsZWFzZV93b3JrKQ0KPiAgICAgICAg
ICAgICBwcm9jZXNzX29uZV93b3JrKCkNCj4gICAgICAgICAgICAgICBsb2NrKCh3cV9jb21wbGV0
aW9uKW52bWV0LXdxKSAgPC0tLS0tLS0tLSAxc3QNCj4gICAgICAgICAgICAgICBudm1ldF9yZG1h
X3JlbGVhc2VfcXVldWVfd29yaygpDQo+DQo+IEMuIFJlY3Vyc2l2ZSBwYXRoIChzYW1lIHdvcmtl
cik6DQo+ICAgIG52bWV0X3JkbWFfcmVsZWFzZV9xdWV1ZV93b3JrKCkNCj4gICAgICAgbnZtZXRf
cmRtYV9mcmVlX3F1ZXVlKCkNCj4gICAgICAgICBudm1ldF9zcV9kZXN0cm95KCkNCj4gICAgICAg
ICAgIG52bWV0X2N0cmxfcHV0KCkNCj4gICAgICAgICAgICAgbnZtZXRfY3RybF9mcmVlKCkNCj4g
ICAgICAgICAgICAgICBmbHVzaF93b3JrKCZjdHJsLT5hc3luY19ldmVudF93b3JrKQ0KPiAgICAg
ICAgICAgICAgICAgX19mbHVzaF93b3JrKCkNCj4gICAgICAgICAgICAgICAgICAgdG91Y2hfd3Ff
bG9ja2RlcF9tYXAoKQ0KPiAgICAgICAgICAgICAgICAgICBsb2NrKCh3cV9jb21wbGV0aW9uKW52
bWV0LXdxKSA8LS0tLS0tLS0tIDJuZA0KPg0KPiBMb2NrZGVwIHNwbGF0Og0KPg0KPiAgICA9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiAgICBXQVJOSU5HOiBw
b3NzaWJsZSByZWN1cnNpdmUgbG9ja2luZyBkZXRlY3RlZA0KPiAgICA2LjE5LjAtcmMzbnZtZSsg
IzE0IFRhaW50ZWQ6IEcgICAgICAgICAgICAgICAgIE4NCj4gICAgLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICAga3dvcmtlci91MTkyOjQyLzQ0OTMzIGlz
IHRyeWluZyB0byBhY3F1aXJlIGxvY2s6DQo+ICAgIGZmZmY4ODgxMThhMDA5NDggKCh3cV9jb21w
bGV0aW9uKW52bWV0LXdxKXsrLisufS17MDowfSwgYXQ6IHRvdWNoX3dxX2xvY2tkZXBfbWFwKzB4
MjYvMHg5MA0KPg0KPiAgICBidXQgdGFzayBpcyBhbHJlYWR5IGhvbGRpbmcgbG9jazoNCj4gICAg
ZmZmZjg4ODExOGEwMDk0OCAoKHdxX2NvbXBsZXRpb24pbnZtZXQtd3EpeysuKy59LXswOjB9LCBh
dDogcHJvY2Vzc19vbmVfd29yaysweDUzZS8weDY2MA0KPg0KPiAgICAzIGxvY2tzIGhlbGQgYnkg
a3dvcmtlci91MTkyOjQyLzQ0OTMzOg0KPiAgICAgIzA6IGZmZmY4ODgxMThhMDA5NDggKCh3cV9j
b21wbGV0aW9uKW52bWV0LXdxKXsrLisufS17MDowfSwgYXQ6IHByb2Nlc3Nfb25lX3dvcmsrMHg1
M2UvMHg2NjANCj4gICAgICMxOiBmZmZmYzkwMDBlNmNiZTI4ICgod29ya19jb21wbGV0aW9uKSgm
cXVldWUtPnJlbGVhc2Vfd29yaykpeysuKy59LXswOjB9LCBhdDogcHJvY2Vzc19vbmVfd29yaysw
eDFjNS8weDY2MA0KPiAgICAgIzI6IGZmZmZmZmZmODJkNGRiNjAgKHJjdV9yZWFkX2xvY2spey4u
Li59LXsxOjN9LCBhdDogX19mbHVzaF93b3JrKzB4NjIvMHg1MzANCj4NCj4gICAgV29ya3F1ZXVl
OiBudm1ldC13cSBudm1ldF9yZG1hX3JlbGVhc2VfcXVldWVfd29yayBbbnZtZXRfcmRtYV0NCj4g
ICAgQ2FsbCBUcmFjZToNCj4gICAgIF9fZmx1c2hfd29yaysweDI2OC8weDUzMA0KPiAgICAgbnZt
ZXRfY3RybF9mcmVlKzB4MTQwLzB4MzEwIFtudm1ldF0NCj4gICAgIG52bWV0X2NxX3B1dCsweDc0
LzB4OTAgW252bWV0XQ0KPiAgICAgbnZtZXRfcmRtYV9mcmVlX3F1ZXVlKzB4MjMvMHhlMCBbbnZt
ZXRfcmRtYV0NCj4gICAgIG52bWV0X3JkbWFfcmVsZWFzZV9xdWV1ZV93b3JrKzB4MTkvMHg1MCBb
bnZtZXRfcmRtYV0NCj4gICAgIHByb2Nlc3Nfb25lX3dvcmsrMHgyMDYvMHg2NjANCj4gICAgIHdv
cmtlcl90aHJlYWQrMHgxODQvMHgzMjANCj4gICAgIGt0aHJlYWQrMHgxMGMvMHgyNDANCj4gICAg
IHJldF9mcm9tX2ZvcmsrMHgzMTkvMHgzOTANCj4NCj4gTW92ZSBhc3luYyBldmVudCB3b3JrIHRv
IGEgZGVkaWNhdGVkIG52bWV0LWFlbi13cSB0byBhdm9pZCByZWVudHJhbnQNCj4gZmx1c2ggb24g
bnZtZXQtd3EuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IENoYWl0YW55YSBLdWxrYXJuaTxrY2hAbnZp
ZGlhLmNvbT4NCj4gLS0tDQoNCg0KY2FuIHdlIHBsZWFzZSBtZXJnZSB0aGlzID8NCg0KLWNrDQoN
Cg0K

