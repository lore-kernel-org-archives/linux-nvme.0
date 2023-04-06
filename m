Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D91C7618D
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Apr 2023 00:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iOherk08wDFrZV1OxKsCrhBOXn6SJYXWoVaLOr7lKpE=; b=vdOxyLa+NEISUE5wrYevrR7FNI
	20fH72UDJWs1rAwf33qoihM+ll4hccJEykbqQWWChTIB9LsNeWuT665tyqhLaUrf4utHd5UC6DaZD
	Dx2pfPy72J/uLggQ2TGq5qP+tDN3llwF9KxyybC0EW/yuZYf0Q5Su7YJJ9RSTihjBjUL6YGGGj1QX
	c6+Mq+bbPMK+8N1VfPqhHhd4ekZ/NSfsacJgoQya0xyXLDiY5+VU8TIR39rsEiLqTkCRvF2HXFcOr
	sA9ySXtJBRaUUqQYl0BN60Zt17zIiPs+6dE6LOzUVmerKR7MoWY2pxTF3r20Xat8y9BFsK0nC4y3q
	nUN0YyYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkDOb-005yCO-1L;
	Thu, 06 Apr 2023 00:22:33 +0000
Received: from mail-dm6nam04on20631.outbound.protection.outlook.com ([2a01:111:f400:7e8b::631] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkDOY-005yBi-31
	for linux-nvme@lists.infradead.org;
	Thu, 06 Apr 2023 00:22:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwiQVNDtZ1C6cL8C1KsM9akD+1829Ziw16ip2F25bHqxWmIgiiD0FXOpypDZ4myMRup5/TsXlmyYEBPfxm58iGNprG+J0XB57YD1rZ7HCTyFqgl7Em3ZPSZuyvvfsIHos9YGzSrhW3kf0V7m3WkgLjQPa4RWGxiHepYa4KLLXyqDMH25wLtRhJW8wnXLdeAIggvCYWeQ1qq1vR6L8LVJAfFjorI384v+WJJkszZ5DibmVxEgM71rvB8A3MhG4QcOh1OWzv7QsYY/kMhqku5oikYZ2HasIblDmPKkeB+I9fGyd8FPK5CZ/ecNa/Trvtw1Ochmun6H29ZxFVZHIA1Anw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOherk08wDFrZV1OxKsCrhBOXn6SJYXWoVaLOr7lKpE=;
 b=mB2Nf/kO09NHKEU6TQewaAtjGkGpaqIm/1AQ5fVPpP1DV/RpJAZ1VgprZtcrqd4skCqPIOJiYxR66Ve2OL+JdJYpbAXgHa5t9xF/DThW1CVQOnWLhwFxmZO13GyeVDzk5/k8YB9nAgsby0lS7ZTBQ7muaP5UizVmOS8IZQCkCyA9c4hgM4vAM9TtTBglwuKB8wcPSTYEvuObPrTO5LaKKRpjXUtJDEHY8D9Rf/j0iQrZdEyB337xWV9+U8iX50JmRksMdJGZyb/yyFGbQF5GjZyjd1ns55JXrXwZQkyh2ZraJBy6P4rC5V1o9DgJU47XNkkmR0H3PV7DK/ouiyY8Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOherk08wDFrZV1OxKsCrhBOXn6SJYXWoVaLOr7lKpE=;
 b=tacXf1ZTrN7s9/7wl4NDA0+bY1AflG7O0hpdT5/eRx2T8Y6PU3tMLY98Qihm9whDEQgEy7WnwtxeHb92D8DXBM/TTgH9wNpVTxUFK3kmoNEJF76fsrST2Zvs6Whj9k6+vF9us5RU3/V2ul4K/mwus+nDoGgx0ZiledyiF0uM7+vsQvDlBuxa4fp46iwjj5nvEBUoGRL6/biCWtbieluQBjFKb5ku0QGyNjNV3QT/n2VwUIqQLWge/sFl8V1RsRqpe/d2Jc8N5pz+CIHaUTOHo2Xue8Ixzn4co7ov9nZcl6LE21NzwVGGJJY1Tt7UciedOhY3IkEIyn7Gtzrt7cTTSQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB6562.namprd12.prod.outlook.com (2603:10b6:510:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 00:22:25 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 00:22:21 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	"hch@lst.de" <hch@lst.de>, Nate Thornton <nate.thornton@samsung.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH] nvme: fix async event trace event
Thread-Topic: [PATCH] nvme: fix async event trace event
Thread-Index: AQHZaAmdck8cqAu4nUmEICuI04QsTq8da6GA
Date: Thu, 6 Apr 2023 00:22:21 +0000
Message-ID: <7d9ab7c0-0972-2a77-4653-3b46174f5a18@nvidia.com>
References: <20230405215720.2872579-1-kbusch@meta.com>
In-Reply-To: <20230405215720.2872579-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB6562:EE_
x-ms-office365-filtering-correlation-id: 4d6e3057-1922-49dd-f4bd-08db3634fd20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  UO00gZy/3ai+jzm8i0nk9Y65JO6/E1pRAQaPlpCb6MB3OsdVnb/lshXGMljMI7U9FkbqkUq8IgCJU1mDqqrCeXBqpIhyHc7tBSMD57ikyx4UgOYL5ON9D/1Z6BcIK7ilNe/ZGz5JMP6gNvdr1EMwrAtTx8oMUvng6+ZQaJ8Z3k0gp20aRqWzrJToOUGdwBt48AolF3Wx02+RDjGgp0tWZgvRIiu2fSJ/0Yrj6cy2kb6Vb3TjcnhankXKKZ06mHZbQQcSlNit7Pu/ip+XOnFYnWaaqUPJhdHImJSpxLpoeg1pfffDxnVa8GR1vw0psW5DcC44kR4J9gBKM+wwKfJ85X8Mee2+L/JLHMO/88LrgZwQkuz/l1AfKc6GNXnVjRg4RZU2pU0VZdp2sTr9MIu/9upiUhiN2fOsocTs8a+13E7tNQ0r4TWNt6IA9Uxj89EeySBYDgThMCQf8r4g5ticjRasYQfqvksmfLSf0M5tX6qNiEc62aNAHY21dnEBG3hkFu74UA13YToLftjOn1y+1UGBjKtCpKTxBuIK2GUrBNXt656DCWs+0Dn4IaFaNGLaCpmklI/nO1OShyMzBC0Sq2vcgkpsWSjNm8mrIVzYzmcI7PBqkGPE5U9X9Ffrcl9PWPBHuj5JjU7+PNEoofqIBFXxt+Ak2wpBsiEfnf7L0J/rjV9OdqXOSrXFo5exwfwX
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199021)(31686004)(66446008)(110136005)(6486002)(76116006)(91956017)(478600001)(54906003)(316002)(66556008)(64756008)(66476007)(66946007)(4326008)(31696002)(86362001)(36756003)(6512007)(2616005)(53546011)(6506007)(107886003)(8936002)(41300700001)(38100700002)(71200400001)(5660300002)(4744005)(2906002)(8676002)(38070700005)(186003)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?SG1CTjdISnlpbWNXUkpBM3c2eFNsQTVpcVFsOHBzODEzTmY3N3dFZUhPanVV?=
 =?utf-8?B?Wmp0cVJ0cFYzSWoyT2QvRExOdVZpb2txVXVKYzJOV0daMG5BTzhNMG9yd3o2?=
 =?utf-8?B?WlVUdUsrSG9xblZYcmlMZHpJaXBOVVNVVXV4b0FuTFcyZytHa3N1akpiNTdP?=
 =?utf-8?B?WXYzYWp3Rk15dUJVeWRLbmI3SUhFamJFbkg2S0ppUWNtK1V3YTJEYTdKSFN2?=
 =?utf-8?B?MmROVmZpYWpwQ3NtWFY3Qmo5LzJFMFErUmFtbDZkamVWcVVyRFE5dTRuRWZB?=
 =?utf-8?B?R3BxWXB5RG1EY2t6aHgwSFViZk95Qm5GbTN4dDRkZlRPZmV0dm8xNENqcmhx?=
 =?utf-8?B?cFlQSXJESFE3MTU5YytQWU01Mzd4TG9nSGQ2VkJpYTVvL1B5cUIrNjFGejZY?=
 =?utf-8?B?cE1kdXpiUDZHVWp1V01NTXVjbzQ5Z2dicWREaW5BTjBrMm1YZmJwTzlFV09p?=
 =?utf-8?B?OVVIU1l6NFpqeVpvZEFTR29MaGJvSVkvVVFoK0tCQ0JPQnVRdkRMQThOZWJU?=
 =?utf-8?B?QmJGWEFNMThMd1VZWWFnYWhOK3p1Y1dkUnRmMVNjVGxocllvelR4L0ViRSt0?=
 =?utf-8?B?MFlSVTZabXJBMEhtYWovR2xpdGtrcnhEOHE1WHI0emZEYm1yWFlLWkgyWFFH?=
 =?utf-8?B?YnQ0MnRKZWpVR2pDUnRobzNjTHQrVUlDaGZCZDFiUEJwRW9xRTlTaHliK1Bi?=
 =?utf-8?B?QzJnM0VlNUsrNTV3RU1oeGRZL1lveVN3MGpvazd2ZHJMQ1U5YkdjTTREd0ZN?=
 =?utf-8?B?WHg2RWJraWNnNTNLN3hRZVNyTWlFWXdQRHYvdTh4cWtDZWdLT0ZVS2JYNUhP?=
 =?utf-8?B?VW9YNDl4VW03RmRsYU9oOStUMUZ3bGlTV1NXT2pJVnhFUnVsR3FsSHVBalVL?=
 =?utf-8?B?NEZ2OTgrWXZEb0d3OW1qQWVvdGZJK3hUeHd6VmV6NE5YeXlueEVoL1czRzZS?=
 =?utf-8?B?empMbUw2VzlkQm92YkhabmJadTVSNWpsaGV4MEJMak15STQ5RHpJVk1kRW1H?=
 =?utf-8?B?K2U3cFVVK3JLVzU1aVpXbTZBWEJHUFJ6SmFQYzJiVDFibjVaMEQrQ1Naanlh?=
 =?utf-8?B?U2NvUGdzODRXTk5aRlNKa01IRmh5K3hyMGxLT1p3SG4zNHRDU1ZPS3BtckJD?=
 =?utf-8?B?UWdscTcwQzU1QWYrUllSYldCZ1dWM3NlMmR6MktFS0JRSGtYR0htelprUmho?=
 =?utf-8?B?bFY2RkVjK3ZUUlhaczBOY0o3SU5wQnVuYXVmSnFDRjYzdWtIUkdTeXRURUhB?=
 =?utf-8?B?d2E2Zmt4d1VZL3g0L1M3VjN0ZzRSYmZybnp2a1h4T29SM09FVXVsbVBaYWhq?=
 =?utf-8?B?NU5SWnpKTlFBMjhMeGNXTHhWQk1nb3ZtQnVyaEhoK1gyTkRlTUtDcU9aWnI0?=
 =?utf-8?B?VCtXSlYyS3pjZ20zbXhzVU5JN0xIYndQQXNhMXFHNG9LTTY4bFNCZi83TUF5?=
 =?utf-8?B?M3hTVWwzdm53d1dTTnlhendHVlczT0F6L2QvQ3dEV3l4aVp3VTJRWWFkZGRE?=
 =?utf-8?B?ZnJ3cWx5b3hTSkUvbFpKTkIwbkErTXU0NkE3ck1aVEVIV2N2WmpGZTBjT1FH?=
 =?utf-8?B?TUpYT2VUbG5zZnBoQ3ZxT2hzRjJxRGFaMktSbmRYajlTNEdCUFd6R1pxTXdI?=
 =?utf-8?B?UDBLQWdieGZaalhXbWxKcTFIWm0zRjNlV2tRVzZOZTNYaG9HVldWeHcrZnhl?=
 =?utf-8?B?QURDN0NHSldyWjFzeUhSVlBxUnZKbEVIam03VlhrWnlzY0JLRXlZTVB1dkhQ?=
 =?utf-8?B?N1pQNlkwdkZmbldyTm13aTFxKzFBWkNEa3ZsV0YzNGpacFNlQkV4Tk0zeWdm?=
 =?utf-8?B?bHAxOVFHZkJPcUJHRkNLUER5WTVubjNwS05nNUVqT1lIckNxNWk3WEJGUHlH?=
 =?utf-8?B?cWJIQmMwVTFhVTVvVzNuUDR0ZDZlUWVPYlYyQ3AzTFdQMnRBdzdZRlpMejZT?=
 =?utf-8?B?emxPQTFPaU5STCtMNktMd2o1cGJJRnk5VFI0KzVSQzEwUGY1TmllRW5RZms2?=
 =?utf-8?B?YjNIYm4zQ0ZNQWhUdkNsVjFWOUZlcmo0VGlzSm8rK1QzWW5jeHNnRFlmN3Rp?=
 =?utf-8?B?Ulg3SXNqSi8zTjFldDZacFgyc2E0Z0YyYTFjcFNlUk9UTXQyNjgwcUV0Rnpi?=
 =?utf-8?B?R3A3ZHR3SHQvNXhCNmZyUTVGUy9UY1U0VE1sbENIdGkyOXR3YTg0MmtWM2Nw?=
 =?utf-8?Q?ptPvL9FvSHJRPA9myldlD11ztdyH8uvTYMXB4IOqUap3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13D0BD0BD9599E40BD505878F280BC84@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6e3057-1922-49dd-f4bd-08db3634fd20
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 00:22:21.5928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xl7Eh+yzS88a5Ydv+YUaifwRYnPNKNzZaBf6efXl3MIRz0Lkx560KO/UVvHPnaSqqTPzyFE7+V2OFIh6vCXhRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6562
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230405_172230_980662_1CB2C366 
X-CRM114-Status: UNSURE (   8.89  )
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

