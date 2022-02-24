Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2F9C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Feb 2022 23:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t4o151Ho0RVKmDXxXddVisXXAjURjqhND9ZIfapK9d8=; b=hkAh+LzmSAbweGJOm6mSa4SPdC
	MZ2xZgbnzgqx5D0sayo6GhwvNS5zyYsfuGy2Q2oJvHH9HULIzaErKlB/UYIU393rfqDhPYVbWIqS3
	xvnolUGkHLVEHcEeE3iZQJF8b5UqVCio+UgRdZSvtfoEDL17j7DLqdAu4y4IRM6k3MpKfO/0JBX2F
	3RcfvckMAhFjO3mU1bJnhl77MKkoPFZKLfBd6Jzsx/2v1Gu1Bie3G0Lu6BExWw430qCEFN8di2mAU
	IYX97sLxmb7h76WSDlzeOOduKgt+Sh+FG0vJgLA4SCN9Qm5I/B37Vxt21V6Z3GgOyIRLR3EbB8TKd
	nwbSu0oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNNB8-002eb6-PQ; Thu, 24 Feb 2022 23:05:42 +0000
Received: from mail-mw2nam12on2062d.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::62d]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNNB5-002eaK-S8
 for linux-nvme@lists.infradead.org; Thu, 24 Feb 2022 23:05:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwxvXJZ2vIYlzzV9cjBqNdlG0+1MIjLn8vb5mEsQkcLijdGeQj5D26TJpeqst8Mgqn+zkAzYkaqMyADHqkTq/SG6k2RF6KdvZF4JWnVWv6cPE9NEwqvHNrJDf+KXrWiSm8uE2Juh9A99s0UqYSrEKPdCoT9PIoMTLW/ZKYu6pndtuWy1sVw8JLsAhGHlqPC4cyRvmZOBmvBoyk3hRT/krAzJoWJD6rmfY+WCUS+fzfUChYARGHMfgHwpcq0wqHxpXxGA4hJXWqHOa7VKMIQNuXD5zPBXHEETOdwd8hXP6qjA3e9ONDJ4AriNRAsrlpYWmo8C8yYyi7UTfGIoHCDNxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4o151Ho0RVKmDXxXddVisXXAjURjqhND9ZIfapK9d8=;
 b=NQ1g3i/imOmnHSrZGv96MR1WMoohZzwXJ6LR5Ne6wui2LV/4aQULR8XVcygb2CTQRKASKIVvOeVaBu9K288jRm39b6oqFC9TY89jPxruL2hDabvPFtUyDR5tJHX1oj4jwhI5VzMjGRI1+SxDZwNcez8CiUL3/7QqEasQNHj26YmZI+3VjHVzqTNHqOdsswvUWAdlKC42aUUySVc7dkKWf2bnVYV9ASHgcY+BCXXg5r9AHZAhCwyWM6NI2ELiOyzDYILu0vwnSHXiaZbMG1/kmaeUM6a4OPBGX1XbBRPnXa2fr3EJV/kfU5T2scKvGv1YEIC7I94OBVIRzNotONaRNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4o151Ho0RVKmDXxXddVisXXAjURjqhND9ZIfapK9d8=;
 b=D8Od948JcwvfR87j7Z5sQzACbV9vl/9jknS5WjQZgnwhVL47NuB0ncKUrHx0zTybaK/J5hHwwKFniYA7Q8wes4Ikl+ZDPcoqzAW8XXebnezuJKhEW+qrYz8fGOcIJxI6ExWLxM2ymQM08oCXgmEDNENBxeqW4KAFEBziWSQ+a9r2TM6uPQ+SWYzqBgR+xeSfF5z1kcR2/6s0ophzUXoDfrb7MTg4dEVwJSbf2ccLnCrmR7VMJwwWYVA/9UARQSmucHknlBnUkUR+ybsASKf1YRiEerjhIrp+ekfS9hUeg7zBaoouL8Ojf7yLOwIRVWIlhLG2/RgiCugqHACuQdq+qA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB3323.namprd12.prod.outlook.com (2603:10b6:5:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Thu, 24 Feb
 2022 22:50:14 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 22:50:14 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Sagi
 Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/4] nvme: cleanup __nvme_check_ids
Thread-Topic: [PATCH 1/4] nvme: cleanup __nvme_check_ids
Thread-Index: AQHYKbT3zoLJwY1Uw0+W0vZQrfjwxKyjTlsA
Date: Thu, 24 Feb 2022 22:50:14 +0000
Message-ID: <749331a2-2dd1-446e-12f5-e74fe3667ed8@nvidia.com>
References: <20220224192845.1097602-1-hch@lst.de>
 <20220224192845.1097602-2-hch@lst.de>
