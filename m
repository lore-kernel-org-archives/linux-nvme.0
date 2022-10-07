Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104CBC433FE
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Oct 2022 04:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3s1rMsmsAqYOxGNbDasR55z4tPzaiyV0UrHeErev4Kc=; b=h/+V32wq3pH4Tl86bLQemwdUBW
	S2SaOD7KylVot9wfbxkILLIUzsptRBquT56rst++LO3dfD/sUCrJ7NZIYEWiAD/NcU24aiaOldiJO
	N7DCKNCRhnE+pQawtui4x6JCtqx3zlC85P2pu/C8pu9Td/X32QrptKnkMiZRPlgxMaPIUf4IKjSxR
	tUKDIdiwc1RS3VxwrXu4UaVxIzGrMxzULqGnuCsYH79f0kbmF2g/W4DAAg6/voajteWLt6Nme5tY6
	vKEqITYoe7M3HBozHCdg/+p5wZSWLx6l6QoutDXrNcM6mxUkjV1PlhjWwRognLGZj8SLyiXqVafqL
	x2F9LjDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogfSM-007GW7-9m; Fri, 07 Oct 2022 04:59:30 +0000
Received: from mail-mw2nam10on2066.outbound.protection.outlook.com ([40.107.94.66] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogfSI-007GUE-T9
	for linux-nvme@lists.infradead.org; Fri, 07 Oct 2022 04:59:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxbGdsIN+xSzcLBZ8s4JLYg1ZuHCLmAvzW97Kz6/6sCLrfs5ToOQ3Xval2QwCYqBIObB8UvkyPXwxU9tvUseEdn4kupgLD8klPth1OpHCHYd+OjV5Vl9YaadJ4gIRa9NqNk/gqjzNn6XnYy3sszZX3GTogffinxDpaFW4ZxoPBVTvDBf4wZCvyCtsuYMcsrrMAW/ItcjBslqfTiTZ8p7D2UD5sEYBPCML2VTX2P6ai2uWjT2BsP4QrXtft7Dw34gUSv+nDbt8HWDpzsL4Xbvfy+pHiXsuffwoJTGdVEqf/Xiiy8b1Gwc4zQKbPnxMWnceyVJPOjjeqk4UEPcN4PBRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3s1rMsmsAqYOxGNbDasR55z4tPzaiyV0UrHeErev4Kc=;
 b=SBxMPsbVRfC7V/xjdwnN9ERe9zK4EZ855MMv/iXF4juYhZqIFkYWQD8S/hQW2ysReAA63AlrITPCLhnNYErRJdT3x+jB5mscen+7PyHDREVm8jXqCNOjVD9o98dirv7FhNTb4loAi53CHZMUn4TmmqDqC42zGsC1mFVs8wSzbEbl9iS4CyAK48RNKBwUNPDvno1xt1KyKH4GScS3H0RVOoVUKzfCgKZF+9Qu9nwHNvhkUCHj2pqsLYcpQ1dMhpOSTKq+Sn6Del9htrJ3ewV72vIXgFLK95R5aAFZVwgQvGsrRSkCUhddV8tOtUgbvoyW4Hn0E2ImycqYnWTn7mq/XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3s1rMsmsAqYOxGNbDasR55z4tPzaiyV0UrHeErev4Kc=;
 b=fP+O94cmF1Ye5BjPbq7xgaUhpYyIlqv/EAfiuyMZVDmXzNdhxBDvYqAuxiVpnB1iz0PxTeQNZZCZV88yZ0Kvl20bSmbHqW7XepjuBRhpkltpy5ArVIgAH6ngRdr017heV6j8nnPTLbiBesLyIkw5u8UK0ahQZOMrWa+kuy7iOnwvZDydbYg4mJYzeFubbT2JJcHRqBdgbTQz/Xlw1jRbzyA2kWH/S6VP5H5P6R76yaR65tR6tSHOzFetaIQ8mXx3675LvXms9wlPqNRnCdLjIrrI7uZ8YnoJNEQGlOKG9dxKlare5yX4SlDOLWycHCQdX5Y8s2L8geZYHuyX04JykA==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 04:59:20 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::a1bb:b25d:8309:27e6]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::a1bb:b25d:8309:27e6%7]) with mapi id 15.20.5676.028; Fri, 7 Oct 2022
 04:59:20 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Clay Mayers <Clay.Mayers@kioxia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V2 0/2] nvme: Support user mode processing of ZNS Zone
 Changed AEN
Thread-Topic: [PATCH V2 0/2] nvme: Support user mode processing of ZNS Zone
 Changed AEN
