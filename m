Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10FDC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 00:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SznyAdJ1RLtjz7yUrqP+u9tHc5FGqQVx742Tmqh7ac0=; b=aGege5Qa50CeSugrBnyU7PxEWP
	uqNwPHGpp4kl8mfe9V4bFN3T42TTmpVYqbOXh387FDJMIOJb3F+TE29pAY64DIShn5Vsjtbbrs7zT
	2QQ8Jfny4HX64lxf2wDhtZDSsgqqRq6+D4dPDRKGnpmA1thbSI0td0u5B7AXhLeKL+F2GYtUaX6cZ
	sntBEVdwkTbcpz2wCfty+UITNuzsLSIYi0RatxqXCAAx5aD3RWRTblOO7iiTrFXNlVwIWEAoeWa3g
	MBwQCLvk0knh2qW6I565u/FQG+2eO2BfkIf2i5Z2Qnou/p311CKWqLh/X2zQZQr9Q3v9ME//KTHUM
	nZutIrXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oujlZ-0064qL-8t; Tue, 15 Nov 2022 00:25:29 +0000
Received: from mail-co1nam11on2061d.outbound.protection.outlook.com ([2a01:111:f400:7eab::61d] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oujlW-0064VW-IX
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 00:25:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNdBJvuxFxzXvD8nKphu9s17erMxUBR/wT7cUfeG0fzdCkEXN3SUhna8PN+hSLgr34te7xPhIAybuamPMEsR8E1jNixZpydAyDlHsdOW6/4aaqFJV3bSDfbvu+ajXeU7064koohqQ82R4bxva3sHlLq0Nl41CLt6nbyMb6tFl3S+Hay6lXqIXHcKCpbPvB1IcHXX06ea9Cmo6pxCFq/SJBrkEt4UeJPZMnthO0mJiS8FnEEmutLvKcg/NRi7ugu7H8sDK/ZwfGU2DAL7UCSR15+ojvbV0Li5A1ZypxeXzuKK9PH8b5fNX5TwsTwYbPpB71cQngHi8uMLbkOGuAF1mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SznyAdJ1RLtjz7yUrqP+u9tHc5FGqQVx742Tmqh7ac0=;
 b=AR3AHYVzlrs8ysv4+QIg90YYl/n0HM8HEyrqDLBeRE2MXM+sUo8PpLiiLxBxAGjJE3tEI5tWKr6GPT7uaWpJ/hp+E0nNMtfEFgnu8omzOpmGirzTqBLTkiVZwRkICEzVW2ssFOIgBWmMfwDtaji1MMjHmMNzJQZNPXifmA7DKmPqZGFtJTzG2c/Y3a2lZ5vEN7rwHDcVJv3AM3NQkGocIgMl/YBc9nwrXJ1WGQijRHbUnrPQJHw7wvJyBTuGpSnY41Fu5PWK6MtEvWROWTfdMF1t+BS7F0uMktzHNegvsudTZ8OZeBp0b91TYyJYeRvs5d1YFHXnJnvGSMPoOoZwCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SznyAdJ1RLtjz7yUrqP+u9tHc5FGqQVx742Tmqh7ac0=;
 b=MMZdAC+kI/LQdFHPf4NHIcbPA0PYeDnvIXKRYqX1R0XkgpmJi2tcd2wPqjsyzIxFE/i3F7vL4ouuQehKPR+0QNDr4BfpCvTrgLARWoBd/Wf1HQzK+PIFABGPioOYQt51P4KavMeFwhAEcmJe2PoXmHC9WGgG5E5E6aLJbq+QhH0YlvWm0afjJl8CoW24A4yEeEhDRTGQYN7Z+2Cnx2+rOnep82cBE1z3i4Nhe2yrCZHlLUQ0eZ01qwnt9+4syCPU5q4qRm8+/X5yK0k3ovmtc1K13clZGU/aubpWO1aNumgaO/GPTSnQvjjN8/yYoDWW/ho0q63V+iIjr3LGQUGRow==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 00:25:21 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 00:25:20 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] tests/nvme: Add admin-passthru+reset race test