T24gNC81LzIzIDE0OjU3LCBLZWl0aCBCdXNjaCB3cm90ZToNCj4gRnJvbTogS2VpdGggQnVzY2gg
PGtidXNjaEBrZXJuZWwub3JnPg0KPg0KPiBNaXhpbmcgQUVSIEV2ZW50IFR5cGUgYW5kIEV2ZW50
IEluZm8gaGFzIG1hc2tpbmcgY2xhc2hlcy4gSnVzdCBwcmludCB0aGUNCj4gZXZlbnQgdHlwZSwg
YnV0IGFsc28gaW5jbHVkZSB0aGUgZXZlbnQgaW5mbyBvZiB0aGUgQUVSIHJlc3VsdCBpbiB0aGUN
Cj4gdHJhY2UuDQo+DQo+IEZpeGVzOiAwOWJkMWZmNGIxNTE0M2IgKCJudm1lLWNvcmU6IGFkZCBh
c3luYyBldmVudCB0cmFjZSBoZWxwZXIiKQ0KPiBSZXBvcnRlZC1ieTogTmF0ZSBUaG9ybnRvbiA8
bmF0ZS50aG9ybnRvbkBzYW1zdW5nLmNvbT4NCj4gQ2M6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVs
Lm9yZz4NCj4gLS0tDQoNCnRoYW5rcyBmb3IgZml4aW5nIHRoaXMsIGxvb2tzIGdvb2QuDQoNClJl
dmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
DQo=

