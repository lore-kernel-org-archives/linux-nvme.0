Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B5FC4828D
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Feb 2024 22:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eaDQdAvbWSoTV7MlnO9wd7dLh3f+qRyejjvzo6jnTzI=; b=41yNVvgXG9ZN89UOYBqP1heODU
	ezPD2a9v0FmyeoazL29AeSCpPV40JYadec86KikmkXRfsrP7FE8+VCO56W9c3DhC5/bRYKAtyGyb9
	7GZFC+l7K5deFOsFlWlGEqTPB3gH+AelVcHvQOfFLveDxZLWpp3yURYR1qzNHvkzk6gRbrvvH6rRQ
	xQrTLFrITeAAEdO1xtU2KZm8fbkaUU5MPkE2g6c5xtjh1OzTU7LVgKTC7N/tbi2CXFBoVBLdzAmyb
	4SRkXKdQT3NZopveP/x5DxcSUoCPCNbpcuPwfV8W8Ky2t58QgzM+zEJfTmCYJcQ+4E8s9PLG4e11B
	yAFQ8bjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX7UM-00000005RTS-0kCL;
	Mon, 05 Feb 2024 22:30:54 +0000
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:2417::601] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX7UJ-00000005RSX-1LKx
	for linux-nvme@lists.infradead.org;
	Mon, 05 Feb 2024 22:30:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyIV/HDt9xpGTZSOat0JbRn56u2DXueBpoK5qTxzQBUTLxZAWSOF6l8Ok+SUfaprv1Tw7lyJhbqGQQT2XUIHXOjZLxUPs7TRG+IF7SsvL53N3Skt+nqh3qricyGyWaHfyEKoEIbqQgGhuGI+KWqy9Zda8CCHKqoCqfBAzaIL0uBhnAko+hqCC6T7mJt6OsmHB45kH9LnEepuhA7gQqGHfeeayZnzW6AA+MBprd9JmHClnMT26Vh8aiZZyPkfdnNTXfkNBZcnHkglqYCblLE9KTyA8f5scdRXyzWtURFgTtqnCO32KkD4RLMvEoUfun7a+7hj8NvX+ZdjbOofOfRNFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaDQdAvbWSoTV7MlnO9wd7dLh3f+qRyejjvzo6jnTzI=;
 b=WqQ8SjFOSf3InWNRkYM0U363fviCfWWYyTbsIBjdwl/Mh/CMacjQGra6gAfN+CfaaN2N8EokO85Iufjm8FTP8LieFn65fu61wqSC3qBlPAYRA7oW9Obr0v2FXvIBD8UupZSqIdQsA+P3RLWrfQMvD23f6Ie2TeAyVB28GMBMEgmcLQIun4sxPrqKUpjA1B21zVUqm1m7/DZ1SkE3SfguSQenKOeOYwZobyJWNl0Rw8t3kJtAViGhe4M6p7uAq2GMRPFk8KvF2LKwNNuN1nhzTRWQQJk0snYQD7Bzj6ZpyiBq45y/lBvq6TSQB6moju2PjXyw71TCYvafFoE5SKrivQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaDQdAvbWSoTV7MlnO9wd7dLh3f+qRyejjvzo6jnTzI=;
 b=Yzz+WuoA8asitlMz9xVw+gYT9JpalAGuoVViDgwuMtXkFcgMGAISFqnXu9Ue4pguXIJTbkwePrZaD3o+0HlkBq/nWThDxbldlKGkq3HmhWz9dzxzyVrMDaiLKJ85aTXB1s4n65KPguhykMzbznDiMKusLMyz2iQP8/mzevrF2i2MJ2/leq/55+rAN4lGosA4qOhhqqJguF9L850ZRUAVLeR6WheRc/Zc8NYQ/oTUYOhvYSIzlX7ArV/92Da2sv60GeuiVcaCLV5Jrln39ztjBCML2Gf3sGjraYbl6D4V45eZFuY3TtIcq07lJhtj8vFEg2W2m1lQDOxKbnLsdlwLYg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Mon, 5 Feb
 2024 22:30:22 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7270.012; Mon, 5 Feb 2024
 22:30:22 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>
CC: Keith Busch <kbusch@kernel.org>, "shinichiro.kawasaki@wdc.com"
	<shinichiro.kawasaki@wdc.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] nvme: test log page offsets
