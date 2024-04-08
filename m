Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979C4CD1296
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 18:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fIg6yUC5ZRIIwBFjsrj7BhRYFc9+8mi7NyZU8iUaN+0=; b=ucSHuHZdzRVgnNGd8AVvA8wsr9
	rpEK3jzoi+vinP2AunUIDGJR1WSrVXD3d8HtEUzEJPgXCAJA1vQfCyWOs+CNpl3XjlKr9AzNhgZQK
	waPf+OOTM0/SakR1RKeXITV7uUpO2BTj8LkPC8rIkQzrB0trkneLP35yqyJBu9drMFYz0uBnhJfaH
	t2xK5ThTXS5mKq5VXB36cHTQIBUyC4v2ZF7eDDoHyQwtanpou5goAY54xrQdcTedlyzoYirmPlLmR
	O9IAmkStSUttXnWan1KDA+K+L0wFclGtsmePeygVSxzQjXvW16NgWUkv+FXw3ZFgC8QvaEujvJAG9
	Q+Zh5ToQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rttgO-0000000GU2I-0ue8;
	Mon, 08 Apr 2024 18:25:28 +0000
Received: from mail-bn8nam04on20701.outbound.protection.outlook.com ([2a01:111:f403:2408::701] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rttgK-0000000GU1P-48WP
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 18:25:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmeL6aRnx5z4obXrWTEo6+/kFMCjIINtaA4kCjcRQaFVo+PvFNDjRV97E5ycYkgzkdxg6Z0w16xA3tuK7Tr2b+hnZde9iJU0oltFAU17mOh0bR0rOmS/z0VKhyd3ptfgqN/nCJAFnICMKk7QMQpkquWgvBn86T+5sSsSmUR8HuErRNJI0dcB3Tr9opIwLJLIG9EVVXKmgh+/zh2303Vsjrz3LwASNOXuCaMMNrMguo0vTMI7TSTrIffc1eVYWS1qdTvCdpUH2kD6KKqxOouqWu5U/AXQO3qsgE9x0VjR2ZmqTqaAvb6aZAQIW3LQDPL8+9czZRsvtIeRUzF01YmSJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIg6yUC5ZRIIwBFjsrj7BhRYFc9+8mi7NyZU8iUaN+0=;
 b=j0HC+nqtOIL4oTTfUlxrlGBlD70JrdzUtewqsuxOpxUL60GQ1dSjFwUuEcpiqMo805tObX8s4//ButdolxLrgjYITMSpMjqV0vyNhHqpf3I74O1mGbDg/oj93xhQZFZDlc8XWJmxvtZ6m5x6yC3sC8ZMN2sg8CU/B5pEY7CwEqlRgH30Q+qZVlBofnl7dlB+kTb6Deanor0Jw7lFntAxI8o0C/B9EYy29u/N4Ww4x22lIr04N/Kp4i09xl02DvI3H4LYhauqYJ/yrjfTXD5A5U2NF959FZRpF0HJwobK6UNyZ16238+MFDl+7JHbp4RKscsluoLqRxLKNYI1kB859A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIg6yUC5ZRIIwBFjsrj7BhRYFc9+8mi7NyZU8iUaN+0=;
 b=D24s2I7cXv7zV2WlvCcrZWjVY6C+bX5gQ9iQSav1J6Bf0xt0T1eT1oqkatkY/OUaW4MEWfGrH/aORlY337pBfQ2/COwhPBzhMit4uuaKStBi2+TCDkCzy+dEiJdbbaV2HCEYUYtVpGEVR33DIZD3tXsNaH69UMyh7YBRZyoHO7cGNGuGa8zHT0S/wKGTYA2OnMx8Hty2x+cFd3WJNUDIOScSTX8gQfR9Hl2IwUbceXY5S4g3no6f9CvxNWrt4ItjjLfqMsiaEcKEIJVvhIykM48GxBRJSHwwkwFKKUEzmrtNydhW9qUqkPOqGbRkVHb4q4slUzOWrT932LsYT5Fe9g==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 18:25:13 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 18:25:13 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@kernel.org>
CC: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/7] nvmet: add 'host_traddr' callback for debugfs
Thread-Topic: [PATCH 2/7] nvmet: add 'host_traddr' callback for debugfs
Thread-Index: AQHaf3W/7/Er60JQD0S+/kDEX3gu2bFexUQA
Date: Mon, 8 Apr 2024 18:25:13 +0000
Message-ID: <28275c05-c669-4e63-9101-91549e9149e4@nvidia.com>
References: <20240326120342.105740-1-hare@kernel.org>
 <20240326120342.105740-3-hare@kernel.org>
