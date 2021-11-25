Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724F3C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Nov 2021 16:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KmO85t9IjdT7UK3eaXCTEdRR7ZIJ+0ZWKG3E+y2umq0=; b=tBalcmnWEGY4hStdIm8k/hb2Tf
	FJW/xe2ICsdvA8a1otwZ5Eb1ve+xa3JfQFLW1Gno2f25P0G7+LoltPZOm4E9PO+mm0EMuOFCg4WIY
	iCAKvvvhhqybN0etuJFvIYkDbgE9P2B+XHp5CFsXd2+bz7H26aqhGd3ddrx137H85TRwHiOrgjAP+
	xxWqWXn5gklHiylSAZH/+o80McdPBUwfWDHqn0BNz1Oqa+1GvF2AQpCjIBeLV+We9SHshaQsRq7JU
	mk3ZS+Gw9zL5CAsrAYuCDH9BQoln3I4SHPeV//R7MkvISA4GfRMLQtWNlWLbeEjflxPW3Te06hs12
	bVIPOxqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mqHMy-008Eg1-KY; Thu, 25 Nov 2021 16:13:09 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mqHMt-008Eda-Ss
 for linux-nvme@lists.infradead.org; Thu, 25 Nov 2021 16:13:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1637856782; x=1669392782;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=YOnPg1yWvhlcDajxbwiBgxnb2utQRtNzzz9A2k2ygLE=;
 b=o1QmMT3hCkMeLelqxqtsBG2Q1FW06N/iYCW2DuxHiOYYXrxR+KHt8p+p
 RKXVQxhSCuSF7hmyF2s6N0VGopdj9aCJdDUMLZ30tatsJz0xnRk1Kp3Bi
 g7IUbHiiZdNuQdr2o96ZhIbnCnM3nOdl2Nh0Sid4Wv8H1Foxwu+olK/sp
 +29NYxsfHMwpoZg4e5hjEkFBYpqQTkCfskq3UREahCF0352APuaRq5B0S
 UW8QIbrzWSKSIxjeoSZEoJmb6K1zJ0OfHzG42IjVArpKiRR/+KrqUuCRe
 ZEd0qr1JW1Bq5pMXw3Wxh6ltBAVT+kB8CBaX/p0vBrULNuG6wwQseiRBG A==;
X-IronPort-AV: E=Sophos;i="5.87,263,1631548800"; d="scan'208";a="191436745"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
 by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2021 00:13:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxFtOWRsdIQJe3+74NhMY4zOGksoEUBUY2UN6Mwf4TrRRv7K6Rv6kgzxMjrta5fYizwoIdlzYZkNaSvE43rS5WwpeWzlYQYWWxdbx0Y30DS2pTLHw1QS2kGOQ0mJ5C+GcYIjPSXTSOdEYMlcdouIzZGlK3bjorpur4Aq3iNm8lhZDzAXxgz1nXX78VPSwhi8WSsLD0g3qsPkXxm6Iq8nWbYRIA2gha39GahxvDBBdo5L2ofN6hpCVmwR+o93mCjbuSwDlOEd4dUP3J6RL7ohxwdrRQ2Sa3vxRBmZqnkGxORHNHSw6ZhGm0Wd6/Lre6beAAOMZegXUL6DGz5Y2InxdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmO85t9IjdT7UK3eaXCTEdRR7ZIJ+0ZWKG3E+y2umq0=;
 b=RsAIYE3RuXCRrJkzYkmdvhSAtqF/0UtwrzzK8HuLyoF3VtgjovQ4thJ9SJ5Rqm9TOtFq2wZCYyT3RQhPvBCvqV4+0MUNw5vsSw+iP4d3Sdmy84aWzUbpXm51t98/zabeBD9aAt0RLg/Rnu09x/T+FOCUzMV1YgwrbIADykykKXSnk0SFFZaFX+GORGc4jkjFJ/FWPaGxPuJLwJ2ULqFkwm8K6qmOnCoIOmwZQbBuk9H8bsqT/oZsFp/+e0ivuEDISZCaX+nMx+De2XndT0dcCH96/7pm5xN25YsRUOn3rW1QPeNLiXGFPT+3g9ySlhP9W9n9gDRoy12ishN33VTYXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmO85t9IjdT7UK3eaXCTEdRR7ZIJ+0ZWKG3E+y2umq0=;
 b=aNvCqU0u/OiIwlqShyYPEqDmyeG96K282DwjPsHBFMdEivajoq4H4y/8a8BWrFKomDC8979myMexBXOtfHkb3hUpg+PKiZ4Hjwoyj4WLs+80Rbq07cw2LMHrQmEIP8RHMF7IIQQjE1wEiUe2rRsHuTznYaTAjPDDymQW3fWZbOM=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7269.namprd04.prod.outlook.com (2603:10b6:510:1c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 25 Nov
 2021 16:13:01 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::c504:3d44:5aef:f3ca]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::c504:3d44:5aef:f3ca%4]) with mapi id 15.20.4734.022; Thu, 25 Nov 2021
 16:13:01 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Niklas Cassel <Niklas.Cassel@wdc.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH] nvme: report write pointer for a full zone as zone start +
 zone len
