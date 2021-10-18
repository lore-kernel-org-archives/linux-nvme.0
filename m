Return-Path: <SRS0=IkIX=PG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A602C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 05:31:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE2960F22
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 05:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BBE2960F22
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dsYkJjQ2sJgPRhX/I6nKThZ2ilnVFJ3Mr3vmRaXGePM=; b=olTnj1BMMeRC9Ftjno2ADONo9U
	mBqUdZSFfpwgaEVOL2LErCknojivl0EJiHYT+AYd2muCtUgAVkL2ZOg2VrIQJK93SBxUSZ7pfeyHd
	e4y1/Nute3AM8BqkyXJI/CyyYA0+2h4DSu+oHcV/MiVTrUs94SSWdArcRp3OuC6BBJCV5NdU3l34c
	Ltb47kdHZyLhaUMfTJ+1TlH3dIKoMy+GDdVZbSFj+DayGevapdYL/Hp1ghW8y4uLKnotD08jaX2M4
	KsNvEPxC8rZfsu4j7uGs5OEG/nYnHL5KaZ9sLgGnJLVgvhJv7gZP837L/1CuLd5EOEtSSZTU0A72w
	U/0Ou19Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcLEh-00ECx7-Kr; Mon, 18 Oct 2021 05:30:59 +0000
