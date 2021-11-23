Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08ACBC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 08:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=67rW9XFE1thfdRjSG+WbAIRhORFqiFPp0yyecNmI5rM=; b=DH68p5IfhxxWt9tTbK0dIrVnbp
	pWhvy4RQKYtF0+OPbPCYQdMth31+ADhTTXLgzQyviFjmVRqpxkf8mSf6ppP80zzuifo6k1NJQZxJb
	CkE2hO53T18M7umFZCM0RYQJf0eUSsy+SEZeu2naSXebfuJS69GePGt5HtkgEVU23fjsQW/UWX55/
	xxnf9iArLvm7wMWdY+7NqK6Q/PWxdtCAaLVgVDrzcQZ3kTUyn2f/QcEHIqRSc80qaNwSQYRVQj+RO
	t8DcRXf7I28oADElEkOLDS/cyoBRh6Z4k9o6DOZpIEjBK4Zpski9sevSbeYVxP6y0yRdCs8q6VokA
	OYJCy05w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpRLI-001KcD-V8; Tue, 23 Nov 2021 08:39:57 +0000
Received: from mail-dm6nam10on2060.outbound.protection.outlook.com
 ([40.107.93.60] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpRLF-001KbI-W3
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 08:39:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOImfUbLh8UeR0GXzhmAvkjZH8d/Ru2ONDxH1LXrv4eeR43nlM3MLdSw6Mf+DTEVzlQPYrne29lKnvUl7oCPt3fbQ9mHKrKSfiRFddoX7yJohbRiJk8mFPItaUjSDg9ec9gtYgwnR3SvmUW5416RZPszRjpj5YvAtZ/92UMBdvHl9dWFMXsNYK4EAUime9JCKhY6JB4SgU3DdWWXK2gWoKqzFKZ4pXZqPba44+R3jdwVESXhsXVCSZ6HPtPI5HvIhLN3adD8o+NHTXWvxEY+6nkecXnKHlPv3toBiW8Az/bB5v80bKO/8uJnxyPNGR9Ysj6KsGsKGntHXWXiizyf8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67rW9XFE1thfdRjSG+WbAIRhORFqiFPp0yyecNmI5rM=;
 b=E017TDzgLt0tH16SIEcGIezG7vHoMRA0RQ5SZJxHlvQCPttlnyteqIvBBIwCFCPJ/P0XuzNy2kqdL6bAlkwqOZjmk8sc1Lxl5tG0bQCUgKjnpZvqACYXXVf+6E0xw/7D3f7apK5zlR90rUcJQzuEF3vbAtR/AHIJjwJ6NBQgsBF0QQEFACiTWSZZfT4bplHo0PkseKqoCswsEyPJPJbo62D/TTleqY1K7OZQc1BCBbZ837aqXxLAoQIBWSxc6EFmDXnIaICAgs113LocHl6vC2dqFRYHeBHNJ4v49sfQOvWBk2x+I5NuWQZFmeOnQcr3mMTmRlGU4CTIVfq6IUYEPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67rW9XFE1thfdRjSG+WbAIRhORFqiFPp0yyecNmI5rM=;
 b=qCt6HyqRdrAxCCI8ZjvMk1exEOkg6BJjbfoSOakw/22Gi1IDg9ADpmNmNBwWXLV7im7ISDQhCy8FARE6Nc6lEy0j5YpxYj1tD/HQc/jJzJ0ofwr7OR6J6SkJKv8MVz+1kLQKL9813XjAGWULpY5zzRhTz1bqGirS1vbJEjjQYCS0lzXW0yPo6Qq4YWj3brmwfbDmChuwT2kJQmejvRbwbpMfRXuCbnYEvyAEA73dxNacf61syXUQ9rJ5xydsgya3QjOFF0cbT/OpUDj/xn1ABuOQd//JjjLX7SPTA2CgQhHpLo2MF2luQZ4SExiKmJlGhl5SMhh/FyAPQyldCumF2A==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Tue, 23 Nov
 2021 08:39:44 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::6dd2:d494:d47f:5221]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::6dd2:d494:d47f:5221%7]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 08:39:44 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <keith.busch@wdc.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: print out valid arguments when reading from
 /dev/nvme-fabrics
