Return-Path: <SRS0=2ZV3=IG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54BCC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 10:43:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F73E651A5
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 10:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F73E651A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qM0o+QkMWjO6cHe3DzEJS21QNjiX3lZV5R3aG4yx49Q=; b=rL3893oYSVIJutRbjNRWueyXst
	WJZgHhC4pf1VF/IyQZOjweafD+Jb29b27q42WAgCJT3y1n/NXbQsEZxS03/DQaCH1ERzhlL5XUPyu
	wKqQBjV79Vv0r7B+nd7p0lQDTeJxCuXG/XF6V+P98ZJT+tTGkx0rbtqDrali4hMmZJvHdiFOnMW9e
	7qjUy5jR7D4MBAm18PkmKUIJpl4jKoZUXAZOqKbuGsxS4mci+X0aco66Jd//hsfpCFsuoFUJ9gmE9
	DJC2bedRTmkM2He8vlAJjqisJSeJbNDOXM5P7fKRyx0Tkbpw+OtzmPao1N54VzIjSWBpVv/LMTEXT
	IMHymCjw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJDLc-00GVOP-Ky; Mon, 08 Mar 2021 10:42:48 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJDLV-00GVM0-Ma
 for linux-nvme@lists.infradead.org; Mon, 08 Mar 2021 10:42:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615200161; x=1646736161;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=vhWf1RCx8T9+McwXB7CnKiFzXZxNvjtCcppj1i65zGk=;
 b=eExlnZPgXNaJys7X/PHsqYFrT04kkceiTPSWQzatKQja9cNxNfAH0S69
 agCDbBTRbLwZQXeLfPt2mf4wjdvx5wTEExXZ84doEJPRk5x/+kkXoOvIU
 13oYvj9NLQleDwkA8P/+dwxQ2Oehx+GdL41DU2yvU7rT06vZGpldI/2iJ
 IiFnmE3ISJHtyOSzmqccMtsHqlDZ2McL8HJGsvKwuTAt7froLedyo9pAa
 4+G7EGeicmdNYdRj5y3OhEx72TBeE/qp73Rtv9l0DFkcYnFv3KtHNBGYp
 dDy+w9eHxHDMp35TTe6MnUOl5agxWu2EY4LaE5vHWfx9vBIohGhx6NVDo w==;
IronPort-SDR: FsL49EP1wkKfTio7WPUtnAID6aCJjYgCbmodI6f+n584zPndagraW3MRy2b/TOB/6aViAbq+Zv
 Z8atxAA+zSG61xQ3cIyp54+tvsOnewYfN1gS2HFLTAGwQ1z0YGU1AAjDE3ToJbrpKlgPI4dYtj
 PmR3WmBWlW1pEq9rqwV0qS+6zZZaUUcQU3JVc5RtVFuomj4SFq0Nwenf0REIXbmb93DpV7hdFl
 Hw9ClvCDhYKldX1wsXma5mS3csmSmceK0FhdF+ecUc9Vl04UpicZyYFBMX5V63M+9BQKAmnwms
 /6U=
