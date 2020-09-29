Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ABCC4727C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 21:22:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99C1020757
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 21:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BvvVZ/S4";
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="KeQKluqA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AbgrXBhB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C1020757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=/K9rjfTj1agkucdFcZUUSVG8USjeltGa8AC9/kZKarE=; b=BvvVZ/S4vMihlCUqvXhUSQrz7
	fPmFWd31jA7jtYMTHB4ETS3H6pEcRVbeeAN2MMnG3QcEUC/XQSr6rMbF+Gve3nVzVn+QShF8fonoa
	XmMjy1HiZhRbV0xDqd1Saa/j+VlpLDu+rW6xQ0uXtOYQoR5y7ytrcjRDcp6wvjwn1PhQKBm7cIqWz
	B8kIYfCB0VgybE70PrB1GqibKOsdfvCfGIjjRhz2qnxW/ZF37Y4i7dOiKBuuzAxRznanzzJQnn/nh
	rbEzPHVrTwiUgWrR+mmb0+vAAMtoMSwzAFBFf4+FbNamOgcTxNd+Fhi/xUqqi61TNzerikQ/KayGS
	UD/m2a+xA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNN4h-0002s5-7Z; Tue, 29 Sep 2020 21:22:15 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNN4f-0002rN-0d
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 21:22:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601415674; x=1632951674;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=yMhivdvc/gQzZPEA974FlGqYAi4V/sMYhsZJArwR/sY=;
 b=KeQKluqAiSaI3u9hCBt/mBZa0kIff64BNcinZyQljUyuzHgBokmmgmvk
 7Bv7OFhs3WT2tnbDiMNoyrn1mBihvyDwxlZmxqVKWVml9DYwxnRzpSmQQ
 XOwBSGFo24E/FjyBTNhn+eu1u1KAPwgkJ3aatKxqgiERTWr/rpORRn6qe
 YypDY5Qrdlhj7q0HR0oT1gWRHdZzTuaYFtx6KPegrIJViHCr/02pbzNof
 C4ifFm6qpopeg7E/s1ISJTM7tRxz5HqnjCw10MEMiV1QtG0oE496ws3oC
 ffnqMS8ssy6LBACG+tjSaRqL+084telYml1DDI8p7qCy5wjqriBU4h8Uv g==;
IronPort-SDR: 3N7FN6CbJkIcITWFUC3rcS4uUe85N6UcJzggt4JUOk9ufC62lwG6aYg8ubOQal3K87IBqTQBdr
 aFI0/9khj7AFJW+9/olqfpv+6nkHsKHQuCz/PiwxUjcb+9c7Ymhq3lwPTljToXZLn6pJyxHqr6
 CasCgz64TFZXUJ+LujMUH/r1iWV6EBJhsfoBXaCzMKIFZublJyyJEQvnIPTvM5KWmh+DZM+IYP
 wiyayG8Zd3WADsnP8StWSjuEm2IOK88kKWs79jBGsomjYbO0KBKHe9s9H8GVv+Od7PxTFzJe8d
 sqI=
X-IronPort-AV: E=Sophos;i="5.77,319,1596470400"; d="scan'208";a="252000050"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 05:41:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHIH7C26twv/hhhjZCobVX6KyoKs9F/aNSTETKimr1xOFOutdxcOZVKou1yfOPmzsJHXRIshUlJQsuDjYw7DpuSt1ukLJ60Vokvz+krQ9t4noniwReH3AO6si/5u7ACY0ajefOSAbgQAgchjXj8/Ar4psvsBSq4erTO2Dyqr9szuPo+qSyNVi14dMNWNsGbNLW5S27elzbMS3c0HmuEdGQJ9A1njJtt8CBXFsSvEfUarVHSzWb0KjQTYZKBPYc1BR/XKfh2RfOsVzWSqbZCUwZ1slH8Ubvw2HLxHvJ6WLLNceUFvb8LqA3wWsm0dwssuC7TajBUlEm3hde9R8xvXcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMhivdvc/gQzZPEA974FlGqYAi4V/sMYhsZJArwR/sY=;
 b=nk8znRE7cYSwanupIoxAe4DR03mW8Jr40xp7J7gDGPNNH2pGl0va+V2f+GwSa29V4b8uGN2RXUic6d+Z1cPxY7AEOq8EEVGtw8oGsXHiCZ7Olor09iP1mbxqqvfTvLnm7Y37xFCi/AAmoOH0DjO+n0EV7K2DNME57FlyLwwt1lloeVM+A4tbx3LS4RUZdUJS1jUA3IQgLkK0VWMp9gusuPAcWlxTk728pvhejXjFcPw3hYIldMWng9ZNVJNORVTsKKk1KlDE5MM/XvQqmvDDd/ds2B44UcfPPIOtLCjNj7CAULbpwplt5viQgqduxpuXZoa+hJCqTI6KJJnxaF4rVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMhivdvc/gQzZPEA974FlGqYAi4V/sMYhsZJArwR/sY=;
 b=AbgrXBhBqr71lo7UWzbekU7cwEDAKb0MK1Lqewt19vOz+ZcHyH3OZohZknnyffgu8aqSpHOh1QuxpWjRYO30VjCCf8FwSuKXTLd7SHCrIrF7CV+rePPFnq1hJIgDWXshe4DrvBpNw2vMtOHVmeotqscTdLehH/B5ztkQlxuiLJU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6102.namprd04.prod.outlook.com (2603:10b6:a03:e8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Tue, 29 Sep
 2020 21:22:09 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb%7]) with mapi id 15.20.3412.028; Tue, 29 Sep 2020
 21:22:09 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 07/20] nvme: lift the check for an unallocated namespace
 into nvme_identify_ns
