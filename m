Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78782C47422
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 22:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MEcDWC4QCFd+c4PblXIx6yMSil1EDSoPMfmyEzxSuyA=; b=HordYW/9ZOOWkI9UlBB9o1P1MP
	3i51xXmR3Q4Xiq9jR3C7RCMr8hWBuwhMIYWCdTe2jkQVjWdCSjbTFugP3vdSBWK+EfncAo9bY+RuC
	svxwVaP0WdVBdQnyBk6iuzt4pXJ6C2M9pq0ceUgr8enJWgukHOWsSdkugdIiAMhgNtjFXdFcRp5pD
	6d2TJ7+7OHIPkNJ1TSsNbqEdmjIN4SG4evKQICLdb3vfs6Bx5IGu2RbSwWDcShOqUUAeSfz6NWJHH
	psB6V9R9WvDLveuPG3y/C5ADhYDI1jjltjF0eE92+GogI8GnYvu5q3HmibZ5OdMxRoagexkekvv6C
	2UrzI0Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSlbK-005HtB-2R;
	Wed, 24 Jan 2024 22:20:06 +0000
Received: from mail-mw2nam04on20601.outbound.protection.outlook.com ([2a01:111:f403:240a::601] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSlbG-005Hrk-2c
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 22:20:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5fNyk5rtKsKzsVNsVP3cCATAB4cWrXzKbGwk6BOSBzLioeGEx7WGkVCvxOL/ba/8ucV2SqyY4/SXUo25XVcubertQ24offjJaOqCXVynHSzmBtkd8WW6scCtS61WdPh3t5/Jd5yoEjp4Xv21bZX1apWormMbxtfy3TGXfQua07g8FOqfvrPgtYqWuWLMKsEJJnaRrQM+FRdIiXLs+5D6nlvbUBthPrqu0y0kaWA1DAdUuNxE/nS+HXmbHrR5gUwDWdg+9q1oaVXSplxzXSMJcCj13RCG2r4+ahNQRWZG8ErXvyx0pL0EzXoyilcYMEbXH/Gm2RqpfIu8UMvtuGMjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEcDWC4QCFd+c4PblXIx6yMSil1EDSoPMfmyEzxSuyA=;
 b=JOsaZdVNzbPSqR+f9P5QuZnZF9f+3eomTaRl5cq/GBo4aUIwdiBaqkUwV2y8/SxeCJzlHTZxaheJpwduvWXyy+xmtf5Ij78ze1R2JQEpx4O/vL+NZQrfU9u+Z1NJklU0OO/R0sbV4bLl0Od1bm5JROBtp6FRNf/MlD/iNj/uFbu2JnjQEeoq1mrzZw50Yg6U4Q6kH6T8ucL2X8UD3r+20wELTIy+7H53JjLdPfAS6eyVRSZqr8Av3M1l1I0aD7gvfZGXqllIjHHjWDSCxh1XNVVapk1x3TYC6wgPKu+r3zTxtkGbmgtugbz6vaTlxm+P46PW7Mqh6W6L4ycviIqQLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEcDWC4QCFd+c4PblXIx6yMSil1EDSoPMfmyEzxSuyA=;
 b=fC/+8WTL3ezql2xFHNSQ9ukYLvZy7vwYjfoUt90SfhRc5xIc2895h7EHM3foyX9dm0h7bLFFzseUJ/XvbzjanewAlgU4NprXJlQ7W1toW3PsZ6+enJNEfSRmznpjlPbstDfAONozfc3RWtsg8eWRZmm7hsfY2iCWKxMJHJ8+gyqveg8AulwZAlRpEiShaA0KOX/VOd7ahSvMJx39t7gtxAciv6R6jKaQGyNhBT0ciLNyJZLMIXDMu1u5UHvI205CPNVF20TVUpWbg2DiudRjvIIfzcQV4v+bqWq5l0tBFwMEhvSuySRCoKuYVhpZNF3+q8IxxZ65eTx66lfeKeEIog==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH0PR12MB5188.namprd12.prod.outlook.com (2603:10b6:610:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 22:19:50 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 22:19:50 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>
CC: Keith Busch <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: use ctrl state accessor
Thread-Topic: [PATCH] nvme: use ctrl state accessor
Thread-Index: AQHaTur8AKAw12X1tk+OCsSoF/oB2bDpiQ4A
Date: Wed, 24 Jan 2024 22:19:50 +0000
Message-ID: <38cd1a30-75bc-4d19-b26a-cfb29a1f4240@nvidia.com>
References: <20240124172855.1901146-1-kbusch@meta.com>
In-Reply-To: <20240124172855.1901146-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH0PR12MB5188:EE_
x-ms-office365-filtering-correlation-id: a01e6479-4649-4630-3bc9-08dc1d2a9537
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1fW7N8yr+ZhKl/trcHtfyrZnktJlj2migHj1J1FV2WEBW3uKZyCcA/+AeJiPntNXRIf3q4mwJfJ0Z6vkoyak4iNts8CtxHpqApHQFBPrNasOQLqqFq0SgtbY2JspCUm3IXMkWExOqqY7UgTRdN06t+r/6vvNKyGxP6U57x5nwkjFFrbKIAKeYdeViJMyGlpILmqPzVem1jO+pwPUgdPe+qSBamavjacWPPTHly4rllMGi0gly0G0+qrOCJ7k/3fb8SGiYE+lRkBOCgTQEZ/40OPin0ImALBiUV+Y6sZmw4yhsLS3EScYQGKpXzP1ocJm0C1pW+TqnWYJwkDDu+MrYdpeqBCD+kDeMsF6XM28mvTJ1+zkKP3BuOStpDipDZRpdkL7XqwwiwBaOfnGTfXygtG0r9RRhzbSDrjHeFy9Kv5DO1A2/Uxfhkj2aBqGWw+sIbc4TKx9cizsQ/ic3+7+mjcW0VZwWpBBVk903hAf+6pPZo1Ubb/Jt8I6kSZg3H/8Cin+NVJSphZdgYTJvRlAmVC9wNeQppAARJQh4bR+8n/wGub4tvLvW9yj5c3IQ0OvJ3O1jv2WMQwZjFFQ9AYAPL4pr38xyx+XLMWQwcuV2cq64s64fZxsE+i5DBq/V4VZnLKKQ0G1fIXhP5igfupGbUh/5UbIZae5+3xGY5cCJTntTwtfPUQs8bSaWQPwvANF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(6512007)(2616005)(38070700009)(122000001)(6506007)(36756003)(41300700001)(71200400001)(53546011)(54906003)(66446008)(91956017)(5660300002)(316002)(64756008)(66476007)(66556008)(6916009)(8676002)(8936002)(478600001)(2906002)(6486002)(76116006)(38100700002)(86362001)(4326008)(66946007)(31696002)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWFmL0c5VXNJVmRBTUE0dVhPdjVEbUlTRjFqUXk3NG94d3IxRDJ0NDhkWkk0?=
 =?utf-8?B?MUxIMmR3QmI0U29xMGk5SUU3ZEJHN0J6RGg3RGJFUkxHd014eFVONmtuSm82?=
 =?utf-8?B?dXFTSkZ1UElyMDcvK3RTRE16L3pnNUJ5VEkzZ3p6ZDZMMi80SEJKRXhicGhl?=
 =?utf-8?B?M0F5em9ETlNrcnBVei90RXkrTGI4VUljejg2bDlRdFlTcEg4UFRYVjBoRmYz?=
 =?utf-8?B?dUE1ajZnQmFLbVdNcHFtREIrQVhXSlZlMTNzQTVvd3dMNDdhU1pHTVZJajZJ?=
 =?utf-8?B?TzhrUkh0bjVjV1U0djhvTGp2c3FXMnJkV21rVVlEcTJ3bjJuZlZKdDNnVXRN?=
 =?utf-8?B?SkRVSHRZamV5QXZrdkFjcjduVFlvQXE4SUZQWlpjU2VZOWswYmRkMVhwckE1?=
 =?utf-8?B?UjdIbGo2WDNYcms5UnRXS0xFTVpUYlI4eGI3MytaZ2l0UFJCc1c4a0RIdmtW?=
 =?utf-8?B?S3VNZmpETDhJU2kvYW5oT0hYM1I3WVRXVncvTDdsbWt5L05Sdm5UK0pkdXdN?=
 =?utf-8?B?cnE3MCswNm9nRkMxUmFUTThkamg3YnVrYTh4VlYyeVBnNDJXRFBIU012TGdY?=
 =?utf-8?B?M3A2TW1JbGx1cDV6aTBKV1BmQlBra1VIRHF3aEdaQWduMnZnL3dod3pwWVVn?=
 =?utf-8?B?dEdJdlJsWEErU2QrK3ViaEVYdHZPR2ZuQmpCcmxMbkhlcVRmcjk4dWoyYlFP?=
 =?utf-8?B?eGpMVFU3RXNVRDRzWU9aa3hieGU1RFFFQnI2dDJoNXpXaFhuUkNBVExlZEFG?=
 =?utf-8?B?SnZFUThsdEZjL3MySWFkRzBOVkIvaFBlQ1l0MUR6NVVKRkxDTGxzbUZsTC8r?=
 =?utf-8?B?NGg4UzZ5cGFoUmZodUd0RjArYXE0SGtRRi80NTJrMlk3ZFFhUWZVV1NsMERi?=
 =?utf-8?B?TS9HN2N2bmE2c1MxTzlnazNDNUdNN3Q5ZkYrUlBpMHg3b3VRendJNzBsUGdU?=
 =?utf-8?B?cHBuM1U4NitBTUREV0hNWC8xRHh0TWJ4RVhLbW4rYjNBYVlxU01YNHJTTS9o?=
 =?utf-8?B?cUJHRUFibTZib3pCT1Azd05YcUpmM2RPRmhrczN6ZVh2OWRIdUw2MTkwU1BZ?=
 =?utf-8?B?K2ZWa3U1QVFJVmx1aXV6WEN5UHRxcHFkeXRjMlN4NmhzUVlsbUZVRjJjZ0F2?=
 =?utf-8?B?UGlFRHZMYmM2T3psY2c2OGNma2o1WlpoMFdpblFGd1BQNUJNaysvRTY3L3FY?=
 =?utf-8?B?QllZMndTNk54WE50d1pLWmhmM2Z0REYxM1o5TENScXF5SkdGa0xkb3JSdTdN?=
 =?utf-8?B?NlErSWxPUCs4OThFRVZLaVVxYURoWGRlLzllc2xtWDc0aXlsNXhtWFJ6V1g1?=
 =?utf-8?B?WFhWZWswVW52bjE4cFhYOU01MzIyM00vYjBHb1pZSHkvVmsrSlhiU1ZEV0lE?=
 =?utf-8?B?OGVMSmtHWk5nWStSYndoalkrcTJHRDdnQWFqUUlzVEVXL1MxRERnZmVmbEtN?=
 =?utf-8?B?SXR3T1VzV2xzMkVCZVduNU9XRFpyektKUjNodzMzdHNmclY0dWpvdlgrTW1i?=
 =?utf-8?B?VVNPY2ZvanBSYXhpbjc5aENBMFNmZGE1ajBkNzlhQmM5aG1PRlFmRWJFaGNl?=
 =?utf-8?B?UlZkN08xb2UwbjlGQWRCRmtpWHBQMEhQZDZxYkp5d3k4WnBsOVRFN1M2YWVK?=
 =?utf-8?B?TzNMcXRIU09MTW8wWFlKN0Z1YkVZbzluWXNielQ5ejhoeTJUbU9Xbzh0NVhp?=
 =?utf-8?B?NnlPdndIU2h1MU43dW1qaWVxa1hFYS9LTWhSSFFYMlRMU3RqRjhubXdzMjRK?=
 =?utf-8?B?OHdEZk5nQ3ZGaUNDdXZpWDVxK0pad2JXclptSWNCeDhBU092OGpzYml2RFdY?=
 =?utf-8?B?Skg4czNhTklHUWNPbUl0VjcrSUFiT01haC93M3c3cEs1d0RtUzFSRjVrZEdB?=
 =?utf-8?B?T0hVNUZVS04rSjBla2NpMU1uc1YxNG1JcmR1c2dRN1g3T1ZqYmlZTVdlNjBt?=
 =?utf-8?B?Q2RWTFBuN1dpL2h5V3krK0FpN1B3VmVhbll0US94dGlCUG9CZUYvZVhleG1x?=
 =?utf-8?B?TGxmZ1FtMFVHbC9SK0xZaFVPRlY4ZGpwUDllVVVIM2dvSFdFUHkzbDFhMkVQ?=
 =?utf-8?B?aXlhS2t0TXhnMUpIN0ZBeFlVQUQvUlEvcytiMTF3d3N2aWM5NDR0a0RHQ1lQ?=
 =?utf-8?Q?NEJhWptQodZAgYDR79COGBRo/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8E0645173CCC745BDBFFD59ADC00A66@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a01e6479-4649-4630-3bc9-08dc1d2a9537
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 22:19:50.8935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yb1YQyLjF/BnmTm/2nEdgrxgaEZhSZDNo2bNhdOTzzu6d5i0TDU0KHaU63RszHZB/0j5tYhPWWotm2o3bif50g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5188
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_142002_855252_9C5A213F 
X-CRM114-Status: GOOD (  22.61  )
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

T24gMS8yNC8yNCAwOToyOCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
IDxrYnVzY2hAa2VybmVsLm9yZz4NCj4NCj4gVGhlIGN0cmwtPnN0YXRlIHZhbHVlIGlzIHVwZGF0
ZWQgaW4gYW5vdGhlciB0aHJlYWQgdXNpbmcgV1JJVEVfT05DRSwgc28NCj4gZW5zdXJlIGFsbCB0
aGUgcmVhZGVycyB1c2UgdGhlIGFwcHJvcHJpYXRlIGFjY2Vzc29yLg0KPg0KPiBTaWduZWQtb2Zm
LWJ5OiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiAgIGRyaXZlcnMv
bnZtZS9ob3N0L2F1dGguYyAgICAgIHwgIDIgKy0NCj4gICBkcml2ZXJzL252bWUvaG9zdC9mYWJy
aWNzLmggICB8ICA4ICsrKysrLS0tDQo+ICAgZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMg
fCAxNSArKysrKysrKy0tLS0tLS0NCj4gICBkcml2ZXJzL252bWUvaG9zdC9zeXNmcy5jICAgICB8
ICA2ICsrKy0tLQ0KPiAgIDQgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMTQgZGVs
ZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9hdXRoLmMgYi9k
cml2ZXJzL252bWUvaG9zdC9hdXRoLmMNCj4gaW5kZXggNzJjMDUyNWM3NWY1MC4uMmExMmVlODc4
NzgzZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvYXV0aC5jDQo+ICsrKyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L2F1dGguYw0KPiBAQCAtODk3LDcgKzg5Nyw3IEBAIHN0YXRpYyB2b2lk
IG52bWVfY3RybF9hdXRoX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiAgIAkgKiBJ
ZiB0aGUgY3RybCBpcyBubyBjb25uZWN0ZWQsIGJhaWwgYXMgcmVjb25uZWN0IHdpbGwgaGFuZGxl
DQo+ICAgCSAqIGF1dGhlbnRpY2F0aW9uLg0KPiAgIAkgKi8NCj4gLQlpZiAoY3RybC0+c3RhdGUg
IT0gTlZNRV9DVFJMX0xJVkUpDQo+ICsJaWYgKG52bWVfY3RybF9zdGF0ZShjdHJsKSAhPSBOVk1F
X0NUUkxfTElWRSkNCj4gICAJCXJldHVybjsNCj4gICANCj4gICAJLyogQXV0aGVudGljYXRlIGFk
bWluIHF1ZXVlIGZpcnN0ICovDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9mYWJy
aWNzLmggYi9kcml2ZXJzL252bWUvaG9zdC9mYWJyaWNzLmgNCj4gaW5kZXggZmJhZWU1YTdiZTE5
Ni4uMDZjYzU0ODUxYjFiZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvZmFicmlj
cy5oDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuaA0KPiBAQCAtMTg1LDkgKzE4
NSwxMSBAQCBzdGF0aWMgaW5saW5lIGJvb2wNCj4gICBudm1mX2N0bHJfbWF0Y2hlc19iYXNlb3B0
cyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLA0KPiAgIAkJCXN0cnVjdCBudm1mX2N0cmxfb3B0aW9u
cyAqb3B0cykNCj4gICB7DQo+IC0JaWYgKGN0cmwtPnN0YXRlID09IE5WTUVfQ1RSTF9ERUxFVElO
RyB8fA0KPiAtCSAgICBjdHJsLT5zdGF0ZSA9PSBOVk1FX0NUUkxfREVMRVRJTkdfTk9JTyB8fA0K
PiAtCSAgICBjdHJsLT5zdGF0ZSA9PSBOVk1FX0NUUkxfREVBRCB8fA0KPiArCWVudW0gbnZtZV9j
dHJsX3N0YXRlIHN0YXRlID0gbnZtZV9jdHJsX3N0YXRlKGN0cmwpOw0KPiArDQo+ICsJaWYgKHN0
YXRlID09IE5WTUVfQ1RSTF9ERUxFVElORyB8fA0KPiArCSAgICBzdGF0ZSA9PSBOVk1FX0NUUkxf
REVMRVRJTkdfTk9JTyB8fA0KPiArCSAgICBzdGF0ZSA9PSBOVk1FX0NUUkxfREVBRCB8fA0KPiAg
IAkgICAgc3RyY21wKG9wdHMtPnN1YnN5c25xbiwgY3RybC0+b3B0cy0+c3Vic3lzbnFuKSB8fA0K
PiAgIAkgICAgc3RyY21wKG9wdHMtPmhvc3QtPm5xbiwgY3RybC0+b3B0cy0+aG9zdC0+bnFuKSB8
fA0KPiAgIAkgICAgIXV1aWRfZXF1YWwoJm9wdHMtPmhvc3QtPmlkLCAmY3RybC0+b3B0cy0+aG9z
dC0+aWQpKQ0KDQpzaW5jZSBvcmlnaW5hbCBjb2RlIGlzIGFjY2Vzc2luZyBjdHJsLT5zdGF0ZSBl
YWNoIHRpbWUgaW5zdGVhZCBvZg0Kc2VwYXJhdGUgdmFyaWFibGUsIHdoeSBub3QgcmVhZGluZyBm
cm9tIGl0IGZyb20gbnZtZV9jdHJsX3N0YXRlKCkgdGhhdA0Kd2lsbCBoYXZlIFJFQURfT05DRSgp
IGZvciBlYWNoIGNhbGwgPw0KDQpIb3cgYWJvdXQgc29tZXRoaW5nIGxpa2UgdGhpcyBmb2xsb3dp
bmcgb24gdGhlIHRvcCBvZiB5b3VycyA/DQppdCBhbHNvIHJlbW92ZXMgdGhlIG5lZWQgZm9yIGEg
dmFyaWFibGUgb24gdGhlIHN0YWNrIDotDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9z
dC9mYWJyaWNzLmggYi9kcml2ZXJzL252bWUvaG9zdC9mYWJyaWNzLmgNCmluZGV4IDA2Y2M1NDg1
MWIxYi4uNzhiNGNlZjBjZmYyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvZmFicmlj
cy5oDQorKysgYi9kcml2ZXJzL252bWUvaG9zdC9mYWJyaWNzLmgNCkBAIC0xODUsMTEgKzE4NSw5
IEBAIHN0YXRpYyBpbmxpbmUgYm9vbA0KIMKgbnZtZl9jdGxyX21hdGNoZXNfYmFzZW9wdHMoc3Ry
dWN0IG52bWVfY3RybCAqY3RybCwNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHN0cnVjdCBudm1mX2N0cmxfb3B0aW9ucyAqb3B0cykNCiDCoHsNCi3CoMKg
wqDCoMKgwqAgZW51bSBudm1lX2N0cmxfc3RhdGUgc3RhdGUgPSBudm1lX2N0cmxfc3RhdGUoY3Ry
bCk7DQotDQotwqDCoMKgwqDCoMKgIGlmIChzdGF0ZSA9PSBOVk1FX0NUUkxfREVMRVRJTkcgfHwN
Ci3CoMKgwqDCoMKgwqDCoMKgwqDCoCBzdGF0ZSA9PSBOVk1FX0NUUkxfREVMRVRJTkdfTk9JTyB8
fA0KLcKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXRlID09IE5WTUVfQ1RSTF9ERUFEIHx8DQorwqDC
oMKgwqDCoMKgIGlmIChudm1lX2N0cmxfc3RhdGUoY3RybCkgPT0gTlZNRV9DVFJMX0RFTEVUSU5H
IHx8DQorwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZV9jdHJsX3N0YXRlKGN0cmwpID09IE5WTUVf
Q1RSTF9ERUxFVElOR19OT0lPIHx8DQorwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZV9jdHJsX3N0
YXRlKGN0cmwpID09IE5WTUVfQ1RSTF9ERUFEIHx8DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
dHJjbXAob3B0cy0+c3Vic3lzbnFuLCBjdHJsLT5vcHRzLT5zdWJzeXNucW4pIHx8DQogwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBzdHJjbXAob3B0cy0+aG9zdC0+bnFuLCBjdHJsLT5vcHRzLT5ob3N0
LT5ucW4pIHx8DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAhdXVpZF9lcXVhbCgmb3B0cy0+aG9z
dC0+aWQsICZjdHJsLT5vcHRzLT5ob3N0LT5pZCkpDQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bnZtZS9ob3N0L211bHRpcGF0aC5jIGIvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMNCj4g
aW5kZXggMmRkNDEzN2EwOGIyOC4uNWJjNzI2NTMwMTNjNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9udm1lL2hvc3QvbXVsdGlwYXRoLmMNCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlw
YXRoLmMNCj4gQEAgLTE1Niw3ICsxNTYsNyBAQCB2b2lkIG52bWVfa2lja19yZXF1ZXVlX2xpc3Rz
KHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpDQo+ICAgCQlpZiAoIW5zLT5oZWFkLT5kaXNrKQ0KPiAg
IAkJCWNvbnRpbnVlOw0KPiAgIAkJa2Jsb2NrZF9zY2hlZHVsZV93b3JrKCZucy0+aGVhZC0+cmVx
dWV1ZV93b3JrKTsNCj4gLQkJaWYgKGN0cmwtPnN0YXRlID09IE5WTUVfQ1RSTF9MSVZFKQ0KPiAr
CQlpZiAobnZtZV9jdHJsX3N0YXRlKG5zLT5jdHJsKSA9PSBOVk1FX0NUUkxfTElWRSkNCj4gICAJ
CQlkaXNrX3VldmVudChucy0+aGVhZC0+ZGlzaywgS09CSl9DSEFOR0UpOw0KPiAgIAl9DQo+ICAg
CXVwX3JlYWQoJmN0cmwtPm5hbWVzcGFjZXNfcndzZW0pOw0KPiBAQCAtMjIzLDEzICsyMjMsMTQg
QEAgdm9pZCBudm1lX21wYXRoX3JldmFsaWRhdGVfcGF0aHMoc3RydWN0IG52bWVfbnMgKm5zKQ0K
PiAgIA0KPiAgIHN0YXRpYyBib29sIG52bWVfcGF0aF9pc19kaXNhYmxlZChzdHJ1Y3QgbnZtZV9u
cyAqbnMpDQo+ICAgew0KPiArCWVudW0gbnZtZV9jdHJsX3N0YXRlIHN0YXRlID0gbnZtZV9jdHJs
X3N0YXRlKGN0cmwpOw0KPiArDQoNCm52bWVfY3RybF9zdGF0ZShucy0+Y3RybCkgaXMgbmVlZGVk
IHRvIGNvbXBpbGUgdGhlIGNvZGUsIHVubGVzcyBJJ20gDQp0b3RhbGx5IHdyb25nDQpoZXJlIC4u
Lg0KDQotY2sNCg0KDQo=

