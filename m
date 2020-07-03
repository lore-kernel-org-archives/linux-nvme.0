Return-Path: <SRS0=BHMv=AO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EA4C433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2020 09:24:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 423C52073E
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2020 09:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PIptAtkv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="q50o0o3m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="taKPPMfG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423C52073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UMYGOKHGPtmUx2a1IBKhkRr48YkaEz2pNoDVF+YZy2s=; b=PIptAtkvwfZYqJx4gj2UIbZ3L
	INv256chZgWqcfOVO91/UUCgLmn1xwLlZX1HMAdBZRKeX4x1lS892uVfNmemE+ghe1EujeK+H/Iu7
	Qy/+A4HlTcxgxY15FTQ4/F3f1AMK3UUmQDwDB+xK/0JeTzzoVbPmwc0Hog7PL1GBytmFBi7gu2hdG
	OL8hauxL/laF9cOMfJG3QIj6HVtByaywOXCmIudztbe6zX3KGorBoa3jdMiZ+/MB57HIaiQ7+6w9n
	C/WhVwvboCm1hMvoiAf8PhCuzXtgmFXE6wCaaD72K+eLcLLITKMm9hKWpcusdgCme64i0AU+xYo9U
	TkBzxfWsA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrHvT-0007BC-Gw; Fri, 03 Jul 2020 09:24:07 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jrHvQ-00079u-Fs
 for linux-nvme@lists.infradead.org; Fri, 03 Jul 2020 09:24:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593768244; x=1625304244;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=5RRDDc553eO+hW1ui0XqMbC2EZuqrcJelHLE3D27X6c=;
 b=q50o0o3m1B8WYAznZxfh4++h3IMkz/tW96/IeWhN33wkeH5AUOOR4SBg
 /I5so3Td+q80kkAM4fztscd1E/HgWGYR+Q5o8OzNTo2ZI7T4Bfiswlxs8
 FKIEWMLtcqByLKPzVZXQ6lNYfOtqix7OPpLFJJT9mVkb0bwYPziXJm1kC
 2DC9kFLOjRbZIDSa/cEkQE5nj82Vy+618iMAPWyR4458uatWaih7PRpa9
 7L4N0laSn7Fc+UntRkGvICoiMle55h93R4oR51ECCa5dALT8QcF5Kuv2E
 5wkxumVZ2+ccPLRzS1kA2lXY4O6WGf4S2yhDVquAC3d4BiBP6h2Dim0mq A==;
IronPort-SDR: tjQnKMQ8wdEWGrFN/sgqWcTqi8xnS/yevtDBUBT8CyrWk/Q0kqJ2Te4+dBB+mvD+0pu/kk9zGL
 m2LvYk5WfH933cpo4f2sWg+IL0bH7pPK2hNWfF8cKTuxPpcXNPvkOhedrsRo7LKiKx1yg1H0nv
 CaYm/9r5IfL35ji0IhASmKPiLt+P9ThKFotfTuYVu6lsqvlcjXhXDc98L3aRHqHIayGqJc2c06
 ckHOb1UYD13HID3U9dZlW/ybR5yr6fxPWsNreE69w1VaBkky6CPQaH9owYbPcuZfP+YIvavN8j
 dgw=
