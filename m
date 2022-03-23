Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8DAC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 18:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=90yM75EZY6vJcvVLYqiBLh8/p14rTnP4rstwhpAfcZg=; b=eQTC30mfiu/MrOOR/zCRVbXUp8
	WImDHwPS5coD49fROuSp3/bVJZbA8IkDWgT7YJHWEXJ2Tc5EHlWUXTVhgxTXJnFy0U1f3rtmIb6RI
	d51lTophKW6/PAU/n1WUq5/LdLY0gxabd00ar25OeQ7XcgdroXrLdS6sVYyZMedjzBnpYTkxaB/5p
	PG70A6VX0zrCp/XMkCakU5472eO/WnvcXmqh9A/LHcXGYZcWg28MmpMaONcZzLtWyGXNgKRTg1Zq4
	AOOQ80vDDyaHbSLKdeSwtZl6gEMywD0xPyowIZ0P+wU56vc3QVgweutwcI/Q/8Z69/mq659pfoqAM
	HzV4+sHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nX5eS-00EZCN-Ub; Wed, 23 Mar 2022 18:24:08 +0000
Received: from mail-dm6nam11on20602.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::602]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nX5eP-00EZBA-JB
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 18:24:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXLejA61dFZKLm1TtdiGkzG1z1MYaAFNsnxMztfW7pVfVnyivj46TBSCk3IQ1g+3O2rG7kX19CFVtCcLi5AZn/1PUxi5ni6BFXSpj7O7EHuTa3jY5z5dA6/M2AdUnK6xqL+IL6b3f/iQXovFr0RSazbzFvpuqnVVjUpZ8TjdOjsWjE2UpOMff0jTyTTaJvmZjS9G+oG/r+KOQVLe6K2/xF0tO1EC9JFkLjJsodRYRPie/uxdismNusQ7mT4SKBB5CB6m1OPDBt9HlWp+2PfqNaXpNow9wGGG67bOR2ZO83FiaFjgqtn8ZzppTad8BJ0IFWGg0xmRMuYfWBNgI9f6Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90yM75EZY6vJcvVLYqiBLh8/p14rTnP4rstwhpAfcZg=;
 b=BOLLBqEK5DIvqTdU/yhx0l/5iVqYOMTZsJwVw3FoJKEd1JwesPFd6FLaZEsZ2IZMlFm4aF6Yx3sFnmyc8CR3X2u/EByirMRD0yJAQmKshg50+JSR1nIZZHmLMSfAt8M4K7PODcKjPpxm1ahMEZv7x6PdPj8k9YrRDebrBZ7T8RzcqMdhZ4Pv1mJ+314DhqEOyGr/i3zi6JMGPxPn7jsK2WfILHhPjTNURGRgTiNLm9ooi4BZa8O3H0aO5DPYfQU5Xof8kzdULdNA/Z//i01aZfzd8J05tvIrWgw2uQih1jsJxXW8frgKomrMRgAQdLpi+vPsbwwj9RqPOgZ4M6JVPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90yM75EZY6vJcvVLYqiBLh8/p14rTnP4rstwhpAfcZg=;
 b=18HIBJt+39kcCGR7fzJznJ8E+iaGW3msxC7AhHunFnYb4KCer2I6XTdTrM/9vNMulZsr7scrCMF6r3svSXv37/UVu5wAAELbdQWTRNiDpsPz0r6k+Duf807W6r7b1rkm13pA9nwTCU3MjTKx4rgWtUn8merDcq38W52TPWUi8KfDqH/Ch4upqq4WvbjZ1KeV+wIGp9stYSi5PQWLDJ/ThpSvPHKPu9VSSwX6109czFoQjwoWZlAFhcB7THT5bpXYcPK4BsahtmnyLWPtrYnFCUHsX1A2cZicbTW2DP7dUgjQFeCWFtt7GNc0rNSuNEHNalH5cgOcW43Nt1yQsATZxw==
