Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8FAC4321E
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 13:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IJFvu7Txlqq4QbkiUAdYp5LUxrFDgYD73zO+DTftg+Q=; b=vaRdCpKFrevwpI7no815ioGf0m
	wonU90O74UG+dgifMchqeiuh/5xX2HpHJPwVHAp+N39i36pM26VCL7sdW6x8OLEKpk+a0pM1/vrRV
	PKwXzwhz3w5kGeNxKK34ZBBoKo6zrNVkVqZhuo/r3gViru+xGjZHimhQOfY6NvcdtRpWD6k3cZF3f
	iNLZwhhvkJhbwjzt1t4JHU3+ajIWAif9pqs6NU29AbaDeLIceOzVAcOvzpWHBjMQkzCsXDMsTyTKE
	h4GNnDucyAEyR/6jjQxm3cC7jvm/d9S6iLX5lsEl+Itgw8eV5wlXFOb159S+vnSG/WecW4tMJk+83
	C+lNd/3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmbt1-00GAfU-50; Thu, 05 May 2022 13:51:19 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmbss-00GAWx-5r
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 13:51:13 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20220505135104euoutp028ff99085bb108b3ec4b84f3cbbbf11d2~sOcD_IPiA2896128961euoutp02b
 for <linux-nvme@lists.infradead.org>; Thu,  5 May 2022 13:51:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20220505135104euoutp028ff99085bb108b3ec4b84f3cbbbf11d2~sOcD_IPiA2896128961euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1651758664;
 bh=IJFvu7Txlqq4QbkiUAdYp5LUxrFDgYD73zO+DTftg+Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bZrDyGsfs+3P/kQAlBt5QaftuKlo9xZ5lneMVHI5aug1TG6fS7V9kYpRQH1zJp0TX
 aQS0mDw4Na5Vep/j9UFtkx51ev8HWoPYDdLkzsFpQn0MX3dfLYYu+m7pnzUaRYcDb9
 /7tJSbSgkhqZGCIeAHuUffcELHFXuTEwOESNLwA8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20220505135102eucas1p28ebe907946ee0fe0ae28eddb6534ce59~sOcB9o7Gb3221632216eucas1p2u;
 Thu,  5 May 2022 13:51:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id BA.AC.09887.646D3726; Thu,  5
 May 2022 14:51:02 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20220505135101eucas1p10477067397a4fdadf9fe7adbb26d1edc~sOcBPoXs42590725907eucas1p14;
 Thu,  5 May 2022 13:51:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220505135101eusmtrp2ec25bb53c2cf3e4bc870f4128d9dc4a1~sOcBMyvg22658826588eusmtrp2A;
 Thu,  5 May 2022 13:51:01 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-e5-6273d6462c82
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id DA.F2.09522.546D3726; Thu,  5
 May 2022 14:51:01 +0100 (BST)
Received: from localhost (unknown [106.210.248.170]) by eusmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20220505135100eusmtip1e415b7e73e2fcc5131f9d700d68c3549~sOcAzCwSG0095700957eusmtip1E;
 Thu,  5 May 2022 13:51:00 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: axboe@kernel.dk, hch@lst.de, damien.lemoal@opensource.wdc.com,
 dsterba@suse.com, jaegeuk@kernel.org, bvanassche@acm.org, hare@suse.de
Cc: jonathan.derrick@linux.dev, jiangbo.365@bytedance.com,
 matias.bjorling@wdc.com, gost.dev@samsung.com, pankydev8@gmail.com, Pankaj
 Raghav <p.raghav@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>, Keith
 Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi Grimberg
 <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/11] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Date: Thu,  5 May 2022 15:47:03 +0200