In-Reply-To: <20240326120342.105740-3-hare@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB6839:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BLyBWZq0yF89NeskotThIGA5D1VQzd7U56k9Q0ZWetdUIxCQBjIZ6vi1+5vb9x99JFjkpglVEaiMi8F9ObCwA7sQVRXitKuwq/c2YMHIUvLNxcsjyfDvd9S8cZ+XJC6YmtGTly2nwPe4Hr+wBqObi64Lnx04MmKO0hnGyCFOwPMAc16Y2AomkKGcGCR1CbugDPlmm/VTYd01gX2Qo8IltwhK6SSLQIz+ahCAkxay0s3lBHFZa+dj58WJuzj6IjEDqAOTnOQgLXCNtBmP309/wk8ffRIHn5oSb/j38c/LCCu9j+NgopiMFeSylF/ziVMN86o5m2d0vbaJ8muraUr+ML2VDcLvmgs90ZuJc6oGoss2sTh7U/xeeEv2QfG+EN06rSSwmgx5+wfyZN4wrSa+DejHZb4tABydYYA6jtnRSw4rTrPfoCgkIArakttK2xvyNkkFmESCawYEhEpFuzsrAoX+edLZXm6ZLBxUzyc3DCrf7nPpAsKxeWsATx9V/lQ76Rqkbn9dV1t2ep+ckYggp6YUqnLgJfhc+naCKzYNjTYzvhQN/QLPZSu+QPD2pKjrCW8mj+14/4UBNCcEfypgyfm3J99TTPTiF3Fi5aZ2Yr165upteEvfzq+COO2uu+gWamc8JVbO7D81U+3Kt9VwNANdhlOX1rxkcH4hJb2TIhM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVdwWWdqYmtZV29QQlZCNzhpWU84OERMc3ZLcU1nOGM0Nk9pMythL3I5QUNX?=
 =?utf-8?B?eitOSFhLTGxVOUMyQThsYUJpNWVzNi9iMlkxcUNBMlAxVVVxV3Rab2U4Zk9Q?=
 =?utf-8?B?eTdQeWZUbzkwMWM1NFZ4MWpJMlhwemdEaUxGT2xzT3Npc3J5STl3NVVQSGZD?=
 =?utf-8?B?bTdsMjkvUlRLQ1JVb1VWdGRCVFNKUHNjOTdhblcrWng5UzRxVTJIVXZaeWJm?=
 =?utf-8?B?SStzUzdhMkJsWnpFcGo3Y0Vpa1R3OWI4TjlFNnB1Wlg2eCsyM2JhN3NQZyth?=
 =?utf-8?B?cXROVUlIbW96cGNNTFpYUTZ3TGtPMW1hQnhGS3ZGd3RwNDA1NnZGRk04TXZs?=
 =?utf-8?B?VDZiODlCSVRndGlDVWM0MXNyYVc0YmJHM1RKNkFlR2VSU051eEFFazdJZmd2?=
 =?utf-8?B?N1p2MC9nN2FXcW9pR3hSN1lVQ2h3MHRIVDBrNEVreXNrcXJraDlTL3pLVnhN?=
 =?utf-8?B?TENvUG5vVFFvU3B5WndKeitSOWQ0QVpXaWdsQkl4WmZPZUVvMUgrZWJMZnlm?=
 =?utf-8?B?eGM5d2JsOEZUM3Y0cmMyaFQxd1NScHp6eGx5V254aXRoQm41U1RlNVB1SERC?=
 =?utf-8?B?T3B5UVhvWHNNaWpDdCs1em9wSEZOKzZ1SlpReEQ2b3NpR0cxNVNaV0ZiRG90?=
 =?utf-8?B?dEx4c044UlhIclpxNEF3T1VsRlFRU3Ewb0Q0ZVNBeVNHc2NOTWthK0N2TzlV?=
 =?utf-8?B?QTJXZW90SDlaRG9VTVlWa004UjhzTXVXUW1aTXh4UEZBS1MycEYySmlPSnVW?=
 =?utf-8?B?WUVubXNMK1RmV2dNK1h3ZG5YWTZndFdnWlRXQUNJNmlsbDNUQk1nN3lCb1B2?=
 =?utf-8?B?d3RRRXdpenBsR1hNUUFSbWRXY0Z4TzFraGMzTGlSaDJKMXp5ams0VjRyQUZt?=
 =?utf-8?B?VzJOdHVWQWY4YzlFZExOR015NmtUZGVFb3BwRTc3ZFAyUkNlL1pobmsvVS9t?=
 =?utf-8?B?R09DTlVaejlUcTB6RUoza2xpcitRRlNmN3hTanBBMFRHL1RZYTJHMjBrVFFm?=
 =?utf-8?B?eEIrazNJSHplS2dQSU5SMlhuUHUvTE02OG5Tc0cvUjNmRnB1dEdQUC9zM2tV?=
 =?utf-8?B?djVuY3FjVTlBZnhjdlhMRlpKNXI3NUx2QW1sbjRRMjMyZkZSenRNc1JwenhX?=
 =?utf-8?B?TWtsK1JRek4xZjVxa0VQNjVnbXZzc0pRK0lQSy9NMllpZzhnTDNXMzFuYmww?=
 =?utf-8?B?K2x1ZU5sSDB2VjJ3VHNoWkhrMmdYWHY2NWZTRWw1ZDBxeWFKUGR2bGZvNFdi?=
 =?utf-8?B?WjVzVWxTaXpBeVlpQjZPTG41OUduQ0RFZ0FEVXVRdmdzdmxib3NvZW92aWhT?=
 =?utf-8?B?Mm9ZRncxazhjZ2N3RTJ6SjFLRHY3MmhIRW9YeHdzNnZvKzFRbVFsYngxY1VQ?=
 =?utf-8?B?Z2NOMDJ6UHZTelpoMmZ4SC8rb1BmNCtldk9CS25rQ3J4NUhOakN6c0Z3ZU9T?=
 =?utf-8?B?clpDNEw3QVNocFl6cnFha0M1Q1Y4bEJwOFhvb1Jtd2RtRnVDS3VkZXBJVndy?=
 =?utf-8?B?SGo5SUJWNE14c2NuSWdlK3Y0U053aWxVUTAwR0JnWStXZ3ZtR3lDQi8rNkNM?=
 =?utf-8?B?T2R5Mmg1MThqanlvR3gySDRCK3MzSUdlVndvTWxsV3o3VnlNVld1SWFBNzBJ?=
 =?utf-8?B?QmRYZTdtem95OUovZG1JdSs5eHg0Qnp5NTcyNlh0VWFTV2ErK0VGb3BOZ3A1?=
 =?utf-8?B?bWFJKzdkYUtkVXZqVXd6UzQxKzZRKytMRmwrM2J4TXRmRGcwTU1Xc1FMTXRD?=
 =?utf-8?B?WmNDOGp4VzNXUm5mSExialNEdFdXcllnRVAwd29jbTVGS0dBaEt4Q21yUmhE?=
 =?utf-8?B?ejBBendJQWo2ekROd0hva05xUHRSSS9FYm93d1ZwVVJjbzdOeVZGQmhtK0hp?=
 =?utf-8?B?WDFRbmNrVUhGOUlYemRtWGxMekNUOVNpQU1qK3BiYUpLem9NWllSOWhrbElM?=
 =?utf-8?B?S1FWOWdaendOb3FJSUpVV0lVWnQ5MUNNV0NFaFlNLzNLY0p0WGJaV2VUaldj?=
 =?utf-8?B?VCt2cTcrcldNamtwbk1wbjg5R0JjbzBzMVRYS0NacmxocjFwK3hZamlvUmUx?=
 =?utf-8?B?QkdzN2dmcWRqZ0dZL2JUTStyWStkVExLVzRnYW05K0JqS0xwWWVLNFhsZVN2?=
 =?utf-8?B?UmdQM25Ya282dm5EOHkxWWJJbkVtbHVERG1NSnVpSkoya2ZxSWdlUlFIaE9a?=
 =?utf-8?Q?RbqoKa5XOio/RXXv1sQJF3QREeb/2VYSI/Hc9Y8uNECP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF7AC4C95502734383CB17E2F5BBC6B2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda2ad47-6950-4321-251c-08dc57f93b3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 18:25:13.1555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 86LgBMHqpKmeglUOJAZBwGF3HDNvXCQhOgbUKoIKbqIHvRukVGhykApljHKYx+Y6gvN0/Tz55ChjF2kOWtOSPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6839
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_112525_056553_A43DD6B4 
X-CRM114-Status: GOOD (  18.42  )
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