Thread-Topic: [PATCH] nvme: print out valid arguments when reading from
 /dev/nvme-fabrics
Thread-Index: AQHX3SFErYDUKNePGkyIjHOGD9xcm6wQ0REA
Date: Tue, 23 Nov 2021 08:39:44 +0000
Message-ID: <8d63ffb0-21a3-d739-f8cc-18d4aefaec37@nvidia.com>
References: <20211119083912.38260-1-hare@suse.de>
In-Reply-To: <20211119083912.38260-1-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8737151-b533-4b03-66dd-08d9ae5cccf6
x-ms-traffictypediagnostic: MN2PR12MB3774:
x-microsoft-antispam-prvs: <MN2PR12MB3774450DC7EB21C95B7F7D3DA3609@MN2PR12MB3774.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4qWcXclfR27dngOZzPtA2xpo/wDfTWxRabOawyZawLetcWRdgPOw2LAqxAcXwdiaooVU39y4ywiCrI7RWnficOd6Cpv89+GAgg+jpJWCiAd8z1JAwmuLPClUdoGjjzLyLkiOvHYOSgETcKTJ1WHQs7gxHMdUxPyC2d9cw73DBDmI9DIWIDi8f/KV/qou7dcyUfHAHL8wBzOCKIn3ICXRMIGdhgFP9FFt08QrpHG4uCYyrBCYeErJO4qfWeNdm2ojZpjpMZ9FEcycjaX1ZdHqE63wGLOFtwTduGzC4Fff8A/c2rgLLFSvp1S/+Suu5724sB9eqjqNhfTORSg7f+W2DfbmA1FaTope+B4OULWQmqI8Y4iH4j/QsWFYpLO3xX8syln7IQ1SVjZSbBCntGbancMYZItJLbNKihkTh7i1SUvTJMq1AT3m2nJuBPkeuRSiFUklJ2w2rmwz5xx1Ha4CaUmKEpUhgY9+9bvXytXCO07Mg90j+ziD3jAcBpquZe7Fj/GaN7BW8aGZg5q1ONHwpJ4nYrpqAWB8RmyDviCy8gKywAj6OSnPL9mbUpGaGpCJxUt/TUm7c3LZcpSsEeGLqBcUDDQsNr5uyhW0ISfxLo9VR1h0EQC+JIovevvHiV9myWos7gJF8DZu94y929ICzr6++ScyPCGMeip83r2kSYQiQABlvGqtPnLpUgvtTGtjxF67dGqy/i4nqNozqngaJAF4MO58KtaaSn/6hAhoYoUbcOlp5F3lnaLL0VN8ljxYyPNH2nT5e0azGXWuSD6HtA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(2616005)(122000001)(508600001)(86362001)(31696002)(53546011)(6506007)(186003)(2906002)(66476007)(31686004)(71200400001)(36756003)(5660300002)(4326008)(4744005)(8676002)(64756008)(6512007)(76116006)(66446008)(38100700002)(91956017)(66556008)(6916009)(38070700005)(8936002)(6486002)(54906003)(66946007)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y25UKy9sRlZzUWNPeklOc2Z1MEZ6eFFYTTdFUExWaDM2eUhDQjB2dEVhV3Uz?=
 =?utf-8?B?Sm5tOTFEV3JVQmFHc1hrbHY1KzVBVkpTcFh0a1k4MjVRbHZwSUFRdW9xdUhU?=
 =?utf-8?B?WDVXSmo1VWI3cE9OeFVjMnpFNDN2eWM1S0F0NUhIWmJOb0htZW1tYnh1R3Ez?=
 =?utf-8?B?dWZ5OXhOaG5zRU5QeVExa3pKY1hyc0VjZ3g4TkFkYkNiOXlWQndjRkEwbUR2?=
 =?utf-8?B?ME5ZMUFPN25wZCtlbEFaTzVFYW5kaGdacE1kZXRjcFk0SUVVWXVEV3AwVzVX?=
 =?utf-8?B?Z3NIVW5JWUZCaUdFZmhHWVhmNmYya0Y5enArM2JlQ3FXeERjWE1CSDY4SkFN?=
 =?utf-8?B?Y3dXRmxwTFBsMUZjOG1JRnJOSHFBejMrMHJ6RExrS3hGVWYrSThwSTJiYkox?=
 =?utf-8?B?dWlnYTRQM3lXSVdobHh4SnNNdjIvM0xHT24yRVZSNWUvbDQ3c0lNRnI1UWFr?=
 =?utf-8?B?MzVnTTV6aUpNZ3ozbU9TM2R2Tkx2SElZc2dvSXk1a0tLTmI2azRFSXNPUTRi?=
 =?utf-8?B?WWlqc3RhRW5TUElQeUErcUVqZU43Qll2cEZKQkVpOXllL3VmY0lnWmM4SzNs?=
 =?utf-8?B?TENQNHdEK3BrZThBaTA0Yno4L1lDTWluOWFtNXNjZG1kcUZsV3hieXJncE1R?=
 =?utf-8?B?Nk9yZ3Y3N2lIb2Z5djJXVldldHJsM3R4UFFuMWNUUTlhbWgzM2JwVXFteTBt?=
 =?utf-8?B?Wmh5ODF4RTVXM0VnZEJKcG5heFRqdjdmZXI5cEExdXRKd0x2RFh4TmEyc3cx?=
 =?utf-8?B?MUl2QXE4c3BNL3dTYktBZk1QbHp6N21uS0Q3VjdFcGZKTzFBVDdvdDFXSjZs?=
 =?utf-8?B?Y1g1cXlJU3FjZkdVbWoxTGxiLzR0Mm56dDBUTDZpRExxTHB4eE5qSXhlRTJo?=
 =?utf-8?B?Ynh4U1ZKQ2oyQnBydkhqRXEzbWxzSXdxZHNvRHVTcFJBckt5NDh2YStySHRa?=
 =?utf-8?B?cGVoem5nRnZvVXZuN294V0xIUGxTczM2VndMa1N0dkhNRllVRi9ZV1V2d2lj?=
 =?utf-8?B?S3BTR0tXMFY3OExHMVFpMW5iN3FhcXB5WHJNTGFoUGpMRTJzWmFZaFo4ai9E?=
 =?utf-8?B?eGd0RUtCUHZ3ZE9XbzFFUjRoSWRXY2MzN0pVWXJDdjNZK0JHRERZVk40ODFl?=
 =?utf-8?B?TUFBUUV2Vk1FeGwzMnVFZlRUNXlHamh3NFUvN1dyZytVRHRuTlFIa3FmOEpz?=
 =?utf-8?B?RHd6TGdXOTVnUHE5T1VjY0tMck52Q0NxeHBKcmwvaHc1ZWI4MFBYQVRLaC9F?=
 =?utf-8?B?VkFTUVoxMzNsZmZ1VXRyVGNVRzQ0SlU1ekFNRllYa1lCb2xpUGpuNENqemFI?=
 =?utf-8?B?UGJyNXF3ZzlmY2NKd0R1WTZDSTlnTnB6bFJ5NWg1SWpINnhPUklaWHlKL0oy?=
 =?utf-8?B?dTRJMWhlSjkzeGdvTTU2RGpPUTFzTGU1bU85TWtNNmovd2VhNU5LckVZUFFY?=
 =?utf-8?B?Yjl2dTJuWUw0Kzl4ZVRuZmIzWEZMbHhOd3c2RG5hejdQNmxmMENJdDhCbEd0?=
 =?utf-8?B?ZzJ3dURLMVVCMzBiS0J1ODByeGFYQngyWXNXWk9nU211aVJoMjlWWUFjbTJI?=
 =?utf-8?B?aUJXRmtUYTlTVkxGeElPNldPUHNoOGF0SU5tNmduemladjQ0aW81Szlyck9r?=
 =?utf-8?B?QU85M1lYV1MxdFlkQVhzbkl5MStXejdtdlVieDk0OFY4MjVqaDg5TWRFb084?=
 =?utf-8?B?QjZRNkpVazR4T2pHQzYwalJONFFGSzR4TWVZYW8zKzVPM2p6T25ZRkNTNzg3?=
 =?utf-8?B?QWFMSUJhUkJLVzI3Yld6RVBVVENEMWtlN1JWQzN0bTRyUGhBa1BHOTlmcUN4?=
 =?utf-8?B?MTA2Ry85eWUrb3NRTzk3ZCs3SFppMXFiRS9hbTU2VXZmNjRFWm5hcWpTY0Y3?=
 =?utf-8?B?czJQOUVLOE9PM3J4TWoxYU1HWUhFbUxHQUQwTFBneC82QWN5d25tMkNNdnlP?=
 =?utf-8?B?WkdTUVlOVlV0V2ZIYjVMOHpsTkNpWnIxdlIvK1VDbDZmYXR4SHpiV09Eayti?=
 =?utf-8?B?ZC8yUUJjTC92M0krcW1kek1pd3hlSGJvSHJqTjJJSHd2T04yNEVrSDdDbEZU?=
 =?utf-8?B?ZVE2NktGbDd1UGc0bGhjQnM4cldjSGFpcHZMNmord3ViZlY1T0YyR1RBZ2Ni?=
 =?utf-8?B?dHZhbi9XN2VOdHZWaVhkRmVZemQ2NFJhc09yT2hTNHBQQ1Zsem9uR0NiQzVV?=
 =?utf-8?Q?KC/J3Y4Ek3TBgBSgX+TgyOvuuWlXLeWWWt9PoviuDOHD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADBF7029537A35428880A4699B5FBA9B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8737151-b533-4b03-66dd-08d9ae5cccf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 08:39:44.8130 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A0f2elSDKRQee1Rujyz/c6c+u6yzcKFZQHM9coTD0+oHiFLsaiEcD1I9iUW+ekdkscTpO9qzMihkMg6nSDOnPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3774
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_003954_063200_F0E92D5E 
X-CRM114-Status: GOOD (  13.95  )
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

