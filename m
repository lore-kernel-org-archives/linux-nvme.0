Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE14C04A68
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 23:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NxXon0w/5iSpPb0NTk3OLi2eSOAN/cKmxE8dsLdiYsE=; b=PK7Q/MbGHc0ZxZmL3vg5K1OArJ
	dKIFW9XciIMXanUoWVbhbPKInfDEtUwZaJxNFY4NIYibwXR6l7exYtzAHn8hi6mvs8lQroBVe76E9
	T6942lrZWXLI+4EJvVElxBU9BePQbGuqTyq1Oq0JJX9C85Z3vXxejUL+ioRZQsWcqbXKpk3mIvQLq
	WgptfTLG8RLXtuq1/gJ9TzLA9V+jwwrzpPDL/u2w7T8+7hzaBkg2IauoySM54eV0f9ailOhgkZfuk
	s0n9cRbauBMZXV/tZ24p/wDFTezz2C+1XWeJE28cfluYBvFG7jDTNb/bMQOL6mVMmDpqPUOl88roy
	IL+chnzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHCbg-00FfnV-EL; Thu, 28 Jul 2022 23:07:52 +0000
Received: from mail-bn8nam12on2079.outbound.protection.outlook.com ([40.107.237.79] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHCbe-00FflF-8S
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 23:07:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZpPhMXe9pljc6vyZmJEee8Zrmk8mOtZ3D1eDAWOnu7HM7oakkTBF17mwZgYUnWqrvvtyGTsctQ8q9ZOR5jXROdXDLEtg/44kTVkQ9UT8ni4LcpjgUpOhQYpvYOtSKcAM1ZRMDJtzwMtePNfkO/sAGYuycxCv1v8QWlQ3fRDClIsDGX/JXE9KnVtybB31koCWHuBdRUaX5MW5aNMj0Bd6tT5Vk4lnEJ/yYBp7XODpzzIG7U12UwrtXUAD/WMqWFkEIowfXYeue33m63aK3vgHNRu0TsVdkxCXkmJNmJV/Fpn2IsHoESv8EU0jcFkMJ1sk7l+hDfYCOWTGA4F/Oo48A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxXon0w/5iSpPb0NTk3OLi2eSOAN/cKmxE8dsLdiYsE=;
 b=iuUgxA4H703gcoA9QO/2kKtHVgpp8kt8PbGCDLj7BtT+vMWL/Chq5aAhkRMMA9uwL7rknnVdy95P38iovDcDeEsK/3y1Nonj8atCpNe9+VRcK3RqhXs9JN3jWBFmphrm2w7ldQH7PVXbLAc+8zNS+ML8MWr+ORbhKKI0k5CQUNpYTUZpYMaxglAiRK+ijt6csHz95GGlZhX1h691qqiA045v+nCWd3R/rak1URCq2D60Xnl8sXeeuaC23NjPnbDp2OBryVnL+gZAxFz1A+67AY/sNWmARr8oqFSJsBfZ/1m7D2Logf3nPykQTEL1jIM0dSDYnvg34S67B+Hp/qS/LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxXon0w/5iSpPb0NTk3OLi2eSOAN/cKmxE8dsLdiYsE=;
 b=jZ86IiMRcpw4YJn3tRfNQhsGh66B5bJGa/9o19qkCCz6DmTNsibaKkOFxRUk7xgRUDvq1SWS/GDZY8lWvB3mvvdHZGWXnTM3g+4MXn13qRs7//RwL1Qt1DJCHMjk8q7yhhxsB6dKWGWFIOOpCFinC8CHRjMbvwzwauI0uTWDpgPDEIB5yenKMyVGoaz2+cvMJCt6+BODB4/UeM6h/eGBhgMoZ+Khq0OH4B5VnHynNOE47kUIGWFY3PIZJZHe0BgnVQipbem2OOIxBlwg5dqXrobQsLkalPZuXs2cZM1TAsbgRdNHFgS72Dp5TRd0EKvnO+1UwuiCHbO4/hCZu7Vilw==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by CY4PR12MB1749.namprd12.prod.outlook.com (2603:10b6:903:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Thu, 28 Jul
 2022 23:07:43 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::21eb:6424:fbf6:a189]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::21eb:6424:fbf6:a189%6]) with mapi id 15.20.5458.024; Thu, 28 Jul 2022
 23:07:43 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: add ctrl state machine pdf creator
Thread-Topic: [PATCH] nvme: add ctrl state machine pdf creator
Thread-Index: AQHYogN5TBHSo68kmki/w/glU3KF+K2UHvUAgABKsQA=
Date: Thu, 28 Jul 2022 23:07:43 +0000
Message-ID: <23d45b37-b02c-66bd-98f7-c8af10a1a458@nvidia.com>
References: <20220727215424.5252-1-kch@nvidia.com>
 <20220728184022.GB22439@lst.de>
