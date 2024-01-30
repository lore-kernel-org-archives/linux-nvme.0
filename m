Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBC1C46CD2
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 08:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BXB9Te5dbuJ+Hcy0te3tmisWhOkzGIEeYQHH7sjsWCQ=; b=0DfoOReHQW4PfheAwjjw9OnFbn
	21mFZKeWKvCfgRCCyBKzsgxI+hJXP698Q4txXmFWmvf+scQo4ape873pWRsap11A8uEILTVqvwAuM
	zPu8y4p0uQCChUQc5PNGXiqZYCbDJJj3cckUcHUcYDzyCN7oK/0IutTCHCFgwUO6/m4XzNiaMTaQk
	z+jlwyjWi8XXJYO+LBidUFytEOclaAopT+bv6Y4MVCGOHFn0Xt0K3Y+7PS8b+W9rk7VA7Nty5ioPj
	TYAxOfWyfOMqU8zAQXs5wt114fB+C0EzkHmOse1NXZFpjZ7tJgxp/Piwhjq8D6HnIyDuAyo1BBxCw
	03RaYtSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUj7j-0000000FccP-1JfT;
	Tue, 30 Jan 2024 08:05:39 +0000
Received: from mail-bn8nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:2418::601] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUj7f-0000000FcY6-3g31
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 08:05:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWbGxuj/i1mRutucE6EMKioQK0mZzxVVm5H/JLN2tRdAHL5qAkrObIwGaX6YDoa7QTcxLynM9dJVxQjA/vWb3loF7TuXL2PwZKn0tarbFW1HRROuXGnlV4mKIiGs5BA6TzninyvZ5UrX7cQkVoCmmB5gOGoicqVoLpv2P1FeTZAx3TTyjpI4F4vcPok7RVaMMcvtYy2Bz/D5IH9mFerCEB8XL2/9Zi/s2ghqT0bTdl5285NVOzfVlYV7geuQ8DzyyblJKGQQxGDBqaXxeKGRecvIpLysklQjrsd8ry20JQTUwnvtk4WZWaPV+BjxMbHXheicICVsP0FCob1ihwUbfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXB9Te5dbuJ+Hcy0te3tmisWhOkzGIEeYQHH7sjsWCQ=;
 b=TQhvog7k/aglSy1V2N3t8hDwMh6hknGXhehItuzj0zV331KfIR4B/YEFl0R+4haYt8WH5178yqcVMkYo/GRF2WIF3GCRHsuNmot0HJu5CJBNBKo0UXppCkkl7qMyjV8cTEhhn/inDBweptnVGG4Q7GOkOwRbUFNjtOZ8bSHWm9r73MGamjg+xfJ66zh12o9cEjVDeNlKP2pBW6CKFpIj9r5O38E6fUWDFscZwkNhNy6KwVsdZH7Yu2g1ZFfBYT+/7Tuz0f3zhYUVxxr8vFHPqUuOUWWmjP9tuCVqvAePwjPKQBIel8erfR1QSCj6PcnNPf9Jo1vnM6CYjCrtxO125Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXB9Te5dbuJ+Hcy0te3tmisWhOkzGIEeYQHH7sjsWCQ=;
 b=o+9YIS14oCu9klJ7o4QPhf5YkpRj9tm5lodBxJMEfd8X514eQ5YZlMywRIE7kpGIrdYf6Y0wfCI6ldCTCYXTeAzBrIEwkxlRXWLNJSf7JLpEquehTEg3rdHQJiYeX06yeNfHYyw25D+mkTaDBsd45dNFluxsMMvyo99aHuRBJttHE1jYNn84vWu8KVaMKNG4XlwIE8M/6NgfQZxpWQR5Ck56EphHwBGpjpxigiR1d4jVVlGHZB5I6dRN9nVlnPZnQ6IC00TEGtSC4S8ELO9j8lzHHWoJZfpUN+1aWL3u5K4e2eE95KFNc4ChvTsYHnQrQb+i0Q2zF8BwDRhyjfRRmg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB6634.namprd12.prod.outlook.com (2603:10b6:510:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.35; Tue, 30 Jan
 2024 08:05:25 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 08:05:25 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH 2/3] nvme: parse dsm command detailly when tracing
