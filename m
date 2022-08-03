Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B70C19F28
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Aug 2022 09:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E+La7o2Zl30I/sNS3Lx2T739zrulxOvYuda5lE4fWfc=; b=HEC36GAetqiQ9npKau7WeyoSlp
	6kK9GnQcCSrorcZDh/f43s2znHJ8FHw9OCEg3RIr6288VzNpwMxVu877EcJMT8IlfsFxfHYgJdhB+
	6H40RBoqgNDJvte6p592aADksGVCfzewp0PYhV4ni+R6j3eudpuAJwKwChhh8bNVOYThawOdKDPeV
	vY96fzIcVfdqRy/7l6feA8b3b5e2KSVTKB1XGN4wodz9qnG29vrc8GetaSex3z7UPs0MCsHzWBTVg
	26MlQntmKTiO0iZoEsTtWmf+nx256e+Vrnv1YNz6CUKbSPinQMCjadVnRCo8D5jEX2FPa85noR3EG
	GFpKiddA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJB1I-004Uj2-Qi; Wed, 03 Aug 2022 09:50:29 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJAz9-004TAB-Tf
	for linux-nvme@lists.infradead.org; Wed, 03 Aug 2022 09:48:18 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220803094810euoutp02bcff3f0585a68c32fdbb7a641da5a3b7~HzLrOWQRm1921619216euoutp02G
	for <linux-nvme@lists.infradead.org>; Wed,  3 Aug 2022 09:48:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220803094810euoutp02bcff3f0585a68c32fdbb7a641da5a3b7~HzLrOWQRm1921619216euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1659520090;
	bh=E+La7o2Zl30I/sNS3Lx2T739zrulxOvYuda5lE4fWfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ikltu0wE24mOe3U3dKUOjvM4+VVsDaHNPMPPFGdsi/XXdOGku3WMzxwNQBQK3/S+H
	 gaHs8USGWaW7Qr0wHUrT2m0wKzd5+DT6zxxouGah3wZTusWjkUlcR2rkNT0Yz/Ctft
	 V24k7phUZEtT81XGVDBBbsLoVqI94ls1GTwTMeYY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220803094808eucas1p20fccdbf39db130f1fcffa078d5c3ffd0~HzLpo-yKd1615116151eucas1p21;
	Wed,  3 Aug 2022 09:48:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 2C.F2.09580.8544AE26; Wed,  3
	Aug 2022 10:48:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20220803094808eucas1p1a6a800161d32fe4242d39e669e5f3527~HzLpBPANP1078810788eucas1p1N;
	Wed,  3 Aug 2022 09:48:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220803094808eusmtrp111d241cef0397c0689130cd7d8eb2553~HzLpAXxR92000320003eusmtrp1R;
	Wed,  3 Aug 2022 09:48:08 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-14-62ea4458fe5e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 94.9B.09038.7544AE26; Wed,  3
	Aug 2022 10:48:07 +0100 (BST)
Received: from localhost (unknown [106.210.248.112]) by eusmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20220803094807eusmtip2c69438db6f11c983d60b36accf56cbb4~HzLosQXnL1679416794eusmtip2n;
	Wed,  3 Aug 2022 09:48:07 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: Johannes.Thumshirn@wdc.com, snitzer@kernel.org, axboe@kernel.dk,
	damien.lemoal@opensource.wdc.com, agk@redhat.com, hch@lst.de
Cc: dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
	linux-kernel@vger.kernel.org, pankydev8@gmail.com, jaegeuk@kernel.org,
	hare@suse.de, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	bvanassche@acm.org, Pankaj Raghav <p.raghav@samsung.com>, Luis Chamberlain
	<mcgrof@kernel.org>
