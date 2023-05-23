Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312E7C77B75
	for <linux-nvme@archiver.kernel.org>; Tue, 23 May 2023 08:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6v6BQjxbNM8P3Rnz7vsO2gCaH5N+AhghE1VsAW1kJPM=; b=wVEbqgu2cW8K50866PTQGLL33q
	AZP/XBxmABp/dEV9kzxLXE/152T9r80OeGQ5qD2Tdg1TVHyNIsAx++m3vQ0Oia9x6i9vgz+52vBRN
	KQyJxs+az4UMaGWOsI5WLSLVjg8v0NvkgHIrsgcUmG0SrQzM2LjYDyks9oK0g2wzdA9/i8fXn3MLE
	9wuCqfSFyo2UKGgnUNb7//kOauutUJIpd092PzcNO/Q87LjhC3RXrYAEOQIuEOQl+R/bTGkpag74T
	p+xJrMG8d6MvQ/FfaE3hlA4cYcLZXG/sIZQ0enP6ubG7VVTRMESzfdZ12mYmRULpeEvRKTc0USfPa
	35zKtGUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1NSi-009S0k-2R;
	Tue, 23 May 2023 08:33:44 +0000
Received: from mail-co1nam11on20630.outbound.protection.outlook.com ([2a01:111:f400:7eab::630] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1NSg-009Ryv-0I
	for linux-nvme@lists.infradead.org;
	Tue, 23 May 2023 08:33:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdJmOJg3rhuzgrQ/H9zM5iPgaFDFus0Qai6zB3eitsw6z9CY8Taw5RVxVr2NOoyuI3Wss/ZgQEIqc7cVnrDWfdoCH21iEk8608i3zwcJhe4agnPOo87tzMgWH2Q031jHexF/dK36lLwMQRAkp8zP4rhBm2DD03kISxaJJBdaqLxC9nAlpok+ikCDGaygGdDQEnmZ8ylVV72fK0QYTZizMkd472lbW04H4QM3CPSG9S8y+KFc9XpWCaDlejM0S8laG5iQEQ6PPvH80tuAn2PKMQ/b3Gpgs/TlYIJfG1xPwAalpzYthVFyqim+qibRdbsRWTzs4r/tlF6jwaODbV+HMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6v6BQjxbNM8P3Rnz7vsO2gCaH5N+AhghE1VsAW1kJPM=;
 b=VAai4x/5M7frPRZkAm9VzkpnI1+iFewghMhFztT/3I2v41T2AJLiSxnLCkIdRUEBHUzIuOz0BH3zcAjzGTw25/KBAxebE0Jx+WGL6uodkOmqNQAfqob/fNVKstEGSrcYQwuzCusWX+qeeg9jxHLK1iNiaJnss1oH5aKlZLtckvZG9MbCtldnet47WcPAMhWLWqMij2pM6cGwprRcdaTHg5LRkOBlaYwR0aRkRXbdJO8FUg/+rhNih970Ea6hWkrwFrZXzYqL9bp/CNh6GqsBAgh1jsQqNEKCxIKc5ifJHKtZZhFHYoeylDZ9q7zNgs5rMBZylfXv8AnAiklSAFWKeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6v6BQjxbNM8P3Rnz7vsO2gCaH5N+AhghE1VsAW1kJPM=;
 b=C6QK7uY/EEtjFivG0QYLkvv+sRTRxVWypBGh0M6VQjPX1Y16B1CUChD3kqNK7/y7GYDD4i2CsP5uMh3UJ3/ZDSqY4BmLYAjHjyJpNm8dlo3330Mu3DUswoTW1/xc97G4CmlqNDIASjn471nOh2UCzHQWHENW5yynEndg0wc76UBoIQ/V4QdHXkfARspEzp+F+OTdT5BgNJhqknTOu7+jFv4hJUeimjDAeiWPIZO0i/NvSpSlwevQ6aVJiqXPZMEW9uEWIsfEmM33o2nFUv17o7N6SvmcdTvYHut6l2o0Vi+6mepVIzStIXCdHTVRE32xVBYCPo46p+rq0SpFLDQOpQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 08:33:33 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 08:33:33 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "hare@suse.de" <hare@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 3/3] nvmet-auth: use helper for auth send/recv cmd prep
Thread-Topic: [PATCH 3/3] nvmet-auth: use helper for auth send/recv cmd prep
Thread-Index: AQHZjIi9abiHYUBXfEOYgL30fPTn169nbnOAgAAbAIA=
Date: Tue, 23 May 2023 08:33:33 +0000
Message-ID: <93731122-23a3-0321-74ad-4b4af63b2fef@nvidia.com>
References: <20230522083713.107001-1-kch@nvidia.com>
 <20230522083713.107001-4-kch@nvidia.com> <20230523065655.GC8224@lst.de>