Thread-Topic: [PATCH] nvme: report write pointer for a full zone as zone start
 + zone len
Thread-Index: AQHX4hdRt5zKIuN2cE+GwwUsJOKF0w==
Date: Thu, 25 Nov 2021 16:13:01 +0000
Message-ID: <20211125161247.164381-1-Niklas.Cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.33.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a19c671-f100-4bf2-f5e6-08d9b02e7438
x-ms-traffictypediagnostic: PH0PR04MB7269:
x-microsoft-antispam-prvs: <PH0PR04MB7269F3DA33ED416AE0BABAE2F2629@PH0PR04MB7269.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6bqQJTASfyEgrbLao7Qi18BOQ8SJ1RlYrxwlnAF7RaPF2MwXH9n4aVco5YUX9njEzH+bwLEC3FG2d9z9ju1IKZhlid+5Ck6VA6oyTc58UaRQf6unHtTXjmfo2JwkXVdAl1NJB5mQNQw7CVncYSv+08V04enGoEDq8gQZ30WOP/fL54EnexbNkL2TCA0uuYG3vwbdjmqJe+pxDzPJrGtfRdLF1DCqq5bBEJKpJ0RJzqO9/gSx/7DW0alsxrxpZhBqiP5pg1rMf7GaeTF5fK7nvnd7E5cxRKDMPhjUYtDsQ4bfmNNhhJm9aAtc0WK4gqjDUUTRYWrj1NDMN64Xl+ANEFAgmyK4WIHWiMBS17Ly3kYTTqASiI0n0xAHbX7RDcMzkS1dBUqt8zUFv+KOUhlI+wnoo6EX831CmqQSU3rbgSXfoGqUFK3X175GfIIjOqJc3xoTC/DMwn8Fv4P7FtahASeYllHCIKjOtUIM587xNx3bBeR4cYpHnYgB4DfaoGuuaSZPvoSKGOQVVX07invSKIOKap+bebqfyB56LpcuO18pgigdTUizHyeJAFwf+wsirbo411XRS2pdWTZxoin4JvGWYP3O3egCe1EomjpxvHxoPiMrZnoc6IgxMyuc8wJ5+uVeg6bHaPNqFe7VxqaCKKOWUPxdt7WPHjno1mxyYi6+cersCAIpMbiwMuzMmdQ73s4ylsmp5NlUkcrLNEaDsA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB7158.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(122000001)(1076003)(66446008)(82960400001)(36756003)(8676002)(38100700002)(71200400001)(2616005)(66556008)(38070700005)(66476007)(66946007)(64756008)(83380400001)(508600001)(5660300002)(2906002)(76116006)(91956017)(4326008)(186003)(6486002)(8936002)(316002)(6506007)(110136005)(26005)(6512007)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xY9H1YSX5FjGGAt77hzVb8WQSXsKtT5u/zPOBcNEEH5iLimNqc94Dr9jJB?=
 =?iso-8859-1?Q?dFrVAvV0e0ZF4j3SlBvGriheC/stVMvowtwb/isAwikacT8LwaLvDVv/XV?=
 =?iso-8859-1?Q?RRrF6b0IjE4XpMMvOL1MdiW+Bcviqr++r4cMTB9f211JSd5z/RzyVDCIyb?=
 =?iso-8859-1?Q?wWpjgNc+CoRZy+/6fMk4d2nA9yTQmuZ/U21gL8DnBXDf/6Sv9A5f+mjhWa?=
 =?iso-8859-1?Q?JVfZY89GwUoKO1vqf23c0qFmcK6d6iZTSG0Jol6rYAMmUdw3MUNe8bKjgg?=
 =?iso-8859-1?Q?HMofz19Hn7s33udgA72ANS6M5YOyfdoAMQbNI3/dgEPYa9/Fi5vt6v766e?=
 =?iso-8859-1?Q?HheWwiGfOIfHhIDvBMhRp1L5GKZJhAzhin1rYvY/izUcqgyuhJ+TM2mu1/?=
 =?iso-8859-1?Q?HunbCb5UrEEihtyvWUCf27l0lCUKD+whTZfcVFuerf0dI4ezOuX8vzjXjy?=
 =?iso-8859-1?Q?4BZBZrp6Y5do6gIZk0Y2Lhb+Ntjogcou6TkkGvvVY0WrhfEh7BuPURPOg9?=
 =?iso-8859-1?Q?/ZN23GaaPJSFlnfn/tPVj8eHae+OXkK0NK4L27JQ1I9rARLdWRK/0NLygp?=
 =?iso-8859-1?Q?pjR7p4IByRPrxTwpKuR9dELzBoxXx57DBHakRJFLJDB3vUUmkwNJEJAp8E?=
 =?iso-8859-1?Q?aKqxU5elR66DAzryoPSmFuzOklLlsbRsj2I/sZ5Gra2mcUdZkPzBAvHMc6?=
 =?iso-8859-1?Q?ByCY4oX61xa7O7uPJDWSkD9E//GgM8/ZNlynvg0K/RxUL8/Nf4+ycG/+X0?=
 =?iso-8859-1?Q?UkIKnO31ulaUNFNIDCOtEh+su2ZU0CpGB0Z0IE9q/RSlS3fAT2hq8TYlId?=
 =?iso-8859-1?Q?NvREDO0F40IEFnHZbYpdhcdNuxu80UZ86RlqpwlMVOqvAA1n4+VxTiUPlB?=
 =?iso-8859-1?Q?ggoI8KLcyytFA8JsbuijWODHVtjinGDt7UHunXRqv2A6ac6FiTN1w2FO0y?=
 =?iso-8859-1?Q?MDbbdaHV7oxCOAT5Ang4S3RktRR4hf48UJ16vi40SZiyyvnpLDG5TeNdwI?=
 =?iso-8859-1?Q?uZZDOyqumdmNb/AQvDS3o/LncgPSDYDuWkV2UB40Sz+isgA0Vx8Xs4DM2Z?=
 =?iso-8859-1?Q?9eiy96l2J1h6B2tX3qByP6YjOu10+UPMT8cWgoVGDpO0hp22sYRE5uEVVW?=
 =?iso-8859-1?Q?RXuPmExIb8oelilvl0LeK6ylGUzgojI+P3271WXQli2VkQuss7BZL7n0as?=
 =?iso-8859-1?Q?KViGxWaRF2UJL/qtd/bbw6XVRmqTDbCfTf5oVQT4nl3ULmGPKcuhiZ+Nbj?=
 =?iso-8859-1?Q?Ly7pmrql03a6t+DtYeM6CrGa9BCp13buv+fnHI93RK9tIlYAiuOHKUtNAq?=
 =?iso-8859-1?Q?as3glkhFEaYT7ZBuT+Kmtu9ydMmZduUPTkCvc/3y8jLjCsf92oEaqPMWDG?=
 =?iso-8859-1?Q?XWv2mHyCrcbT80ez/XXQYDCkloNAwZNt8rPde45VOi4j2CSTT7YXTBsYjg?=
 =?iso-8859-1?Q?mEXg0ndoM3wiDSaVGGXuHVHur+e+eKaxlgqQd7/bNX8vgy7bS/wioWBaY+?=
 =?iso-8859-1?Q?gyRmwRLB+VhemnjJ7/0blFl6hGFacUSc+vIvdMdLTx1mIsZYtrhGohrJZ1?=
 =?iso-8859-1?Q?/KoM8YE3j+LjnElErw/Iilgnxt1RHB+tr2XWVNJ8Dq9JZf/vXNsXdjtzzS?=
 =?iso-8859-1?Q?I4rOd9lYAUtf3/pFEFIT6NOtRixOt3UPvO+0zRE9wSmgwIvqOSWTs2gsgB?=
 =?iso-8859-1?Q?62zI7DAgL3m6TwmZOkE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a19c671-f100-4bf2-f5e6-08d9b02e7438
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2021 16:13:01.2857 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dzLAcC9bTkEegZp7BchnJ/63FsxeJM8MQSylwTDE2fmP9RE7ir4rC4PU3fZm5hAOSY81RpeeijL3G5+/1FmZxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7269
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211125_081304_038596_10DB3B30 
X-CRM114-Status: GOOD (  17.32  )
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

