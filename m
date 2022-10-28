Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA7DC38A02
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Oct 2022 16:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GtEcoxfh3MD1hdzndHuH6KdYfnRxB+jX8/2QkTGR85g=; b=JgAS8iOjR6mOL4xKgKgYfzh74E
	d4KX8yCs++yCYViadXMWgMLpUTXc5Xkiv8m6rvCSvT3vxL8QTVr/aGH6AyacanC5EO49i9eJhlrk4
	S3N+uWhxOuX+5D6NE5K6BPBNtVoJTqcJ7Ct4AIcM+iLDpItWfnrzpqj2a10ALZl4jK10VpMBgaYe6
	fUTPXkE7Kgvw6klMa6MdV8EvRAyFQk5yxwMMb4gqv5PIZ65as4gbP4zAS+63suGoMezmUZWQxU5Bn
	W5GvIAGyII3c1pCMhdCe9mJfz1FRizYHHtFyXJYz6B9klXb9EiyEX11rVFJmipZJSIhmi2QpQg3vR
	jUOnS+hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooSXp-0011UY-6T; Fri, 28 Oct 2022 16:49:21 +0000
Received: from mail-dm6nam12on2086.outbound.protection.outlook.com ([40.107.243.86] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooSXl-0011SV-Vh
	for linux-nvme@lists.infradead.org; Fri, 28 Oct 2022 16:49:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqwnSXJaZlU6v4YWfRNZx+W0GaTxLvnBQz0NdTgWqgJwXvAhQO9EJ6scxXKk5O38tuVklWqvIR2MdMkW5r3LHfw0AoHNPrtxBj/kifAbAOCD6FI4SrQxiKZuqN9aXBB4urtjpILujwiErlVl+oQL+tRfHAuc3YSwhGMWMUDADmGCdAJ52x03ZAtdsaV4e5ErI1mgDPU33oXiHCJo+BySm61Cv9ziap8IMhMxPmxmMEcwcHrsolTt04Bi+a4MO6m+udoQf3Beu+7AjN4JdRV19ErZZZjfTwAzU3OimfswgwMkJcOzLCAMWMpCETTlS71j4ECvpWqSC80GjgMIMdpdUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtEcoxfh3MD1hdzndHuH6KdYfnRxB+jX8/2QkTGR85g=;
 b=SOxGxQ3nJyJZD6NHe26R+ZS5ZRQ+5/HEDUT8dZq7ubOdfYLjSMFCaL7carx9uU7DG0lEDkY9Vv0DwgZq8WcY498h7ZLuP5rjzaRg4HgoiZAhAU5jaFP1JJRIkF6+x1nnkjpGS+XBXa46qkU0FYZbKv7UvoA/C5un23vnQS6q2A1W2wj2aWLP05j/Ms2BfbWT+i5XXkQu6aKEVRWeeD2ZB1LTqUokW0i2Ov47udUsbKv2EkgJHDqYvbPB7jWGGeS3HKKySj9nOrrh7X3WJGHvcuRB1ghK7t5UOBjsZFkKhp5j7esFbLx1G71yzjtx6BAEUiYBID2lNcsm5Q4EDScfgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtEcoxfh3MD1hdzndHuH6KdYfnRxB+jX8/2QkTGR85g=;
 b=ZCBSZBTWssFEITC4tCwNU58Jvck7HcYjIRzxg5FfarKKwAUsOdbqbUhaCxg9a7o5S8vqYwennwSyQIe+kMcwTEUJUItAJUThdQo3PHLKpA04batQjQCUNyYz5uI1ufoEynaTCEY9QCeUUepRBaQ8AvsOJ73zDrA4KKTyjmTMi7ixZh7PbWcSvHSXVAHesifbhbKeb2aCYFHeUheW47Wv/Q9gn2DpPetjRGw+GLIEsy2qyCLaIw7GxtdSHVLFcMGer8N3hytzz2Ma9CLPXSAkWIE0A9C0/5rBBLfWzasz96qP9v0aOmAs0IevJrRF/qRKfEUA7izksYLvY8LcAOYV9g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 16:49:12 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5746.028; Fri, 28 Oct 2022
 16:49:11 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"joshi.k@samsung.com" <joshi.k@samsung.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Alan Adamson
	<alan.adamson@oracle.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCHv3] nvme: quiet user passthrough command errors
