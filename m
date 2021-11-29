Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1754DC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Nov 2021 12:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kc3SisfhTJdNrVZ7L3DS7L7uNUMCIdU299/2pJIwxeM=; b=3M4pnmRdv/49QZATCdlWGK4T2S
	zqGu2Cc0qcE9ymKfzGTtzB0RTE/ZYDkT7HKAtIbFP+2er+LkZfNL9zmPGXIeNSyIN0aSiSJjdxWkh
	SdpzwvuYC41F+oCBqTVDzasyo3qtWzhJDI2hKh5YUjF9lj6sCkRRBsfJ3EbqaS07dEQn3XdZdB+5m
	enVgvayr++XhNHNAm0HA28psEeTr+Q2byacMfk3Ivg15oplWaZ0Cs/1fziLsVJAknHgaQZstCP4An
	P+fyav82R2GC+9Yv8oUyQ7+KUJTOaX0Hoo2l8uJQpLrbnqvzHqg77xYVMv92kUdzf+Vwv2sCwuXCs
	gt54o2Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mrfwp-000ijF-11; Mon, 29 Nov 2021 12:39:55 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrfwi-000iiX-61
 for linux-nvme@lists.infradead.org; Mon, 29 Nov 2021 12:39:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1638189586; x=1669725586;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=iOHsLVKiX3ZNiA3g428CTXP0Qyvab1dLhWQmPbjMONg=;
 b=maxuVjcWOCd2UX6uvyPp5lvfNCts9hHSr6tuLNXrw7pPOIZULTma8poM
 Y5U2ONsYSRLy1kfHOXZlw+F6oRsk/t6vy9RG32kMDlfq1l2adY3S3pcDr
 CEk2KGypYnHNQxJ2qBKKF9Gz9tsh8iiataZ1kxXeDxykysHrumtuKuWu/
 Zitx0vfNcyjVmi5jskYzT/RuYSjmJ7xPgHs7+wKnxQ1IjX5i89MaTBkSN
 ejYXZctaqPWvFo2GaCrZC2TnuLlZ8jXIjtTpqEAO7O7bk0CIy2RMoMs6O
 DO/T0kIo9KH6TA6InbODa2+Q9dkiozWUHHnoQvK0NY/pmYle6IEp0N4D5 w==;
X-IronPort-AV: E=Sophos;i="5.87,273,1631548800"; d="scan'208";a="191743569"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
 by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2021 20:39:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5ECRSR5TCRg5aHTxW8WeZNzqOvpEuXTY5XNUDBNpWeuzhelHrImfhXPiFp84suayPFKNNDZ2TujHYQ0ZhjLJuKBnL31YQD8sVVhoL/n61fo76zFJvc+mcxSe2XKd3GqlsWJRjvPP8calS8Y6Kad23tpRUdE3zahOBtvdYOK1tH/k8fpVDTyki9OWGCm5wThp6Ce/j2Pl0tkyto6aZhBIJlyxFKCxnt0dThV+p9/p06eZcFv/sZh17f4Ck9Fxj/GIjfGDs1Xw124+HV7Q5R4xkqrTpGo3ab8+YQHID5dJyV47bte26jmJB1OhlzeJeG/31aE5kkBT4CLRKBEW7wGuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kc3SisfhTJdNrVZ7L3DS7L7uNUMCIdU299/2pJIwxeM=;
 b=Sk9k6B/mXP1Icy7LBZG1LNklhkObrLoYWyUph/XxU2hz8YeQC1/UXosku5ZFuW+lYAFGb9kBS3lfx3m0uCHwRmYlPJEbWz3hL7RjCJ2J04+jum+2FtANWJKo/HbmW3hr1k579FHql7AQI7xP59NcM2Ptw3ar+17CgpxSb/vTer0B0S0ZPOnwoZRYSwqXLv0m/vmbZzetdhJ7uIz9UWn16hCBp+DOU5ZhFE23i6rqt+JYuT9S0FXkKrSeOtcFyl8bt+74t6GRKSLuGt2Zgm0GM0ZZnCvQkotK9r8HswuEw5aCZaz8NtZSvCIkCZVSg0HumcnrzhLLcWQvP8DN0yTuzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kc3SisfhTJdNrVZ7L3DS7L7uNUMCIdU299/2pJIwxeM=;
 b=hPI39OCh6UPeakWEoB+9TI7IQ+2ebNVGVi2ZOT6MSh3Kk0+Ab//y0GP+rb5ukA+51qY9UKtjt7XUn4URUqAEUY2XBYEM1ce3rrOfX7LdIMXaO5RPZPWsxPhjka5pkobYYEgayF2qOxgh3G6R4n3BP35oJqGB4xVzYeYJSx4T/f4=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7191.namprd04.prod.outlook.com (2603:10b6:510:1c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Mon, 29 Nov
 2021 12:39:42 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::c504:3d44:5aef:f3ca]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::c504:3d44:5aef:f3ca%4]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 12:39:42 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] nvme: report write pointer for a full zone as zone
 start + zone len