X-IronPort-AV: E=Sophos;i="5.81,232,1610380800"; d="scan'208";a="161606454"
Received: from mail-cys01nam02lp2050.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.50])
 by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2021 18:42:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wy675tK3Hd6v9JEko0ei1VDTIw//54cNjVHnKXm0+GRj+FVJC3lib4PmodU6kxUg8Qa/hwGzlci6upQykqwVuXIgMNkq2Q92YQL2pV2Otc8U8FQo+NtZjMbejMMN5Qmx0waRcE/QSSgsiIZ4pbGhgqYZJ4EniiZ4A4DWVuaM1Vvc0sg3z74XuM5uDoX/ie2GMqla2yK1iC7NaVveGaPpmY7gHOQpYdu2nwVBGgFCi5mBiSUJW37vfcJVKB7AmImjVFTtGDQYB1Uxp+4nrboWZ82evXSCQZWcmXC5q7h4C3Af9Ecca153QRYEAHBT2awg45tOO30rjj5lu1D0fdSPFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dwcARWGRUR5UNC3BsqJFG9ac/aGHjUgkb2k0QOFfjk=;
 b=PNmJ7+DN7uzNd2hFqSooJaEFzvys+uuy7tEcSAT9XOCmpsGr+bypGCvLynS2rQ/I+hvvFy3ChPFY3D0m1Nawv8mFCeHmeIPifAuUe0Yla+oWvSNKPj4b71ji0ZUATH3ExmRYHItM2GfF9uWHHyFaUkDzryuyJgvv0vd+VzNtyrcM9DSVyYPBP1dXf1GqPlCBH2snfw73IqoIbGcjNkUYqGkFsIMcJ3lbdTbBulbptoMi1C9g2L+HwLmtusLqqAps1Nh5ApzsxLdagMWEnwF1c1ZGl9tAOuu8GuwK/oemQf26lfqa4c/BnfxzC8D5k9CVraUxd2lZdsIDblq3ByANyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dwcARWGRUR5UNC3BsqJFG9ac/aGHjUgkb2k0QOFfjk=;
 b=LT6Mms8XxP+zNkZHQvfUMIzimY1lDSqqWVcdZRRw6xkW9/oWw4q8ho7miHR/OxeVZW9qHU6sbeX8Br7bfm/uLNcf5NZgMUND1/nxK2MuaJTM6nmg8zXJOrcxTO5tyZULZ338G50Cs7Ba3x4u44y9NkuB5pT+80UUifaUYRJEd5A=
