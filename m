Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B360AC63777
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 08:10:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA3420857
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 08:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EdPyNSZK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a9r1EAUl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="l92pb4m8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA3420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=FZJUQ/RZAHDij190gE0+FRWB/KGDijsnDBj+xjNLq14=; b=EdPyNSZKMhekfRigulFzxq3w8
	iOffM113NBW7yuPaOxAQzgMuinCom+fEsvR8/oxtSpAVb3yur492qOA3krAu8QSOch1zyuWqszqSR
	gGpZZbjDjammpIJ4I7Vg9pHTpgujfdeTa7C67+vknuYX8oKYHZBBbSx6Pm2wNAhcxXAZcMvtPig4K
	2a7WqHhFokZliCsyv9P0qgwVXfTdaVjKZJMoN6jMuMNQT+5L4vk/J/CFT84LXYcKa7wxaD/8ieVuv
	/6g0k6iFzdX8Pe9IQ60J/uUxOkrm9seKIvMoaWbNDu2mGeJhHlLhYTtkSSOx0OrXF+E81tjd04qAD
	Msr6OSBxQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kiCLu-00070L-CB; Thu, 26 Nov 2020 08:10:08 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kiCLr-0006zE-8Y
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 08:10:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606378203; x=1637914203;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=twuFuj9G89sdNdlWJPYUhlr5Gdeca3NaMHlbNzpQhnA=;
 b=a9r1EAUlsWqfl0mlo24YObvtPV3Zm7x+Y2Ijz+weeSTBUMXfisT8i4lI
 wyzlcGJXlv3JNKbtIgEdeU6eE6zxv67B/xjwl77v8+zvysuoZSKfW8LPu
 fiIHwkNxVFd6wlZ/4lv1EA0Y7ukiNERgrkfF5BvkP7ZJzpql7iD5Arc6T
 d8j08iNAwnrUkeL5c7jdvnH2FzPO2XzYU85BjGvD1QHeCO4jgPZZHBtiA
 ZdU1lvNdNs3H0CAqjW3b4AetlTmcSr+8Xw9wLfedoWijy0d8/dcvdVYVF
 7ByKPQOxozqOzXPQM+GenVgxzwoUh4QLl9tZooGWeUhokiJ6iiM96R1WA g==;
IronPort-SDR: GCIZtEl1u9EETVwQ3q0EJKKFDsrngOk5Nr0Mk9Tw/mGGV4KsIQQiG3C7onUVwNfD1sq5crtfv2
 289dEnjvePmMI+w2s2P86K1f4qxsdvmmI/RCZRaPmrzLQJoQ6iYYKTRhfaeYkXw1ljLLxx4c9S
 M6mhWMliUoLCXVFqG4ErTjDdTpnU03algfkompRhJ/9zv9C78RyAYwcRd4WEjstQFg9t/u09cs
 iOft6GubmpiQFsLoCb9wPFhN2+Gmd3O8NGffmR7pWUcJhkEfhOHcw7ZijZB0PObTdYhzZq2wxE
 ECs=
