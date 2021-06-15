Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528AFC48BE5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 23:00:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D814610A2
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 23:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D814610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kcu4Oqfwa0SLTYik0u78ouX75UKserNueLggA6KZs40=; b=kqbrtn22oKfsJZ
	ch0uRSDx5W+sF4LtK+20J/2kI4cz4W+lbc1xxbPaR0q5Bg65ludqOyP+CNa/K6lBhyU9tmlvJlQE3
	3am8TYzvUc3+AFTQRH5RI4M2dr2xmhE3FuBiQb0fwrbBV9kYKDkDXiaG5aiRD8vWJ3l58DY65eJlg
	lake8TdWwSgIiDR1i+4WCJNvX1lrBfs69SQMJ882LZm7oP0ZEZ27S8yUUP5izSSIInRftC46cQIE5
	pgAKqYFE+yyRFBEwxjg7i7RQ1vjboHfNAn3nw9K+7xoWSwBKg7vPSsqd8bzpZMZPUFwynWvI+x+Ok
	m7ySi7h1e6bdAstM23dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltI2U-003jwN-Il; Tue, 15 Jun 2021 23:00:10 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltGoi-003GHx-4Q
 for linux-nvme@lists.infradead.org; Tue, 15 Jun 2021 21:41:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623793311; x=1655329311;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4gHOkpXURqhlPRERi8412yGZU0bZhB/VOyt4CVi1HKo=;
 b=L7frWKeLth2TkUtOe+g8q/JUjy0ZkFe0PrO4DFhNlzGcX4hGq6iJQ41m
 ZiaEGyivew0gkgxRunFUNoOz6WDIljrlmQXHUdfyk87DSA6FPm26KOZgF
 jSoa0XrD2YzZfktZNNn4T4sOepXnDomXHDfR4ZQF1aJoaTAO6cGr4aa1h
 nOaTsxC8h9RdZB7puZeP8IFprHylM5Ztf52LtB4uDJ6L7sU7QWTSgoU5m
 hWJ9YE0YSjfEsTYdTDqTwV5M27J+Q4giqN3G7ijV7iwxmwPl0q4CCZXlZ
 WJNN7qt5vSMaF9Toop7CW97YzDe2DIrGEJAa/eIbNRFEXuHGOleYDibzc g==;
IronPort-SDR: xOzVDWHNnqOdvB4862ly3ICTaHH6KZRhDi61q3kWQPe2gGWF5V8VJBnB+f31v6rbC6KLzjMUjw
 0bATRGZPVE+i8ceSF43JKbv/9oP/Wgcx3AuUj6dWOv49Ij8lv8DfhzufRfhHbyj++JBjtc9DDN
 MkW9Wam4SKO7FuhOLS/6Jc6FrvkMblgy8qct+X7I7gq9YKsyR/KjVgK86UsglCFUczsLo2XJtl
 zbx0wTKyE2G+JcN42o6xZjdG61bkwR5asF75BD7gux8NPvR08T5VU4ndXeqGqiFvA7TK3Lpl5y
 go4=
X-IronPort-AV: E=Sophos;i="5.83,276,1616428800"; d="scan'208";a="172020400"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
 by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2021 05:41:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXvVIhpr9B8CTrM8DAWFCcUuTBMrnC2GTZr64SlyqLlfV14kk1Hhhk1RJ3Mb4Qq7YaqfHXyCAF1Hm8liobaySioegbPrSMeRje2gO3InjoO11inSkViqIf5UvP0N5AsYUzTlqwZBznHRrilT3I5FFveKvmWXqXaHVweozusCfxLmKWHXWxjABq+dCu99oVrsdNpgo7y/HC/L9glBCyU7QYsqB6NV++JuBgM4jxatuIdumh9u+7Fv9L4O4PBt1ecDqJTlu1JEhGUjpdyj9lvNIcXkJ214aYGJd0BUxmD9FslFZv6IGK6shinanv6YMdj/2r/6PiWaX5dfqdtD7lOnCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NQGG5JRNJEWGXvYxH2yGhSMcjbB2JQnCqCmq+RBEno=;
 b=h2pLyJdMvVekQM76m38wocgMNZjRR02lp8KMTyBTzmtGXYSOuQqrt4sfuZGAfAgwc3cAhxOgknfMwhas9ve7mPolkHD5qoneG/OsoVqh+IvWFZBrZzdPiZG++x5b2aerfyaxfMYgdRyFaDGPSkKOVZjOsyc8TKVXkZzjgI0+4TjGQrK4n7kw82Vd8Dt0tTQC4q5tvKO1OXrF4r9hci49nW5xdtqyJduxvcFl2vcTMSiQku/eSfrt0zdH7kqptlu5rkDTi4ho5OTfmE9iMfuo2rm57LCTv3PKgvPbJtVZj4tyczML7oGnEnLirdrqAfx+tuPaDU5X/1NLPWaEnRaXbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NQGG5JRNJEWGXvYxH2yGhSMcjbB2JQnCqCmq+RBEno=;
 b=vyPPigopflUDPvJlmQQ6VTEEgucupyy/tTqDfMdZXUT8IWNZrXuU1ZTAy/BwfI2Ik/G0C4RwymYug8YxI9OMAaNNiEDioLYA//Y2N64NLzL00QqACydkhqblioa0veJ/+s/W4aMCsicOOeEyXpt/d6tI9t7cVwxuvDcmJjtDMGc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7550.namprd04.prod.outlook.com (2603:10b6:a03:327::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 21:41:48 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 21:41:48 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: kernel test robot <lkp@intel.com>