X-IronPort-AV: E=Sophos;i="5.75,307,1589212800"; d="scan'208";a="142911590"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 17:23:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnmTh6QpEkOAbsDVT+Rdv8cK25fEABGAqPuxcUpxLD0PbAviAO87s8fGpw2vsrJ9f1D5u1x+g6jKCFP8E8iE8r6IgqZhm1tPd7Lu7NRwrjS1IJe8KvBuSxnRv2HVWGl7nJd0U4UTgcXpj0zH/ddRRWNhO1ttQQ0MmF8rMJQHyFpv4T2Gzm8w1miKYpyg74zr0fqFc2pFE1U2vFrGUpl0IEvztVw9294EKuifxJCQsCMe41qENH7OYkAUQ/UnBl1Xizblu+QErO43pEbgIY52fsu4cqJh+P6ou6BhMtMf/Tl5hvsV/iO7a/Gv2/WZkPBSPe9kqPw0f66P3s75hziscg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJ1qNHUOhykYDN293J5yXrC80m7swQRsB9T8yIfPCGQ=;
 b=hLWGscA9L1UoKrH3H1ltLbdQHitQ2e0ruFTV+XpJ0TaAUTO8urJVLijJBKl2eMiyw8fIXPnb75AdxXPhFtEl3LZzJjIW7Ai882ArHbjSf8ZnDbH5bpnHDri/jv5ExrO/jZdmW9wQ3UrFuHh4XPJtdWz0uo91VPAqtZFWF211tRmu+cM+bakhwd/OLxNzA3ZhVVjLkIk0i13/teXTsSVGey5bSeJBE4UwRFhisL43dMqPbg1NQXnJXdbQqV7BPO4uDSraP231ggwhtjFjdTtuONmYeOSB2gecrAh/GnX/0mwQl4YmJO71zB+41zTVX7lAXkfrYAeP756qEIKGJakb1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJ1qNHUOhykYDN293J5yXrC80m7swQRsB9T8yIfPCGQ=;
 b=taKPPMfGJ/2bZlpPmbT8gTebPDeFIPa860KnlnpL8GKi8G04IUJO/+XiBMiHIiR6aqvspYWNRtF+Wzq+yiKpGKU47dMViCyra+x02MdubT1NECj8bxllHS+tlOZD3E0DzBkreSHO6dfeH8P0eZwvRFiyVXK9620zWWzSo6NpRG0=
Received: from BYAPR04MB5112.namprd04.prod.outlook.com (2603:10b6:a03:45::10)
 by BYAPR04MB3829.namprd04.prod.outlook.com (2603:10b6:a02:ab::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Fri, 3 Jul
 2020 09:23:56 +0000
Received: from BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b]) by BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b%6]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 09:23:55 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v2 1/2] block: add max_open_zones to blk-sysfs
Thread-Topic: [PATCH v2 1/2] block: add max_open_zones to blk-sysfs
Thread-Index: AQHWUJ1jh+E7Ih03MkW/NOTP37wCxaj1lhuA
Date: Fri, 3 Jul 2020 09:23:55 +0000
Message-ID: <20200703092353.GA33841@localhost.localdomain>
References: <20200702181922.24190-1-niklas.cassel@wdc.com>
 <20200702181922.24190-2-niklas.cassel@wdc.com>
 <SN4PR0401MB359886C77E3711DAF16D9B9F9B6A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