Received: from DM5PR04MB0684.namprd04.prod.outlook.com (2603:10b6:3:f3::20) by
 DM6PR04MB6298.namprd04.prod.outlook.com (2603:10b6:5:1ef::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.23; Mon, 8 Mar 2021 10:42:34 +0000
Received: from DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::11d3:8b30:e11f:87e5]) by DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::11d3:8b30:e11f:87e5%9]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 10:42:34 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Niklas Cassel <Niklas.Cassel@wdc.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH] Revert "nvme: cleanup zone information initialization"
Thread-Topic: [PATCH] Revert "nvme: cleanup zone information initialization"
Thread-Index: AQHXFAe/O1qthbSdYkihoP//+y7iVQ==
Date: Mon, 8 Mar 2021 10:42:34 +0000
Message-ID: <20210308104226.165814-1-niklas.cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.29.2
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0fc15512-2fba-4ab4-9971-08d8e21ee230
x-ms-traffictypediagnostic: DM6PR04MB6298:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB6298650C63094DFF40C1DC1DF2939@DM6PR04MB6298.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:311;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 677injCT+oh9MsqrLv5L8AmGfygK1VjA85WLUMqXK3D1CnloMAVPZZD9LCWN+LeF/djwZXK426erb+XYxjhp4fQyEwN/Ohl62MaG0sjbuh0c/X2QWFDizu+i9nDLO/C4qL4IAwfrmKTb5vjy19ni0tPjDgBD+xVC+lepEzWg0AhR1Lx1mDtfDkXE73IxjmfLHs5w0w2Dpysc80eV0Riw6S1OiLAyRIdNf9L93WRLrcgbCaiQ7Yd7xwRCI5pLh+NGcRcRkE/7kedNwiWo/N7n6CiJb9BJ9nBTA/xO0XBcm6E6Sd/21zdN3hwQwIWQVL8Je+qdNMyCjeUfi7JsH2gV372L38w405H/9X6rV0+dWS+14i/M/xyv0WXDzkJ6cHA5tOUJtuSmmXNtG2ovl9hT2cSYI61dU8IjmvqfcOLaHeXjJvkQTgORs5TRuzD9y3dfJ+rlM5FDGFgnhZeAvK4mrfgoLKllFgewYolSrkA2dLpeI3exJrcSUhoo6h0gULSnEZqcZj1vClaK7MVBp6MaMQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR04MB0684.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(8936002)(2906002)(8676002)(36756003)(4326008)(64756008)(5660300002)(2616005)(1076003)(6512007)(186003)(26005)(6486002)(71200400001)(316002)(110136005)(54906003)(83380400001)(6506007)(91956017)(478600001)(66556008)(66476007)(66946007)(66446008)(76116006)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?BCIdlcU7NLILtMZnADw3XcMcCadUseZUKj/HBkubTwMHFFE+iPjfTiPV8v?=
 =?iso-8859-1?Q?pYO48tuHcTHhiGdlENSr7N3Tk4rlPmCT+y//u5lp8llxwXqD7hN43t/NjN?=
 =?iso-8859-1?Q?AV++qd7gcyNrhiJCxx96WniptsosJCdeYGlT7Rp4fxnm6o1iA1SidH742K?=
 =?iso-8859-1?Q?Jp+27boB4kEPWwgtdExG6e2g0ogdTzA4AcvGAUJD5tRC1NK8Y9fFquE0Tl?=
 =?iso-8859-1?Q?7CGz/HSzOS2TnJsgDB+uEgfRmwu1lEmhlemF2OHYGWZp/vyjlrHX7LBe5T?=
 =?iso-8859-1?Q?HViyksAldTZ8Z4Gsv5XDq/JVizoZnxzZo8AnCqpveLmiEBe/hBipmhz7IU?=
 =?iso-8859-1?Q?A6jFJT8N1G8NouKkeZh3/K0jUaUvLita4kf0BjoU896PZVq+lYPbgrLRyl?=
 =?iso-8859-1?Q?ZnLeBU4wqJmdSeoWPVJT3Sv0yiNklJW1xxWAE1H18bmXx7720R/0vdzJMS?=
 =?iso-8859-1?Q?Gt2AimnFpCnZYKhq9xapWnaCrHgnYjpOV3iFqbmcL4w+1IJ8TdihoiZtdy?=
 =?iso-8859-1?Q?XW5BB7CZYRQGJXC5XQ4UCwJ1BKATvRhwBwSGzAnWicGAva2zzRcx8Wi55D?=
 =?iso-8859-1?Q?uhT9shtGA3fujNiUFQ0AftrQx9/lqAVal+9373bFmfTtAOzDXrRxZ9X67/?=
 =?iso-8859-1?Q?OYjJK5q3EzVheGt8ABTmIoSGJZTkrIXZedeMxRJ2fcu/oW81ZkFOX8asqJ?=
 =?iso-8859-1?Q?N6IljC6OQI67MZQARdaavyJMSgvpEfRJhQqDt1fkawiBCvjHsHvb/e8/b2?=
 =?iso-8859-1?Q?TLzlBV5jVUcQeYAaL7dWPq2nFt9bUKUX6UE15IBcIH1bgIskh44R/a0TGU?=
 =?iso-8859-1?Q?2Gw3/6n2Lt6bF2JuRzvBE6kJdoRzX6blcDaowM5mCIoy+HuOLQ2shrQeBM?=
 =?iso-8859-1?Q?5oQSiRr29fdivGa+Bg4T06ASX5rx5jRQHP+N4np9o2IXGEbpf/nMejkO9h?=
 =?iso-8859-1?Q?+0DwVHZ0GZ0GRGn8mbutguYd3QxFdDuf0a11P6WO4Q5Pey/hgAeicdhgqK?=
 =?iso-8859-1?Q?jJdy3mwBvlcYftFm+KeyKdq3UI7xgcTWRr6BDuXZ9UjSXDrdm0CJjGIo0Q?=
 =?iso-8859-1?Q?EFATDIH7elgWimvfsiBKUWuAL5nGwi53jEMKWxb8sSZBfOlxxYxpAfCV8b?=
 =?iso-8859-1?Q?3kaU+qKl2EqN72LXFQBFukxx2bnPEBr1UaKfomO9rIkcjQ81FU0X9MVsVX?=
 =?iso-8859-1?Q?KsLyvxkiA83flfrrnExxiy8dgU+e9NmEThivsjdirscqtB2VAgIggHDCy9?=
 =?iso-8859-1?Q?KNVKCEvxQHr19rhHZL82pyrDmNr2JLLFh8W6ZYc7Slhmky4kF41S3itep8?=
 =?iso-8859-1?Q?6mJyGwxtDi41XEEJ3R1lGzNlrLdd4BP4ttmRJX5lZtvqmt826bknJpobkC?=
 =?iso-8859-1?Q?nTxBJJJ4vy?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR04MB0684.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc15512-2fba-4ab4-9971-08d8e21ee230
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 10:42:34.3437 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EJhMCEtQFerhBzHzHVYpPd4Q+jgz1iokpP92kwuW+cYqdenRe58whRiWcqV5tOnVnZU98bnWAjv3/YogML0KJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6298
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210308_104242_768610_C2A2302A 
X-CRM114-Status: GOOD (  16.79  )
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