Thread-Topic: [PATCH 2/3] nvme: parse dsm command detailly when tracing
Thread-Index: AQHaUox0hQUh2p2NfEqXokg0YtVtqrDwojMAgAEXyQCAAEcTgA==
Date: Tue, 30 Jan 2024 08:05:25 +0000
Message-ID: <93da3b09-7cb6-4e5a-b5b0-ced7a8542c1c@nvidia.com>
References: <20240129082256.63239-1-kanie@linux.alibaba.com>
 <20240129082256.63239-3-kanie@linux.alibaba.com>
 <37d84d79-6be4-47dc-9f3f-09bb9c5cae82@nvidia.com>
 <304cc83e-72c7-4b12-b2fb-f978e331e813@linux.alibaba.com>
In-Reply-To: <304cc83e-72c7-4b12-b2fb-f978e331e813@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB6634:EE_
x-ms-office365-filtering-correlation-id: ce6d1262-a80f-47d5-5348-08dc216a370f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GvZ3T9dWoElZtFuAP3DX9pWlxpmlqJRcJECc94FRBN5+DBbcIa5Ry2JFDV9nXhj2j6sfqZvHt8nyL4UUaKZkyPDabEHaD2UO/0FK/zV6IglQOBU/7pR44awlKRkbFFw13OJMACUbetySxevuz9G7DrVBYsVpUWqiLzS/VIDGmMRMG/OSF/cqTG28vFWDwmy0tfgsIOpw0NDum5A+Jt6JwBz3ea6//Slk0Iolp/EwxBtyVc4OTt5YX4CIdEwBXqGGEtXklhR1PbU5e6ZowPP+6OTn7C4aDcra7J028Hyu+MK2daFQVy4kNRgOgxfWtikiti2Whvvo3k2NtcosLsWNI1AIVJ4i7XYdIgg5wGx/Onoh3UmyI/0Aa2x5X8q/JNSWBAVX5TUVm3g4U18FO/wr9NyAPOnZLj5tr/azpLn0qhQtUxlYkLwc2fMAEByaw/f/00BIITbpqamrypNvKWaBGY/ubRI24EX7f3EIbmr+ianaWowkecgnG2kwjh/Ika/vvfbfEmoXtxulKdtdm2FS+dPGCAUtPeZ7P/IxQhgI5h4xCFiUH6GwKNOzoHUe/Yy8th8o7TL+trzxByxurptky6C0ywSyS2nvIACrwqEHFmnKTghvBXYkB/VnfHrUtw7S9DynEiStNe/YNIadICrLnKCrUyJ+1IoZvxmP4yi5C9aQdnGrNA1Abv+c/RQqGRRZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(2616005)(41300700001)(31686004)(6486002)(38070700009)(36756003)(6506007)(478600001)(71200400001)(6512007)(83380400001)(38100700002)(122000001)(31696002)(86362001)(2906002)(5660300002)(91956017)(76116006)(6916009)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(4744005)(8676002)(4326008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVBLTkw0TnhRcjNDNkViRGMrM1JvaWczMHNlVWxuYzZoVTgwUDFvWUdXaEQr?=
 =?utf-8?B?U0Ixc1lkczQvbmRiM0VCblU0aE5lUnNsVlNYS3k5ek9IQ3Bxa0FvUFlVRE85?=
 =?utf-8?B?cktxemZUVU1HbXJQWDE2bXNKT01SMTYwdFkxRHkwVDFSTk92VTJtb3haMGxW?=
 =?utf-8?B?c3AxMWYwQnovZHJJMW9xdWtzQnR0Q2NJb3hWTVhnZlFCelUwTTNlWGxvTWFS?=
 =?utf-8?B?NzUwbXlxaWozNDZvT01lY2ZBb2pFVkF6NkZFSW9GRWhndm4rVjFnaUxaQ1ZR?=
 =?utf-8?B?N2N4YndxTGphOGQ1NzA3YU9tRjFyVEZTdWd4anYvcjRRenA4VmFMY0VXMzBu?=
 =?utf-8?B?TnRpaEZJOG1Penk0cWh5QytuMVhsMkhZb2FheEdIcWQvWGoxVzVhbkd6c2xh?=
 =?utf-8?B?Q1h3cXRpbmtqRUlZeTNmbCtIbHV5anF4SkF0VWp6Uk1TMHJSZlFNNkVkeTRU?=
 =?utf-8?B?blJld2VtdHNNU0tGTFlBUGtsb1JqeVV5SVVvZlZNS0FzTGd4K1ZlM1Qrb2xk?=
 =?utf-8?B?aUJTRzVwNVNVZy9RUk5rd3ZjOVB0bjBDQm53YWdnamNGSjNhM0loWUwzajBw?=
 =?utf-8?B?NVFSU2pQU0tuc1V1SHpEZUFJUDM3NDF4eFBOYjJxZlNpZ0NGSDJBU1dXRFB4?=
 =?utf-8?B?QWFEaStqaE15SkZPM3AxZHRSRDVJZG9OQ2s4M0pON3MwV0h2MTVOaEhYUTNZ?=
 =?utf-8?B?Vm5hWlBLTlFtTDJHL2pUdEk4UGF5RlVQSU5KMGxNbXMyeWx4NTNOdTZrT3JL?=
 =?utf-8?B?RXB6ZFpwSGZnYTZEbit5dXVtVHdhZWcvNVMzQVMwbWZFdlYvVlJGWGRYak4x?=
 =?utf-8?B?VG1kN1BGbUJOTlQzSU5pUUpvcTArMTFWSkRTSk4rU2xjMGprSmF2ZUs0Ykxr?=
 =?utf-8?B?WTZnZW9KaUFHa1I0OU1EZzdBT3BqVmxqcms4TjFNMGExYTVvdkVvaWovaXF2?=
 =?utf-8?B?d1VjNFM5VnVlaHliT3ZyOVh6RUJxMTc5SWFFNHFiVG43ME1ZRDlXQWo2ZjBY?=
 =?utf-8?B?U0Q2MWh1em1GZktVeEJCN1ZPZHoyTTBWN0VnL3dFNk9idHFCaExXK2dkVkhk?=
 =?utf-8?B?dll0alQ5a0VpM3ZBRzMrajJORWVuV1NHcklvU1lEMmdSckpyeUdDaEFIYnJs?=
 =?utf-8?B?YndZZUV3KzNyYjlGVGhDVW13d1pXbFZFMkpQZm1qbm5rbFB5RDZJSm55amp4?=
 =?utf-8?B?NWp1VzJlYy9mejdwVGdpZ1lNemt4WVF1bkFVUWs1NkJhSUlFa0tRb3NqcW44?=
 =?utf-8?B?K05GcGdMYkV1eVRGZWVYeDVLQ3kzdUxzSzJ4YUJKZSs2c2VBdFR6NTk5UGlk?=
 =?utf-8?B?OWhsdkpoYnppQmtkUFQyQkFpQTJ4YkIwMmEwS0pEU2ZrV3ZQL25Md0h1NHRm?=
 =?utf-8?B?S0RXTmdFMkZxeEo0M1RyelFNdERUYnFrWnR4OEZRaVRhTVlHdFpCMUx1djhq?=
 =?utf-8?B?OGJLaWl5WWNkTDY0TkQ3Q2RxTUFybHpjdmZKYTlPYTBQQnNJTk5wL1V4OStH?=
 =?utf-8?B?bE9BWlFqclpuYjlUUUpCczhadWplY3cvRWU2bFRSdWtMTnlqZFNRVC9NaytD?=
 =?utf-8?B?NzlaTFJBem1VVDYvWm9PRldoSklmc2R6UVVnQStXTDBWMHNyN0p4enVadDBD?=
 =?utf-8?B?S2lEOVBndkRwMEJaYzNmNDdVRTA2QXYrSTA2VlRKMldqQVl2MzdOSUl2Rm56?=
 =?utf-8?B?SVVOdktQYnY4SjUrQzdtQTIzWFNjQXNLTjRaUjRiclRWeUloa1F6VTFaZ1Fn?=
 =?utf-8?B?UU5POGJ4VWk1NTJuNmg3OHdKRjNQK0dBWjNGZXpQTmZWQzdUZVVEc2U4cHpI?=
 =?utf-8?B?cm9Yb1VCR0U0VlU4UWlFNGdmay9BTURySFEzclMwb3VRd3JDV3kreklFdlRk?=
 =?utf-8?B?Q1ZyN1FSOUwyeDY2eG50TjlIakx0MnZ4b0krb3ZDeWR4L3A4OEw5eU5hTmg5?=
 =?utf-8?B?OXIrRHlKeXNzZ2R6czJXeXVYTlJXUzJvRFRwR3ZWNmIzRXhyWUdxTHpWQ0E5?=
 =?utf-8?B?N1hRQVVIQ25TZmFKSUo1eHE2VVdtVlZoQUlwVDVKWitlMHN3MzRCRk9kaERX?=
 =?utf-8?B?bTMwT2ZsaERZc3B6QzJDRHZzdmxDbTJlTUdsQ0RZV2RKZDI0WUhCaVdpS2I2?=
 =?utf-8?B?cUJTZWg2eW5jbk1oc3hYSVA1azBKNWtLT3NneGU3NmRBa083aXROaHFBNW5I?=
 =?utf-8?Q?yKWlskblgPg2nZdvln+ypiJ0iOew6/AybrquL/UAzub/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24086313DB53D74EA4B05EC41D9F07BA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6d1262-a80f-47d5-5348-08dc216a370f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 08:05:25.3147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LMhB9eTpcb4e+RAIeN7PZQp4ZMp2pAIsQunlchVftgKlKVgL1heJg6CmOSC1ycNM9VUKtEbPuA/EOQ5VyCpHNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6634
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_000535_959559_E5BC27B2 
X-CRM114-Status: GOOD (  15.75  )
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

