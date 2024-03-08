Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75809C54798
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 00:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+QKGRnr1NEKDM8tz13seBeKon/bVYfrRZHjdVH8rb3E=; b=TnH42ZS7NQ6QC93VtNm/IQQjbe
	nH+M4tth0EO4rH9nlzzgEheVHY85mkrQoXn85t8usRCNEnta/Vxib9VzLig85RKP9/V+EiCNFhLo3
	IBL/IgRxb9piaOVpFPONhuS63itPORUy1jbbfzBxaLKwEa3kJnQZXjxefVlDB9PkNCKe8+EeNk2cU
	Pa4AjhsGS1A8Gkw5fkHBnrmoNcXuTL9XYjvPeLr1W0DzEfJ6WwhhwVXd9CeQRg2CU8Ae8yuJJZlWB
	jqBHiqvbUt4/k7Er8GURXmum+tH68wi8uA7XnRtAcf+LnuAFIvD+q7H1y7SDoxNRD80NDfgK3wkHQ
	NYDZFVuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riNpc-00000006vm3-1nyE;
	Fri, 08 Mar 2024 00:11:24 +0000
Received: from mail-dm6nam10on2060b.outbound.protection.outlook.com ([2a01:111:f400:7e88::60b] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riNpY-00000006vkv-13Nh
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 00:11:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCdYSyy3jHJuORYBpQdHjb6+5adv7duRUP4wUg9gBqO8sCGLtv3Io/NAl5tVAwsMa0gvas9H4TdAH8ZBGL1MiOJN028iEFgDfiWCNs88PMexF60NrNDs2o5iJCYc6OWTR0fmb9f0GRPpe51QWKgiRm5uczeHx6Xo+sUrf8/hZjq0HEO5zFJPw5WyKvi7f4JqgtPLpAPMa8YM9atG/0Hf+TQbd9j8va6RLQiykp25cz2MSgOwAVnnBhw91c1FYMvW101rYotxFZhsJvbF3/ACpNbJlivR2pqGBBsIggD2kodes4Kiuk86ErbxyoqVupEvoZ3wfAb3xmPnqIp3rcUzGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QKGRnr1NEKDM8tz13seBeKon/bVYfrRZHjdVH8rb3E=;
 b=YiX/T/qvRNymKpjdN682SFcGz7rSf/TBxdAB61NQLaYZmp+IFGGQ+WPQa2UWxNLF7uzsYLOkXSkrBfjwb039Ezo36nKLQf5udFAXWt0zOp7our7QywCCSqNZ7Y+NPFHqPql56mjNCA+vJqg7N6MCIONkoILy5BM2w1xD29lLa4pJTy70TcHYiHRP/Lnqg27tO41Q8qXJkah/Nntb9iTmx0bUy7QNw4N9TIH9TgnvtpxIH8ytueu3+GiHa1Fc1QVgFTOvnvdAMBP2QzhvP/RzySqWoEE20E0HE7zFGfgXpW4GlH2WIQaUC0fyJadwrKtDAo6VWwSY6vzo6douy46Z5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QKGRnr1NEKDM8tz13seBeKon/bVYfrRZHjdVH8rb3E=;
 b=N68j7euZsML48ndSAu6kx30t4ezdUy5LX/dwIfl/8i8VQn3Wm5Lg+uulOgLlt4JGgmYrdHSU0LlGaTwydSK+d07T4JNgur4feUJEuG8NMimQP8l9QN1oYlBot1KZAo0FzOh9lf4QdELsT//RCLgmHSSO2j5su3jOyMBt1TNaevgbaztNrjiU7Gq+X3PRmbnpo/+Ybsq/IRLmVaXvH/IjyK3kw6qjwE4maEWU7YFzDKPb1qypKPWI026yXKqfa79u6Z7GWeSMIlsSZL8iN690nhq4nZuku2SxrwjW1d3QIPr86F+qN3i+TbrYT6VOuaPTZHzVLwc6f85lBchaTNN+HQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 00:11:05 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 00:11:05 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] nvme: change shutdown timeout setting message
Thread-Topic: [PATCH] nvme: change shutdown timeout setting message
Thread-Index: AQHacLD6Z8zCJ2zoDUWRnRxex1TCsLEs+NYA
Date: Fri, 8 Mar 2024 00:11:05 +0000
Message-ID: <262fd7fd-77b2-4a44-9364-ec5b67ae709b@nvidia.com>
References: <20240307165933.3718589-1-kbusch@meta.com>
In-Reply-To: <20240307165933.3718589-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH2PR12MB4087:EE_
x-ms-office365-filtering-correlation-id: 6dc221e3-ccdf-4fd1-ca71-08dc3f043f2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4nClvrvMAhWd7irZWtgeT041uammldE7EvT+1crI7OGDPlTWBmgmQJvvUqYB6fI1+kBiL6GJp/TrcJlmTW+UQmXP7Y6cGn869NVPpN5YshtFvL6rdqjwgNkeDrekrfGP4prgrR+EKDrSiUx1rCttVpfoPe8i0nygLvWsLe0s8yLPGGRlW5Qdq7oVzHKHn7ge7qRxiIQPftoOQ4OgQ1TZ8joiwZGnIOLRLI+IOvkifWVNKEr/XwwTIreVxKqrxwgxzRGEZfMRPjtmXd0fot78yl4ulk4/hW9bJlL4hL+xjwF7tJ1+LdGxr6Q+2DQgGuuGeMCI+9fpQHQjfE20eGNPwsnZXLmkHXbNjXYKcdMMpcETFGYcGI6LlPSZIjpUO3iEc/+srxT+ns1Tz6L4VtAv5VMiZF18YPhnbFLszzZsqkwk1jzjx2z0Y7KhKRn7CBvxg1XOZQU0AVyZXvaS6wkDkOAQpoThfjw452XnvAIkwd4cXuJebJOSWPILnkeMzB8436D2oWm7MMFqSMreM7jXNd9beZjbbfOF0EYS3qlhGKkoiRkQ5ppTeLzdM59af8K4zYBo03jy35AvWoq0D5hdRIDezDx+n1DI+QgrM94ATOc0KbMbgDW4Y/PS761MevkH2F+d5N6bfq15SOn4kUwVBKU/8c3DyRrMrJdrgsrksMOLioasiF4oDGSJInTOjEGf/2onVjylVm/t/9c2QTq87Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799014)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkRMOEJ0bkQrNnlaU3d5WUZPdnNRU2FVRm4yeEJYQkpJek8ydjBIYmdLSFYy?=
 =?utf-8?B?Z0g3VW5ybXJpcFZTdnF2Szg2Z3RrV3A3T2t3WHcxWHRJYnhzRFQ4TlVMUjZw?=
 =?utf-8?B?MVluR1Q1VG9CWnRQR0N2Zlcxek9qZFoxMmJwRWdwWlZKd1BBNFRvSm9vcWNV?=
 =?utf-8?B?OXk0QWQwOUZqcytQRTdQcUpEZzdPcSsrRkVRc1JJazlURUEzSGh5TGo0TlB1?=
 =?utf-8?B?S0g0TEhnbmIzTFFPb0VlZStNVzJNNEphQ2ZZNFpsTElqamUvcWxOZjFUQWw5?=
 =?utf-8?B?ZW1Vc0ZDc3NFNTk5ekpiYWJCZFNRa0UrT3ZLRXhOemJJR2wrVEtycHh1SEFn?=
 =?utf-8?B?aVFKVXRUV2xyQVQwdE1FSUpvMGNDaUw2dVJHd1pja1FjV3R3NlhMQ09ERVFz?=
 =?utf-8?B?NG0rbGhmK2RuaEw5dnJGSkV2NGZ0NSs3NWxBT2xkaHBCT01jUFJDaElicXBm?=
 =?utf-8?B?aHNUQW5XOGNkdWdUMmRmZWZ4YVRPN205bm0vTmsramV2dnBxZ25VYStrZ1Bo?=
 =?utf-8?B?eGRVRFkyNnFkZVgyNzAxTlRVM2VNNnhmTkRkbjVIRjRwcDNMYXFQKzk1SXdL?=
 =?utf-8?B?c3FyUnVvbGdmYUo2VUlYQzdmTUIxYzROQUFxVnN5NXNqaCtiOTNxQ3J4OXlU?=
 =?utf-8?B?VVl3alVGNjlyQWxKeU80T1JQOGhURDdabHVtZ040SWRPUEhURHRmMWU5MHBZ?=
 =?utf-8?B?TmtUSldnM1l2SnM2enVFTDVONHloa1ZBM2ZEenlSempmeTQ1TjhMNmlKNHkz?=
 =?utf-8?B?VmE1VnVDQWNZWXNNWDN3VHJ2ZUF2NUVoN3Uwek9IRU5DSmxFdXJFeU1SRzMv?=
 =?utf-8?B?Z3VmZDNySUhNUXlGakEzdzZSUjdVSzhOSlh0c29MUmRZU3NMNjJ2ZUxrMEV3?=
 =?utf-8?B?WmVnYUdQS2UvRUZHYnN1ZjJ6QzFvZXpOM1lqZm5remdIMDFiVVpYb3YrbFNO?=
 =?utf-8?B?WTBXVVNZbjRkdE5kb1FPRXFTWFNHczFhK2kzV3JYODVRM1VOWUVaOXpEcEpu?=
 =?utf-8?B?MjFwTlhiNThlQll4UWY4blhlWEZnQVRIaXMrMEI0ditPZm5mWW15YndpV29p?=
 =?utf-8?B?cGV1aXR1UVBBQStFUU5UcGE4NlpwQVdlMjdhT3dFZGovQWdnMTlWYlR3SGlv?=
 =?utf-8?B?NDU0TldNUEhRSDlvL0FMQzRiNk1PQURPOHBSZHhJQ0dHRzczQ1c4Sk9oVHV0?=
 =?utf-8?B?WHpmUTFXZXM4MDY2TmxLUjA5MFp6WmdnWjQvTU15Si9zYkdjZzZlQWJCZ29L?=
 =?utf-8?B?YkQrSzdjSSsvWm1HdzAzY2FkdXVmY3p5Q0hkUU9MeDV0VlVVdFFzeWJ2WHJR?=
 =?utf-8?B?RVdERGZsMEt5NUJnNWJVemFha2U2MmNrbExYK0kxVXFIa002R2ZOcXdtMFI0?=
 =?utf-8?B?RyszeHVwbTd6WEFLVHFKMWxaM05VV1lwMEtoV0Z3K2c4cmZBRXlvY0VESHBT?=
 =?utf-8?B?a1hVbS9kdFBVUStDM1JHd2IxYXBQQnZvWjZpaFpmcGZpMEhYQXR2OSt3Rm14?=
 =?utf-8?B?L2VPWHNlN201aWNLMEpvcmI4UEs0L2V4aUNNTHliTkNHZktFVzlxV3A5VE1y?=
 =?utf-8?B?RlU1UUtXRHFSVHBpUkxXVXNiaHFsQzluSkFKcXd2ZEwrakVsZTU2dEc3eEJV?=
 =?utf-8?B?cFhDckEvSDRLUGoxRmdXWDRxOEVseU5aNVlOUTRvS0VNdVE0dGU2QUdpZGdZ?=
 =?utf-8?B?UUt1NGRPeFhNSGdLZFFNYktrV2JUNUowaDdzRzA0MVU4ek9FT2hNNG9rZFE5?=
 =?utf-8?B?a043cjFFc1M3dTc5U256YVN3OXVSRGMwL3NQMmIvWURZOXQyU0ticHlwWFRT?=
 =?utf-8?B?bzdoNmtVREpBY2VGSG4wemhhU01NQVFDWEg2TUgxd1NqNEQ2L0NxYWNXU2hq?=
 =?utf-8?B?SmRucS9OS3ZJV2FFZjh3cUo2QWNBK0QyVktoVUlEbGg2ZDk0ZXhMVGZkSkNn?=
 =?utf-8?B?YWJTT2J3cHF3eWFqaTVYYXlRM1hkRkRaTzhSZWxEMnEzc3BDRlAxS2RuNmZU?=
 =?utf-8?B?TDFvajhXT2NRNFlXQjZId3plcEt2UGdvYXVpQUhhY3NuQkVjSjNYSWVwNGxS?=
 =?utf-8?B?alZWZzVpQnVpVjRMdGVlRXcyemxIVkdTNzA5VDJBYkNYRDhXL2JDbDdCM2kz?=
 =?utf-8?Q?rWvz9ufUp5RxFPofGUMA6NuuF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BD2F3A06450D54FA70D5C391456F1A4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc221e3-ccdf-4fd1-ca71-08dc3f043f2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 00:11:05.1828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UEGijNXSEiPWWIkoSQIqtuPD6ROlfYgl6B7hOB9ozDOQ4+bmUdiymjn5LxJDblpx3Wfm5CoYJnRgOmBthYgP6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_161120_322209_24DA8F22 