Message-Id: <20220505134710.132630-4-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505134710.132630-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0xTVxTHc997fX1tVnwWAjewjK1GzUiobizuOslEGeZlM25z2ZaQ7Eer
 L9hQStNamLBlBaqzuAAjjIUOg5oyhbJWfqiUoWIRO0ehxjIorjA0rVOLK6U4qUwZ5WHmf59z
 zvec7zk3l8LFejKZUqj2sxqVTCkhhcTZK1F3+o5RrXxj/ywPLfZeIZFloppE9TNRHC0MuXF0
 bb4MQ+N9dgz1nqjFUItlAEN+mwlH3/bNEKjFcBNHtY5RgDw9jSRq+inARzWHHuDIWxMAKNJs
 4KO28QCBrMEQkRXPeEbeYZ782kYy31X8zWfspgk+455sJxjPkI7paDWSzHH99zjTaf6a+WVc
 TzL2g3/ymKquVsDYun4nmM7BUibS8QLzTd8R7D06V5i5l1UqiljNhjc/F+47c6wOU3clfhG+
 0Ufowc/iSiCgIP0anDrs4VUCISWmTwH4b7sN54I5ALsrTQQXRABssPrwpy31o1bAFU4CaKjz
 kVxwF8Dgb91LFYoi6TRYZuTH8gn0EQCHKqaXR+F0CIN/Pa5eHhVP58LI7AAWY4JeC4cuePkx
 FtFvwIXZKh5nlwobrj9czgvoLbDReJPHaVbDqw1+Isb4kqbizI/Li0P6lgAap2aJ2BaQfgtO
 3s/k5sTDe84uPsfPw0V7E8ZxKQx4F1Z6DQBW220k17sFVrmUMcTpl6GtZwMn3warne0rijjo
 vb+a2yAO1p79AefSInj40MrzSqA96l8xhdBT3khwzEBXSy+/BrxkeuYW0zO3mP73PQbwVpDE
 6rQFeaz2VRVbLNXKCrQ6VZ50T2FBB1j6pINPnHPd4OS9sNQBMAo4AKRwSYIou1ktF4v2yg6U
 sJrCzzQ6Jat1gBSKkCSJ9ihOy8R0nmw/m8+yalbztIpRgmQ9ttO7Ztv2raeTkseazxW5Nh1f
 529vVhvDp7JzzJHyYv8qw9r3L1nki7jfMi3Hb3+oE7uddL8FxIVMvsfWy7tuL5S9aF7Fhh4+
 KklDdz4RKyZ3ZcVdxt9OSIebVL4HNNGwfl2nJj7DlSb9OL2o1GOw7mhaU/Bpvm9ecTAr1O+m
 SszpifPFu6/NpUSH149dUJ9vGzbM9DyaGtnq9QQEiomjrcHwwKUDu3OC7oHEVGWms35Mdesr
 wz8W892L0ZTcIFHeJN+uyklL/Sh/2vVl442Lf0yVifQZV7OfG3l31LGZLgyfLz8qvWO6DpUW
 w2BnwglZ3cb8uSThcNHrH5xjMjZLCO0+2StpuEYr+w8ND+StEwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsVy+t/xu7qu14qTDFa/ELD4v+cYm8Xqu/1s
 FtM+/GS2+H32PLPFhR+NTBY3D+xkstizaBKTxcrVR5ksnqyfxWzRc+ADi8XKlofMFpMOXWO0
 uLxrDpvF/GVP2S0mtH1ltrgx4SmjxeelLewWa24+ZbFY9/o9i4Owx+Ur3h7/Tqxh85jY/I7d
 Y+esu+we5+9tZPG4fLbUY9OqTjaPhQ1TmT02L6n32H2zgc1jZ+t9Vo++LasYPdZvucrisfl0
 tcfnTXIe7Qe6mQIEovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJz
 MstSi/TtEvQyti6YwlSwRazi460DLA2Ma4W6GDk5JARMJKZdW8cIYgsJLGWUWLMtDiIuIXF7
 YRMjhC0s8edaF1sXIxdQzXNGidm7uli6GDk42AS0JBo72UHiIgJTGSUubL/AAuIwC/xmkrh3
 ejpYt7BAhMTeS8/YQGwWAVWJs/tusIPYvAJWEr8/9bFCbJCXmHnpO1icU8BaYk7nQ1aIi6wk
 Jj58xwZRLyhxcuYTFhCbGai+eets5gmMArOQpGYhSS1gZFrFKJJaWpybnltsqFecmFtcmpeu
 l5yfu4kRGPPbjv3cvINx3quPeocYmTgYDzFKcDArifA6Ly1IEuJNSaysSi3Kjy8qzUktPsRo
 CnT3RGYp0eR8YNLJK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpg
 krBclV0eNnGB37NOwbVnKvn+bspKfShtphbpoc58an7ew3NBHD6zKyLfPwoT1lF5pSCtVZ38
 eqv0y1qrpFKL3nmxWva7GoM7/t/1cg7o3X8nU/QUg6bdgY9ak3IZWGL7ZCSYSoJrmTlmWhz6
 OPdGVqXSidfPWPmn9wv+Wqyy7rBa1OKqeecvOhy1PWcktC/9yqUms0f3j/StnbGGObIuU4ez
 s2PCxNIATR7DS11u15zf7+u98mEPT0TVky8X1S2Sjilc352wt9UnXMabdU2604KkJyLrbvyw
 LTDN+vnMIyMmxlo8//DWo8ueh6+Vr4mdIrb+5urLrc0cK5v5j8dHn3IIDXNuKBFeWKIVt12J
 pTgj0VCLuag4EQAgxjQTggMAAA==
X-CMS-MailID: 20220505135101eucas1p10477067397a4fdadf9fe7adbb26d1edc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220505135101eucas1p10477067397a4fdadf9fe7adbb26d1edc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220505135101eucas1p10477067397a4fdadf9fe7adbb26d1edc
References: <20220505134710.132630-1-p.raghav@samsung.com>
 <CGME20220505135101eucas1p10477067397a4fdadf9fe7adbb26d1edc@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220505_065110_544048_2A4C3340 
X-CRM114-Status: GOOD (  15.22  )
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

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/host/zns.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 9f81beb4d..65d2aa68a 100644
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
 
 	blk_queue_set_zoned(ns->disk, BLK_ZONED_HM);
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
@@ -128,8 +121,13 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
 	const size_t min_bufsize = sizeof(struct nvme_zone_report) +
 				   sizeof(struct nvme_zone_descriptor);
 
+	/*
+	 * Division is used to calculate nr_zones with no special handling
+	 * for power of 2 zone sizes as this function is not invoked in a
+	 * hot path
+	 */
 	nr_zones = min_t(unsigned int, nr_zones,
-			 get_capacity(ns->disk) >> ilog2(ns->zsze));
+			 div64_u64(get_capacity(ns->disk), ns->zsze));
 
 	bufsize = sizeof(struct nvme_zone_report) +
 		nr_zones * sizeof(struct nvme_zone_descriptor);
@@ -182,6 +180,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 	int ret, zone_idx = 0;
 	unsigned int nz, i;
 	size_t buflen;
+	u64 remainder = 0;
 
 	if (ns->head->ids.csi != NVME_CSI_ZNS)
 		return -EINVAL;
@@ -197,7 +196,14 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
 	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
 
-	sector &= ~(ns->zsze - 1);
+	/*
+	 * rounddown the sector value to the nearest zone size. roundown macro
+	 * provided in math.h will not work for 32 bit architectures.
+	 * Division is used here with no special handling for power of 2
+	 * zone sizes as this function is not invoked in a hot path
+	 */
+	div64_u64_rem(sector, ns->zsze, &remainder);
+	sector -= remainder;
 	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
 		memset(report, 0, buflen);
 
-- 
2.25.1


