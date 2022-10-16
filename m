Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498A6C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 16 Oct 2022 05:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/hTl335QU4amuQ+gx1vXqiqJEX4QKELbXa1oA1paV3o=; b=khKSYLNI1hDgA2PwS0r7hdwINl
	xMISCiiEVj/MG4UmsHrV2z5lurt5I7pB5KHIKyhhHtaKCoTMVUJmgl4UsEvrm1yxazgTPIW/ctIIF
	xWm3Fpr740aprBnyu46BPFuxcVGWP41AZx9jbobITvRqmSDXKO2ck1Z4Wg0jnP8gWMKkrPbGYvXwV
	Mn/VFq/EnwJ1Hw9GPgJB8me3d3QRs4oep+5QOQ4jEXcVXNd5XggafPfCWzufWTmFRYQMHsvMavWyj
	3p59m2GcJQiWCv5Ttq9m3gKbk/uhWli+t2OIRhYwAccQ827f/OIW5CD0G8VKUhNRw8yzhFTv3/pbD
	H+YM3CvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojvzC-000aiX-6u; Sun, 16 Oct 2022 05:14:54 +0000
Received: from mail-bn8nam12on2072.outbound.protection.outlook.com ([40.107.237.72] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojvz9-000ahv-L2
	for linux-nvme@lists.infradead.org; Sun, 16 Oct 2022 05:14:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwBo5y6d1dSPDswvTEXKExA+IdtmZeplvQz4MIGIh0ifXiyjlkv0EfDsmKfVb/L32UQaidEfr0QneJUzPge1oJcDymuXL//88yq9a2BddEGGPnwElD0ae4LzgHIulAiPQGX5hD6iIBkBovFacul1ntdAZKDS0MbqbnwNKiCqO/erTB0aJcuwB1Y77MK9vy/OJdThw9t3eC3ULeZs0IPWvrOCbL6t2UNzBOhD3rzBAdS2ipXcRqK7hIWBACvXCTU6rdh7evIdU3gW6l7I8SPb9UJSfMmEKYfOB9rUjfF8SfkBOOkn6Ij6u2TSXrAc/qy/d8qNTJqqSBTrc+pyxKS0gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hTl335QU4amuQ+gx1vXqiqJEX4QKELbXa1oA1paV3o=;
 b=K/QOpaoCIONCDztNZiDgqi8P2g/dVqwPyarn+0T76yNEFjclzSZJkFKqhY4W9v/cqA9QuDvpLkAbRs/bu+dJTMxyi8qey35nIxTKbE3374NyMSH1xENon3iAz3j1pAIHY7fx/Xv1jxPJE5DGHwAre9VgCI+swM9TK8Azo+SAI0EJOxdGg0T1fXVpNW2AEQUm+Xka/ZO7TSFISvG5BSh8ydsJEec6OnfwVccwHU+pBiwSP97Mlumg6Is8xU1tZXrRADFArMoeSVUmoNMbZPYKQ6HngMk47flnRAXymtc2bAr0FrmetrR2ogn8KFUdIMgva5Alwke16SYvwhwHxO+9MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hTl335QU4amuQ+gx1vXqiqJEX4QKELbXa1oA1paV3o=;
 b=HOvXE8sbrWNbseqU11iDRHJm5qQyfgh7krpC79ijFFEX+bKFgjFHZY1paK1njp2iIWNwX8nhDmC6zyN5x3lkcE0FgisJiIXY2DkgQ8qm3s7y3bvVBaLaq0RDRWXxx1PALtwhbU5oPi4q+RLRHOXBSTPsZzV1BB3cMrjEZWZDknPZrp7e0PXrQqCUyQjmapfNkXUciicJzYqA04OXqQJdYRlMNAJE75oK2kifVxwTgW40ITfxl+XzvQifJ2krvgR8YZaCouJTqlIi4VvlkF4miDIhe/o88jA6l8WezBVd2UFT9fOS+apAUFyIrQAGIt4ao17eO6LxqS6sXl6wXqAfYA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW5PR12MB5624.namprd12.prod.outlook.com (2603:10b6:303:19d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Sun, 16 Oct
 2022 05:14:46 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5723.032; Sun, 16 Oct 2022
 05:14:46 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Xander Li <xander_li@kingston.corp-partner.google.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>, "paulburton@kernel.org"
	<paulburton@kernel.org>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "ralf@linux-mips.org" <ralf@linux-mips.org>, "jhogan@kernel.org"
	<jhogan@kernel.org>, "christian@brauner.io" <christian@brauner.io>,
	"jeff_yang@kingston.corp-partner.google.com"
	<jeff_yang@kingston.corp-partner.google.com>,
	"dora_chueh@kingston.corp-partner.google.com"
	<dora_chueh@kingston.corp-partner.google.com>,
	"james_liu@kingston.corp-partner.google.com"
	<james_liu@kingston.corp-partner.google.com>, "vincent_wu@kingston.com"
	<vincent_wu@kingston.com>, "xander_li@kingston.com.tw"
	<xander_li@kingston.com.tw>
Subject: Re: [PATCH] nvme-pci: disable write zeroes on Kingston SSD
Thread-Topic: [PATCH] nvme-pci: disable write zeroes on Kingston SSD
Thread-Index: AQHY3WGzngHDh/mJB0mLe1p3Vv0txq4QgaWA
Date: Sun, 16 Oct 2022 05:14:46 +0000
Message-ID: <8a38ecfc-9316-5b9a-6efe-18bc69733650@nvidia.com>
References: <20221011110642.4333-1-xander_li@kingston.corp-partner.google.com>
In-Reply-To:  <20221011110642.4333-1-xander_li@kingston.corp-partner.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MW5PR12MB5624:EE_
x-ms-office365-filtering-correlation-id: 7f895bee-b50f-4697-220c-08daaf355782
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  d54ra9/k5Zq2Di4t/2alSIu7cg1FhsDZWKOVnFFnpUqkoPAEc3jQ/m7yKnaTC0wuhwgPJPkqYK3Yc4SL+nzv3PBl3eDxHGkjuFxTMNce1bKL15O20sO6vSgVUJWDXFpyiTyLEYU0aslP4k8ACf3HNEkKRUmGKoxvVvd5mit3IDFfLdD4xL67xydqRNP99EjE6M+fdFMi90zYgG6joRZeYQalrXN2+t4NZajtn27aFudWLbO17VPbMlidZxfEdxE2PvPv38pkoODKu5ryQENjh8gqLZdg29kIjwSB1/6UGlZFDVzMNUBONsvgOwCAZFukvz2CG2cB0dgONCyd6NpV+CPr0lJIWJUwFhzGf0JVhUq+8r7lELYTPOnQ4EXe4WCezKPW1uvSuKkXBS7ozeiriWXnPGAzJrWw6ClHdarDy4f8v9He5knYv3MeMyEWHt++zC/SEy5I5LSIoNICpcS2REMqoXijtnhJ7j4H/wJoSIFXTAl/89GPGkj2dbtIfX04wAv7AokYca04RxFz9pG0BdzfYHUGbDTzTTak/0TCFROswlTLnXeBg379EdV6D67el0ZCVXTsGYaHPPqU2VLWCwdIBlW0Jr9HjtTib1dDOCC7dmLB8+iR61mXl9WhY/HTSUIknl3oX5SiTH0KHmFuoYEyadSM2sj5cQYG+tBFpR3jjnfXEOx+JOD+WCSwBCxLiQ0RziL2upCMJtouW1yMWi4CmImMSUEQpB818NbDZ01E6zqjnJFa8XPpj6l+ux1kVTVYSNf1Qay1SmZi+/I8v4RGqJ6H/q0kr383XwkWzkjDaYYTtuecgpCBsxDn/JtSrrmxIDAKVm9f8/Th5S1xEA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199015)(110136005)(6486002)(71200400001)(54906003)(316002)(478600001)(91956017)(66556008)(66476007)(66446008)(6512007)(7416002)(5660300002)(66946007)(2906002)(8676002)(64756008)(76116006)(4326008)(186003)(53546011)(2616005)(6506007)(41300700001)(8936002)(4744005)(36756003)(86362001)(31696002)(83380400001)(31686004)(122000001)(38070700005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?eFRCNWZKN2JKY3gwWTdBZm96Vkg1V0xSendoTTVDbHlOQkhUTmt4QzBqZWNu?=
 =?utf-8?B?eFIzMkd4N0QraDBhSmRKeUk0WDVJTDVLMUVNNHR4amIwa3R5VXVRaDhWRVd3?=
 =?utf-8?B?VDVRdXMyZ2twT2pzTDFBVk5pZUI4UWhnaGRsMnl5c0Z2OHBaL0ZDdi9ZZ0g5?=
 =?utf-8?B?M2Q0ZkpZbUtMMld3eG1maXI5WHdCRHhBVGYvZFNRMUo2WHdHRzVTcGs4MEJl?=
 =?utf-8?B?TTBFcGxMRkxIbFRKTWpaZGttUWU3SzNSZDdSZ05JUENMejZINTBEMkZUaUxm?=
 =?utf-8?B?OHIwSXNuaFdZWlM0cEVKbTJvOFJINTdOdjB3OStMSElpSXM0R1g3RXNBdkN4?=
 =?utf-8?B?VSs5TXJTM3BNa002NGc3bTYyVm9sQW9GUFdXVGJlMkdvSGFJYWt6TFpkQ3ZG?=
 =?utf-8?B?THIxMXVJcTVvOU5qMWRpWXVyYjI5SUs0cWZ4SjBtRk9VL0djL1RWZzVhRVdZ?=
 =?utf-8?B?MDRzNmVoajc0YWN0OCtWR2UyWXFoTVJCNkJNbmo2NmpyN3hibkFCVVBwa1la?=
 =?utf-8?B?OGFNOUFvNmVCbUMzZHJZMHQxbEtSRDQwdm91MnJqNUNGY2YwWWdBcS9UNmZB?=
 =?utf-8?B?UUZzWWo4S2Y1RUFNR2owTXFuNXZaRXNzNU1pZjduOU9JSGtZRGpONjRXazZ4?=
 =?utf-8?B?WkZmZHkyYjRDWUFzbTJTN09TeU1VZXZGMFM1Qmw1NkxzOWRXbHU4dXBUdURT?=
 =?utf-8?B?eDdoLzA4YzdWWmtVVlhReXhITXptMm8raGdaaHdWNnE4eXVGSkhPMmVoV0kx?=
 =?utf-8?B?b2pvN2YzUmpVMW5uMjhjRmt6bzViVkgxemF2WVdWM1dRbEowUmFLSUw2NzM1?=
 =?utf-8?B?MnJXNEVud3hyUnpYSVJqM3d4U1pZSFl4elJzeUQ5Z3hPQTc4NG45SHY3cHdr?=
 =?utf-8?B?TnE1c1NSREs2bGpiK0lTMzNacGMrYkNzMWJwVTdGM0puMVFvcGZYVTA0YW5s?=
 =?utf-8?B?SHRrWDFDTkpyN1NaNTdhUEtFSWdLTzVyQ3BvWW00ZWZLdjZJbkw2ejVrMUEv?=
 =?utf-8?B?a1IvTXQyVmJFUkQ3a3Vqc1Y4Skg1QWM5YW9qSE91TTA5Y3UvVWZsTTJyRmRR?=
 =?utf-8?B?aG9wa1U2NlhLWFB2d0VJWnlValhqWTBSZzFoNlhIYlhDeklGRk5lekV0cHpx?=
 =?utf-8?B?TnNHQVJOT25BRms4TStwQ0xkTThwK1Z4T0xlVXhWckEyRDRmM1dZd3BmN0xK?=
 =?utf-8?B?RXFPaUlHMk44eUpIYytUMGFXbm9TMFFKU2p5a3lTQ0ZCUTNsZ09kTlFMdmJP?=
 =?utf-8?B?ejk3eWxQeXFDbE9jQ3dycjlvVUhaV29iMXJxVkZobUdTWWc4YUhjNTk0Ty8w?=
 =?utf-8?B?Y1o2MjYxZXk3NDIvMTl6ZGx1WkFQck5QeXhCcjVRVmdaQjliNzBGZkxkRjNp?=
 =?utf-8?B?ZTQ1Rmp4NlphYXBtT2VLOU1uTzRPZW9hSUpBWVdyd0Vpdi9TZmd2YktSbU5k?=
 =?utf-8?B?cFhReGpodWMyWXg4b0MyRGZqdHlXTSsrWTM5VnVORy9CZVV4Qmd1bWJiNlo2?=
 =?utf-8?B?YWY0U1ZaUmJpZjBNYWN2MlRmVnNZUGJyTld4WlVqakZVcllxQW1KbUU4aXFs?=
 =?utf-8?B?cEtNQkdmMi9adVlwbmNUcEtKM3E3NUdabS9FU2pBakZuT3hITFVQQ2NkdXpq?=
 =?utf-8?B?YnBjOG1LMXFzcFNydEVnWjJBMEZFOEpBWHU4ZURkUHJ0aFZ1NXhYR2pNUXdM?=
 =?utf-8?B?eDJYUGZqekZrMSszSGM2NnJ0Nm5pTmdTdEhZelM5amhKUm9hcjNZVm9uRTI5?=
 =?utf-8?B?RFFpQVFiQjV3ek5qaGY1VytvaEFLRVpMZ3FPVThOZnBsYS9HVlI4cm9lKy9k?=
 =?utf-8?B?d2lBK3NuTlFlSk5HM25PeGl1bXVSck5iMnRxM3FRc2xjbG8vZHVRVjI2Nk9K?=
 =?utf-8?B?UG91NjVDeVh5aGJqNkZpZkg3bCtUYmVOdHY2RkRpdWtsZVBVVFI0RnJNOU9N?=
 =?utf-8?B?SGJrOVBiK05yNXVxcWFjUHVkbDgxRXFkOTV3Zks0SXpIOHhYU2kySVNJTDFH?=
 =?utf-8?B?VldYSy94Y3hTd0I1NEh5TGMxOExhMkV5MFNCZ3o2S09MaGFHSnFlQ0gzY1Zn?=
 =?utf-8?B?WjU1VUo3b3ZBM2lmeW9RckY5ZkJ5U3NBMjdMT2FGenM0NmRlWC84Y1ludFZL?=
 =?utf-8?B?ZHk2d3FYbTRxdndCUUU3U3NsekNYYTVPdWtrTzhjNVJWVDd1U0wvcDBYNXRE?=
 =?utf-8?Q?09M9c15DxO96pEjHMfA6YUgJae6sps2wvsAXCpBSvb7T?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33AB09D7DE915F4EAE05392C0E3FFFB3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f895bee-b50f-4697-220c-08daaf355782
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2022 05:14:46.1995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5u/VP2LyJ8sLTCnN4b9p7+0dXwcg68UPs/SCzBvqQULflAs2btnV+SDWjfrhUadOuIdW9RZawuZKooAKAZa9rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5624
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221015_221451_708978_49A4E7BE 
X-CRM114-Status: UNSURE (   8.15  )
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

T24gMTAvMTEvMjIgMDQ6MDYsIFhhbmRlciBMaSB3cm90ZToNCj4gc2lnbmVkLW9mZi1ieTogWGFu
ZGVyIExpIDx4YW5kZXJfbGlAa2luZ3N0b24uY29tLnR3Pg0KPiANCj4gS2luZ3N0b24gU1NEcyBk
byBzdXBwb3J0IE5WTWUgV3JpdGVfWmVyb2VzIGNtZCBidXQgdGFrZSBsb25nIHRpbWUgdG8gcHJv
Y2Vzcy4NCj4gVGhlIGZpcm13YXJlIHZlcnNpb24gaXMgbG9ja2VkIGJ5IHRoZXNlIFNTRHMsIHdl
IGNhbiBub3QgZXhwZWN0IGZpcm13YXJlIGltcHJvdmVtZW50LCBzbyBkaXNhYmxlIFdyaXRlX1pl
cm9lcyBjbWQuDQoNCnBseiBmaXggb3Zlcmx5IGxvbmcgbGluZShzKSBpbiB0aGUgY29tbWl0IG1l
c3NhZ2UuDQoNCi1jaw0KDQo=