In-Reply-To: <20220224192845.1097602-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09dc4159-8ee9-4deb-a6cf-08d9f7e80577
x-ms-traffictypediagnostic: DM6PR12MB3323:EE_
x-microsoft-antispam-prvs: <DM6PR12MB33233A0229A7356F208C10E3A33D9@DM6PR12MB3323.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pe3Mwa4Aaogu96q5qwouNORir/6bZ8fL2MwvCwyeJWl0DyhBXZ8h6sbvkKDitFjX8PihwUDYo3YYtLfwR6dTMJRThaixeS4iSvGmr0vxw12eHNxj4//2TCOskzJhAQlYh+tqUA8FLpH17adX2RlbbIE0H2IhvdkWUQ19j6j8ZzPqX/UG2EBln1WM7kMM2dv0yUHgX2r2MhX6GOrlXYqFTZRdSIoHc+4pgVygQsMQeS31JuGOq8YwJmf4XpO81NrQrpsOr+wGKtcuSXp7F7tgUswqpOUPZShpU3wZMOsI4Kv9fty/RL1QG2qM7mHZoLbL8N3POyw+rX0aI2Q1kflc2pFow12aWzu9Mh7AQQzdTgbdVvcUokR33Bm+QrTPH6WqJ6Dc1bIZ2RZYGLkn21/viy982sJpOAbmmdOc1fP11ctd5unGSkayI/UqU+0SC1WHr8rW+SjXfLiC6CeT8A+8LL6MBrsR/XnjxqqK/cp1HYeCMAxoBTFcri/EWE0xLZfuSYHuiqT0xBWlFx/oTso4inStoiHZ3F55mcDxWbbYBni1C3k6grOUJdGdLm29DwSVRLq9TSBleSXgcr3dVv8qnA6mwoLLCt3Ph6OUqOJd3kOF8LKzqeYLFnhmxnMCyAoydCr1T+IJ8iuIkhH8HunPIIUBTMOmLILgIWRxOGqTNksh8mN4B9Mm1ITDzx87h6qa+SDGFpvXL7zgv85g6RYXy25AKI28px14eW/QXzXQPgC8XU+Msg6RDxbNKCtpqLP6DaG+7iALQomTsmNCZgcbSA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(6512007)(186003)(66446008)(6506007)(71200400001)(76116006)(66556008)(64756008)(91956017)(2616005)(5660300002)(2906002)(38070700005)(66476007)(558084003)(53546011)(8676002)(8936002)(122000001)(66946007)(31686004)(36756003)(86362001)(54906003)(508600001)(31696002)(38100700002)(6486002)(6916009)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1ZrYU1TUWd5RVZJL3ZuU1hlNHlobjZBTktsMzY4R2lMK2o4bWlzNDZheGhS?=
 =?utf-8?B?U3FrNGtBeFZoeElJWXNqcXNnSEphVUxGWnVGb0tHMTYzMU9vczJtczdDeFB2?=
 =?utf-8?B?WllKMEdnTWYxY2dBa2ZXZkE4MGFUL1RQREVOR0ZxYzBZVENkd3lPMUpzVlQy?=
 =?utf-8?B?MHlxajhNMjFXVHBGNE1PUkcxZzdaNWxsak1yNW81QXVkZTBrdHBjOGNBSHpD?=
 =?utf-8?B?OEcrL1dxS2htSlpadWZCWXoyNnIvRDYzeXZ2NWJ0azM5c2xCRjA2dllua2Zs?=
 =?utf-8?B?cEswdTR0eXlDZndqczZ4YXdpT2FKMDkwTjJnSTJaQXNJMXpCbWdTVGZkU29s?=
 =?utf-8?B?VUloRWJNNzduSnRJV3pBWllaYU1hTVZjeERiT0o5L0tnRFpSUmJISFRFSTNu?=
 =?utf-8?B?RkFWQnBrRHZZd2hGVzl1QmV4WW5aYm56eWJiMGsyeVlUZ2lHQW5NTCs5UXVQ?=
 =?utf-8?B?dHRVdlZDMFJZa1JiUHNJNHhLRCtyNjNHZDJ5aVBHcloyRmYzWXNNZCtqa3pC?=
 =?utf-8?B?ZlBWcDlEWnMvRkJOWVE3V1orcGpXSTJRL2pZU3M1VkdmUWJhZUlMVHcrbC8r?=
 =?utf-8?B?U0FJVk1Vcms0UWl6Nk1ETGpYd0ltcUpPV3NuYzB4WUVwdWJHbFloMFUvbVB4?=
 =?utf-8?B?RFVSdnpIT2YzNFJYUEczSklhK1Nhd3hPdzRLZEFzVGFXUG1TN0tLVDRRdVpE?=
 =?utf-8?B?Y3BhVEV0VFZkNGsrNDVYVXlycG9PWVhsSVJ0WEhrZkxjd05JdzFjS2REb0hO?=
 =?utf-8?B?ZFE1ZDd4ZWxVVDBTbzFNSStNV3RESytjNjZ2MTV0R1NYN2dydHY5Y3phcWNn?=
 =?utf-8?B?U0d3K2RpblJ5ZDNpTlR6bWZqQ0NMOTdPZDBrV0RHcXBldkdCdlBKVHFPNTdS?=
 =?utf-8?B?ejRVc01OYUpuUkphSDVjQTM4MVhUWUNzLzBSK1I2eHRRb0ZpSUY3b1RxWTdB?=
 =?utf-8?B?cDFwbVByeThIaHNiMmpTNTNBS2J5TFBaTGlURVNrQm03N05ndE42MThlUWN6?=
 =?utf-8?B?eEdQckJOV216TEkyNlRmbFJKTkJhY0tmblptVmNSeU94U3o1S0ZrUXJJRDNl?=
 =?utf-8?B?R2tvTnkwZUJnVzN3aDhRUXpIcFRvV2tBZEZobmZpRXQ1TnVnTnR1M1pUVEVC?=
 =?utf-8?B?STBFek5DN3F6dkRNMnF6cW9zeVNLQUpCNC9Sa29ydzA2cVVxakhOaU5BNEhu?=
 =?utf-8?B?a29Ucmw0MElvT2R4TXdRT2VKSVFDWG9CL1NvMVpndEhtQTNpNk1UQXlUMVcw?=
 =?utf-8?B?cHBUSTVBQmlQMGF0aFk3akh0Q0hrZDBhMVJ1em1sd0RxR0hCM29hcEZDbE1D?=
 =?utf-8?B?bVNIZHBoYXVhYys1UytxRTB6c24wZ05pRGtEMll4Yk9XWUhOdFM5L3dyVldt?=
 =?utf-8?B?UitoNmNsRHQ4T0JUczZvTkR3a0NMVlB6dElGMmkyTHRNWmludzRRNUZNZmcz?=
 =?utf-8?B?RUdZSnFObVg4ZnpubDJwSzZuNEpPVy9ZUzE1R05lOFpzN0JKWFJIeW11SFFI?=
 =?utf-8?B?UW9hRXBtb0o0NldsK3NPQWplZllLeEY0WjlJTGNpMXhOOHlvV0JmdkdPUitD?=
 =?utf-8?B?V0VKNzJoNHc5UkpkWmk0d2poMnQ2WUN3czdPQjhleWlURUVCNUx0elEwYy9W?=
 =?utf-8?B?a0ZRcW5YSTNrLzdlSXhkSXl3Ky80Q1lQQ05pTHhwaDQvdVFFb1RRWmg0bmNL?=
 =?utf-8?B?T2ZaMmZJWTRqVzV6WE1JTitKcXRnZFgvMThhVUpUSXAzaTNWRVhNRUdJaERa?=
 =?utf-8?B?SG5acTgxKy83Qjh1cVhjU3BqMFBBdWU3Y3Q2WFlCNzlZcjltSDRDS3Zjbm0z?=
 =?utf-8?B?c2g4MUVQZE5XaERoYlVzYW9mSjFybGltZlBNdW5CU3ZOMzlDeE9LdTloOSt4?=
 =?utf-8?B?SjBUSlg3aUxSQ2tjaEFORFQ2SlIwOW5Cd3hMMzdJc1l4TVRqWlpJRGZSaEtD?=
 =?utf-8?B?QjJKMm8zanptWVFhRnJ0THJpSmY2S3Y1eVRINE82QmNRb09jM0NaYTE2Y3Fj?=
 =?utf-8?B?R0FNNWZlRlp4WGNRSmVNcDZzQ2twZ2JGeXBPYVl3VUNMSjQydEYwSXdwUVlS?=
 =?utf-8?B?dVU2NnA1SVYvWmdaWmhZU3VSaTZnRjZsNXp2ZGJSQXhkN0d5RzdqMTFCdnlP?=
 =?utf-8?B?NUN2ZjVzUVl6bmo0TTZ4b3orV3VBZUVRSU1QZDBjOWd5aGQ3Q3VCODNMM2hR?=
 =?utf-8?B?ZEpjY1dWNDA5ZVhONkozaGpoK3labFAvVGZsdjNRai90LzNyZENDSUU0V2xq?=
 =?utf-8?B?MUdJOTFKVFdjODdnam8rQmNIalNBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8E598FCF01D2543BDF484559F0A39F2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09dc4159-8ee9-4deb-a6cf-08d9f7e80577
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 22:50:14.5055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZTsje5tdoslx8aefkO3uXOvlP84ZYgyOGckdtL1c3dxqJsO41b9QvDXBvQ1AYU5KsBly/FrLgJQU9XgnfzZYIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3323
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220224_150539_922030_A79553C8 
X-CRM114-Status: GOOD (  10.89  )
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

T24gMi8yNC8yMiAxMToyOCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFBhc3MgdGhlIGFj
dHVhbCBudm1lX25zX2lkcyB1c2VkIGZvciB0aGUgY29tcGFyaXNvbiBpbnN0ZWFkIG9mIHRoZQ0K
PiBuc19oZWFkIHRoYXQgaXNuJ3QgbmVlZGVkIGFuZCB1c2UgYSBtb3JlIGRlc2NyaXB0aXZlIGZ1
bmN0aW9uIG5hbWUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGxzdC5kZT4NCj4gLS0tDQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55
YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCg0K

