Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2ADC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 11:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/8OkLgd3NRk2srdHzcUQe65wu7haX9+aG1SPK65Uabs=; b=l5Luni3S6gH1IUCg3z+ye1tUkM
	9R4x2imnqTzLEsr77oKJb+kzUDVwWbbn3mAQQqeHpdwzLmcNKkmkGnjDONGmkFmqouDPbItx5Q0mP
	rgmgNMGG5vSV6VTs00P2JgdNLpfV2u/XAvxChUaKl/gj+BxphCbWCVPH65rY2HBMsCcGM5/W+M17t
	BVHAemA6uiz29CBhhVfT4Ezm0FpTxWAcvaaSqtH0oW4gY/Nn7WGNGG2R2U9hTUwMBX2LCqt8W8LIU
	68BLt4PpbWhGYpf/yoho4foT31lAGslyMDC46/5rngC+Eq8jh33AQAvTetbbGEYts1QU6AWtwqfAG
	i+mYNK9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndrrM-008ZrW-5y; Mon, 11 Apr 2022 11:05:28 +0000
Received: from mail-mw2nam10on20602.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::602]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndrrJ-008Zqj-1L
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 11:05:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRyKS2/X7/0IbP03pXpEIF0YTdVZxEs1LGsE2SdGpXL2I/JJ3PyW/5BOFlErhQ2G/6KzuNRm2VNokQoQqsMHzZCih9s2zjcJurn7tHxE5fJvbzX9/p/P56SqbA3ngj96rZCC4xhQriI8T9EbAFLcOAJlPtuQv1Em1pHiFzV9sLVm/cpJCi97OYMpYptNbmW3zmo9zphan7f8KNTP4+wyvpSEbhgXc7PQV/KUu9+bGcfpA5nnzoH/23wcvm+k4vP1+FN8xCdOxmouKwOl6ssTT2ptV0cghfHwtB4bwnbWORFySNe/89xq7r6JKGF/rVl87mOH1CPcjMlYEL/8rhSy/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8OkLgd3NRk2srdHzcUQe65wu7haX9+aG1SPK65Uabs=;
 b=IdY9apSoE8CWKtwTALp8lNGXRCociPXUzZuSQzGW70drP+aDshYfM6byzKMmEVBeujSsbthqij+azoqLn1+9TfSj+FC+35hReU5cW7mfbvl3JMSwbyEXePljXFZhwjKAMfDl7DUSmEakH3IgmtSA0ejEE+ria8OqB5m7Psq/3FAwq35EjMeSX3Qq1rsw9XYJRL9kZITcR08zGx3Y/WluYX06NyJCoBxymTZvJEl3BOpsBIwxpEzI11eBf+cCx1s1BDcnP4PmpDmRozIJ6g5qKHXW/cx4dKc0PTBq8xIvqRkLiOe3qKzZOQ+FQl7l6zvySfbDZdlthAf8R4znxKVOjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8OkLgd3NRk2srdHzcUQe65wu7haX9+aG1SPK65Uabs=;
 b=MdYpsnRGdWSjZXsQcPRwgoPeW1nt7Bi8Af8J2IUZ+xpI+COLdtqc5TgtvPukQzo6Je9fQwGE8gS6qlWBnvFpainFGVvzd3du8llVzfGSe6QD3NxS5+KyXKLc8oijKScwgC/QhCCuZKkSaxLmOlHq2Sngs3EhYAt61JJqSTQO1+W9VaQnT7w2Dv/OmKabPXq8xNbETnajkC0CCKPMPcaXrA0ImB1cpo3yOo27LUU+wVEoyX58kaabBPnmT/DSrIAZ6ypVW+fWp75M59llopWTxpjcZxZsfd40qg8QzHlaphYbbowdqinWedLVAVMyMzHcXw31HXX6TPqkk+L5FKhONg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR1201MB0042.namprd12.prod.outlook.com (2603:10b6:4:50::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 10:49:40 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 10:49:40 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH 2/3] nvme-core: don't check non-mdts for disc ctrl