X-IronPort-AV: E=Sophos;i="5.78,371,1599494400"; d="scan'208";a="154736583"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
 by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 16:10:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbPE1s+5QwUEQ3WtPDnDsCtiC3teww9VPLx+cPYKW/owLRyCVW7v8j7gZ6fxcYfe4CX1ZY34ZS58PNrEvVUucrlssNwYYFGEujkRA5UHnX+FDCW4Xm2jBvnFSQW5pmEmg7wxYlbMzxq6vQ4B6T28rO4l8ML3Cabw9gdoDrBTzTXclVhvYs6nUNcZ1r4/Pwo1K7lOabqMLiQzKZxlj1DVxAtj2gvH/kNEBPkErDnlZoZbs2aVgbKHItOQXHwnV46AEpV1d1IfmHtqXBqfrwM9nIjcICqZ0DzXHf5UTH74qajw3csT3B5D1MGmaPYdwPj3bjvBsQx0xCwTkEAvhB4cQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKG1/yemXCLOGj8QeCKCetFygTTFU09bx9vM8PONJaM=;
 b=GyvBb0N7DLFHNN5gIpFzIpwoAsn0FJqj9IeuBZolYNd+9ToPWNF/MuPWPCzzUOR9Aab0aX/mgxkhJkmWx6O7xuKdYDpKiDQVh1a16VECrxeA/w1vvYjssx402j64zS9192wjD857de6LQIQEX9es/v8kRf/38JPRkonaoDReU3xqF/RJb2bc7XnxpO9LEzI3rsrn8JqlUsySkZbZwPuBTvNpwv3rXKgNX4vFDnIcE+JTrid+cJZhyOcJyB8RPFxBlwoA2CwdtMWbO78Ef7MjYHHdH6MKtH87UealsAVqWP2zsz0EqDAYAwi6l04i6ol5ZqvtTN5+pN6sVh9vYqB9yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKG1/yemXCLOGj8QeCKCetFygTTFU09bx9vM8PONJaM=;
 b=l92pb4m8Oufm6pZUgMKusW9p+xTifZ/qLRyCu49UAG20+6tW2m+Qxo0hIRkCA97rtc/a2KZ2IINwR5AtRwCEEQllVvqcoTRnDjFBbJwGsaTs6kL9r20VIu5wmgQZt6UfaaqwpjhqwQDLryAVuMN+a3MQi9Ta8ScYiHdGuVcQhdg=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB7014.namprd04.prod.outlook.com (2603:10b6:610:9e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Thu, 26 Nov
 2020 08:10:00 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Thu, 26 Nov 2020
 08:10:00 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/9] block: export __bio_iov_append_get_pages()
Thread-Topic: [PATCH 1/9] block: export __bio_iov_append_get_pages()
Thread-Index: AQHWw53Q1xOHjYPK90G7y+rXNLOYSQ==
Date: Thu, 26 Nov 2020 08:09:59 +0000
Message-ID: <CH2PR04MB6522C85613BBB83DCF37F0ADE7F90@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
 <20201126024043.3392-2-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:7477:1782:371:aeb9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c0ed3a64-efd3-43d5-7f2a-08d891e2aba2