DQo+PiBJJ20gcmVhbGx5IG5vdCBzdXJlIGlmIHdlIG5lZWQgdG8gZGVjb2RlIGlkdy9pZHIgYXMg
SSd2ZSBub3Qgc2VlbiB0aG9zZQ0KPj4gZmllbGRzIHNvIGZhcg0KPj4gdXNlZCBieSBhbnlib2R5
IG1heWJlIEknbSBub3QgYXdhcmUgaGVyZSwgYnV0IGNhbiB5b3UgcGxlYXNlIHByb3ZpZGUgYQ0K
Pj4gdXNlY2FzZSB3aGVyZQ0KPj4geW91IG5lZWQgdGhlc2UgZmllbGRzIHRvIGJlIGRlY29kZWQg
Pw0KPj4NCj4+IC1jaw0KPiANCj4gTW9zdGx5IHdlIG9ubHkgdXNlICJhZCIgZmlsZWQsIGJ1dCBz
b21ldGltZXMgb3VyIHRlc3RlciB3aWxsIHNldCBpZHcvaWRyIHRvDQo+IA0KPiBzZWUgd2hldGhl
ciBhbnkgZXJyb3JzIGhhdmUgYmVlbiByZXBvcnRlZCBieSBvdXIgdGFyZ2V0LiBXZWxsIHRoaXMg
aXMgYQ0KPiANCj4gbG93LXBlcnN1YXNpdmUgdXNlY2FzZSwgYnV0IEkgc3RpbGwgaW5zaXN0IGl0
J3MgYmV0dGVyIHRvIGZvbGxvdyB0aGUgc3BlYy4NCj4gDQo+IEJlc3QgcmVnYWRycywNCj4gDQo+
IEd1aXhpbiBMaXUNCj4gDQo+Pg0KDQpCdXQgd2h5ID8gZG8geW91IGhhdmUgYSB2YWxpZCBpbXBs
ZW1lbnRhdGlvbiB0aGF0IHNob3dzIGNsZWFyIGJlbmVmaXRzDQpmb3IgaWR3L2lkciA/IGlmIG5v
dCBJJ20gbm90IHN1cmUgd2h5IHdlIG5lZWQgdG8gZGVjb2RlIHRoZXNlIGZpZWxkcywNCnVubGVz
cyBvdGhlcnMgdGhpbmsgaXQncyBhIGdvb2QgaWRlYSBsZXQncyBub3QgZG8gdGhhdC4NCg0KRm9s
bG93aW5nIHNwZWMgb25seSBtYWtlcyBzZW5zZSB3aGVyZSB0aGVyZSBpcyBhIHZhbGlkIGltcGxl
bWVudGF0aW9uDQpmb3IgdGhlIGZpZWxkcyB3ZSBhcmUgcHJpbnRpbmcgYW5kIG5vdCBzdXJlIGlm
IGl0IGFwcGxpZXMgdG8gaWR3L2lkciAuLi4NCg0KSSdtIGZpbmUgd2l0aCBBRCBhbmQgTlIgdGhl
eSBhcmUgdXNlZnVsIC4uLg0KDQotY2sNCg0KDQo=

