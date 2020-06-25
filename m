Return-Path: <SRS0=w+e8=AG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F65C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 11:10:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 783A7206FA
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 11:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D3RwvbE/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C7ZKT0Pc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="P6BzWujS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783A7206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eoDM6hFaHKlKXPhTbhDAjIT7rB9SkK/nL83GDBNoOlQ=; b=D3RwvbE/bWFVX1frWKnsCTOLj
	r4j4zzN62ToLOQGrq+80RwCmXR4gg/IgkUf5xiT//5flfanfMLceBs9AIBX3FGkUTsZV3uuV0lWB6
	Ckv1dy8yNECasbAOrMnOYcQ0gp2fb+OhBBxNN43T9h533gxPGUvpC/Xf7AP2Iqi18HGCPywS0x0HP
	noh4UZzztDO+JyfwwfNMCuU3P8w4Itod1IVUBZbtPubTwDzlTMAJkLAVobsYnNIev697l7Q3KOo/5
	Fcl1OyGMgFVoro6ZhGxm3Nn+zumctwjFCFcW3M4xiTFUcIk27ZqucRUXvZ/XMjilUZU28j/oBO2vh
	/VHMCiBmA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joPmB-0007JR-Dr; Thu, 25 Jun 2020 11:10:39 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joPm6-0007IF-IA
 for linux-nvme@lists.infradead.org; Thu, 25 Jun 2020 11:10:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593083434; x=1624619434;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=IJRF9zEkcBNWDVyG/jsP4nVTQuEOO4M3oRETxnchKfE=;
 b=C7ZKT0PcGyXS85myl8g6kgUvO2+BoVcY1mPn6YHGQK6dKHUYAIli8gWS
 SHoiYGPyNu93pjZX6qmzDjYBJvVbHJrAW9myKzDTvnlHNPt7wlgKqljZy
 ghJySn+fSPJ9iwrRfYPvlVUtWcGU8UMFSCzYQ6mWu+3tFJXm7O0hNkB/E
 Z1e2SKTJtnuqyZHsfb/9VOGCrUKeVvyQDkJaSEyiUUgRdkfXZTuc1M+pB
 P3X+gK9fT+vdciYDRwgrwq339wE+2tQFeUeYV79EpuBiYxZdQpsELBkkR
 aM4kuZP39pk1K5xGe96hpDmh+CxjUGTXbO4mPJ6f0PYmZQz+4ML6gWAGe A==;
IronPort-SDR: sL0nCXh94Xxcq4Msp+WHmtnQ7nZ6pcp1ZAN48I0y4MNZxyT4WOZn2YuC06rQwV2ShGqIYVey54
 l28052WjK4mSfqYTXrT354qBTvOkK4XYPoznewkYMQjMA9eSzn8iYmmTyHEeTIfQ8cHNNP3kYZ
 b5g1Al5zkAvIVT83QE54lD+LCK6AatZKFRlDAooE+44Ye0agsoB6I/k2470zJnyDP4Q67FWbvU
 jyJ9oIRSAZp6K8KWLnyfk4uKzWcmGZBvDlmW0RtG2bCp7ZEyNqo2LD12h3sTJv6hrOkhwV08Oc
 1zU=
X-IronPort-AV: E=Sophos;i="5.75,279,1589212800"; d="scan'208";a="250115393"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
 by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2020 19:10:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYCXAhInE4zM4VOoLNL11KWpnCNFsXiDjYvoZfRU5keXvo+lWTMPdvzQvmh/iHhkWaQ+zQP4bDahhLr7P2UHI/SjyhsV/Uf8ivX4u0Df3Vq8Gf64Xcidu1d5EgA5v8kMkcLBKU5QAmaArkav78pLzR4eoZtpjCPmKB3ZgtQrhl/72mQSqHksGSApelnvaeGaBFwTN0uPLHpDcRhRgGdk7K3oXj5GNwkhuoVTn0Tw51B9EbzO+VXIt1FvKXgvF7PyizlXKBun6OoNon76phQs+W0Mj/QfKnJglNA1JnrGP/HPD3rBbOWbFI6ALs3WMR0OgHtGQhQ+ab0hebyC2iDAwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2f4IsGmMJDVq3YPs/Emu7kDfaLSNYRF0Cr3Dxp5q2fg=;
 b=lI1X3nOq4Rx7kv7z35dZFLsRZSwDmtOgqejhmn7QcvjauCrglBj3QREy/utBVy86Vr1/rITydJzABnhHBkQHXZV2yrv/hnQD7iZPyFuJUACuzEA3cpst/I8qCRk65UlYFYEi6a927ZjFHGEKZ9Q850pkviZjZQN2ylhJ2hAPdHWPRvdWNs45RFfWb1WjBEpO411cNmVAmpTpPFf/amyrEaZCwzDIZaAfTqpOZcmhC8e++uzLdTMhtZnQGRhVuaB5zm3MgPAveeOmPmiY1+ZwEl9K8oFBCoAm0VGrqeh+a9f+fWQM57FN27QfLX4QYxzavVGSmRhoHOgUv6WmgfR/6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2f4IsGmMJDVq3YPs/Emu7kDfaLSNYRF0Cr3Dxp5q2fg=;
 b=P6BzWujSg27HWQvpgqbJPfVmY/c/CXJxOX4pp1iBfR+DCrTDmkYrH1nFInHnDwdvBPQA35HpV81iziAwAy8ElmLO6Sa4SW2b0gStFM0ZEhdz3YjGGI5Dv2KMZIrV1Unbt0cV6PW6Jk5io0b3oYhlnHDILtqpp5/hoDIpBK2UNIg=