Thread-Index: AQHY1FSLGEN8L/xoy0yARDTtK6PgSK39fimAgAEi44CAA8logA==
Date: Fri, 7 Oct 2022 04:59:19 +0000
Message-ID: <5b538b64-9c4c-25e5-91b2-91f9f627ec80@nvidia.com>
References: <20220929223955.3275715-1-clay.mayers@kioxia.com>
 <1cef55e7-26a3-abac-315c-5f7f56f4771e@nvidia.com>
 <6709778688ba4c58b21f832b96ddc73a@kioxia.com>
In-Reply-To: <6709778688ba4c58b21f832b96ddc73a@kioxia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4659:EE_|DM6PR12MB5520:EE_
x-ms-office365-filtering-correlation-id: d4593fec-dbf8-489a-0b99-08daa820b1b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  XHzqRLuRd1ckfLtoNdyjSThU8+7j7E7/h1HYNkQw+iWHS28DmqwRFecvcD4wjRxSiNQr2xXRBWs3ZTDzlvBkTWBS44IOuRpZ3qmZ5iaBLbYeRq5ttCGTZgcPYNUZj6gwTkk32gIh7UM/wpM1CA0yaimobG6UDiDBASv4E5sq5FslKKBiSwTaiaVhvOFjiHvPmieLgx287j4bCU2vh0f815VG425p9EHeW6BTfFPBDNeZEi7XQUDPLjzcBqI37FKkvxSfqfl45T2tpTu04nz3yppC4ldmxYl9Qn0JSHPirYJVbQzg/LtF14vzyZSdqNxCBrL3bGCHh3XEpX00JQt9gjD15LIWz+CkpJuPqfV0vlBycVZ+0xFKoN2RqURdNJKgjZprimc6hWgkS1ebHJNXXoZND3somB2NJFBahKBQn/BsRkauXlSNLmdf6BiozkgX85VOgUPSqrrpwGJlhjFj2xszlQLyZWCGY1IhXoFgyL4xbWR6LhOU6fPmff7ZDnBbuLcB/it367YQFEoof88VkjSYO8OLcS/9Tl7mT27jk6l1jqKJRPP1KEUunsEj73IW1lb40QoDRZ6n3vAZOMVH/00X+uZUK07O0XfLizGtLsxfXkLyQOlmH1UKxLFpwDIJK6+/DWs/YJV+Am94sdwv3sv95jAVijmMyIgW14N6mGqFeID5WGSVo3RAY2+dQx+HNrroRWE+nm/kCKbFVgnyUaNctTzepVUzLM/J9GMTM4zt7fGLz1dhOuYfawJOnON2ZQpYQR7zH/z6gMgxXHcYREEUrafXn8YBsa59vCa331ZH+SapVE0K7LdOmyVE0aqnpATZOgMUrCrpDSKRoUWJPg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199015)(478600001)(31696002)(31686004)(36756003)(2616005)(86362001)(8936002)(38070700005)(122000001)(38100700002)(2906002)(186003)(54906003)(6506007)(110136005)(6512007)(5660300002)(6486002)(66556008)(71200400001)(316002)(8676002)(66476007)(91956017)(76116006)(66946007)(83380400001)(64756008)(4326008)(41300700001)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?cmlIc3FxanpzSWJrMFN2Q2docnhsT2xhSHU1QmdLQUpvUlR6QzM5N3RzN3Qz?=
 =?utf-8?B?Q0NyR2NVQW5oMDVEeE9OZWF1WjlqSHhKL0tVWHBBY3BhVllHZ3RtRjZGTzNk?=
 =?utf-8?B?Z3NvRW10ODJZdXdoZ2JrK0dmRUwxTHd4SXdJdW9pKzN4OGhma3hvbUdnRWxu?=
 =?utf-8?B?RERiK0Zlb2dPOWRkZENvS0Vjc0FyRzVIUU5heVg2RXRoZm1EeWlwNFo0NXdq?=
 =?utf-8?B?azBxUGdONG16bTJTa3Q0bkl2L0YrY1NZVzA5SktMSUpucXFqc2ZjVm1aV2N2?=
 =?utf-8?B?cVkzbGdLdnA2dFhRcEpObVNyS3pXeVNCdXlteUJMYjdFOWkyT1B1S2N4WkFr?=
 =?utf-8?B?RCtHVHlHQVJVSGt2TTUvaytSWGdkUkhheGhTbHVDS21kalY1WVFRRS80bm0x?=
 =?utf-8?B?SDdPTmF2eGhGeFRwdXR3eHhYcTcwTGNUZTZ1bGNwdm9FWnNRZ01XbHRDMkF3?=
 =?utf-8?B?U2VQOTBRMUFCanJyT2FYVEZVN2IwZDk2N3JrUytnTWE4N20yekZDdzBaZDBl?=
 =?utf-8?B?ZTd5TkVMUFNtUnRHeDVVRm1KZUN2bTdmUmtPdUZzNG5BS1hML3Q1Wnk3bE9u?=
 =?utf-8?B?MHNwQm1LM0p2YStYcU54WWlqMmtyQ1NTZ1lrREJ5TVZCdUg1QnBoZ1VUV1g0?=
 =?utf-8?B?WGw0b3VYTnNQby9SQXhPSlZuV3BmZllJZ25hRnNlcTN5MEMzam1PUXpNL3VG?=
 =?utf-8?B?RXdiUEJicGJSWGdmdFN6cU12cHhjcXlVL1A3ZjYwbkh3OGd3WW9VdVhFYmdr?=
 =?utf-8?B?Q0E2bVZuSU54V0Q2ak1YajN6NjdNT2Z0NHZFQ1pGL0R4TGZLemFCN29FYmJU?=
 =?utf-8?B?a3h2VjNwTGdHcXZkSHJFM3VpQ0cyNkJXZ2lTcE5IU2syN0RTeEF4SVIwYWhU?=
 =?utf-8?B?alJEOE1SMFpSRHQwalUvOVpBeHlzRjZ5bnN5REZobnN1K1Mrc3BKRDBIZ1p5?=
 =?utf-8?B?QmduK1B3TjF3UUJ5QUVRSG1MTVFpQUZDc0VudjNsZVFDbnN2UHFpOU44MSt0?=
 =?utf-8?B?N2Q1T1NBVzB2MEVCdnFBMVRrK3ozYkU2cFdYVXV6MlVFWHE2TTRDaTY3aEdQ?=
 =?utf-8?B?VjkyVHdKblQ1dDl0ZForanNVTk5TdGQ3VlVtaWtmd0U0QTZqWWYvWlJLTmVy?=
 =?utf-8?B?blZnb2EyUEtLVVl2S1NqcHE0VFdxZGYvQWRwSUMyZ29neHIwdkMrRzAxNENm?=
 =?utf-8?B?azBXdzJBWTYyckJWdXpJeFBFM0xuR0JpWDZrbkdoUzUrYU5sUnBFVGFYVThm?=
 =?utf-8?B?WjA3b2krdmNJSzhISXptMXV6elRJUXVnTTF3Tk1pUGlyeGlZTUM3Uk4zOFB0?=
 =?utf-8?B?NWpWUkFrZFRiMEtHc3RxOVRCd1BBQk9LV2pwaWR3VzlaTmZhVTVLTk9hNzI0?=
 =?utf-8?B?clJsSDJJeHUxWVUzdjJmRFI2WnJZZ09HdVpvSStZN0IvTkh5anVOR29ZR0VS?=
 =?utf-8?B?Lzg0L0ptS25iMlRoVCtSaU5memxqMkZvaEJBOFVuNHNuaHZiUjF4YlVjVHR3?=
 =?utf-8?B?WmtrQk8za1liQzlWeE95YVlBSUF4VUxvTkFsR2I0SkNiZzN4dG12YXprL2wy?=
 =?utf-8?B?OUZrcXd5NExoL0NFdHBmbUh5ME9JZGpCL3VHeGR4MncySnVUOGpqQnBKb3BD?=
 =?utf-8?B?ZmRKUEdpR3FoZkNIN0JkUkx3YlBCMzhrUFhqUkcvZmU5Ni92akhnYzVMTFRs?=
 =?utf-8?B?QU9qYlRaYzNGZE9DcWhWSkRvcmNNcmU0b0VvdUFNK2p6bGx2NlZ1Ti9sYk1t?=
 =?utf-8?B?NFQrN2tzZmhmYnlwNS8wdHBFUjIzUXZTK3cwZEdmMzUxZDg0OFdLQi9ieWF3?=
 =?utf-8?B?YTVrWDVjblRnb1dxdzlKNm9Id28rV0NHOEMxbWFmMkdNZ1F1aHVnMTZmTjZ5?=
 =?utf-8?B?M2pBd0dXSTFtdVZlUUVCWmhQdFNFMS9VUEFFZnFIeFJlODRjVEFURzJHSmtz?=
 =?utf-8?B?TUpiYlRieXdaRjdjU1Btd3NkOGJtWVM2dWZtUTZnZkdZZldnN3IwdXZkd1ZT?=
 =?utf-8?B?ZUYxd29xUFFoUHBSNHpXRkkyK1J4L2lPOURBYk0rREx0WHVSWEZMNVVjSjkr?=
 =?utf-8?B?QnJQMy80bmxMN1dtTzNvNEkrek9KczM0MVhKaXpTRzJoNS9aNHZzdUtWcHRs?=
 =?utf-8?B?aG9TbzVEenlvSFVrTlhScVlOZmZWQTBaOXA1cmh0Qy9NNjk3b21lNjNyR09W?=
 =?utf-8?Q?MXIaH+HY/9VN49K6hObo8W9E+Kxggo1zkmYkgIZ+MWpW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFA783ED2F30444DB0A662EC20A48BA8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4593fec-dbf8-489a-0b99-08daa820b1b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 04:59:19.9442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dXTivKVOQu/IkU09whnnnPCKWFv5uKaHFLVeN6OGOFDnszd+kWSB+kCVhr5NpRflfLYcy311xUfEL33qsYUpNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5520
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221006_215927_172198_F2EBA651 
X-CRM114-Status: GOOD (  18.61  )
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