T24gMy8yNi8yNCAwNTowMywgSGFubmVzIFJlaW5lY2tlIHdyb3RlOg0KPiBXZSB3YW50IHRvIGRp
c3BsYXkgdGhlIHRyYW5zcG9ydCBhZGRyZXNzIG9mIHRoZSBjb25uZWN0ZWQgaG9zdA0KPiBpbiBk
ZWJ1Z2ZzLCBidXQgdGhpcyBpcyBhIHByb3BlcnR5IG9mIHRoZSB0cmFuc3BvcnQuDQo+IFNvIGFk
ZCBhIGNhbGxiYWNrICdob3N0X3RyYWRkcicgdG8gYWxsb3cgdGhlIHRyYW5zcG9ydCBkcml2ZXJz
DQo+IHRvIGZpbGwgaW4gdGhlIGRhdGEuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEhhbm5lcyBSZWlu
ZWNrZSA8aGFyZUBrZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1ieTogU2FnaSBHcmltYmVyZyA8c2Fn
aUBncmltYmVyZy5tZT4NCj4gLS0tDQo+ICAgZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMgICAg
fCAgOCArKysrKysrKw0KPiAgIGRyaXZlcnMvbnZtZS90YXJnZXQvZGVidWdmcy5jIHwgMTkgKysr
KysrKysrKysrKysrKysrKw0KPiAgIGRyaXZlcnMvbnZtZS90YXJnZXQvbnZtZXQuaCAgIHwgIDQg
KysrKw0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2Nv
cmUuYw0KPiBpbmRleCA3YzgyZTMzZDkzNDcuLjIwYjEzOGVkNTcxZiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9udm1lL3RhcmdldC9j
b3JlLmMNCj4gQEAgLTE1MzAsNiArMTUzMCwxNCBAQCB2b2lkIG52bWV0X2N0cmxfZmF0YWxfZXJy
b3Ioc3RydWN0IG52bWV0X2N0cmwgKmN0cmwpDQo+ICAgfQ0KPiAgIEVYUE9SVF9TWU1CT0xfR1BM
KG52bWV0X2N0cmxfZmF0YWxfZXJyb3IpOw0KPiAgIA0KPiArc3NpemVfdCBudm1ldF9jdHJsX2hv
c3RfdHJhZGRyKHN0cnVjdCBudm1ldF9jdHJsICpjdHJsLA0KPiArCQljaGFyICp0cmFkZHIsIHNp
emVfdCB0cmFkZHJfbGVuKQ0KPiArew0KPiArCWlmICghY3RybC0+b3BzLT5ob3N0X3RyYWRkcikN
Cj4gKwkJcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiArCXJldHVybiBjdHJsLT5vcHMtPmhvc3RfdHJh
ZGRyKGN0cmwsIHRyYWRkciwgdHJhZGRyX2xlbik7DQo+ICt9DQo+ICsNCj4gICBzdGF0aWMgc3Ry
dWN0IG52bWV0X3N1YnN5cyAqbnZtZXRfZmluZF9nZXRfc3Vic3lzKHN0cnVjdCBudm1ldF9wb3J0
ICpwb3J0LA0KPiAgIAkJY29uc3QgY2hhciAqc3Vic3lzbnFuKQ0KPiAgIHsNCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvZGVidWdmcy5jIGIvZHJpdmVycy9udm1lL3RhcmdldC9k
ZWJ1Z2ZzLmMNCj4gaW5kZXggNDVjMDQ4M2M1NGZjLi42MGNmYjFhYjI2NmUgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvZGVidWdmcy5jDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS90
YXJnZXQvZGVidWdmcy5jDQo+IEBAIC0xMTUsNiArMTE1LDIzIEBAIHN0YXRpYyBzc2l6ZV90IG52
bWV0X2N0cmxfc3RhdGVfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsIGNvbnN0IGNoYXIgX191c2Vy
ICpidWYsDQo+ICAgfQ0KPiAgIE5WTUVUX0RFQlVHRlNfUldfQVRUUihudm1ldF9jdHJsX3N0YXRl
KTsNCj4gICANCj4gK3N0YXRpYyBpbnQgbnZtZXRfY3RybF9ob3N0X3RyYWRkcl9zaG93KHN0cnVj
dCBzZXFfZmlsZSAqbSwgdm9pZCAqcCkNCj4gK3sNCj4gKwlzdHJ1Y3QgbnZtZXRfY3RybCAqY3Ry
bCA9IChzdHJ1Y3QgbnZtZXRfY3RybCAqKW0tPnByaXZhdGU7DQoNCmNhc3QgY2FuIGJlIGF2b2lk
ZWQgYWJvdmUgLi4uDQoNCi1jaw0KDQoNCg==

