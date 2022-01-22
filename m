Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B25C433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Jan 2022 04:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/j/RG+BEUxWPDgJokLtPdHM3mmPOS9t6KLTs8jChMOY=; b=1jSQmlyvhNLXs6DeLTYzHKhaSj
	PHQ7UczeOxTOpaI3Bo3V8Ev3VnW1Tb8QxzjOLE+1fdnlDMvJ0BFFrM02zw3kemOhFdWJ9DQTeVUrB
	Eilj0rgcPIB2eAWCOGhSj6DZkti8IPFKez2S2e/bKnnwL9DC3yKjJBZo61J0lubQf66Svu+bWhhHB
	aKjtGCxI3DPu+BZ05KMRrNK1S6JVey7kPJXPX42/rtFi00efYGnXj4wXAysxK9wTuy+9h1ilVmjvH
	vNz8MVXrDWsWWUZ2l+HsKdZHdoetkiYukDlDRzU5/b7fo3Z9lrYC6ZJ4hg2IRYbtHgOBm950yIFfG
	cKMCFjVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nB80O-00GaqX-M2; Sat, 22 Jan 2022 04:28:00 +0000
Received: from mail-bn8nam12on2073.outbound.protection.outlook.com
 ([40.107.237.73] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nB80L-00GaqB-Ks
 for linux-nvme@lists.infradead.org; Sat, 22 Jan 2022 04:27:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpQ8WeTkvFQUUjitusjLtdkepWbVAqa0oRvOuCepFBgr60CjMEeLwFJRR1VJewjGiLRLfMm7zCgP7zYfrw3Fvwd61yU47gOyrsaNtcaFAG7LM/k7H+JQx9nM2n18GwKvtdWlwuYswwnsH81wF/WAHw4OA93la9B67Mr0t4e/uFWm8RZWKtTkW3MKG8BzRHkFzB2etjQ5w76t6PvSYNpivTTdbUJdcNZufJofFJ2UQWoiZVLqKTGHN3A6u0/Oo6uZ8k+2YtxUYSuEJvKJPUmhcNilclkqoyR/NFY4XvqM8kJRQKtJKpGn/rFHdGvDbcpxvHAgZaRBLUWVusnXWn4WeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/j/RG+BEUxWPDgJokLtPdHM3mmPOS9t6KLTs8jChMOY=;
 b=FIMdSCJJFumG8qbaMA6PQaxestlJyTGwIVE0Q7m8YPwi72QY+XY4o7p7a7u98SnIIt7UEu46ZSouIJ88pVBkeXh58+gubelJ669LQ7/a3Sn9PGtAyggwy1NtNoI6U2KGtKRawVvqihnrXlwhIe8UCWDkVHkVKXVBZxt+k5W+WZrIBUhAj005ocgOV4wDoL6U9I5VVWvrXTR62HGQO4guFfdAQmSPQnCLNOD4I3og9nOShxC6QRi0Wq0uPPPzsEKkvrN8qvbU072cr7IjINcL7M0opVLX3EWXa9tHi1jtrqI9z+DYjiyFDbhYm0chyANyyImH3In8gLK1v3Gh14sViw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/j/RG+BEUxWPDgJokLtPdHM3mmPOS9t6KLTs8jChMOY=;
 b=OIU58v4eeObELStMtM9MhusVSTeKXbOrWyanBRHX6egid0W/fszbFnoG8OuYyjqohr/pZbrairJDQkNORMjh8ZyaXn2uJJZoe1x6ie6fgoW+ST8QQd9WvniR2uGNKrwRZdnyJWTIWAKEbS7YiS7IqnfsWmILPMW6/XHL3lOU1DtUIyYxutFXBnSJn443i3EVHtzNOTANMaRcqz8V3t0EjHR85HeE3Oi3zmXm8+Ig/nyMD9va/rggYlujWTZuAYORL4pYwttUdezsX1BGL9udcuYOV6lNEtDu5K52VKJGo4QivtUUUUJBUQSJbsKwnvTMWceV0V/X5vnRBbcTq0yUxA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Sat, 22 Jan
 2022 04:27:53 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f%6]) with mapi id 15.20.4909.012; Sat, 22 Jan 2022
 04:27:53 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: kernel test robot <lkp@intel.com>, Hannes Reinecke <hare@suse.de>
