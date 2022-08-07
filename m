Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DD0C19F2A
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Aug 2022 09:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nd3QFwnQNzFTTfrCP+3/buoredcPghPq+H0baulUl0s=; b=HN/xonN+EjtO757moiJo77vjvr
	NXOxmQzZXfl/y2wMDL4FMX7ihMS9ras3tWoCKDZHMSo06XZUElw/gdy5BVwmad5hLxJHVzZvsqSML
	mLa4Ms+TpVATsnyQQzkRSfqeThqBfHTe2WBodFOnJbksXcVOcgYjdtn0zCpOj6lxsa/5HPDcrIpYm
	yJxmZwAVZwq9c68JazWZnpUNhoA6HMwvtYn8CMfvt7ZfaPuG+nBcxH12+D8sggNAo/3Cs93/61M2g
	wRtAbCt4S1D2QXn+mRviWqhMF2zrVH4YyKoIiPE0e09yWkfl8ci0T0B7bjVybbPM2nk3tuCi1PVuI
	qUeiqeRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKcTn-00A1Ve-0f; Sun, 07 Aug 2022 09:21:51 +0000
Received: from mail-dm6nam12on2057.outbound.protection.outlook.com ([40.107.243.57] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKcTk-00A1Sx-7a
	for linux-nvme@lists.infradead.org; Sun, 07 Aug 2022 09:21:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qf3x7xu3dN1zsordqUxyiyGxedWSsFXHFrGcwFreD6iaYteRVEtxsw2T8SGDyvFjsru9i5+dNSQAtkL+4R2SDal1j+C2KzT3edfvVazuHlGOAMMkn0qS0QDgJuwDluTNI6zHRb3WzfL88WwX0E1wUdPZN/LS6y4H/8tlqhlkODJOJdzKiTRnjuOSsESuXu7BFIvNFJ+rt3nRR2XK5RI2NptBC2VFw7HUzIq8LXI+FJAKrIz0IoBAsXAasuiCmRq5ddoftHXdFTscQlBxkoJ7o+xJcukt9McQk1F0vsdhS8nwi8Kvy7P6QUqunhfqQzyzv1LXs2XqeD/lLwI56pvLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nd3QFwnQNzFTTfrCP+3/buoredcPghPq+H0baulUl0s=;
 b=YJ/0VC9fb9ff5R7oVduBCCb8oC2xxvJkusjVD8mlBR9ftknt58HO3nvLVJFL2nUo3WY4b1emJ/bsPIxoARHUZzctxNuaOJJXkEYsyad3VQS1W9tcIv+9W9jEkRWg8I3XeU9DG3VqQpJt4vkGSSf8vHCdwn/140aSevSUHdUe27EpISs03odXK1YckzfV9AcLKfCjr0O5ZxGlYAIm746rtRz2vOrGWz0O3epZijVEmQrm/g1gcpI/0wxvDagRL4TvWE+45MvZMryyM0BoplXG2gvfPb9D6/2F8QcerPlKM8C+7dxmgsXMgeEMvhtaA3z/+pE5GPoICOWYc/d/zeYEwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nd3QFwnQNzFTTfrCP+3/buoredcPghPq+H0baulUl0s=;
 b=cPOzNKmHmlvXbu78nbowCI8UxkcDf2F35FXEygRRe/uTUt2QWGVo+XxH1a2kcmM4l+WWFkNVSUQqHuoEbRDX5RQBl0FhIOL/iK9XVKVfvBf+SB2i4KKcxMSAf77E8P4H27IfRXNZ0EoVUjHIpwA//hfAkGAZi5zbRc7xwaZ4nHp7W+T4kFG1PmpIVWPNCiel0aW96i+bAZKuXpDJ8JUW31K6PZWXWWDoCo9Ld0DV+C/NUffwk4ODYVEh43EW+VUzaNogFscvCf8m98aijlCFf7lXxeXfhI29h82fvHptli7ODn91/px/LQpJpMu4g/BbOcdyVWsqxipH9cy7QRu1mw==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by DM6PR12MB3545.namprd12.prod.outlook.com (2603:10b6:5:18b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Sun, 7 Aug
 2022 09:21:42 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882%7]) with mapi id 15.20.5482.016; Sun, 7 Aug 2022
 09:21:42 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "Ewan D . Milne" <emilne@redhat.com>, James Smart <jsmart2021@gmail.com>,
	Muneendra Kumar M <muneendra.kumar@broadcom.com>