X-CRM114-Status: UNSURE (   8.66  )
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

T24gMy83LzI0IDA4OjU5LCBLZWl0aCBCdXNjaCB3cm90ZToNCj4gRnJvbTogS2VpdGggQnVzY2gg
PGtidXNjaEBrZXJuZWwub3JnPg0KPg0KPiBVc2VyIHZpc2libGUgbWVzc2FnZXMgY29udGFpbmlu
ZyB0aGUgd29yZCAidGltZW91dCIgY2FuIGJlIGFsYXJtaW5nLg0KPiBUaGlzIG9uZSBudm1lIGlz
IGp1c3QgcmVwb3J0aW5nIGEgcG90ZW50aWFsbHkgaW5mb3JtYXRpdmUgZGV2aWNlDQo+IGNvbmZp
Z3VyYXRpb24sIGFuZCBldmVyeXRoaW5nIGlzIHdvcmtpbmcgYXMgZGVzaWduZWQuIENoYW5nZSB0
aGUgdGV4dCB0bw0KPiByZXBvcnQgdGhlIGxlc3MgY29uY2VybmluZyAiRDMgZW50cnkgbGF0ZW5j
eSIsIHdoaWNoIGlzIHdoZXJlIHRoaXMgdmFsdWUNCj4gY29tZXMgZnJvbSBhbnl3YXkuDQo+DQo+
IFJlcG9ydGVkLWJ5OiBMZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1i
eTogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPg0KPiAtLS0NCg0KDQpMb29rcyBnb29k
Lg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K
LWNrDQoNCg0K