CC: "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi Grimberg
 <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-fabrics: fix returnvar.cocci warnings
Thread-Topic: [PATCH] nvme-fabrics: fix returnvar.cocci warnings
Thread-Index: AQHYDz626tDTsLRGYkOekKj26MfBjKxuclkA
Date: Sat, 22 Jan 2022 04:27:53 +0000
Message-ID: <f4c2f81c-eafe-6fef-88c9-952b668e7e23@nvidia.com>
References: <202201221116.hWZkKqts-lkp@intel.com>
 <20220122031737.GA31599@fba2a898af35>
In-Reply-To: <20220122031737.GA31599@fba2a898af35>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63052ae7-4276-49b5-df6a-08d9dd5f8e9f
x-ms-traffictypediagnostic: MW3PR12MB4411:EE_
x-microsoft-antispam-prvs: <MW3PR12MB44119C3FC7A760B556F12C8FA35C9@MW3PR12MB4411.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XTTjON1DARp9LikZUBFKaQorhgxrWEqCwuKH2DEhQP1DzhSBT/n6u0dHnHmZfeIjevCSAXNO2Mhs1ePiraOBpSXLTPmRL9erw7A8HcDEpuMcPtUDGjvCVj4aZGNaRJVlYhBaC/QncEMfKZNTwWVL9whjb6c69Xn32rvbzgiifxq3DaLwp/JDuaBHTjuttbPSRDdAVJLUsBWg7Y5lrdZwjHePY8E5TbftMF4SwFDt5SysH2AKQtptH8imTqWxSFvEu2oq5q4dCacPHMsGYbpCVaeB3MN5AMEQ+C93wL4IZB7evIf9WJqPxiP6RVLDCGi9kX/Klcy/WG1az4xCf+bTH+tCXyAoHF9yIMQRWNO42tpJ2MilemlPF09U+4WnP+86VoeaBfVOMzBsNprTkTkCNcxvJkBzG+BbrLctw5IAvIkPdSsO6ZXcPfUFSaTHN74BFvM5D5QFs+MSUqTRlG2VqeAf6YUw+apfF5Tvxj9BeBvqvxOdFbU+mMdvVP8sm4GfgzJqt4MgXkaEQMql6D7FL/77UjswDwwH0aHGpvLt8ANdBVBzETWl0J9a1mJydDIYo1iNWgKszFYb1I0nFJCDgflX59Voq5tYFCA60coYsgSFYGhvksOxs73LVFqM/c4KC9Xe4lWce3KcUhzWXA2UlJ42oA0iwAknDx95/uR4F08jKmweVMg9vGKUfgV2W/nMduhfiqvgE7aTCkArmTwxAH1283DKK6iKEuwb19uz/iFqMHHVk2/QLhiE0WPnwZG0cApA+gwxvtgkbYn+Juztfg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(38100700002)(38070700005)(316002)(31686004)(53546011)(31696002)(4744005)(6506007)(5660300002)(86362001)(8936002)(76116006)(2616005)(6512007)(110136005)(54906003)(91956017)(36756003)(2906002)(508600001)(8676002)(66446008)(64756008)(66556008)(71200400001)(66946007)(66476007)(6486002)(4326008)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFM3YjMvQVR3Y2oxZGtzbkNncGNVZldmaFpQc1Z5MHVqZWdqcWx6ZTBXUG0y?=
 =?utf-8?B?cmlJYWpQNUFUWDVFVkpQYzVKT0hTMTZxZzhjdXQzUDhCdWZJZ1RaeWd6WUlu?=
 =?utf-8?B?RTNJTitBdUx0OHArODlodUtYeVB3UTJWOURKeVAwc1NUd0RXZVJPTjdXVHBn?=
 =?utf-8?B?L1VHcTl2WWM1dFlzMjBNOXlneVcxeGwvczNrdHQ2dUx4M2RreWEzYzl3aFZs?=
 =?utf-8?B?eWQwUHkrTWwxcFpTa2YrVm5YM2Q5VE5JMm4vR2dscHZFenRSK0pFOVU1VGho?=
 =?utf-8?B?Y2JkWmVXS2VheWwvVm1RcVVNZUNVTDcrL3pFVkxTNEVjSWd6Q0FKZGU0dTQ3?=
 =?utf-8?B?L2MzYktFV0xUNzdHTWdQVE1mMVV5b085NVRJVlp2VkNzNWJUcGNiTWNCSThs?=
 =?utf-8?B?YzJsaGZ0aXdnbUh2dU1HcE1PSmQzdWw0NGJuSzhCb2hsUGJuekpzM25TeFNk?=
 =?utf-8?B?a2RlcFVYYkQ1N1pkdHNhdTdlTFF4aUdlYkVvNHZZaDNmdlFBVThSNUo3R3lC?=
 =?utf-8?B?VGQvZHBYTjJhcmtrR1pwemkxcjlOL0RJYUlYcVFReVhYcVlaRlNDMVJuNTJK?=
 =?utf-8?B?SkNicDk2dmo4WlNLUHJwZzZMVFRYMDkxWkViTDFWTlJ3MjJMQUJQWlBHMXpz?=
 =?utf-8?B?TkdlNjRGV0ZBOE0vbEVzeTNZSXFuSTJPN3U3cFh0UTJzTGJVa2o4MnZNenZT?=
 =?utf-8?B?dEx1dktlZXhWTHNQL1ozcjlaT0pZaVJYWkpSODNYSG5oR1JyN3IrNlJkTUhz?=
 =?utf-8?B?MHFrTzUrR0I0V3V0ZmxWSVQ1d1FWaGhNanlJVTBZQVI5V01OcjNodmVsR3hQ?=
 =?utf-8?B?NFU0ZkJYMTR4Ujl5L1Z4R1plZ3FMem94aHppakI0YUQramFUVVZ5R1VZeEdR?=
 =?utf-8?B?dHo5NXF3Q2IwU05ZNU9PeFo2VytMeCs1RlE5QkdQSHFUYVZQUklHZTZnT1Bh?=
 =?utf-8?B?SnNlc29tUEIyc0VXb0w1RjBKdzhqRGNFNWcwWkpyNU1rWWpDenFGYmFYREJa?=
 =?utf-8?B?eEx4anZXUVhnOTFydUdFYWJTNi9tSTU2S1lvTkk5TDUxZzQ2WXVncE9vaTlB?=
 =?utf-8?B?dDdua0NiUGRHMFdxa2hsNlRxUzZ1VXNzQitOLzFXWjd0ZnRnWW5hUGtxRlM2?=
 =?utf-8?B?TXlUM1BmWnRWZkF3dVA5UTgrRzExU1dySUpLZ1pmZCtueWdxQnBzTitlUCsy?=
 =?utf-8?B?alpkUUY4VHFkSXNMajcvbEtSQjRuOU5Va2dqUno5blE0L2tNQU15MHlVYTRu?=
 =?utf-8?B?SmdmZFZiWGVpUkpnVnFPeXhtaTNNRzNVQnJQQnF1OWRDV1BwK0RDNVNTZXpj?=
 =?utf-8?B?djUwTHJyTGRaRldaenFHRnYxbStIcGZjMm5qQW04UGthek5oODFGaFhIQjRQ?=
 =?utf-8?B?VzQ0NDVPNTRVTTh3RlcrUXBYb1BjdkdUWmhwZXVtTE5vc3JXaHpxT2FaMm9u?=
 =?utf-8?B?UE1tbDJpSG85OVVJZ2s3RXdBRi90VHRycUNsZWRFSWRyK2dyaDJISmdGbWY0?=
 =?utf-8?B?VUo1U0ZJb0o1N3Z2NldLcFRMOS9Xb1V5U3hOOEptWUZIaGowazNxTzBzWHRR?=
 =?utf-8?B?NkVSTG81T29zZXl1eHFCSGRVSmFEYzZ3UWYrRVpCV1NPb3QxSDBiSWtNMndI?=
 =?utf-8?B?dWZFalpGVVh6YkNpWlYwRlFORSs4NlpQL2NPb1R2ZDhyVXhMVWhZUkwxSUVh?=
 =?utf-8?B?R1BZOUJycHEzTlE5WUhnaFhDNmc5SThsK0RFZGFwUGx0cjJQdGpOQlRZYUFE?=
 =?utf-8?B?SFBsV2I2aHh5Um5Fc1pQREdPOHFHQ1poR2tDTHMzTVRWV1dqTjdtZThmcHZa?=
 =?utf-8?B?Q0RiZEc5ZUNXVytxaDJCU3pYS2xKZWlqdkRWUHkybWRDSTVKT0tCOC91UHJi?=
 =?utf-8?B?a2s3RmdmcXRMQTFDc0R5dkJVY3lrZENxWkNMbFBKdjFFNEtNVjVzSFdMNFVS?=
 =?utf-8?B?WUJuSFN1QnpadmNWV1RHcUV1bmp5UGtBaFR3OG9taENQZTJPMEtnM0tmU2hp?=
 =?utf-8?B?dW9ORXFvQUtESDFLSS9FdXNWR0ZqMGdxNXBudkJFeWx1VEoxbnp5VEIvamM2?=
 =?utf-8?B?OG50dnFScDVkRlNzZnZLeUVvQkZVOUxXY1VWclVQSFR4ZUprb3pSSklqT1Iw?=
 =?utf-8?B?eCtDU3ZlaXNoTmtTMStUWk8xd05tUVZzalA4aU1hY2d0UTVxd2ppclJ1elJF?=
 =?utf-8?Q?gwAHKupNKr/5UJi54NsE+wodz64frrxFgwBs+4+jaQ7y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3226D65F4C734346B56FBEA70763C76A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63052ae7-4276-49b5-df6a-08d9dd5f8e9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2022 04:27:53.3328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2v4JDz4YfTi8OGU+rOG/3EswqGI2lG5JPpFvf1Tl2PwwVXO5CAMrYKIsW5tncYAbbYLIxZM9QxPV5K12lcLbRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220121_202757_872124_8030FCF1 
