Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79292C54791
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Mar 2024 06:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MTqUS+RAnZYK4u91eFzIpD4URhXYihDa01cIjm6hMF8=; b=YUnVVrNQm/qrihKUBJwDM4qRh4
	UVbkTMPLKVXukd9Hj4hKWy4iDEmHIgYTkBn4dO5kuRClYsPV9DVFkiYmi3vrQFJNKP6ce6KS6V8Fx
	cPi+9jcq+yK/o3CdBJrQiy7AH4EpKXV/XbqRUiMHsaNth67ZZUVSrjYfx2UhRDmOW3FIcNDGNAq4P
	qg76wB8P9j/qam0pMoIzSgNeJ4fTb8bFWqazdCGF8bF46zW2n+hxyvTWIe16V57fqfb5uS2gi6YHu
	SPCMXMv1uKiNO6QXrBVZyfRbijfU8OR26z7KO7CNsmKxHxH+6pjAQlR+EqDeuu80fOi7KgIxf/q+h
	vMV8o86w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkHeo-00000008zs5-1tke;
	Wed, 13 Mar 2024 06:00:06 +0000
Received: from mail-dm6nam10on2061e.outbound.protection.outlook.com ([2a01:111:f400:7e88::61e] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkHel-00000008zr9-0lR5
	for linux-nvme@lists.infradead.org;
	Wed, 13 Mar 2024 06:00:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nB4oTbS1b+AAeT3c6qubvuXpPhz2JK8JhvielTWr8tMsgFbOboxjZVpsB45x3nrNTClseAl8YFe98NyMYYaVm3crRo+Xn8j27cu+mM/c+vKTXu21B3rOLsL+tZfzj0PUKSYvZY71FL/l5gqk/iplTL1wUWoUrA6jeD1HVIFPoiR9LMdWOYaMzq6Bh6UhlchQaAz4Sq1p8IQwXKJbiBijxZ0oqvFywN1RsdiEX6NsbD4aM/4v3YrU5NdGrEX/artd8jnkRm4M8+um3CxUxNllOMteJLwjAETMY9tAvr+MY99admRXbDSahFKEtBrTi0nmiGzKWpuwd1kSsPx45s1DlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTqUS+RAnZYK4u91eFzIpD4URhXYihDa01cIjm6hMF8=;
 b=MsGo4Iy1s4KLF3YhkU8nYEdHAFBrH+TuGAk2PfAOzqqL0lB0Cf46Q0OQAzQUznUSe9+E+udSif31XV45MfYhiqpRBm6Uc8n/dbqLUlLcG7Z7ALNXWEsr/0AoQcwwlYh7UruAaSaiL225KqPQ2ML8bEOiyW3kjwQKXBzkaRW1O672Uyp34Hg7xMfn+9IQ4tQUEl5vEePIzr+QPKeB5PQj57XDnRZW5BOnbdNpbulFtrlvQ47gRqSkVUfWzGQnldbd0hF+MjFLtQ+DKOa1yB3s5xgRZxE9odwVH1wepQrzEymCv4IiMfob9rGJaB0Sf7vOBiA54Or/DGSRTGOWYJmUNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTqUS+RAnZYK4u91eFzIpD4URhXYihDa01cIjm6hMF8=;
 b=OAiGD0dLIoCfqqZ2R7/dU+/pYEchyJqlifWt8VEzIg2/FebJvee+rf1QGL3QHjooA5oFLEZ3Ee0zwl6tGEPOnOxv0KBTiYS7L0m70Ulo8iDpulxUTXBz+0mCftNPdnPM4qQNNnfJfYDSS9tJd1zYkp0jROy1/JKNHVlB9WX/I7bmSOKlKFQzWUdo4Esh5zusjT03OGIWSI3H62Wo0sPVqVSLD58HV0V6lmLKv615f+Oho7SvSc5nAyXhYJsMtwRbCO7pU0mxJ/8SeTW13y9W0/NzH8HH9kc5T9Bw6nFLLxzXAx4tQphgqgx2liZUytJwB4j+eSamSY3Lzy4yqTQCdw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB7178.namprd12.prod.outlook.com (2603:10b6:806:2a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 05:59:49 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 05:59:49 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: parse zns command's zsa and zrasf to string
Thread-Topic: [PATCH] nvme: parse zns command's zsa and zrasf to string
Thread-Index: AQHadFJkbdq1BVZzSEyzDCVFcYrw8bE1LqsF
Date: Wed, 13 Mar 2024 05:59:48 +0000
Message-ID: <0A51F63E-5701-4E90-8D78-E0B805762D80@nvidia.com>
References: <20240312075243.91742-1-kanie@linux.alibaba.com>
In-Reply-To: <20240312075243.91742-1-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB7178:EE_
x-ms-office365-filtering-correlation-id: 68dd6623-62e6-4a16-c4e4-08dc4322cac6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mf4vnhxiHi++HnW2khXTlhqpHN6EgHqnEqRSZvm5XaBxzGzSK/mmQxPEiDnAwugBqD2JSAlfFmKNp6kUZvz55KdblVlctXiO2uHn0vqPdOwwpW4pWCaO16tAWJOnsaMyrX+E8rWRnLLNlSq2uXfGpNeiL+qL+if0wXd09wPT+x4oKv+B7pdPxKbOgeMPSy7v4y5UgbURexUK3bMS/rPQaIicYBG5grKtCa3UKxzhYPbR0RGyMGBfPXWzC1/HoWfXLlqn/zHmjQ0b3gCFw1KA/KZPyltX1tpgm10QiqC+m52rS4nPVCFUTl7Z87/9husRBuPIWxAVEzGkIWKf7sZ59Db98luIaM3AtxUNZ46D+yLtR35v6JZmUCf0/nO7Hrvq054y1dzSVExdQXKfivpJKuNu3L3ir7NQahs081TI9BQqNDpq6Rlogj13OES4R6P8CiNRW3f6yucWkqG72qdhCeN4B7X4bP+ZhdC0sB7wJApn+7f2tNC9iJEiQvZ4eZUEnpVXYkIK5iKn23ukezpnw4YnGy1ekwfPOyx/ioY8tczH+NEizxm6G8AUtehO+fxWQUFFznMORacMVAHB5gBg6nuEfjSOPLaBTtEAw3jWK6CmWTeRBHcK5HNxOkGYyyG56Uh7+r5aTqzNIHIBC99YC4cIUV8J4cBZojmOLFyG2+KkB2TYEBIV2sfKFrktbmV8sVIw2N8pbpzdlN7V8mqUqiAHFKiPn9je6yoVazAGbaw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWNYSGdtY1JHVjdraVdXOXFrK0Y3OS9ZSm9RMjdwVnZkNVF3N2FuRktxdlZ4?=
 =?utf-8?B?MlpBaUJuODFsK0xaakt2a0tQRDBVWWl3Z2dGd09sNVRCUXlMSU9IWHRRZVhm?=
 =?utf-8?B?c1BjeFp0czR4emlieE14SHZ1Ump1MEtwZ2gyd1VQR3VjRmFZakt0T3Uwb2po?=
 =?utf-8?B?ZEhtTVYyZ0x3d2RNZWN3WTF2VExnc3pHTjNWanl3V0s5NUphd1padytQbFNH?=
 =?utf-8?B?N21IQ0FoY1lxWFIxaVI0elArRCsrV0k2OWN4Z1RkRVI4VmVKdEdFMk1MU0Mz?=
 =?utf-8?B?dktHcFg4RDZEZ2tJeERWUk5rSjFxSGVTSDNaSFpCUFM5NTU2U1dDM2FjTEky?=
 =?utf-8?B?bHA2MjJRQXZGZXFwa1pKZi9DNlZrYU9wM0FsSVA2Mld4bkViV1l6d1VNd2pl?=
 =?utf-8?B?T1J2NXN0cTBZY1M5ZnVPbEpadGtRdndmdmtBTXYvaTkrQXlVbDNrMWVwclo3?=
 =?utf-8?B?aG4wU0cxamdSM2V1Z2ExL2M0WTdSUE43WFlUbVFOeWJ5YVdkVy9lOHVvNTFu?=
 =?utf-8?B?VEs3STlEekhjM04zZzlCcHp5c08rbmhLYzZCS1UySWllQkxKSlJoaVE1NnhO?=
 =?utf-8?B?M2pGekFqMWpSaU9neUNBSkRUdEthOHE2S3V5V0pJcVA3dlF3QXphUWszYlpr?=
 =?utf-8?B?OWFBNXZwejdvTk96Vi9NVGNiTGIrK01ocHFtR2NvUkJkbTV2Nnd3blpRZEVT?=
 =?utf-8?B?VWhYd0ROV1NCRGhTOVVsbXVaT1YwNkZSVXAzM29qQnpWdUt2UkI0QWhTbmMw?=
 =?utf-8?B?bTR0VVNQbkZHVFk4OXNxYko4MmE5cDE2VUtQa1did2xoMDRKMHF5QlZQWjVL?=
 =?utf-8?B?eEN2d2JEK09zcW1STkFNbUg1L3poWjh1TlZwSjFKYnd5d2tUYmVCc3RuNlBB?=
 =?utf-8?B?QVNaRDcyV3M2T3EyRmRCMk9UWDZ4elM5dmpzbVNBZEIzMXF2Zjc0OTBOY294?=
 =?utf-8?B?TnlnWkVUY1o4V1llTjhVb2ZsMElmQ05NZ2xBajdRWXVjaExxZFRiYzV3YkI4?=
 =?utf-8?B?dy9xYkUyazZHZHEvSHo4SHBLUi91bmtlVWZBbnEwM2VDRHNDU0kvTC9BQXdx?=
 =?utf-8?B?S3duMlpsdXcrNkUvaVo3dmlOcUNQS1ZnN1JYdUo2U1hGQnpnUTVwdkhXcXBn?=
 =?utf-8?B?MlFrajhzcEt1cyt0Y0R6elcrcDVGVlF3UU1IdnVway8vak5LeG5mZ0k1QUw0?=
 =?utf-8?B?aFJtRlQrckRndXQ4K29Yd3A4d0VGUnJNOE13RTJoMExVWnUrUU1rQWIyM2hN?=
 =?utf-8?B?YjY0UXc3Z2ZHUUtYU2NyMTR3UEY3KzdvS3oycFFveDFQREhVZ0NqUC9meWMw?=
 =?utf-8?B?VTdTOHVZajlpQ3AzNWZ5MzFZcEkrdUVLY3FobENrc20rVXdFWmpJMVp6L2U5?=
 =?utf-8?B?c0JVNXBnN09SbXZqSHQzdWRmZ3I3ZVpsN29wWkxBaU52TGxMV1NscktDWFlL?=
 =?utf-8?B?UnV6QnRWNHdqL0l1Z2Z3Sk4wVUpyN1NuSGFwcGowaW1ONk1ZNVBxMVJTODNG?=
 =?utf-8?B?eVJqY0tvblV5N3pReGRCNlF0eXdMK2V2cE5obk5XOERyendYUW1NbTdaM3BC?=
 =?utf-8?B?Rk5XbGE1QVN6R0RNM0RLVlAxTWNFOFgyQzZnMUZvVDhsSEZsNEJOam5lTmVH?=
 =?utf-8?B?aXNBeDljci85bkw2TFIyQWV2cHp6YzcyOUZLK2FkbGFTbUdnemFJSkxNK1pq?=
 =?utf-8?B?U2VWZmwrSkF5cXZndFNnZG40MUxmMkk5WFhPQ3REbGE1cHFuTlFBdzhKcXVJ?=
 =?utf-8?B?ZHNmcWJNZGl2cDVEOWJlOFg1ZTgvZUpRRWowU2xRVUtUNGtLcWgwa0kvcXps?=
 =?utf-8?B?QmltTkJMWjE4UGUvcHVKZjV0aVpKYXBNRHBxRDlLdmp1b3A1M2hSME9YVWlV?=
 =?utf-8?B?YzNUdGNjb1ZidEJYV3VtMkw5ZC82MlZJMWhUa3kycnpjcDlRTGhEcXcrMGdr?=
 =?utf-8?B?OWk2THdLeGdOaUJ6Rk9ZM3hza0lvTERqaHF6THFPYkJLUHMzWTBMdUw2YTdO?=
 =?utf-8?B?QlBsVlkrSzJEc3BkT3JJdDdDdWtWcGdvR2RPendBTC9pSXh6dmZ1OG5mYXM5?=
 =?utf-8?B?NnBVNTYzbVpZNW9rQ3RxcytVYUd3bENzVk93WnlnL0NiVWhWV3VwNVpHNEV6?=
 =?utf-8?Q?PdozOVqH8ymUqWxMDjViLgIcF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68dd6623-62e6-4a16-c4e4-08dc4322cac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 05:59:48.9611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YaJWfe0JJTBiSqUFaQTHZI6AV8AF3+enzWm9wpGw0GL3o8maPWTh9c60zic1kqUylUC5Akt3beN9Zj2PSln13Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7178
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240312_230003_265588_64855C51 
X-CRM114-Status: UNSURE (   7.20  )
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

DQoNCj4gDQo+IE9uIE1hciAxMiwgMjAyNCwgYXQgMTI6NTMgQU0sIEd1aXhpbiBMaXUgPGthbmll
QGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToNCj4gDQo+IO+7v1BhcnNlIHpvbmUgbWdtdCBzZW5k
IGNvbW1hbmRzJ3MgenNhIGFuZCByZWNlaXZlIGNvbW1hbmQncw0KPiB6cmFzZiB0byBzdHJpbmcg
dG8gbWFrZSB0aGUgdHJhY2UgbG9nIG1vcmUgaHVtYW4tcmVhZGFibGUuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBHdWl4aW4gTGl1IDxrYW5pZUBsaW51eC5hbGliYWJhLmNvbT4NCj4gLS0tDQo+IA0K
DQoNCkxHVE0uIA0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlh
LmNvbT4NCg0KDQo=

