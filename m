Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BAEC77B60
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Apr 2023 12:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0nbIVu5WRwtK398SqmZy4JmT6/GfgPl9m9LkQaSl+e4=; b=FbjDbbff5S+Z7ov1BLJRRXrbug
	sQiCaWg2qQoOEUigDT5VvSurDQmssPP6e51iTrXPp5s6HvThRU7ImHk76RutlpiJvKVwmj7Mhls3z
	MM57Jv3xBQLZ7h1DPl4k2JdSugiqgoUGuykgAnspx3Os75Lw1vX5kEXpG7nsTUoMrE+7IVDzgPX85
	Lhilov3cUyNIOcNyAI0/jAN7exKdN1l5gFFUqgfavY0Nfp4iJm9TTnQzxNnJG+PKAPGuI7KwwMgFM
	qDa9fHNAjeqCWwwkfdYSGfpe3yVXxvkVWiBGUf3lMfgaCRRYeahTH8XDXoXbvgL6vbrowR/zPjxB4
	LIa/tBIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prek3-003zqI-0f;
	Wed, 26 Apr 2023 12:59:27 +0000
Received: from mail-bn8nam12on20609.outbound.protection.outlook.com ([2a01:111:f400:fe5b::609] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prek1-003zp1-0m
	for linux-nvme@lists.infradead.org;
	Wed, 26 Apr 2023 12:59:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0zdeLUnT5/Ia4UiQhxsJYvfecK9fucW3wTe4e2cQZvpHbx2/Yb+aN070q7YU8h6y5/ppBLD2+ltwcIbo8CE0t0cO7sd1XrCFT2IN+UWxK6eh9bcyBBS5cDuax6HXXj/FmGLigvxUfrLYECTtesjcxnYC2SVmSN97tvtPphtExOac+Sy9snXDDjmZ/PZy6v1u87vZINXMzJ+I9KEf7fyp+GYLm9H6B2RmQzv/RJeEh9aw/elhLF1vgZHoO6DzYvua0XTIeBO3V2QlWjDtH3xvVa8wNLltYc/T5PVtrj+YFiv1twA21GVkq2wk5E47o9/WLiEd8TVe4zp1afAKBSkpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nbIVu5WRwtK398SqmZy4JmT6/GfgPl9m9LkQaSl+e4=;
 b=i0BffT1zLH1/ZfISgm9hRLVDIoPSoCKLURNsGASDPUeoST5X3SqGX5QiqsM/xmzZfuw3nEebLnFjEmYIbjLZf8jSzQTzgkyP3ICGIHtdhFg5caYFkGMyldVhzuirI0fbXuYcfqIsyUZYxG3lRJ09sMOIMAkwfIuJUQfIhBpPJlvwEm/w5C6gY+lpyqssPXwTmwN+IPa4qruL2ec8uHE9ZIJWRWad7s6dUDEwlYGKQmKo/3VxJSfAvFBcIP1tuWnR1q7l6FCzWLSH+fKXrsY79Hubw6fekwdM/k2g+gX1la+qIcOReCstzNKvyd3ixd3uTenB46vRiViags3NTMHoiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nbIVu5WRwtK398SqmZy4JmT6/GfgPl9m9LkQaSl+e4=;
 b=duRTIMrKbv6LOib1DBIBJxBdmBrjJyGXdvCjHcK2tjBCjIc2WHwr9ue1AyH5ENmV8pL7g6zjk2roPvLZALsSnXYUwTUKqH844TUU83Wbv1WNzm44rE/KbIlhVazX2k8kijjru5+e6cepl3K4vgW0WdsR8M4p/Lz23swRVFBxTED28zciknVh9wcvraSLc7gSZENu4S5Odsha0eDf0nyfkrc4QS7p54VAIMEKnoZZN/ZzPv2VV1Wfyldv96UMzPGv8dFifMJk4/WZrM/NXpSfI3whLmadinPs236SXDkwv23rareLaavCb1B5SWcU5yQG3oiEFjl7oCCYZxqPbKEa5Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH3PR12MB8355.namprd12.prod.outlook.com (2603:10b6:610:131::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 12:59:18 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 12:59:17 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 1/3] nvme-pci: add and use print io-queues helper
Thread-Topic: [PATCH 1/3] nvme-pci: add and use print io-queues helper
Thread-Index: AQHZeDsNuwPvFKub+kCz5bhAJWgu1K89jVuA
Date: Wed, 26 Apr 2023 12:59:17 +0000
Message-ID: <c481e6ee-00d9-3495-ff17-19b676942215@nvidia.com>
References: <20230426123119.8738-1-kch@nvidia.com>
In-Reply-To: <20230426123119.8738-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH3PR12MB8355:EE_
x-ms-office365-filtering-correlation-id: 5a4fab25-4e6e-44c6-adfd-08db46560b57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  P0+iuMzdp/HcWf5F66cDiUFRAugi9MZhBv6j2Y1R2wEvBq5MZPzWv6TtS1seg+Q2oep0MHZbdUZEyzR6k9989hWuwYHHm4cG+3JyichGiWPCJHXe1ISKQubezFg2YrnnHT98zPMMkyzA601S1bfN24fe4ryArGGniVIXGomW3KhtD/aUM46ZM6Jm+l+UZyah0kQ+UHfzi4KUONW9gmdIZLZhKa3VyQCJY3BqM580kHiX74vRCzysTrfnQbG+1TQu2xn+7P9yZoQa28b989Ej4Jp56Q/U/4AWTaCldOyM7a0Hi2kFauS8nNGeJVi68mJ9IR9wMeXJcn087nprG2UxI7X3nQiOteLE/3peNrbsXFLV3OztIc1rQolX+RNDMMuqCKIApMxP/5faU3wq9cZ/ty6St4yN1+qO5FqYB0tevwcSCiOMcVGQYGfmEqnmP4uAD/qdknCqs0SiO/219zgpYOFntgXOrusEU2NtfyZb6AABQES/Ky36zG9gsX2yrmDmIVCZcG/UcnJHkN16jHe7WFsYdCnXk2fjN6EyuKX2E5gqxksZTS/W0UqSMGC89F6EGFGZLlJeEW9wAEq4m3rEX+W1TbuON4gX1UVdHH/IabnnXG+PGHZP/hBEKeiHALDtH8sXAVLLb0wW7IiqSkDkbP1UtuiEK8NmkbG+5ah/fussxpgQIqMw8KeTmwjq/LVT
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199021)(53546011)(6506007)(6512007)(186003)(66446008)(66556008)(4326008)(64756008)(66476007)(5660300002)(316002)(76116006)(91956017)(66946007)(71200400001)(6486002)(31686004)(2616005)(41300700001)(31696002)(66899021)(36756003)(110136005)(38070700005)(54906003)(8676002)(8936002)(2906002)(4744005)(478600001)(86362001)(38100700002)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?b01DTU0rZ3lNMHJkMnBlZFUrWXNVSllWcnQvL1hVVFhtcTFBVVRWbGlNNmFW?=
 =?utf-8?B?eEpMcTFDanhRY0NOSDg1YUNHR1lRbnM0UHdpSk9HOWlTQ25HbGdOblNjK2ti?=
 =?utf-8?B?N2dwRzdyWGN2NTlwNC9vQ3BtNWlCTTJkM3pvNjR0dGdyY1ExM2ZKR1ZrdTVP?=
 =?utf-8?B?a09qNm9FWitTZ25KMVQyVnZGM29FMXl2NytINzZ2NUhOeU12MTRsTnVpUCs1?=
 =?utf-8?B?c3NsaUZKblhNQmdDcGVDQUhTaVhqdmloWk5nZzdYUnZTNThKYmdzYmFHSEZn?=
 =?utf-8?B?S3JDN3plSHRvSEs1TTJCb09WYjJZSEY3OUJ0SGs1YWVuMHFzdyt4aXE4V2xq?=
 =?utf-8?B?cUE4V0VENkhWc3ZhR0hXdW8xdnNWVngrNGFTa3YxS1NVZGgyY1d3blZSMCtx?=
 =?utf-8?B?dnROU2VGNzUyb0NCTWFxeXZyMUxSTjg3RU5ER0p2cXoyNDB0TjhzZytyRTky?=
 =?utf-8?B?cHozZ3ppNHJDVzE1K1orMStOZWJYWFJCc0hVSFViTHR3Q3RkbVh2NXRwVmhl?=
 =?utf-8?B?bHY3dEp1YnRTaVVDS2pQd2d6UnBRVDh3QXZFN1kvaXkwaGJNWnY1LzFWNm12?=
 =?utf-8?B?Zk1uSWZ2TUt5WDU0WWJCcUliMWUyK28xWldPRkxNTS9vTnk2eWY3UUg4Q1dU?=
 =?utf-8?B?Ty8vL3J3d0xVaHFPdWFNbGRXREN0aURraWN1aTJLU3U4VjVEUnNBRzM2emY0?=
 =?utf-8?B?T1ZHcHZEdzZtTDBxK2tyVDRxZEVjQ3hnZklxTU9NY2pnbEk0dVBSc0NZeUpC?=
 =?utf-8?B?RitqNlpYcC96aEdLOTNrcXB6Ym9TQ2F4NkJWdGV4VW14RGk2RVZyd00rSitm?=
 =?utf-8?B?cllCYkV0dGExSFRBZ1pISDJCZmc4Nmh6SFdrdDg4ejhzMGFpUHFzeWE4Zjc5?=
 =?utf-8?B?aVR0SjRDOXM4OFlra3pVOWliY29yVDd2a1FObUxkUjRzbUcvTy9uSE1GYW10?=
 =?utf-8?B?aEl3VS9jTWtPUXNZanFPYmh3eUlqcVMzY1ZRajF2TGhYc0IrdGNDY1cvYUor?=
 =?utf-8?B?MlpaNzFyN2V6a09lR1FmTVl2NkRSMFc2WjJXUURxdVdtNVBnc2dOVFpCaExw?=
 =?utf-8?B?Vi9BcU5ZTUc0ME5TaGVBRkgyeHB4bTdJd3dGZmVFQzNYdEZyQWNKdW12YjIx?=
 =?utf-8?B?UVFpYXVVTDBOQ0twaDhBQTI1amgyaGhXZkRDTHdlcUN4KzNpYXZNMFB5amlW?=
 =?utf-8?B?R3BpY1oyYjcyUXY1TlpLcW1ENmJWalE1R0g1ZVdpekN3aWliUU03b2NoWEU2?=
 =?utf-8?B?aGtKR0tWT2swTkYrMnRnYVFNTHcyd0RYaUFGQS9lMnFKODJpbFJvOEN6eVpi?=
 =?utf-8?B?SzZQeHhzajFDQjE0T2MvK2xlNm5XKzl4dEdFNk9zdWRWTmRLS2VpeVhQUFpr?=
 =?utf-8?B?a3lvUFNPempxMHNCWkw1c3A1Y0E4NmMvUlJ1WjZlM0x2emNIMEdSUHRtRDRS?=
 =?utf-8?B?TlFTcFdYU1NFMG50Nnd6eTNrZHpESWhDQndHNUhBRThWK0ZSczljU0N2eG9s?=
 =?utf-8?B?WWYwRzF2aG14WWpJRHNwWGlmU2dONlN5cTJvOU16ZTlKZ2lVNGEweUVTakNF?=
 =?utf-8?B?cERtcjJpdUxGSytOanFHVVJzNHdhcGU2d0FEYUFKTkkrOFlGQmFacjViTXUz?=
 =?utf-8?B?cEN6NCtWMVRsTEpYdCtON0FGS1c5bTc4MS9BaGE5d09oZ3VwMHBqSkpwS3Nu?=
 =?utf-8?B?YTJBK3YrdCtRVzVmNG0rZFlqSFZLVS9mcVlEWnI0ZDVmclB1cFBYMjMzcEdH?=
 =?utf-8?B?UFFjcGFXM3M2YlFJbDNTbEJMSjM2bnlRTHVDMzRuTjI5dEFCemlISjgvL0tY?=
 =?utf-8?B?QzY5Y2ljYUF6aXdJZXZ5ODZoc1NoTWhyY0R2dDJsb1FPMVRHeXdLcUEwTXRx?=
 =?utf-8?B?cnV5RTFnWXhocmZnaUNUNnhuc3lxTkRaR0JoOUVpOXZiNVdnQmtJZXRiSmw3?=
 =?utf-8?B?ZDcralRrdlA4emJ6ckR6SVhNOVRadVM0RzlxRzVrWjVVR1orRjc3RExrZHZB?=
 =?utf-8?B?SlhMZ050MDJldGZVcUdTa0NLaEpFZDFsQU1FTE51ZVkrZWYvV0VMYjBQQlBL?=
 =?utf-8?B?RVVsNTQwRkJxNlR5bUlZc09qb2hweVBRbnB0RUhUMVR1ZjhJY2R2b0d0Lzl6?=
 =?utf-8?B?a1ZTU3ZkM0ZrdkVKUjdpRFhqd3FHUTdkc3Z4NEJTMVl2Zno0aTlVUHc3K0JB?=
 =?utf-8?Q?GuwE/n3eoPjkG2kt7NAtAGBty0CvkSUNLAPFbtO1Z1Bw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38B51F2B5F5B5B499E27C407DE4DBB6A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4fab25-4e6e-44c6-adfd-08db46560b57
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 12:59:17.4284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8b+uUJQwVH8g0ZoYSfS/9EgilpozU8aqbNDol14xo1hw1k68abOoSm0yVEqs5X8XGLigcU0RDLKHvOZ9UcdkFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8355
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230426_055925_282467_23A74F46 
X-CRM114-Status: GOOD (  11.77  )
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

