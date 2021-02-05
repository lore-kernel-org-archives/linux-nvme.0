Return-Path: <SRS0=OXBW=HH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B018EC433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 18:47:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF7664D9D
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 18:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF7664D9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WUGJiwQE5rQR1h8OeVdKPHwTdxzVStlsgE6WQSYw8po=; b=GulhsyOGaj5HF75/V5+aTCp/8
	OA4EBF+mygYTX94pjPU1/6TKjbchPMdVn9dNqid3y/fSZGHn30tpDNNPxKz2MmAlTzFJFJXi15uPY
	EaYSorBRhN2RF3gRv+Q3LZGlTLoP8lIccNe3Hh9Bt2h5FLZBUPet0t8tgEP0K/4aUFkrGfkxt4LmI
	s4t2LuI9DHvjGapWArG52I1j/20vzFb+no4mqKV2mrEQqELNXFmbw7iKW9IgYRYuJo3MrTsiraPnJ
	nsB+zkDyKnz8jlCFfFocRQjvNvx0t/sNvdLLVtSUcEqIHYC72JkLjNX+OmVAu+C8+NoCTEmdZaMN2
	iZBS26+iQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l868P-00066d-9x; Fri, 05 Feb 2021 18:47:13 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l868L-00065k-L1
 for linux-nvme@lists.infradead.org; Fri, 05 Feb 2021 18:47:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612550829; x=1644086829;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+swEQpzmSZVcCG2IX6399sSqncA8iTn44Gfbm2X9UnU=;
 b=RfzOOUTJ6292pCqret0yotpAbLyPAAqwwGQFBpb30aKn9fNdKWgtDMp8
 GA0/7t0SBMTjXrWBkIinRhmaYSfsdSIJfO7jlNpoO13rTEzSb7TUn0mH7
 QazQxBeI8Q1o+M9PbCH2jNQoMv6INo0j2R1nv1MTJb9dA2Trk21H0nwgZ
 g9PsE+vElnlIMetBgWqwMYXk5EH3CNSPWrBd7cHu0I9W7tyFgB/tX8tNM
 1+4ei/3KNpNvcU9nLyPlWP0hhd7WaEeSe6+LX4Ztyf6fzQDMriFdiaEZG
 eYua8OgThlfVY0zf41WaBu03c40ZTCHnoPLVE5CSgfm+oaYRCPOfjzaWD g==;
IronPort-SDR: YT8zcgdWxCDOHvsuCW+D2xi3B7ge1ay/eQsuWkAbVXuPqhZy9Yp38qlUJafGFXLDf0aWhZJdV5
 hpFHKyyFJv4D5HXZlz5HLoWgl5EfS03K0H6Uhw82QFg9LMKras28l0YnRvWfCl6fesNr94jXdD
 JXHy9TI8gkEZWLG8ijm0VeybV5HWIrxh/M1hXtppny3XB+R0bLZIh+7afZkzIEYDvQjVMfILx2
 Cs9ZJYc2k7tA//FcVf7tZImy05M/jUbCRH1P5LSB7SQHEhHQ9z9VfYbMjbvqacSS+YRGdd6/6y
 wTA=
