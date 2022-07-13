Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42150C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 07:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LtNvc6V/R/YhTrcmxIE46440fV1dt7BRxzlTGuLoOpA=; b=Bfz7GgYxFPqT2Fb87RZsBXkrhz
	uJiJ6WYTPIR3gGhJzFlRfdCiRqFAqLfYlUkCYoLPSye6B3u9s+pv8UhJy0EvFaeZRuWSys4JykrQe
	WsXo7I6FDcPWTPoBrLfB9ex41sDNgzjLA94BY8BTeF7Gv5hnVyqUrUV47LVEnn8jxYJdKWlFr9Hqy
	lSTf+gcDk/AFOdr8RCM2PvLjRfg8RZRqisoogv+DqZW8J/RjMoHlVgemfUPrRWa27rByWx818gYH1
	1zcsdBeQ8QTYuZ6zQCpfXpGAXofV71OUxEcdelJvH/pfbqvJvWgyPKbcq4uo6eB60TGhpZwdRjNv7
	FAfTbtNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBXDc-001Qyb-KA; Wed, 13 Jul 2022 07:55:36 +0000
Received: from mail-bn1nam07on2081.outbound.protection.outlook.com ([40.107.212.81] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBXDa-001Qx5-4j
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 07:55:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYq88wElsgdcAfT71Skljfv4S/3Q/NSyxSojOwKm51KQlT84xDPxRViAJfTNobBECyaD4kZZCkjmTvdqrmhtoa0kDR67exs+mFTgRNrsGzZCSvA4LMYKBQX86PFD6E7GNV/mHAQiucLhmA+xB1v3qNMHgiXkbkPb2FM9szD/jzvOav665OYRHCPZUxI8c1J/Ly389hbY9TRFp5f8vjyzrmCVrZMUShbkIo2LzDOvZqjuJST5FBLexxnmpLU2gXtYfoRFuHG6SM5yxT1k5z3hy7ydloufSw7iYQWiyexPSEvItRDsHs1ikKOw969l5PhlydYolVPJtM+XEV1cVoRFgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtNvc6V/R/YhTrcmxIE46440fV1dt7BRxzlTGuLoOpA=;
 b=l1XCnGAkURQmVFEHqmofDeCe/QP9av5hhst7cHpAxMCCJUlRlxHLihAfsg18zLpYIkjGL3RCCkSqzkzQgew2L6CGA6KZEjYQW0pJtp+RN7qQESU3pc950UsqyvTo8oBoC3+ZALQcCzstyucp8E5S2NFAJtteIhSEX/BD3daTnVD8kLgFkt+COFRX/d9Ly8qBHzqfPZlcuZJMpBGY2SGL8xKMlVK44rSI44muuzVYVvU8/47tKoqbOytDOlVQv5NTEE9fyXsf0SXDYM/XakHiD8wDXl6PRBFKZyLjce8qOCngJxty8ru5ChezDTFoHAOeQkGQXmEq2x/0/iSua7uu1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtNvc6V/R/YhTrcmxIE46440fV1dt7BRxzlTGuLoOpA=;
 b=Bhs0r3kFMtGMfue8lt7sJLYeLiYktK1yURsnyX92+JALTiR30y0qb8f//sjXo1RogPHWPqmTGU5n6J6LeD9cXNVllSeOi9QPWCN07b4JAWb9SZjehHl2J3n6J0GeX7gRoyil9fhJrzYVT+xSvCubwREljniab/o9CmegLfC6HdBBr2iKk4wGxFhOB1TqKkvtr8xAaKxRQD7M1Vp0cXji0ArQ1FPBUHAzt1UeoIP0swwd8qxEvH429Ea99cvyowkVaUWFV7wKoBlJa9JdzRnUwPc7FJoS7QPnqa3LRstDkYSsHTHbmVBOrEHZ4q5cXLctBSeGuUY3JNS9kscd3a/N0w==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 07:55:30 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::3cc0:2098:d2fe:5f56]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::3cc0:2098:d2fe:5f56%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 07:55:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "joshi.k@samsung.com" <joshi.k@samsung.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Joel Granados <j.granados@samsung.com>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>, "k.jensen@samsung.com"
	<k.jensen@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 4/5] nvme: factor out a nvme_ns_is_readonly helper
Thread-Topic: [PATCH 4/5] nvme: factor out a nvme_ns_is_readonly helper
Thread-Index: AQHYlnxq05VZHrupv0S5zCUcokIgma177t8A
Date: Wed, 13 Jul 2022 07:55:30 +0000
Message-ID: <cfa284bb-919f-78ae-f368-05aeb2021989@nvidia.com>
References: <20220713054914.1888305-1-hch@lst.de>
 <20220713054914.1888305-5-hch@lst.de>