DQo+Pj4gVGhpcyBzdXBwb3J0IGlzIHBsYW5uZWQgdG8gYmUgdXNlZCBieSBib3RoIHpvbmUgYmFz
ZWQgYXBwbGljYXRpb25zIGFuZA0KPj4+IGFub3RoZXIgdW5yZWxlYXNlZCBkZXZpY2Ugd2l0aCBh
biBhbHRlcm5hdGUgY29tbWFuZCBzZXQuDQo+Pj4NCj4+Pg0KPj4NCj4+IFBsZWFzZSB3cml0ZSBh
IHRlc3RjYXNlIGluIHRoZSBibGt0ZXN0IHRvIHRoaXMgd2lsbCBnZXQgdGVzdGVkIGV2ZXJ5DQo+
PiByZWxlYXNlLg0KPj4NCj4+IC1jaw0KPiANCj4gT2sgLSBJJ2xsIGdpdmUgaXQgYSBnbyB0byBp
bXBsZW1lbnQgdGhhdCBidXQgQUVOcyBieSBkZWZpbml0aW9uIGFyZW4ndCBhDQo+IHJlc3BvbnNl
IHRvIGEgcmVxdWVzdCAobW9zdGx5KSAtIHRoZXkganVzdCBoYXBwZW4uICBUaGUgY2FzZSB0aGF0
IEkga25vdw0KDQphbmQgdGhpcyBpcyBleGFjdGx5IHRoZSBtYWluIHJlYXNvbiB3ZSBuZWVkIGEg
dGVzdGNhc2Ugc2luY2UgaXQgaXMNCnNwb3JhZGljIGFuZCBzaWRlIGVmZmVjdCBvZiB0aGUgY29u
dHJvbGxlcidzIGJlaGF2aW9yIHRoYXQgY2Fubm90IGJlIA0KcHJlZGljdGVkICh1bnRpbGwgaXQg
aGl0cyB0aGUgY29uZGl0aW9uKSBieSB0aGUgcmVxdWVzdHMuDQpMYWNrIG9mIHRoZSB0ZXN0Y2Fz
ZSB3aWxsIGxlYXZlIHRoaXMgY29kZSB1bnRlc3RlZCB1bmxpa2UNCm90aGVyIGNvZGUgcGF0aHMg
d2hpY2ggYXJlIGdldHRpbmcgZXhlcmNpc2VkIHByZWRpY3RhYmx5Lg0KDQo+IG9mIHRoYXQgY3Jl
YXRlcyBhIHpvbmUgZXhjdXJzaW9uIEFFTiB0YWtlcyBtYW55IGhvdXJzIHRvIG1hbmlmZXN0IGFu
ZA0KPiB0aGF0IGR1cmF0aW9uIHdvdWxkIGJlIEZMQVNILXR5cGUgc3BlY2lmaWMuICBJIGRvbid0
IGtub3cgaG93IHlvdSBjb3VsZA0KPiB1c2UgYSByZWFsIGRldmljZS4NCj4gDQoNCkZvciB0aGlz
IHVzaW5nIHJlYWwgZGV2aWNlIGlzIG5vdCBhbiBvcHRpb24gc2luY2UgZXZlcnlvbmUgc2hvdWxk
IGJlDQphYmxlIHRvIHRlc3QgdGhhdCB3aXRoIGVhc2UgaW4gYmxrdGVzdHMuDQoNCj4gVGhpcyBw
YXRjaCB3YXMgdGVzdGVkIHVuZGVyIFFFTVUgd2l0aCBvdXIgY3VzdG9tIGVtdWxhdG9yLiAgVGhl
DQo+IGN1cnJlbnQgUUVNVSBOVk1lL1pOUyBkZXZpY2UgZG9lc24ndCBlbXVsYXRlIHpvbmUgZXhj
dXJzaW9ucyBzbyBJJ2xsDQo+IGhhdmUgdG8gc3RhcnQgdGhlcmUgdW5sZXNzIHNvbWVvbmUga25v
d3Mgb2YgYSBiZXR0ZXIgd2F5Lg0KPiANCg0KUGxlYXNlIGFkZCB0aGUgc3VwcG9ydCBvdXIgUUVN
VSBOVk1lIGRldmVsb3BlcnMgYXJlIHZlcnkgaGVscGZ1bCB0byBnZXQgDQpuZXcgZmVhdHVyZXMg
aW4uDQoNCi1jaw0KDQo=