Received: from mail-dm3nam07on2054.outbound.protection.outlook.com
 ([40.107.95.54] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcLEe-00ECwj-Ml
 for linux-nvme@lists.infradead.org; Mon, 18 Oct 2021 05:30:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKQLHHfUUg3CtFtJiPGC7vaIabpZ1wF2PFTwnNf+rY4Oz3sKefEVVqM06sOD/1dtxXE0QYEyGk3d90w59BKDYjJs58bmzdwMcGoYx1mPC+c8ldLl+fOLroBISliz8HwUxeIzx4kmI6KYbBAm0sZds07XlGph0hPXHcUh8ueY+1ybdkZhII8kFa71A6edZWNUP8PWHLn9EtDIe9Oy/A+vA06a4LTtmwb6HH2zhXLx7qdTO5qNnfKjvUEathU8ifm/nPYRo4ceia1zQkc5oYBaazw1oKNFhHaey6oe8PjyHCgXMllhnIhIsqN0bAduUvaVwsbTqMfDTcAsEPwUWdqJ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsYkJjQ2sJgPRhX/I6nKThZ2ilnVFJ3Mr3vmRaXGePM=;
 b=mn4Z2BWjaswgS7YIGwj444q0xUP0TJk1S06Mwx5rfIj+ym3oPpvFRmW8OaNRyaNrXiJLDEcx0lBXgwYTc9HmoQFWydIdO6iYf6MPK/WLsKserZ6myPmHhz2rfPl3sxctZo/Q0jHgs2Fzboq41sLEIQgZl0Msqyp9lZtL3xSbRdEDqkVsGIjy1lTHOI9XVWCvvP8E8aaf0YgK0zYBjoo8XKPTIMM2W9AAUtR4opJgWTqGgcH9VLPvqiBxzq2K7n2c5xv3Sb5kxsQSi3b9GSYpwNBZtubkWna1s84Ssboni4D0JQBIzU4R5895e9tvF8mgR2tJ+CVfFdrURW/9GmaALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsYkJjQ2sJgPRhX/I6nKThZ2ilnVFJ3Mr3vmRaXGePM=;
 b=MKDzSP3JN0S/HyXcMCLawskWjrgrOkFpNdTRNclNVUEahmgcihaZ5Hbe/S+xOlTwnce7XaNh8tOXl7MA43ObGEL/jWWwxBxs36+ag2VdLc43tGb8JmWZitYq6Z8CVL61tp591RKe9MuHB/XuyndTzAKbyUe40WxW6nCLTAI72fQ6alZ+cKvEyHL2SSU3AHuPMebxRl6CGj53WCPBbFWwq30bBFDl9oNJ9dFESVG0a2vbv1c8Cm9ozS531b+6IqKyWiOg8ZDaWDac9YbtXJHMFFNOBWkRcxzzspMiATKDydcaIQYdScgRBKUL+IDPz5TKjco7k/gXSIZwXiQ2hzmReg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1392.namprd12.prod.outlook.com (2603:10b6:300:14::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 05:30:53 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 05:30:53 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: chengjike <chengjike.cheng@huawei.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "sunao.sun@huawei.com" <sunao.sun@huawei.com>, "jiangtao62@huawei.com"
 <jiangtao62@huawei.com>
Subject: Re: [PATCH nvme-cli] huawei: filter out the partition disks
Thread-Topic: [PATCH nvme-cli] huawei: filter out the partition disks
Thread-Index: AQHXwNvBiTLQ2N3O8kGu6uGO339Jf6vYQOuA
Date: Mon, 18 Oct 2021 05:30:53 +0000
Message-ID: <19ce83c6-7ef6-d21d-9133-607a56c0d3d2@nvidia.com>
References: <20211014091130.2083-1-chengjike.cheng@huawei.com>
In-Reply-To: <20211014091130.2083-1-chengjike.cheng@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fd0f804-8bc0-4d8c-a447-08d991f87442
x-ms-traffictypediagnostic: MWHPR12MB1392:
x-microsoft-antispam-prvs: <MWHPR12MB139283E2CA54C4B9882D9D8DA3BC9@MWHPR12MB1392.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fZO2H5PC9zgu173oObWcciRUMB4Sh7vf9BgbepBKLXYqEO04vCptvOwH6qXVBL6QsT13RsY6xQcMfwrmqVZK3mjdFjXgOO/muf91TDJpNyWKLKn+OmnhtjtjuZYzOfgNuHeM/Twl13JccWE0pACFkzo5LCgdsmpOdUjoU4xo/+83jlGN+bAlMc2por4PYyAp676gamwyGa+9EQ1ojMPCtLNuNdB8qnR5NoqIzQ/JkYxk73Lr9bYSR8jJiaS5Ty1WUsVqP/ZtvZMqI38yegBqcdH58fzgPnqJdDUU0oqFA8N4kDf5Mgu5f45c1rdBxiKTu+dUyschJpR0Ug+hUdCmexUeOfXo1K9pmaV1Nuoc6moLQ4qLPpbRjDb2SBR2a+b+9IJh9LJCGueIyxoewzwz/yhXMaJAoqwreTcW4bTNv5LGxPunipwP9GmnL1YZlRDtmugjLdaEnB8DX0bB37hLfDtctzvpmLNVqcQeDUkFfIKLSsrbBX/a4Gkdr9jEY2zTF91/J4+SJTOvZRdCJvIb67yNyxDvcy+U+O8qXewVJwR6EluIv1mUIKoQ8N1ziclsgHKFftgBVu/CO+SEUuUz6YUQgDByfbC7O66E3I9RhpOIW9qYfQJ4Q4fGSc/SOe7MCvyPqJ9+jpnT559Si+k5lypdzOhGry/PdG2Et7PbBY46PwEm1v76yGC0y87jfTKklkHT3MgrFLFN4ESYRSLbtFFMYpEHXrLs214qNW2V1RGXJ/G0OIFGl9wlNpS63Yshs32veZMgSFeB5+h1IzrJAw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(31696002)(8676002)(31686004)(38100700002)(2616005)(66476007)(91956017)(66556008)(36756003)(66946007)(26005)(86362001)(6486002)(5660300002)(316002)(66446008)(64756008)(71200400001)(6512007)(54906003)(6506007)(38070700005)(8936002)(186003)(53546011)(508600001)(122000001)(110136005)(4326008)(2906002)(558084003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmJkMklWWVhSQ2NYTGM4M1B1bnZJcnZ4dVkvTFdvcDgyZnVDaW96MnFrd0Iy?=
 =?utf-8?B?QU9EdXhBNzR4WlM3bmdrdEt1NlJVSkovQmpXZ25MakNhRHlFZTZEOHR6ZUdr?=
 =?utf-8?B?WG9YekwyOG5NVnYyZjkyVC9OeEZqYnJ0aDliSzI5NkdDamZOM2Rid3lURDdj?=
 =?utf-8?B?RFVYL2lBaGlDV0J6RVN0alVlQzVLUzh1UGxEUTNJV1ZER2thaTU3TXZldnZa?=
 =?utf-8?B?MEdRVjZ0NnNTQ0pJblN4cUlIYkt6RS9hZjZNZFZpYWR1OEVsVS8xdmFRNzFh?=
 =?utf-8?B?QkJmdkFSWUpmOUF2TUQyWldjbUhtbjJhT29LbHhrcDBEaURmV0hMa0xkdzdU?=
 =?utf-8?B?VjRGbUhDZ0NYRTdZREEyOTNQRkhOa29LTjVQQUZ0NDQvRnJtMk5JdjY2aUcz?=
 =?utf-8?B?aVNGV3NMaGQxZ28vdzFMUlFIbkhmbjF1ZTJWK2xjbDZMdzBDdjFWSkt4cVFE?=
 =?utf-8?B?a2N4Ynh1Q3NnZHZNaDRNRFJQeDN1ajNVejhnZSs0dkFRS0dtUFBlTTJmY2ZL?=
 =?utf-8?B?MmFVUGZzY3dGUE9XNklVYXhXY2J2TmhwQzhRWVdrUllzZ0FnRzBTdDVsOHBE?=
 =?utf-8?B?RHNpeUJDbEs5R051Tzk4dGFlRjhzbUlzUW51Z1JSYVVHOVRCK2xuRkRJaVhz?=
 =?utf-8?B?cTV6TUMwcDUxZkxkc1N1b09HeWpibXVhODZDeXFVWFVVaTFna1VJY0tqbEVl?=
 =?utf-8?B?OWI4Y2lyWGJ3QVoxbmwxVzhtS09qRzUwR2puM0tBYUlVNVNpYTFwd2piNXRq?=
 =?utf-8?B?Q3Q0dC9qN1hQWEF0UXdJbUl5RjJ5b0dsQTRjN0xmNGVOSG9TdzQzYlB4a09D?=
 =?utf-8?B?Kys2ajA3OVp2YXo3eUxUdmRMaDhUaU1XRHF4SjdZS3NaY01KOFgzSmNOb09s?=
 =?utf-8?B?VVhQUGFXRFZFVnVRUGs4ZmE5MG5zT3YvczU1bjlXQVkzeURxT1QveUdrRmtB?=
 =?utf-8?B?aHFrcnkrQTZYRFVONkthSG1XRG5vdTFnMkNpbUhiTUJOR2FIUEZHZXRhY09X?=
 =?utf-8?B?Z1QrWW1lOThLNmQybmdjWURJSGVaajFJdjRGUElZZUpXWlZtdW9aSklvT3dr?=
 =?utf-8?B?MEJJSmxvVGJBTmV5N2lkZVJHWER0NCthb3JIanNtTHE4MUNLY1loYVlhaFJm?=
 =?utf-8?B?cWRiNEVveHUzN1QvZlRhQ1RseXJVSGQvb2xTYXhxdytrbjlXZjFLYVpDNjdS?=
 =?utf-8?B?SHNZNnVDWUlUNTMxOHlBRTMveXcrOTY2Ryt4RGwvUUJPRnpoT3B1cHN0Y09q?=
 =?utf-8?B?NHhjT2h3SUZSK0lyd3hYQnA0L1NVeUMzSktVQWRUVFFCMWRZSEVONUVlQ29V?=
 =?utf-8?B?TFV2K1VMTXMyUWZJYndjbVl4OUxaYno3aTBIb3gxRGVuVm84SjlIVEQwQ0xG?=
 =?utf-8?B?bitaMFQwdnRVbG9HcEtPUk1vb1VLcVBGeVorK3Jnc1VxOXV5K21pbXRyNlla?=
 =?utf-8?B?OVExZlF3TXpMT3VMMi9EL3BjWnhpZWtDUHc1STNJaUVwYVplci9qb0x0ZUlE?=
 =?utf-8?B?ODFqUi9CbzhmclREdk9WQVUrd3JSdFMzK0xTNHhKZklHYkpLcVRlZmcwVHpz?=
 =?utf-8?B?czFNcWpGV2lXTTUzRGlIVmFoOHdPQkxFd3JXdmJHaE81NVNNdnVydjBzMDRL?=
 =?utf-8?B?RVdSZGs4UURadDVlRlhwbUpRa21Dc29LWTV3ams2cVZ4aUpCaStsRklXU3RC?=
 =?utf-8?B?d0NHZFc3VG5sQStlYlJIaVRXOW1BNDV6WGJ1MDRqaWFxdkVBejZZSHI0cXR1?=
 =?utf-8?Q?toC1FjNeaUg/L/ge7c=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D21C0CD6AA9CB4E812CF47707E448B2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd0f804-8bc0-4d8c-a447-08d991f87442
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2021 05:30:53.7287 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XwvyPjrmAGXsD8njvvauM+wWTlwfLJmYbjrMta0pLtKHdioEgRZso0qmJHDgHKQb/E3z8KYv8cvYLKJ1OB+5FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1392
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211017_223056_791505_F4A2521C 
X-CRM114-Status: UNSURE (   9.51  )
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

T24gMTAvMTQvMjEgMDI6MTEsIGNoZW5namlrZSB3cm90ZToNCj4gV2hlbiB1c2luZyAibnZtZSBo
dWF3ZWkgbGlzdCIgY29tbWFuZCwgaWYgdGhlIGN1cnJlbnQgZGlzayBoYXMgcGFydGl0aW9ucywN
Cj4gZGlzayBwYXJ0aXRpb25zIHdpbGwgYmUgZGlzcGxheWVkLiBUaGlzIGlzIG5vdCBleHBlY3Rl
ZCENCj4gU28gZmlsdGVyIG91dCB0aGUgZGlzayBwYXJ0aXRpb25zIHRocm91Z2ggZGlzayBuYW1l
Lg0KPiANCg0KDQpJcyB0aGlzIHNwZWNpZmljIHRvIHRoZSBIdWF3ZWkgb3IgZ2VuZXJpYyB0byBh
bGwgdGhlIHZlbmRvcnMgPw0KDQoNCg==