X-CRM114-Status: GOOD (  10.64  )
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

T24gMS8yMS8yMiAxOToxNywga2VybmVsIHRlc3Qgcm9ib3Qgd3JvdGU6DQo+IEV4dGVybmFsIGVt
YWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4g
RnJvbToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+IA0KPiBkcml2ZXJzL252
bWUvaG9zdC9mYWJyaWNzLmM6MTA5NTo1LTg6IFVubmVlZGVkIHZhcmlhYmxlOiAicmV0Ii4gUmV0
dXJuICIwIiBvbiBsaW5lIDExMDkNCj4gDQo+IA0KPiAgIFJlbW92ZSB1bm5lZWRlZCB2YXJpYWJs
ZSB1c2VkIHRvIHN0b3JlIHJldHVybiB2YWx1ZS4NCj4gDQo+IEdlbmVyYXRlZCBieTogc2NyaXB0
cy9jb2NjaW5lbGxlL21pc2MvcmV0dXJudmFyLmNvY2NpDQo+IA0KPiBGaXhlczogZjE4ZWUzZDk4
ODE1ICgibnZtZS1mYWJyaWNzOiBwcmludCBvdXQgdmFsaWQgYXJndW1lbnRzIHdoZW4gcmVhZGlu
ZyBmcm9tIC9kZXYvbnZtZS1mYWJyaWNzIikNCj4gQ0M6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBz
dXNlLmRlPg0KPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiAt
LS0NCg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxr
Y2hAbnZpZGlhLmNvbT4NCg0KDQo=

