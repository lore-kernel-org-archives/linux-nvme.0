Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72CDC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 10:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lCfXuPBSh75yJbmr2g4t6vRKf1DmM025Klhwrlto1j4=; b=n5BSIlB4TLRHNZQMw61i2IBg2V
	jECrfRY9ekNrziuyBJqVb5LX8MRy6pa48mPpiI+hs6BYk+P5IswpzmxjJBNAciRg1+qwKK/IY3ZQs
	xPFy+fxEXVJ7nC1FNTyJTGbp8r0Ta9c6WdT6On64L54ZXAMBFUkmtF64FEl3DSbPh05gjO6E4x/zg
	Ef7hojUhwXeIq42NMUNEY9UwGG14UlS/8xKXwDyA0e/9Xzpv+0cnQJmr0JEezi1zY7EmsY7VGsEkg
	D2x+sLo79CoCyNUUqJrtYT3ii0snChlZgG4cAAi29rBceDqv9KCwp9GKDPaGNXWziBNSMlL7MwBoB
	tRr6RWpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUQcO-00CSlE-QP; Wed, 16 Mar 2022 10:11:00 +0000
Received: from mail-dm6nam11on20629.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::629]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUQcM-00CSjo-L3
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 10:10:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIcyrR9t7AbsdkMWWq3RqYd6ryYHoYHwELldkkMkt0+AK+xAncGt09Uw4ad7DQSy9FcMuemcW0BBPFdDLPs+KBGV+uggyUYnq4nHnsaP3n6/wXhzTvllwwHgMKgc5UZzGY07Ujj6XnRVd1K1zQV/259lrjdDnayC9WUSoHCrRrgjCHL+83xw+mNBmlud77zLosH/JhBFlPEMfnIYVrX8DJX8Nrtl9inbbxYD7Ml7mdy8/xJbjmZv9++8jdoVxBcEnhMxz9qbhSwPnWT1mbTT4XDyL+ES2ExmCrSJoB9SQpaFErQt5PeGEUD56yBZIVCIyTufQRbfWhaSyIea0RSrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCfXuPBSh75yJbmr2g4t6vRKf1DmM025Klhwrlto1j4=;
 b=SPC7DxfEYO2llxOkAxNn4SI5fJ0mBoxY/t5JTNOjjAqBsPZZbWfuP9nY3zAv1NXJjnqClVdBj4mJzu2tSS52M3xE7e30jRcEhyFMu+yU4NRE/x/d6q54b8LbXGWuaquUYOCZG0w08/VcG5PoVrlUb3+HWSwfO2tnBlchi00cKx3fWH/nn0iGY/9cLcIlcFihLH9PUv+q0KEPnC0MJROtpcQgV7LEXG2SF21Pmsv/1AVoM5eZOAxTNKOg0rXYq/lrqe6+G3EDY46jEpQl7/xK58qOV27CrnjyswYQSqCRD1eo+sqoR9VAcMj6bunLPo3fH5919Voo6YIy530nJ1xi0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCfXuPBSh75yJbmr2g4t6vRKf1DmM025Klhwrlto1j4=;
 b=Sv4ofiyR0H5vEy9NxR3VPDCkKiGVbJ45KK07kYTNCoZLdJMNvmZHjUyw01xwUU+PuqmZxKe2PwiPpNV/AAc7LR3TZTmN1gmdIz0BkBNxNcJ2j/PlDLfxWxE/CdW8Ufdeho9UQUkI82OiBbYIPYaZxWei1JXNbZ4T+kwCSPhx3nxHrz8jp5hByL0aOrcbBbxG2cTSL0VDL0qwE1DjU6V1uQlNUETEZ4NDYsgcawAc0dlQKsyiYdiMAWdVLPJnYXJoHZoLapbr6bgXNXl0/yr3pgoMNJMwsNbzvwi0VRHVnXNAfnMY6ermmhor50M/OLsk+iHvZEQmgM5Wb2LoXSnbpg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 09:56:10 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5081.016; Wed, 16 Mar 2022
 09:56:09 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Pankaj Raghav <p.raghav@samsung.com>
CC: Sagi Grimberg <sagi@grimberg.me>, Luis Chamberlain <mcgrof@kernel.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>, Jens Axboe
 <axboe@kernel.dk>, =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?=
 <javier.gonz@samsung.com>, Adam Manzanares <a.manzanares@samsung.com>,
 kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Pankaj Raghav
 <pankydev8@gmail.com>, Kanchan Joshi <joshiiitr@gmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph
 Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme: Fix zns drives without append support to export
 correct permissions
Thread-Topic: [PATCH v2] nvme: Fix zns drives without append support to export
 correct permissions
Thread-Index: AQHYORlQ7U3+JbEzPUiEJOfuOlviEqzBxYiAgAAAZIA=
Date: Wed, 16 Mar 2022 09:56:09 +0000
Message-ID: <6e19b134-3ba1-432f-092d-ea526f09ef35@nvidia.com>
References: <CGME20220316093439eucas1p27c2a31849e9dec6c6bc217c5f1b26180@eucas1p2.samsung.com>
 <20220316093423.17906-1-p.raghav@samsung.com>
 <9498d380-0172-dae0-9354-bd4d725fff5c@nvidia.com>