In-Reply-To: <20230523065655.GC8224@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CYYPR12MB8750:EE_
x-ms-office365-filtering-correlation-id: abb2c11e-6e02-4c02-19d8-08db5b686510
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q7iwNelfM9aovKDA7jq6IuVSi1AHF7DzBYODqEVfPMVUI2FApuE2Ab2ZliG4GFjAKuWWXGS/Gw02DSeqluZQiDvMRQ0jaeHfIOGBGnnV1Gw32v5hnuSTxL2/mWN8ZV6y8Xh+uKrTspex+v8aEL86mSh7DJ1PjFzUvenPVxV3j42VfrRx19BO/XLaz9yg1aNUhuxRjPwX+KIxeiZm6Z+P4OgZguwJInDYkx0ksGCDsd7ONrn9wkVI35iUp60h0Rgj0d3qR0n0HrH8QVpmrw/wAw8yAjQvXumS9vM0EmTHf+cMvIsGqIempcPxGftDlTexGBcwoaz+zgwMFAFC1E1MtoH0oEdu3AqOasfnAzoF5WX2sws7I1MhWyIeVtQ3ObIucQMCbXvMkSg5Nymx7EoHczW8mqBRSQ5ey3zDe+PX9HK94syEl9K/14WtiRRhlIMFIkNjImypfu0O5E815ukyjj2TRsHM8Y7fl1XJQ0s/EqB83gD41KLGax03ylPOcBldwB7JRBp9PnCNBvKCghRfrCu48kEdflEi0/v80bXHl6UJ2ua8Z78PidlyDmo9wIS4b5I/l3h1ySWl/3MoVVLK2WUooPI5fGOFcDcZmWUqNU1c0pYuf4OwFwb9WXRgkMRhuSXbugXdOpLJRH5uNfinUtHM7DhaZ4H+dosPqtqjzUk7yZVG1VAM677J5zuKYuh6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199021)(38070700005)(31686004)(6506007)(6512007)(53546011)(41300700001)(186003)(8936002)(8676002)(2616005)(5660300002)(316002)(86362001)(36756003)(54906003)(110136005)(38100700002)(66446008)(66476007)(64756008)(66946007)(76116006)(4326008)(31696002)(66556008)(122000001)(91956017)(6486002)(478600001)(71200400001)(2906002)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGJEcWcvSGhaT3hPWTZieXdjOHhpZ2pib2c5dXgwaytwMFlyVGhEcjhtaDdu?=
 =?utf-8?B?NUUxaUxubi9iamx3NVdGNUVPS2R6VVdkQWRJUXhrNWVZQnY3Tk5zMGYxOW1D?=
 =?utf-8?B?TGxkaDFyNG1XMXE1VHBFWCsxV2N1blNpOW5iaG15bXdVRnZoTGVjZWkxQnR3?=
 =?utf-8?B?WWE4UERnVjMvTEFhMXIxbE9VZ1hjM0VhMmJYdFNTNEd5WDVhZWxBS3JVSHFU?=
 =?utf-8?B?K2xDQXptV1JkSjI4N0hvOWdneDN4WGNEV2puQTluNmJMVTIrU1ZyR1VGK2lL?=
 =?utf-8?B?elhWcnUxY3lLa1pUalduQUw0K3d0VHYyb2RWaXIyRHR0ZDVaVEQzdzNmV0py?=
 =?utf-8?B?YTJzTEhHaEt1OGI4UjNBZUlWYW9YejI3UERLL014dml2UWQwandFMnllS29y?=
 =?utf-8?B?cElCcUd5MUFRaWVxOWNiakVDcUlhWGFCak5FOHFQVm9JWHdQbmYvYjFiSkRt?=
 =?utf-8?B?aWQyc1lCY0QxelpUQ2VXRnk4STlKOTh5cHJkNll6MktoTFJmZittOWJ1UjJ2?=
 =?utf-8?B?N2I1amRIcjQ0SXBTbHZwWmRGM0d3eUEwZnpZOENIU3R5UmpTdXE4bmlUNGda?=
 =?utf-8?B?QjdMOXNKdHZTVWMra29taUlXWjA0OHBWdi9KbzRoTUpuUXRJRXgzeSswbkY2?=
 =?utf-8?B?QlZWMWdUZ0FNRkJTS0JiNVdTMVZMQzZwMG8xeFhwVGczZ1Jsbm50WnY4bGtj?=
 =?utf-8?B?QU9HcVlEVDhSRXY1cnJxTDEyWThVd2RnT3JEcVFkcUo4LzNKOThiYm1qdTht?=
 =?utf-8?B?cnp0S3crOXRGTk8xSW5xOGV0SXcyNzBpbE83Vkk5R0tYWG5IRTJZVTJ5RW03?=
 =?utf-8?B?bjRUUjI4bXpLSmMwaldya1dMQjNvSnhLNzZiZXhGQ1g5azNvb1V2TDQ4bnNh?=
 =?utf-8?B?UDVYSzF5L2FEdk5hL0Z4NWhleXBVc3NMWGVlQjNrSlRmZE5TWTB1WHVlek5H?=
 =?utf-8?B?LzNQWWV2S2ozV2xOSFJvYXdNT0hRc1M2TkpRTWJuZUEzSzlZS0pIT1h4azBv?=
 =?utf-8?B?ZEtld01KSmp1YXpZaElhMnFuUFJ3Wkx4VUk5V1lJdU95d0Z6OGtpUVVsNlpM?=
 =?utf-8?B?NHU5Q1JSaGJjRXVycFdDK3dPSy9LU3d5L3hSYmFmQU5ZSFpCVGJxdUUzNlM1?=
 =?utf-8?B?M2xVZjNneGNtaUY1WnJFZFJwQzN6Zmx6bHg0VmpIak50eXZUam5JVTd1YVU5?=
 =?utf-8?B?bzFKQkVWWDI3aWFoVXU5V2IzUTlCL1lEd0VPNTFtWjNGRHNNdUlSQlU3UDFR?=
 =?utf-8?B?dXJNT05LRHB5Um1ua05NVVhlcHd1TDVFbVZidE14UkhvM3hPZEVtZ0JsR2VF?=
 =?utf-8?B?N1U4WEJrVnRxeDJQSUw0S2NmQTBPNkZPbGVBci9vTy9rbEFxQkJlbGlaWnh2?=
 =?utf-8?B?TmptTkNmYk82TW1SZ1g3SndERmhFMk5HTzkrNFZmRTJmRWZRNXA3RFdRVkkv?=
 =?utf-8?B?M2FBTGpDZ09PNS9hSzBubnFFY2IrUlZEc3lLbSt6R2pBY2pkdGZIUUFRY3lE?=
 =?utf-8?B?NWpvTDk0OHoxV1c2bXJpMi9kNEpaNWNhMFN0eFkwQWY2ZzU5R2ZsQ01IVm45?=
 =?utf-8?B?cmxNTTdESUNKbnhDWXFZWXFoK2lmVTRXT0ZPeDJUcjhCYUZsL3JGSFBhU1Nm?=
 =?utf-8?B?UnFmQnh1REVWNTlCSHdjYnV4M3JpZnJwcGZrcFdWVkdieW0vckRidGtnZVpK?=
 =?utf-8?B?eGtkd3ppMm1Za0ZReGI3Nk9WT1l1OFNLZ1dmR1RRNysyVDN2T3gyM0xwSyty?=
 =?utf-8?B?bVJZemEzMHFGOVNPRE9JbjJKMHNyb2hTb0tFNzJ3UkRjSFhKcy9WTHJZTFll?=
 =?utf-8?B?UTQrOU5QQytQUjFKZzlDVTRwWG1hWFZ2RExpcGVVUjFNazArdlZoY0tvdTF2?=
 =?utf-8?B?NVo4RWxWLzVoR0krNDFGb0NOd1N2M1BkVUMwOVhVWlQwdEp6Z1RDKzNieEN5?=
 =?utf-8?B?Vng4WVU3OWNVUGhzWHNhSTNXYUFmNkJxWnhDZUZZS3pJMTUydm1ZNkdreW9h?=
 =?utf-8?B?c1lnTjR3MlJTYzByajIwUG5KRnhFeFd5R002U0paRnpjdWgvNndsbFppanlU?=
 =?utf-8?B?S1ErT211UldPY3ZCNmttLzBCeUcvc3FjbkorUDlmS3pGRlgyNGdqb0Y5VmJX?=
 =?utf-8?B?bTlOL2s3N0ViVnBtRU5IYmFwam1xbmFvNTlXVGJ6djRKb2xNc0JTejFiMy9Y?=
 =?utf-8?Q?8PQN6lu+srKXMorABIjQNrtuhSevMRG6O/SnPCzP0aA1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74476FAE78633545AB7AEDAF624BAFCB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb2c11e-6e02-4c02-19d8-08db5b686510
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 08:33:33.2921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eO6kwpkhRyvLP5ZPHr3bibT2FdpQ05ZmLRGzh8tj/YmZKTzj6Px/TLMoNRbftv7zbpoEyt6AfdiQF3IHDDfCkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8750
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230523_013342_129774_5D31A882 
X-CRM114-Status: UNSURE (   9.00  )
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

T24gNS8yMi8yMDIzIDExOjU2IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4+ICsJdTE2
IHN0cyA9IG52bWV0X2F1dGhfY2hlY2tfc2VjcF9zcHNwKHJlcSk7DQo+PiArDQo+PiArCXJldHVy
biBzdHMgPyBzdHMgOiBudm1ldF9hdXRoX2FsbG9jX3RyYW5zZmVyX2J1ZmZlcihyZXEsIGJ1Ziwg
bGVuKTsNCj4gDQo+IEknZCBtdWNoIHByZWZlciBqdXN0IHNwZWxsaW5nIHRoaW5ncyBvdXQgaGVy
ZSBhcyB1c3VhbDoNCj4gDQo+IAlpZiAoc3RzKQ0KPiAJCXJldHVybiBzdHM7DQo+IAlyZXR1cm4g
bnZtZXRfYXV0aF9hbGxvY190cmFuc2Zlcl9idWZmZXIocmVxLCBidWYsIGxlbik7DQo+IA0KDQpv
a2F5LCB3aWxsIGFkZCBhYm92ZSBjaGFuZ2VzIGluIFYyLg0KDQotY2sNCg0KDQo=