Thread-Topic: [PATCHv3] nvme: quiet user passthrough command errors
Thread-Index: AQHY6tvZE6ubR6ZAnUa4MftTsaqt4K4kBLHa
Date: Fri, 28 Oct 2022 16:49:11 +0000
Message-ID: <23014EB9-EAD3-4973-9AE8-12B37AA9D508@nvidia.com>
References: <20221028144435.1613982-1-kbusch@meta.com>
In-Reply-To: <20221028144435.1613982-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB5915:EE_
x-ms-office365-filtering-correlation-id: 4a939cbd-621c-4d67-5939-08dab904570f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  UcBGdcGwyBqcTYHGaiqE/BVAzNQNGkcaq13N1m6BnP+0GrLBs5DmMBa/ag9RYb2r3NQY/4iKS+Y1kQCvqD1lhT7ZXpm3moOWtBFtNgIAjIbX6bVCNQjvS2JOpy+4RDRQTkKFBFLS4WpGbmvmhbm53QXdDuRXiESzh//t2Y1httOWZhNmEB5977ZGi05g46ogrKzvW7TMkHRMiPwGs4TjayQJYb1/wApfunOq4dTLyRQjihYqw9HGaAJ5n2qjBufLfPfnB0YS/8/Omd7MrhpZ1pbkrC25dprUWOQWBfLXBWDEYwg1WoaB+O6tmmy3Hb2QOn/mkhX4iV04YtACHMHJU7Tezi4h9wN+Orl2p9L9Lu3xEs1l4SzUJ06vyEGyhTkssnW2MUQ1A47n8wtf0SfOoIMa7M6rrTJ+m6bBquyOD6mSNxAOtSWKCEaUM6dYgchAtGrMb+MgbjHoNIeKA6gUiI2lvt3DMr5QNrMLuGW61Q+Sr6WQ5iBBMqY5vhyXsF1LM2zL6AMFTie0t411CZY8vstOvFpdly4lBIYeoVccIE4/X/f9mXQKptjdwZNHLEMUeZX3WsyqalXWukJAGaSrPyD9H4ir7KJB3szwFaOoMh2S12qdS5J+vtioH+f7lXeanvQan0v4/4a7kl5cQy8Ovx6t+Y0t1g1VOOPFyahHZ8wnIS2EU3UaK4aCsCLh3R5psNmfECo7EtM8do6+SWvNP0QwpoEsvCGgN/Y3BQy0kBdNnSsocGclgLzltWFxjsUQtupZE4mkztzdYuVFTrRQNFLoY2kNiA7mgoWh3wqEp7Q=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199015)(478600001)(53546011)(38070700005)(6506007)(2616005)(6512007)(86362001)(64756008)(66446008)(66556008)(5660300002)(8936002)(8676002)(66476007)(66946007)(41300700001)(2906002)(76116006)(36756003)(4326008)(91956017)(33656002)(6916009)(54906003)(122000001)(4744005)(316002)(38100700002)(71200400001)(83380400001)(186003)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?d3dIOGx4dXIwdjN1bmdka0h0NVpRWXk0bmlpUjhwQWVCd05MOTFwTkhTSGJs?=
 =?utf-8?B?OEQ5eXNQbUJkY016NHMwYkdLTWFUaGNFR1ZpUkxBMWhGWUZTSzhOQnloZ0VZ?=
 =?utf-8?B?dzVkVzZWaTZhaWszV0pzazB0YXkrdWNSdE43aUhGMjUxWnZ0Y20ra0tFUHZR?=
 =?utf-8?B?aHFVcS9TUVBHZUd1bXF3a3ExVm1WZXZFTjBWbEV5dndXMXQ3c2xKTXQwUUxa?=
 =?utf-8?B?dVNMaE1lcDVJRkJ2K1QreUFKQTVmaXo3NmVGOUQrK1pzNkgzWkZpRVdHWHNR?=
 =?utf-8?B?ZkpHTGRFTWVEOGk5MVBoc0Z6TzZ1emhjeWlzMW01czRXbkNRd3VjYmRoZWcz?=
 =?utf-8?B?QWxvUzN3S2g0T2NRTS8zcW9VTmh6VElkWjh4SjVZVkxVQ3JwUnFOZFB0UkdM?=
 =?utf-8?B?djh6R3lTb0hidmdrUEZWbFFOTzlBdFcvUHU0dm9oTVoxVThZV3pzNis1Q0tY?=
 =?utf-8?B?NElxbGU0SEwxU1B5TUFmL1BoRnhJTTIzQ29ETmx1bFUwaDB3SXY4VjRVWVlx?=
 =?utf-8?B?enZBOStMQUhHSE55M1hTZmxPbWxtTnlkcHlEZ1ZERGFnYS9RV084WVhkQ0Ra?=
 =?utf-8?B?ZVJQZWZ3dDVJME1JVzF3MGR0Wis5MSs1djArUkVldEpuRDZzbXh3bFZxdkk3?=
 =?utf-8?B?aHp6T1ByK09URVJ0NTNWVkpxcElRYzJKblZwK2lTbk9haTVOdjFHd0pJMWk5?=
 =?utf-8?B?ZDhCS01lVTErUVlOQXEzWWR4czh4L3B2ajZ1SldOemJXOEVocjhPcEUwQzdJ?=
 =?utf-8?B?WVBnaVJ5VmVGcG9aZTJmck9kTXNHcEhYZVhJcERQc1FMS1c5dmNKaFFPajk5?=
 =?utf-8?B?d0NPcDdBM0JTdXR5WW1BMkxoQ1h5RGtGS3lSUThaOTVBb0tHUnBnUWMyckYv?=
 =?utf-8?B?cEVVUG9FZmZYV2JhdVNnbHN3Z015dHR4dGRPK0ExbWRIUmx4U1ByVEVxcTlm?=
 =?utf-8?B?WTA2TVBKZXJwbjZxR01vMGRKZ1F0QnJBYi9kUGVkTDBzSXJab3pBVWVZRmFw?=
 =?utf-8?B?VGljRDMrTGNLaU9NSytTelNMVHBsMkpTelZsRzVQSEtZSXRoN0ZKd0R5Z2NU?=
 =?utf-8?B?L3hmWVNxUFJEV3YrMDBkR2VPdHhPZ0piOVBrYUVkc3NMUlVwZ09NamdhYlpl?=
 =?utf-8?B?Vk5PMElTQ0hidUVKeVdKeTYrZzVoR1VwNVFWdkNDQm8waXVRQmJLRFc2Snlv?=
 =?utf-8?B?MXg4c3ZqMC90QmhZc05YT2hPOWRoUDdxZkpnRVVkREFVS3M3TkZzMUJnQkc2?=
 =?utf-8?B?T0RMUDF4UnNvU0pGSmZxa0t5N0VhYmhnMGZuTW44TEFPb2VTajV4dlREb1By?=
 =?utf-8?B?Unk5MVRDU2g0bDFNWG5QK0pnVGtFaXlEanVySlBjQncrQ2JQQlFZbERObDZw?=
 =?utf-8?B?bjdMMUFpT3J0SC93SHk0RHlTaTBiSG4vV0J6dGVvRElqeUxNVklTcFpzaWNG?=
 =?utf-8?B?cU5iSjVGWk9pRVNJSEt0bnhGREg1aXVIZWhtSmxDc2EwRlNFN2tqSXpDakVv?=
 =?utf-8?B?WHo4eEZ2Tmt3NFQ2NUFJeHdFYUwvOURpV1lqK0Z2UGlrS2xwU1pDNUEzQVAx?=
 =?utf-8?B?R1owWFhzM3dNM1NTeStjMU5GMSs2TFJyRUZwaGFMMTRTNEc2WjNjVU9BcUJ2?=
 =?utf-8?B?cWNxSjdUeGNMU2laNDNIbXhFSU1qKzdCS0g1OUtsbjFjeURkOVpQK3JiUVAr?=
 =?utf-8?B?amozNURUWmdMSXMwZFptUmw1em1wVHN4bGM1YWFPck9qZmRNdmU5NDR0WklW?=
 =?utf-8?B?emVFanFVK3M0aGx1WTRRd0lFOEpJTi9MREZjajNYNkFHQnFJNGFwSWFEaW1X?=
 =?utf-8?B?ZEMxV1gvbE94NEVaY0VhaHJyclNRZEJxMyt3T3plWWZnZFdYRlRiYm1ETnc4?=
 =?utf-8?B?QVRTNXdXbHVsSStaVStBeEx1N1Jxenoya3JTVm1wcUdlcTB2anZTUkR0WXow?=
 =?utf-8?B?VTl2TjRGMjJieGNIMzVJNXRZTm5MOHV6Sll4T0prT3VtYnhVRHZUYXp1eStN?=
 =?utf-8?B?Z0xEUVgxQ0pHU2tQVEZtdTVseUkxVFNEODFqbDBYS2pXSEExektGYVRFWFEw?=
 =?utf-8?B?RFdzaFBLMys3STA3SWpEdlJTQS9odmlaVVBFOThkY0ljNnY0K1ZQNklUM001?=
 =?utf-8?B?VU52UmcwVkdDb0JTS1ZHM0lSNzhvSStoSENwTkdqTUdnRU00eUIxRGVEd3BK?=
 =?utf-8?Q?EGWEyL3k3hvegOLVT+nxN0CSP4YgYzftgczEsEI6yqUR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a939cbd-621c-4d67-5939-08dab904570f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 16:49:11.7352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Rl00C1fRfwF7HkZnbyMNHCYE7V45M03QKQYGmEd/u7HDja/ZtBkhP1dnaEpdfrdzo48rjFxsL6PrMhxSZ6+lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_094918_067427_530C12E6 