X-IronPort-AV: E=Sophos;i="5.81,155,1610380800"; d="scan'208";a="159250155"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
 by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2021 02:47:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0JkOBXCa1N5MJlK1qlG50eKDngdGKPDdWzTirBGxvrASTXcGQ37gwPggt8lVSNGSOZRByLgX4RdT+Bndn7S5ZTj3dK5EpZQlW6Mhb46aFzslPGNop8M8BuqYqsYyy8RZ73mNLKUPpo3nPqHhppzSbm/VON9XLVN9q726zReh9iz9Srm70kfmw05sysK3DwvxM6JDZngZH3qpMhtnar6aP1uprd+shaiODYn3iS40AdY8WvReuLbdLx/cWV68zbefS3KsfymveygWIjfn4ySgNGVSTwFEblqBt3h/xTzbvxPVui/EFE3RZyMMrpei8hDHfj2myxtOL1jGhVk8c1VSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+swEQpzmSZVcCG2IX6399sSqncA8iTn44Gfbm2X9UnU=;
 b=TjOkkbKpGSfnRY/kertdQowGcwqT0UkO9BCIQ6FBJcf3R/jZZw0rp4LiutYdmxCM22ZWZycSOY4ZYV8ls4r/NBRTX/1M931H2b2MnfsWcwhMY9SkG3Hbc9rhx7jEEOK6JhQCwuV4H8OehmAWcOSpincStf9VZlAeenHy6Vd0sTzEP3VDHhST5Ad3gctovwbMhaS8DIjyfcjQAthI0haWYSEXP0/wyzOJ/vqrXafHe6ZphJ3XzSZWCA7aqvy/5fHpPYDz7Ae19dvvbyW81h5I8cxgTpZX26YETKI2g6ClfpLz7U6BYQ/2UnJrz2wl8PXWRNkQGxdkGvUJHSWcRbT35A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+swEQpzmSZVcCG2IX6399sSqncA8iTn44Gfbm2X9UnU=;
 b=yvn5g/cYdhNVByeS2ybF3pMUNnN3+JlweWC15wUefcJhoZ5xhijbxgpMKNduhthnZuG6UVai4zmpVn7eaIr72oygidsWfOKMobUr+Y58LxQ01Y9lhSm0pYWs73M/Kg98gbSOvyycatezMnAOYattxZdLRCgsq26jxmKScKDiAn0=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5527.namprd04.prod.outlook.com (2603:10b6:a03:e3::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Fri, 5 Feb
 2021 18:47:04 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.024; Fri, 5 Feb 2021
 18:47:04 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: move NVMF_OPT_CTRL_LOSS_TMO to generic list of
 allowed options
Thread-Topic: [PATCH] nvme: move NVMF_OPT_CTRL_LOSS_TMO to generic list of
 allowed options
Thread-Index: AQHW+9dDuTjleYcWM0KZQ98G1e7d46pJvz4AgAACzYCAACTewg==
Date: Fri, 5 Feb 2021 18:47:04 +0000
Message-ID: <72432D31-3061-494B-8D86-AD28A6CCEA43@wdc.com>
References: <20210205154714.127995-1-hare@suse.de>
 <20210205162506.GA27415@lst.de>, <14420650-7548-3897-3baf-a8c303165842@suse.de>
In-Reply-To: <14420650-7548-3897-3baf-a8c303165842@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:8802:2703:6e00:cd31:a612:8bc6:9059]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f446d44-5f5a-441b-d16d-08d8ca066eab
x-ms-traffictypediagnostic: BYAPR04MB5527:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5527015AC786F455EA38592486B29@BYAPR04MB5527.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2FrrEzgJdfzeikfjVyiT7kOn8qWnGkB9ddzcDghj0ixg4klFOKzPvsFnl7K8b4AyjA3nupLWHyckzQugAZyMvVxFycqib/7qzFWaGGwzd06iv4nQJnQDN8/ctd2MQ0b7rTa89K6yVfm0e8cctpjjycuGepT1lMdDWs4ZPtxTTLyXNGgFNcVLaiBtin82v2VOVNe+JarqJNioJCnZmQrNz9XgHK0r0333XyWr9KRsS2yiDVwoOavBe5+I6S/JhaQLfadjA7pMbamnp1BkPXiHTxWY/xG5XhlbPKyfDcFTuCslLUXecjfj7gPEIde7VWuoX8RKl4MgcH2HBiIDM+uTL75wCJE2nlx3bUiLK/qRGT9LpRncXkO/6xAdhypB0urK3tih9dG2+770jwO3tj5Y/oOlrX8sHf6PH7+zmk+Yx9IJJiPLZFyJa1j9ed2z195LErRdwzn+hk6auSapI2M5cQG9p7UEG9GHhjxolSrTMXzeOPrn3iEuEJSjUROLqg22Yqh9Y/eOcJ45ILQU2S0plwaP1u+XeVrvJCtyWLdHpS1mUrOPs4h4XxldYqBp2o03DGi75Cdt7jY7C/luofuT6MWBgINj9CzJkif2xHYCG6q9ibsXV1GOyK9VEOWSnLR5b9i9s8IuoU25J5YEAGZ/5ASRNQyWrtIlH4XRm1foAOpcZN9flC+4gCo3BE4eTS60
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(6916009)(64756008)(4326008)(186003)(2906002)(5660300002)(66946007)(76116006)(8936002)(33656002)(2616005)(66556008)(66446008)(8676002)(86362001)(6486002)(83380400001)(71200400001)(66574015)(54906003)(36756003)(53546011)(6506007)(966005)(66476007)(478600001)(316002)(6512007)(41533002)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?VmY0UkR4VWNTL25UK3NRSXNBSGZnUjJaVzJzMVFHZjUrbGtzR3Y5OWREcDhZ?=
 =?utf-8?B?Z1NpVWFtSVVOK2owNkdqZkk2WEF4azlPbEpNNkN4MGdVbGMyaDE0T0VERWxL?=
 =?utf-8?B?SWhrU0ZWVXFaK2dvZ0ZpbWdNSzI4UkFFZTNCMFVuakI0aUhOZmVGelExNXBK?=
 =?utf-8?B?SlRWc2ZaMjN5TUV1TmZPeWxZdzJieGYzT2RObDJZRFhhRWpSekhRT0ZBUDRh?=
 =?utf-8?B?K3ZXWUY5UWN4cmJrZ1pzMTdLd01lV3JQc2JUeFVSNmVuUXo2TkxzQTkvWHkw?=
 =?utf-8?B?d0pNU3BWOHZzNGo1NGgvRWpGb1NhUGZ2MlJDMUVKcnovN1g2VkxNWnFVSVJF?=
 =?utf-8?B?NEdScVg2cUZVOC9hakdiaGtpZHlQZ01MbDdCTldHQkxkQ2syZjlGdVRmVFJG?=
 =?utf-8?B?MEg4ZDgxYS95N0x4L1hGdXVaa1lWTDVSV1FadFdsbVFuZW1hK0oreVNYOFpz?=
 =?utf-8?B?TnJQNGpOcjh2UjM4TDlVSmplVWNJRmlkZ0V3amVvaUhFUVBLdm0wTFhKKys2?=
 =?utf-8?B?S042MCszQkljaUVPZitSeVpGQTNHZDRKQjNMS3JxY2FDeGhvWlcva083aERt?=
 =?utf-8?B?eUJxeU1ScmpJWWRXekl1bzZVM0VMNGdGWFBaM2R0Z0Zjcm02TDRkZWRTOHR2?=
 =?utf-8?B?dEllS1JIR1VZME1rcGlnbzF0UDBsQnB5WWVFaWJVTnAwNkN2M3o1b2NFVHlX?=
 =?utf-8?B?MWRQRHh3a0FjL1lsVlozSHNJWlNKcGluWVd3SmhxMHNkYngvc3VmVjFuME03?=
 =?utf-8?B?OXgwKzdwMmpyZnVUbHA1R0dMTjJOdHRMMUp2N0xsS1ZMcHdUaW9jTkZZRGhU?=
 =?utf-8?B?dW5DczVwM29FMGZFU1FncDFvWHZSTTNkaUJxSXZtN1EzNnZ4aDVuZmg0ekNV?=
 =?utf-8?B?bDZ2c1ZDZExoY2hhUk9JMmpmNFlBbW1JcENlclBWUEU5RGhRbzVhUGNXbW9C?=
 =?utf-8?B?cXFMRnJ6b2JqSyt3WXpEN055K1YrSTJLU2NrczFEREpjdkhqR25IOWxlSC9B?=
 =?utf-8?B?RjN0UTBMUDFXSHNNZjVjTHBtaGZJOS8wc1VINEoxK0FETmpOMG5VL290NDlE?=
 =?utf-8?B?cDNYS05OQnJkSGNDMkYrV3lienJBUHY1dWNiVE4zNHUycHp2ZU9GenM0L0xu?=
 =?utf-8?B?OUtQTG0zb2F1T1Zobk5YQVpwMkxNQkkrbVZGYThMUVovdjB6eHpKYWlZeTlF?=
 =?utf-8?B?TnpsT2RxcWxPVHE3Z1JMLzZ0c1pBWGpzTWwzNlFWelM0WTArTTdjYzFkdjJ1?=
 =?utf-8?B?N0xZblNISEtPWDhVN1lyaExMcnFqMlREcHc2eDIwcG41TUxBa0xWbnZuVnFj?=
 =?utf-8?B?NllRLzE3WGZIR0dHV2FGbU5Uejh2bFZEcU9HVlpzR3RidjdZTnZDNlNTaFRx?=
 =?utf-8?B?WmpQNDFKVzQzcXkxWm1WTTY2TU9zUkFCenV4b3Y1a3RialRRR3VGUHZNclBw?=
 =?utf-8?B?aGVjRGxyVXVBa1A5Q2tDRjlDRUxzTURKUEVMNGt2THNWRFRIK1VIaW12a2Zh?=
 =?utf-8?B?ZGtTeENCMGtzQjg0ZzArUnJBUEU3M1ZvZ3Foc1RDK25Kd2JpcnBMZGFLcWgz?=
 =?utf-8?B?NXBRSzloQVdGQmpPTE05UitIWnJqd3VhZ3ZjQlVxZ0s0alZwaEU5aDQ2MVVy?=
 =?utf-8?B?TWRndlAyNkFUQ1NGZTl1ZjNQV2ozdmR3Wm14VzBSVmZRUUxKQkFhUk9hR0Jr?=
 =?utf-8?B?UFZmdGZteHlLVkczZUpiNXFOYWxUeWIxZzhEMlRWbTRpQXl2MlJMTmNtM0ZU?=
 =?utf-8?B?SXpURWJ5MCsrSWNuT04yU2RZcEM4Wis0b3RzZWpYNjNEamhxaUIyYkF3Sm83?=
 =?utf-8?B?eWgraUtvT1dyUnZTSzNON2ZDOHNkVk5GTWw0T3BiOWdmK3JDYVhWNmQ4Y2Zj?=
 =?utf-8?Q?oPlovPPNAOX+X?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f446d44-5f5a-441b-d16d-08d8ca066eab
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2021 18:47:04.7164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oN7dBF/zI9KWjSuiwWAj+CDCYCEABc5RqWxmyZfWY4p3GN64iSWVXHiNrPPgFBBImHfK8VE6X2+Z+BMMkq3x5LYXGAsNPb93y6IcrH2l26c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5527
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210205_134710_029794_B9CDFEE1 
X-CRM114-Status: GOOD (  20.90  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <Keith.Busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

DQo+IE9uIEZlYiA1LCAyMDIxLCBhdCA4OjQ1IEFNLCBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3Vz
ZS5kZT4gd3JvdGU6DQo+IA0KPiDvu79PbiAyLzUvMjEgNToyNSBQTSwgQ2hyaXN0b3BoIEhlbGx3
aWcgd3JvdGU6DQo+Pj4gT24gRnJpLCBGZWIgMDUsIDIwMjEgYXQgMDQ6NDc6MTRQTSArMDEwMCwg
SGFubmVzIFJlaW5lY2tlIHdyb3RlOg0KPj4+IEV2ZXJ5IHNpbmdsZSBmYWJyaWNzIGRyaXZlciB3
aXRoIHRoZSBleGNlcHRpb24gb2YgbG9vcCBpcyBzZXR0aW5nDQo+Pj4gTlZNRl9PUFRfQ1RSTF9M
T1NTX1RNTywgYW5kIHJlY2VudCBudm1lLWNsaSBoYXMgYmVndW4gdG8gc2V0IHRoaXMNCj4+PiBp
biB0aGUgZGVmYXVsdCBvcHRpb25zIHdoZW4gY3JlYXRlIGEgZGlzY292ZXJ5IGNvbnRyb2xsZXIu
DQo+Pj4gQXMgaXQncyBub3QgbGlzdGVkIGZvciBsb29wIGNvbm5lY3Rpb25zIHRvIHRoZSBsb29w
IGNvbnRyb2xsZXIgd2lsbA0KPj4+IGZhaWwuDQo+Pj4gU28gbW92ZSBpdCB0byB0aGUgZ2VuZXJp
YyBvcHRpb25zIHRvIGF2b2lkIHRoaXMgZmFpbHVyZS4NCj4+IFdlbGwsIHRoZSBvcHRpb24gZG9l
c24ndCByZWFsbHkgbWFrZSBzZW5zZSBmb3IgbG9vcC4gIEkgdGhpbmsgbnZtZS1jbGkNCj4+IG5l
ZWRzIHRvIGJlIGZpeGVkIHRvIG5vdCBzZXQgaW4gdGhpcyBjYXNlLg0KPiBOZWl0aGVyIGRvZXMg
TlZNRl9PUFRfRkFJTF9GQVNUX1RNTywgeWV0IHRoZXJlIGl0IGlzIC4uLg0KPiANCg0KSSBoYXZl
IGFscmVhZHkgc2VudCBhIHBhdGNoIHRvIGZpeCB0aGlzIGFuZCB3ZSBoYXZlIGRlY2lkZWQgdG8g
Zml4IHRoZSBpc3N1ZSB3aXRoIE5WTWUtY2xpLiANCg0KDQo+IENoZWVycywNCj4gDQo+IEhhbm5l
cw0KPiAtLSANCj4gRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3Rv
cmFnZSBBcmNoaXRlY3QNCj4gaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKzQ5IDkxMSA3NDA1MyA2ODgNCj4gU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4
ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnDQo+IEhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwg
R2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcg0KPiANCj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gTGludXgtbnZtZSBtYWlsaW5n
IGxpc3QNCj4gTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQ0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QK
TGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