T24gMTEvMTkvMjEgMDA6MzksIEhhbm5lcyBSZWluZWNrZSB3cm90ZToNCj4gQ3VycmVudGx5IGFw
cGxpY2F0aW9ucyBoYXZlIGEgaGFyZCB0aW1lIGZpZ3VyaW5nIG91dCB3aGljaA0KPiBudm1lLW92
ZXItZmFicmljcyBhcmd1bWVudHMgYXJlIHN1cHBvcnRlZCBmb3IgYW55IGdpdmVuIGtlcm5lbDsN
Cj4gdGhlIGlvY3RsIHdpbGwgcmV0dXJuIGFuIGVycm9yIGNvZGUgb24gZmFpbHVyZSwgYW5kIHRo
ZSBhcHBsaWNhdGlvbg0KPiBoYXMgdG8gZ3Vlc3Mgd2hldGhlciB0aGlzIHdhcyBkdWUgdG8gYW4g
aW52YWxpZCBhcmd1bWVudCBvciBkdWUNCj4gdG8gYSBjb25uZWN0aW9uIG9yIGNvbnRyb2xsZXIg
ZXJyb3IuDQo+IFdpdGggdGhpcyBwYXRjaCBhcHBsaWNhdGlvbnMgY2FuIHJlYWQgYSBsaXN0IG9m
IHN1cHBvcnRlZA0KPiBhcmd1bWVudHMgYnkgc2ltcGx5IHJlYWRpbmcgZnJvbSAvZGV2L252bWUt
ZmFicmljcywgYWxsb3dpbmcNCj4gdGhlbSB0byB2YWxpZGF0ZSB0aGUgY29ubmVjdGlvbiBzdHJp
bmcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4N
Cg0KdGhpcyBzZWVtcyB1c2VmdWwgYW5kIHdpbGwgYXZvaWQgYSB0cmlwIHRvIHRoZSBzb3VyY2Ug
Y29kZS4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8
a2NoQG52aWRpYS5jb20+DQo=

