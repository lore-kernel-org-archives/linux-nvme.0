Return-Path: <SRS0=fYEw=LL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B50C2B9F4
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jun 2021 04:59:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEAC3610CD
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jun 2021 04:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEAC3610CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mtSOl8i1ii+oHWfoM8l8+/aq/hHXnoNdrHB4Qqff4/k=; b=OYLWJppPex5plH
	txPgM9IMmkU75ypzOim0KqCv7/XY6U/wX2FcKt2nREGoB2pi4S1+A05JLwDYM+ttskbfWfSA6yJPN
	oP4eccNLVMCV12MHuuyF81MthcK4bjvdtB5kVwTIb6kYqcXhf8eK77ZqZLjy8drO2wHesRjIW0a3l
	fMlgJq38RO2vZwxjGu/iub1lP0IAQeRGTub7uMB9Md0s0Je4WaT31qDjtZTPeIHmgacSh4wWjSOSo
	sayM1ObdahZbqPVAJQDFGpJTjR2gy5UGl0DB2uaTLp99Z+p7xTpBEXe9zvsGSfYchF89AOW8fDRle
	q931ffZm1ddl6Kduay7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltk7a-008p0X-S7; Thu, 17 Jun 2021 04:59:18 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltk7Y-008p00-B4
 for linux-nvme@lists.infradead.org; Thu, 17 Jun 2021 04:59:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623905956; x=1655441956;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lBvgmlTO8ukTGQytevLlsdmhe8nbUWRvEGe3QqMvibg=;
 b=faIfmQz/MMn8fomRjiBfKq1PswCyjYzzdBe/HSuXXDXoj8jD/d8TXxaH
 vcQ6lICt1BZrJouQo211Kd6wn5teZj6VbAwysXYKpEpAKcU+lMcijD+nr
 krTmpLIFAf8Sfpss+bi0LSjYLNTG6h3LCSGz3Jo88i/vwq7dsoS3et9rY
 suiLGX+3qlMXQIgWo1Dg6++ktvEQcv1MsYJ5nqQx8Lk3BpL6cv9NP4q3v
 SgSCAzFwfoi5WUnA5wx/glZxKzGN/2mYf7g1JI0uNlC01ztyOOAVdc0YL
 tdHtPKRVTOeOSFuUCGz6GwIPwM9yHbOXBxYohJOSWQLLlfxrb61D1KQPP w==;
IronPort-SDR: ikzxokZp8EVYDtTXMm+qokw6VHK3xKyZxuiyT3R5D0vHgUqYlNZxrRhULB0c/BR//j9RJ4iwdh
 GiLbLKlUwEuSf2VyBhWj0VUnkCNdHJaYcCLd3VcYv7kveSoBQSUxpt9omi4RR7bMvtoDlUMwoZ
 aYOfOs7yvJ+P+wTnCFjGLsKOjAbOizRrVU0JwLaKWdVQXJzWqx1vIeQU0vlBYjTHCO8ujo6Ysi
 T6Z+yTVTlI/Cu56g7EMF0FkGZDkTlwkDLD49Fty9kmYsWimTpkPrEy1+t/EWxIGNaaxHpKQ0SV
 qes=