Thread-Topic: [PATCH v2] nvme: report write pointer for a full zone as zone
 start + zone len
Thread-Index: AQHX4rJY3tsBd4Y+70+8pYI5zoHXOKwWkS0AgAPPEwCAABa2gA==
Date: Mon, 29 Nov 2021 12:39:42 +0000
Message-ID: <YaTKDVDyfssnD4l0@x1-carbon>
References: <20211126104157.227400-1-Niklas.Cassel@wdc.com>
 <ef1c39ab-7b56-6a37-0f4f-1ca111d5b48b@opensource.wdc.com>
 <d612503e-6856-cc3f-40ed-4c487af7feb1@opensource.wdc.com>
In-Reply-To: <d612503e-6856-cc3f-40ed-4c487af7feb1@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 536c89f4-77cb-4560-3e67-08d9b335514c
x-ms-traffictypediagnostic: PH0PR04MB7191:
x-microsoft-antispam-prvs: <PH0PR04MB719113CB7E2E8C12866220F7F2669@PH0PR04MB7191.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uk2ee+PvZBQ2OYLZd/ORAexPl++iM+gyra/lbGNjPiRhMNa4mOxFI0j3YYDX39XUvffrJtcegIxse1DJtB4ZlEp1xV6QsagXCAE0mXB2cYVgRT4OCIZVvpqsgcJvAVBuFcwjC/2k2TTVBMnKLu8kXP0UoZDW7+IRN8Fuse2BUVtG8RUnyKr8CM3VL7Msz4L3mZw8NM0x4AktHLEvhEJoZc4weEdPCbVpZNAamlH6AB6S26+EnGSEZWzOg8fVVCxotCwyW51iftm1Guk2YipaRWNkasGP1yleFBFpa1PZlgqPWN1MDSNHd1V5xVAqVxHJhY+cAFFE36NVWl7EeT+jQ3MvQhH2Y0rzuCd+dfT+uJ0pPkeNkBMhJJm+c3LrqiM34M4G/4bCds+eWMkXgL7Pvgbm70ivoqBLmk17Wgsyy6EHz80IftvqhRkrCCDBmKCQ3lj654sunykRsUeh8f4V17z7dCFMKC1BvD9zmJ1tkWILnBah/lOjWCs4cKZQZvw8QrAukSuseS+7vtrhcdcSdQ0X6BIX1OBD42Bjjhflmc/wMCgm9MQXMXLk+bvyXAIzqBWZrKiPfuGC51hzqdJ5UZvlE1H2qKkNg2vBHot2NRFzjTK9oXXh5w/cwg8UL7WO431QsBQlGFRpa+Jvr2n9OYd2CtcIFy8T1PzMYhiEwRxuKnr8eGLPwCTIIYPvKofQMV3/5EcNZTudtjvpw/l8PQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB7158.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(7916004)(366004)(8676002)(5660300002)(33716001)(2906002)(316002)(54906003)(186003)(38070700005)(38100700002)(26005)(8936002)(82960400001)(6486002)(122000001)(9686003)(508600001)(6512007)(71200400001)(4326008)(6506007)(53546011)(66556008)(66446008)(83380400001)(86362001)(66946007)(66476007)(76116006)(91956017)(64756008)(6862004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w6oGLukSfxop34auw6Gzi4gNZhLn7Q20Xf07P+n6CByo9HTwk4d6B6mz9QlE?=
 =?us-ascii?Q?9m9aaeANePxjlVgauj9OOuNndkY2mlli8sJsqVabXMVcrdu3xbcyLz8y56Ke?=
 =?us-ascii?Q?LHSZ7C8exiuhoFFOpugIWXcRWnLVRDNCSICAKOOSM1fsyGCNUcPBxxsmLHAS?=
 =?us-ascii?Q?sZj1L/bwv8UViwEH5dZ1izc4P4gffjvIf4ypm40QiBhdq7GQN3PJQhvlQcc/?=
 =?us-ascii?Q?GV9ScV5yMiQfVoR8NqZjqAvHbQqHtdlouoNgLf6GqOfRiBgMpFzFxnBcPlS8?=
 =?us-ascii?Q?JI1pF2ftCkwfvtdPsAK5VLv4/mDtgajUIwlHppEwEeuS0+pJofGx+RqY7zu7?=
 =?us-ascii?Q?8N4NBWVV7xc+yS3GNVw8XRQ36neMiEreSwBRja7YkTITqCxOZNw3KZ2QWye8?=
 =?us-ascii?Q?wN8C+KvwTQ6VdVPFeTPtN0kV2PhZA9vQY5QzQQkhzi6kgeX6uKEST8G9jUR4?=
 =?us-ascii?Q?wvrO5il+9AoxUOrH/nakb8e0Dj/WkOMEhAAjTTiEUczVsoQHBQyekwDN77g5?=
 =?us-ascii?Q?ZlhyReXCktqGHxQLhCopRhtnlJTSU9XfXGq+QAQqwNqx6VYrO1E8lNjz2GrX?=
 =?us-ascii?Q?m5UAUeXyYTQsNuuf1IfFy+MBiw8inUEtIOI994pt91Us2G3rifpD9yIb8XGH?=
 =?us-ascii?Q?Gehk2cc31+CPY9kl3KVZgs3S73hemylYyoQ8H/T/DY9rBm1yBVV+etfTnK/c?=
 =?us-ascii?Q?AbOvwQTYDnrE866aLImQfvLUscRzeSA94UgGm7m2idQ4k8c+ROeQ+ZmgJKQ6?=
 =?us-ascii?Q?5uRsVVL3wmsSG9wyks7Bbdn/MBlnwjCWhdiwhMZfljS03nz4q5p8hnjSZj2K?=
 =?us-ascii?Q?l9dJvEDNL1XNb7I1k6POx+vLRigH43qg5VqDlGQam50UaG22m0wOS1FvdBpE?=
 =?us-ascii?Q?JShEV/ZzcnRLNFsF9gj21OS+6MAqQX3fBpLmVz1gSZqjNFefDoOCXBZho46L?=
 =?us-ascii?Q?0Qq3lB6DzmCiVjWcQH2paAcoo7RvFD4ldMQCJEW2fIU/GOPLqTQ3+97AceeK?=
 =?us-ascii?Q?2w5j0XS/zL50oK00uTI+4Rk6obx+NjVUgFMKNtwF3ivUVK73yFSgGFA279Wl?=
 =?us-ascii?Q?7+BS+wZ6vDvuWvjxRoHsmarC4IIyuqNB8dbJ2YHPueKc/YNSritNAx8pgfr7?=
 =?us-ascii?Q?Hzmo57sxBUlx076Z4Dpyh/cVrAQu0dBPltzqE10juN5VSBWSNgYh3ENP23uw?=
 =?us-ascii?Q?N5XiJfsERUDyrPgOo/vNhtka1xj0q6N8Uun01RxeLHMCKw3NwWu99RlgMY48?=
 =?us-ascii?Q?wyV17s9zh67dMhcyXyjcluMdu1fljOoQcEWRN4CRRDFow+U5JnuoxI6YvJ1O?=
 =?us-ascii?Q?A/65fewxMegPWtP/F8ylroZ3NTJS6W0eax4BuyYs9irXJSCYT+8wItpi7/UW?=
 =?us-ascii?Q?RoFVxyLqt/fNQZhsB49vjfo2jb4HwifuxIZq2NY9G95EsezT0uLBsOG2s9PU?=
 =?us-ascii?Q?LLFXfBGY95FHiAFq+WIW8/lCALjTNrhqRmYoLyfUjX9Bdxbs+6tpTRYI8iqz?=
 =?us-ascii?Q?hgBfvdszdmR2HzWqaDb2w2lqOvxuea7zazX5fBMUIaf31FDz0hPYLJ/oX0k8?=
 =?us-ascii?Q?RPA08FB60Ktq2KuFk6hIZETJ7wKqQfwUGWMBn2pyzdSJR2uRb9RzluzXTnAk?=
 =?us-ascii?Q?vtAOqGt3PGDN881fa4zZ6zg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A1CDEC1FDB207A48807772DA639C0608@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 536c89f4-77cb-4560-3e67-08d9b335514c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 12:39:42.5975 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: okHvn+A0BDLltpkT8hlngcPlEuoxYPEF7mREHrv6ifrmJo+TE+cLP9lpxWN6p0/huLyFy3pRecdIUqQ18WZ7yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7191
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211129_043948_336077_998B652A 
X-CRM114-Status: GOOD (  33.70  )
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

On Mon, Nov 29, 2021 at 08:18:24PM +0900, Damien Le Moal wrote:
> On 2021/11/27 10:14, Damien Le Moal wrote:
> > On 2021/11/26 19:42, Niklas Cassel wrote:
> >> From: Niklas Cassel <niklas.cassel@wdc.com>
> >>
> >> The write pointer in NVMe ZNS is invalid for a zone in zone state full=
.
> >> The same also holds true for ZAC/ZBC.
> >>
> >> The current behavior for NVMe is to simply propagate the wp reported b=
y
> >> the drive, even for full zones. Since the wp is invalid for a full zon=
e,
> >> the wp reported by the drive may be any value.
> >>
> >> The way that the sd_zbc driver handles a full zone is to always report
> >> the wp as zone start + zone len, regardless of what the drive reported=
.
> >> null_blk also follows this convention.
> >>
> >> Do the same for NVMe, so that a BLKREPORTZONE ioctl reports the write
> >> pointer for a full zone in a consistent way, regardless of the interfa=
ce
> >> of the underlying zoned block device.
> >>
> >> blkzone report before patch:
> >> start: 0x000040000, len 0x040000, cap 0x03e000, wptr 0xfffffffffffbfff=
8
> >> reset:0 non-seq:0, zcond:14(fu) [type: 2(SEQ_WRITE_REQUIRED)]
> >>
> >> blkzone report after patch:
> >> start: 0x000040000, len 0x040000, cap 0x03e000, wptr 0x040000 reset:0
> >> non-seq:0, zcond:14(fu) [type: 2(SEQ_WRITE_REQUIRED)]
> >>
> >> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> >> ---
> >> Changes since v1:
> >> - Minor commit message rewording.
> >> - Use if/else instead of setting wp unconditionally and then
> >>   conditionally updating it.
> >>
> >>  drivers/nvme/host/zns.c | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> >> index bfc259e0d7b8..9f81beb4df4e 100644
> >> --- a/drivers/nvme/host/zns.c
> >> +++ b/drivers/nvme/host/zns.c
> >> @@ -166,7 +166,10 @@ static int nvme_zone_parse_entry(struct nvme_ns *=
ns,
> >>  	zone.len =3D ns->zsze;
> >>  	zone.capacity =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->zcap));
> >>  	zone.start =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->zslba));
> >> -	zone.wp =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
> >> +	if (zone.cond =3D=3D BLK_ZONE_COND_FULL)
> >> +		zone.wp =3D zone.start + zone.len;
> >> +	else
> >> +		zone.wp =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
> >> =20
> >>  	return cb(&zone, idx, data);
> >>  }
> >>
> >=20
> > Looks good.
> >=20
> > Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> >=20
> > Note: read-only zones also have an undefined wp. So I wonder if we shou=
ld not
> > set the wp similarly to full zones, to match the fact that we cannot wr=
ite to
> > these zones. Same for offline zones, but these are tricky since they ca=
nnot be
> > read either, meaning that wp should be set to the zone start for that c=
ase...
>=20
> Thinking about this some more, I think we should do nothing. Reaction to =
RO or
> offline zones will always come from an IO error path, in which case, it s=
hould
> be clear to the user that the zone wp is invalid/undefined. E.g. zonefs h=
as such
> IO error path.

Christoph, Keith,

Since there are no longer any outstanding questions on this patch,
please (re)consider this patch for inclusion.


Kind regards,
Niklas=