In-Reply-To: <20220728184022.GB22439@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52826211-e348-41f8-286b-08da70edfa28
x-ms-traffictypediagnostic: CY4PR12MB1749:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  lPIMl/GnvJblX5TQsp6wsCal9Jh+obBPjnZJIXSh9eyTfsqKO0L9ct9WcniH1dVgFIVSuqFy9wXttcTe5QAeoEpgCnDVWh6y2c5RtE04ahgINkf6DXYfB17riSF5OiqvCU2dvc3PIiz8sM21rcMdAO8zA7w709prlu5Ug3Y4e9DINAk0nFdO+wrvne/oi8YSh1efQ67zA5WxXuxsQCCOy1fdVO4cj2hneoy0KIqA3yqCANFS73sEdNcKQRhluAzzZuIweaisBWas6Cts32/q3DuE0ip2KAkkAPQh4Zi1cIGgpUsiWBQnXeEVz9Ipy47NUijDnOSzo/4Py9MDV1eJyTi5dQdPwZtsu4W6Am9n053D1CL0tVv2NZ1lrXVyeZsKxRKtc9D23GtxX17HizEH0IY5Z21kUPHnFHYWKc3KyafNQanlyq5+ooEt2Xoa+SCefRuDazA0/gi30CzDoW+duiAe3FAfpep36NgVMyKyz4IZy4GQ8mpLlmaDm+LtCfsnwD0KzG2RUxdTonXDjHmMVCCp11BC8kOnSqZi7PjO3awlVbo4PqHmU6z8TfevcTj1WsiZYqbFrTBsd1mgN6+zLsEAkLZrwNb21LVCnN7NAQRyvZ5hZuaEI4Z4cnVjlXaQnrdpPR3Xhc+7sxT4CUm32dV6VSkMWImWEFC6iFCFNae9qIR1eSGuQA4OZtTEna/blAYy+O5m9ntP2+L+ECkBIDTvlQixXhDXQgF1cNi/Tvu1th0AMoqzBhrWjAaKUOAGlHSvgUNeC1UGKW81KWsMF/rHaE4f1Esrz/pFkDCOyFGPl6TEnHZXQcHESOPQU2lHT/UKFUaqLyK5flJTQ75ifecx3CYg8EBOei+XVtrnkdVgHLgZDXNMM9YLkgPswO+t
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(122000001)(6916009)(8676002)(6512007)(64756008)(6486002)(66556008)(478600001)(66446008)(4326008)(53546011)(66476007)(66946007)(2616005)(2906002)(91956017)(76116006)(38070700005)(316002)(54906003)(6506007)(71200400001)(8936002)(31686004)(36756003)(83380400001)(186003)(5660300002)(41300700001)(38100700002)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?Sm84WHZWSDFvR1VpMGZLWCtIbEo2WVlBNDRlUkZJd3lhelVkWENQNEZ5Nzcw?=
 =?utf-8?B?S3IrT3lVQmE3MUNiVitSQThaSmlWbUJnOEgzZnZwd0JnVHNIQWpKU2dLcXlv?=
 =?utf-8?B?T21GVk84TjQ1ajhBZjl5QWJseDlJUGczVHdqQVhNMzc5cUY3anlkVWFyOGU5?=
 =?utf-8?B?WXdvRWNwS0N1SEpleXp1WnlZYWVNN3dFMEtrdzA0VFo2K0NjZWdsZEhnajNm?=
 =?utf-8?B?aHh6SUVFeFpvdjFVcnBZOUMvdWwzYjQ0cnJyOHpjVi9YZjJCUnptby9aa05U?=
 =?utf-8?B?ekU0Nm4rTEpyOEdSdTZsTWdTd2dTczM1YVZlS1NlSng2WlNrV2dQeWdPNEJx?=
 =?utf-8?B?eCs4RDB5UU1CVDErUnl3Q2xQcTNyWUFyY25YeEJGemExMlVsUWQ4eUpUREZH?=
 =?utf-8?B?ZmovVmtUWTJSVTlWYS9oS1BlN1N1MkV3TE1KZ0NnWGV0M01yOFcwTHo2bWdj?=
 =?utf-8?B?UU1ubmdLcVBCUGtySUx5OWNaaWlPMG9Bc05KRllzZkpIRUttSUY3cW9ObUZ4?=
 =?utf-8?B?cnM3YVNnOHpHTnZEcEJtK2lsNnNFdERScER1b0R4WVBaQnhScU9DNjkyZmNE?=
 =?utf-8?B?V0F2WXA0UC9HZm9BZm4yQ25FR1lsUU9wNjRQS1RSSmJiVElJOUowczBTaHNM?=
 =?utf-8?B?KzRWTWRjdHh2bC9uUGt3aVljbXBNOGpneHpxQnQ5U2NRYXhZUkgxajcrZ2xF?=
 =?utf-8?B?TWJmODFsS3dGZDRIbHBzeDFkOE9GWWQ3OVkxUGZXa0l0bEtWWE10VnllYSsw?=
 =?utf-8?B?NytsUmhXODk0MjIzRzhrMnNNaFJud0IvN3FOT0FPVHdzZkEyWDBMU2h5eTRL?=
 =?utf-8?B?d25SRit2cTE1STVHQ1NMOU9RdlczbG1vaDJRSklKNGI5OVcrcWdZekc0YzdG?=
 =?utf-8?B?ODNvNnhzeWtjRmhyY3dmUTFpdm1WdkhiWk5QaXFNUExiRnFpTlFlUE9ZQjZH?=
 =?utf-8?B?WC9sUlBzU25yYS9CN3hWUzNLVDFyT0JlOFl6R0l2TkdPaVVFT0VQL0kzSmIw?=
 =?utf-8?B?SGt0WWFrMnFFUzNKbXVZcWY0L1lXRDVtU3dQQ2V0Qmg3dnFBMFVkMHJuaFdE?=
 =?utf-8?B?NVZoS29tT1RaMStKdnRlcjRjZEtLRGxrQmYwUXN0WDk5YnRmMkt3eVY2RFgv?=
 =?utf-8?B?WnFuZG11SHE1WXhxZHpkWjVWT2JCN20yT0k4L1RRTFpDQkN4SHpEdk5mUGtW?=
 =?utf-8?B?TUQ1VkpzQm5KMUw3U0ZOeVVOaWZxaUVLanJteGRYb1BIck8vZmZRYWY4ZzM5?=
 =?utf-8?B?VUpCWTNsLytaMTM0a0xYSS9jVDBWemFjZlV0QXFBaVo0aU5UWjlvOTBsYWRW?=
 =?utf-8?B?OVJXb00xNkVOWk1ySVJhR1Z0V3ZidTVqaHpzZFdubDhkVTZkaFF0eFJrUlFW?=
 =?utf-8?B?WGhpcmRYUk53U0RZbHFlNWZ3dUJ6QkR4UHJyekxuNzNZWElDU1ppNHJTSUxv?=
 =?utf-8?B?aTJ0c0FrYnBjemNzMkg2QkwzNjdRYk9NYzJHZ3dxeUVKM0VRTXFybHdUUjVH?=
 =?utf-8?B?blo4cjV3UnhiVmFJOGxnUUtpQmpqRFRIaWFZMFN5WEcreURQSW40MGpXUGFh?=
 =?utf-8?B?clBLSm04Y284bVN1ckY4ZEhQUEt5Z1JmRk5JakJJR0N1MTNOSFJZZy9zTkRj?=
 =?utf-8?B?UU5lK1BJZXI4VzJUWk15QzJKZDFmaDFSYnliSGp6aThxVUx6L2MxYlBoUjNv?=
 =?utf-8?B?eXlRLytSeUJZK0JYald0aWZ4c084aFZwK0tUZ1N6RUZFYmFtdlJkKzN6LzVn?=
 =?utf-8?B?ZUJQZHJwSzlMM01nNmgrYmZKMmhOMVhRZjFib0JuTE9MRDJjYy9pdU5KN2Zy?=
 =?utf-8?B?cm1oanpIKzlEVnZCMUpOc1FNSTFjOElaSEp3aEtJWmhYUmppMXpDaUZwbnFX?=
 =?utf-8?B?OEJYOFI2djNDTmdzTGNiTGlZbWF2dUFRUVA5ZVRxQUsycDBtbnlVQnU0UFpj?=
 =?utf-8?B?bUllNDRwMFdxUGh5eksrSzRGQVVEWklnNVRHSHdBZlExMy8xZHc1SVJvSms1?=
 =?utf-8?B?WUMrVVkzWTRJNldUNGJva04zY3ZCNUYvODNub0tONUNLZUJ5UTdrSnJlMVVj?=
 =?utf-8?B?aGhUR1RwVHdKQlc1eHUyODJOd2FQempoUUZCWkoxUVA3ZFZpdzNjZXlHUkRV?=
 =?utf-8?B?SjlKWnNXakZYMTdMaEJKSld5cDlWdnk4UEUreW8rY2F0RnIyYzI1ZWw2QjZG?=
 =?utf-8?Q?v2ihRXDWBvKvn5LkJ4qPP6gKpV4nRWnxFTFFDjfErWUt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A37F49167B5EE44788BB0ECCCCBE9603@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52826211-e348-41f8-286b-08da70edfa28
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 23:07:43.2373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fG8tQZVaC780SG+Q7yDjoS1EL2ffznLNOyRXRZ+0bX6OyR9BMZPiKMW7uuqnbtFuVxSEEEJX6IZ82nSt3zOENg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1749
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220728_160750_654166_C9DA9E91 
X-CRM114-Status: GOOD (  20.46  )
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