Thread-Topic: [PATCH 07/20] nvme: lift the check for an unallocated namespace
 into nvme_identify_ns
Thread-Index: AQHWlZSoOQDaaYZ2fUyTanr7KBnUaQ==
Date: Tue, 29 Sep 2020 21:22:09 +0000
Message-ID: <BYAPR04MB4965DCB854418A4FBE719B1586320@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c47ad214-cf46-424c-fb2f-08d864bdb967
x-ms-traffictypediagnostic: BYAPR04MB6102:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB6102BE1F847AEECC5F3CEB3486320@BYAPR04MB6102.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IWGT4xT8D5uMPc79D3ZfMyKAgsiup7sRNVp8gsYVO2kyoVXELGm1ehvN1cyDtX6oVIafH9celiQSYif4ElGy2fC7s6P4mrb6CuwGAEDgHVRyXKecFnRkT3+vZhqH8/tW/AiCM/WFfsHGVOKvjhVssJlUcR99fqbvhHxGspZ2HRxY94XrFOWWbMcn3fSBxDZfm4w/lAgayG39gJqZmRUefdJCB8WjS+bomfzcStqA48HgoD9KRojrESUvrz0K6FXPGBvKnvUhRN+M/YDD12bAvHd8yBMidQOOl8MtPFd0eYkT6uQ44F6TDs1hkxldNuHa7k/q3nVy0m6/Vn/MLW5RNPI+6Isr8+73g0CVMjREc+j0SjzBxHatyD3GBHnntqX8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(53546011)(6506007)(186003)(26005)(9686003)(558084003)(33656002)(66946007)(5660300002)(76116006)(2906002)(71200400001)(4326008)(110136005)(478600001)(7696005)(54906003)(316002)(8676002)(55016002)(66556008)(52536014)(8936002)(86362001)(64756008)(66476007)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: iB9TtrEoD3soJ8IML+mgc1S4YBkZv7X/02vZpKYwbiMlgB9CSRqVnTPGQSx4YCrTU3oAMrKHuq4DmIbejHGsR4HnM2i3BrvLZ6RFp9U7D8EheuKo7tonHzzrLQMMDNgVIZc54ecR5dEUQjOuWXL7fu1rLagkTnWpH73NwlG2k37qGPfwWnek/iYNUpUyYK+YZhDN3qf2FRpDezfVhEjwBgoOqK248Ko7jSYuI0wxU+4H+aYSdHv8la8aggHN0edZKsBgOlFxwBOfJEMaJMrihICYyu4T49sVuefuFsL7mDCvPRLyOQQUA+RKHajLKnl/0u7U5KeNSyudo+HQrdqEJEaFbOlLcJDvldkhzVfRgW60d2LIGF11B7jTBWxabk76GeEjb+/kUnCEgCM+ZFKA45ZpKfx8Z/Jn/+1B/vzPcRDB/NmxIx4A6W98c8SEXm4XYOllIdHlfrttjTHpV5HhjfzZ6QhK2tY33+wj1C/hKnJh+Bf8wfycx+KK3bMleHvY/ZY3bpiFsBkzEj85xheTsg2YLmTluqERAgt9jsQ63+4mP8lW9icXo3EPy969gSSBB1TgxL0AOO8dMnYYYNWQsVE0R8e+RmItHcgeJ5iqiL3uf9zpYuKXXajzWYCOlVIGx48ubEZtJtSfAy3pupwTOw==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c47ad214-cf46-424c-fb2f-08d864bdb967
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 21:22:09.2752 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: czA9sMSDQAFwNr07K+nY6p1i0nR3vrayyxuyMEonqAPwaF3/wyWJteZoABhV4ujCKUEEdcBJCNGTNS1tuDWsIdj6QUMdne/DqddqNrRSQdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6102
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_172213_197106_9756B0BE 
X-CRM114-Status: GOOD (  11.01  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/28/20 05:41, Christoph Hellwig wrote:
> Move the check from the two callers into the common helper.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
