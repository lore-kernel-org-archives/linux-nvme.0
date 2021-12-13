Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B5BC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 21:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ptf3R/GjqSEjvS+sn4nleLXhu0S7Ta3+4vMb9pMzXy8=; b=AurIa03AEbDBNEFROX9f7lLyTT
	GAeHUquc9dET08dAMO10FLFPA/86HzKIZcWHHjBQ58FdCanWzfaIEVevY0pwPr7XrD3B8T039ETEu
	JbCP4m5RYyeENr8wFH4z6USe5q/njFaFp2+D612YxNw49n5NEWsLtuecFndPOkTmRu6dzmLl0Bido
	3CfTLImP+sWnkO8QJwiQPA9gr4vK6NycMokip+3Bktaj3Uw1XrT20pEMqOUh6V9BmEV00Q4eU1AUA
	mOVsMMH2e37cK2hT+lypUn6NZXq+BvFe3dPSVHKvd/xnHmOC8z9xr46PaTpaSCtx/9I4XFqTsLF0V
	6LHcIHBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwtAW-00BUN5-83; Mon, 13 Dec 2021 21:47:36 +0000
Received: from mail-dm6nam08on2060b.outbound.protection.outlook.com
 ([2a01:111:f400:7e8b::60b]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwtAT-00BUMM-A8
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 21:47:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZYU5V+4e4xcc0Tdj+/H9oXxBqQ6BAY3Hc6gIkgQ8/3PI2O1v5kXYNYIVwi/ukhVtdZT8jnqXlNimMwcGIEAbxgaxwNCTLto3L/u8fbaL1WF+SEOVkam48UFxsWDHaJyqMwrZxXfOhikFYU0d4APcOnNNlkr7S7oRXpRqGMeh7H5lbR3034VUSZFDPx6oKQJIg2ooytfadHhzxdZOqF0vRbVNGQPm6O+LcIFzJ9T8xnq9breor8evA9XupQ3e8ClIphrDUR6OaTWGfCMYQApMA9HffkTdudGMpQy7HwQq8wFEepTLaJxvqz+ER37mN++j82bBPyRvtMJpBO4MVTHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ptf3R/GjqSEjvS+sn4nleLXhu0S7Ta3+4vMb9pMzXy8=;
 b=bCgLEhVgDuMnz+rw/5iSbgj4zUzLVwRkZbA/N40s2ERq12X3jPloji06pAzS/Gs+nRcgRUe2X9krxoMNIvkorcjkW8gVlB+EMM3z4v1UoslJdxRebKzY1yfFxpsVlhlDzBLzVgWqBT5ixP6wsOxGWBaln/2uIqWqyLKTc8lNoA7o1gCFYy0AtkQSNX5svCgewVTQeZkh2RrHgFv+nN9YYZWDqhW/oM2HDt1K6Y9WQ4y4vPPigzd+zj1rDCNxJBe+kTUsXJHV5rzZQwz8uQyWmMSMVQdf1tb9yRXV2RCWOKbmBkXnGhBC+AvHCfyWe+/eQpq/gWZPXbhGs/wiV/q4XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ptf3R/GjqSEjvS+sn4nleLXhu0S7Ta3+4vMb9pMzXy8=;
 b=Ra+NoJeybmB4dyGqj8E6+4qE8xmpi6iOto7vFdi0QZPKWC0A17GA5tqu1vU7lN+tk2UpwYkQX+pOjAEq1fPeSZNFdj4d5IgzWGVl0uz13ZB76eekFFNJ3Ydkgq9winY04r5kQUZB09mpwS3hMsEgujQImHwQhysO78cUr0y683dj0XnRmS3B4rDtwaoXX7sdOu/zXuBABdTBW0mgAbndnR81jLkfaA8sGKIksjxXXbvkOVYb9X4mJHywSUluDLvl/T4YGHDBPFODKe83GqPmtm0z20T4rF+BomDnASrx6mUaQMof5mwNETVnFNbS1H/R8FzNoxibz655myYNfLF5pQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1200.namprd12.prod.outlook.com (2603:10b6:300:9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 21:47:30 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 21:47:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Martin
 Belanger <martin.belanger@dell.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2] nvme: print out valid arguments when reading from
 /dev/nvme-fabrics
Thread-Topic: [PATCHv2] nvme: print out valid arguments when reading from
 /dev/nvme-fabrics
Thread-Index: AQHX63JqEKcF6ORjXEKKwrrLgmPDsKwwGcEAgAAJJICAANxCgA==
Date: Mon, 13 Dec 2021 21:47:30 +0000
Message-ID: <741fd9d9-8411-dadd-96fe-c2e46863d33a@nvidia.com>
References: <20211207135549.100950-1-hare@suse.de>
 <6ba69fc7-d2cf-664d-5289-89ff932b1539@nvidia.com>
 <fe706681-4897-6cc7-3595-668fe824a1ed@suse.de>
In-Reply-To: <fe706681-4897-6cc7-3595-668fe824a1ed@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 800ab1ec-b3f8-4ab3-3a71-08d9be822998
x-ms-traffictypediagnostic: MWHPR12MB1200:EE_
x-microsoft-antispam-prvs: <MWHPR12MB1200889582A5189687830279A3749@MWHPR12MB1200.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:510;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /WQeDb5iLUOCcjfXmeWIqu5ELhWMxcN6cFoopJBCu8F4ktbuKBEROInCmJvLQTeFwGkGKOlBqR2m+At97TcDqN6ibNnnj9zXZU+lKlZYdDYWKF4nqfrh6hQ5kT7UxDs1uEGbjtyEjN9Y12bxooBI0IG2wx62fdASbpL+IJH7KzgOKK5E7IkXjNo7nCiWj/jObwz8ZFs6G/FujM/JZcmO/kqjTRArQEarJ3w+teziwMSqYFnHQc0Zt4zW1WprU7W0OMZShXC84gJZBOyNONkjNznfczwxiXom8hqM9KzHt9xglIcgCR+M37zCaKb7GJR2QEtyueDLEHixU4RpHwaTXOIPWBdYlzLQHLlTFr3bZniwlQaEGyTVtiWpLnDBf1W1yASGd+4s8PL3CAQj+BUQhxUZzp1DSePPKumCUq+7mkKZ+yTwkVpyvyYaumIfKiT/QMMtH0C9C+6W/oKIOhwzT3jOkLvywr2xJzjuJCVka42KPp++ejeGv5EGBlms1d0R5eL5YcNQMIaw+XyoHcOHycI+csAbevBtQBAMgM+f3r9sNRVdd7TvwzBtO+MpPMcEjGCOSqYVib0Xb1omS668DqbTwVCsz+0NKqkGUUso4zBgXSxyx/BrQveFS+HxhveOP1JJSEuB4cH9QOiJxD9qYGOAHfrtHdxMaDWBFhOrVdJ4EQgDkc7134A1rA22JwcDVFnPskYx0PRK3lTLOo6OYie3d8v1NxG812HLeH2YK0iJsX8IUUpSz+WO3vj5X+f3OtPYY17h4hP0RhdiWwp/1g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(186003)(36756003)(54906003)(6512007)(8936002)(71200400001)(6506007)(86362001)(76116006)(66946007)(91956017)(2906002)(66476007)(66446008)(66556008)(64756008)(6486002)(6916009)(31686004)(4326008)(8676002)(5660300002)(508600001)(38070700005)(2616005)(122000001)(4744005)(38100700002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmtqcU5hT2dUWXFoUmRXT3MrekI3WDVhVTM3bEE3b04vRWh0RFptRG5FZnN3?=
 =?utf-8?B?NEwxcUR2RHpUQ3JZUWkrSEppT1JUdklrTGJCdkxMbXdxdnpHYVo3VERmaFZQ?=
 =?utf-8?B?L2kvUGhzWWxCdlp6bkdSbzlKdFpqYzJWc3VNbUhSVHkzdkJ1Z0x6KzhDZEM1?=
 =?utf-8?B?MUxQSzFibjlWM1ZKSUUvaDFDUUx2TTF1THh3bDFwVTJzeVc1VnhtSjJTSHFD?=
 =?utf-8?B?RXVsUmtRaDFnVXNVTG14MmRZdUdiT2xaalp1cUhLcW9TTzVoRmFiQWRIM096?=
 =?utf-8?B?OVBPVG1KZHlHOWFDbXRacVRGN3RoNTE1UUF3YTFjZnIvM1NVc1p5c3grSW5p?=
 =?utf-8?B?eEZiSHlIQkJtM0MvOW1jay92YldYVU5lbVZWRElwME1VVGFyN2I2cFNKQlJu?=
 =?utf-8?B?Zmh5SFRUU0NYQVlZeHFkd2kzOEpRVG5GQ09sZWo2aXc4elkwWGgzbitaTFpM?=
 =?utf-8?B?RkdnamZQb0FxQ1E2SENCRFZmdjRiV2xoakN0aVl1M3NVbkhCYy9sQURaM1hB?=
 =?utf-8?B?UmtVNURSZTIzWnhtTUZzT2lPaVlFdWJoZ0VGS3hIa1B1UzhVY2YxM0h3TXlK?=
 =?utf-8?B?UEd2NHA2RjFmeHM0LzVjdFBudzVJSkRVdURLeEtCSmhqc2VmandLajZjdUw2?=
 =?utf-8?B?cmN2YTRJVzF2NzJKS2x0UjFlYTZ0ZVhMeVBIMTg0bU5INVhHN0tZaTFZbjNt?=
 =?utf-8?B?dGQ0bCtNaWlvUitsMEJQSXNjTmZVdnBNN2w3OStWUFdLTVA4Q3hlYkpodU1Y?=
 =?utf-8?B?eXVDQXI3aVB6UkpuTmRleXJ5YUJDdml2YkxaeEFKNWJYZWVYM1pEZE5YL2lS?=
 =?utf-8?B?K2o5VWMreVVxaDdoL0Y2T1oxODNPYTRqa3ZvT29zRWEzZTgrK1pDL05DV2hS?=
 =?utf-8?B?Q2xoZjRwRGJDaG53SUZYcFo0azdSemVGbFdqa3R3MW1DcHBVWXZNWk5QMXda?=
 =?utf-8?B?dVJ2UlRuME42Y0E0TVZyQlhOd1M3K0lZL25WL09JRGdzNnhId1daM1lEenlE?=
 =?utf-8?B?V0dEMFNYWGlyVHlWNTBOUEVwN2VrRG1Md3pvZXFFbFB2UGJMVkV1bzhYakMz?=
 =?utf-8?B?UGlhSERGRnA5clpSODMzMys2UEpQZU9lWE9MMGR3Sm5QUzkwSEhSUGp6ZnFG?=
 =?utf-8?B?MXRuV2dYNUE2ZmppUXkvcysvTnZoTnFsQXpqRExlYmIvQmFqNzNtV1ZzUi9q?=
 =?utf-8?B?ZzZhaHhyTWV2cVZSVXd0L0dKMUc3a3hlQjBVbFZqUkd3Q3dJYlFUbFBIT3R2?=
 =?utf-8?B?ajgzMDVCcmdDbWN5bmZ3WTZSRms0V0JPNm93R3d5bEwyYlkxaFVhZmNLeWY5?=
 =?utf-8?B?WmVQSTNQeDdPclFTT1lFWHczbytJbUJLemgwWlFmdW1DdEJrRzZJZUd4K0l5?=
 =?utf-8?B?S1dYckFPbmFBWkVvYnRDZUg2WGkrOHNMd1RvWk93S3E4amU4VXJmYzlpK3lE?=
 =?utf-8?B?d0RHeDhGc1UxUUt4Y2FMMnB2djFDbS90aWs2VGJwUkZib1VYQW1zckc4R1Rv?=
 =?utf-8?B?Y2k0MEJnMFUzYnRtR1BrOTZtVWRGWHRnUUh1NDhLVHIzcWNYUExXSG9MQmRC?=
 =?utf-8?B?OHNpekZHK3JjWXFnU2hBRUVBUHRaSzZXOGtwd0Eydy9ORzlldHRYUHhyUmFo?=
 =?utf-8?B?Nll5QnIya3JVTDhGR3dZTmo0U0xOaXM4Vkt1OFpzYW1DeTJvNDgwdXhHSWx0?=
 =?utf-8?B?bW5jUVBEYUV1RlRRWE1WV0hKSlVxd2VoMXVtZFIzSXJSNnFUTzRtdHh3Wmpt?=
 =?utf-8?B?NTlPY0w0ZkVsa1RDSCt2TlRpUzRlYlJFOFgyZWxpVzFWV2gwQ3dtVWtPK0NX?=
 =?utf-8?B?em95Yy9OOXZ3UzBjQ1RqUDE3eHNEQmhIeVNlVGk1bU11WTk4MXR3VEFPd01R?=
 =?utf-8?B?V0ZTRFgwcTlNL3lJM21YQTBHUDRzZTBzSWwwTHhSeDF3Y2dCcFZhdkcvTDlQ?=
 =?utf-8?B?alp4bWV3UVVXYnBnVVE5aXFMY3VRWFRDQXZtY1lrcURJNkUzNTh2MkZzWklH?=
 =?utf-8?B?R2xVSEpXaGdMeE9MMnBUM3VyV0M0TlBlajdrTnFZNjVMUk5uOVBlcGo0ZUFH?=
 =?utf-8?B?N21BVkV0ZlMvVDdiRFRoejhYMmtPRmhHS1pBTFEwUHdwZ1RoSDBjbHlFWVZZ?=
 =?utf-8?B?aG5aUGVURUE5V3NPTUxFeVFJd2p6alZnOUNUbEs0N3hobFVpMVpoRlNLdFZm?=
 =?utf-8?Q?rePlQm+xSN4jIdcEef6ChGrph3Eqw6M9wbkn/tYqCI6b?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAF1A593725FD04B875C71C96ABD93DF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 800ab1ec-b3f8-4ab3-3a71-08d9be822998
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 21:47:30.0944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sQ45mrLtJA4RDnrJ9k4ZytvbRva32+iQovEQ9PooKC4Oecb4SBi5//I6q09g+hy1bIEaIQIXEVP32p5e9zWgOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1200
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_134733_527294_C617D5AB 
X-CRM114-Status: UNSURE (   9.38  )
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

ICBDYW4gd2UgdXNlICJcbiIgaW5zdGVhZCBvZiAiLCIgPw0KPj4gd2l0aCB0aGF0IGNoYW5nZSBp
dCBsb29rcyA6LQ0KPj4NCj4+IGluc3RhbmNlPS0xLGNudGxpZD0tMQ0KPj4gdHJhbnNwb3J0PSVz
DQo+PiB0cmFkZHI9JXMNCj4+IHRyc3ZjaWQ9JXMNCj4+IG5xbj0lcw0KPj4gcXVldWVfc2l6ZT0l
ZA0KPj4gbnJfaW9fcXVldWVzPSVkDQo+PiByZWNvbm5lY3RfZGVsYXk9JWQNCj4+IGN0cmxfbG9z
c190bW89JWQNCj4+IGtlZXBfYWxpdmVfdG1vPSVkDQo+PiBob3N0bnFuPSVzDQo+PiBob3N0X3Ry
YWRkcj0lcw0KPj4gaG9zdF9pZmFjZT0lcw0KPj4gaG9zdGlkPSVzDQo+PiBkdXBsaWNhdGVfY29u
bmVjdA0KPj4gZGlzYWJsZV9zcWZsb3cNCj4+IGhkcl9kaWdlc3QNCj4+IGRhdGFfZGlnZXN0DQo+
PiBucl93cml0ZV9xdWV1ZXM9JWQNCj4+IG5yX3BvbGxfcXVldWVzPSVkDQo+PiB0b3M9JWQNCj4+
IGZhc3RfaW9fZmFpbF90bW89JWQNCj4+IGRpc2NvdmVyeQ0KPj4NCj4gVGhlICcsJyBmb3JtYXQg
aXMgYmVpbmcgdXNlZCBmb3IgYSBzdWNjZXNzZnVsIGNvbm5lY3QsIHNvIEknZCByYXRoZXINCj4g
c3RheSB3aXRoIHRoYXQgdG8gbWFrZSBwYXJzaW5nIGVhc2llci4NCj4gDQoNCmhtbW0sIGxvb2tz
IGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29t
Pg0KDQo=