In-Reply-To: <SN4PR0401MB359886C77E3711DAF16D9B9F9B6A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.224.200.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b3e9fd44-0c0f-435b-bf35-08d81f32cf3b
x-ms-traffictypediagnostic: BYAPR04MB3829:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB38291132D01F69977F6C12EFF26A0@BYAPR04MB3829.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bFjqWROSy2D7WmhgxniYnkzie7+UipmD2JdwtMXzdbE8jgX6IbrU1zoGUafCO1UbjFN9t4mUcasnzm1m3wHzjVOvLts7fH01asizl8ib/MLWPDa/X/E/SEYr/4UlPY5eAQ757APu5bMVnjVEyRJG4KnrZ821WStURlcg8pB5rgqy5KiFA2KgBqhBQis/UUQ7vPPtahe/M3htZs0hu1DWsfKbXZZgo6QZ128aHK9fMoa13t8xJoyO3ASx2jBah7tRpP3oErx/vSowNSTKKcGXO3WDxkkeKSRIXA40hhuUe7/xEK+URBTiMoI9U2yA0mRsKYH4eVUOU04CKF6CJKcMkg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB5112.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(54906003)(186003)(316002)(8676002)(71200400001)(2906002)(1076003)(6486002)(478600001)(9686003)(66556008)(66476007)(66946007)(64756008)(66446008)(6512007)(76116006)(33656002)(91956017)(8936002)(5660300002)(4326008)(6506007)(6636002)(26005)(6862004)(53546011)(86362001)(83380400001)(7416002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 32H4xPJ3L2YlZh9qgtgerAfts/5hwAhNUagsJ+aXnY5dielELAh5MoQCKvyEcf9guIPA++3H7XGJESiJpulk1klPoUZ3xaYQDzs21OOtzdRFjDFt95De70nQYDh47Qf1gRVEdqXsEWOx6D672D+Spv8l8j+I8Nvgtk3/CPjBrq5QTl6RZwQ2WhaItGZjy39qDk4u/7G9AvK4ipThAQ6Ax6DwXw7jE47kA08S3M3xAV9DttbQPh0i9micEIZAkkROaoUmFfBOxB13yIvynOCjm2aSj0S+Fir5AugBM6ghfagYZOUB9Vfj//FDFrWG2kmvoqYVAbFMpwuCrO6HknJWtj5essLkQbDXULkZBeWo8FEjAiUX3GGHWF6TrzdfegdI/5NTR79yXliJOkGtY8TYK+9Azme9Ke4q4KSrioUCsm+NczQYxnNLplXgTTzMkWXfwYNj4TFl9x9Atr+BJ/Ikas+A7+c8j7FSYHqx53yQzG4D1vhpWUljVb1SIs1wu0dz
Content-ID: <39B52203871A9645AF607E0FAD048CBA@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB5112.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e9fd44-0c0f-435b-bf35-08d81f32cf3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 09:23:55.6941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 82BdjeNZOMJXtUTaeev0lDrmyaREjwsr5Cd324KrWLuVMPIx+BVKzUJeDeXamL3oe5mpMXDOs7QM9fpD2I1bxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3829
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200703_052404_705538_DA24EC30 
X-CRM114-Status: GOOD (  22.50  )
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
Cc: Jens Axboe <axboe@kernel.dk>,
 =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
 Sagi Grimberg <sagi@grimberg.me>, "Martin K.
 Petersen" <martin.petersen@oracle.com>, Jonathan Corbet <corbet@lwn.net>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jul 03, 2020 at 08:22:45AM +0000, Johannes Thumshirn wrote:
> On 02/07/2020 20:20, Niklas Cassel wrote:
> > Documentation/block/queue-sysfs.rst |  7 +++++++
> >  block/blk-sysfs.c                   | 15 +++++++++++++++
> >  drivers/nvme/host/zns.c             |  1 +
> >  drivers/scsi/sd_zbc.c               |  4 ++++
> >  include/linux/blkdev.h              | 16 ++++++++++++++++
> >  5 files changed, 43 insertions(+)
> 
> Sorry I haven't noticed before, but you forgot null_blk.

Hello Johannes,

Actually, I haven't forgotten about null_blk :)

The problem with null_blk is that, compared to these simple patches that
simply exposes the Max Open Zones/Max Active Zones, null_blk additionally
has to keep track of all the zone accounting, and give an error if any
of these limits are exceeded.

null_blk right now follows neither the ZBC nor the ZNS specification
(even though it is almost compliant with ZBC). However, since null_blk
is really great to test with, we want it to support Max Active Zones,
even if that concept does not exist in the ZBC standard.

To add to the problem, open() does not work exactly the same in ZBC and
ZNS. In ZBC, the device always tries to close an implicit zone to make
room for an explicit zone. In ZNS, a controller that doesn't do this is
fully compliant with the spec.

So now for null_blk, you have things like zones being implicit closed when
a new zone is opened. And now we will have an additional limit (Max Active
Zones), that we need to consider before we can even try to close a zone.


I've spent a couple of days trying to implement this already, and I think
that I have a way forward. However, considering that vacations are coming
up, and that I have a bunch of other stuff that I need to do before then,
I'm not 100% sure that I will be able to finish it in time for the coming
merge window.

Therefore, I was hoping that we could merge this series as is, and I will
send out the null_blk changes when they are ready, which might or might
not make it for this merge window.

In the meantime, MAR/MOR properties for null_blk will be exposed as 0,
which means "no limit". (Which is the case when a zoned block device driver
doesn't do an explicit call to blk_queue_max_{open,active}_zones()).


Kind regards,
Niklas
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
