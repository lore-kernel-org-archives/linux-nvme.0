Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE0BC6FD19
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Mar 2023 07:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FrRr788Pk1kyM+BBVxRbKjy++gKi8y65AKM/AN84rGU=; b=rFMXJdEI1Jbx4q6NtvFD/HbUzo
	xg9bkFknoTKXcrXLKcHlsVx5R4XvhKB2rsXnSbtzZ7YGgOYjYLtd6Jy2ZuvBkTZMalXWwCPZYkMOJ
	z7HfIYUmTS9Ido1MTODJVagaQiSNaNgcrWrm1xWg/tKQpgCg8Rza0y02+gznUkQg1Jmr8Ri9cQvoc
	ZwBCkOSAFv0uDDrs8glu0U1OIO8U99Ge6/SI5H+rLhep/nRC8XLFlnolJncDKUjAZxY4vFXWqiOmH
	J0KzANYHEPeQNAnMYalPOnV1YXxUEG7S+fk17lQTHONfb4tvwNkLOVpeid54HB+grzZD7vz4AtVYB
	brsQRtWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pchsi-00FTNn-1K;
	Thu, 16 Mar 2023 07:18:36 +0000
Received: from mail-dm6nam04on2062e.outbound.protection.outlook.com ([2a01:111:f400:7e8b::62e] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pchsf-00FTLl-0y
	for linux-nvme@lists.infradead.org;
	Thu, 16 Mar 2023 07:18:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcLj+Ogyzu9MO2NruqSMgC8mdXKInDVGUzKb9lOxVxcy9rehFXUvO5iHSclNfnU0wdPo/s0IoDkgRu4/kSnleijBkefbh5wbRhohvseWysxNlstgLrbnhAds8GxH8/8qY4xNMfblwnTZe2NdoGqFCJLGRX0+wfzB1QqBIcvEPs2MygzL8S+9XZQFwAtA8d8WVQG/Ijc7lhTP0i2ZAc0dn0/QoMDV12RBTLeeaBMMWVCnaY/imanzbmPDzx511H2G94ck9A05shWEXP2Q9z6ddVtbrRUWM3iUZFNO7Db2rQCvzG5kEd4p0u4TgO3wIrH8Ko5FJwqCdSc6pJw7TEvWfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrRr788Pk1kyM+BBVxRbKjy++gKi8y65AKM/AN84rGU=;
 b=OC3sipZs2XgzW+Rzi4pJ+I8ZkOtgkOt5dTJEzviZNALzQMAjde9fphk2MaSjE4F/aeXGMhx7VLAAR0IwhQrBO8cr05b+yIkNII/Yyc+6HU78upVZ/f+wTdPdvfvHoK1fbwG51MYGNTZ+lpClzyeAO8nxJyKbF/2vTT8uOXPebpaSDSg7xXyhmGYikFufe+HPu7WoSLRJX1IZK98Yu10A5BmTzmJlDC1fb1cdUsHZvqzG3AIbuCMK/frdKUM7oWiVfyzWZeYHchPf+sUqk1ERbpoezQWk5zIZsIMDv21xOW85EvABjyt9SRXOwtS7imSSiJpOJGcguf4ziye3gyvumg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrRr788Pk1kyM+BBVxRbKjy++gKi8y65AKM/AN84rGU=;
 b=otZyjVWF5qptFYFeOS7z27IU0CnQ91WZFXSUSkKgp7T4g9VYk2yf86iQ5IRWs8E9XQtCfRrHJa5k+YhcSV3mHJ5cV4v2vxiQDPTp8rHCEK4FdPSy60qxltAMU0B9AN3OHd9uauchJWzX4ovymVL0/cUK7Rf95B64VcsK1+H6lMqniJNvkshZuUv5uAb0QTxKzg/Jrh1jnmM3sHMPv+djXtbjs4s2jIla3peIMpfpZniF+Lm31e2KiM6RZApNVB+n2enQuvwnXym/+F/FeqIpiuOifNJ8N3W5AMHv2tZpds1wmzO0UFLd+yjdVHMJfun1Fj+sVWjUidNwsEZXxwwjyQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH0PR12MB5107.namprd12.prod.outlook.com (2603:10b6:610:be::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 07:18:28 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6178.029; Thu, 16 Mar 2023
 07:18:28 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Damien Le Moal
	<damien.lemoal@opensource.wdc.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: more nvmet Identify fixups
Thread-Topic: more nvmet Identify fixups
Thread-Index: AQHZV0lRyuE1Da8B/kib45QV6DqYZq78cxCAgACMWICAAAEGgA==
Date: Thu, 16 Mar 2023 07:18:27 +0000
Message-ID: <ea5aacd3-1759-f004-7bab-760c1588bbc5@nvidia.com>
References: <20230315142032.507083-1-hch@lst.de>
 <0fe36f74-b9d0-4b68-1cf6-4d436b15df3a@nvidia.com>
 <5042ab75-3ef9-fd3a-25dd-38b240075467@nvidia.com>
In-Reply-To: <5042ab75-3ef9-fd3a-25dd-38b240075467@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH0PR12MB5107:EE_
x-ms-office365-filtering-correlation-id: d3af8cfa-36dc-4492-8e70-08db25eea394
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  EHoP4sp4l4v2NmBjlwswFm2twESLmAByuMi0WbbZBoUSEBuGEk4jEc52qZpjBceeZkKwMgfhQosDjle0oMhlJ7hU+Lbb9c+172MoH9f/2uXedEargK6yd/R6sfM1wO5OElvMipzM/wqZGZdIANHnEHbRmFSdS/8DWubg0gY0cXTJYIiZ4ICDeaPu2VvFGDHqKfS/w/FyWOVeck+pwEjrTYCaLVZoEvr/m3s9MPsB+ag4KZGYXAwKpqONmwAeGpMH7E1ihWbHHQZgKddU7bPrT/VAjO/pnLacOEQ7N9BTMld6VsfRFbCcJ5blMwOa5soHImlpgheYWyb+ebxU2nkuNHqOHPeiG1qscenHKn/edarK3YeKCi2qVGc+NnRnTxHTNtTjo/wmfxmMYo4HlW68/aQBh+3L3pf33cskRhWD7Lr5EqefNofmM6SVMFYpivYnCrGjvYlywMfwBwJNNrmj4ku7cxvi999tA9MuIQVW1VydshBBK9l4LnJfycbta+pLr1N4xQdo2NaU80dNAvspxUNVo+DaSDQO3HsHaOnGcLRQNeprwopnUvrX1C99pCNcG28+1OVmANMFObINDqDasyB9sBWYpGvTHRllmH86wcfClVam2DGur29+gk41oADMgnQ2iEO/+lFn1tZsNAHUdQuu1EW9tz7/V9IGNiMZp6yo+H6uFH+/9gC+l0+XJlHyHN10KaJ4F6l+LW7mrImtjlrq23op2u36ilQpShNKJQr9Lef4rrwx/5wSzyXjI6HWL+DJV1vphpLdzeh5xC3czg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199018)(38070700005)(36756003)(86362001)(38100700002)(31696002)(122000001)(5660300002)(2906002)(3480700007)(8936002)(41300700001)(6512007)(83380400001)(4326008)(478600001)(186003)(6506007)(54906003)(2616005)(53546011)(316002)(66446008)(64756008)(8676002)(6486002)(66556008)(6916009)(91956017)(76116006)(66946007)(71200400001)(66476007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?UGVlMmovejQ1TVJjVlQ1M2E2SXRJWlZ4WjZOQWtOdFVJMmxFcFdPeW10akJ4?=
 =?utf-8?B?MEtxL2NpTGM3SUVIb0tsVGoraHlkL2pkeGhWQmZ1WTgvNXZLaDJBT0ZMRjJv?=
 =?utf-8?B?WjVmRHBTY2FCWCtMWjVqTVhTS3VKM0JSRXBtYndNa0UwRGFpT3JiYTd3UWR0?=
 =?utf-8?B?N3F1ZDBHSGhqdjZESG5IWHVJd2ZDSzhzN0JHemxIU0x3VG9zM2ZQbW0rbkx5?=
 =?utf-8?B?THZpanIvc1VmcmFITlZlN21tbko3WUJhcGJuNklMcmRBMlFoZnNjK0dXNWRC?=
 =?utf-8?B?bVpKNmhjaU5PbnIycVJPeWZsSmdXeFc2clJLVW4yWG5hTVdXUzdGT1pja2E1?=
 =?utf-8?B?ZGNHK0VqUTM4eFVFekNQSDFSY0JYa0JGZmZqYkVTOHdKYnNCOUdIaFozSFZB?=
 =?utf-8?B?czQ3cVhBSWtPditRV1ltc3l4YTlhc1pqbFNTR1dFYlZqTG9mTWZnRjNaYjJJ?=
 =?utf-8?B?ZFczZ2swNXgwRk9TSU9oR1UvbUxtcUg4cm95QXlUTDYwLzMrdjRGWnVaRlMy?=
 =?utf-8?B?Y3ozRmxRdk9qTzhvSlNERXZZbi9RUWFFSENjWU9QYlZucmEyclA4NnVFZlgz?=
 =?utf-8?B?c1BoeHovUGdGcC8zWTNTNUFuNDl3Y2NVNnhZb1paTyt4MVEwWjNoaTc4U0Jv?=
 =?utf-8?B?Rm1veEtCZUVUaXJhUkpham5PeE1FckV3TTdINW9Ca2tQVzVMclYzZEVYUWtK?=
 =?utf-8?B?MGQyZi9uSUxKL0RmeThYUGIxTWJpUVRrcWx6c0dwcnduNGQ4dzBQV0N0dzMz?=
 =?utf-8?B?QnhacmFHUWtJWTdMT1hoYjh4WHBOc1JDakphaXNjaG13WnVKVE43ZFBXRVFU?=
 =?utf-8?B?T2sxWm5xTDBsaXQvNjAzeTc1dzJaeTBjMjRWaFlFSnhYcGxXbmF0MEhMNVU5?=
 =?utf-8?B?dEk2YUt1cjRTenBORlNzdjhEZWdmSHpjUFROS05Ncnpsc2hxbUJDTndPQ0VR?=
 =?utf-8?B?b1hXNllDR1dRUVBEODRPUjVqN2RqMzZ0aGlaT2xOYk5kWGNSWU0xZTBwU2J4?=
 =?utf-8?B?a1FLWllzSWt4azhFblF5bzhIZ0IvUGdxRG1EcGNlTjI4TDdnTFdEbUVaMWdH?=
 =?utf-8?B?L0ROQkZiRFB0ZnRFVjR0aXFsTGpJZWEzYkpxbGtiUTJMNXVWR1kxWi9DWEF0?=
 =?utf-8?B?WHBrYUhPOWtFMGFPRW1uUzQwazVDQUdMbWpXcUdCNzhJL1krNzlCcCs0QnND?=
 =?utf-8?B?RHh5UmRhOUhlTlJxZVFZTUU1S3NlbTFrRnlEMzZnYmdZMW9QcU5tVXJ6c0lM?=
 =?utf-8?B?VmlIemRzM2tKdEltU1k3ZEFMdkFLclFRWmRiRmpOblV1Rm9icjFQSGVtOGx0?=
 =?utf-8?B?cldzK2hCdUhjMjlxa0haRFg1K2I0MXFUUUY5QXZOb251WkJDakNEU09ZQURq?=
 =?utf-8?B?ZCt2VmJKRlpsR0g3Q3BNOElEVlcwRm9HNGZ5TDhKazZqSWJTNmFVWmFkcmt2?=
 =?utf-8?B?dkVKUlhDL0ZlZ284Z2l6Z0V3Q3UxUGkwaXlxZTV0a0lKamFEQ1VCQ3RiK3kv?=
 =?utf-8?B?L3ZidjVzRGt0UWk3SEJtRFQvc1ZlZjdKNEJ0cnA2VVo2eXpwcVZoTDFXUEJW?=
 =?utf-8?B?Z3dTTE95dGkrc0JWVEpVR1JsNmlZcCtSUnZoZFYvYVBpd0hsSEpSelN5OVEy?=
 =?utf-8?B?Qm5yUThSMHV2TnV6ejFtbjlkcC9CWDdHNjNianBURUtlU1g4cERITUZ3Njdu?=
 =?utf-8?B?NkZ6OXZjeVRQUDQ1akc2Wk5qTGJkVEVTMStBeStxdllXc2J3dWswZzRvWDNp?=
 =?utf-8?B?VjYzRkpOc1RFR0d0MW9WRCtWbisrOUdDaDYvVExab1k2V2ZFdk5SbWRyWW1F?=
 =?utf-8?B?LzRPdnZQeU94N0hHKzJJbC8veHhHTFhnQXRwTDRleXhUTFIwY3NnK3dIVEhV?=
 =?utf-8?B?VlJqdlNHVE5vSVY1dUNZZ05zNHFhV3QyMFlKWnMrdk5YWXNPYnRKUTh0RjJG?=
 =?utf-8?B?ZUJWdUFoNFNwY0RvUnBleWRvY0pzbm0xVmZpMi9ZeWptZmNhN3h3TThtSWlN?=
 =?utf-8?B?UXhSSm9nNzdKc1JhNEYweTN5UDFuVktsQWQ0SWdGczc0YWh5aUxlWENCSVZX?=
 =?utf-8?B?Zmx4b2RPQlh5bVNGUGlubXZmM2p4eWZBSmNsbVhGQ01kY1B3elpvUzNsQnl6?=
 =?utf-8?B?OWFmM2NGSHlVVEFjdHlaSUxxcTZEeWRaU29iZlA0NTVpOU9XVjVvNFo2Rnl4?=
 =?utf-8?Q?LjpyAQqRCXvb8YMMDp04aCZyDThlcOEw0VTYF1hbMhpl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78BF092311B5DD479AF541CA3A209809@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3af8cfa-36dc-4492-8e70-08db25eea394
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 07:18:27.9767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: boUTyff0WKqx439eApa15o9aHCHnyNQBUs/gNtIaYmZr0Qgd2D7XefHU9VmeffKg8jo4xIdlEc/Mh5DwQsqFjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5107
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230316_001833_379252_F8A8DBA4 
X-CRM114-Status: GOOD (  17.56  )
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

T24gMy8xNi8yMyAwMDoxNCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBPbiAzLzE1LzIz
IDE1OjUyLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBPbiAzLzE1LzIzIDA3OjIwLCBD
aHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4+PiBIaSBhbGwsDQo+Pj4NCj4+PiBoZXJlIGlzIHR3
byBtb3JlIHBhdGNoZXMgb24gdG9wIG9mIHRoZSB3b3JrIGZyb20gRGFtaWVuIHRoYXQgSSd2ZQ0K
Pj4+IGFwcGxpZWQgdG8gbnZtZS02LjQuDQo+PiBMb29rcyBnb29kLg0KPj4NCj4+IFJldmlld2Vk
LWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KPj4NCj4+IC1jaw0KPj4N
Cj4+DQo+DQo+IEkgdGhpbmsgeW91IG5lZWQgdGhpcyBvbiB0aGUgdG9wIG9mIHRoaXMsDQo+IEkg
YmVsaWV2ZSBpdCB3aWxsIHJlc3VsdCBpbiBlcnJvciwgcGxlYXNlIGNoZWNrOi0NCj4NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMgDQo+IGIvZHJpdmVycy9u
dm1lL3RhcmdldC9hZG1pbi1jbWQuYw0KPiBpbmRleCA0ZWUzMGE0ZGE1MDkuLmFmZGY2OWY5MjU5
OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9hZG1pbi1jbWQuYw0KPiArKysg
Yi9kcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5jDQo+IEBAIC02OTIsNyArNjkyLDcgQEAg
c3RhdGljIHZvaWQgbnZtZXRfZXhlY3V0ZV9pZGVudGlmeShzdHJ1Y3QgDQo+IG52bWV0X3JlcSAq
cmVxKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPiDCoMKgwqDC
oMKgwqDCoCBjYXNlIE5WTUVfSURfQ05TX05TX0RFU0NfTElTVDoNCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIG52bWV0X2V4ZWN1dGVfaWRlbnRpZnlfZGVzY2xpc3QocmVxKTsNCj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7DQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybjsNCj4gwqDCoMKgwqDCoMKgwqAgY2FzZSBOVk1FX0lEX0NOU19D
U19OUzoNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN3aXRjaCAocmVxLT5jbWQt
PmlkZW50aWZ5LmNzaSkgew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSBO
Vk1FX0NTSV9OVk06DQo+DQo+IC1jaw0KPg0KPg0KDQpJbmRlZWQgaXMgcmVzdWx0aW5nIGluIGVy
cm9yLCB3aXRob3V0IGFib3ZlIGZpeCwgdW5sZXNzIEkgbWVzc2VkIHVwDQphcHBseWluZyBwYXRj
aCA6LQ0KDQpudm1lIChudm1lLTYuNCkgIyBnaXQgZGlmZg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bnZtZS90YXJnZXQvYWRtaW4tY21kLmMgDQpiL2RyaXZlcnMvbnZtZS90YXJnZXQvYWRtaW4tY21k
LmMNCmluZGV4IDRlZTMwYTRkYTUwOS4uNGVkZTFlNGRiN2ViIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9udm1lL3RhcmdldC9hZG1pbi1jbWQuYw0KKysrIGIvZHJpdmVycy9udm1lL3RhcmdldC9hZG1p
bi1jbWQuYw0KQEAgLTY5Miw2ICs2OTIsNyBAQCBzdGF0aWMgdm9pZCBudm1ldF9leGVjdXRlX2lk
ZW50aWZ5KHN0cnVjdCBudm1ldF9yZXEgDQoqcmVxKQ0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm47DQogwqDCoMKgwqDCoMKgwqAgY2FzZSBOVk1FX0lEX0NOU19OU19ERVND
X0xJU1Q6DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG52bWV0X2V4ZWN1dGVfaWRl
bnRpZnlfZGVzY2xpc3QocmVxKTsNCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByX2lu
Zm8oIiVzICVkXG4iLCBfX2Z1bmNfXywgX19MSU5FX18pOw0KIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBicmVhazsNCiDCoMKgwqDCoMKgwqDCoCBjYXNlIE5WTUVfSURfQ05TX0NTX05T
Og0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzd2l0Y2ggKHJlcS0+Y21kLT5pZGVu
dGlmeS5jc2kpIHsNCkBAIC03MjAsNyArNzIxLDcgQEAgc3RhdGljIHZvaWQgbnZtZXRfZXhlY3V0
ZV9pZGVudGlmeShzdHJ1Y3QgbnZtZXRfcmVxIA0KKnJlcSkNCiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfQ0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsNCiDC
oMKgwqDCoMKgwqDCoCB9DQotDQorwqDCoMKgwqDCoMKgIHByX2luZm8oIiVzICVkXG4iLCBfX2Z1
bmNfXywgX19MSU5FX18pOw0KIMKgwqDCoMKgwqDCoMKgIG52bWV0X3JlcV9jbnNfZXJyb3JfY29t
cGxldGUocmVxKTsNCiDCoH0NCg0KW8KgIDgwMi4wMjk0ODldIG52bWV0OiBjcmVhdGluZyBudm0g
Y29udHJvbGxlciAxIGZvciBzdWJzeXN0ZW0gdGVzdG5xbiANCmZvciBOUU4gDQpucW4uMjAxNC0w
OC5vcmcubnZtZXhwcmVzczp1dWlkOmI2NWNlY2UzLTdlNjAtNGQzYS05ZmQ5LTU4MWRiMjAxYjE5
MS4NClvCoCA4MDIuMDI5NTk4XSBudm1lIG52bWUxOiBjcmVhdGluZyA0OCBJL08gcXVldWVzLg0K
W8KgIDgwMi4wMzMyNDBdIG52bWUgbnZtZTE6IG5ldyBjdHJsOiAidGVzdG5xbiINClvCoCA4MDIu
MDMzMzIwXSBudm1ldDogbnZtZXRfZXhlY3V0ZV9pZGVudGlmeSA2OTUNClvCoCA4MDIuMDMzMzI3
XSBudm1ldDogbnZtZXRfZXhlY3V0ZV9pZGVudGlmeSA3MjQNClvCoCA4MDIuMDMzMzMxXSBudm1l
IG52bWUxOiByZXF1ZXN0IDB4NyBnZW5jdHIgbWlzbWF0Y2ggKGdvdCAweDAgZXhwZWN0ZWQgDQow
eDEpDQpbwqAgODAyLjAzNDY3N10gbnZtZSBudm1lMTogZ290IGJhZCBjb21tYW5kX2lkIDB4NyBv
biBxdWV1ZSAwDQoNCi1jaw0KDQoNCg==

