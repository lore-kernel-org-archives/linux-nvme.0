Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8027C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jun 2022 22:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lX8OaVef7PPpSCxtxC0NE/UgdiodaKpmWdLdWqESA14=; b=KNCGFw+1AO9ExzykYLoQz0r3eL
	FQyk/Me/DmzQnDAsernxqDWycX1ayR1IO5BVfTjXHEFWYs1otexAtPvVWWzxR0xuJ5WlChT7MO1sD
	vm2HVSDhW5dmLuWmf18arRVYYHUmiqRSbrBFwiEgCVLBhmU/fN0CHj4MmPBJ4Aqrr5lk43EA3WNMj
	ZLFPhfdx+Li7L3KygwH7xkkqqxoU43njB5hjAVB1WZskVT74uetwQNmjoXYyvUFERafQUH5zLgZ+k
	1rt80ou1NPY0mjp82ieoDi1ARx9QWZ4K6G6bPa1mk8jug9BGfBkLpCDUprTVp3I40Eha602vQuNWw
	/XsHyWQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0sZU-00666s-OX; Mon, 13 Jun 2022 22:30:08 +0000
Received: from mail-bn8nam12on20604.outbound.protection.outlook.com ([2a01:111:f400:fe5b::604] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0sZR-00666L-KV
	for linux-nvme@lists.infradead.org; Mon, 13 Jun 2022 22:30:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaVJiGAOPT2lNH2+rZ0Pda5xZRgMn0vP06+ug//mww58pPXcsWI0q/gw0lHJ9NvCoy/z4jXBtCA1mqQNFQUIuzmOnMq55mf9f3zj1jSBm6/QodIVZ57C8qs3mQW83Kkr+Hu/7tR6RoT71xRzbX6hEzfwKfHNbh5xLJyJkZSy7aCgVJwG8h+EAFD62xE427xK/tIubhXzibDvABzdkkH/7WPMVoQKPvj2P7d3kufijFCBf8d4LaR20z2JQByuP6EGJieQRsQE9DIVXwhhtufkSMkvSK4jOYEE4iSYprZE1poHe+CtpS70liJqQEM1+q8rotfHETi975fmyC4iqG/5rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lX8OaVef7PPpSCxtxC0NE/UgdiodaKpmWdLdWqESA14=;
 b=GHcA8R+tH/r5/48tq8hJ2cdPRmgTTeeHvEguCyvUmyeMPSmgvBxfvPUVZRHNDbC9wJP1jTChyHtSxhH+Ucpc0VMB7gAMKRwsd8yj5e6xKBcuLitxHErpK4A03doZgUFLfFS/wnBE1IsjzOwDriL3Bc9P3fcF1CMWr/jIu5P6/uFVOju7nVtG4gt11Zs1jSohB/3XzzQ9OfWDa6z4eXmGvFKnKFhb1CohzZQY3+STAFx/7snCsuPw6f7LkSX6o43DRRLNs2YgQf5RPC8WKoH8Nw6ddLt9xYoQH531uL6hM04cvWJDiM+mUSjCYk1bkiJh1IlPpesbCDWOW533zWjLwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lX8OaVef7PPpSCxtxC0NE/UgdiodaKpmWdLdWqESA14=;
 b=nR2w9JjQ1vO0T5AwCL9vnUNne9jyICFbLcl5CebJbH9WaGBY/mgLffpwgvq9Oa5LmlJF1lCnMfwYPJWLu72Ky7LN+lGmFIqMPIa554gm6VKZaeBzHvP59kIl+yL98/6Q7GEnIXMqvqhagW0FzFqtSYVwrCJfo7ZU9CJhDVnAyjS0n8DkBBX0P7TNFhHidPu1L3aql3+9y907QR/M7gteFXw7/4t3h4NqGa61eH8usRQvur36R4ijUSc+CU6GcZd4dT5HDCY6t3zmK6lcPbcp6mdTjvqHgobdUP3sY2sXJl3uKwCc9hu79T2R6fJH1zvGYNlsRMuxcgmzkk5sOWFArA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BY5PR12MB4920.namprd12.prod.outlook.com (2603:10b6:a03:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 22:29:58 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e%7]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 22:29:58 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCHv14 00/11] nvme: In-band authentication support
