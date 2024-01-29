Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11B1C47422
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 10:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yt2y1YLqm1FSeW7D5/+KLTJ05xPjPLyFoy7BgWLtyRk=; b=yuQVH//mREOvqLyuDXLpavSYrF
	P8LgbEdPfiSNPCEKjUIEnJWUODA7lafP0sOEkctEtpvmU6J6Ia9FCg6IbKSF8bnMmAGVswivEh+o5
	kvnpOJtgrLK4n1A/TObp082wV8rRZAstOJ32uz4hv1H2GdNnl8F6FtFSjKlOj55aB2gaaB/l2rvYX
	z97s+32bWcWF1TzKt+qAPkEvgf+tfvkbaIR3mEP9DaImtcU25ydjal7RP74HOy/6ehf8we7N68QtD
	Atr/HTW26zwu3o25eG7aYr/aHuRbLJsrd6Qb8/QNBi0TmLUGU2ONbslLRtv1J8AuLJrMlSLPFrLXW
	vdeSwNIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUPKa-0000000CJnf-1VTR;
	Mon, 29 Jan 2024 10:57:36 +0000
Received: from mail-bn7nam10on20600.outbound.protection.outlook.com ([2a01:111:f403:2009::600] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUPKX-0000000CJm8-1a0Q
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 10:57:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xa5vVAusxhuKvMGFH/psnrNgNflhd5Gezn0NSlDPpiVDr9XKv+fB/THNamjHj37B1axXjBrDFrrMdHEMG0M1bg3/KZMJS6MBXMRc/jdF32sbtLlVVNqx9ZEuzK4m8GmlnIaEUyVpDJQamwXZGS4bNU2vIQAHPko0Av7PCF23R0gUAcRyQYQyOam3IC7E43VzVoTsVdT6g1cO9dmcRPUpBZBrFWUfTx5MHnAUouor3XP4+HLIUwQg9bOlSOoycctEBFs2U54JWla7QbtrzQuhZkOlg2dPGQW7n+Zf3AEpk0hIGPa/TDk/gzNJMZGHc3A23MCiEdjK09CCn2JJfVXD+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yt2y1YLqm1FSeW7D5/+KLTJ05xPjPLyFoy7BgWLtyRk=;
 b=mWy7pVsr0I9nQuWTAmK5lrtxWXfAb6qFudjZ1xRju0iS/T2PV3iKzf3TKMSHA7XB9oSRBBXpM8tfYascpQSdG8G6cTh/ih5b8tOI1lFE7uc/LDDCATPjmyz0hBmW2Hei3Vxb22i0V+v9k5BNXmkCXL8nLakChUpZettWuBvMwNA2CrmExG37DU26iS7h++8d4WV6j2RTRqHugSVLSIG8SQOanh20VVgnvuvRz64u5BljAXJrMKXXRZQKd9cK8Spolpdvt075AT8B/n9y9Yqjhyg9deB5ZPFGU+q4qlCdaD5pf8f0G+eZHlTex1IghNCE980zPdI/qRZ6i/pRaS3d0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yt2y1YLqm1FSeW7D5/+KLTJ05xPjPLyFoy7BgWLtyRk=;
 b=feuFSuPVSyJc0mG5Sv3FYbmp48DIRwBIYDdYNm9+YGqg4FWtnHUfXk/A9FpjQR31qQWN+ZqpR3VIbx3Yx57JBl4vB0EHndAazRNeEqNUQ47h5bhhIQDOobz0YEsOAGFm6bVf1nl3b/Ax+bXYfGEesmkkQ3ZEPy7JvMLKglBifcCO765NAl1FpFo6x6PJ8N8Va4ElDjzHrw2WQIjeDqJaLpzuzCRDozi2ZM+J0Oz7ZAZovcwu8u/ip/nAEBWyD45kO2UzDb0OmKK6DfxmGa42vfKGv16S5eot3oYlswr5qciiinr5VANPc0Ftl7okhrFLyrEs2F/ne/BM+CtU6vHRig==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS7PR12MB6093.namprd12.prod.outlook.com (2603:10b6:8:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 10:57:23 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 10:57:23 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "Nitin U. Yewale" <nyewale@redhat.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "jmeneghi@netapp.com" <jmeneghi@netapp.com>,
	"loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH 1/3] nvme-tcp: show hostnqn when connecting to tcp target
Thread-Topic: [PATCH 1/3] nvme-tcp: show hostnqn when connecting to tcp target
Thread-Index: AQHaUp9gmz4z8H3FeEqhPXc9wuaE5bDwnp8A
Date: Mon, 29 Jan 2024 10:57:23 +0000
Message-ID: <c94e3908-5701-4cb1-882a-605ea204dd13@nvidia.com>
References: <20240129103759.42653-1-nyewale@redhat.com>
In-Reply-To: <20240129103759.42653-1-nyewale@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS7PR12MB6093:EE_
x-ms-office365-filtering-correlation-id: 7dafd2e0-9f18-4853-c10c-08dc20b9128b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W/r2E29jzPMi/fOUYa/IWNUvfEKxF798GAwcrSlZKuEHEMy1QYIxIeXCEVUFKTtiTT+hZ2XsoSaugcHODZTJaQIjBn92lAif4JSFFOA1rCFLp4J4c8+hj/s60HNv+pV1zWKCidvVJka/0aKkH1y4AfRrjjebIOXMg5zX+dBX4OeIJU2HvOvadSldmsJGktQa2GJ48Ar8/HE+JD0J3cefPA9CxH2Y1MokuJS3TJhjpQCM6YTK+j34walB8LQkv8Vobnvoq1cXVUKsJggHDd2gouQiGoKbDGjaG2y8pebTj5fnsU2cj9F0x2DuucFVfYQGQcEfOL/FcFFU2DLGbdFlDvFpEQpBYohSXcSX0/Q+81mhHnOVD3kPtiSt0k1B/w4FTmCr5AUcLxgVw8RxFiU0cwmiHjPq6GTa3C5j3d1GEzPnmak1joUMQwN9KUbaCmKajNkAgEUjFBL7TzjoVzR5RMumYMVVp/Mjfw7iHtK26EF3YultFh2I4p9sp28Ny47z8At838HWCI7Y2nO1EfuP4rLCit4Jw/MEkOZM/SrJm+TFTEksruFICXnuazfNo4oTcsILpiZ8t/rAOvGnB97ZFSbF3JAYSQ+ZL+SzeDO08raJ9EOjoEcg5hI+LFHqJdKSq9TggrWqqLCTrs4ouU+vRMCvX5RGNJmu362lRF6mRQst+sXYiSp3WwF3kLGCzKel
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(366004)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(53546011)(6506007)(6512007)(2616005)(38100700002)(122000001)(5660300002)(4326008)(8676002)(41300700001)(8936002)(2906002)(478600001)(71200400001)(6486002)(316002)(54906003)(64756008)(91956017)(110136005)(66476007)(66946007)(76116006)(66446008)(66556008)(86362001)(558084003)(36756003)(31696002)(38070700009)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkxOZDhyQnNiZUZ3STFldVJKTHFuZjFZa0pwNjNjTGNMQm0wWmNkNTNkVTNS?=
 =?utf-8?B?c0lzNUZPVDhNcUJBQmlnOXA5eS9Vbk9vYytEV01xQjQ1bTdWQVRoNUluMUdj?=
 =?utf-8?B?NElXcmhIWjV5SlptcGFuakVEWjg0UVFOL2JNdFlyTHhwYjZqYkI5Nko5UHZ3?=
 =?utf-8?B?SVYwVXVldWk4bTk2Mit5VlRmVEVIbjZ3T1g1aGE3N01PNUtOazlCVndVU0hM?=
 =?utf-8?B?WjMvUGNpREI1NE54VTBrOVRWQ3pYdmhYQlJCTUN6eFFNaEZtZTdvK0VlREtN?=
 =?utf-8?B?QWxGeVJnLzdrbHE5eko1ZTRRQ1A5UGMzTnh2UnFuZkZWVGQrUDFGd05nQ3hk?=
 =?utf-8?B?cDNuanhkRTRvUGdmTTdHTlVBV2hTZXdFbWFpb1d0TGpidHc5M3pqcWZncVBJ?=
 =?utf-8?B?bXJsTGF2czBXNzl5aUhvUFVYN1VueCtUTG1GMHc3c1p3ajhHSk5FTm1tbnlj?=
 =?utf-8?B?eFFlcUhWbEEyZFhESEt5STAvYmhXOW1tanQ0NlNwR3JZLzdvRTV2WDlKWlJZ?=
 =?utf-8?B?YlZSZlJYUENxS0xZMU1ILy9GYStEMHg3azhETEVNMmVXVHRET2o3N204SHhv?=
 =?utf-8?B?Zkc4bVNBb2grSDNZd1lsbzUydnJvS0RFSFZPQXdKRGkvVTNwL1Y5V2Zrang5?=
 =?utf-8?B?T2dXQXorY1oyMU9maFhhOHlXRU5adEZTTytuU05lZ2dtRXNEb0p0SEdDb1Rx?=
 =?utf-8?B?ZmZUZGE1NjUxZWFJY243UFJ3LzIyQXZnT21lYnpMankwREpoK2FYSWpJamp5?=
 =?utf-8?B?Q2JBZzF6ajhmT1NiZlNYMUsySi9NenFqZi82Sk1vSHJsb3NOSnRjRGRzNlpy?=
 =?utf-8?B?SGRXZXZxQ0dYYkVzZStOWXRGenY1c2NvVTNFazRJMlU3UzlvU1d0RWNONU5G?=
 =?utf-8?B?b0o3dU1iZTUrZk4yVEN3L01Sdlo0Rk4rejUrS1RsQ09GV2lpQjBqMTJqdXZK?=
 =?utf-8?B?di9ISlpxcjZuTm0zM1FSN29YQnBNdmVWWUtrbDlZMXRBWUovdnZrVHY0YTRH?=
 =?utf-8?B?MzJpWEV5Y3hGbHdqSEtZVS9jWFFUOHJkZng3cDFhWDBhdk1DNnRZU09YVEpl?=
 =?utf-8?B?YVk5eWxNQzl6YzdJWWVnUG5zZXMzY0h5cEZtSFpESnFzVFEvbEJDc1RRSDZR?=
 =?utf-8?B?clNsSG9XaEp1dk5NV0p4VTRaZmY4b1BDcDhjbjNZOWQ3MU8vck03ZHh4MENx?=
 =?utf-8?B?S1cydG45b0h4UXR6SENaKzB2UTdPTG16N0poM1BJbnJqUWZwUnNOOWdDTFU0?=
 =?utf-8?B?U25WZ1JOTUE3dHVoZ0kzZEdMdDRxNlo3TDhXZHNkdE5raUFEbGFzTFlmZHdI?=
 =?utf-8?B?ZHB1MmxJK08vVjlsWklWVi94NHN4QkxsaWtyaXBHTXB6dk1QbDRmYkhuNGRt?=
 =?utf-8?B?bjV3TFMyMStyMndMUVRQYlZHdFcraDlGWStxT3VGeXd3UVZrd00vMnBHQ3NV?=
 =?utf-8?B?NnY1NUZLUTcvcGp5VlRoeG5pdVpJRUxwTE9XbnJ2ckRJMVllcW5LL2UxWlQz?=
 =?utf-8?B?YjRvYTFIWkNTY0RGOVhDbkg5MHdoOXZTMFBMbG1ETXZ0b2FKSDJPL3AvWjd2?=
 =?utf-8?B?dmphbHpZaVFrZVhnRkNneG4vUG9uVWh2UnpqTEZFbmVxQmZPbEM5NGh4TU04?=
 =?utf-8?B?anJET0hibWV5R2pETGQwQ0hkRGFJMFlqNWdZbnR4UkJnYUxkZW5KR0RzYUZi?=
 =?utf-8?B?TG1YRXY3OVY4d3lXanZjOExvSW10dEdlWGt2SFJLSEpoL29PWTc0M0NMNmgr?=
 =?utf-8?B?YUZxME5xaHovL2l3N0p2aE55VXRSZVVJM1JTSEdtWEhBL002aGhUc2FZWDRu?=
 =?utf-8?B?WkhpdVkwYWxUTitvcXNleVRoTHZvMkovZ09vdGtCeENMUG51VnZROEV5amFw?=
 =?utf-8?B?SmJ5TnhrNEFBVjZwa0djMmc1YWFDVFVTUU95dWRXUkdaV1JuaHNaM05OalJN?=
 =?utf-8?B?TGVVOXNYalc3QWpQL1orUE9tN0xja001UWRRZjZyNEhjRzRiYWR1d0dnMGtx?=
 =?utf-8?B?clhJbXpsT0lwVmlySDhvOUg4dExVKzRqeG43cnpVQnVtVEhJNklFU2lWazdq?=
 =?utf-8?B?T2dUNm83RVh3bHlsZVZ1TmxPUkFDTzhuMXBuYUlnRVhYS3hKaTBTc3UvK2kz?=
 =?utf-8?B?d3c1cldBYjYwN3NraGhYOHpyNGVvOTFKdXgwRGxkWDRBZHlDbGI1djlRM0Y0?=
 =?utf-8?Q?aqID5bQVDroWoyYhz980wV8ABWR+nSw93MN1+kYDnBN0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <701377AFA431C7478C3AE89426C49E09@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dafd2e0-9f18-4853-c10c-08dc20b9128b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 10:57:23.1787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZPLiUchatlaw1fV3bL7J19gmhHrE5peIWaSa8DwG1OraA0ERI73ngBT51Y6F38bo3waRPkEYyDhNiNyqVqPOSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6093
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_025733_480861_0DA82804 
X-CRM114-Status: UNSURE (   6.66  )
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

T24gMS8yOS8yNCAwMjozNywgTml0aW4gVS4gWWV3YWxlIHdyb3RlOg0KPiBMb2cgaG9zdG5xbiB3
aGVuIGNvbm5lY3RpbmcgdG8gbnZtZSB0YXJnZXQuIEFzIGhvc3RucW4gY291bGQgYmUgY2hhbmdl
ZCwgbG9nZ2luZyB0aGlzIGluZm9ybWF0aW9uIGluIHN5c2xvZyBhdCBhcHByb3ByaWF0ZSB0aW1l
IG1heSBoZWxwIGluIHRyb3VibGVzaG9vdGluZy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogTml0aW4g
VS4gWWV3YWxlIDxueWV3YWxlQHJlZGhhdC5jb20+DQo+IC0tLQ0KPg0KDQpvdmVybHkgbG9uZyBj
b21taXQgbGluZSAuLg0KDQotY2sNCg0KDQo=