Subject: [PATCH v9 05/13] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Date: Wed,  3 Aug 2022 11:47:53 +0200
Message-Id: <20220803094801.177490-6-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803094801.177490-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7djPc7oRLq+SDFZu0LBYf+oYs8Xqu/1s
	FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
	f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
	vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBPFZZOSmpNZllqkb5fAlbF5
	/1b2gj6RiiOdk1kaGC8JdDFyckgImEjcOP6crYuRi0NIYAWjxIKDr1kgnC+MEv8m9jNDOJ8Z
	Jfa9bWOCadmybQEjRGI5o8TsVxtZIZyXjBKtmxcAtXBwsAloSTR2soPERQSaGSXu/u0BK2IW
	OMAkcXPLLbBRwgJREjvunWAGsVkEVCVOr5kCZvMKWElsvTCRHWKdvMTMS9/BbE4Ba4kp//5B
	1QhKnJz5hAXEZgaqad46G+xWCYHtnBJ3l3SzQTS7SHxZuBJqkLDEq+NboGwZidOTe1gg7GqJ
	pzd+QzW3MEr071zPBvKCBNC2vjM5ICazgKbE+l36EOWOEotnzmCFqOCTuPFWEOIEPolJ26Yz
	Q4R5JTrahCCqlSR2/nwCtVRC4nLTHKilHhKXz35lm8CoOAvJM7OQPDMLYe8CRuZVjOKppcW5
	6anFxnmp5XrFibnFpXnpesn5uZsYgUnx9L/jX3cwrnj1Ue8QIxMH4yFGCQ5mJRHeOy7Pk4R4
	UxIrq1KL8uOLSnNSiw8xSnOwKInzJmduSBQSSE8sSc1OTS1ILYLJMnFwSjUwcfXt3pd77WJt
	1Jk7hqvu9u2u6Ok/MnP+z9V3Dv+sSv+y55WR6eyH2y1Dzh7JTI/Y0rbva+gFJieWBFsbJnOR
	vqmG0x0y/kpwd5x63fRJ6MTOmIIP5cLOa411vuR91TzntpGPkbOuOP9GsvqferXUVZrCBzbs
	luGQ0Nwwvf+v+ZGWhpjz3ytdN5eqLkvb/lPlkOKp/f2PrcoyF9zfMGnNguc/lGyeKUWu2+tb
	Ll6hy9jpfo5Fa6pz8zdT+Y3TQkO2mBx84J/atfiA+99TrVfMVESzVDUnvoq+vbpA4bqNdUJU
	96dtsqzi84yO/ufS4HL5d+/gOoudx2ZsWJHofPtzuSprlIWQzawZOlcMpifeU2Ipzkg01GIu
	Kk4EABdgS875AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xe7rhLq+SDHavs7JYf+oYs8Xqu/1s
	FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
	f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
	vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBOlZ1OUX1qSqpCRX1xiqxRt
	aGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7F5/1b2gj6RiiOdk1kaGC8JdDFy
	ckgImEhs2baAsYuRi0NIYCmjxKTJC1kgEhIStxc2MULYwhJ/rnWxQRQ9Z5Q43/SfqYuRg4NN
	QEuisZMdJC4i0M0ocfnMOVYQh1ngHJPEnKcP2EC6hQUiJG7u+soOYrMIqEqcXjOFGcTmFbCS
	2HphIjvEBnmJmZe+g9mcAtYSU/79A6sRAqpZ93cWK0S9oMTJmU/ArmMGqm/eOpt5AqPALCSp
	WUhSCxiZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTG77ZjP7fsYFz56qPeIUYmDsZDjBIc
	zEoivHdcnicJ8aYkVlalFuXHF5XmpBYfYjQFunsis5Rocj4wgeSVxBuaGZgamphZGphamhkr
	ifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTAl+sp25f3lqDz+RSuO29Y9z3DFlsNdmnpzghR/
	F1u98So+PoH7yo6M2jKWeQK5ObMXsFZx1lYx+BeIBRQZOqvne3LM+6i6iTUtk+H5LqYIhv+z
	JV4qfeWwiNSzn3VH77SJRFTou/j0+PvPrj6SsuF8UqPwKPZ52EPnZJP0KysSPTyj8qbxXO/5
	/6kg8PYqxXO5uoFtu+UZz04Oit02zWqGd9W/+Xuj03kn3UrVmzpX9I3LSc79u/qjozhsdq8t
	WdL/me1q0epZK7Sac+/kXnr4Z47V7b8cRXNsGrw0kmZIrN6p8j6Z1WRjyvujqQbLL/ntiFjk
	PEPlkM1emaiyxvmM3s9Ld245VdHvFXjSSYmlOCPRUIu5qDgRAAllp1doAwAA
X-CMS-MailID: 20220803094808eucas1p1a6a800161d32fe4242d39e669e5f3527
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220803094808eucas1p1a6a800161d32fe4242d39e669e5f3527
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220803094808eucas1p1a6a800161d32fe4242d39e669e5f3527
References: <20220803094801.177490-1-p.raghav@samsung.com>
	<CGME20220803094808eucas1p1a6a800161d32fe4242d39e669e5f3527@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220803_024816_303554_3C799B51 
X-CRM114-Status: GOOD (  14.39  )
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

Remove the condition which disallows non-power_of_2 zone size ZNS drive
to be updated and use generic method to calculate number of zones
instead of relying on log and shift based calculation on zone size.

The power_of_2 calculation has been replaced directly with generic
calculation without special handling. Both modified functions are not
used in hot paths, they are only used during initialization &
revalidation of the ZNS device.

As rounddown macro from math.h does not work for 32 bit architectures,
round down operation is open coded.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/host/zns.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 12316ab51bda..73e4ad495ae8 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -101,13 +101,6 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 	}
 
 	ns->zsze = nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
-	if (!is_power_of_2(ns->zsze)) {
-		dev_warn(ns->ctrl->device,
-			"invalid zone size:%llu for namespace:%u\n",
-			ns->zsze, ns->head->ns_id);
-		status = -ENODEV;
-		goto free_data;
-	}
 
 	disk_set_zoned(ns->disk, BLK_ZONED_HM);
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
@@ -129,7 +122,7 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
 				   sizeof(struct nvme_zone_descriptor);
 
 	nr_zones = min_t(unsigned int, nr_zones,
-			 get_capacity(ns->disk) >> ilog2(ns->zsze));
+			 div64_u64(get_capacity(ns->disk), ns->zsze));
 
 	bufsize = sizeof(struct nvme_zone_report) +
 		nr_zones * sizeof(struct nvme_zone_descriptor);
@@ -182,6 +175,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 	int ret, zone_idx = 0;
 	unsigned int nz, i;
 	size_t buflen;
+	u64 remainder = 0;
 
 	if (ns->head->ids.csi != NVME_CSI_ZNS)
 		return -EINVAL;
@@ -197,7 +191,11 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
 	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
 
-	sector &= ~(ns->zsze - 1);
+	/*
+	 * Round down the sector value to the nearest zone start
+	 */
+	div64_u64_rem(sector, ns->zsze, &remainder);
+	sector -= remainder;
 	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
 		memset(report, 0, buflen);
 
-- 
2.25.1