Thread-Topic: [PATCHv14 00/11] nvme: In-band authentication support
Thread-Index:  AQHYe0aSk0irjXINo0eCGJTZzeAdv61GRZ6AgABSZ4CAAcEZAIAABNgAgAAEf4CAAAHmgIAAH80AgAVvhAA=
Date: Mon, 13 Jun 2022 22:29:58 +0000
Message-ID: <e0d65fb2-2e2c-9bd4-8d2c-6c728f15f5a6@nvidia.com>
References: <20220608144518.67607-1-hare@suse.de>
 <bc6d292f-f1f7-3cc4-772b-ef8e2a6466db@nvidia.com>
 <3d2cd533-6bd8-abfa-4df9-40aa6a2eae63@suse.de>
 <7b9bdd9a-1411-ca0d-9f87-71e2c25dffbb@nvidia.com>
 <af8d390c-abd7-d4da-6bd9-99354b2ab2c0@suse.de>
 <c0da59d2-52ab-e219-8610-5f253cde7076@nvidia.com>
 <623745a5-78cd-7280-97ca-f91c4f4b6720@nvidia.com>
 <d1e30f4f-7c6c-4728-8d13-b23b3b7ae740@suse.de>
In-Reply-To: <d1e30f4f-7c6c-4728-8d13-b23b3b7ae740@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b43f9f2-ab7d-4f1e-ba7d-08da4d8c3fc5
x-ms-traffictypediagnostic: BY5PR12MB4920:EE_
x-microsoft-antispam-prvs:  <BY5PR12MB4920B79E55894815223166F8A3AB9@BY5PR12MB4920.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  HG5G4n0/XqUnpfh/kW554ePdbTuRGK+bxhTgTFwC5MAkoqlBG4ftfdnvFodbTyL1CnymuZ95uKBWyzM1gp2bdrMxFK/l9GurSiKQEnJYisOoVRKAIGFUKNQVJLAQ6RgGMo+Wm6yLnfqx8DDD1qz4NA6/8iSX7pWxuFJ7IJilO/LgxUuSvztec8sbthmbLGttFRLzRLmXLx2yMRhBdPsoNiad2BIlanfObKKCgIrQZ+b84HaFySpi+nsj+2Vf82xfuBr75uZtByTF0F46lVZuWDzMmad/ACfMrF/+eDAsUwwZ+ju7V+fA5Zw98tXrldxZVKvkvEFtTERP9dtZVF3WeB3aHCQYjFaynMotE4Snyso2nPmBA1LiMN3HLr8TrGgQIRj+Zf0gsz4T+9BYJ6+1o+X048K/PcMMcp262Dk/8jdj+v/fQ873q8HKuKXDt1tedIrdWTeudzk1hYhU3hj7pDgufpDm6HtsoYnSFPUa5TYx0N2KPXOStif7SQtZGzP21BJCtPXL4yTn8WJDA8YtuvadWXHdoF0cjG/GZ8/Cs6VvHHpz/q1vzUiROlGvU0a0gNRqFRypYvh2EmIXXZ1SjTUX28ScPgXeRu9uc8I/0u5oalM4zfPqkdRxMKkAmYCM3bvlbakFeEmWNXRUyDSCcFgwAuOkLnevX62uppVxF9BFo+yJp4ghL8sdtNCrejrf+1YHOcuzxOtN4/as99wxuJsHXeQfLos7SIeBnPZ1jms+GjaGEAee6OL/W6a51kNK4mpzUmWgNoW+T+rFAkhcSQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(8676002)(66446008)(8936002)(66556008)(91956017)(76116006)(66476007)(66946007)(64756008)(4326008)(53546011)(122000001)(6486002)(86362001)(2906002)(508600001)(5660300002)(31696002)(36756003)(6916009)(83380400001)(71200400001)(6512007)(54906003)(186003)(4744005)(6506007)(31686004)(38100700002)(38070700005)(2616005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?R05lbE5WVnpjanpyZElHTk9MU0pBT1pndmU0MzZtV0l2bUZJZnVkRWpNZjBj?=
 =?utf-8?B?bjJLMGQrdFU3U0FIQjJRRFhZd1RVeThsRGRFZkd3U1c4VmdCMnB0TytrZC9F?=
 =?utf-8?B?MEVIaGFwYW9ETGIyNFA5dVBNSWV2d3orUzk3bnNBdmhmQjJMMzFwRTRCRC9Y?=
 =?utf-8?B?N0RNRy80SFdidWZWQzJRL1ZJVVRTR1o3K3liZHNGSWVPY1p6WWRKNXljTVBL?=
 =?utf-8?B?OWgwUnNTUVgwUmVKT0ZzN1FpczVmV1NRNlhyanN1ZjhHeXJjZm5UZ2g3b2ZQ?=
 =?utf-8?B?bTdFTGlhT2VsaTUvcUlDQ1cybk16cGRrNzZPb05Xak9pN1JmbkZ2dTE0a2c2?=
 =?utf-8?B?TTVZNEwzcy8rUE5nSnpJay9LNkFqQWhhMkluOUdmQStQK2lPNjMyd09sYldt?=
 =?utf-8?B?WlZpMDdra1hEY3lOUzh0VGhsZDYvdThKc1RFNjJxUEVQblRLL3NjSnR1NUpq?=
 =?utf-8?B?NnhYWGxaSDZxRzh5Ny9MbHZCK2l6TEx0RmE4dHdtQ3JteVpGVEZ4dWlNbXRF?=
 =?utf-8?B?RWJZNWJmVDVUQ1JVMndhWkhLYTBsQzFNdU9tK254M0RvK1FlN2JyN2IrRExt?=
 =?utf-8?B?eVR0a0NpbUo2cmp2L2JGMEpMM3JoNzh6eFJuUXpQUUozWDZValFjS1RnTVMw?=
 =?utf-8?B?TVQ0Ui9ZeXlOaU9tMjYxM04ySmVxZDhNb1JNd3JQcW5iaENQZldkUno5MEpp?=
 =?utf-8?B?SnN4RHQxTDhMc2tEUlFRR2NDa1VnZ3NtSVpyRXRITktSbEdaOHRScXY2WXAw?=
 =?utf-8?B?RklNdXhGc0FuWThIRXdNd0NTdU1FK2xmVnNBQjE3anl6eXpvMXQ3dVpvdXpL?=
 =?utf-8?B?TWx1RjZlOFVEdFNYSEdQaXloZFlhOWM1UDRWUjFZK0E4aTZBSEdta1Z1OXlL?=
 =?utf-8?B?VW13bkIzUE9tbC94dnV4TXdQWTV0TTExb2gwV0VCRkZCd09pSUY2TGp1YUZz?=
 =?utf-8?B?VFR1cENFU2ZlNVh1VjZCaitaVUN0VU9kcW02cUUwT3RKRXRFRHZOanVIalpo?=
 =?utf-8?B?Rzk3dm8yZzlGUU5pNG41QjcrdFR0V0FPaVN6SENaRnBLUk9UaXJmUG0rMEZY?=
 =?utf-8?B?K0FCMGtPQzhnNGhxYW5BNE1oOHRRcHRMUys1WVhUV3lHZW9FNHBQUnlsd1pG?=
 =?utf-8?B?LzFzeUNhVUJJSkhEbkhsaWw2VXJqWHlXR25FT2dlTGhQdnU0c1lNZ0ZSM3dR?=
 =?utf-8?B?aDY1SHlsZVpITk1RWVBIdWJTSXhRRXB2K0pFdUNhbnh5alJhNFFRLzhXazlk?=
 =?utf-8?B?cTZUVFpENllSamtldnVRelFBTXRydzJobm9IeU05c3YyYlp2MlVJSVg1aUlD?=
 =?utf-8?B?SjQ1MEtRRHBOUlpQa241dExxL0o5MXJZd2VnSThtV2tiNWZaVTl0NlhsVjVl?=
 =?utf-8?B?VXZJaGVmUkVoRVVvZ3RPd0Zha0NrNk9kRzdsMkFzZE1KV1o3V0NMZ0llWEpZ?=
 =?utf-8?B?VlZ0ZUl3RytqSlY1K0hGUlpZY2xTOTJvWENBYi9HUngwU2NETHMrUExHcVVB?=
 =?utf-8?B?SndCVEQ5NXJYOHFnVUJCcW54OUZsOFdqckMwL0NTbHdDTjd2L2VTcStXbWZJ?=
 =?utf-8?B?eTV0MDIwNVdZRTJKTndSalNML0EvN0JtY3pFZ2liRUwvMy9rSndVSjRBYjRk?=
 =?utf-8?B?Qk81N1FqdmJRb285Y3pUckg2aGRmc1k0V2I2L0o1d1VCNFJZNWZ1eW41Q3JZ?=
 =?utf-8?B?KzNXVURwUWlTam51ZGtSRkVOTDRiYndLUnJ2cGtnM3F2bnZKeXFlNzYvSEhq?=
 =?utf-8?B?UDdqdCtGSjhBQkpaeXNERG1rVkhLcHRnQWRVRlhqSWdkdUN4SWJYTmhDTWlj?=
 =?utf-8?B?cGlnd0R4NGJodEN5b2syQ2g3Qm9hRkZBMjkzU3VVNkY1SEhIaHEwY1BUOENH?=
 =?utf-8?B?L1JqUmFFK0FXZjQ5OXFrWExOVUdSaVlSaFd0NCttS25LZlBPbzFHeGxoa3RX?=
 =?utf-8?B?TklYS1E2amRpY1AyejRvaXFOdHBtU1k1MU1IbjZRcVJzYi9zYkk0SWM0WlBQ?=
 =?utf-8?B?OWs4c010aXZ6UElLS2JVQWZjQnRIcGpMUDNaN01ER3o2NWdnUWRkMFRqSm9B?=
 =?utf-8?B?cTJSVkNwYm12Q3pYOWZ6S3VkZURDd3JZbzBNL0x1bkpNekpBUUNxcW45Z0Q4?=
 =?utf-8?B?T3NUaDRndnIxTlU5UmJTQjFmS0F2MU5CV1Ntc002VWp1N2tyNzZKQkFUeU9w?=
 =?utf-8?B?TlpVUnhqU3lzRi9KSlNtbHUxUTFiWU96aUlZZitFMitkKzJiT3RLaUNIVy9J?=
 =?utf-8?B?d0hWQ2tCWDFlRmtNZWc3VzVkUWRGNmRrb2ZNWTdYK3ZqeWk5UmhRYnEvaS9P?=
 =?utf-8?B?S3lHQ1lxUStCWXdYNExPL1FIcE92czhrMnBsa3A0R042R1NZYzdiVlRkaDh6?=
 =?utf-8?Q?247xLVz3UuoJNJ2HLWsWUJk4o1mjYqVpjoUIA8K5rUCKh?=
x-ms-exchange-antispam-messagedata-1: gkKPgLUbGrphEA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB6FB846FA87D946B7E545D77B9AAD0E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b43f9f2-ab7d-4f1e-ba7d-08da4d8c3fc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 22:29:58.6560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jL16Ldw/qopKLuADzeyJYxq4OuYaYRRf8LcCeoQHhVdy6hLewin/xvbh11u6SAu/Xb4SOyLJEDwK2pTPRX9DXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4920
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_153005_923319_86A14E1D 
X-CRM114-Status: GOOD (  15.61  )
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

T24gNi8xMC8yMiAwNDoyOSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOg0KPiBPbiA2LzEwLzIyIDEx
OjM1LCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+IFsgLi7CoCBdDQo+Pg0KPj4NCj4+IExl
dCBtZSBrbm93IGlmIHlvdSBuZWVkIGFueSBtb3JlIGluZm9ybWF0aW9uLCBJJ2xsIGFsc28gdHJ5
IGFuZCBkZWJ1Zw0KPj4gdGhlIHByb2JsZW0gdG9tb3Jyb3cuDQo+Pg0KPiBJJ3ZlIG5vdyBjcmVh
dGVkIGEgbmV3IHB1bGwgcmVxdWVzdCBmb3IgYmxrdGVzdHMgKCM5NCksIHRoYXQgb25lIHNob3Vs
ZCANCj4gYmUgZ29vZCBmb3IgdGhlIHJlY2VudCBjaGFuZ2VzIHRvIG52bWUtY2xpLg0KPiANCj4g
Q2FuIHlvdSB0ZXN0IHdpdGggdGhhdCBvciBkbyBJIG5lZWQgdG8gc2VuZCBhIHBhdGNoc2V0IHRv
IHRoZSBsaW51eC1udm1lIA0KPiBtYWlsaW5nIGxpc3Q/DQo+IA0KDQpDYW4geW91IHBsZWFzZSBz
ZW5kIGl0IG92ZXIgdGhlIGxpbnV4LW52bWUgaWYgYWxyZWFkeSBub3Qgc28gSSBjYW4gdGVzdA0K
aXQgYWxvbmcgd2l0aCB5b3VyIG5ldyB2ZXJzaW9uIG9mIGluLWJhbmQgd2l0aCBDaHJpc3RvcGgn
cyBjb21tZW50cyA/DQoNCg0KU3RpbGwgY2F0Y2hpbmctdXAgd2l0aCBteSBlbWFpbHMuLi4NCg0K
PiBDaGVlcnMsDQo+IA0KPiBIYW5uZXMNCg==