From: Niklas Cassel <niklas.cassel@wdc.com>

The write pointer in NVMe ZNS is invalid for a zone in zone state full.
The same also holds true for ZAC/ZBC.

The current behavior for NVMe is to simply propagate the wp reported by
the drive, even for full zones. Since the wp is invalid for a full zone,
the wp reported by the drive might be implemented as a don't care term.

The way that the sd_zbc driver handles a full zone is to always report
the wp as zone start + zone len, regardless of what the drive reported.
null_blk also follows this convention.

Do the same for NVMe, so that a BLKREPORTZONE ioctl reports the write
pointer for a full zone in a consistent way, regardless of the interface
of the underlying zoned block device.

blkzone report before patch:
start: 0x000040000, len 0x040000, cap 0x03e000, wptr 0xfffffffffffbfff8
reset:0 non-seq:0, zcond:14(fu) [type: 2(SEQ_WRITE_REQUIRED)]

blkzone report after patch:
start: 0x000040000, len 0x040000, cap 0x03e000, wptr 0x040000 reset:0
non-seq:0, zcond:14(fu) [type: 2(SEQ_WRITE_REQUIRED)]

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/nvme/host/zns.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index bfc259e0d7b8..4091b955ce62 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -167,6 +167,8 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
 	zone.capacity =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->zcap));
 	zone.start =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->zslba));
 	zone.wp =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
+	if (zone.cond =3D=3D BLK_ZONE_COND_FULL)
+		zone.wp =3D zone.start + zone.len;
=20
 	return cb(&zone, idx, data);
 }
--=20
2.33.1