X-IronPort-AV: E=Sophos;i="5.83,278,1616428800"; d="scan'208";a="171433876"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
 by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2021 12:59:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYPFLxqO4gnE2vantITuuQ9beSB1xpbyr0kvZg/j3bdFJKEuxag/m/0UHTuoQSO1+Ajg0h0mmAsceWCOcTeTl1Cwq98JsEVlckOqGR+Q/9rpdzzocXY5P1oyxJh4/KPj7mR2mW6t3gcm22oP9EosDDHXh3qtTnz8TkDTqDV652lgLAmKRdclioWB7bN8mEZcKcTt9vhSVttQBcJtm/RasDKNbRY+Ta4scOk05C5cpmz4mMPYL2ueS7Mas+Exu0k4I4ZNOdfDGQ6xYN+o6PsdfW3DZO5JQwHJrc2YW4LKah0qF65YPlIlZAE9eHmaV3areYMcn6je+t9IXycK6Gjqzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBvgmlTO8ukTGQytevLlsdmhe8nbUWRvEGe3QqMvibg=;
 b=YVKE5uz7PnLlr0F7wrd8MyWJSrDOMRKX1Hn0xcb5LnHfzVWMG9/zE4yxIlyt7DBK177mUOEpbhPJ3Yl2nvlHtjTQD60S3FXQmyGogUg6piJ3zmQAZmuCBkaPOhqWor1KOq+DFIW6oIaFb88ixSUSB7xotTuriM4xM/9BsP5CC4Lc+CnKb3XJUnrdeu8AIoee0FNG/C+gmrluLULM8xNpUel/7Xo7H7SRaswM2/SAE4ap0S/TuVUgpILjqOS8hoiDyTJ7Y5VQz8J7U2JIgedu5Bvs5nJy6gNuzTqYWj3KL4IcluCaLKTv+iCmVWw6bb0C/6ELyuOLn5t4U/YKIfyCmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBvgmlTO8ukTGQytevLlsdmhe8nbUWRvEGe3QqMvibg=;
 b=EwV5I17vmnCzdRok0SrKLgkUxIcN3/Nm8fdek3djm1U0kEu0vYsbOBJVGuu5xRmgcAjoApOlqLxZGQyPRjS/qvN4MNm7A7qy7ZQbh7Qhketqw5bc9h1P135qVn29DiifEsOI9RwrWDl7iQo2EwlV8QmNlzpY5pUmmETiuHC9uAY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4870.namprd04.prod.outlook.com (2603:10b6:a03:4a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Thu, 17 Jun
 2021 04:59:11 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4219.026; Thu, 17 Jun 2021
 04:59:11 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Prabhakar
 Kushwaha <pkushwaha@marvell.com>, Shai Malin <smalin@marvell.com>, Omkar
 Kulkarni <okulkarni@marvell.com>, "malin1024@gmail.com" <malin1024@gmail.com>
Subject: Re: [PATCH 4/4] nvme-tcp: use ctrl sgl check helper
Thread-Topic: [PATCH 4/4] nvme-tcp: use ctrl sgl check helper
Thread-Index: AQHXXZgARjX6e1SJqkmhYgcmOxFQL6sXdxcAgAA4v+E=
Date: Thu, 17 Jun 2021 04:59:11 +0000
Message-ID: <132CA045-F44B-432B-A995-779A5D108E28@wdc.com>
References: <20210610012826.53398-1-chaitanya.kulkarni@wdc.com>
 <20210610012826.53398-5-chaitanya.kulkarni@wdc.com>,
 <CAJ2QiJLSfoZ0qXJoJ_n_1Z=7JzL_TZp0ZY2Wb0EgB-bQNzatjw@mail.gmail.com>
In-Reply-To: <CAJ2QiJLSfoZ0qXJoJ_n_1Z=7JzL_TZp0ZY2Wb0EgB-bQNzatjw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=wdc.com;
x-originating-ip: [2607:fb90:482d:779e:f40e:9d3e:d08e:567e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5697d468-283c-4189-5fd7-08d9314ca5c2
x-ms-traffictypediagnostic: BYAPR04MB4870:
x-microsoft-antispam-prvs: <BYAPR04MB48706C03A13C55CACEDA151A860E9@BYAPR04MB4870.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d3pk2iJuaZ/GCorH3VUL6QF4oJnTT17Zh35dBj3k9DrqCF5wQRJv6taT4JXE+EVuNB000/vEkEUNMbTcoapYgWMrC8WIFPLJd3Xv1LH+qvFUm4besEFSqY5BEpxzQhXNFJYgMnDmqxnmSeMMa56bD9QFFALB4LBN5y/qmrRKnj1rY9+WcSQF7U9+Bn+WuZSlug2SQvIjnSZ9+sLAyZvTB5AeIfD8YPpMUMIXDhOqEeK1I1k6P0j3+vRb3TFa/z04+DeRAGdsH3KrsKrmGH4P12yGBXc2kMrvvbGAsRsaZkqK0i++5jD5y1EVJZa0nXk4lJwR/rfuJeNLew6ocFt/tus2t4OYs0SkMSKYfwMPYiEf7Eg1TdWvA5E03pj7kXAM2eUNcKotBXU+uX5VGot6OnkV5Cx6zPUH1NUV5/XC/WGEj7OSk9b2pEGm3lq3zdfumujJqa4fiOtIJd1uocMd/Z8xivYamE2HY5VdJ0K46tS2RaPXS1+9fr02K3CnfklFw66V9DYSgLZ51yrnPgXqhZO67enWgqS2ESgAK1fhuum3+L3kUU2AsOYQC1u+2TKg5RDfcrFzlaklA+PqdVM1QQRkyS9vPEr9sv5k/27PWOumY41mMhg929A9L4rF2T7GBBEKdhhPlU4PG8kZo8D7NopazWVd/nszSXAlpcA7EcWOkboHPdhUyHdlZsb/almn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(86362001)(66446008)(66476007)(478600001)(64756008)(66556008)(54906003)(6512007)(71200400001)(186003)(2906002)(6506007)(2616005)(83380400001)(6486002)(8676002)(4326008)(53546011)(36756003)(316002)(8936002)(76116006)(38100700002)(5660300002)(6916009)(33656002)(66946007)(122000001)(333604002)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3dtUzhSZTJjZ0JQbkF2a1llR1BuTUhHWFl5R0JBNXFSWDgyVTNtV0lXVW12?=
 =?utf-8?B?MlNNOGhMNzFOZ1ZMYXZCNERncVJrWmkxeUdmcXk4Z0N0ZyswMGpFdDJLNW0x?=
 =?utf-8?B?UFQvZUhmeWdWT1dEdkhXN1p6Q2NOa0FieEVrNXllV0hoczhIQzVhbXNhYlI1?=
 =?utf-8?B?SjgvOHRUVmVDbXg1eEE5RXV6OXliOHhhQzZuZ2U4eXZhSUJrUy9YV2xORm1y?=
 =?utf-8?B?bHFlbjUwbVI5SER5WEtrSm1JL1k3WTlmUWd2aE1mZm1hSDhsaFNzSE9IZmow?=
 =?utf-8?B?QVVWdEJZdmJiVVFMU1NzdUxPZkd5aGdidjFFQkZqUmJncmhndkJwMmFualFD?=
 =?utf-8?B?aWRCZnE1QlVtTDcyZ1NIQndLYjlHd25rblVYMkphU0ZyRnp1NzJ1dTl2L0RJ?=
 =?utf-8?B?UVQyczgvc1hCRWJTVmxyNVF5WndOKytMeHNYbGQxYm5Qa29VaThsTFE3SWV3?=
 =?utf-8?B?SlNLbnd6ZExxUkdGQzZhMHlrR1MxWko1cVlxVDhON2RXWWdyK20ySEhlTkN0?=
 =?utf-8?B?TXUrc1M5cEhDWXpnN0pRN1JoMFpRdUVteXJxSkpxSzhkQlhFYjcvTHlqZDV3?=
 =?utf-8?B?NE9abEhkTUJjdXM2VmxGK3ROLzZzcHNqT0tUSk9BZStxM1V0cldpUlZJRklm?=
 =?utf-8?B?M1BiOVBzNG1hNnhsZGtjRlNEWHl1L1N5NTZlU2VLRVFhM1phVGJydVlFNk44?=
 =?utf-8?B?bW9CdDhOc20vSUZUeEZxZ05LeGVDK3RmZS85bjVLcWVhdU5xaEt6b0JqaExj?=
 =?utf-8?B?QmFDNncxN1o5Qm5OV25tNStOZmJJenB1OXZPZkZlVXVnYTMyNHhJRFA2STRn?=
 =?utf-8?B?aW4zaytIc2UyMTFTbjdaY0ZnaWcwY3o1MjZLcnBTTkZvMjNqUTZUOC9nYmcz?=
 =?utf-8?B?NkZ6NFJHM0dtTVlLaElEcU00TU81dzl2UDI4ZVRXTnFmbjJVa1NFS1VFMWNn?=
 =?utf-8?B?b1Y3MExGVENxVjN6cEh2cnRDY2ZLNnB1YlpJZ2FwdzJDcWJHc1hZNlR3TFVm?=
 =?utf-8?B?b08raWczQkpjWThDdEJWb1M4dmhleVVBZVhrZlFDVkZlTE5RczFYRGNqOENq?=
 =?utf-8?B?QkdQd3lwNXZtekIrRzB4ZEpuYXR6S0dtTDF5YTgrbWdua01Qb3FNeklNSDhZ?=
 =?utf-8?B?b3VCOUE5cUs3ZkJCdVo4OEFZQlZIUklvL0JLWDE2UEhWaWU2S1VPNDFGVjl6?=
 =?utf-8?B?MmMzZ3ZiM2V2UkRpbGpTNGhLRGpMbTBrTmxZMm9kaUVXQ0xGMFdVbndTS1Mr?=
 =?utf-8?B?R0RsMFFUNVFiQVZITjZIOGhwMmhieWdqZ3J5bDhBSXFkOGtkR040TmdRVit4?=
 =?utf-8?B?eE5FeUZTTXV6MXpXVHpXclZIdXFGdTFuaGJvZTk2TU9JU0tOM2tabmVLQ3lG?=
 =?utf-8?B?OHk2Ui80bGFjMmNhb2UvdG5nUHdmeExrNjc0YThTNmtERDY3ZFpIdmxCOHlo?=
 =?utf-8?B?NW5YZ0o5ZElvZ01GVStqeUVLeVhzWnJFMFNvRFp0eHZjcVAraGMxYXc3YXFK?=
 =?utf-8?B?WnlXZ0dNVVdNVFg0ODRKZzQrZkJQZjRNOUJ0ekI1aHlSNnYxZ0NMbTNuc2Zz?=
 =?utf-8?B?UlBkM3BrbVpoSCtaYlpSZ0pBcStwSEhDREhVNUU1SkcxVjBpa01PSFlFUkhh?=
 =?utf-8?B?N0o1VlBaY3VFSk1ESlVpcExUMWJDNXc4ZVlZdlZjOXFickp4em44aDUyU2g0?=
 =?utf-8?B?WjhBTmRTeW1McFdJMVVyVTAwL0FhSmtwVHRYU2pCcFZ4WHF6RkVEQVlyekFw?=
 =?utf-8?B?MS9VSkVKOTJiU1dXaTRBMThMMW5nRHF3YTVTUk1BZXN2ZFBlVXE2WVdtNDNK?=
 =?utf-8?B?cGVINlVKSWc4c1VTZ2VPamV0MXhtTTRqa1dua1phN1FacWxiNjRoNnV0NVox?=
 =?utf-8?Q?8RaLEMSyJ4zhM?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5697d468-283c-4189-5fd7-08d9314ca5c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2021 04:59:11.7060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TgRF3EaS1vD2osP697msfVAP/W/ZxuYDs15S/lyIw+09tJ3X00aSUAG+SAPhcGz8aWRzcfioIt2pJVdrZdad7CR/0rEDCC/aE9uDL3JKajk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4870
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210616_215916_548590_50F7B55C 
X-CRM114-Status: GOOD (  23.80  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

DQoNCj4gT24gSnVuIDE2LCAyMDIxLCBhdCA2OjM3IFBNLCBQcmFiaGFrYXIgS3VzaHdhaGEgPHBy
YWJoYWthci5wa2luQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79IaSBDaGFpdGFueWEsDQo+
IA0KPj4gT24gVGh1LCBKdW4gMTAsIDIwMjEgYXQgNzowNCBBTSBDaGFpdGFueWEgS3Vsa2FybmkN
Cj4+IDxjaGFpdGFueWEua3Vsa2FybmlAd2RjLmNvbT4gd3JvdGU6DQo+PiANCj4+IFVzZSB0aGUg
aGVscGVyIHRvIGNoZWNrIE5WTWUgY29udHJvbGxlcidzIFNHTCBzdXBwb3J0Lg0KPj4gDQo+PiBS
ZXZpZXdlZC1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4NCj4+IFNpZ25lZC1v
ZmYtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8Y2hhaXRhbnlhLmt1bGthcm5pQHdkYy5jb20+DQo+
PiAtLS0NCj4+IGRyaXZlcnMvbnZtZS9ob3N0L3RjcC5jIHwgMiArLQ0KPj4gMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL252bWUvaG9zdC90Y3AuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jDQo+PiBpbmRl
eCA2YTY1YjA1MTYxODAuLmM3YmQzNzEwM2NmNCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbnZt
ZS9ob3N0L3RjcC5jDQo+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC90Y3AuYw0KPj4gQEAgLTE5
OTMsNyArMTk5Myw3IEBAIHN0YXRpYyBpbnQgbnZtZV90Y3Bfc2V0dXBfY3RybChzdHJ1Y3QgbnZt
ZV9jdHJsICpjdHJsLCBib29sIG5ldykNCj4+ICAgICAgICAgICAgICAgIGdvdG8gZGVzdHJveV9h
ZG1pbjsNCj4+ICAgICAgICB9DQo+PiANCj4+IC0gICAgICAgaWYgKCEoY3RybC0+c2dscyAmICgo
MSA8PCAwKSB8ICgxIDw8IDEpKSkpIHsNCj4+ICsgICAgICAgaWYgKCFudm1lX2N0cmxfc2dsX3N1
cHBvcnRlZChjdHJsKSkgew0KPj4gICAgICAgICAgICAgICAgcmV0ID0gLUVPUE5PVFNVUFA7DQo+
PiAgICAgICAgICAgICAgICBkZXZfZXJyKGN0cmwtPmRldmljZSwgIk1hbmRhdG9yeSBzZ2xzIGFy
ZSBub3Qgc3VwcG9ydGVkIVxuIik7DQo+PiAgICAgICAgICAgICAgICBnb3RvIGRlc3Ryb3lfYWRt
aW47DQo+PiAtLQ0KPj4gMi4yMi4xDQo+PiANCj4+IA0KPiANCj4gYmFzZSBwYXRjaCBkZWZpbmVz
IG52bWVfY3RybF9zZ2xfc3VwcG9ydGVkIGFzIGJlbG93DQo+ICtzdGF0aWMgaW5saW5lIGJvb2wg
bnZtZV9jdHJsX3NnbF9zdXBwb3J0ZWQoc3RydWN0IG52bWVfY3RybCAqY3RybCkNCj4gK3sNCj4g
KyAgICBpZiAoIShjdHJsLT5zZ2xzICYgKCgxIDw8IDApIHwgKDEgPDwgMSkpKSkNCj4gKyAgICAg
ICAgcmV0dXJuIHRydWU7DQo+ICsNCj4gKyAgICByZXR1cm4gZmFsc2U7DQo+ICt9DQo+IA0KPiBU
aGUgIiEiIGlzIGFscmVhZHkgcGFydCBvZiBudm1lX2N0cmxfc2dsX3N1cHBvcnRlZCgpLiBUaGVy
ZSBpcyBubw0KPiBwb2ludCBpbiBrZWVwaW5nICIhIiBhdCBvdGhlciBwbGFjZXMuDQo+IFNvLCBl
aXRoZXIgcmVtb3ZlICIhIiBmcm9tIG90aGVyIHBsYWNlcyBvciBmcm9tIG52bWVfY3RybF9zZ2xf
c3VwcG9ydGVkKCkuDQo+IA0KPiBJIHJlcXVlc3QgeW91IHRvIGNoZWNrIHRoZSBsb2dpYyBhZ2Fp
bi4NCj4gSW4gY2FzZSB5b3UgYXJlIHBsYW5uaW5nIHRvIGZpeCwgdGhlIGJlc3QgcGxhY2Ugd291
bGQgYmUNCj4gbnZtZV9jdHJsX3NnbF9zdXBwb3J0ZWQoKSB0byBoYXZlIG1pbmltYWwgY2hhbmdl
cy4NCj4gDQo+IC1waw0KDQoNClRoYW5rcyBmb3IgcG9pbnRpbmcgdGhpcyBvdXQuIEknbGwgc2Vu
ZCBvdXQgdGhlIGZpeCBzaG9ydGx5LiANCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtbnZtZQo=
