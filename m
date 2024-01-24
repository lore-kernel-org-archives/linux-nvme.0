Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774DDC46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 05:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OMKeFHkjPsGYx76fxZBMzEw2E/l6TLDw1KaDR5AJfRU=; b=YPXP4ZWrlDGVoS3u3U6VX+pkFL
	2LW7NXLIIuPqV/QhQnmi+opgef57teY+FLAaqCcX8Xg8Hv93VyT7/kN4Clf6bpvj2JAnQtFjjIc1v
	oU6yz+yT6L95UIr45oqN0MMF0fs4X0adtGQlTUsrqEjke8cth94/Bfz7g2UhaGzBq06K0SNH63r7c
	8SSCUvKhruzY7gBWhVGBF5mLvoR8Xmng659wO8ovchJhIKNPZnPKQ76Lk2eByuEnlNAVKqbm2XJo5
	vEE/GkrIihw4+EGRTaAZB12RVewu9iI2vlZbOYRVzPZENOnWUDs/3jhOkQREMd0v1WpmzvP07/OkC
	zwVIMCEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSVpb-001bAv-2r;
	Wed, 24 Jan 2024 05:29:47 +0000
Received: from mail-mw2nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:200a::601] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSVpW-001b9g-1V
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 05:29:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXlGZGTt0xoU6yHJLJB1MaUtsATRaf84HeepifHZa5IfDUTvtJIk7R8bCjWoEBFi58XB8yLq7sHFLSWCPBDR1g6UdrqFjMszGQFpxPQyafNWw6egYcRebCo4Iq+NrGMDv7c6sL9tbo9b7u6GBJNZCIetG2c6+nG01eG4x5FtfdlAq5PXdXpdyGGmj+7FD+02yeV2Fxr/Tw8XuEigrWIMeRBrfyrRqG+8UhY/oYUpI6RvSUsiyJfnH4H03yeumNzdJ8MVJ/cnfbJ51PSrGa/676GHns82CAMtwhNISzNhfs5qd1c13kE4IsC/zoBISv5ophzG3mITaHD08ZY7WUlXgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMKeFHkjPsGYx76fxZBMzEw2E/l6TLDw1KaDR5AJfRU=;
 b=iErrA/L1xE2EPXvsF7f+Utl2vqLPdUCF1q3MEDRqngXYWv+6tiAN/GXO4aVIZ+I9JO41cRwer8eM8yrglTPmF+KVHMMjYMG3Ce3As8ZogFpM3y7vmh0IC52Nu4zHUup8040DBfEl82biuewD8O327le70Q5zaC//x/LYYaiUe5iT1gV8YUW9ZuaP6RA1a6670SD+fK2edmT+9HcwDDzS3qHspzboogQWYy/MyjSsUAxTJqes8suQTgZt5ZBTGWd2iQ0r8rVqh9BBFxcK/kYBSVvKxrkq18vrFQPMTHL6jqMqo3r/EvIL3K2vBT+5jYDXmuZ0kcU1jOAXioUqlleM4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMKeFHkjPsGYx76fxZBMzEw2E/l6TLDw1KaDR5AJfRU=;
 b=gOsa6KdEy7XQjudtxs4wOD/nllR/td0Hz6qOK5ToMM8n4lfvPV3uIy5WDGcy1+NWczG3V7a+sOlAg4yIoP5FXU13nLEWuZnyncYwAOudxx0HDZvxm6o0OY3wx5dCn271kguHRRT6GTIDrCEbQDx5FtLYK818rWprUNjSD9DtlkWHy6KBTUBhQ+1WJpxasC4Li9AgY6y1o6sv6K8LqXVs5Ku0vHX/hKpg68yzUC0+k3eAT50rk/73HYGpzqsmYZUp2cHifnK7BLOdw4bvqErwLVuikI64izJ4Dr+mp6/xAu3cRGxmIuvbpuejmZ6sOsu3fJMksJzFHgw8XVS/kkGNxg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Wed, 24 Jan
 2024 05:29:34 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 05:29:34 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Damien Le Moal <dlemoal@kernel.org>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: Re: [PATCH 13/15] loop: cleanup loop_config_discard