Thread-Topic: [PATCH] tests/nvme: Add admin-passthru+reset race test
Thread-Index: AQHY+GjASN57a3SV40SqcdHFoqxDK64/IKsA
Date: Tue, 15 Nov 2022 00:25:20 +0000
Message-ID: <bb0cec9a-693e-8fd9-b521-8c23a7ff2ce5@nvidia.com>
References: <20221114203412.383-1-jonathan.derrick@linux.dev>
In-Reply-To: <20221114203412.383-1-jonathan.derrick@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH0PR12MB5607:EE_
x-ms-office365-filtering-correlation-id: 91f7f0a8-9a6e-48f5-0075-08dac69fe12f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  Mvp2hiaIanKYv6m74ikQ8X82tMNkoGh/ZBzRdaB4p9Jk8lOVoETzQ9cgItGt3+slI29ceo7Q69v69vg4UGNAMDCqNMQfxJTn1xrLlglrwIyX8jPMcD3cSAeMpQzJQZX1Zxqq6jZDZ6RLyQvh8l+QhUT/deeN+Qz36uEQkj682f0cd6LxHw0DWLsiJrWPmONQIktfU0J+3IVVs6zKrY5xHOOqu3yA49+axJDgC7PIVjnPbNvVPtPKatZR4FduCAs0Zp50OCLF3QETRsTneZFWUae50FeJ7MjI2O34x969nWS+Xj8ZcCPMeWrvNoaUSlw9iSOjKiJ/5xCra4etWpAE/OChbAsnHhgT/GRTLHJqh5w2K/VymSTsr/unlH1IY1/AjTDiUVYmRwPAggOceCZH8spSPfUsJsYCpStcMaynfNX04Kpjb2GuaSpWz6CBo+DY/BEbOXY6P/Z05svK/yMGssCfi2+KBAzWV1faGRjPa0i1l92X/akmmR1FuXo55bNHbF1vSt5uUaTFGQltrrPmUfUEjLa5VXmDGAQPfjoY+2tydjOsYXvRQQ0ECManN1/g0sLZZNo996ZMCXF5knpN/eKcwhvldxsN3kEmef2EVNK+nSyBNc2gID5fTK1cOkNInWE5+bbMmB2kBYqYkqAVcnrHplje201uIpsV5hpb0YGFu6HPz0n1u+59tNRW4zALkcENFeK6yAkQjTTvYwbkmfck83AQz4qEDI4LJI0JG04XqsUV3LTaUgSRLWMt+t+5zbvkM0fcTHFutVeNWA8RJ5OG/Hf4y0AQAd5XszTRGE5eppGrO5oGGpPfRXCRqGi4xHX/faHCPisxjUvoXkYzEXGNkXl1b3C9erYppv+vYPzMAT6PexvrPc81dH/I6g3Bf2dfQQr0zRaLrJZS3ftdlh8AG7CIHUImuDRT/eMDUC8=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199015)(31686004)(71200400001)(53546011)(6506007)(478600001)(6512007)(66446008)(66476007)(41300700001)(66556008)(66946007)(64756008)(36756003)(91956017)(76116006)(8676002)(2616005)(186003)(6916009)(316002)(966005)(6486002)(4744005)(8936002)(38100700002)(5660300002)(38070700005)(86362001)(122000001)(31696002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?TWhaODVJVTFUTXJ4Vzg2MC9mWXNsR0ZUNmF0ZDVNNU5XaS9LbWhXZmc5ekJ0?=
 =?utf-8?B?b29NejJHa0p0T2FkYSt4eDdUNnJ6MEtmRWMyUXJJQnpuc2ZCai9KeTFCb2RN?=
 =?utf-8?B?c0sxeWNsOU5qRjZGVjRERGpkOTRlUVlJOHIwMlNNU0VORlJnbGl5OVB0RTZy?=
 =?utf-8?B?d2ZQTzl3YVpRekF4UkwrTmFPUXpNQUp3UmNoWmFkK0sxTGZDN0xMQWhza0FT?=
 =?utf-8?B?NzNnQjNKWVNzUkJSMHdBVUlCZW91RkpjUjJ3QndtdjZPOWFwNnhoNnR6c0NC?=
 =?utf-8?B?cUJaa0l5eTB1NGl2dVNmQ2ZzMDdacy9LcExhcEQyMVJNditnTHRlUFBIRHhw?=
 =?utf-8?B?T0l6M1JGTk9EQVRvYnpvT3gyVEFwNG14dzlkVk54ZEd5MHRQS21iUzdWUE9k?=
 =?utf-8?B?em9EWnBha3A2TS8xb09OWDZudExpWVhiTDFSVHByTGtRYjBsWHJEUGIyU0dI?=
 =?utf-8?B?eVZqODJMa0FlL1poRHFHS1laTmp1dWNOWVRrNXc2bXVZT3Uydldseld2c3RF?=
 =?utf-8?B?Y2MwUFVyaFl5aHNEWmRFRmN0cmJZMFZIRmZhb3E1YWd6bjUrR1prVE5LZVUx?=
 =?utf-8?B?aVZrSWFhY1NuemlRa0hXa2dJbG5RakR6WTBUTmM0RzFXNzZQTGFGREhOWTBT?=
 =?utf-8?B?bmJQMmIyS04vUmJuRUNJbnQvU3ZJQWNCT2JWeG1nTDkwdXpvaEpIS3V5VndD?=
 =?utf-8?B?SXFNb2dYbjdxSVRFeFlyMzVURThuQXBuYTdKd0U3UWFuYnhjTDRWYVNLbm42?=
 =?utf-8?B?KysydnptbW5WajFaYUNiS2NXQ0lBdlFWdDlBdDMxaFlhY1BRbFpnVmdCYjRI?=
 =?utf-8?B?VmM4cFRXcGJGRjZMSGFsVEw4TnZUTzBJdzBXbUxxRmJvcCtHRUV1WEg0ZmpZ?=
 =?utf-8?B?ZDBkMnJaMHJEYmtaNjdNKzYyZi81OFJqMjdpZVp4WWc1a0ZhaURjZlRueWl4?=
 =?utf-8?B?cDJsczhCNmlJUWRiYUV1bWNnZjlHdktXYTdKZk9UUFBzNktrc3oyeWV4S3N0?=
 =?utf-8?B?dzlvWmRvMXlZT3FmVUZaa2pVS3BxZUM5MmoyYTVKWi8zVU5ubjU2UDN5dEhT?=
 =?utf-8?B?QlZUZ2JjOGJtZ2NCaldYMmxKbVRERlRQZitTeGVqSkp2MkdzdDNKTVEzemU5?=
 =?utf-8?B?elFPNnlMYVUrRENGRjZCSHdXc0QzR0lFSTMrK2c1ZTBTY3VPTjFyN210NEtC?=
 =?utf-8?B?Z0Z0aDZxeCsyQUFXbVBvaEtkbi9xMjFVekUvQVdjZ0Y2QjJ0bXlrMWNRYlB6?=
 =?utf-8?B?b25YZmRwdzd2ZERISUxMU2pZREhmQ2FlUTFwNlZLcFlnZENVWGdTT2lJNjhi?=
 =?utf-8?B?YUtLRlJ0SE1qejVIYlpZakJmdGJ3WVdmR1hka2JaS2VWNkJTWEE1UGpTRlRX?=
 =?utf-8?B?TzVZVGs2SXpvUEozdlljR3JuNEg4ZnJ1MlhwWnN4czVMYVE2L2VCK25SeXVt?=
 =?utf-8?B?OTVnZ2VUNkdDeWpDS2U3WUV2UVk4YVBGQlFOdWlweEdvYm1Sd05TRDI4d1VN?=
 =?utf-8?B?Nko0TkEvUkhuS1g2NWZScDY5Z3c0U0dQQklSTmVvTEduN2J0QTE4RTIwWDBT?=
 =?utf-8?B?TG5JYWQrOTdHaDNLbFlWWk4yOTZBNU9lbFlLUi9kQ1ByYzRML2lzdkFVSVdS?=
 =?utf-8?B?TDkxc2E0R09VeGlrNGhXN0JhQmNMTG91Sk9MNzBaSFhlZkh1bUpqNUdFUW5X?=
 =?utf-8?B?VFZoTUxzQjBqdU9pUFlRQ2tnOUozbU4rVmlIWlFKQmdLMGhHYnBySFR5SFYw?=
 =?utf-8?B?Z1FaQU0vbnEvLzVMT1FkZUFhMTQxcy8xZjZBbjI3L0pDbWw0ajJxdDhvVWZu?=
 =?utf-8?B?L0tyanNjVWJ5aE0xM0wrY2xkVllKQUt4bk15amdaa25KWnFQdkM4a2dZQmhQ?=
 =?utf-8?B?UGc4ZWFrODI5NEtsbStLSFY2U0VHWktUMThBbWRLcGIxNzMrekorVlY2QXR5?=
 =?utf-8?B?aXowZVZMUU1ZUzNtQVpxcUN3ejVqSkwvZFluclRWTmo1Y1diSm82czl1ZHBG?=
 =?utf-8?B?M1NWMmNBQlpIOHluclM5c0c4MTRqdHpYenJLUk9mN3YyTXoyMCtzL0dyb283?=
 =?utf-8?B?YVdpOXJiWmxHV1U5UU40NjRQdTg2SndXaVlhUzB6SUxpekdxNHlBdW56RUs1?=
 =?utf-8?B?V0JCY1p6L0FTL0FMditaM0NZSWFZOEtnRy9YTnVUbFZzWEt0VW1INHNVZmgz?=
 =?utf-8?Q?w3+r0i5un7yasJDPaBDv242Zr0nigLaBq2gRlKixkVbt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F1E56E87F8F1F4FBC3CDF6A22DA89E7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f7f0a8-9a6e-48f5-0075-08dac69fe12f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 00:25:20.6087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aEEOEMv8al1n0b7Tpd+ZW9V3iuRgSPWAiNqfWaFdydCUNBXZd4HpSPokBrLhfieMqAt/IbMRT67H6puf1fhTyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_162526_634608_35BA078B 
X-CRM114-Status: GOOD (  11.47  )
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

T24gMTEvMTQvMjIgMTI6MzQsIEpvbmF0aGFuIERlcnJpY2sgd3JvdGU6DQo+IEFkZHMgYSB0ZXN0
IHdoaWNoIHJ1bnMgbWFueSBmb3JtYXRzIGFuZCByZXNldF9jb250cm9sbGVycyBpbiBwYXJhbGxl
bC4NCj4gVGhlIGludGVudCBpcyB0byBleHBvc2UgdGltaW5nIGhvbGVzIGluIHRoZSBjb250cm9s
bGVyIHN0YXRlIG1hY2hpbmUNCj4gd2hpY2ggd2lsbCBsZWFkIHRvIGh1bmcgdGFzayB0aW1pbmcg
YW5kIHRoZSBjb250cm9sbGVyIGJlY29taW5nDQo+IHVuYXZhaWxhYmxlLg0KPiANCj4gUmVwb3J0
ZWQgYnkgaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTYzNTQN
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIERlcnJpY2sgPGpvbmF0aGFuLmRlcnJpY2tA
bGludXguZGV2Pg0KPiAtLS0NCg0KVGhhbmtzIGEgbG90IGZvciBzdWJtaXR0aW5nIHRoaXMsIGl0
IGlzIHJlYWxseSB1c2VmdWwuLi4NCg0KT3ZlcmFsbCBpdCBsb29rcyBnb29kLg0KDQpSZXZpZXdl
ZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg==

