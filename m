Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38BACCA473
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 15:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XE0NpEBu+1aDTc7oocVDl0+0mNZPg+moPKv1JnMJiAM=; b=cJ8ANZQToMQ5VafsZt5h3XQ0cK
	w68iHpTaP8cH/UykjLZQ9NRXko7EiJ89l5gCuyZVWs4gziHVOUWSbHjmdab9bqsEIfLG9qAEHDbQ/
	8Ou9YSZqujJuc7u5QpHA3DtKJgvzeICpGGs6RIfoxLIgdUxYhW79ceDLckBn+JQ6gKJLbvE0JSXJT
	+KkW+E6o0ARMi92G3g0S1QDmg3gZXuvs60sF0rmKox9FaDFhaSLvQhKeFR4U1mL+JOCwH3XgafNGI
	6/7s1rRrKHaClmC6yNIDU1IVezqIvBgdhXk9M874L9TZ6crDZrLYYZKmiyNlH9XH1dLIpiab5SJ2o
	lUWYNmLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3g1k-006DMr-4t; Tue, 21 Jun 2022 15:42:52 +0000
Received: from mail-dm3nam02on2053.outbound.protection.outlook.com ([40.107.95.53] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3g1e-006DK5-2p
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 15:42:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVOiPdho+v+if1J5OZRCWQUH9E+53ynD0V21HJAp1JopUjqqqmUdThQCYzVAjYOYCzZul21MxE657Q15/6hjcP/42wnGCQFt3217bvbqpQU0AyyzXxaobxllBHFvKt9naRR5si2RBFvE7qtn6drXkwXh4o+lyx73BEXCVAQkxGGwniekglM6If+/uryAe7icfhpIV41DAHJZxST9dwcUGLuGU7tLgkV3wJffW88JJY4YhvOMNilhTyCS6pIQTqxUgjXGly2RDqm4iyonbn94iQ5WpgKqFOlQQWVRE8IBR0qxgFcPozdsS7DhFnOlBzvOz5za9exZ2Bnq2ZEzEfDzEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XE0NpEBu+1aDTc7oocVDl0+0mNZPg+moPKv1JnMJiAM=;
 b=Njl4Re2IzUy/rmGG0Zr2lUGTF8JedqX2OQ/Ic7dND6kuJVPkKkNxEnQOOIYCfwoMxe3co+aFxDKz46zAuXI5lKJgomvvxPNldDPK6jBn0WAatJekUXyOYpQZ/RRMtlg7ZNr3b+M+QgoKvQAgdbMJkw8vFV1b5FDyURJk2GvJWAOln6OsOlMy0xv193sQUgYlPqb+mv2KZfCLm8HRSdp/OWaEfzmxJzF60D9vCr7rIBj9Omo6Jsyn2xSBjz4dH6sQErthm/zkMLF09+P4Du0UM54sfBobAaf6wqJUKwWEeLaJ4vIo1TjIC/QCALUJJddT/9Yc9a5zC0dv2r/L8Kncng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XE0NpEBu+1aDTc7oocVDl0+0mNZPg+moPKv1JnMJiAM=;
 b=a4uA8M6rqfdNRx5KX6BtNkXgH+xFYfasvk89VYdt7LySn1Rn37DIEGlVG+gd9LbUiU8dmd4Zn+tVQQniqPCP/tg/oGxzPrEm28OArkFl5CXdDskloIr1ljLC4QO6x1B6euHgMeJSe/Z/4clTWfnM5jaIkqVfi1qvFlKBBU1Y370/3MkLMUxdXohEIZeCN+GaEKB+FP0IPh0+Y1S3Uvf+OyXHOx/ImY3YqRTCvlh0aFYDcYyiY24eT0y8wHfFuoXNrgU1p4pFgMbGSAjCS+O2P6C0Dd5+FU6GFslUsCwPnZngCDohjHaA+Tr9v8b8ssHRKXVrNfJUqw5++xkzszQaGg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY5PR12MB6298.namprd12.prod.outlook.com (2603:10b6:930:21::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Tue, 21 Jun
 2022 15:42:41 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 15:42:41 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Joel Granados <j.granados@samsung.com>, "hch@lst.de" <hch@lst.de>,
	"kbusch@kernel.org" <kbusch@kernel.org>
CC: "gost.dev@samsung.com" <gost.dev@samsung.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"joshi.k@samsung.com" <joshi.k@samsung.com>
Subject: Re: [PATCH v3] nvme: Fix CRMS masks for TP4084 - Time-to-ready
Thread-Topic: [PATCH v3] nvme: Fix CRMS masks for TP4084 - Time-to-ready
Thread-Index: AQHYhT2xTrWJx0wTI0qdB2jFwGNuVK1aAJgA
Date: Tue, 21 Jun 2022 15:42:41 +0000
Message-ID: <c170eeba-6dfb-37dd-8667-a477002a7ba8@nvidia.com>
References:  <CGME20220621070724eucas1p186a9c118c37b140e60c2d1f8cacf636a@eucas1p1.samsung.com>
 <20220621070500.1381155-1-j.granados@samsung.com>
In-Reply-To: <20220621070500.1381155-1-j.granados@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89d7b8ee-7dc1-4c8a-3a10-08da539cad3e
x-ms-traffictypediagnostic: CY5PR12MB6298:EE_
x-microsoft-antispam-prvs:  <CY5PR12MB6298B7752001E3E10931D5EEA3B39@CY5PR12MB6298.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  4Qvpl/0F7GhO6DKRFJi+YquGMgyIgmjB0pjlqimrcAWBHABAPF5IV+fEc+op3Jn5uIx/Bf8qSycAfU63eR7yCQmJlzztrJnHTWtMPwqjB2HbmcRSiNfuX7DvhIxNhZhgu9Bd6uDX9x/mBB3evxr9OjoRzsWQ1vYmnERaD/6xhRVHY2NfZTSI/D2PXMYKFmCKrklgNYgQbUGRM5DMXBNGFGjGxcC70F2DqHwXceESenQSq+vaIL9jCpCjKWJxYQ0NMoVmDdxOZxKhhLmMoHO1Q3ENiQ1lSjnVl1NAuvPQdRhHV1WgsHuz5HQGlXYdmoTlb/5F3flILuoo7F795asg2hjy2BnhZLrBai36Lq0Q1bpk5lBg3PPgWVqWDO4mC9wrs0ykv7mo7L79mDBi2AkfX2uhl3hOXlS/W6TmstFSx3Zap4umWn0RBLEiK69n/SYSLRHiqI4mPmEjcY7SHv7ZR9UOJMaVt8zJUmX1R70sIqwZDTXTNu+uN66BZg87UuMCdSDOztu6Bd9Sqrfx7vyVNZNINR3QKZK3PYGtm3vuwhITTfRGkn9B9otfRYtbuoLf/U2a1qybT5QUNhNlZVGP0/I1jQho1yOgU0imKcOy53MGmd0Qegq/2GLrXneT/8NIILdwlp8g70+sOQJO61JvV7dysi3WkK/LXyEy2WWnMPBfmBjztACaGHKtMHYBO+5bAekFxSoRfwygkbriPzxUDVq3zpeFrweDkGJ1OPUp2tO3IaDbTu3JXqjF7y0OK7bwS7i8aDt3fSBHaNge8KOHHQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(186003)(8676002)(36756003)(38070700005)(76116006)(6512007)(38100700002)(41300700001)(31696002)(6486002)(110136005)(316002)(122000001)(86362001)(2616005)(66556008)(478600001)(53546011)(4744005)(4326008)(5660300002)(6506007)(8936002)(71200400001)(66446008)(54906003)(31686004)(66946007)(64756008)(2906002)(91956017)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?ekh0cTVya1NOZXRUb3d5VUYzN2VxaTc4UCtiM1psUVJFZUh4dnFycnNxaWNJ?=
 =?utf-8?B?T0V5SXlsaTFtYUNCZ3AwTmpoOUtydWFTOHRHc3NHQm9DbXFCb01VWGNTY2FI?=
 =?utf-8?B?YitMdThucGNYdHRGcTBCNUNlRWpobzJzSlpmNUtYdFVuR01meTJYajMvV1hE?=
 =?utf-8?B?Tnk3NVpYTVcrUUs5NW03WUc3UWxXNWxFbmRlVWZ6N3Zvdy85REZ3TkdBQTNt?=
 =?utf-8?B?cjE1V1Nua2tLSnlvSmxxUEFUdi9WdlRwNGRqNU1RQi8zK09yd2hBTFQ2cFFN?=
 =?utf-8?B?R1Zab210Zjk1dnJ4cEtRZ2RHYUtuUlVIWDZ1dTZVK0ZveXVseVFkdFgra2lF?=
 =?utf-8?B?K1RvVWhwdytlcFpTc2lDbnJaeTYxZStMVEF5enMreENvUWVMZVhZcDNGTkhk?=
 =?utf-8?B?SlErc0tMWGtpRjU1azVOajVESGhxa1ZrSVc2dEozSjE4eE1RVHhNTmFkVUtK?=
 =?utf-8?B?Nm5CK20zUTRnelZYRE50ZW1ydHFBZUdLYUhlTFd3Uk1ScnNNVUpBQmxlT05J?=
 =?utf-8?B?N1dvektMaGZzQWhIMXhzUWJVL3JYSGxORUtUWitGeWhkWGp6c2gvU3A5NVcz?=
 =?utf-8?B?K0pPS2pTRnp2NnZhWUVsVlRXRjI4a1JyenFqMk5McmdCTFdDN3R1UWhNQllF?=
 =?utf-8?B?YzRFRHA2MkRheG9GZkpzRDhyS20xOFh3L3czRU1qWG0wYWJwVGZUUzJ0RzhD?=
 =?utf-8?B?SkJ3Vk1VMWV4aVhBUUY0NjVjV0hoenVLUjE2dlhEY1VGamRMMUovR2FTbjZ3?=
 =?utf-8?B?R2JWbmdmRW5PRmtGeVBZekJrSHZZMGpOUnJsblcwQUhJSkNRSk5hL1dOY3Vh?=
 =?utf-8?B?RnhoZXlmVVJYbGFydm91REFOOGkyL0V1SiszaXJHd052Vnh4RUJHVkFqN1R6?=
 =?utf-8?B?M01POWJzRzFydEN5dFdtMVdNcnZHYisyL1U2Tkk2QW51SnZlRnpyQkZpQ2cr?=
 =?utf-8?B?MEdsNjhmTW1XS2JHMGMzZiswZjlxb2lsM3dMSFN6c0svREFLY0xhOUEwQzNS?=
 =?utf-8?B?WS9oMEhTbTZOcXpGVktoK2NjbWFxUkdNMy9mYmRDd09GQ0RJRkdrMVVlUTYy?=
 =?utf-8?B?T2VrNzRGcUhIQ0l4RG9OSXQyNnlGUDU3cmt6aEsxM3hHK2dCK2pjR3hOZDds?=
 =?utf-8?B?YVRncnc4cVBQMzYwT1ZyZFUzQjZaOVZjK3p1bkFQNjZUbjRFL1lkS2I0dXFv?=
 =?utf-8?B?cURvRm1KSVdmRUR2S0huRkVuQlFFaTlzQnFjSU1IbE0rRVJTU2htM3V6Um9p?=
 =?utf-8?B?M2ZQOW1WQVd1ZVkxdXVWNjloem1UNFVjZ1hBOEVibkFyUitrUGhWY250a1VY?=
 =?utf-8?B?clB5VEZOUVIwVlA5UGJLRVJ0eVpxbEloUnFiZ1ZmMlkxOHE0VU5uOGtrQkVo?=
 =?utf-8?B?R21nbTFwK29ZSU5nVENuaUR5S3QyTXh5NXFOR0lUOTB2OWo5cFJmYWJBTitL?=
 =?utf-8?B?YTMyajlFTFhPQmNUR2JOalNZc2tQLzJiZWwyb3VvMFlCdWk4eWFTS25LeWRz?=
 =?utf-8?B?aG1zL3FEekdxU1E0eDhuT1UwOEJ0R0w2UW5iV0w2eTdPdi9ObGhIWVlYOEpK?=
 =?utf-8?B?YVVrL2ptNE0vLzdLRTVOeFg3d20xckxXRkhyRjFSb0hZaGd1RzhjL0RxSmhG?=
 =?utf-8?B?K1lEaEUydXBraGh1MUNweWtuVFE1WTNNSlNPUkRVcHNvdEhNYkZxczBvb3cr?=
 =?utf-8?B?b1dvRjYxYmprZkF5ZUZUZ3RYdmZSUE00T1hKSzdFNkpkOWI2c0Z4amtrVkdL?=
 =?utf-8?B?VFZhbTJ0Z0U0c2Rrc0NMSHg5RVNnNlZHWWYvd0VGNmo1MGx5eDlMM2JiVDR1?=
 =?utf-8?B?czlsdmJnVjg1OGIxNDhPdGJldHFBQUJOOGYzU1pSdU5jUnBPUnVkWnFzaE8w?=
 =?utf-8?B?azR3d2VoODFxeWxSdmp3dVVlOU9kTWsrK1BINTRsdjJ1ZWdWdUoyanBwa241?=
 =?utf-8?B?eVI0cmFlYVlOMVY0R1JoZG5BN1NZcE4xUmVid1V6alR4ZnA5bFREQlB2RlFI?=
 =?utf-8?B?eFY4Yk5DaDdQeVV6eHNJK1lhU0p1b3J0THNBdDRKcFBFQUNkZHZyOC9WNEtI?=
 =?utf-8?B?ajhEYk9ibW9sUlBYRGhoNFJZZUVlS0E0anY3bzFHblFGdU44dkZ4WFRUNUxW?=
 =?utf-8?B?TTA0SWVIRzZVVlEzdVlCcmtoOWtEWnhvejNiZkU0OUdwaWc3MGIyVEI1b21n?=
 =?utf-8?B?a0F4VnhoTktoL1NxTHRFZlJ3ZStPQm1LWFU4LzFLK1o3QndlbGZiS3ZMcEdh?=
 =?utf-8?B?UkhBNGJ3Y1lYL3FZc09qM2xWcHAyeXNzK3VUMU1qTlVHZ1RHRm43eHVtN3Bz?=
 =?utf-8?B?cU5ueE5TM2poNmZLYm9pSVRGcFdoTUFWNW81SkpsNzdBTjlBTEpaallFREpN?=
 =?utf-8?Q?rnUlUTNNs0RU/8yY9Rjg9z97WcZez29qUjmdj9yzQM2fj?=
x-ms-exchange-antispam-messagedata-1: S3trL0yrfquPFg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <17BB198DBBF5644B8E73107A32C6E3B3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d7b8ee-7dc1-4c8a-3a10-08da539cad3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 15:42:41.2730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hy24KdVlAembnd2Kp/dgNver77T/a3Vk2XYPzhDfUUlSQI+FIsxnhPf9SNctK905Us6hnK7Y76AfxChEkBIdNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6298
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_084246_174228_01C4596B 
X-CRM114-Status: UNSURE (   9.33  )
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

T24gNi8yMS8yMiAwMDowNSwgSm9lbCBHcmFuYWRvcyB3cm90ZToNCj4gQWRqdXN0IHRoZSB2YWx1
ZXMgb2YgTlZNRV9DQVBfQ1JNU19DUklNUyBhbmQgTlZNRV9DQVBfQ1JNU19DUldNUyBtYXNrcyBh
cw0KPiB0aGV5IGFyZSBkaWZmZXJlbnQgZnJvbSB0aGUgb25lcyBpbiBUUDQwODQgLSBUaW1lLXRv
LXJlYWR5Lg0KPiANCj4gRml4ZXM6IDM1NDIwMWM1M2U2MSAoIm52bWU6IGFkZCBzdXBwb3J0IGZv
ciBUUDQwODQgLSBUaW1lLXRvLVJlYWR5IEVuaGFuY2VtZW50cyIpLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogSm9lbCBHcmFuYWRvcyA8ai5ncmFuYWRvc0BzYW1zdW5nLmNvbT4NCj4gLS0tDQoNCkxv
b2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEu
Y29tPg0KDQotY2sNCg0KDQo=