Thread-Topic: [PATCH 13/15] loop: cleanup loop_config_discard
Thread-Index: AQHaTVm66bhrxcc96UWolvTxB711NrDoceuA
Date: Wed, 24 Jan 2024 05:29:34 +0000
Message-ID: <ba6f5eb6-f1f2-443a-b211-2fa26b1c0a8c@nvidia.com>
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-14-hch@lst.de>
In-Reply-To: <20240122173645.1686078-14-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB7590:EE_
x-ms-office365-filtering-correlation-id: a3eca61e-4108-4b05-51fa-08dc1c9d72eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f1WE6taYxQMU/zWYU4kvQzN2CqqpccUZXWPIF29IRmbRtf02vXic0pS/MJGOmNp/Y82J2kjt63gcthwNdZtcQWXiA3LVNpo5WaaeQyLvIZpeVcJUMqviIHIJTxKMdV1H9h5xU35wanNpLZWorzsN+fIC30pVj1kxkHj3sHDHdA1/+Zzqra4iw3bnMb0Cfvqp2Kpk6XB76IuZRZumuBj/5ZNioxCyNm3vvegmlyTbc2kov3hLBYQpXPPPmKSP50t8Bbi749aISqlyJljc7jL3xqU8Pb7A5zKenKdIMjP/uT/rtOrY1imqmMd6fcidxyIDnuDzMYWsMW9H6D1lRukMensr3OeuMwMbuKWvw8Cx7iz5FjAnS1M3rmEg2mpxfGKniSgy+BhO25gm0AnKNBGBKNm+WhnnyrWV4xjYKoyYyWRC1TPxaIcSLs336E3UexHelFE9I1gmBMM+uTQ90y0dY1lnPPwP594ikclaaLauvPZyr4AiWx//YsDKRRaUjrELIbn4n+8dBQBOclVeE1eapj6BJDv+wMTUzVUHWi9mLdwz43X4y0zmx0rRbyrQPvOyhMd/KNUO8riMdU6Jal8qiD0sClUUrK0ue7r8ahuvOoaMyoh1PDaPimaIxIlcoEhGUFQO9zYFKArcrCA9CIWsRyeNdJtQe8EmBpIBqlRjWI1K75DEQ6IWQiInlzCXOVN3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(366004)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(6506007)(71200400001)(53546011)(6512007)(2616005)(26005)(83380400001)(122000001)(36756003)(31696002)(86362001)(38100700002)(38070700009)(110136005)(8936002)(4326008)(5660300002)(7416002)(4744005)(2906002)(6486002)(91956017)(41300700001)(66946007)(66446008)(8676002)(64756008)(76116006)(66556008)(66476007)(54906003)(316002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTF6SVd6VTJaYnE2Wk9ZOGh1OUhwUE4ybmlVcHVIa1IxM3VhUncxcjBEV2Q0?=
 =?utf-8?B?eHFlRGgvYXUxNXc2K09YMTRGN29YNTgxb09kaWE0dVFXMXBOcSttNXdWMVh5?=
 =?utf-8?B?eUhJTmxxZFNNdVRtS0dOWUZ6bWV4QjZQaG92SUtKZmF5OHFyaW9qRlFaZGM5?=
 =?utf-8?B?dG4xaWtIZU0vM0NrNVVMbDFsanV5M3RvSEp6OWNWQVpPUG5CbVlTclJ5TDdE?=
 =?utf-8?B?c0RleXVTQW90R21wKys3anE1cFppSkZIeU84b21QTWx0UkNXNXFjcmtMZlNl?=
 =?utf-8?B?WnFUYU5yT3dndC93d0VlNUxNNG8wSU5IZWF4NlllcmJ4VHZ5WUVadHlIZGll?=
 =?utf-8?B?cmFCSTFKdmgyZHhxRXkzWkMxWHJaRkh2TnJqcWdxTEVsUGxDTjJzWk02ZStv?=
 =?utf-8?B?TnlwSkNuaHhFbUpCUGhNaG1SOEhiNjhPcEp0cTE4VS9IK0lRa1RwWEttZDRi?=
 =?utf-8?B?L25KL1ZiU0N0RGpqUlJNVDZOSG5nS1AxUitQUkxJOFduTXR2MUNPbE9JQzFx?=
 =?utf-8?B?ZmlWMnVpem9MNS83eVRvbVNJWEZxZUFYamNJVGF2dDdNUHlaMy8wbDlBRGha?=
 =?utf-8?B?NFdXQ2I5OWNMQmtLQXJmRzduT1VPYXc4bjNpc1RUVjdoT2NJN1dkOEdiZEx2?=
 =?utf-8?B?bGVmRE93TjgvOHRBWGNPUkRXZEFvNzFGdVZjTzdFY1N5L1RiT1dYMHp4TFZT?=
 =?utf-8?B?SHhIYmtWdXRDREk4RThJTTVhMUVWbzZsOCt6TUNZR1dCaVM3a1NjYVhiRy95?=
 =?utf-8?B?WDVURHVZdnJHck4rdCtKQnNjN0VBOEh4QXFlRnpMNVQzbWtUM2pJM3lWaE05?=
 =?utf-8?B?a0gyZytJWHlDcFQ5YlJHNWJ2NGhXQTBDcHkrQ0c3S2dZWlVHNE5IeEVyaG1M?=
 =?utf-8?B?T0EzN01lWHZxZUdueGNyMUh1OGZVMjhKWTNNOHdKblQ0UGdNWWZLR3FrUWZ0?=
 =?utf-8?B?TjkrMStyTXZNNXRKSjBlWExLdUg0cmVNd3hENUZ5QWd5bjdPSnNaaEpGdlNu?=
 =?utf-8?B?RVZNdjBHNDVPbDcrbmFzVkk3bVhiRG40NEQvbWx6cmtFdWFyODYvdlAzTTZx?=
 =?utf-8?B?NDFjT0pJbldVa2k3RHh0UVczS2tCMHhmVlRCN1JIY1lUM1V3ZDRidUtGQzZO?=
 =?utf-8?B?ZnVjUVo0Um5aeUJTaWY1SE1lcmpFWWhQcENoR1BFOXRiYXEwWUk5UnN4RkZD?=
 =?utf-8?B?SitDWnp1RWFHdVdCY3pvc0RmSFVlYWV6Ylh6K25TU2EyZHVweUFpQ2lMK1ZX?=
 =?utf-8?B?Z0xnNjc4VS9pdE1PRVp0QU5XVFl4ZVF6ZUlMeHRlazFZL1ZPUzNUUDdGZkMv?=
 =?utf-8?B?a2tPQVYwYTNNWUo2eFBDWEVlbWNqVmtwRTh1WitJcUxMaFpIWkc5eEFjbkpK?=
 =?utf-8?B?Z1pud1hkdWxsVXBzTkhIZHFyQmlablNkcHc0WENuZStqeTlDQUxyTkdDV3Yr?=
 =?utf-8?B?UVl6VnBmSE9BR09JazFId1hVaHhRUUpSMVlRNGllR04zNDF4cm9zcWh3djRo?=
 =?utf-8?B?S2g5cG9vKzFsd2g4cDZMbnIrMllWOURWcE9RQWI2dlRVUFZGYkxVSFVaMnBV?=
 =?utf-8?B?WVR2TzJXSENxM0w4UFg0bkp2Wkp0cXhVWXhPaGtLVlJvSzYyZEpENEJhQjFp?=
 =?utf-8?B?c24xRVRZZ0xWVGtTdHhEMHJJN0RFNVBWUE1EZFVRQW5DdXYzM3B0Qm5BajBu?=
 =?utf-8?B?dXFkOCs3SWFjSnkxdWFEN3N4R2ZlcmhiKzBtK09tUkJKMFBaMm1SVlZ5Qkh5?=
 =?utf-8?B?a1B0Qkl4alpUeGd3a2Fma0c4RCtWajQrZjhiYjl5cithdWdwQTJ3Q3M2UC9I?=
 =?utf-8?B?MTNzMVc4ZFcrVWRVUjVyK1FDeTNzOEtLeDU4dFNhR0VPY0Q3dHc5Q0htc2dW?=
 =?utf-8?B?dWNSYXhyWW1WNGpXUzMra2V6UU0xWlBVMEFiNjhhcmkxeHZYUlJzVVJLbDUx?=
 =?utf-8?B?VU5UVXhQV1VRWmh5OGpIRlJQOTc1b050YnlZZzJsUnpsMDF5b0FMYXVUWVFu?=
 =?utf-8?B?ZUhndHR5ODhBRkttQXJwWWEzUE90U0pkVHlNR21DVUJYekMzT0FRNUxSRXQy?=
 =?utf-8?B?ekptZ0RNOU51NE00RTdFdFdCeHlUY2xISlBaZWlnYStkK2VJeVVzaUQrY0hz?=
 =?utf-8?Q?VMAt0VqEVp0LabCI+aeZQiifm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <488F6F498F066F40A59683D4C1F83D57@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3eca61e-4108-4b05-51fa-08dc1c9d72eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 05:29:34.2764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ux3yzzivaEEyy5HmawH+4GKclC1QpkQSuYv7RzwnihLfvJSjbXwL6nk9VrmWDjzU8M7sydx4a10+hB2eVQjkvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_212942_529354_729A5187 
X-CRM114-Status: GOOD (  10.34  )
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

T24gMS8yMi8yNCAwOTozNiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEluaXRpYWxpemUg
dGhlIGxvY2FsIHZhcmlhYmxlcyBmb3IgdGhlIGRpc2NhcmQgbWF4IHNlY3RvcnMgYW5kDQo+IGdy
YW51bGFyaXR5IHRvIHplcm8gYXMgYSBzZW5zaWJsZSBkZWZhdWx0LCBhbmQgdGhlbiBtZXJnZSB0
aGUNCj4gY2FsbHMgYXNzaWduaW5nIHRoZW0gdG8gdGhlIHF1ZXVlIGxpbWl0cy4NCj4NCj4gU2ln
bmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+DQoNCkxvb2tzIGdv
b2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0K
DQotY2sNCg0KDQo=