In-Reply-To: <20220713054914.1888305-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4390644e-e29a-465c-3602-08da64a50ea4
x-ms-traffictypediagnostic: PH8PR12MB6674:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  N96Hvj9rVFVQi3MRqoIYGJGzSgO2vndIpNuUB3i/tPuLb8xdZHxihUhvfWydoLDMIrTZJHh7vtdJoNlB4EakDrTMEByjBjfZ0EOBs9Z8C6ViQ7zGI7Mug8okK017Ip9qpbsDLOCQUTPvU2quar9J47EwDozw4D70wU+ECM5vjczV2N42E5hHSAsnnRVZXGFiKnoy89nTTvheNBxQWYTvY+wouzdeS6Ge8JYS5HcDDGWxntBkHNfX0oP9RewmOZ3MpQnKQLiQ/M8j5Xwn4KwYtB36cUWB34j5MwDWVbMjhPIS4PqPjzpRwXKZwqPrmNvzYSIWbbA2HfkmxK85xJRq+CzA6D4UP3jElnhfQidQMdP1IsDQy+z5zx5WmuWYk41lk932EkmBrfh7oy7jhtRZn0MahKEnK/COh4f9BtVEudIgMactW/3ZB3djvmwoS3e8f6cldvC28LtXvd4YXyFc/QR+DzTzrOMcXpazj2ISFLHVGzgc0l0B6XkFGz3Jw8JuQDTvbBuGjGNZRF3aDxYBGO/Ozj1wJv+6FQA733OOzQqMo4kOKFbY+FCJw51S6/hh2g0gbwdmdFZbqU+Dbcz4O4u/L672dNuwCckVVzsjSpjhQ/xB7msJotn3ApntkDzTGTt3Xs1nImLJ8b5Xt3iOViroT215vF38BKraeE6mlfdNUJKXIlSRgibBAL/x919T3RZcWQ3BgrSnZ7S2dHMUJxvmQY61+FBm18zErLBlVxYrEdRDZm5srcj+oxbUPZx9L/asVTSJJDtHqMiEomrIqVp023acBqCHFOX3oj8/t4zyw3aoqj9ROH54xEDlrLrz60f8GBwObfHbYRRv5mBR7OTwacLrFP2IjAhdDT70LIiyRO/+4hvX/b3kPNB2Zx+h
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(558084003)(36756003)(31696002)(91956017)(316002)(66556008)(66476007)(66946007)(4326008)(8676002)(64756008)(66446008)(76116006)(2906002)(5660300002)(8936002)(86362001)(31686004)(6512007)(6506007)(478600001)(122000001)(54906003)(6486002)(71200400001)(6916009)(53546011)(41300700001)(2616005)(186003)(38070700005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?UHdFYTB6Q0JEUFJTdjBaeGhlRUN5THVVZHBRM1NuV3UyTWdZbDFzSTR1MXNu?=
 =?utf-8?B?V3lid1hkYy90NGJjSmcxYVJHcU9sMG15eTVueHdDdkhSRElqUjlFdDNKV2xp?=
 =?utf-8?B?T1g0ZUJhejhOQnV6U2hmTW5wL1NncXRheTVxWWRGT1d4M0JXVkpGMnJtT0Nn?=
 =?utf-8?B?U05kaEJodkdoVERaeFBTQStjY3ArbGVNR0RBTVV5TTZWRXlKU3BPSnJVZXdS?=
 =?utf-8?B?bUVnSjd5SWsxd2hjVVBPTjU1blBmdnVTd0tnMWtLdVJTVXlya01OVnRMUWhM?=
 =?utf-8?B?MnhKUkd1MlNaMFRvU2hCM1A2TEUzNW5yd3g2NTBQZTU3NzBaNWxveFdMS1Qw?=
 =?utf-8?B?dnpKR0JTZkkreTVQTDY3MHIvV0RELzFDVVpHUEFydjlZeUNqVGI4Q3J4c29h?=
 =?utf-8?B?LzQwV0lnQTBMSVlTMTEwUjAyaTU3dXI1aUVvZlVCbnZYL1NJSGNrQTl5UjMw?=
 =?utf-8?B?YUlqdm5PTzRqVzJaZXN0RzBZQkN5bjE4emRCREFDQTlxVTJRa2JJMGpTT25o?=
 =?utf-8?B?b1NhZ0cwZzJnVFVLWGpnSU95MU94ZUZyWThLZ0JrL1VnZFY1K3lEa2graCtk?=
 =?utf-8?B?QkNNZmUxaW8yS1FJdnNNdnBrbWw3S2w1c1QrWDh2ZlozVmZVcVJqV3JWNmV4?=
 =?utf-8?B?Q0t2VmowVDVLd3RiOVBtdGZOWUJTeEtxRWJ4Rkw1S1F0elZ6VE1Vdi9EOTZP?=
 =?utf-8?B?NTNiYjc1NFVuNXE1bXgyVXViSnFINEZqQjdRNld3MklNSktCd2paYTdiMitH?=
 =?utf-8?B?Vmw5UFpKZU9BTFBDL3JIWkNqZmxKSlNaVk9md3RMamFYQWVzTHZqUUtWU3VS?=
 =?utf-8?B?WmlpYXIwZUx2QUJhVlA5Qzh5UjEvdm5rWCtYYU9yaFRvbFRTbjZUWlRRVHA0?=
 =?utf-8?B?U1ROYlNmV1IyUlRDejZ2RUZuMUNBdXhnNkFHM2tXT1V4cUpnYzI4UEJTS3RY?=
 =?utf-8?B?RkZSa2xYUmkvcEpscU1tajVSY1RYL3duNGRJUUl0dTVaU1BRLzh4QnMyVmUv?=
 =?utf-8?B?eXJmUnF6QU1RamMyOHhnZDR0bkJwdGMwMFVxLy9FN1JXWjc0a2VnV2tXNi9s?=
 =?utf-8?B?QkdzYU1NYzVGWDg5VEpNWWdyVjNpS3pnQ00zSUwwazhVTTNaTFdIbC9oemNT?=
 =?utf-8?B?RzhsZFpSYUkwT2MvbVo4QVIvYldXZCt5ekNmbHNSNGxnV1FoS3Y5U3dySTdY?=
 =?utf-8?B?bmhzWEJRMEIyRkJnR0NkQTNjSVRPcFFVd2VHdG9oT0ZqTkFicmNpOUNEUG8y?=
 =?utf-8?B?NHRjc0JKa2h2U0N6SjNnRkQ3NHlGd3ZFUHllb1hMNEtZN0l1VkRRUG1rVlFx?=
 =?utf-8?B?RExLcjFkWVRVeU5EM05LdklCODQ3MFRPTlF6WGxYa09Va0ZwSnZDdUN4TGNZ?=
 =?utf-8?B?YlVYbEdjMmJxTDFjbE0rU0xBSkdZdHpZZHdkM2RhSHVYdDQrU3hBL2h6R0xK?=
 =?utf-8?B?QUdxUVhIOFFtYkNTVW1FeXgybENzWmpuVTAzdlo4a0ppdEx6Y0pwTmVma0ht?=
 =?utf-8?B?Ync5a0RBdXR1OFdpVlhQdmgzSmxSbzFIaEdoMVJaTDdnZnJ2Z1MxUXUxbWxU?=
 =?utf-8?B?dkd5UWkrQm5IbUdCZCtCbEJZbVhiZkVOZ1g1eDNTb3ZQamN2Y1VCL3g3K2hX?=
 =?utf-8?B?a01VTWx6N2ZSdndja0ovcCtTdXZ5SWVyWGx1YWR0dFlDYUgzb1dMTWkwaXB0?=
 =?utf-8?B?d0Z4M1ltSmxRYmQxc1krSXlsYlduSDNkT1dWdFdZRkFtZnVSekZuRlFMY0NE?=
 =?utf-8?B?dFppdG1zMHdybTBhUnovUEdUWm85V09ab0xXb09QMm1hYWRjNGh4Vm0xV0hU?=
 =?utf-8?B?Yy9oZUVYQ2V1QVhZMEszY0IxenRUaCtxZXZ1dktqV2F3dWRJQWI4MkJ5Wm9l?=
 =?utf-8?B?UkJubmNlSk42MlU4YWJKcFhNM0loZzVjWTNWb3c3Zm10OEdIOFhXeGpxOVZW?=
 =?utf-8?B?Tzh4UGxUZ0lYNmpNRngzdDJNa2NvWXVxYUY0U2VUd0VoUU02bHRTNmY3UGZ0?=
 =?utf-8?B?OGovY0lIL1RpTEg4RnJ4Zm05K3BGRGlvRTU0QlRXS0FjeGpvb3FPeHpZUUxo?=
 =?utf-8?B?SUJENGRsQzhYZzgwN3l6VnBBRHBRWUpseGp6NjFtUko4alpIYzhiVmN0TWlL?=
 =?utf-8?B?WExrSVFqK0szTGZhaUd3QVZDbVBwaURMSEFSUlprRkxOQmVkVDlWaWFHRGM1?=
 =?utf-8?Q?hzhMes15NyBvzyqdNvqDvjORoipSk9OczsGqhL2gcToQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29A29054DBC36540BFD74836D265029B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4390644e-e29a-465c-3602-08da64a50ea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 07:55:30.4214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ZBI+ERj10bTDQfcW3Wtt1iqboLzT8oQkH5kGuLqpkBMqr+B18PWeLKTGfI0eIHCNtilYYKiYHARiE4JWCZdNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6674
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_005534_206869_3B83CEE9 
X-CRM114-Status: GOOD (  10.16  )
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

T24gNy8xMi8yMiAyMjo0OSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEFkZCBhIGxpdHRs
ZSBoZWxwZXIgdG8gY2hlY2sgaWYgYSBuYW1lc3BhY2Ugc2hvdWxkIGJlIG1hcmtlZCByZWFkLW9u
bHkNCj4gdGhhdCB1c2VzIGEgbmV3IGlzX3JlYWRvbmx5IGZsYWcgaW4gdGhlIG52bWVfbnNfaW5m
byBzdHJ1Y3R1cmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGxzdC5kZT4NCj4gLS0tDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEg
S3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQoNCg==