Thread-Topic: [PATCH 2/3] nvme-core: don't check non-mdts for disc ctrl
Thread-Index: AQHYTVIa6YR5KcbjpkWDxqSgwxqmEKzqO8CAgABHEQCAAAY7AA==
Date: Mon, 11 Apr 2022 10:49:40 +0000
Message-ID: <b5dd1bb3-e001-ac66-d461-4d699a2dadd6@nvidia.com>
References: <20220411031249.5158-1-kch@nvidia.com>
 <20220411031249.5158-3-kch@nvidia.com> <20220411061301.GB14797@lst.de>
 <34d61434-27cd-f918-a3bc-fdca3196ef99@grimberg.me>
In-Reply-To: <34d61434-27cd-f918-a3bc-fdca3196ef99@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95be21cd-4699-46f5-d85e-08da1ba8fae7
x-ms-traffictypediagnostic: DM5PR1201MB0042:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB0042F5CC3B8A4C81EB8B9BE0A3EA9@DM5PR1201MB0042.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4/JZBbayU/FJIB1P1MZ2tCww+ej0EQiCR3AjDHKmUqhMof4omo0dVZQoXsnW7QkEi943PZ3YwJqjx/KtN8BIBs5PmVE7Vk7E2CYO1X9piB7jCljV82Pv8sMIxElrYL0JfxufKeMETHKHfUAog+BOoe7pboDPv9T3DwxqqrRNwA7GA/qQlwilMbC3vEOwUo9AR0XhTN3pVfEdAeQEGQPQSJJtS2lHPROvrTARrXaiRlHxqdlOp+1miPQ3DNPoYW9D+aiPYneasFTg1jLdntsFtepNnx+L62WIa8rpCxyvAMeof07NExiB0GmCuaIldtQ4YXNe5LJtp/7Qate3xzVfpfYqJGuADqMq57yAtIT0Woa5d49q0KloQwiZWq4UlVRWKI0/1n8Xk8+SdWgjCz+719UpG1evQlz7/+vsnkT/AOImcHNXjoQtESnyi+1evE2L7jgBdSnkOl7eHWdGyyF1n6XSFGynC5xQ5+jZZMbQ+D3rETZPeHD4he5/iGiK6p8DfOoSgclkLcGaiuY54mUJ+sTjjZUE98lE7f3tGXZGpByeit2aRakQx6qto3mt3n19G6qpNfTQ7+Vz0dh5bL6TpqNTwXXcoM97z8EBFExytlr3kqd9ox3sKSJnFpHGpzJmMWCRHKIji6SUU8EUf9IW6BAd20lwgkACidXexrbvq5CGb/l/dUiPfWBxMXuBZNdLCdxIDrZMYiV6eBx1INj+6S63nowZ8noQ6sHpnS8BWh7q+0DfgEZLiIdEk6v/CCLQYI5lkuIYr/mk+Nr8Qgwvow==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(186003)(2906002)(66946007)(76116006)(31686004)(83380400001)(86362001)(4326008)(66476007)(2616005)(66446008)(64756008)(66556008)(122000001)(508600001)(38100700002)(36756003)(71200400001)(91956017)(316002)(31696002)(54906003)(110136005)(5660300002)(558084003)(8936002)(6506007)(6512007)(6486002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVFiTFhRbklXMFAxL3Uxa0VOVWxpVjgxbFV3c0ZLbk8yUnhmYUdNMEtrOUZj?=
 =?utf-8?B?dS9hbkVLMjNKTmxjbUV3K3VpNHh4U2pvK2NFSk5Qa0FwQVBCRWs4eDN0c1dQ?=
 =?utf-8?B?QTE0RzFJRlJqSkdJbDZKZFJ3SnZqVTVoQksvbHY1VlVONHZIK3J5VTN1SGVx?=
 =?utf-8?B?K2hJc3pEblNwQnNMR0YyWkNZQkdwZklxUGZvZzRjcDI0bUVDRENkYXVscE1N?=
 =?utf-8?B?VE9hUzhTWEh6UWtkS0pna2hGQ0JVN1JpQ1B0emlOajliR0RDbzdQRlRlS2lX?=
 =?utf-8?B?S2JMcEdHRjY4Qy9ka21mazRzcjkxaWh0TjBBcFdtY1NUOTl3Vk1PRWgyc2dV?=
 =?utf-8?B?WVVHaEJxSTJGczl0RkY5UGlwdERBdmF2dXp6Z3ZyQUg4N1dtZk84U1lXSER0?=
 =?utf-8?B?dTVCK0xHTXUvYm1XdURrd2JqRGdXZEpQTmFQWDg5S2FuZmR6TmFqakxQRVNs?=
 =?utf-8?B?WUkrRXBZeHoxWjBUdnpWWUZKa2NxK0szZjUxaHowekhLdTEvdEJ6a1c3TS80?=
 =?utf-8?B?QjdkWXZkaUZJTDJxU0dPbTIxeXRsc2F6UGJaZkxLZlphcWxWekh6S09zOVNQ?=
 =?utf-8?B?SUVZSGYvdzMrQVJ6bnpJWlQ4RVhXaDdiamRoYnJ3R1NxdVhiSkJpU2tiWmFT?=
 =?utf-8?B?bnd0ajZrUFFnYW9KSUduU3l3dEZVNU5WcTc4eC9MN2IxUWNLL2dkVW5CNEhT?=
 =?utf-8?B?TnVTV293TjkwYnJGRy9zaEFNTXUzNzBxWjU2d0lFdXZBQTBWVWxZVFkvaSto?=
 =?utf-8?B?MkJYVW5kSjlZTGx2dG9MbUkzNmh5QUkwc2Jhc01QL0Z4RktHUnhuVURSUFkr?=
 =?utf-8?B?NlA0cXpnRlppM0FBQWtuOGUzR1IyeDRRSWsxU0t3TitGWUxYMEVTQXNzaFJw?=
 =?utf-8?B?R3l1S2g3SlNrQlFBK2VyQk1rWEhWTlhTRDRSaVp0SGVDOThVL2M3YktEZnVh?=
 =?utf-8?B?VUpBR09HSW9xazhXTDBxYTZ2enJMZ2s0RUo5d09KQmxJbkJRYWhydVJtNnhQ?=
 =?utf-8?B?ajZvUjl4NGdVTEFINUpUUURwSHdYT3F4UUd2Q0s4aGJyUm4xcFFwZk1taEpN?=
 =?utf-8?B?a1NxTzFzdE9ZQUJuUTZidnppbEp4dVpWQ2pEdWNmVTZKU0dCWjNpMXFsb1JJ?=
 =?utf-8?B?TGF0Q3hjM0tNRy9HS2lWYzl1WmdnMjZteXZrK2o1b2dqNzNIQW10Zm51amFC?=
 =?utf-8?B?RTdESitJNzAxRVVWbmRVdW4yMEY1MU9LVmYzZGFyamQxTjJuaGphWjVqY3lB?=
 =?utf-8?B?RHk5Uzl3dGI0bkt6Nko3NFNBOS9meWl4b0g1Y0NtUWJxOGtlVFVGaGZoL0FS?=
 =?utf-8?B?R0pYRXoxOUZrWmtpVU1LbVM3R3htTDdWQ3FrVzhVUlhvZHBWdWpNYUNqL0Vs?=
 =?utf-8?B?ak1oQ0tuVGNGYUFQd0o0R2FkQmlxRi9lWENHOWhkSDBHcmYvUVFyNGdjNzM3?=
 =?utf-8?B?VHoxRGdpVmVSS2JKY0c2UW5LQlozdTJVaDIxV3hiNkhBNWlETnRJWThGeVQz?=
 =?utf-8?B?eitYMDRORkpDQUVOSXBjbTh2RnV6SENNUnNhUEtocWdjS2pvby90dG8rN1hi?=
 =?utf-8?B?RXBqaHI1WU8vZ1gyR0FJb1NPRldzUy9kaGorQ0huRlJSeWY5bmlKd1ZhTWFD?=
 =?utf-8?B?RmtscUlMV29lbDhwak1WL2FvTGU5eU9BbEcxanR4UXAzMGpKV0xuWnFRd05y?=
 =?utf-8?B?NWZEM3BVbXVqVDFLcDBwTDBxcTFiYnNwbVZDTWVDSmNzNWRxam03NGRnQjQy?=
 =?utf-8?B?ejNzRHJCa2VXbU50aERTWnhLV0dSSWE5RnlhYjVjdjd6eExKb0VLM3lldk9C?=
 =?utf-8?B?VTE3UU5CRERRR1crMFg5MDZXck05b1dkSjdXR3RsNlNmVEpzK2J2SVdWT2Zr?=
 =?utf-8?B?cFR3bnpodDVkNTdlenhMTkFCRWR0UnVxVEV4eWwyaEt0ZnBtM2xDSWdCU2hB?=
 =?utf-8?B?K2xabTR2OWU5MTJkSVpZWW1acFdGbkNmNHdQRmE3V3BxOWtIc0R5L3BOeFpV?=
 =?utf-8?B?NzVzQWpQNDVxL3RTNnRtdzBhbWFpdkRoNzFjaTBwSkdrSjQvRTVmdWtTbjlF?=
 =?utf-8?B?STVOYVNHb2xINFlQMGM2UCtLSUFQOTlUMnB4N0ZobUdOVXhlNFlmbVJycTcy?=
 =?utf-8?B?Y2hwNVUwbEZsakQrWWhwSnZZVXFXbHZPaXRmNXV4VmlTS216S3pLQm9qYVRE?=
 =?utf-8?B?UGpCcFR3YzBWUGtXS1dPYzVvY0lsRmJhYmExOHI0Qkk3aVYzNnBrYzBoZFB6?=
 =?utf-8?B?ZkxxWXo2WlpobG92aVFwb1NNNGNwa2ZzTTRSTzJyQXNObkhuUDgzcUx5b2Ra?=
 =?utf-8?B?aXdraFJTZ0UvM2lHZENGaEI4eDFmV2NIZTE0byt5dm1RY3BMRGorSUl5Qmwx?=
 =?utf-8?Q?uSUjV+4/Nm2jW6rt1R6n8FhXi+kjmrUbvXOuJz/zRO3k6?=
x-ms-exchange-antispam-messagedata-1: HLv75eODFahM4A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CF7F1103CE8F84A99D8514F6CABCA13@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95be21cd-4699-46f5-d85e-08da1ba8fae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 10:49:40.3050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XyhMtsRReDTk8XJA0GFqnkX4DaMEyhtzgk0TDiDq/0uCofoKXZErxE13Ngil+ZP91GbLVUv6FSzzf5fxAKWQ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0042
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220411_040525_112752_29156245 
X-CRM114-Status: UNSURE (   9.33  )
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

Pj4gSSB0aGluayB3ZSBjYW4gc2tpcCB0aGUgd2hvbGUgY2FsbCB0byBudm1lX2luaXRfbm9uX21k
dHNfbGltaXRzIGluIHRoaXMNCj4+IGNhc2UuwqAgQW5kIHdlIHNob3VsZCBwcm9iYWJseSBrZXkg
aXQgb2ZmIGhhdmluZyBJL08gcXVldWVzIHRvIGFsc28NCj4+IGNvdmVyIGFkbWluaXN0cmF0aXZl
IGNvbnRyb2xsZXJzLg0KPiANCj4gSSdkIGFsc28gbW92ZSB0aGlzIGNoZWNrIHRvIHRoZSBjYWxs
LXNpdGUgaW5zdGVhZCBvZiB3aGVyZSBpdCBpcyBub3cuDQoNCk9rYXksIEknbGwgYWRkIGl0IHRv
IFYyLg0KDQotY2sNCg0KDQo=

