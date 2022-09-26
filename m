Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882CCC6FA82
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Sep 2022 22:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IsrxKzth28Ki01xHx+KVU8NbDZua2pWDL2xqGR6XWh0=; b=WTngPdlAqPOjEubiL1r4A9c8l/
	IIRH40nUGt82ytGNlnVQ7d/VUOseKihiaHFlzmtzo8mXLqKsXuwPJGbNfE3kfAD9iO37rk9H5BzNX
	rHkDj0iR91lQwK5rGdqmqR7+PjKQRN/84jP7CAAHJNH62DhltCjG7BfPh1vvO8nkjRySl5I6VcMv3
	fFUpUDxv2cvNcDyuDh61z8rQWNxr0jY+6Gf1+xxzrqb9Et32jriyPw5K2TOL04bgh/5TIq+mffNqH
	2QfoLl5nISw+7244C61kNpv7+vxfD5KE7J5QAL28wBv+xGN/ZKjaWdO4sV9i+y5LLCrtc66WW3H73
	VRNkn0zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocwXQ-007AT1-N3; Mon, 26 Sep 2022 22:25:20 +0000
Received: from mail-bn8nam12on2041.outbound.protection.outlook.com ([40.107.237.41] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocwXO-007ASQ-Ap
	for linux-nvme@lists.infradead.org; Mon, 26 Sep 2022 22:25:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZ11Pzrlhfa1cEWIWb8c5cyagv96tB7wwnc+XigpHr2yXhTNDdOUtOmrEQIQKxFTizdOzvfhzURU8vjBCs0QJ6P7T6DcUgTJY+LRa5k41u3vYKuJiPFIung+S1EZjXK1BwyghbmZi9SBz5RecTIfa3BAD7+8TuMCpvYOx6znKzO18pARlRdjthkc2jj0G598ymB0a0Vah0XmGrl9l/NT8VT9EzwSqMl1kkedpFYtCi57lAdJv//nXIiHShFQukuEWpUG2q+JkLKoGqY9vfCNi2M75v1fE6MaWmN6VMFGExG2c+vWeRHQQyj07412Rmn8XeH/3lo7GiZuqf5WoHCVHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsrxKzth28Ki01xHx+KVU8NbDZua2pWDL2xqGR6XWh0=;
 b=En9o9J2gzEN2Lhnws+GA81ejgwcaqW40Xhs3Y4tdu9UIh3kp+zINDuT7GVhlvKzrGKKl+lvod1gvGzGoYA7SPkbLi1NJHZMZMRiC9f76v1Xw0hJIVHW2dROgCVWknj5RM4FJxrM8pW5nf0n6++p9PHQXfQLCUdeuVuBE277sAtpIjD0l779Cr4OlHb/yXQG6aFv7NhX0Ump/l12iCvGj5iA5nagcmyHT2H5mHVjj806KXBrC7W+WO+vMAUSK/qihKj8MkUJauljpAB7Kt4+sbZ3M5zwVrSoLWHOT/jddgoKR1rd4h7jftFKRjW2j7OQOucREhkU5ENwZm6PWP9lUAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsrxKzth28Ki01xHx+KVU8NbDZua2pWDL2xqGR6XWh0=;
 b=Y6buksQfH4KCmHhKlHizLv7UNMfYhfcG/tcFkCUubVvB7YnjH2nCT1WWV7AOtrUGPNRVJ2HeauYeUBRzUGfr0/RotG0m8Tg5SgpgCjlcmtmzpSCnZNhFyktKXRPmT7744msDkUi4XxCi4df/h+MeGmREacQVtWPrzKcGPoPdw+ovii3HsTQMhR9riLz+nBAjVlMepazfwTUj6DkbttEiLXATumLe66jqT7+dClw8aTZPiYxugkCFxDvAFN5UKl99/kOSN6uBaM92IDMdgzpEAXmmz1e/+W7zrUqvMPs3AC8AhHKe+u4nvOdVeMzCs4Jpsx2MeGz6LULqpnB+gMKTsA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CO6PR12MB5441.namprd12.prod.outlook.com (2603:10b6:303:13b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 22:25:12 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 22:25:12 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Kanchan Joshi <joshi.k@samsung.com>, "hch@lst.de" <hch@lst.de>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH for-next 1/2] nvme: add the permission-policy for command
 control
Thread-Topic: [PATCH for-next 1/2] nvme: add the permission-policy for command
 control
Thread-Index: AQHY0bl9XH/1sm1U0EibMApUjXXaIa3ySjuA
Date: Mon, 26 Sep 2022 22:25:12 +0000
Message-ID: <bd90c4cd-18d0-0c47-9265-dd462b21fa90@nvidia.com>
References: <20220926145430.81658-1-joshi.k@samsung.com>
 <CGME20220926150439epcas5p160506693c35f94eec80f26e34027988f@epcas5p1.samsung.com>
 <20220926145430.81658-2-joshi.k@samsung.com>
In-Reply-To: <20220926145430.81658-2-joshi.k@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CO6PR12MB5441:EE_
x-ms-office365-filtering-correlation-id: 8ca2f45c-bd6b-4e76-9ba0-08daa00dfaa4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  3aMZyikjE9cDvpoIDojI/2VGdN5dw799QRREr3uRR73sETr0K/oJOsB/L4UqcHMHTbEuDG5EAFdGKFZ5JACnx+cTddEJhUDIuZB8zdln0/NAuB+NUN5CoZPDIeeFK8+W/tf670mbEDATJNgKfb/n3tkVEA0cCU6KeA2/IDnjWF5BeilVUpEVoKMy75a2JeTof/oaPnprtdSr+zxeAXRLqnt71FI3Bop4kvDKIvM1Cnq06azhdsq+Tc2CaSxvhkX51TU9umbE3QT/rjuhRIMVjn5T6/ag37/EmzfqtlzBJh61F2LBKE9X5X/RgmoyF3tY4OW2SZu6aB1hPv7mUxvZaHkbHaVlNwMJs1YqEWiFs4bkedPp1Vn2pSfdg5tV0mMTsQ6ZXMtwNVfsmuItwLZcGBl1+UTvptYV35+aNgHnijDVpirO8lJih4AXHg+0UIRTB1UPldmEoXHCUJyq3nfPymJUPXMMatMzGspnTrnRmayZzPqVN91z9xTuXZ4QW5N3MdnTOVaRrTnvu6pAFl3DuIcerUQi934zNf7FC5BIzFV19K5gfmSxT4Ejfuaz6qHFSplW2tVpy26ho/B3cuy/X4ZyQqWdRh1oXvRMaSUdk/fnHOZUt12qt5Asf4gxdQ7AYC6wiLagzrkA7LGQQGT5zXsefNhJUNeYj7nDO/MNz2jDmg1CbMTzm0kNaSKwEOLVI1Oef1ug0OfPuLjuu2gA06LK32NWhrvkAAb00JYL8fvq8D7TDYz9ZIWQw85lzL3J75iWh7BorzgEhVyIWuN8U4n0lsQXxsSR24r/AHqGJ9LMDOTjOievcpXbg3eKsDzsWSkibwxrKWlWyIXKdcWndw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199015)(36756003)(110136005)(54906003)(31686004)(31696002)(86362001)(38070700005)(5660300002)(2616005)(38100700002)(122000001)(83380400001)(186003)(6512007)(41300700001)(76116006)(478600001)(6486002)(4326008)(91956017)(66946007)(71200400001)(66476007)(316002)(8676002)(66446008)(64756008)(8936002)(53546011)(2906002)(6506007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?ZzJ6ckxpekJXTVE2ZzFvRitVNFJadldMSS8zV21Xa01UcW0wVElyZUZYd21m?=
 =?utf-8?B?V1NqWmd0eGRPSzdPUEZVRU40M0hKUzR1dWhSN00zTlUvYnFyVUk1aVV1N1Fo?=
 =?utf-8?B?RnEwanFFVnd1ekpYdmlGaVFOL0E2ZTRXVk11M1I4a2IyVi9jUGZRRm9wb1lO?=
 =?utf-8?B?K1YyUVF0TjJ2KzdZZHBycVJ3K2U4emorbS9UYVlDVGxmL3I3c09UOHd1dUNw?=
 =?utf-8?B?U3ZENGZuclNlU3ZMNkxueWxPdm5iTEpBeFN2aFJLZmlWSktlQWVvVmxUWFIw?=
 =?utf-8?B?Qkh6Ykk2MTNyK3lSYisxNGZtekp6MmRxU3EwYUNkenF3ck1EMjR0eDNzTXFD?=
 =?utf-8?B?QjlTc29vSnYrT1loKy9hejBNaGFjaW84eG0rQ3FtWnhuTHBZcTJDazNiNThW?=
 =?utf-8?B?TzlTNm1EL3FEaWNUZko5TllMbzhUcGJkUE1ZdnQ1MGlwa21TRm5sc0cxQ0ZK?=
 =?utf-8?B?bWJVRGc1eG00SkVDNzFhYXBKRURGaGZQYUNkd0loYkNqZXpiMDJZNFJRWkdh?=
 =?utf-8?B?ODBIMUVMNTNBTGZnZnlHcHhFT1FpOHFHTnBPM3BXYytzdHdZYm9zOEZpTEYv?=
 =?utf-8?B?b0ErbDl6MHpJK1pGUDhSNzVEYUJ2S3ZnVlJrOWJOaytvdThaYm1Ua1RVV043?=
 =?utf-8?B?bDVyREhraHZuU0lrU2tEd3ZpWjZjSjNRenBTTGxRZnFEZmpjaTBPNGlqMGdr?=
 =?utf-8?B?UExJVndoWldSQzlkMm1idGRTMVRJNHhPd1hhek1TQis1N1VldG9EWTN5NGtV?=
 =?utf-8?B?NGduSmlhbTZNMThVVHpzcjVrZEdrWjY3TWxsQ0FoWVhpd1l4UjZ0ZXJZbUM2?=
 =?utf-8?B?c29ieGRYZFhDVUZmcjNSYjQyK0laR0V2Nm5GU01weVJlakFmbm9zaWNJbUdj?=
 =?utf-8?B?WUp2dFNOaTRzSC9IM3QrdUtDZWhDNzBrKzF0bnBsZTl3dmxidXE2MS9VeWVM?=
 =?utf-8?B?WGxUdkVpUFRLZFNSWnNvRnErSmdEdFF3V0s0TU1ndHgrTEdHb1dBOUxqb3Nv?=
 =?utf-8?B?RndVUWROZ042cytOcXBncmhiK2djTDJ0Q1IxT20rMndvRHliRlJEQndndFlT?=
 =?utf-8?B?UHZTR2Y0UnNINmU1Sjk1ZFlXWGZzcTBGM1NSa0prYkNZU0d3dUNuMHZjT09u?=
 =?utf-8?B?R1VBV0RBMWZTTVA5OExNU0VkV21RNWREME4rWmNHQlBFUUpDN05KMnRJNzg2?=
 =?utf-8?B?c3B6VjB2SENmUDZGZVBRR2JwTjVMWURjSC9vZ2xtVUlBNkZib0MwNHZkeTgw?=
 =?utf-8?B?RnVOMSt2OEwxYWNlcXFvcjc5aEszNE9tVTFFN1h3VFhsaHVVZ0wrZ3pOSnNV?=
 =?utf-8?B?MjRkYTBzeHVBQlErdmNsUDRidmt5YnBtd0V2T1pxdmVHR2RkckpSWndJeTVB?=
 =?utf-8?B?NmREdGdPTzNPamh1cm55ZHFBcWZUNWVyL09XclRhNzBtOVpPd3NmVzhQMGVr?=
 =?utf-8?B?cEVUZFR4VTBqNWh4SjlpU0ZQNC9BbnBQNjdhNEZ6Z0Q4R1NUU1ZGN3ZTeWdJ?=
 =?utf-8?B?NEtyem1KZGNDSnZiYjdZbW15d0U0Uk5Qb1diL2VWY3h6czNhV1NUeUEzUlhS?=
 =?utf-8?B?MnFpZm5KNjkyVHFqZ3pvazBGc2Nucy9teS9BWHMyYlZua2QyNzZhZDdrWThL?=
 =?utf-8?B?VnBRRWV5SElteVNRYnRYNUdSSjY2amtBRUdtVmo5NzlIREJaZUVaVFpMZU1J?=
 =?utf-8?B?c2xYVXZldFAyUlRmMlRKeFlVN2ppWFZXb3I2d1B5Ymxwdm4zazg2bi96akFE?=
 =?utf-8?B?YnpCVnR1TWhPUGkyeVJRekhnaGIybVF4YUFnWEZsNWVyVmxBcjBZOWtrUm1a?=
 =?utf-8?B?QkdFOFVsYU5VT1lISE1hdVFaeFhPRTVOQ282cVYzbXZsd2dpN3YrUVBCbTF2?=
 =?utf-8?B?SjNwUVFDZkN6SW90Z2xWWGUyOE8wbFFBYTdFdURJaFJGMHVZVGpsRGNBUHhW?=
 =?utf-8?B?Y1pVRUNtai9sMEwyenpUVDlBTUd2a1FkVDZFVzJFWlBlRWVKSEFOL1owZHI5?=
 =?utf-8?B?QXdlcmlqMkFMV3pwcTBLTytMc2NzSEpWNzhISFdEcUFxVTlXL2p5ZzNCakhS?=
 =?utf-8?B?eDZqeDlycGVxSG1zbUU5WVY5cVBVRVByRUxIS2tEQnlIS2g2QXZldGNING0w?=
 =?utf-8?B?NXQ4bDBGVWNSTU9sM3RnNlhuMmpZbmw1ZnBuN1JrY0djVmxENHFyMk1iQlZM?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80A2B264A7220946AC3AF38A786FC837@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca2f45c-bd6b-4e76-9ba0-08daa00dfaa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 22:25:12.5988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tzUpKhqZvjDW9q15oT3UIF32qEjUMzMF/2O79/3qUcpZkEShsnsLpU5RwA3FysoygpYN5rdHmI2dDeFwPTQwUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5441
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220926_152518_398429_056CE297 
X-CRM114-Status: GOOD (  23.47  )
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

T24gOS8yNi8yMiAwNzo1NCwgS2FuY2hhbiBKb3NoaSB3cm90ZToNCj4gSWYgQ0FQX1NZU19BRE1J
TiBpcyBwcmVzZW50LCBub3RoaW5nIGVsc2UgaXMgY2hlY2tlZCBhcyBiZWZvcmUuDQo+IE90aGVy
d2lzZSB0YWtlcyB0aGUgZGVjaXNpb24gdG8gYWxsb3cgdGhlIGNvbW1hbmQgYmFzZWQgb24gZm9s
bG93aW5nDQo+IHJ1bGVzOg0KPiAtIGFueSBhZG1pbi1jbWQgaXMgbm90IGFsbG93ZWQNCj4gLSB2
ZW5kb3Itc3BlY2lmaWMgYW5kIGZhYnJpYyBjb21tbWFuZCBhcmUgbm90IGFsbG93ZWQNCj4gLSBp
by1jb21tYW5kcyB0aGF0IGNhbiB3cml0ZSBhcmUgYWxsb3dlZCBpZiBtYXRjaGluZyBGTU9ERV9X
UklURQ0KPiBwZXJtaXNzaW9uIGlzIHByZXNlbnQNCj4gLSBpby1jb21tYW5kcyB0aGF0IHJlYWQg
YXJlIGFsbG93ZWQNCj4gDQo+IEFkZCBhIGhlbHBlciBudm1lX2NtZF9hbGxvd2VkIHRoYXQgaW1w
bGVtZW50cyBhYm92ZSBwb2xpY3kuIFRoaXMgaXMgYSBwcmVwDQo+IHBhdGNoLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogS2FuY2hhbiBKb3NoaSA8am9zaGkua0BzYW1zdW5nLmNvbT4NCj4gLS0tDQo+
ICAgZHJpdmVycy9udm1lL2hvc3QvaW9jdGwuYyB8IDE5ICsrKysrKysrKysrKysrKysrKysNCj4g
ICBpbmNsdWRlL2xpbnV4L252bWUuaCAgICAgIHwgIDEgKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwg
MjAgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2lv
Y3RsLmMgYi9kcml2ZXJzL252bWUvaG9zdC9pb2N0bC5jDQo+IGluZGV4IDU0OGFjYThiNWI5Zi4u
NmNhNjQ3N2RkODk5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9pb2N0bC5jDQo+
ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2lvY3RsLmMNCj4gQEAgLTIwLDYgKzIwLDI1IEBAIHN0
YXRpYyB2b2lkIF9fdXNlciAqbnZtZV90b191c2VyX3B0cih1aW50cHRyX3QgcHRydmFsKQ0KPiAg
IAlyZXR1cm4gKHZvaWQgX191c2VyICopcHRydmFsOw0KPiAgIH0NCj4gICANCj4gK2Jvb2wgbnZt
ZV9jbWRfYWxsb3dlZChzdHJ1Y3QgbnZtZV9ucyAqbnMsIHU4IG9wY29kZSwgZm1vZGVfdCBtb2Rl
KQ0KPiArew0KPiArCS8qIHJvb3QgY2FuIGRvIGFueXRoaW5nICovDQoNCkkgdGhpbmsgYWJvdmUg
Y29tbWVudCBpcyByZWR1bmRhbnQsIENBUF9TWVNfQURNSU4gaXMgc2VsZiBleHBsYW5hdG9yeS4N
Cg0KPiArCWlmIChjYXBhYmxlKENBUF9TWVNfQURNSU4pKQ0KPiArCQlyZXR1cm4gdHJ1ZTsNCj4g
KwkvKiBhZG1pbiBjb21tYW5kcyBhcmUgbm90IGFsbG93ZWQgKi8NCg0KYnkgbG9va2luZyBhdCB0
aGUgY2FsbGVycyBvZiB0aGlzIGZ1bmN0aW9uIGl0IGlzIGV2aWRlbnQgdGhhdCBucyBpcyBOVUxM
DQpmb3IgYWRtaW4tY21kcyBvbmx5IHNvIG1heWJlIHdlIGNhbiByZW1vdmUgYWJvdmUgY29tbWVu
dCBhbHNvLg0KDQo+ICsJaWYgKG5zID09IE5VTEwpDQo+ICsJCXJldHVybiBmYWxzZTsNCj4gKwkv
KiBleGNsdWRlIHZlbmRvci1zcGVjaWZpYyBpbyBhbmQgZmFicmljcyBjb21tYW5kcyAqLw0KDQph
Z2FpbiB2ZXJ5IGNsZWFyIGlmIGNvbmRpdGlvbiBpcyBzZWxmIGV4cGxhbmF0b3J5Lg0KDQo+ICsJ
aWYgKG9wY29kZSA+PSBudm1lX2NtZF92ZW5kb3Jfc3RhcnQgfHwNCj4gKwkJCW9wY29kZT09IG52
bWVfZmFicmljc19jb21tYW5kKQ0KPiArCQlyZXR1cm4gZmFsc2U7DQo+ICsJLyogYWxsb3cgd3Jp
dGUgY21kcyBvbmx5IGlmIG1hdGNoaW5nIEZNT0RFIGlzIHByZXNlbnQgKi8NCj4gKwlpZiAob3Bj
b2RlICYgMSkNCj4gKwkJcmV0dXJuIG1vZGUgJiBGTU9ERV9XUklURTsNCj4gKwkvKiBhbGxvdyBy
ZWFkIGNtZHMgKi8NCj4gKwlyZXR1cm4gdHJ1ZTsNCj4gK30NCj4gKw0KDQpUaGlzIHBhdGNoIG5l
ZWRzIHRvIGJlIG1lcmdlZCB3aXRoIHRoZSBuZXh0IHBhdGNoIGFzIHRoZXJlIGFyZSBubyANCmNh
bGxlcnMgdG8gYWJvdmUgZnVuY3Rpb24gaW4gdGhpcyBwYXRjaCwgdW5sZXNzIHRoZXJlIGlzIGEg
c3BlY2lmaWMNCnJldmlldyBjb21tZW50IHRoYXQgc2F5cyB0aGF0IHdlIG5lZWQgYSBwcmVwIHBh
dGNoIGZvciB0aGlzLg0KDQotY2sNCg0K