From: Niklas Cassel <niklas.cassel@wdc.com>

This reverts commit 73d90386b559d6f4c3c5db5e6bb1b68aae8fd3e7.

Commit 73d90386b559 ("nvme: cleanup zone information initialization")
introduced the following warning at boot:
WARNING: CPU: 0 PID: 7 at block/blk-settings.c:252 blk_queue_max_zone_append_sectors+0x7d/0x90

The warning is the result of chunk_sectors being 0.

Worse, this causes the sysfs attribute zone_append_max_bytes to
be incorrectly reported as 0, which will break user space applications
relying on this attribute.

Looking at the commit, it probably assumes that calling
nvme_set_chunk_sectors() will cause chunk_sectors to be set.

However, looking at nvme_set_chunk_sectors(), chunk_sectors
is only set if namespace optimal i/o boundary (noiob) is non-zero.

A noiob value of zero is perfectly valid according to the spec,
and simply means that the namespace does not report an optimal i/o
boundary. Hence, we cannot assume that chunk_sectors is set after
nvme_set_chunk_sectors() has been called.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/nvme/host/core.c | 11 +++++------
 drivers/nvme/host/zns.c  | 11 ++++++++---
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e68a8c4ac5a6..a38b509eeb80 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2210,18 +2210,17 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 	ns->lba_shift = id->lbaf[lbaf].ds;
 	nvme_set_queue_limits(ns->ctrl, ns->queue);
 
-	ret = nvme_configure_metadata(ns, id);
-	if (ret)
-		goto out_unfreeze;
-	nvme_set_chunk_sectors(ns, id);
-	nvme_update_disk_info(ns->disk, ns, id);
-
 	if (ns->head->ids.csi == NVME_CSI_ZNS) {
 		ret = nvme_update_zone_info(ns, lbaf);
 		if (ret)
 			goto out_unfreeze;
 	}
 
+	ret = nvme_configure_metadata(ns, id);
+	if (ret)
+		goto out_unfreeze;
+	nvme_set_chunk_sectors(ns, id);
+	nvme_update_disk_info(ns->disk, ns, id);
 	blk_mq_unfreeze_queue(ns->disk->queue);
 
 	if (blk_queue_is_zoned(ns->queue)) {
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index c7e3ec561ba0..1dfe9a3500e3 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -9,7 +9,13 @@
 
 int nvme_revalidate_zones(struct nvme_ns *ns)
 {
-	return blk_revalidate_disk_zones(ns->disk, NULL);
+	struct request_queue *q = ns->queue;
+	int ret;
+
+	ret = blk_revalidate_disk_zones(ns->disk, NULL);
+	if (!ret)
+		blk_queue_max_zone_append_sectors(q, ns->ctrl->max_zone_append);
+	return ret;
 }
 
 static int nvme_set_max_append(struct nvme_ctrl *ctrl)
@@ -103,11 +109,10 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 		goto free_data;
 	}
 
-	blk_queue_set_zoned(ns->disk, BLK_ZONED_HM);
+	q->limits.zoned = BLK_ZONED_HM;
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 	blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
 	blk_queue_max_active_zones(q, le32_to_cpu(id->mar) + 1);
-	blk_queue_max_zone_append_sectors(q, ns->ctrl->max_zone_append);
 free_data:
 	kfree(id);
 	return status;
-- 
2.29.2

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