T24gNy8yOC8yMiAxMTo0MCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIFdlZCwgSnVs
IDI3LCAyMDIyIGF0IDAyOjU0OjI0UE0gLTA3MDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToN
Cj4+IEl0IGlzIG5vdCBhbHdheXMgZWFzeSB0byByZWFkIHRoZSBOVk1lIEhvc3QgY29udHJvbGxl
ciBzdGF0ZSBtYWNoaW5lDQo+PiBxdWlja2x5IHdyaXR0ZW4gaW4gQyB3aGVuIGRlYnVnZ2luZyB0
aGUgY29kZSBmb3IgdmFyaW91cyB0cmFuc3BvcnRzLg0KPj4NCj4+IFRoaXMgYWRkcyBhIHNpbXBs
ZSBkb3QgYmFzZWQgc3RhdGUgbWFjaGluZSBmb3IgdGhlIGhvc3QgY29udHJvbGxlciB0aGF0DQo+
PiBjcmVhdGVzIHBkZi4gVGhlIHJlc3VsdGluZyBwZGYgaXMgZWFzaWVyIHRvIHVuZGVyc3RhbmQg
YW5kIHByb2Nlc3MuDQo+IA0KPiBTbywgdGhlIGdyYXBoIGxvb2tzIHByZXR0eSwgYnV0IEknbSBh
IGxpdHRsZSB3b3JyaWVkIHRoYXQgaGF2aW5nIGENCj4gc2VwYXJhdGUgY29weSBvZiB0aGUgdHJh
bnNpdGlvbnMgc29tZXdoZXJlIG91dCBpbiBEb2N1bWVudGF0aW9uLw0KPiBqdXN0IG1lYW5zIGl0
IHdpbGwgYmVjb21lIG91dCBvZiBkYXRlIHZlcnkgcXVpY2tseS4gIENhbiB3ZSBpbnN0ZWFkDQo+
IGNvbWUgdXAgd2l0aCBtYWNyb3MgdGhhdCBhbGxvdyB0byBib3RoIGdlbmVyYXRlIHRoZSBjb2Rl
IGFuZCB0aGUNCj4gdmlzdWFsaXphdGlvbj8NCj4gDQoNCkknbGwgbWFrZSBzdXJlIHRvIHVwZGF0
ZSB0aGUgZ3JhcGggd2hlbiByZXZpZXdpbmcgdGhlIG5ldyBicmFuY2guDQoNCkkgZGlkIHRob3Vn
aHQgb2YgYWRkaW5nIHRoZSBkb2N1bWVudGF0aW9uIGluIGluIHRoZQ0KZHJpdmVycy9udm1lL2hv
c3QvY3RybC1zdGF0ZS1tYWNoaW5lLCBidXQgZm91bmQgaXQgb2RkIHRvIGhhdmUgaXQgaW4gdGhl
DQpudm1lL2hvc3QuDQoNCj4gZS5nLg0KPiANCj4gCXN3aXRjaCAobmV3X3N0YXRlKSB7DQo+IAlG
Uk9NX1NUQVRFKE5WTUVfQ1RSTF9MSVZFKTsNCj4gCQlUT19TVEFURShOVk1FX0NUUkxfTkVXKTsN
Cj4gCQlUT19TVEFURShOVk1FX0NUUkxfUkVTRVRUSU5HKTsNCj4gCQlUT19TVEFURShOVk1FX0NU
UkxfQ09OTkVDVElORyk7DQo+IAkJRU5EX1NUQVRFKCk7DQo+IAkuLg0KPiANCg0KSSBmYWlsIHRv
IHVuZGVyc3RhbmQgdGhlIHBhcnQgdGhhdCBsaW5rcyB0aGUgQyBjb2RlIGZyb20gaG9zdC9jb3Jl
LmMgdG8NCnRoZSBwZGYgaW4gdGhlIGdyYXBoLCBjYW4geW91IHBsZWFzZSBleHBsYWluIG1vcmUg
b24gdGhpcyA/DQoNCkkgd2FzIHRyeWluZyB0byBhdm9pZCBuZXcgY29kZSBjaGFuZ2VzIGFuZCBh
ZGQgbW9yZSBtYWNyb3MgZm9yIHRoZQ0KZG9jdW1lbnRhdGlvbiBwdXJwb3NlLCBsZXQgbWUgc2Vl
IGlmIEkgY2FuIGRvIGNvbWUgdXAgd2l0aCBzb21ldGhpbmcNCndpdGggbWluaW1hbCBjb21wbGV4
aXR5Lg0KDQotY2sNCg0KDQo=