Received: from BYAPR04MB5112.namprd04.prod.outlook.com (2603:10b6:a03:45::10)
 by BY5PR04MB6294.namprd04.prod.outlook.com (2603:10b6:a03:1e5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Thu, 25 Jun
 2020 11:10:16 +0000
Received: from BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b]) by BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b%6]) with mapi id 15.20.3131.020; Thu, 25 Jun 2020
 11:10:16 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v2 0/2] remove workarounds for gcc bug wrt unnamed fields
 in initializers
Thread-Topic: [PATCH v2 0/2] remove workarounds for gcc bug wrt unnamed fields
 in initializers
Thread-Index: AQHWRatsK9pqpN/HlEmT0NtnEgioaqjpNw0A
Date: Thu, 25 Jun 2020 11:10:15 +0000
Message-ID: <20200625111012.GA418830@localhost.localdomain>
References: <20200618200235.1104587-1-niklas.cassel@wdc.com>
 <20200624164441.GA24816@lst.de>
 <BYAPR04MB49655BD99E428B66EBB831E486950@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB49655BD99E428B66EBB831E486950@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad2e133a-34c1-45d1-7d31-08d818f856cb
x-ms-traffictypediagnostic: BY5PR04MB6294:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB62949BD4A3A25EAEA7C08C4BF2920@BY5PR04MB6294.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0445A82F82
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1gBtn0fFHU+Ga+WYbuMGG8SECPdvIICVcw1B4ymtl/vJK29G1slRtEaQ8CWFCsW0oRM+I9qDXnzBzH55DpTWW+108AFB+zeZ8nWC679ELtXHk000yabYhqnXh+eKApdlvF+F25FpZUXUeIeoDVZVQgbY32DujZaGtSe3cca0UCT3EOsaPYs8ZozF35ydU1DCkMt24NO6tYMB8FDTyAK3k+UyhgMH9pInzJhzlNzi3svXkgd9i/4djq5jLrU48Qh7GogJXdLk+Z7/uoE4NoXlzsaDAtJFTOeoQ9MHlBZPm0+ZIrDgsPP/zkeL4w+Dzoz8DZVo/zD8YS6qbi6IK8cG3IHEV2l9uqI4MdvlHij8wqCsMD5MKWyUJK/FZSyGlXYwOUX/jXhip/0HZA/WiYCnCQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB5112.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(6636002)(66556008)(5660300002)(54906003)(316002)(33656002)(6486002)(4326008)(478600001)(966005)(64756008)(66446008)(6512007)(66946007)(4744005)(86362001)(66476007)(2906002)(76116006)(71200400001)(9686003)(6862004)(26005)(6506007)(186003)(53546011)(8676002)(8936002)(1076003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 3D+Sz1EZWejzcrMRXSr0wG8p9XCzgI17nfCOsgo2yCJfz6bxgMAIa7ms5O0+jMetg6GZTUKToChyFN5UeOj5uyBMup4PX/H2P6oXJpUYtonpHINqgaz1ui7+U0eZi2EqTLiUgBpqaHR1e65h8Q6IUdgAuTUf7ez7dSKBS1uyqNU+rFnnhtoFIHRQBSDyGfYt+S0SJD1rjknZprqiA0303M8IE6BKa+Riez/+T/6JbDx06B+ZtGd0otK3tGmzaZ3d1HnVb5+aW5pkK9n4VnF8Rv2LrlAj3KmZnFU+Z1s3mg1Lpsg4f9JMJ2LAyPShB6u3SWbTsObI/9sKeDlq3Q+Jkm3uCIjySKVfsqRgCymjX7F6MvYdAXMGqeNLlcRbSU+3Z8vYc7meblgb5lYo/cUCg/aSDUJOwfHfAPVDjBvFdnJOdHc5Bs0zwoqebO1J7IPpiURd8at43KwS4QfXMrPOK7r8vlNui9ISX2IWVIeSFeUqoAnln1HXrbX0IKuz1h/o
Content-ID: <BE0752A3B563674095CC7361BDAE4655@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB5112.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2e133a-34c1-45d1-7d31-08d818f856cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2020 11:10:15.8288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GhwvoCJxv5Gv3Ib2DX8LvuFqwQ/SWXAY768x2IseIxRiXUdWzYqS24+kYkImSwXfAzF81lM2zMpPINCJ61U3GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6294
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jun 24, 2020 at 10:40:21PM +0000, Chaitanya Kulkarni wrote:
> Christoph, Sagi and Keith,
> 
> On 6/24/20 9:44 AM, Christoph Hellwig wrote:
> > This looks good to me, but I'd rather wait a few releases to
> > avoid too mush backporting pain.
> > 
> 
> Here is a summary, for longer explanation please have a look at the
> end [1] :-
> 
> Pros:
> 1. Code looks uniform and follows strict policy.
> 
> Cons:
> 1. Adds a tab + more char [1] which can lead to line breaks and that can
>     be avoided without following declare-init pattern, less bugs and
>     no pressure to fit the initializer in ~72 char given that we do have
>     some long names and who knows what is in the future.

[BEGIN being silly.. sorry guys, I couldn't resist.. :)]

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/scripts/checkpatch.pl?id=bdc48fa11e46f867ea4d75fa59ee87a7f48be144

Isn't 100 the new 80? ;)

[END being silly]
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
