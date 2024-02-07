Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375F3C4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 05:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=knxa+iLJ0Fy3ajVg+xLrHVxeOIW3h83R29oCoAHtWaY=; b=l1CtJhB0KM3hfxRSY2HmwzlJNR
	YcjP9TwtS3HnjCkK3O+0n9Aa3bD+d6GURMP5OesUSLsSVAOSlnu8URFCGKhmOTjP1p+MNgmVLwfx+
	Et0KUCA0nP8b7PTdR7TlnZSTfJCzq+Z0f5810cDXpGx8UYJq/cLIsJKKi/FkamDyO0UF7ipyQg2JK
	d/dUJMf+M3m4ra6NWfBVBjmzr4GE5LNG5fjoYFxMdhRAODuuAWFbnqMC5MmFhRiHMfqY9RcbOwjhm
	gp//0+gxm4BQKZ7x9L/82DTIsQrHwS005LIyc3g8Q+63Hwyf8iBozha9eHPm88H+djYTb7h+Mwu7O
	IKujiXIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXaLz-00000009jae-1EXL;
	Wed, 07 Feb 2024 05:20:11 +0000
Received: from mail-mw2nam04on20600.outbound.protection.outlook.com ([2a01:111:f403:240a::600] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXaLw-00000009ja7-401j
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 05:20:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAvB86koa2KTY59Boopv9v3A+5RJcJtNo/79/wdPUK3OQyo0VhTI03OjrugnFCKKVtUvmX7NUScjWtrK8aIF+P5eaDmZFvV8Kh8sIk7n5wZEXwnkqdfDRA+bjKRCC8qwQT266zH7IjfBpup3RVo8bh2/7rU3Hgi2HP/49bmzG9U9/GadhEBIYzOg4lqSyfyOuGbu165rmDW8lQhzLRrFr4ier64IM3p3+6Px1QymQeEvnFA8T7FoJ6X1BJXkiBxqcG4ELDuDUZur9Q9DTl7ru1E50ylbTtWnSVo6bO8VBqJWgokCrIfXzbl5uMriHzrFOB9Q/mZKc0om29rAzQPvpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knxa+iLJ0Fy3ajVg+xLrHVxeOIW3h83R29oCoAHtWaY=;
 b=Q5bgh2xLWWyTagVHddfNNN8+x5cOMbcplDvAnb4MA9SpdCRlrytr6cpuc1lE9Ql962tMqckareaY5G+Qnn8tJlSLg3wBjlE5oSaUIbaIEDcaVemDmlY5xVZL+eYftqahpJFutR5xw8ih5Ind20DzygAckBCKsoYdxm04quMCvJ8adE/Tn1tO1N0vMwdKQ7uBlTwjIRbi1Hzo+Lnf4qR2+SaYIRiVoslOSN19S7MZb69AFQf14MTZPSh1eKb0pQNRdO0IEZyiMqyJ4CobJF37OxNpWDDn/1dmKGNBOr/k0lTSFDtExeKmR2TJGoy23nAnv6O3W9J0V6bHuwFwCTPzpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knxa+iLJ0Fy3ajVg+xLrHVxeOIW3h83R29oCoAHtWaY=;
 b=qTaWFk6SPlnaRH2cUHciTbhhqB0E8nzVcXgNRrQ9DzvNVU1LtphQit0AkV+Yq/gca25rZHVy3f1n/oA/5oC6K5IYSCSdoEmTjakkEnXzc9x6cC1+MTRCJohWxDtpm2RQerCZ+mxrL1+9SMkxtONFEiXEaCLdaGFcqqweRa5sRyJbNqO5VhTEpWMDnjGFpi9r8UH3Gfg97XSB3qxKhxVDShvCL5M9l7PYbX6QK9iLnVDdsdgYh8s8ZFXqsCzIuMtoeeLTKYHjyQSIFXAEoYIg9dxJXrmQBkF3NatR2zXrVFBqnk7wZnQlgMtqJ3z14GgTmfi6uwNy5j27gu2PBWvEeA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB7250.namprd12.prod.outlook.com (2603:10b6:806:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Wed, 7 Feb
 2024 05:19:53 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7270.012; Wed, 7 Feb 2024
 05:19:53 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Keith Busch
	<kbusch@kernel.org>
CC: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] nvme: test log page offsets
Thread-Topic: [PATCH blktests] nvme: test log page offsets
Thread-Index: AQHaWGSLvF98sFoeGUCmkSxQW36iwbD801IAgAAKzYCAAW5IAIAADV4A
Date: Wed, 7 Feb 2024 05:19:53 +0000
Message-ID: <cd04b339-e8a2-447b-b623-1c880e6c7612@nvidia.com>
References: <20240205185225.2878642-1-kbusch@meta.com>
 <mabar2czffh5f7ftappnbtir34vzz65ecxatz7p4xbe6u6ts2s@hwe7yb3pcajx>
 <ZcHUf_MF_yDAkrMG@kbusch-mbp.mynextlight.net>
 <osl4dygp3c76pin62mumm42bs7t4hpooynfvsyqnda4acxxqeo@irad4vxvungc>
In-Reply-To: <osl4dygp3c76pin62mumm42bs7t4hpooynfvsyqnda4acxxqeo@irad4vxvungc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB7250:EE_
x-ms-office365-filtering-correlation-id: efae28e5-8212-4eee-9dc6-08dc279c6a8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FkKu/rve/ClwSREGPV2dTYIY6g22p996lx8OUXtX2IX7SQXtw7MKKPuWixQgnJNLdlm7ZPPTNFfR5va0gk/7SztKkjfOJrPI4sqs3PJI+geR6GjWuu+4LbAI9DvbhEi3TKIcdTLO9RrHf5nz8hzzMBgVpXlW8TQ+O6tmwhREAnspxYO5FYfG88JNOqticRwNrj7XVzd9s5GlvotmVLabtO6YlnU5gV+glGX9dIpJylzxvittmcSIwIeeGd9GP0BEfe/2/7Bt95H5ADPALJv8fw+IphaUz/Y6DE5Z0cyKNdWyUhIDhSQWOewTJQqeNRSQTvv4OG/+PhL2iDdDBsiivj46dJxJS/V9eBQqzf3QYJiuVONcwJOu/peQfwuxmoSDqf14BbX5egQh4f8cbfAqgAtgFa7Uba8GWReamLze+5KhKPAAXpJ/mb7KmXhqWzuTY6Mdb8MhP0o2/Z+b3RIrpdtx0DepbHW2KhD6L+gTz0vSZULIdXA/1w8Omak/o3qeX0VkBdEzPQIjs0ZRlOGL/wIqel2lYcIzh4V19JzWtFIFAL5F0wgHgNWC8GzY9Wh6A5qLP8i8ZhkhJHjJSLGsLc4NPaLvgZVlYUwsly+iCJaRkKXS1sNvXBmgv77nIqfhEapCzEaQ7ZMEvvvPF+FagqGHm4J6RhTdmKdlDsA6k/iITLvZsHrxSQ4J3hAcXaO6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31686004)(91956017)(110136005)(41300700001)(86362001)(31696002)(478600001)(2616005)(6512007)(54906003)(38070700009)(36756003)(38100700002)(122000001)(6486002)(76116006)(4744005)(8676002)(2906002)(71200400001)(4326008)(66946007)(66476007)(66556008)(5660300002)(6506007)(66446008)(64756008)(316002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGlXaEUzdmVNdXJRQ3FSYU9kT3hLVGpMTEdZenBCN25RcjdjbmlRdHh6R3dm?=
 =?utf-8?B?ZGFscVRQWmxsdFRISnViZlZwMFFPTjFUL0o5QkJIOE43cnp0RGhya3pUcWlC?=
 =?utf-8?B?WlJMR2F1VGo5T0s5aDFFUG1CZVhxQUs2MmJ3QjE0TDlTcGQySW9OU3p4LzRX?=
 =?utf-8?B?bkZXVlJJS0dxU2VxK01SOHpqcm9QandyQlJNMVhNRVhHNktIVWM1dmorRStt?=
 =?utf-8?B?UU9JS2RrTzNobWpDVy9PQ09XOElic09WSzcxS2Z5TU1YMjBPQ0pab0NaTGlT?=
 =?utf-8?B?a1JHcE1oN1BhaFZtdkQzd1FYM3NZY2R1MG9mRytiUW5lNU13S3MyQWRQS1Zo?=
 =?utf-8?B?SnhhQlpzU3gzckh0S3hqQ1crb2ZWdDJ1RlU3ZVEwUXhwc2hkUHlWQzBKZ28w?=
 =?utf-8?B?TXlreExOZkFWTzV4bnErdmtwblE1eUwwZElJWW85bjl0UHRvVUNlZlhZSGZJ?=
 =?utf-8?B?OFpvM01QYXltR3JPU2lWeFVlemJweCtkRXQ2cTFMc1VNTmJycGlFQWIvZ3Jp?=
 =?utf-8?B?RHVuMWl6QVFWSS9LQnpuei9ITlFYNmJCdWdZRjZxSlhMMjRyaERsNVo3eE4w?=
 =?utf-8?B?NzBBTUovbkF2dkMyVnJ2WVBPb1pRK1N0bTBnY2ZBMTRBUHBlR3lOQTlPRWNO?=
 =?utf-8?B?REZvZmZ6ZUZkbjRQaVVhSXkvM2UxTmdPVnQzQmNXaWxyN3pISDI4ZytmWmpz?=
 =?utf-8?B?UWxGRUdTQ3NUZjFSWTlQMk03a3VudmcrZlJsc0YrY0VveW44aEg4SUQ1cXRI?=
 =?utf-8?B?cWl1cGZWYXFYcVVlM2hEVlVQNVRBdzF2VHY1NTJHNWhCVG5uSjJnTkduMzlu?=
 =?utf-8?B?N1pheS9oRkIzMENBdDMvc1JFYm5jY2xiZW5wT3dTZ0x3VWVsc1ZobU1NRDRB?=
 =?utf-8?B?dC9WWDNvSVdtdnNuTWhQQW42azgvSGFzMnJwNHd0TGxsRk5JZkQreGNERVZ0?=
 =?utf-8?B?YVI4ZW4rdEhwcFYzMGlQM1pDTG5YQSt1bysyaXdvaGdRU0ZId25uaDNERTdP?=
 =?utf-8?B?MVNwL2N6c1A5ZUdqYnYxZjBBdHByTjRXZDM0WlJMVlN6Sm1YZ0h6ZVhBd1k1?=
 =?utf-8?B?dlV3RU1YSGQzamMxMTNMamltVk9YYzNqdkM0dUxuaW90cE56WHpiQzU0WHo3?=
 =?utf-8?B?Qm1VcjBNM3dydS81dXJqTlduQTcwbUVRQnhIcGpxd2N3TWRjdW4zM3lyQ1VL?=
 =?utf-8?B?RVBSc3lOM04yMEJrRm1raGtGdnA2UlQ5Yk5tNU1Ra2xQY1c5RitITEVEWFY5?=
 =?utf-8?B?UUdqcThqZFdaZm1BdFRjMFFCR1htY1RXblRBYnNjK1k1ZTN5azZKcmd5NHZG?=
 =?utf-8?B?R3YybG1IT21GZGJaQ3NndGN4YXJJdXFPZnRiZkJRdEUyY1pLYU9tcHV6ZThV?=
 =?utf-8?B?RGdRaWN0Y01zd0RNNFhyak1iL1ltQjhWbXdmL2RGU210RThDL044WmwxSDRz?=
 =?utf-8?B?WUhEK0lTZ1VmY2tPVXgyV1hmRFBrVUdpWnRzb1JYY2RjUFpHa0lLaW8wTDEr?=
 =?utf-8?B?dW5mVk5Pb2FJYmRoL1A0ci84N1RmV1lYaGhZQTVmbTZHTXE5VFpJSlNMSlds?=
 =?utf-8?B?V1k4blEzUkJBWWNYUCtCcHFTRERWODlvSVFBbE5uWThudzlNUDZZLzVzMVQy?=
 =?utf-8?B?ajQ3SEtzS2R4NUVQS2VtNituL000K3U4VEQ4WVpsdUdscTdXb3ZTRTBnYjE4?=
 =?utf-8?B?OFBPS0UwMFlUanBvaWxnVTNYN2tWWm5hRm9Vb1hPOHFGUmNBUUZ2YW1uR1Ri?=
 =?utf-8?B?d2ZyWDdNV0Zrd1ljUXZSV0lsTHUvRzdGeFRJT0I0TTc5WjM1ZElwK2Q0OUtC?=
 =?utf-8?B?L01jQTBKZGxSQ20vUVhPYUdpajR0dlcraUs3V2JKWGhWdW1sd3I0TEh3VGtJ?=
 =?utf-8?B?bjFZeHBuT2VWbU50MDZ3UFQ1aXh0aVcyWGQ1WnBRQ3JSdXNPWUJORnllQ05P?=
 =?utf-8?B?VzIwNklZWkhUaWZqOWV2SGxLQzIxUWFHeEZ4dVp3RWVLaDYwMHBBaDA5c1k2?=
 =?utf-8?B?cGlML3o0bkhLNlhIRysvUzY1amkxR2VHRWVqZklIN1BkaXgvOUgzRWhIb0JK?=
 =?utf-8?B?WFBXY0tPbXhLRi9ra1RqOWZ4ZjNFT2hxUEtRcVlWNGU5NU1JcTNBODdSOEJ6?=
 =?utf-8?B?bGE0d3ZUMkhTb05XMHpEbHI2QTZIT1ZEbVV1bDJpS3UvdGxMemxpdEZnK2t6?=
 =?utf-8?Q?V87U/kYzgVVZIfHr6xwHa8PsdVqjJbOribb6fzYvPAe1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF563E13EBB98149A6AAD624A8001C7E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efae28e5-8212-4eee-9dc6-08dc279c6a8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 05:19:53.5407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7GyNZuEZQ1qwjo2Lk44uavAS9JYsC0wEQc1GbSLi4q5xHQIPCH0gEi0K2Swi7oDrlaRFvDEsY3TQgLQk/f6sPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240206_212009_032983_9701287F 
X-CRM114-Status: GOOD (  10.32  )
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

PiBBbm90aGVyIGlkZWEgaXMgdG8gc2VwYXJhdGUgdGhlIHRlc3QgY2FzZSBmcm9tIHRoZSBudm1l
IGdyb3VwIHRvIGEgbmV3IGdyb3VwDQo+IGNhbGxlZCAibnZtZWRldiIgb3IgImRldmNvbXBhdCIs
IHdoaWNoIGlzIGRlZGljYXRlZCB0byBjaGVjayB0aGF0IHRoZSBzdG9yYWdlDQo+IGRldmljZXMg
d29yayBnb29kIHdpdGggTGludXggc3RvcmFnZSBzdGFjay4gSXQgd2lsbCBtYWtlIGl0IGVhc2ll
ciBmb3IgdGhlDQo+IGJsa3Rlc3RzIHVzZXJzIHRvIHVuZGVyc3RhbmQgdGhlIGFjdGlvbiB0byB0
YWtlLCBhbmQgd2hpY2ggdGVzdCBncm91cCB0byBydW4uDQo+IFdoYXQgZG8geW91IHRoaW5rPw0K
Pg0KPg0KDQphcGFydCBmcm9tIHRlc3QgYmVpbmcgdXNlZnVsLCBhYm92ZSBzdWdnZXN0aW9ucyB3
aWxsIHN0cmVhbWxpbmUgaGFuZGxpbmcgb2YNCmFueSB0ZXN0Y2FzZSB0aGF0IGZhbGxzIGludG8g
aW50byBkZXZpY2Ugc3BlY2lmaWMgY2F0ZWdvcnksIHlldCANCm1haW50YWluaW5nIHRoZQ0KZmxv
dyBvZiB0aGUgZXhpdGluZyBpbmZyYXN0cnVjdHVyZSAuLg0KDQotY2sNCg0KDQo=

