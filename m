Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30063CCD1BF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 04:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vAqY3MwibZBPLF7B9/sBInfiXkJQn2tey1/jkK/d6I4=; b=DS9NNQ1z2681e4py3t9s2x5D5v
	qw6M/gd8N7OEqpXebo8FIAlMxXatX1iybAzF13hcp3AK0p+jWsympq38C0VyRrzJ66AEfcUFQ9x4t
	+LQf/lAP9GmapmOhw4/0oZtItmGC1gL6W1J3VBZ1V23U88AzlsDkRfE1i8rKh87AGEQiU4+lEy6ag
	r7rUJOQF1V1v3+rY6lo0nFloXeCpsB4CI8yM80QaIt77vf3QBHTxPDH0s2x5I6yPr3aY14/RzPOAX
	yaOxBGJpZuJmKRLavlFNajJrKoRKhQ/CprCXC7jifAz46CjPACJYGsOq1N8N6FTcQYRYDTThT92Mr
	oeYvFkAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDxcu-0000000H9AO-2U60;
	Wed, 29 Oct 2025 04:17:36 +0000
Received: from mail-westus3azon11012030.outbound.protection.outlook.com ([40.107.209.30] helo=PH8PR06CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDxcr-0000000H99R-2ftc
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 04:17:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2YnNSRbECGVJVNB0gBNsG25KZ2vuA2DLYqI0MeMpeg58AvjlFH/TlK15YeKg9HAilDJVrfmrtA4SaCULVpc7GFIeApGoHqT+9gbzHbqhs67FZLNKvCL5y3s1ewX2fLjRY5fCRVxmLf+UY4BkTtj/n3SMdO1M9PXOMfXhpJ9mIrqWxi92JJEf2mzcLkHR8i8BWd8ognHTb7wbGSWaZrAzPpi372dl6anYYBXahf4puG4tMkyHt9X5eakOg1IB7idnSvbQO+3B7/FDZXkUmP+BC11c9CHu916zJ/LFAKB3CbtcPYWedF9eqWUqd6vSRZhSoysT/AgCzHsYZt+cCTUcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAqY3MwibZBPLF7B9/sBInfiXkJQn2tey1/jkK/d6I4=;
 b=dnVNXVxak9zTq0zItZH8HD6abe3tJdDcQLwSaaBjcycpQavrmFEU6sC16UlmHqrkMpbg8s4NtSYQkhH8D5uenstMBdMsvU5+ihdnfoR0x9RTyohVvsMhHX1J1TbXH0fOvZT4iR+j+I/iuNvNFA0C//tzzuh8gX9vJt6/aZvK8+09+X6FoWd34hNT0MfG2XZdiJQj0DvgWgFvo7/D0D9CT8OGpGkJ7QaXYkoiGrRuT7FJlSq2sHEIatA2h6AS6HAbKzPb81JooQhSbYkMqTZDdw7aDkrmD5XcePmzteCgpzksDXpQi8vmKjK0M5MINwhNxNKk4UK4MUc9v6Q6OhAX0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAqY3MwibZBPLF7B9/sBInfiXkJQn2tey1/jkK/d6I4=;
 b=I2LzcZhwgGAzrBE4XsnSuF24QAF0VJaPZIqjJEYHHxE1oncN5yRC0463+e4euhRrUIRGpSRyNwsoXPMZN3EAK/zOf1A5K9W87hH1LZPARH7tUlh0g/3edV/+sVROrdDRv/V3x96h2IZSzNjTKUzRGT8OhykGNbcwyTOziecA1C6FUhvXKnV2qe9gs5t9ObNNLx1SeMLrqahQv89xlZrlQwlcZCi+3pwUqOjU0f2FDREYl54+slsEbndJMo+4hxu34/RSwqLXJjU7uelWhc45kLLoB93kDgs2wZKJuwmCXzByWW6jtBmVIDrcCKpC1+/simqW67l2xSJR62tUOF+BSQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA3PR12MB7998.namprd12.prod.outlook.com (2603:10b6:806:320::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 04:17:27 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 04:17:27 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Jens
 Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCH] nvme: introduce panic_on_double_cqe param
Thread-Topic: [PATCH] nvme: introduce panic_on_double_cqe param
Thread-Index: AQHcQ1uPZ/XVoVOMEkSObv1C0WAkpbTPMQwAgAkyuYCAACthAA==
Date: Wed, 29 Oct 2025 04:17:26 +0000
Message-ID: <3d8c3319-9f46-48fc-aaef-181322329c88@nvidia.com>
References: <20251022135454.75767-1-kanie@linux.alibaba.com>
 <6dc4c33e-8183-481c-a101-8a2b6596d2b1@nvidia.com>
 <36c2cec2-7d0b-4ee6-a79f-d5e318a8fee0@linux.alibaba.com>
In-Reply-To: <36c2cec2-7d0b-4ee6-a79f-d5e318a8fee0@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA3PR12MB7998:EE_
x-ms-office365-filtering-correlation-id: 0627b2de-757f-4335-8d7e-08de16a211a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NDNsbjVpeDBPY0JGODNzMDhsQXhhdjhvSHpHWjlldUNHdDhLeXJHNEJZOEZP?=
 =?utf-8?B?c0xkYmoyek5tQnRMM0RnU0llK3hCaUFQcTZKMDUvU0FveWxPd2ZROTNleVIy?=
 =?utf-8?B?bEx0b2VxTS9uNjhrVUxoWkVmaS9iMnV1RWZXeWZySllTYlhIRUo4Um9YSTBX?=
 =?utf-8?B?c0k3NVY1WVYwQVRvTHVwVjRVTDNpU3V6SnQySGh6eTNYRzlSYjNkUTZYYnVO?=
 =?utf-8?B?cndNZGFiUE5uLzhIejZkT2NtZUt2OEcrTTBMM0xVQTJxNk5JdUp1a2JvaUFG?=
 =?utf-8?B?YVhDWk9NV1dySmdUK0tlSXZMUlc5T09NbUdnTkVXeEVtbzZ1YUZHaUVaT3NC?=
 =?utf-8?B?MjNvNlJxZkw5YUQvWTJ6TGRVOWVpSklIRUcvc3R1S0NGay8rakF2Uzl2c2pm?=
 =?utf-8?B?aWRCS2pkZjdjbFpBQm5lQnpVREttbnQ1TXR5K1JOSjFGL1FIOTl0ZU01TGJz?=
 =?utf-8?B?Q1d4UTd0UFV2M1dOcjdhRzBTYmNEbVJQRnROd3N4RTU1dkNGdVJiNVZwTnZr?=
 =?utf-8?B?SVNsQmhUTENKb0lRMHJrQTdFNTFkd3NBV1czNDF1MzFqNWZvUDZ5TmU1ZTk3?=
 =?utf-8?B?ODVhUisya2NKZVJNbFNER1NuMXd5WldTTStlUzlQcWp2UUd4cjNQUTNaQmVO?=
 =?utf-8?B?M1RseFVsWEx2RWc2S0Rjd1Q0QjZUWEQ4SlYyWTJyK1l5SnY3MFBMNTA5akF1?=
 =?utf-8?B?RTd5eTJVYmc0a3FUVkJKUVpmVU4rUjRkd0NjWjltclExOXY4SURJOUh1aU9D?=
 =?utf-8?B?YXczcjVEeVBTRFNPRkFucjl3dUhxZy9qbnB6NmwxM1RYb29hVmRCWjRNUUg2?=
 =?utf-8?B?dnBFdFJwNUs2bE1nRGVnOC8vK3ZnZkZFU2VCNDQvMkJNWTQ5ZlJVOFpCUFVD?=
 =?utf-8?B?d0I0ZDlmNmwwZ210UTFzeUdjY25RSC9IRDRMRnV6S0tSVkcwc2VzVDdvZ3Rr?=
 =?utf-8?B?RjFsRG44WGVnZml5T2syazNnUkNlOGtpcXRabWl4cDJnekxaZ1NZOUdRT2VJ?=
 =?utf-8?B?SEQ3VTNNS0o4VmxEbUVxc0JNNXRwMG9HUjE3cEtEZTBYdUkzNmZCQ0k4Sjk4?=
 =?utf-8?B?KzNjd1RyM2IzT2hZUlNuSnVpeWFCRHhwSmtydHZ0ZnBJU2d0SlN0bjJkWmYw?=
 =?utf-8?B?UEFQa3Q3WUd2Lzd4SWJvVDNPZitMbzh6ekJEM0NFRU1wYVQzVHQ3RHFtbzIw?=
 =?utf-8?B?MGlmeENmMHdhd0UyU0NpWHhYVGZOZnpSMkI1V094QnFlUTNaa2pvSW14M0Ex?=
 =?utf-8?B?M3I4dGxyYU5HbGlzRWFJa2VhNFVESGI5UTg1YVdGbiswUVBQYzhySkpWeWo4?=
 =?utf-8?B?dGNKQjVyaGxyRm9rUWs3eHBXVHlUcHVBY09OcTE1NlV4OUR5djJPRzEvQThi?=
 =?utf-8?B?eitnZFpvdDZpYTQ5N0d5RUsrdWNRWjNsVVRzUlV6a2E1UlVVWVhTN3pBM0dO?=
 =?utf-8?B?UkZlaXl5bjZjM1IvVUlGczdWUmJJdkY0YUtYUkFPQlVmdUErNjJkRytoMjlk?=
 =?utf-8?B?Qk1qcUI4RjN5aUJ1SXI4dzk2RXhrSGpMZmdXZi9zdkpDNENBczJreWdXM0pJ?=
 =?utf-8?B?c1dOTm5qbks0bUY0Sk9yMy9yd1pCbGVyVDQ0VE9rTmN2eXJZVGlhVy93WUR4?=
 =?utf-8?B?UURjdEdHaXQwRE41NVZNZFFSaDNpYVI4UTQySUk0WTlFR0NhM25OdklZMFJ0?=
 =?utf-8?B?ZFd5TFBqdWRLR3hIKzNHMThpTGFWREgzcFA3SlVUNlhQRmEvRXI5RFUxUmtq?=
 =?utf-8?B?bklKcE5KRFd2dXRBWVNCUWxRV2ZUaUZua1hDVTQwclJaKzVES2dOdUpuY04v?=
 =?utf-8?B?VHYvVmFmL0JrRVkwcklVQjRBcnZLUnp3OVY3Qk5xcXlyemRsN09FMGpsRDF3?=
 =?utf-8?B?QjhHejVDYUJEWGVEeFJ1TEsyYitjcUUyQnVscWozUWZtTHNIeWRzS0ZuZHg5?=
 =?utf-8?B?dmEvbnI3cExlQ1lhZGwveW8wUjBmLzRDVGlGc25vUFQ1VXowMitGTXVWeFIv?=
 =?utf-8?B?bldTU1Z1Y2JCcFRsRWR5YTJmRllkeHBJQ3EvTnpjQm51QTA1S2NRVVgxK1Jj?=
 =?utf-8?Q?o6zbm2?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cElEK2YxWmxCTER4em1oTER5YWFCelUzeHprR0tjR29RUi9jZ0ZndVpnL0U5?=
 =?utf-8?B?VXIzK2RMMThmU3hhbnovVWlRTDRod3hOY0tYQ0FJQTNWVXRpNWhBTkxnaWx6?=
 =?utf-8?B?THlYZ0R3U1RLdUlFbDFXaHBacjkxUFBjSlJ5ZnQzSFNwbDNnMkhBcko5OEZs?=
 =?utf-8?B?WXdiTnM0NC82V01vODFFOTliMWN1NkVyTlNUb05yUldHMmJiOWNYTkpTRXd6?=
 =?utf-8?B?bDh6ZStNVzlPalY5TlVtbDByQW5Bc0YzeGluU3VGdFprUDJIWDFQYmJ5Qi9s?=
 =?utf-8?B?elZ3NlM4cVE5TmJod0RXRUlodHBLVUZ0SVRLYXN0Y3BuWkk1amRTZFcvelhw?=
 =?utf-8?B?ZndveXJrK3RmU3BueWlpQ0pBTmZuTWVZOHBGQ244aTU0VHFXV1A2OHM4VXNt?=
 =?utf-8?B?alZ5UTM2RVpiTlFXWUtRQzhiaHhNT05ybm85NXZ5U3NLZk9ud1ZwaHcvb2tZ?=
 =?utf-8?B?bWJpZkxkRk5kSm9tTW1QNHF6dm9UU0RvUCtZNXptRzZMS25lc1pKZERaSlhN?=
 =?utf-8?B?YnY0RHZYaTlnNmw5ZERtM1BoZGdLQVlKSmowY3ZwYU5HT0dLYUtxZnpSRytm?=
 =?utf-8?B?cUEzb3RsOEJDSzRITXlkcnM2b0hMU1FYazhOMmFtMXVieXMvTGtzV2ZvRC9o?=
 =?utf-8?B?R25qVE1KMGUyV3RSZVRidTBzM3ZXWmtpNWFVRVNKZ05tZW5QMnlKVjFGOEVz?=
 =?utf-8?B?ejZSUXo4ZStMcEpZNnN4SE5adHBLakovK05hVHBUMThtbkFLY3RrRmpVY0wr?=
 =?utf-8?B?VVJmRTE5Qk9zcE9oNDVPeHY5L3M5NFM2bFVDMzBjRkRySzIvd2hmT1pJbFBy?=
 =?utf-8?B?ZnlBeWtXZHVkQ1N2M1hOVmE4b0ltUjNRTXRyOU5aNXBiNUdUWFhMWlVqNGRC?=
 =?utf-8?B?ZWZKT2ZQUHM0TnlsV1JMUU1HZE1JUi9tNFo0aXdzQWFlam5KbXk4TllSQ08y?=
 =?utf-8?B?aEh1ZHdYektHSjM0UExYYXZPNzZVRFFKaTl4VVQ1dEJiTU9HalpYMk9aQlUx?=
 =?utf-8?B?WUZsamdielVzTHNpYm93NGxVVyt4VUJDKy9mZS9BTS9jYThmY3l2MURFNHAz?=
 =?utf-8?B?M0ljSElRY0ROQ25FNGc2dVZxdnhKdUU5TWdiWllUbWV5M2pqNWFHMHFLV3RD?=
 =?utf-8?B?WnhUVkljN2V3Uiszb2hERDNGL1RpdVo0dURzcWoxME5yVmNwTEx6MXQ4ZllM?=
 =?utf-8?B?QW9JU1JOTlhUUzZKdmt3K0t4cW1UYTBaamFsdm1tNTJaQjBIV01TVXBOVzRa?=
 =?utf-8?B?UEF2Qmo1c3dFSjhnVVpJb3NRUmY1dWEycTkzT21vamxhY2dnWVVNSzQ3QWFP?=
 =?utf-8?B?RGN1bmttcE9ZYWFTWUM3L3dVQzNtOTFrMTNkM0RTN0VOR3ZCTjBIT0tXRlh3?=
 =?utf-8?B?dVc4V25lMU1CVDhHSnJmcEdTT05kQmhyQjVYT2JmMFBiZGRtM3BkYUt6eS8x?=
 =?utf-8?B?RUdVVFRZWXFUNkdPbFdSMkdCK2lOVTc0U1diUGdUN2Q1MHpJYXUrM3hrU1do?=
 =?utf-8?B?RDVKZnVhRjNiUEpkem1LbXVJQU8rUUVNSFZmZUIyOFYvQlpXWHNYVko4MnJE?=
 =?utf-8?B?RmNhY2NDQzBNMlQ1dERuR1lFMzhjZUt2bmx3SHMyWGg1cS8xMWtxRG0wbUVU?=
 =?utf-8?B?NHhKRVg1Skg3SFEveTBObEZoT2x1aVg4M3Y1T1ZTSzVGb3B1WTRRSW9kVmp2?=
 =?utf-8?B?VjJHYTB1V0hZR1NmSytvek15WFF1REtsTDZYcTFmTjRaaWtpSlI5UkJ6aVNj?=
 =?utf-8?B?Z1ltR09lOUdrN29EZ0FIeVVrKy9GRFVoU1I2K2F1cXNnTU9NSXB6TEpxdWky?=
 =?utf-8?B?bE1RWUNBSm9pQWxSRWlCdVJnR1FySmpDSGMzenNkUkpoaHdxa01FZUFxbFhB?=
 =?utf-8?B?eTRMQ2hrMlNXTC9XTVF1VUxTTkV5eVA2ajJkYkx0UDB0UXFLbWM5cHQ3OFhk?=
 =?utf-8?B?UnpnSEd6M1RBdExyNjBUQWlPTit1VWZQd0xhYTJQOWdHaDQ2K01VZkMxbjJM?=
 =?utf-8?B?Ykxld1BkT0h0TUF0Ky9KSHJ2K08wY0oxU28ycjhFR292U1g2NkV2MTJkZFlB?=
 =?utf-8?B?ZTFQOE9tUURzLzd1NDZlb29leHdrNDdpd3RaMmdUaFRFZm9mTFZYVnJWS3Er?=
 =?utf-8?B?WXc2MTlCa05yd2UwSm1CZEs0S1lEc2ptRGU3M2tqdXZxcWIvdUs2aEtORnBo?=
 =?utf-8?Q?7rWfc5AEcohCAvFV04Ijuc4IK40Q1ZVzn8iQb+0eUuvO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0ADA9FA6941AC4FA5FFFC2A6482327D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0627b2de-757f-4335-8d7e-08de16a211a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 04:17:26.9538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zi4ODULEmnEPWXPLjawl1B9xTBRLifHD6KWTzTc02F3A1Jc5zq4TVppq6CVGYGFYnDnmDjS0q5VmCeqdUl4IWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7998
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_211733_741560_72E8A4D8 
X-CRM114-Status: GOOD (  18.87  )
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

T24gMTAvMjgvMjUgMTg6NDIsIEd1aXhpbiBMaXUgd3JvdGU6DQo+DQo+DQo+IOWcqCAyMDI1LzEw
LzIzIDEzOjE0LCBDaGFpdGFueWEgS3Vsa2Fybmkg5YaZ6YGTOg0KPj4gT24gMTAvMjIvMjUgNjo1
NCBBTSwgR3VpeGluIExpdSB3cm90ZToNCj4+PiBBZGQgYSBuZXcgZGVidWcgc3dpdGNoIHRvIGNv
bnRyb2wgd2hldGhlciB0byB0cmlnZ2VyIGEga2VybmVsIGNyYXNoDQo+Pj4gd2hlbiBkdXBsaWNh
dGUgQ1FFcyBhcmUgZGV0ZWN0ZWQsIGluIG9yZGVyIHRvIHByZXNlcnZlIHRoZSBrZXJuZWwNCj4+
PiBjb250ZXh0LCBzdWNoIGFzIHNxLCBjcSwgYW5kIHNvIG9uLCBmb3Igc3Vic2VxdWVudCBkZWJ1
Z2dpbmcgYW5kDQo+Pj4gYW5hbHlzaXMuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBHdWl4aW4g
TGl1IDxrYW5pZUBsaW51eC5hbGliYWJhLmNvbT4NCj4+PiAtLS0NCj4+PiDCoMKgIGRyaXZlcnMv
bnZtZS9ob3N0L2NvcmUuYyB8IDUgKysrKysNCj4+PiDCoMKgIGRyaXZlcnMvbnZtZS9ob3N0L252
bWUuaCB8IDMgKysrDQo+Pj4gwqDCoCAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0K
Pj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMv
bnZtZS9ob3N0L2NvcmUuYw0KPj4+IGluZGV4IGZhNDE4MWQ3ZGU3My4uN2EzZjkxMjlhMzljIDEw
MDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KPj4+ICsrKyBiL2RyaXZl
cnMvbnZtZS9ob3N0L2NvcmUuYw0KPj4+IEBAIC05NSw2ICs5NSwxMSBAQCBtb2R1bGVfcGFyYW0o
YXBzdF9zZWNvbmRhcnlfbGF0ZW5jeV90b2xfdXMsIA0KPj4+IHVsb25nLCAwNjQ0KTsNCj4+PiDC
oMKgIE1PRFVMRV9QQVJNX0RFU0MoYXBzdF9zZWNvbmRhcnlfbGF0ZW5jeV90b2xfdXMsDQo+Pj4g
wqDCoMKgwqDCoMKgICJzZWNvbmRhcnkgQVBTVCBsYXRlbmN5IHRvbGVyYW5jZSBpbiB1cyIpOw0K
Pj4+IMKgwqAgK2Jvb2wgcGFuaWNfb25fZG91YmxlX2NxZTsNCj4+PiArRVhQT1JUX1NZTUJPTF9H
UEwocGFuaWNfb25fZG91YmxlX2NxZSk7DQo+Pj4gK21vZHVsZV9wYXJhbShwYW5pY19vbl9kb3Vi
bGVfY3FlLCBib29sLCAwNjQ0KTsNCj4+PiArTU9EVUxFX1BBUk1fREVTQyhwYW5pY19vbl9kb3Vi
bGVfY3FlLCAiY3Jhc2ggdGhlIGtlcm5lbCB0byBzYXZlIHRoZSANCj4+PiBzY2VuZSIpOw0KPj4+
ICsNCj4+PiDCoMKgIC8qDQo+Pj4gwqDCoMKgICogT2xkZXIga2VybmVscyBkaWRuJ3QgZW5hYmxl
IHByb3RlY3Rpb24gaW5mb3JtYXRpb24gaWYgaXQgd2FzIA0KPj4+IGF0IGFuIG9mZnNldC4NCj4+
PiDCoMKgwqAgKiBOZXdlciBrZXJuZWxzIGRvLCBzbyBpdCBicmVha3MgcmVhZHMgb24gdGhlIHVw
Z3JhZGUgaWYgc3VjaCANCj4+PiBmb3JtYXRzIHdlcmUNCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9udm1lL2hvc3QvbnZtZS5oIGIvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oDQo+Pj4gaW5kZXgg
MTAyZmFlNmEyMzFjLi4yNDAxMGQ1ZDE1Y2UgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9udm1l
L2hvc3QvbnZtZS5oDQo+Pj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oDQo+Pj4gQEAg
LTU5NSw2ICs1OTUsOCBAQCBzdGF0aWMgaW5saW5lIHUxNiBudm1lX2NpZChzdHJ1Y3QgcmVxdWVz
dCAqcnEpDQo+Pj4gwqDCoMKgwqDCoMKgIHJldHVybiBudm1lX2NpZF9pbnN0YWxsX2dlbmN0cihu
dm1lX3JlcShycSktPmdlbmN0cikgfCBycS0+dGFnOw0KPj4+IMKgwqAgfQ0KPj4+IMKgwqAgK2V4
dGVybiBib29sIHBhbmljX29uX2RvdWJsZV9jcWU7DQo+Pj4gKw0KPj4+IMKgwqAgc3RhdGljIGlu
bGluZSBzdHJ1Y3QgcmVxdWVzdCAqbnZtZV9maW5kX3JxKHN0cnVjdCBibGtfbXFfdGFncyAqdGFn
cywNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1MTYgY29tbWFuZF9pZCkNCj4+PiDCoMKgIHsN
Cj4+PiBAQCAtNjEyLDYgKzYxNCw3IEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0IHJlcXVlc3QgDQo+
Pj4gKm52bWVfZmluZF9ycShzdHJ1Y3QgYmxrX21xX3RhZ3MgKnRhZ3MsDQo+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZGV2X2Vycihudm1lX3JlcShycSktPmN0cmwtPmRldmljZSwNCj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJyZXF1ZXN0ICUjeCBnZW5jdHIgbWlzbWF0Y2ggKGdv
dCAlI3ggZXhwZWN0ZWQgJSN4KVxuIiwNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHRhZywgZ2VuY3RyLCBudm1lX2dlbmN0cl9tYXNrKG52bWVfcmVxKHJxKS0+Z2VuY3RyKSk7DQo+
Pj4gK8KgwqDCoMKgwqDCoMKgIEJVR19PTihwYW5pY19vbl9kb3VibGVfY3FlKTsNCj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gTlVMTDsNCj4+PiDCoMKgwqDCoMKgwqAgfQ0KPj4+IMKg
wqDCoMKgwqDCoCByZXR1cm4gcnE7DQo+Pg0KPj4gSSdtIHJlYWxseSBub3Qgc3VyZSB0aGlzIGlz
IGEgZ29vZCBpZGVhLCBJJ2xsIGxlYXZlIHRvIG90aGVycy4NCj4+DQo+Pg0KPj4gLWNrDQo+IFll
YWgsIEkgdGhpbmsgc28gdG9vLCBhbmQgSSdkIGFsc28gbGlrZSB0byBmaW5kIGEgbW9yZSBlbGVn
YW50IHNvbHV0aW9uLg0KPg0KPiBCZXN0IFJlZ2FyZHMsDQo+IEd1aXhpbiBMaXUNCj4NCg0KV2hh
dCBhYm91dCBsb2dnaW5nIHRoZSBuZWNlc3NhcnkgaW5mb3JtYXRpb24gYW5kIHN0aWxsIGNvbnRp
bnVpbmcgdGhlIA0Kc2V0dXAgPw0KV2hlbiB5b3UgYXJlIGRlYnVnZ2luZyB5b3UgY2FuIGFsd2F5
cyBzZXR1cCBhIGJyZWFrcG9pbnQgdGhlcmUgYW5kIGdldCANCnRoZSBzeXN0ZW0gc3RhdGUgaW4g
dGhlIGJyZWFrcG9pbnQsIHNvbWV0aGluZyBsaWtlIGZvbGxvd2luZyB0b3RhbGx5IA0KdW50ZXN0
ZWQgOi0NCg0KVXNhZ2U6DQojIEVuYWJsZSBhdCBydW50aW1lDQplY2hvICdtb2R1bGUgbnZtZSAr
cCcgPiAvc3lzL2tlcm5lbC9kZWJ1Zy9keW5hbWljX2RlYnVnL2NvbnRyb2wNCg0KIyBPciBhdCBt
b2R1bGUgbG9hZA0KbW9kcHJvYmUgbnZtZSBkeW5kYmc9JytwJw0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9udm1lL2hvc3QvcGNpLmMgYi9kcml2ZXJzL252bWUvaG9zdC9wY2kuYyBpbmRleCANCmM5
MTYxNzZiZDlmMC4uYTlmOWM2MWQzZmM5IDEwMDY0NCAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9w
Y2kuYyArKysgDQpiL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jIEBAIC0xMjk0LDYgKzEyOTQsNTAg
QEAgc3RhdGljIGlubGluZSBzdHJ1Y3QgDQpibGtfbXFfdGFncyAqbnZtZV9xdWV1ZV90YWdzZXQo
c3RydWN0IG52bWVfcXVldWUgKm52bWVxKSByZXR1cm4gDQpudm1lcS0+ZGV2LT50YWdzZXQudGFn
c1tudm1lcS0+cWlkIC0gMV07IH0gKy8qKiArICogDQpudm1lX2hhbmRsZV9kdXBsaWNhdGVfY3Fl
IC0gSGFuZGxlIGR1cGxpY2F0ZSBDUUUgZGV0ZWN0aW9uICsgKiBAbnZtZXE6IA0KVGhlIHF1ZXVl
IHdoZXJlIGR1cGxpY2F0ZSB3YXMgZGV0ZWN0ZWQgKyAqIEBjcWU6IFRoZSBjb21wbGV0aW9uIHF1
ZXVlIA0KZW50cnkgKyAqIEBjb21tYW5kX2lkOiBUaGUgY29tbWFuZCBJRCBmcm9tIHRoZSBDUUUg
KyAqICsgKiBMb2dzIGRldGFpbGVkIA0KaW5mb3JtYXRpb24gYWJvdXQgdGhlIGR1cGxpY2F0ZSBD
UUUgaW5jbHVkaW5nIENRRSBkZXRhaWxzICsgKiBhbmQgZnVsbCANCnF1ZXVlIHN0YXRlIHRvIGFp
ZCBpbiBkZWJ1Z2dpbmcgaGFyZHdhcmUgb3IgZmlybXdhcmUgaXNzdWVzLiArICovIA0KK3N0YXRp
YyB2b2lkIG52bWVfaGFuZGxlX2R1cGxpY2F0ZV9jcWUoc3RydWN0IG52bWVfcXVldWUgKm52bWVx
LCArIA0Kc3RydWN0IG52bWVfY29tcGxldGlvbiAqY3FlLCArIHUxNiBjb21tYW5kX2lkKSAreyAr
IHN0cnVjdCBudm1lX2RldiAqZGV2IA0KPSBudm1lcS0+ZGV2OyArICsgZGV2X2RiZyhkZXYtPmN0
cmwuZGV2aWNlLCArICJEdXBsaWNhdGUvSW52YWxpZCBDUUUgDQpkZXRlY3RlZDpcbiIgKyAiIFF1
ZXVlOiAlZCAoU1EgSUQ6ICV1KVxuIiArICIgQ29tbWFuZCBJRDogJXVcbiIgKyAiIA0KU3RhdHVz
OiAlI3hcbiIgKyAiIFJlc3VsdDogJSNsbHhcbiIgKyAiUXVldWUgc3RhdGU6XG4iICsgIiBRdWV1
ZSBkZXB0aDogDQoldVxuIiArICIgU1EgdGFpbDogJXUsIGxhc3Rfc3FfdGFpbDogJXVcbiIgKyAi
IENRIGhlYWQ6ICV1LCBwaGFzZTogJXVcbiIgDQorICIgQ1EgdmVjdG9yOiAldVxuIiArICIgU1Eg
RE1BIGFkZHI6ICVwYWRcbiIgKyAiIENRIERNQSBhZGRyOiAlcGFkXG4iICsgDQoiIEZsYWdzOiAl
I2x4IChlbmFibGVkPSVkLCBzcV9jbWI9JWQsIHBvbGxlZD0lZClcbiIsICsgbnZtZXEtPnFpZCwg
DQpsZTE2X3RvX2NwdShjcWUtPnNxX2lkKSwgKyBjb21tYW5kX2lkLCBsZTE2X3RvX2NwdShjcWUt
PnN0YXR1cyksICsgDQpsZTY0X3RvX2NwdShjcWUtPnJlc3VsdC51NjQpLCArIG52bWVxLT5xX2Rl
cHRoLCArIG52bWVxLT5zcV90YWlsLCANCm52bWVxLT5sYXN0X3NxX3RhaWwsICsgbnZtZXEtPmNx
X2hlYWQsIG52bWVxLT5jcV9waGFzZSwgKyANCm52bWVxLT5jcV92ZWN0b3IsICsgJm52bWVxLT5z
cV9kbWFfYWRkciwgKyAmbnZtZXEtPmNxX2RtYV9hZGRyLCArIA0KbnZtZXEtPmZsYWdzLCArIHRl
c3RfYml0KE5WTUVRX0VOQUJMRUQsICZudm1lcS0+ZmxhZ3MpLCArIA0KdGVzdF9iaXQoTlZNRVFf
U1FfQ01CLCAmbnZtZXEtPmZsYWdzKSwgKyB0ZXN0X2JpdChOVk1FUV9QT0xMRUQsIA0KJm52bWVx
LT5mbGFncykpOyArfSArIHN0YXRpYyBpbmxpbmUgdm9pZCBudm1lX2hhbmRsZV9jcWUoc3RydWN0
IA0KbnZtZV9xdWV1ZSAqbnZtZXEsIHN0cnVjdCBpb19jb21wX2JhdGNoICppb2IsIHUxNiBpZHgp
IHsgQEAgLTEzMTUsOSANCisxMzU5LDcgQEAgc3RhdGljIGlubGluZSB2b2lkIG52bWVfaGFuZGxl
X2NxZShzdHJ1Y3QgbnZtZV9xdWV1ZSAqbnZtZXEsIA0KcmVxID0gbnZtZV9maW5kX3JxKG52bWVf
cXVldWVfdGFnc2V0KG52bWVxKSwgY29tbWFuZF9pZCk7IGlmIA0KKHVubGlrZWx5KCFyZXEpKSB7
IC0gZGV2X3dhcm4obnZtZXEtPmRldi0+Y3RybC5kZXZpY2UsIC0gImludmFsaWQgaWQgJWQgDQpj
b21wbGV0ZWQgb24gcXVldWUgJWRcbiIsIC0gY29tbWFuZF9pZCwgbGUxNl90b19jcHUoY3FlLT5z
cV9pZCkpOyArIA0KbnZtZV9oYW5kbGVfZHVwbGljYXRlX2NxZShudm1lcSwgY3FlLCBjb21tYW5k
X2lkKTsgcmV0dXJuOyB9IC1jaw0KDQo=

