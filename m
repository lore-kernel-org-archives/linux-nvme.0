Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0814C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 16:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i8fyGoHtQ+m0dHat7yE5xl3kO5bcKIYfI4OQ3wd0pvQ=; b=sQgP3ZGocUL+ABpBowFtaGBnUD
	aw8zsNdYpRsLzKVtiBYwQdE5C+l3god7CjaGQhioyFR7AHw+HsP3zFXhzdohfoCmtCeTyq5hvNqgP
	XALgHcRSCTAk2BvKSRLZvS3BCjFXeBI8nA7SMxKSYJ5J9OnwaIa0DBktZNmWe6YMK1gbszhjfnv29
	TWoq7SpnCI3FxSU3sVwxEpXlUZBnD9r1gFiYTx+2qoal0R3ujBvyLMEo7HbtWXZYhjAgj93caRz1M
	NTWogr+DqNnQUY5QYN3oBD5MrLu/0f3iSA74J02HXDK2VKDZ5jK3AjT6JLVNjR1nUtGVrCa+8gEEh
	siB7HcYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUWr9-00DqWt-FQ; Wed, 16 Mar 2022 16:50:39 +0000
Received: from mail-dm6nam11on20621.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::621]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUWr3-00DqVa-Uz
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 16:50:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AItoVqOViFfexbXcOgDG5dNcuV/L3E+dbvYy89KoWE24E/enbNztH+CTAlSvueIJUgBrhr1xmHHqJXNKJ9ERSQnX1Xqkk8WFdjoy5Gsw1u4QeJ/7fWUGUVzPHch4A6llYpEQm2gvmUNlAbmhQgnsT1P7YYy98Uz5ipYbjv/DAjNixQKdumBudnehGS+mLvqu/HjWIpoOhd7NZgM6o2TJmVFkMaCGxaqqxlb1FwFndXG22Y9XtC58/MyGTUk/+1F1mn0pFEavwuVnhISU1K+/q32vpjikqJGio9rjOk91uJWgxUMC7AqoawTWiFihFpU+fGQAZLvzc3LtVymtcCnBVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8fyGoHtQ+m0dHat7yE5xl3kO5bcKIYfI4OQ3wd0pvQ=;
 b=mvDMhKmi4Xy/LyLQr6aSF9iMIDI7Phjaq2YePA89mCXD2h50v/Hay0hy74+3buwlds5i7bRozc8koq9grUMBer5JEZaLOJ2zqYjceSPkW5FJxtwovVJGoEfabjkFm65km5F/9XSFMoVLJlhgMz9cFZXnr588WJTBaMeLKEs6HejcmZEAa2LeleqU+DQ23GtZ8+9bJKa/28zZpPJN8oL6bh4fDZSx2HK7eDuvsL5jWZ1ZBfQIkDdRXScZKQUNuoaCIoDC/Sk91QU9mgSMZqTmOhA3xuVOZ9Du7PhV6fmZatMxehZp/FlHYNi4AfjFNJ6XNCkiKfz2hhM8qcVk3UJozQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8fyGoHtQ+m0dHat7yE5xl3kO5bcKIYfI4OQ3wd0pvQ=;
 b=E66HzLHe8LX63zpoRIY9JWhci7vrFMnFU0qNmA39cBZcnE1kClHL/XnbmoEswR6ltnvr9BgU+s+FlXmcgMqJofbRYG1jl1d3UNyTwurVQXqkfBI6qqxb82th/6KloE48IvDZtL+oz87ZfpzQ1958F8qWxqatE9ECvqUOvCL5y2ceEozWJe5koYJ5kj9dTwwzitQZOoO+0pkedc479GGBiE0TAg+RnxDBvMx415+8fGaIDLfEcDHmTq78/8bB35oiwvjlTxVKnsdt7bZeoJkxtXHXOY+3i6vUHSekLR4ehTguPBWFaV1LmlKgp4iq1aM0rfPzIMH34pXUZebI6Fm3sg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CO6PR12MB5459.namprd12.prod.outlook.com (2603:10b6:303:13b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 16:50:30 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5081.017; Wed, 16 Mar 2022
 16:50:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Pankaj Raghav <p.raghav@samsung.com>
CC: Sagi Grimberg <sagi@grimberg.me>, Luis Chamberlain <mcgrof@kernel.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>, Jens Axboe
 <axboe@kernel.dk>, =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?=
 <javier.gonz@samsung.com>, Adam Manzanares <a.manzanares@samsung.com>,
 kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Pankaj Raghav
 <pankydev8@gmail.com>, Kanchan Joshi <joshiiitr@gmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph
 Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme: Fix zns drives without append support to export
 correct permissions
Thread-Topic: [PATCH v2] nvme: Fix zns drives without append support to export
 correct permissions
Thread-Index: AQHYORlQ7U3+JbEzPUiEJOfuOlviEqzBxYiAgAAAZICAAAcGgIAAbL8A
Date: Wed, 16 Mar 2022 16:50:30 +0000
Message-ID: <e4ea80be-f9fe-c02b-ee53-c78ed41ef444@nvidia.com>
References: <CGME20220316093439eucas1p27c2a31849e9dec6c6bc217c5f1b26180@eucas1p2.samsung.com>
 <20220316093423.17906-1-p.raghav@samsung.com>
 <9498d380-0172-dae0-9354-bd4d725fff5c@nvidia.com>
 <6e19b134-3ba1-432f-092d-ea526f09ef35@nvidia.com>
 <093f80d1-580a-11c5-057f-a231ecf99bae@samsung.com>
In-Reply-To: <093f80d1-580a-11c5-057f-a231ecf99bae@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf7e55e2-1caf-49e9-f8aa-08da076d14af
x-ms-traffictypediagnostic: CO6PR12MB5459:EE_
x-microsoft-antispam-prvs: <CO6PR12MB545942FA4F7545DE47E8CDD1A3119@CO6PR12MB5459.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HzfQq9GjAVuP5j4s+E0tyA8T3z5nyVTmxlT9x8JhV7opzT6EZhRQHZZVT9cgsUlXwQpY4R/geX0q7o97UhkaBWxV6iVtHKrwcVO9h+51oYRiB3ULvVKffEFow8fAEDw/ES12L8A6ppV7lFWgGiB22qRrNRwcyo02LMcqih8TWGp4lxjkdpTtDXaasYGtu1ALAkMbwKuUMqYT08kbX5YBWIth45K6d/7cLA0V+i3Roqdqve7WHmZF3YmBR5yJ4hBjsUSkBDJQr0UQ0bkNIyRg0whK5pDJCoX0uJuuzNKcWdn1dUODrBCPlAnZgLGto+aKMexpUkHaBqQnFJgKEVjYE4r9S/lz+lWo0DtCGfl61IMDh4As9hd7uRwJVhlkgVGQvyOwwbVOabiTkvgn5Pjtx38jRDBbbXDV3zo8CMwYd0xC7snkOX69MIbtl0E/LOf3PvJNwodVWsllAmXrAVY6G2gbopdHuPjxB9ejVbbbYYRl8za7B+MUPALFhN7J+tEmuZD4ufqVm1+G12VtHOI/icvfeN8TsalVLXeyvu2EGoztSX4SsfiGmjAQDpstA3MWIIHW/Z9a3QStn294l5C8cYJhXTs17hUO4l20Jr7HVV7quPbIRdDnGwGdBwSM7rM+cwpzfa4/mTuGK4dIQgMTAxi9fPTz+Mud4rm1vh5+kzZs5RcFvs+ZW5f8nSQx1FjRm1e4ZQHdaOuLxSp+ntukN8ZaoRwEbOXFb33M66EXtSqz9Ve542o/7dbY0nMxm2Jt4Em2FtjS35dOEZ67t7BQxw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(4744005)(7416002)(2906002)(38070700005)(5660300002)(6486002)(83380400001)(508600001)(122000001)(53546011)(38100700002)(2616005)(31696002)(54906003)(6916009)(6512007)(186003)(316002)(66946007)(66556008)(4326008)(66446008)(64756008)(8676002)(66476007)(76116006)(6506007)(91956017)(36756003)(31686004)(86362001)(71200400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXlMVGk1TUNyL0lEK05PSzRsOVdlbXU5MC95V1NYaXhaQ2g2S0hhcDFoTWJk?=
 =?utf-8?B?SGk2QWRFTkxuOHRnVEhNaE9OTVhYc3BJdDFlSzNpK1VRbkRaOTJjYXFabkx4?=
 =?utf-8?B?TFIxVXB4MDd0UkZwZ294bXIxMWJsRVJTOWJLZ29RbU9zN2Z2dll5N0tXZGJM?=
 =?utf-8?B?dGdadmhyeS8yRlZiVjROUlRHUSsvL2tOTHduVzBOQmNiNEJxVHpvdFRjWVF0?=
 =?utf-8?B?UHk4WTVZcDFFZzVwcjB0WFlOWGhaVWx1bmFLSitsWjRtUERwUEhlVC9ML2NJ?=
 =?utf-8?B?SEpvSG1rM1ZsbGhQaThRVWY2dzNoY3krdDh6M1R6cmFCb0tLRmo1aWNyMXVz?=
 =?utf-8?B?dFJuMEVmZlhnbTArZXQzbnBDRE1wZmxnNHpManFsVGNjazVXNFVLZmlkSUZ1?=
 =?utf-8?B?bWFLeXovOEkxN0p0RVVNbEZVSFVMdTRBbzQwTUxLMklPWHVvZlp2RHJpL0RC?=
 =?utf-8?B?SThzQVd2OCtqVERRY1RqaFJPaGpvWkZsVUUzWXZiSXZrWHNObHNxR3dRSUdq?=
 =?utf-8?B?YXJQOVlNQ1dxdG9HRWVtNUF5MHFWM21pYlNram9jM1NZUm0xUzdBeFVWRnRh?=
 =?utf-8?B?amJCWWF1YTJpUHhlT2ZuRzVldmZtZ0p5K1FGbFdsYlE0T2hxdFJVTTgvdGwz?=
 =?utf-8?B?OVdPTFY1K1o4MU11d2tNeGFNOTJpN0pPRDlBeVEvcjBIWHNZWHBLcXhzQTBz?=
 =?utf-8?B?NFpMOUdxK0tmb0lwZkh3d2ZtajBySU0xVldxaWIva05jUlBoL0pNR01UUmRo?=
 =?utf-8?B?emwrV1dkZ1p0RVhlZzUzVGsxODhGMExGNHc5aUtNbVJua1ZBc1dWRHoxdWVn?=
 =?utf-8?B?bG9pOHdneVUrTXE4dDQ5Z3ZqTStaOTJadzJ0TGkwQ2s4dWxNSmloTS9WbzMx?=
 =?utf-8?B?S3cvaVFlOVB5cnZpREJOZ2U1S0o4RWN4eFdldnVjRXJWb0hJdVdOWlNSMkRW?=
 =?utf-8?B?S21Ob2wzSXN5bFovUE1qRklaZnluSmYzSVZ2UGE0cDhpUVNjeWl2MkwybzNV?=
 =?utf-8?B?NGlJL2hJcGRjOVpkeDcybHpBeStYdTF0NkdRQTBjUG5McVZmdzRJbFBqbFRs?=
 =?utf-8?B?ZkROekd1cnFOSG1HZHdaeFQwUmcweGdScW5WNGJzR21YbTVWcTEvUjNrS09a?=
 =?utf-8?B?azFGRGl1akNWbTZQMWhiM0h2cWxrWXkrVVBjV1RiKzZGUDhjRytQV1dGMmN1?=
 =?utf-8?B?c1l2aCtVL1B2MmxsTXNHZUZ1enlHaWRZbENOMzFHMjVUdFhmbGFqdlBwalpx?=
 =?utf-8?B?TnZtMStNNkRLOXpzRHJndENhYUJXQTdDdWwwT3pJdmxvc1EvZk85ZUtSREVK?=
 =?utf-8?B?dmRodTI1d2djK2VqV0ZjTFBIMVdJcEJ1bi9STlp2YlowYklGOUF5dzdhR1V0?=
 =?utf-8?B?TVBpenN2WXZ3ZXZhV05tcVBWVWV5b0hLSFJCRmxHb1RBcHFWLzFJYWlSUnJB?=
 =?utf-8?B?d3FISVoyckZsd2k2YjZ1TnJCYW5FbXVBMFZoUjd3WFY0WE5vZ2lwNGhNVWZW?=
 =?utf-8?B?QmIvWDUvcFVzZVIyV3lGWGd0dURtenpsdzg3YXB6cURSTmJBVUxGekE3VEFk?=
 =?utf-8?B?a1hMN0NwWDJ0ZXluS1JEeFRxbTVUdkRySFY0TnBnQVc4QmlkR2paU01CNzVu?=
 =?utf-8?B?dGErYXhrNmNNa042TnpESTNidFRQbFM3d0R5S0F5cFFoSzFLdHl4NGxBMUdO?=
 =?utf-8?B?WnV0ek1VbXRIQW1yVkJkcC84ZWZ6SXBReTZWU21PTnN5aFhyZzhyS3J4Qy9D?=
 =?utf-8?B?cStuRUJ2WFdHT0ZlSzI1Vm5hQjZoVWQwTlp0MGVYa0NYMmhwTUpUS0ZVUkpx?=
 =?utf-8?B?MUlRV3B5TjdHZzFwYXZySE85WFVMVFo1SC8xZjBGYUlGdHczekhOUlBsTlJH?=
 =?utf-8?B?UDNDMU5mM1dXRis5aXlGRE0xTUszcWE2dWNLWnpWR2R6MHNhS1hUcEpJZW1o?=
 =?utf-8?B?dXJxTER5NTRyZkNoWS8wRHI2WFB5Ty8wS0ZlOUMrdWhhWC9zSDF2T2I3Vmg0?=
 =?utf-8?B?SjZQWTMxK1p1Z0x2K2J3SFkzd0VHaFlLMnNGcXpMYVZnRisyUlZna0dFRWJl?=
 =?utf-8?Q?0GU94p?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD4B8606A2B5254086EF39B01837C83D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7e55e2-1caf-49e9-f8aa-08da076d14af
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 16:50:30.5315 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6hxC3Gj8i4ISlcMi87x1KyGlv4ppxFSXCzH8O5dT/pNjDFGHEHhHXHpGfONX5wDn3GskCW1XkpOAuU4dJGbhEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5459
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220316_095034_085003_571D66DE 
X-CRM114-Status: GOOD (  13.73  )
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

T24gMy8xNi8yMiAwMzoyMSwgUGFua2FqIFJhZ2hhdiB3cm90ZToNCj4gDQo+IA0KPiBPbiAyMDIy
LTAzLTE2IDEwOjU2LCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBPbiAzLzE2LzIyIDAy
OjU0LCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+Pj4NCj4+Pj4gK3N0YXRpYyBpbmxpbmUg
dm9pZCBudm1lX3NldF9kaXNrX21vZGVfcm8oc3RydWN0IG52bWVfbnMgKm5zKQ0KPj4+PiArew0K
Pj4+PiArwqDCoMKgIHNldF9kaXNrX3JvKG5zLT5kaXNrLCB0ZXN0X2JpdChOVk1FX05TX0ZPUkNF
X1JPLCAmbnMtPmZsYWdzKSk7DQo+Pj4+ICt9DQo+Pj4+ICsNCj4+Pg0KPj4+IERvIHlvdSBoYXZl
IGEgc2Vjb25kIGNhbGxlciBmb3IgYWJvdmUgZnVuY3Rpb24gPw0KPj4+DQo+IEFUTSwgbm8uIE9w
ZW4gY29kaW5nIHRoZW0gaXMgYW4gb3B0aW9uIGJ1dCBJIGRvbid0IGtub3cgaWYgaXQgd2lsbCBi
ZQ0KPiBuaWNlIHNwcmlua2xpbmcgdGhlIGNhbGwgdG8gc2V0X2Rpc2tfcm8gaW4gbnZtZV91cGRh
dGVfem9uZV9pbmZvLg0KPj4+DQoNCndoeSBhcmUgeW91IGJsb2F0aW5nIGhlYWRlciBmaWxlIHdp
dGggdGhlIGZ1bmN0aW9uIHRoYXQgaGFzIG5vDQpvdGhlciBjYWxsZXIgPw0KDQo+Pg0KPj4gSXMg
dGhpcyBmdW5jdGlvbiBpbiB0aGUgZmFzdCBwYXRoID8NCj4+DQo+IE5vLCB0aGlzIGlzIGNhbGxl
ZCBkdXJpbmcgaW5pdC4NCg0KSSBkb24ndCBzZWUgYW55IHBvaW50IG9mIG1ha2luZyBpdCBpbmxp
bmUgbiBibG9hdGluZyBoZWFkZXIgZmlsZS4NCg0KPiANCg==