In-Reply-To: <9498d380-0172-dae0-9354-bd4d725fff5c@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93ac9bc9-d5cf-4634-4356-08da07333296
x-ms-traffictypediagnostic: BN8PR12MB4787:EE_
x-microsoft-antispam-prvs: <BN8PR12MB47872FB5C348563923BD1627A3119@BN8PR12MB4787.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZGh8Cd6uoja2VPC8v6Jq0a6WGDIbRUtGlJt5BC/9YLQEFnpU2tYaeGg0NhNcSk8RxZl2isdg6XyLzySiQQfE15tyeMAkGtKQz0owIRRmysbHmZkVLcnmiGN8svjolJzoDtKKnhEEeH4KGl6IiAQZfMr6grkrfU3jWVw8+ReflleDZQJXrl51jV589mgo9BPincxvWqdedd8CxBTJBohDxgjasauhmzDYe1P55+xP4obt32eBdvr24FmPSwwB6cmyYLVVnTGI/t3nEEVlTzH8x7ePHOieFxV3RUwsJZOGO2SEHHmsqdcCC1TsVzjgxZQSEKOeaYaoXh++A6IKme3cNHD4S3wUN4/HLgt0lBOhXqyAUi+QsDh/r2cdhtBSznqReFXMDnGf+T3+xTfmBdamrrLsKJJg3jbK9IQUoFs7DiLIP2Ljph82zYR/381Ijdqgwew39W2Oz8iYfjXXeq+NDxAGOQO3dmLr3rJUT/kcf3uFpkIaXw7U34VmtaHhvL8nK0U8Cezz21BPs4aCj2Kp4fBAFoycA4pkZaPbAIKLhstOXBRYF4TgsMXJaCfcp9dhgFqbpXP/r4j7ilC+6mnoWeZoTqFxandEVmo+k8B4pKVIZsgiB99fisZ/D2EwEioF4M/f1MruNhYKtRZH4oyf2cC8Du0KCjAIHHPXbVzU3ooZ6lcAMDc3XiUGs1bierCHq+2elj6Yv4FKSFMoU+4t4tlP5R1t3mPC+otBz1i4Gm1H2hpBLOePffei1PyPx13w/y9bfL2SQ/pjArXYOQBKdw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(186003)(38100700002)(122000001)(83380400001)(8936002)(54906003)(5660300002)(7416002)(66946007)(66556008)(66476007)(8676002)(64756008)(66446008)(4326008)(558084003)(2906002)(76116006)(508600001)(53546011)(2616005)(6512007)(316002)(91956017)(71200400001)(6486002)(6916009)(86362001)(6506007)(31686004)(31696002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1NsR1czSWNUQ0hMeTRlWjVxRHNxV2haOFRQbVlJYzRrS0ZtZ1l6dnRSWUVV?=
 =?utf-8?B?SWZibEVPTjJ3UklxQ01ZUitwbnpjSmQxQWJ2MTdncXVJcS84eDZmN1JaT0tF?=
 =?utf-8?B?UU1BVlhOcUZ4QTM3NHBLSVNjMlo2L0JKVkxaZnVHazJ4ZUJ6V0hLMkpuVWdw?=
 =?utf-8?B?OVIrMFl0VmZFVnRjWjhvb1VHWTJiakFEWnB2QXRLS1p3YjRzbGczMStyQ3My?=
 =?utf-8?B?aDJsUGdrdlJ5T1VzenZSVnVVQU1qVTlRcWw3bjdTZWVrY0J2b1VEckJWSkU4?=
 =?utf-8?B?Skp4aHZDSG9ZTlhuVHM5UVNBOEFzWUEwdFcyc3hnSHZVN2hSSERITTlnVWo3?=
 =?utf-8?B?Vmg5T1kxT1hlc3lYS0IzVW9DTEFTTlR5aVd4Sm5IU2VQdWcwSzhncXdzVlND?=
 =?utf-8?B?MCtzZzJxMTNBNW5PRVozQWZtYUxoM3pFbnBOVGpzckd3QnVIMW1QdzF6SFFT?=
 =?utf-8?B?S1V4Mll6WXAyaVc4VkJyTE9EODR3V0xMSzM1a3VTbDRSWmRtSWh3aUNVeWxm?=
 =?utf-8?B?cWRmZzRJOTJrbEpINTlVcHp6SmJDK0MwRm5KSUF5YTJ1b3ZPYkFIYWlLYjND?=
 =?utf-8?B?UlFpMk5mS0xESi9lSlRMa2FxbE80UTRkM3U2ZUljdUFUdEpQTHJ4cTBtWlkv?=
 =?utf-8?B?djZTUFpQL09iU2NxTElFOWZYbEtJTHRvN1VZcFJob2hIelVzWGZFNStpaFlm?=
 =?utf-8?B?T0NiYzdBNHNYUExXS2hNdkErN3RwT1FIdlhJZmRsbWloVUxybkF6dzZNSU56?=
 =?utf-8?B?SmhjaFZZdk52VTFTUnVnOU9qQ0g3aDhHekZJb3J4dTVOaUdodFVkVTVkdEs4?=
 =?utf-8?B?aWY1ZEpKaE1XVkROdk9Rb1pvdHNMTXZCbzdxZjJrMkRMRFE2eE9KaCsweHB4?=
 =?utf-8?B?cUJCd1d2OFBHNDhZYm8zeGVlc2xoZXVWOWlydUpJeEdUbHZwbFRFdmJxUUZO?=
 =?utf-8?B?TmNFb3BxQ2I1WW9RZmM1ZWRBeFJ2a0JDY2pzZFZDWFBaeGdQT0hQQ3VVcWF1?=
 =?utf-8?B?UU0zSFgwNlpPeHBzbmRQeHdoeE5RNEFTeHZ6WEdxYTczamhIUTUySEg1T242?=
 =?utf-8?B?eEZ4ejVBMWhvQi9CT0pMSW9wTDRnbGNuMEZJVnUrOVlkcWNJYkpDZi94aUtj?=
 =?utf-8?B?Zmt5NHJ2M1NVUW5FOGNUYlg3dnpKVGVZUlRhZjJpbklMSkVKdUMyU0tWNHNV?=
 =?utf-8?B?Vm8vNUQydkNxby96Tm9IanZ6alBKc1k0NE95anNad1dQV3huMTVhVzdqOGkr?=
 =?utf-8?B?dENna0NZZ084VW5OWWw5bmVEUEZ3c0RRaW85azhhR1hqNXkvQUFXT1FRVFBr?=
 =?utf-8?B?Wk1nMWUxK3lyb0ZDaVFvdHNzbzk0WnpPYVVEL280aGFUelFQL0E2amoxUWZT?=
 =?utf-8?B?aU85ekZQbnhUUU1yaHpUZ1M3RDNVVWtlOWZCRVZKYzR1bEc4d0ZPWFVZdkFE?=
 =?utf-8?B?WExYZUZVTmJ4TUxlT2tOZVR2amI4Z291Ky9zakNEQk5ORTJjTjdyVW53QlE2?=
 =?utf-8?B?YUFJMTVaK3plL0pEeXJVTGtWek5SeW93UStJNmxTV24zbU1tTzRyY0lwQjRx?=
 =?utf-8?B?SzJSYk9EaWtVY3pRY0QzQWJrWXBzUUNmQk5KYlROOGkyUjRTeVEwamNia3NC?=
 =?utf-8?B?UWd1SGFKMWcwQkFTV2lURFpHK0xCSDJVbmQrckx0QzNTdyt4VXEvK09tbEtV?=
 =?utf-8?B?ZWdxWFc4S3dLU2lmbVpzTGtXZjdVWWlJZGYxR3NTRzV6NUVaVUJBYlFNWG5w?=
 =?utf-8?B?ZFVYZnFXWnJsMUt1M2poWFVDRWJFLy9ocHpQd0ltYm9DdkloR2Ivd21xSytk?=
 =?utf-8?B?UVl1dnNRR1FwUExKNlFPUHhoRHoxQkRZTkVBQnE1ckYrajFHN0FHb0VBRUZZ?=
 =?utf-8?B?UVpXVjYzb3JYK1lzY0drRjNVY0hWQS9aNkp1U01XU0VqU0RKYjdGM1ozYUYy?=
 =?utf-8?B?Q1ZvVmYvTUZSSU8zaXgxTWZLRG1USHpSR0haZGFxL0xEeS9XWVJpVDNEbWVL?=
 =?utf-8?B?aVdqaE1FVHdtSXlvZVQwakJoam5XQVdKdXdpN2oyUlkrejJ4c3dkVWVXeEVQ?=
 =?utf-8?Q?Dc+Hvw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FC8A5315028E84B978E4D46AF02C937@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ac9bc9-d5cf-4634-4356-08da07333296
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 09:56:09.9000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y4Vy1oMeBR6v42o0tI0SrJjVLBA9ebWfoOWvWnil5P7+1LUeLuqJMt1YKDqpnF7xnNtpwABwAp1yvGFXBwN2XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4787
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220316_031058_703031_FA635D64 
X-CRM114-Status: GOOD (  11.71  )
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

T24gMy8xNi8yMiAwMjo1NCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiANCj4+ICtzdGF0
aWMgaW5saW5lIHZvaWQgbnZtZV9zZXRfZGlza19tb2RlX3JvKHN0cnVjdCBudm1lX25zICpucykN
Cj4+ICt7DQo+PiArwqDCoMKgIHNldF9kaXNrX3JvKG5zLT5kaXNrLCB0ZXN0X2JpdChOVk1FX05T
X0ZPUkNFX1JPLCAmbnMtPmZsYWdzKSk7DQo+PiArfQ0KPj4gKw0KPiANCj4gRG8geW91IGhhdmUg
YSBzZWNvbmQgY2FsbGVyIGZvciBhYm92ZSBmdW5jdGlvbiA/DQo+IA0KPiANCg0KSXMgdGhpcyBm
dW5jdGlvbiBpbiB0aGUgZmFzdCBwYXRoID8NCg0KDQo=