x-ms-traffictypediagnostic: CH2PR04MB7014:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB7014D9ED7404604E93A7547FE7F90@CH2PR04MB7014.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7yBlvKbaw6pXck7sLPqzSIUkxgia5gvO5x/8FqFvXMn3jS7xbdBkqmwMvNsq5sJSdmbND4EaA1fhfa1y9QjVlpvUHoUNRXcrhaX+QsnQkyemjHoZdz8St/xUkvxWxDWwjyExt2kXmThzV3C8Klr0sl8cwq5bd+thHvJCvfuOKQaJUA8CspnxCc/gYOwUCmN5zww32//ki2c05LBWHmYd7TnOuVmvVujTpqwPvBjCtmEEtECVv7wCkDxOJjgU6izN1EJ/b92My6AyThg6ymiMw01DkIWF+TC7Rq7P9z24gtxlVnSAXEIjuqQ9AosuJbnq1wOOuScYaBMgGFdxjmYvOw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR04MB6522.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(54906003)(110136005)(316002)(2906002)(8936002)(33656002)(4326008)(64756008)(52536014)(66476007)(66556008)(66946007)(91956017)(8676002)(6506007)(76116006)(71200400001)(55016002)(66446008)(83380400001)(86362001)(5660300002)(53546011)(186003)(478600001)(9686003)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IHMRQppQVaHrWR9ogtSfOOzAF0uw9/Ip/CqohinbKpJSUs1OVaDcfsvGAtkL?=
 =?us-ascii?Q?YEq1ZrOPHeoRTuc+Qkj0xPi7bNChZGdbgRV751l4wGSR9dkqx0/i8TkTLnCM?=
 =?us-ascii?Q?R6ChBk5ELLLUxWD/NRempQS+sovYi/ETDDmYnT1lW2D8xfYcgzmYCqGFp5ju?=
 =?us-ascii?Q?By8nGoFQBc3xW2HRNuhafsua6IsKDqxl3KxcyIcu4rSrkhEpadJ+dwATWvwY?=
 =?us-ascii?Q?nDGunDqJ1e6PHxUb9nLhCMGmY33xa8siQo0vy3urYo6PbIvitYmUXDcAmEez?=
 =?us-ascii?Q?XPaictZxzYDLrsKYpuqFayCVQzB7wFCOVQR1WdgoBLc2wEOBNNH9ScmzTzg/?=
 =?us-ascii?Q?u/hLrRyyYiWwEP9RS2MyT0cxTvfZLNHsaeNSx9kjAc98XAWiE6rTC8wtr6FA?=
 =?us-ascii?Q?C4Ifu5aMSM6YLiLQcSp1OoLM8IQept+8EE7jkmGwJz0eoNN2KkZUbjEkApLg?=
 =?us-ascii?Q?FyDaZqh2LBchemTL/VV6eIOHSN7JeXPwiNP56jMBQqMjs6CbkvOtQLI9sCBo?=
 =?us-ascii?Q?2NpTfig4QnzJk7m/NANIc2m3oWLK08gmUUG0Usgi4CgKMABgNMeArirJvAmM?=
 =?us-ascii?Q?cF707yMDqq/41tl/UJ/TU/TtJek/k6hP4cBoBE5EF/mx6NaDiRrkb2V/U0Pz?=
 =?us-ascii?Q?bGD3WU5dxczadj70gBbJS6GadAU7sYpiI2U54SyY6ClwieUkiFTxyqUjuHC3?=
 =?us-ascii?Q?Oy9JH10SBxDb7IvDc9dhAC3ZhumURUMa7kWt7V+rnkcEch1J9MWPN3kcmEcg?=
 =?us-ascii?Q?M5cvmyF1eCkrbaN1aiZ410QgWGiE5Ofh8ATKKA4s4egLrWt/YsJl0KWWdKc/?=
 =?us-ascii?Q?VJZXEOPC1d0yBuHfIJhuh4qKwbMYrMm8OR+TycLacTnUhLtMkX9JbVTMw/5M?=
 =?us-ascii?Q?wSy9agVn6Bi0aHBsViapZG29DzDGmrYT3yagR/KAnQT+C05ElXKi9HllFCg+?=
 =?us-ascii?Q?qldn7JquFVKp+h3tIIk1s5lUSnJx3l5UjsoLboCv99XYe4rtk0NuWrRuOCxb?=
 =?us-ascii?Q?i3QPB1ZYy6uNox7ZvnXnLDpfCrt5Lbzx17z/BqfNdYj7uiz/YOVWxvo8e5VX?=
 =?us-ascii?Q?ERPrZJvv?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ed3a64-efd3-43d5-7f2a-08d891e2aba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 08:09:59.9591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJHW6Kgh8EAaPnzE5MSKsrwSjPm2YA6ACjH0PFXuUolbZupuPKpJzSy8xLBSqXtXyMhieernLvhtD1sKUsn9SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7014
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201126_031003_463274_F3343E90 
X-CRM114-Status: GOOD (  21.87  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/11/26 11:42, Chaitanya Kulkarni wrote:
> In this prep patch we exoprt the __bio_iov_append_get_pages() so that
> NVMeOF target can use the core logic of building Zone Append bios for
> REQ_OP_ZONE_APPEND without repeating the code.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  block/bio.c         | 3 ++-
>  include/linux/bio.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index fa01bef35bb1..de356fa28315 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1033,7 +1033,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	return 0;
>  }
>  
> -static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
> +int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
>  {
>  	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
>  	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
> @@ -1079,6 +1079,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
>  	iov_iter_advance(iter, size - left);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(__bio_iov_append_get_pages);

Why not use bio_iov_iter_get_pages() which is already exported ? As long as the
bio op is set to REQ_OP_ZONE_APPEND when bio_iov_iter_get_pages() is called,
__bio_iov_append_get_pages() will be used in that function.

>  
>  /**
>   * bio_iov_iter_get_pages - add user or kernel pages to a bio
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index c6d765382926..47247c1b0b85 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -446,6 +446,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
>  		unsigned int len, unsigned int off, bool *same_page);
>  void __bio_add_page(struct bio *bio, struct page *page,
>  		unsigned int len, unsigned int off);
> +int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter);
>  int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
>  void bio_release_pages(struct bio *bio, bool mark_dirty);
>  extern void bio_set_pages_dirty(struct bio *bio);
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