Thread-Topic: [PATCH blktests] nvme: test log page offsets
Thread-Index: AQHaWGSLvF98sFoeGUCmkSxQW36iwbD8VQWA
Date: Mon, 5 Feb 2024 22:30:22 +0000
Message-ID: <b6c119a0-b349-4d84-9c57-4b99321e612e@nvidia.com>
References: <20240205185225.2878642-1-kbusch@meta.com>
In-Reply-To: <20240205185225.2878642-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB6332:EE_
x-ms-office365-filtering-correlation-id: 8c73f313-e378-4b8e-cec7-08dc269a0a87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tx2ksoIPqdoQdrAmNs8khpmrJmo05UmdA9QPlw/D7byjf2DWkNuS1ylwO2/Y+cs0thTNwvV1uw1UIq7uW/YNiYm8xZVJ/uVyUso/ezwa2oFyXmiFseHgRvtT1tfnaZOJ0j140j+j/T32dG+dAtHy+2jkoywSCkQAfR0jneMglmWDlfBEWFPzx6CxvhvScczYKbEvf2zHXhNCiko4Sonng4dtq/wXyC9YjoqvC+iEGO+I4qU7QICK/Wf1Rwvv0GbVoPkYB+EArJ63V+XWzRxrO6o7HgRl30saxcsAa6hKVmwwLFVogZ08LzdOzeDa4IJitPlAyha0lkGTKXgllYPJnAfIAjBlNQ+bBs77lrSOe0wJcHwJiQYCVdBNmSzV5GsGNpFNwdZEISpn9yMJZcRFh9tejMpHmWCczAiuqaO14WFohhQ2Jzwp9rzuicEa7hhrNzFCc63O3cA1bB0CGVcfw5DwFZwMmg+vAte+pVHFW9xcs3gjE1EsLozcUsKmOhLl3eOv3Daln8cavJ0SuIYGd/pPNjjELnDicBGTjNxA7KkhThF2cX4tY6xlonQ66xDiKu+jnyfv4k6lsCtNI5B/mrHbu4mTVPe7mgS9zVYGjbB1wvI7Mv+QP+09oNdi0UIEu21dEz5EXHm03iPOKN6orr21PLQdYfNNSLRNBbcJ7uyRyHpiGSndCeix2Dfdj2bF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(396003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(2616005)(31686004)(41300700001)(64756008)(36756003)(54906003)(6916009)(66446008)(66556008)(316002)(66476007)(6486002)(38070700009)(478600001)(6512007)(71200400001)(53546011)(83380400001)(6506007)(38100700002)(122000001)(66946007)(86362001)(4744005)(5660300002)(91956017)(2906002)(31696002)(8676002)(76116006)(4326008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGgwNDNiWWFrdklTS3NZUXNuVlhkSFNzZ0ZnYjFnRitMZXpkWUtlYStaSXNP?=
 =?utf-8?B?VXpEcE5DUE9ENnN6dTNUSHFQUXNSd0tWbU5zRDVNbUlOMHpjLzB0NzJGNTJZ?=
 =?utf-8?B?LzJrYmIyd2I0K1MyZ3RIR1huWjlsSThZYWY5OHVDVnlERE5uNDM4YmV6UHNl?=
 =?utf-8?B?VG1xNkM1K0xPS3kxeG1FUm9CNm1lMDd4SzRzWjFac1BkUXpNVHVNWXRxNWpM?=
 =?utf-8?B?akpzZXNscEZnZnh4VUJIMHFFb0thQUJwdDRJcjNZSEcvM2wyaHVwRjB3UHB6?=
 =?utf-8?B?RjVoNDZaNDB1bUMzWHVwMFhlV1c2UUswejJ6Z2F6T3kzMG96UVZHMmMxYWg0?=
 =?utf-8?B?VVZrQnhla3BYUGk0Qm9wZG12Rk83R2JXMW11bHdXOHI2ZDRUSGUrNk5telhz?=
 =?utf-8?B?bHdsV3dVaHZ0K3cxeVNBajVsNkZDSjdEODUvSllUWnp4S1VSN0w1cExsV1hY?=
 =?utf-8?B?RjAwMXhkTlEyZk8xNTFPSGJpWTBYLzd1WVR4djhtVG9RT1F5WTNCbGFiMCs0?=
 =?utf-8?B?RmdGbGV5UXE5RHNNYTdUaXRxOXlKQXFUTXI2c3pnQ3FjcnErUUZqbEdmaENH?=
 =?utf-8?B?eXJ2aU5iMDVuZkZwK2N5WlJXQWtUaG9JVjZnaWlKOUtiU1d5SHR3ZzRsdGRl?=
 =?utf-8?B?QlBvVmcyTUp3aStoSHVQbC9keWFra3BOa2xrbXVLbEFZdTZPQzI0eGxub2Vn?=
 =?utf-8?B?Q3BZUWYrZEFBcHFZV1J6RnF3MW14Z0lXRmVybXd6aEEyUWVtSzcwWTlJd0R6?=
 =?utf-8?B?cmpLcXlKS2tUSmRabm1SbjNmTk4xTUFzUm5RMWtlWTBBcTd1WnFOVHZIMzVq?=
 =?utf-8?B?aTZmK3BjZVNGOFRQZkxOdzh3Mlprckx2ZGdFSjh4VENqTGdmaXJreGRwOWlX?=
 =?utf-8?B?N0RtMnFySHJpM0ZZZVVIQWNMNy92NG5WYlpvME1XUlRoY2M4VzZxUVdybVhT?=
 =?utf-8?B?a3d5VVRKYk9CYnRFekhRUFJsd0xVMk16Q2dSRVl5aWdYSkN2dkFOdUZFTGMw?=
 =?utf-8?B?OXYzbzRaeFZzanhrMFdFdHBERXExTllxdXNhZ0NBVzV1VnlvRXlkMGtDeFhC?=
 =?utf-8?B?UzZlYW53RFYyeXM3cVg5RksyczFUV1AzTWhaMXM1cGs2WVhCOXFwQUdlWWM2?=
 =?utf-8?B?clRodXVzTTBOdWlCOVJnVkM2YnNVNmdhd3dydW53RXV3anlyVmRNd2VVelpy?=
 =?utf-8?B?NzZKMk1idDhDZVA2cmV4VzZoVGo0OUFObktvTDhGLzJidWdNZG5lOXNMekJD?=
 =?utf-8?B?STM0RHNIQ3kzUUdtdnVwVHorN1Y1a21aUE1lZEp4MXhXSU5hZUcrNTRxYzM3?=
 =?utf-8?B?bXlBTC9rVVZwOTFxWEVTWWtPV1VKem0vZWprMGhsQ2V4eC9QdlBzODlPUU9u?=
 =?utf-8?B?cWxyck1TRHFEUUdCMHVFbGJ0dW41NjNkc0c5WjE5OHUyZWdyZUZVOWxRWTJU?=
 =?utf-8?B?dWVXdC9ROVBZYitKTjMxK2NHdDhGaHZDcWpOOWk5MFJXQWVZTkhxWi9lTTVm?=
 =?utf-8?B?R1g2UnlpZ3Y5b1VKdlpmWUZtY1BJR0hGK3FydHNIS0FQYSt4cndPNVc2YXh4?=
 =?utf-8?B?NHFrbFlQcllvUzB2ZHhQaXkraWxCT3lZMTNCRGN1dWRwb1N5S3Bxd1orV2di?=
 =?utf-8?B?Sk1rV0UvL1RuNm1sYjhFbklTNUVQS29LM1ZRV0RHMVhGTHZTYmh5Rk5paDR2?=
 =?utf-8?B?OVlkbmJZK2lWeEhtbXB3bEphdkpUeHZwVW1oYUQyWExzMHc5MkNpRHhnNkNZ?=
 =?utf-8?B?ZVIwVTgvdDV1bE9jVG1XeDVxbWhIRVdQSWtxMFhNSEI2RXlJQTVLSGZWamRm?=
 =?utf-8?B?NC94VVlGaDkwaWJXVVlXVC9pc3dvdzRLOXpRMzkxanlsZVFSNGkrMkxuK1k2?=
 =?utf-8?B?OVNHbHRzcnRIM3NqSlZOaDA3NzZHUTBxUEpjV1JneXhDT25VNFFYUUNWZUpy?=
 =?utf-8?B?ZzNhVGY1TFJqanlIbE5vbVh4cnN4dER5K3dub3Q1MkprcHgvOEhhVnM3cW9u?=
 =?utf-8?B?NS85d05XejBjTjcwL1duTU1YaFBWdUVTTVdFVEY0MDF0MHk0RmIzelJBeVNY?=
 =?utf-8?B?V2NmOHlhNmxJMDV5QkpUd1pibGQyV3R5KzUzT1drbzBZZm9KeFYxN1RUNkhx?=
 =?utf-8?B?dmxXMUxCeng1Q3lxb0d6VVNVcnVTQlJYVzdxaGo2U2pjWkUzamJzMkJrSjFo?=
 =?utf-8?Q?1cafPcLPPwL2XCgsD8eVPd5BB5D6tMkoFiq9AAV4kl88?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3ACC8A09B62B7E47881E4948A133430C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c73f313-e378-4b8e-cec7-08dc269a0a87
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 22:30:22.2750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y68T0NlunMQtvgm6UU+19VJuBYD89/t+E2dZbNDsajqYhpS3hxsmNoj9JbPypJQQKp3CWlhKthq5qBseWi6y+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6332
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_143051_382734_442A9D21 
X-CRM114-Status: UNSURE (   8.73  )
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

T24gMi81LzI0IDEwOjUyLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4gRnJvbTogS2VpdGggQnVzY2gg
PGtidXNjaEBrZXJuZWwub3JnPg0KPg0KPiBJJ3ZlIGVuY291bnRlcmVkIGEgZGV2aWNlIHRoYXQg
ZmFpbHMgY2F0YXN0cm9waGljYWxseSBpZiB0aGUgaG9zdA0KPiByZXF1ZXN0cyB0byBhbiBlcnJv
ciBsb2cgd2l0aCBhIG5vbi16ZXJvIExQTy4gVGhlIGZhbGxvdXQgaGFzIGJlZW4gYmFkDQo+IGVu
b3VnaCB0byB3YXJyYW50IGEgc2FuaXR5IGNoZWNrIGFnYWluc3QgdGhpcyBzY2VuYXJpby4NCj4N
Cj4gU2lnbmVkLW9mZi1ieTogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPg0KPiAtLS0N
Cj4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