CC: "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
 "clang-built-linux@googlegroups.com" <clang-built-linux@googlegroups.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph
 Hellwig <hch@lst.de>, Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [linux-nvme:nvme-5.14 32/32] drivers/nvme/target/zns.c:257:6:
 warning: no previous prototype for function 'nvmet_bdev_zone_zmgmt_recv_work'
Thread-Topic: [linux-nvme:nvme-5.14 32/32] drivers/nvme/target/zns.c:257:6:
 warning: no previous prototype for function 'nvmet_bdev_zone_zmgmt_recv_work'
Thread-Index: AQHXYi7/YxXu7Hmy5k6zW4wZts/tSasVmh6S
Date: Tue, 15 Jun 2021 21:41:48 +0000
Message-ID: <472070C8-85CE-4C02-A96C-4D163A7D9296@wdc.com>
References: <202106160534.PvpGDOHM-lkp@intel.com>
In-Reply-To: <202106160534.PvpGDOHM-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2607:fb90:849e:cc43:e84c:2e80:f77:c13b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50cabb1a-f6f5-414b-3214-08d930466105
x-ms-traffictypediagnostic: SJ0PR04MB7550:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB7550F9347216EA978D4CA33A86309@SJ0PR04MB7550.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ULvImVs+lIhX2Au3VqHVEz3J4vh+xxyAYH4dnNT+p1n3DYcn9b+qRie3PxV/W2YttX6dUgQkNt5u1pgQVQt30SqPz7mESzwQd0pAjoNwdXJtuafaRUxguxzbRVmx9ilKY3EIIFEMNT1TPYPksW1eqdD+5ExXMLlUOTBzz06/04oo2atPQVDmHNiNZLiCdJiP5CNAqyacVSvDtHra/O5NkMRHxkA9h+R1kbOwhZBy0/yyFI/vpT1o94vtDQQM/uXg6SWCeupSD90OD+O6x8TMtx7XzIheZIpo+lNn+4gmQ+C4sKpsidKI7V76wiUp8GTwjWUeNL8t35tHqsS+lYQBjn8GI+WQYsaqrHiMblrvINhNkVX+pVhB6eM27E9pXkN+oFO1+wpgUpWvFZ4RvaCaY1QsY9CvfvKn/dvysreOfbK4bi9RBUmlF2wQ1Ydl1+IEWY97QLpckmaEk60BHaoRbP7ztFUer3GZHJz73/YAbRIoIU1xL9qEbKU1i67foT9Aj4oQy3oLppnqGhVfDW2C3FVUJ+WKySzXt+FYxSJGvLTQONc2gw2B4U7ERoOKJ3pUbAN2jlqMJrCAT4umb3LADXt3g0I1zjpLsR//DbhvhhIPXDGTx3HGeMnMfbd9wRJTukgljMxFD5PECM8Pp22KA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(6506007)(6512007)(478600001)(53546011)(2906002)(6916009)(2616005)(38100700002)(54906003)(83380400001)(8676002)(122000001)(71200400001)(86362001)(36756003)(66946007)(186003)(33656002)(76116006)(4326008)(66446008)(6486002)(64756008)(66476007)(66556008)(8936002)(316002)(4744005)(5660300002)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eZAdG1Ncj0Cd3SmpHWYKo+c+MfZl6VKNErrGAyOIImUp/F+rQf63OQKirOOw?=
 =?us-ascii?Q?ZW7k8qkSRnnZfsmKzfo3BL1bhqhx67hX4mIcqqcvjv98bnSuruzjkuKBcqfO?=
 =?us-ascii?Q?xhWe0TUuMh1wDGg6AR8sKs653shw54XSSKbjbcfVPWAxQKNpslo9aYHmzemK?=
 =?us-ascii?Q?6jqJ+4uLkTRJ3UEFUu38e0+G7j7yQfmS4xks/k/dqoaSNgw5dhYZG+zt8pFG?=
 =?us-ascii?Q?FIi1bW8nwfoujo6cz+Ik/ur7PKrR8nkPhATEMQ1xctcoAjYwlVLRKU7tUqc3?=
 =?us-ascii?Q?xHr1P0WQKvWy0ebNT2RRCyyVNwEp1IOM1/VtVqMGpeLTBwm43qJZDBLcuKop?=
 =?us-ascii?Q?7nbWbSZtQ9PJ/nQrnPHutt0LLyVPDd3uu4z2FqP5atqsHln1dugoFfNiDoJL?=
 =?us-ascii?Q?ccD9sqL187zih3+RjF+5tDg/CqHdsiSSKAfOHtOFPSm4Kv6Brq02neNoAsf8?=
 =?us-ascii?Q?MP2PLw6ZVj8r89j4IpIvzdYFInNr8BDJlyIr4CdHkj8aSZFFcybaLkJh6Fzb?=
 =?us-ascii?Q?AALTXublNP/HbXY0iebecZxP9Fv7nA6ve9DCNGMTF30FwFLMHLGC1pcmodnJ?=
 =?us-ascii?Q?hC0nKRQdK8RZHNUawfLeNMHmmPTCjlv0u7PqVIoFCOaOtA9v9sDqeLE8hARa?=
 =?us-ascii?Q?w3GP/W68KLeaBAeWnvASS90a8lDULP5paFMpOIKNNxn5CE0rjRNgVDTBFRaG?=
 =?us-ascii?Q?cW0+bHjJ03LIzp3fJuo++uw8SzrtHEyH9fDoUL1T3GJvFDhN1v9IiPuF6y4+?=
 =?us-ascii?Q?o4qdEx8oFekPDR2DhptAwwsyIfFCZyxmld4vER6Jl+ocd1ixDfqPju+Pxl4J?=
 =?us-ascii?Q?xnALaHrv0MmodbG+UvzSzcaBgJG8/rARXGdMI6FLp0e12isQ9Plsga7U7F+Q?=
 =?us-ascii?Q?ShvD96BOU1fH/w93812UjL3uWiplanHVsJxBAWH6iQQcfjbrEVJN5h8teQ3k?=
 =?us-ascii?Q?D7FlU+p0VjyOB3IJrerLvcEPw2MNqAtSQRlrC0lWV2ceWU9SaI3Xtnf/RTla?=
 =?us-ascii?Q?jgS2BkPbHL8l9gJPjMMsRMtPEDd8ep43O9gRofzOWpOJ4fJnphL4brpykaYl?=
 =?us-ascii?Q?rLBam63dRT2WsBdBff2ma00afJMBVCDrk9YdNWC9D/26sTahKDOEx8qwpy1H?=
 =?us-ascii?Q?/yzWsPfFjmOVh4lK0n5lOGWviRxZGdN5Vk8kaHv+Kme1ZI3Cp1t0N6xHUx1+?=
 =?us-ascii?Q?qtvN3SSbs9tG6ia/jgErsPc/Tr8At/bnFZLOOTbMOzTufpACY+KMfJOMihue?=
 =?us-ascii?Q?kRnaOU/1yyDcYi6gJKNGP0YCt9LPuywLcqMcXVrnqIR2gIqnyg798IrY1LLZ?=
 =?us-ascii?Q?Bm32uEE4OWM/z8sR1TYa1LYP0xNQkinCjnW0fARovgQBwmvhSs9mUrXgNYc2?=
 =?us-ascii?Q?gr5YsqPlA4PVTTtXDVQ9zOYbMfdd?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cabb1a-f6f5-414b-3214-08d930466105
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 21:41:48.2140 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alJRb7U9tRsA3TzEjbSw6IatNTJRZXSBLk4WXUS1/VVMmq4bJT+vD5Rzk9RH8etxPxMhtr5oApm8yugALR3HCjBVexG4C+ru13zYZSutivI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7550
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210615_144152_323518_8F2242A9 
X-CRM114-Status: GOOD (  10.66  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> On Jun 15, 2021, at 2:40 PM, kernel test robot <lkp@intel.com> wrote:
> 
>  void nvmet_bdev_zone_zmgmt_recv_work(struct work_struct *w)
>        ^
>   drivers/nvme/target/zns.c:257:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>   void nvmet_bdev_zone_zmgmt_recv_work(struct work_struct *w)
>   ^
>   static 
>   1 warning generated.
> 
> 
> vim +/nvmet_bdev_zone_zmgmt_recv_work +257 drivers/nvme/target/zns.c

Yep got it now, will send out the fix soon. 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