Received: from DM8PR06MB7704.namprd06.prod.outlook.com (2603:10b6:8:32::16) by
 MW4PR06MB8314.namprd06.prod.outlook.com (2603:10b6:303:129::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 18:07:59 +0000
Received: from DM8PR06MB7704.namprd06.prod.outlook.com
 ([fe80::2d43:b548:21c9:699c]) by DM8PR06MB7704.namprd06.prod.outlook.com
 ([fe80::2d43:b548:21c9:699c%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 18:07:59 +0000
From: "Knight, Frederick" <Frederick.Knight@netapp.com>
To: John Meneghini <jmeneghi@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chris
 Leech <cleech@redhat.com>
Subject: RE: [PATCH 1/3] nvmet: expose discovery subsystem in sysfs
Thread-Topic: [PATCH 1/3] nvmet: expose discovery subsystem in sysfs
Thread-Index: AQHYPtnpTi7jgQcoLUOifsjMcQoVg6zNOZkggAAJbQCAAABm8A==
Date: Wed, 23 Mar 2022 18:07:59 +0000
Message-ID: <DM8PR06MB7704F3576A67EA57BC638FCFF1189@DM8PR06MB7704.namprd06.prod.outlook.com>
References: <20220314105333.56714-1-hare@suse.de>
 <20220314105333.56714-2-hare@suse.de> <20220315080602.GA3082@lst.de>
 <f2fb9eea-8c9c-cb95-5380-2a10b6ce3f46@grimberg.me>
 <ec115fe9-2b3f-8f31-d3b8-b85686c2788a@suse.de> <20220315094950.GA5322@lst.de>
 <089e3056-e603-bd9e-6680-52a26cafa72e@redhat.com>
 <DM8PR06MB770422A304E46F38AD030A21F1189@DM8PR06MB7704.namprd06.prod.outlook.com>
 <84ec6970-c02a-900e-a9e5-0d39236226ba@redhat.com>
In-Reply-To: <84ec6970-c02a-900e-a9e5-0d39236226ba@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.400.34
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netapp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d40f1f0d-0541-41d7-f4ea-08da0cf81077
x-ms-traffictypediagnostic: MW4PR06MB8314:EE_
x-microsoft-antispam-prvs: <MW4PR06MB8314DF330CAFEE9B179BAF63F1189@MW4PR06MB8314.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qsw/qbaL9D1nEX5WcqvIKEROxsFwzRMI1YaGaxQsd02FiHUoOmjpMUVS8fDnD6Ysunl+q2hbyST/8YKVyXWj1Q2/2TQxqb+/FXWwBsRCrbDS33Y3ccgAVDcpCap+4nc9Gy94ON2kiK7XdmAcHjQrbWF1emwbQ9SpooKkaLKbkoj6i9ri3YJnPx8PjyrxRiK+j/opmKO1y0PVNfhTAsN1ffXVPn9fxwGWfh1KoaNAiZ88qxiXzfpX20Bqt2x6perH3RbW0T+3PBkKN9DVWDimoU7AOZlYFrD+Dnx58RvXls8oliczecesmR8F49vZ8PauMMuUPN/4FMVQiCX9pRWjgT9rJ0Y/mWSUSTvjQw1IepqMUH0WY5edHipS6eW7afmZ0YIPmp3lAJLtTHhq3BgM/roq68TgvSb6cYhCcpkz9EZ6IAZySdeOJvyEZlMJ9XpjFD71WCeiwqlSu8epPWwus16cfmr9/Qmg1u3crNsZGkdvaL8EyhZ0THR96JJDonFuqwd5ZEmTWOTT6ISe+FAW90O33Vg95Orhsq6Qa0VCy18PjsvX9D2mBMc0XYzwKx55FxRg2SWxArL+JEyoPFqyCCmbxjaPrh+Mwu7F4j2HWDYvE+a8kpTCRSIBOXaSfaRNj4VBp68ENmTwVgOUgKqJUF3QVhfq9YnMVP5lO7YUumgJhED9myu+wef6bQ9eVya5VCrFy22ewkOgjWcZEUly0A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR06MB7704.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(86362001)(6506007)(7696005)(66946007)(66556008)(9686003)(66476007)(4326008)(83380400001)(53546011)(66446008)(64756008)(52536014)(8936002)(186003)(26005)(508600001)(122000001)(8676002)(71200400001)(2906002)(38100700002)(38070700005)(76116006)(55016003)(33656002)(110136005)(316002)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDZGdm12MXRxYm02V3dCL1ErWWV1MjRQUGwvT1l6NUw0Z1g3cENvRTZ3ZWpZ?=
 =?utf-8?B?Qkx3SjBNemdOcnpCemczcWZlNENxbUlIRFpqZG1aVm8wK0NkUXNFcGNmUk5E?=
 =?utf-8?B?d0QyUVlhait5UlQxRy9OSlF6QjhacDhyZlRnS0J4aGIzdlQyL2hCV1NSbmNh?=
 =?utf-8?B?eWFxSlB1MUpNUVNCMVpVUTRaVzQ4cER1bWVLeEhwdUc5TEJMbE5ZcU1UcG1X?=
 =?utf-8?B?ZXdmRytaMzlaMGdXajhCaXhteXF6SFpSY2NHTDR3MW5yNHZUYVhBaXNMcUVD?=
 =?utf-8?B?LzRuOS85SkhiWXg5ZVhQc2RhU1gwZUFMMUxjc2hjU2ZvVjM5dTlmZEJjQTlZ?=
 =?utf-8?B?djJ1NnlCZHlvbkNOZHVqN0wrVGZKb2dBVm1oMFNwY2ZCWU1aQzdDbnVMbjBv?=
 =?utf-8?B?WmJvL3UzMXJzRUtWWnBKVmZtcWdFaVBpL0hTVzRPUE5LcjNjYlR5T1hEZXlh?=
 =?utf-8?B?SjJxa2ZZUlJNcGpsMUhSYWIvT2VweUtOaDIxKzNGZVdYbW1Ba0tqeUtEa1NU?=
 =?utf-8?B?R1EvTnJrSkl6RHZJWFUybGVqc3U4cGVnN3RQamVvZld3SWlieEJadmthTXY1?=
 =?utf-8?B?cXhWZ3p1b2RyeUtUeForRmhJL1RuelRwc2gxMmdZR3dnYllLNzJwSXdNQzhw?=
 =?utf-8?B?UlpSZnIxSW1xYnFVUDdDMi9QM1ZKMHEyUUdJNFVuSWdXSXNncGhTSVovUjJi?=
 =?utf-8?B?Z2dCRndOMHNYYkRUSGFhMUtnR0JKajRTWmxUaWt6d3hXSVlSVEdwUkdoS2V3?=
 =?utf-8?B?MGlOeUw2ZE8vNE5zSWRtbm5lamxXNStpWTBCYU1Vd21ZamFsZXVERmxWb3Fh?=
 =?utf-8?B?LzI2UHRlbGVsbnQyQTJNZHZuWkRDYVBxWDhiUEtqaXR5UjkyRkFGbUZ5ay81?=
 =?utf-8?B?MjlIZGxWSG5HSzNsNWRkZUNzUkxmOEZkMjA4OFFPeUFTb2xoUVg2VGgwWnNm?=
 =?utf-8?B?YnhCazFRc2FZcGN4OTFBZ0QwRElqMWh2TU9pWlVINHZINWNZSzF4RWtnUlky?=
 =?utf-8?B?bitkVkxtMUJwRTZzb3JZVHRWZkNVRWFCY2ZKejJKNVpuVVJSczdoRkV1WjRS?=
 =?utf-8?B?RkRtVkYwL0VENDFJNEs0ZFBFTUUyNzJ2aWRYWC8zSFBtVnpSS0p5Y3h3Njdu?=
 =?utf-8?B?VzdIelc5K0xFNy9vdHFDZ1N2eVpId0kwQVJGdzJObU52V1ZDWXcwWmZXZWIz?=
 =?utf-8?B?alhPQWZzYWV0ZTJSREl0U0MwSjdiTUxXdFZFbzd6NzN2aVlSVWZkTm9iNlNK?=
 =?utf-8?B?RFo2OHIxMVRQdHdHMkh5cXpjVFBkRzQzUHo4T202ZVdRdGdxRWdTVVBSYk1j?=
 =?utf-8?B?blY3SGJpSEpLdXc5ZUZzWW5PMlVJODZqOW5tL1lDRU9MYzUraDUwOUJOZnlt?=
 =?utf-8?B?dVkvdDl4dFovNTBLQW9Jb0grbWVpY0VadGZXRmVCaGI5RkFNTXdWUk9YZnVD?=
 =?utf-8?B?QTR1Um5UOXo4NnBvYUNTdUR1NlhDcmZaUGJPM0VxVE44eUhpYjN5dUpWbmJq?=
 =?utf-8?B?VW1YSmVRM0hZUG9IZkMwd1pVckg0Z2JnZU1vWGpsMUxlUGxYREVRcno2dFYw?=
 =?utf-8?B?UjRZaUpXQjlOU1ZtUGJhMjZMRzN6RUx0eitTOVVENWlYbzgzaEVobXJGRVFj?=
 =?utf-8?B?R2pXR1RjUldLVTVtNDlpZEp5ak9OTGRsTkZXK1ZiN2JCd2JrSlgzM3ZmNTYr?=
 =?utf-8?B?T0hTYzdpOTVLR0ticnJnRGJlVWFxTHhROUVJcWRGbnBaV0RkVm41YUl4cmVJ?=
 =?utf-8?B?NmVNWFZERTBSSkRNdUJCVW5qaFZPeHJWZzJBYTduWnlIUGhSRUc0UTZyWTZI?=
 =?utf-8?B?RFJRQitXY2VtREVhUXRDYjI4K2VhM2ZGNjdMWUNSdk5wWStJQU5jU0hBRDEv?=
 =?utf-8?B?Z1ZETVdRT1BzSzhaeVZsUEJLY1lNWlZNd3dBMk9XSVQ1alBvYVhDbzJsUGVy?=
 =?utf-8?Q?L7nni8vMd2Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR06MB7704.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d40f1f0d-0541-41d7-f4ea-08da0cf81077
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 18:07:59.2960 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TlepffeQ3dIfmOjEAKRTh8gwbahMMlTNhSEFpYy1b/4uRfuQFGR203suISDaGmSN9lTUrYfxfVf6mYikizp4fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR06MB8314
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_112405_648043_9364D45C 
X-CRM114-Status: GOOD (  27.70  )
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

SSBhZ3JlZSB0aGF0IGEgcmVhc29uYWJseSBjb25maWd1cmVkIGVudmlyb25tZW50IHdpbGwgZGlz
dHJpYnV0ZSBrZXlzIGFuZCB1bmlxdWUgTlFOcyBhdCB0aGUgc2FtZSB0aW1lIChhcyBhIHBhaXIp
LiAgQSBjb25maWd1cmF0aW9uIHRoYXQgdHJpZXMgdG8gdXNlIGEgd2VsbC1rbm93biBOUU4gYW5k
IGF1dGhlbnRpY2F0aW9uIGlzbid0IHZlcnkgc2VjdXJlIGluIHRoZSBmaXJzdCBwbGFjZSwgc28g
dGhlcmUgaXNuJ3QgbXVjaCBwb2ludC4gIEFuZCBhIHdlbGwta25vd24gZGlzY292ZXJ5IGNvbnRy
b2xsZXIgdGhhdCBSRVFVSVJFUyBhdXRoZW50aWNhdGlvbiwgd2VsbCwgaXRzIGdldHRpbmcgd2hh
dCBpdCBhc2tlZCBmb3IuDQoNCglGcmVkDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogSm9obiBNZW5lZ2hpbmkgPGptZW5lZ2hpQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdl
ZG5lc2RheSwgTWFyY2ggMjMsIDIwMjIgMjowNCBQTQ0KPiBUbzogS25pZ2h0LCBGcmVkZXJpY2sg
PEZyZWRlcmljay5LbmlnaHRAbmV0YXBwLmNvbT47IENocmlzdG9waCBIZWxsd2lnDQo+IDxoY2hA
bHN0LmRlPjsgSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+IENjOiBTYWdpIEdyaW1i
ZXJnIDxzYWdpQGdyaW1iZXJnLm1lPjsgS2VpdGggQnVzY2gNCj4gPGtlaXRoLmJ1c2NoQHdkYy5j
b20+OyBsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmc7IENocmlzIExlZWNoDQo+IDxjbGVl
Y2hAcmVkaGF0LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIG52bWV0OiBleHBvc2Ug
ZGlzY292ZXJ5IHN1YnN5c3RlbSBpbiBzeXNmcw0KPiANCj4gTmV0QXBwIFNlY3VyaXR5IFdBUk5J
Tkc6IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIERvIG5vdCBjbGljayBsaW5rcyBvcg0KPiBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cg
dGhlIGNvbnRlbnQgaXMNCj4gc2FmZS4NCj4gDQo+IA0KPiANCj4gDQo+IE9uIDMvMjMvMjIgMTM6
MzQsIEtuaWdodCwgRnJlZGVyaWNrIHdyb3RlOg0KPiA+IFBsZWFzZSBkb24ndCBtYWtlIHRoaXMg
YXNzdW1wdGlvbjoNCj4gPg0KPiA+ICAgIDMuIEhvc3RzIHRoYXQgc3VwcG9ydCBBdXRoZW50aWNh
dGlvbiBjYW4gdGhlbiBkaXNjb25uZWN0IGZyb20gdGhlIFdlbGwNCj4gS25vd24NCj4gPiAgICAg
ICBEaXNjb3ZlcnkgQ29udHJvbGxlciBhbmQgcmUtY29ubmVjdCB3aXRoIHRoZSBVbmlxdWUgRGlz
Y292ZXJ5IE5RTi4NCj4gVGhlc2UNCj4gPiAgICAgICBob3N0cyBzaG91bGQgZXhwZWN0IGFuIEFV
VEhSRVE9MSByZXNwb25zZS4NCj4gPg0KPiA+ICAgIDQuIEhvc3RzIHRoYXQgZG9uJ3Qgd2FudCB0
byBzdXBwb3J0IEF1dGhlbnRpY2F0aW9uIGNhbiBpZ25vcmUgdGhlDQo+IFNVQlRZUEUgMDNoDQo+
ID4gICAgICAgTG9nIFBhZ2UgRW50cmllcyBhbmQgb3BlcmF0ZSBub3JtYWxseS4gVGhpcyB3b3Vs
ZCBpbmNsdWRlIGxlZ2FjeSBob3N0cy4NCj4gPg0KPiA+IFRoZXJlIHNob3VsZCBiZSBOTyBhc3N1
bXB0aW9uIHRoYXQgc3VidHlwZSAwM2ggcmVxdWlyZXMgYXV0aGVudGljYXRpb24uDQo+IEl0IHNo
b3VsZCB1c2UgQVVUSFJFUSBvbmx5Lg0KPiANCj4gV2VsbCwgdGhlbiBtYXliZSB3ZSBuZWVkIHRv
IGZpZ3VyZSB0aGF0IG91dC4gIEkgYWdyZWUgdGhhdCBhbnkgd2lyZSBwcm90b2NvbA0KPiB0aGF0
IGRlcGVuZHMgb24gYW4gYXNzdW1wdGlvbiBpcyBhIGJyb2tlbiB3aXJlIHByb3RvY29sLg0KPiAN
Cj4gPiBBbmQsIHdoaWxlIHVzaW5nIGF1dGhlbnRpY2F0aW9uIHdpdGggdGhlIHdlbGwta25vd24g
ZGlzY292ZXJ5DQo+ID4gY29udHJvbGxlciBOUU4gaXMgbm90IHJlY29tbWVuZGVkIChhbmQgbm90
IHZlcnkgc2VjdXJlKSwgdGhlcmUgaXMNCj4gPiBub3RoaW5nIHRoYXQgcHJldmVudHMgdGhlIHNl
dHRpbmcgb2YgQVVUSFJFUT0xIHdoZW4gdXNpbmcgdGhlDQo+ID4gd2VsbC1rbm93biBkaXNjb3Zl
cnkgY29udHJvbGxlciBOUU47DQo+IA0KPiBUaGlzIGlzIHRydWUuIEFjY29yZGluZyB0byB0aGUg
cHJvdG9jb2wgQVVUSFJFUT0xIGNhbiBiZSByZXR1cm5lZCB0byBhbnkNCj4gRmFicmljIENvbm5l
Y3QgY29tbWFuZC4gQnV0IGlmIERpc2NvdmVyeSBDb250cm9sbGVycyBzdGFydCBkb2luZyB0aGlz
LCB0aGV5DQo+IHdpbGwgcHJvYmFibHkgYnJlYWsgOTklIG9mIHRoZSBydW5uaW5nIGhvc3RzIG91
dCBoZXJlLiAgU28gdGhhdCdzIHdoYXRzDQo+IHByZXZlbnRpbmcgaXQgZnJvbSBoYXBwZW5pbmcu
DQo+IA0KPiA+IHNvIGFnYWluLCBJIHdvdWxkIHN1Z2dlc3QgeW91IGRvIG5vdCBqdXN0IGFzc3Vt
ZSB0aGF0IGlzIHRydWUsIGFuZA0KPiA+IHRoYXQgdGhlIGhvc3Qgc3RpbGwgdXNlIEFVVEhSRVEg
dG8gY29udHJvbCBhdXRoZW50aWNhdGlvbiBubyBtYXR0ZXINCj4gd2hhdC93aG8geW91IGFyZSB0
YWxraW5nIHRvLiAgQXMgZm9yIHRhcmdldHMgLSB0aGV5IGFyZSBmcmVlIHRvIGltcGxlbWVudA0K
PiB3aGF0IHRoZWlyIGN1c3RvbWVycyByZXF1aXJlLg0KPiANCj4gSSBkb24ndCBkaXNhZ3JlZS4g
SSdtIGp1c3Qgc2F5aW5nLCB0aGUgcmVhbGl0aWVzIG9mIHR1cm5pbmcgb24gQVVUSFJFUT0xIHdp
dGgNCj4gdGhlIGV4aXRpbmcgd2VsbCBrbm93biBkaXNjb3Zlcnkgc2VydmljZSBpczoNCj4geW91
IHdpbGwgaGF2ZSBtYW55IGhvc3QgdGhhdCBzdWRkZW5seSBmYWlsIHRvIGludGVyb3BlcmF0ZS4N
Cj4gDQo+IC9Kb2huDQoNCg==