Subject: Re: [PATCH] nvme-fc: fix the fc_appid_store return value
Thread-Topic: [PATCH] nvme-fc: fix the fc_appid_store return value
Thread-Index: AQHYqW8pJix/pqRxKECvniIAoTvBxa2jK1cA
Date: Sun, 7 Aug 2022 09:21:42 +0000
Message-ID: <10bffda7-f210-bc10-ef49-b92a0a14e687@nvidia.com>
References: <20220806083228.3826126-1-hch@lst.de>
In-Reply-To: <20220806083228.3826126-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f938234f-cfba-4c25-0e8e-08da78563dae
x-ms-traffictypediagnostic: DM6PR12MB3545:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  xctqcx0QzLSXlh8Kp3bd3WBUDAL6NBrYljPZdnP9Sz1PVKln5jiUgXkO48hEYArAk57B4JIhVIyAzlZ0o1YPsat09LgMKBx0gORLVpumUYXHQ4IY6MVuKkawoxf43V/pbwL9vDn/PSRnGDdkZ5usqbiRZCzCDABjxDQG+n9rSa1w3phHlYPX9Atsc5FrykwL6XfwV+psSlEHlqes0pN9xM+YwVtw2ToIGBz1NNAeOfeIPnTgNtxkEbpvuftIL8XUw9rp8Xr0hYX6W2T+O3s59X1qS1cz+SCyfRhgklpQ+Q+J2LEDufbYAll06WcxPRAi1SkGAFNXVyFFChJdMBnN4Ndu7MXvInJXVLXgavcNPjDimdCDKZoz98g0fKU0Aj7k1yBa0Tpd/HKBkwZKeZyxPJAcRhk1aIOQt5CGhX6k/o7WKC2nv3vmyBWZzirDqlVgqJ6MQumjnwj1Cg18e+xdZfAF4aXsEwNLsumvVNd1pPei+p6ow0T4VQLNisv0VEJ+kJUu16iWtZK08zyHdPZK+E/4SBlaGlN7YX4NshumlaJvAzbctLKCtxKqBFeORcdIOH5W6v+uhHkgxC2oUD7bnCfXPzUAJGVJ+8kz0UQi2jdrdfc59+/n7sv5UQLjIa68xCfx74R1deGEt2IfcJoBedkU8mbjIlmYsNwzSZu31L6BWY+AubL+KD+EGtZsq2QnJCxGt6HDZzIadpAG0KmBAaTHv9aws2onV+BsKRPXCJtEiWShI20tby33a2tsOVn6BCZuVebYG5LaowCYtKnfY7mpybzjN3UuGUm+65VbUo0lb/KyW77Ot5S0rmbdbc1uLRQi2ziQEGQkP16B+7kduHJgbUGjW/lm+9iJHadwWTjbrHamWjkAHX+Ihuz5pa0f
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(38070700005)(38100700002)(31686004)(186003)(6486002)(53546011)(2616005)(478600001)(71200400001)(41300700001)(6512007)(26005)(6506007)(91956017)(36756003)(86362001)(31696002)(8676002)(4326008)(64756008)(66556008)(66946007)(76116006)(5660300002)(66446008)(66476007)(110136005)(54906003)(316002)(2906002)(122000001)(83380400001)(4744005)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?dlgrRlZ6MlVXL0tiamovajVzVnhFRldVZWErUnNKeksvTzFnRDVUMUdFUU5n?=
 =?utf-8?B?alpxVzZ3cWhUUVhvbWJnS1h2NDk0NGhKSDd5T21rcGpmWFhnOWc4cU9RRThB?=
 =?utf-8?B?Qi92dmZrTHg0WDE5ZThEdDlqUTFZQW5aaEFodDF1YUpWcFUzYVNWWDdlMFFz?=
 =?utf-8?B?eFFmMjViOVY2UVVXcHJoUU9xVCtHbFJOVFRIUjhFN3NoSHFNd2xndGtaNjVm?=
 =?utf-8?B?ZS9ZRUxuS1RRNEh4bUk2T0NyK0JLTVJIQ2hEYnc4OCtXYnRldTBGU3NUNnRD?=
 =?utf-8?B?akRmWG5RYUVCYXV3MjlqNU1rZzRmdnVtUU1Wb3cyUFpHOTNDYm1UTmZLUWtN?=
 =?utf-8?B?SkJmY3p2V2ZxbVEwa0UvWVlLYlZWWHNiWGpVVDNsZEIrV1YyL2tvc2piNThl?=
 =?utf-8?B?b1RlVDVLdk9oNnFHL2VQdHgvend0a0puZnpnc093TWVDUHkyU3M2TWVCSVRQ?=
 =?utf-8?B?U3VoZUMwVW8zc25VakQ0ZnVYeHo3dUVhTFFGZDA1b1A4N3Z1Ynd2RG5GZ3dY?=
 =?utf-8?B?RnFyYzdOZDZobXpMTTY3WUpIUXNFYzJabkRJUjJhcG9IVVZqRFVFZzVTMGxh?=
 =?utf-8?B?Y3JXR2VmNHdQY2Zac2xjVDBhMU5mNWliU0t4bndhc2lURXMxTkhoem1PMFkr?=
 =?utf-8?B?UCttV1lNOGZHR2grQ1B0V2tLWDFvNmlTOGZsYTNvZkUxU0UrY3psNTdOak12?=
 =?utf-8?B?YitPY2lkV0NPQkwxTGJWNjh0N1FMNXJyTTRHa04ydUFGZ3ZwVCtSQXdQcngv?=
 =?utf-8?B?WnpYZHNEUWhwTnRzMDNBSmgreUtTRm5IOXQyREdIemFNT0x6Rm5YeFhFSVdy?=
 =?utf-8?B?MTFiT2NOMHI0bnZNTXFBdUs5MmoycHJUbUJaYnpJRFBWU241eko0MDk1VnMy?=
 =?utf-8?B?cVRYS3NaWjhVWVc0bDB0VFZ5ZEtaajRUazErQ0VwVVhuQTlzN2JZRDVIOEhW?=
 =?utf-8?B?akNvV1VBbUdaajVmcm5HOEhuaHNJVklQakdsbVdyTXZobUZEZnlzZ0RVYmNZ?=
 =?utf-8?B?RGJONVhESXJHU3dyaFdYUWhnRW9rVnZHWG9POTZaNUNGcHhnVW5TWXlmWXNF?=
 =?utf-8?B?Nmd2bG11dXFVL0NnY2pjR0pxSWNHa3NJbThYU2Y2bzJFT3llZ0pKMmxBdktX?=
 =?utf-8?B?MVVOemhxQjVoSUh5dWphcENLZjd5VUkzT2l1Z29PeFRxOEJ6bHpidVQ5UVRp?=
 =?utf-8?B?RVFtbkhXTGk4MjFqclg2ZTY4YytHT1BkU1RzNVJNTGorNDMreEtKT1RPRFNu?=
 =?utf-8?B?U2RGTFcwckV6aG1MUGpEOGlFOFl6djEyaC9vdFNwM29jUWdZbUhaektMYlJv?=
 =?utf-8?B?SnJ2Vk1aWjJtMmRFTFpjUGtpQkQ3RFNSRkw0ZzVGTUJlTVM5VnhjOU83d3l2?=
 =?utf-8?B?THZxZWhySE9VS3Z0eUtJODBlK3FaVjRxMU8yRStrVnlzU3NPTmRwdHJ4ayts?=
 =?utf-8?B?TlNDSXhrbEk0S1Z6RTQ5TGIySS9EWURUUGgxbG02Vzl2R01JcHkxNjVWNUNN?=
 =?utf-8?B?NktBRHJ3NE5OaE5HTTU4ZmowSWs5V0Y0aVB5TG01Y1lmK200LzFKcDVuYm5v?=
 =?utf-8?B?RmRRNHAzeEVSczRDOHZRbWNKcHlrTDBFSjNNS2tIVnpmRHlmTW1EcXBxOGVF?=
 =?utf-8?B?VFIrV21pb1ZiTnlzc2JGaGVWbHc5bmNlZlh5aFd1UFBubEZGU2ZHcWZYSmcz?=
 =?utf-8?B?aWZmTTdZdEVOVnVUQ2ltUkxUMDkzQ0xQaEwwYzZQNUtLM0xKRkUxcUdHN2hw?=
 =?utf-8?B?ZXloTGMvaXp6MEl4ZWJMNTVLd04vRVpEU1RMNUNuU3R4WnhPRUZVYjB3aTh6?=
 =?utf-8?B?eDU5cGhpUEswTXVFSVVhQllWQ1hJTHo1dHIxL2EwNi96MnR3WU1JOUFnNmI3?=
 =?utf-8?B?YVRlSS9reGt2VTEydjg1ODZpTWQ2Q0MrSlNPMi85bWpJbzFpN0xPancvSkp3?=
 =?utf-8?B?K2NGaHdvWms3TEQ0VTM1bm9UTmV2eFoydVcwaXd5aWpLdURXUEE0cG5Zc2Fp?=
 =?utf-8?B?L2dpdmdPM0tMNWJja2lWWmU0Y3JaTW9KUjNrOUl6TlhKSnJha0xLRWhFOERm?=
 =?utf-8?B?M0hMVHJEN1JNQk9vZncrQlpIcHhyWUpVWVV2NUt2aWU2cFdlTXlHTHk4L3lv?=
 =?utf-8?Q?Y/u11iR+IdIpjdzlLU6T3ZAlF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F9C030390378D40BC6F6F0F6D175C04@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f938234f-cfba-4c25-0e8e-08da78563dae
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2022 09:21:42.3528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xCbtt10PERDIek6rQgzPmW93bqIkEGHZ1rg1cE05RGhypVBGFZ4kLHT9Qpd0KCBUJIHyA6W4wfsCoj+RH8UXTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3545
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220807_022148_292934_B25EF84B 
X-CRM114-Status: GOOD (  12.52  )
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

T24gOC82LzIyIDAxOjMyLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gIm52bWUtZmM6IGZv
bGQgdCBmY191cGRhdGVfYXBwaWQgaW50byBmY19hcHBpZF9zdG9yZSIgYWNjaWRlbnRhbGx5DQo+
IGNoYW5nZWQgdGhlIHVzZXJzcGFjZSBpbnRlcmZhY2UgZm9yIHRoZSBhcHBpZCBhdHRyaWJ1dGUs
IGJlY2F1c2UgdGhlIGNvZGUNCj4gdGhhdCBkZWNyZW1lbnRzICJjb3VudCIgdG8gcmVtb3ZlIGEg
dHJhaWxpbmcgJ1xuJyBpbiB0aGUgcGFyc2luZyByZXN1bHRzDQo+IGluIHRoZSBkZWNyZW1lbnRl
ZCB2YWx1ZSBiZWluZyBpbmNvcnJlY3RseSBiZSByZXR1cm5lZCBmcm9tIHRoZSBzeXNmcw0KPiB3
cml0ZS4gIEZpeCB0aGlzIGJ5IGtlZXBpbmcgYW4gb3JpZ19jb3VudCB2YXJpYWJsZSBmb3IgdGhl
IGZ1bGwgbGVuZ3RoDQo+IG9mIHRoZSB3cml0ZS4NCj4gDQo+IEZpeGVzOiBjODE0MTUzYzgzYTgg
KCJudm1lLWZjOiBmb2xkIHQgZmNfdXBkYXRlX2FwcGlkIGludG8gZmNfYXBwaWRfc3RvcmUiKQ0K
PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gUmV2aWV3
ZWQtYnk6IEV3YW4gRC4gTWlsbmUgPGVtaWxuZUByZWRoYXQuY29tPg0KPiBSZXZpZXdlZC1ieTog
SmFtZXMgU21hcnQgPGpzbWFydDIwMjFAZ21haWwuY29tPg0KPiBUZXN0ZWQtYnk6ICBNdW5lZW5k
cmEgS3VtYXIgTSA8bXVuZWVuZHJhLmt1bWFyQGJyb2FkY29tLmNvbT4NCj4gLS0tDQoNCg0KTG9v
a3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5j
b20+DQoNCi1jaw0KDQoNCg==