T24gNC8yNi8yMyAwNTozMSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBJbnN0YWVkIG9m
IGR1cGxpY2F0aW5nIHNhbWUgY29kZSBpbiBldmVyeSB0cmFuc3BvcnQsIGFkZCBoZWxwZXIgaW4g
dGhlDQo+IGNvcmUgdG8gcHJpbnQgdGhlIGN0cmwtPmlvX3F1ZXVlcywgc2luY2UgYWxsIHRoZSB0
cmFuc3BvcnRzIGFyZSB1c2luZw0KPiBzYW1lIGZvcm1hdCB0byBwcmludCB0aGUgaW5mb3JtYXRp
b24gd2UgY2FuIHNhZmVseSByZXBsYWNlIHJlcGV0YXRpdmUNCj4gY29kZSBieSBhIGNlbnRyYWxp
emUgaGVscGVyLg0KPg0KPiBVc2UgdGhhdCBoZWxwZXIgZm9yIG52bWUtcGNpIHRyYW5zcG9ydC4N
Cj4NCj4gU2lnbmVkLW9mZi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4N
Cj4gLS0tDQo+ICAgDQoNCmZvcmdvdCBjb3Zlci1sZXR0ZXIsIHdpbGwgc2VuZCBWMiB3aXRoIHRo
YXQsIG1lYW53aGlsZSBhbnkNCmNvbW1lbnRzIGFyZSB3ZWxjb21lLg0KDQotY2sNCg0KDQo=