X-CRM114-Status: GOOD (  10.66  )
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

DQoNCj4gDQo+IE9uIE9jdCAyOCwgMjAyMiwgYXQgNzo0NCBBTSwgS2VpdGggQnVzY2ggPGtidXNj
aEBtZXRhLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79Gcm9tOiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtl
cm5lbC5vcmc+DQo+IA0KPiBUaGUgZHJpdmVyIGlzIHNwYW1taW5nIHRoZSBrZXJuZWwgbG9ncyBm
b3IgZW50aXJlbHkgaGFybWxlc3MgZXJyb3JzIGZyb20NCj4gdXNlciBzcGFjZSBzdWJtaXR0aW5n
IHVuc3VwcG9ydGVkIGNvbW1hbmRzLiBKdXN0IHNpbGVuY2UgdGhlIGVycm9ycy4NCj4gVGhlIGFw
cGxpY2F0aW9uIGhhcyBkaXJlY3QgYWNjZXNzIHRvIGNvbW1hbmQgc3RhdHVzLCBzbyB0aGVyZSdz
IG5vIG5lZWQNCj4gdG8gbG9nIHRoZXNlLg0KPiANCj4gQW5kIHNpbmNlIGV2ZXJ5IHBhc3N0aHJv
dWdoIGNvbW1hbmQgbm93IHVzZXMgdGhlIHF1aWV0IGZsYWcsIG1vdmUgdGhlDQo+IHNldHRpbmcg
dG8gdGhlIGNvbW1vbiBpbml0aWFsaXplci4NCj4gDQo+IENjOiBBbGFuIEFkYW1zb24gPGFsYW4u
YWRhbXNvbkBvcmFjbGUuY29tPg0KPiBSZXZpZXdlZC1ieTogRGFuaWVsIFdhZ25lciA8ZHdhZ25l
ckBzdXNlLmRlPg0KPiBSZXZpZXdlZC1ieTogS2FuY2hhbiBKb3NoaSA8am9zaGkua0BzYW1zdW5n
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPg0K
PiAtLS0NCj4gDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEu
Y29tPg0KDQotY2sNCg0KDQo=

