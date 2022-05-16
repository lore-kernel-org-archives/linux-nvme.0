Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578C4C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 16 May 2022 16:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IJFvu7Txlqq4QbkiUAdYp5LUxrFDgYD73zO+DTftg+Q=; b=0cmA07TVqT4d7Wn7Rm5hQnOI+H
	6xjrEGniGeS5FyFyAJJyOVJwJeVkMC9VkWd+2bXUxxw0eyvtn6uKg90Lo3uF/2liVQzP6VaGIpZ4M
	R/yaddH8cBlAtHxNervzPGQw02a9bzhGS8OaPG12pV6mZ/xxCeO47YiAvP1EoOSvJ3O4bf0XjLfK4
	0WXu+Y/tvxOkeoOC5DLfJFYb0hMaGxuh+foYaZ8GeGiK7+iL4irKHYOdIqsHRQC/UBcqB7ejiiKCC
	CY4T6SolpbgCqjRtFmhXMCaS2/+8+Mh38to2gIZ8NPXqim3H/aKA23NqpFW4URBxff2M7/brddxPP
	omG0p3Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqdzx-009CR0-39; Mon, 16 May 2022 16:55:09 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqdzK-009BxS-1A
 for linux-nvme@lists.infradead.org; Mon, 16 May 2022 16:54:33 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20220516165425euoutp01cc065ebfa4fab08d733817cb61837009~vpCSGQr272082320823euoutp01S
 for <linux-nvme@lists.infradead.org>; Mon, 16 May 2022 16:54:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20220516165425euoutp01cc065ebfa4fab08d733817cb61837009~vpCSGQr272082320823euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1652720065;
 bh=IJFvu7Txlqq4QbkiUAdYp5LUxrFDgYD73zO+DTftg+Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UPRV74XvfZD/Srf4Pvh5UdLPS71mZCRWcuLS8bADEtZ4NDs7z4mhxzR1HpYYOJ6Au
 T+fX2nb5z5DQsUXAbGWUQCst5by+1zvFZ5dyE+MP0xafrP4vSPFJl/SY++6+K8lrHv
 Cgohay58NbarWtGqihLFMWOWK6tMFdM5JX6fPmgU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220516165423eucas1p158930326081e188da90c844c41449d67~vpCQpqA1T3100231002eucas1p1G;
 Mon, 16 May 2022 16:54:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id B4.40.10009.FB182826; Mon, 16
 May 2022 17:54:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20220516165422eucas1p174acec28848a9c2178376f092af3fa1c~vpCQK_Iy22562625626eucas1p1X;
 Mon, 16 May 2022 16:54:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220516165422eusmtrp2535ec901b9fcfc699f53e88d7145bca3~vpCQKB3a51030710307eusmtrp2r;
 Mon, 16 May 2022 16:54:22 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-45-628281bf30ff
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 9C.00.09404.EB182826; Mon, 16
 May 2022 17:54:22 +0100 (BST)
Received: from localhost (unknown [106.210.248.7]) by eusmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20220516165422eusmtip15250a2577700f87549716a5010c26ef5~vpCP3mI__2390423904eusmtip1u;
 Mon, 16 May 2022 16:54:22 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: axboe@kernel.dk, damien.lemoal@opensource.wdc.com, pankydev8@gmail.com,
 dsterba@suse.com, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, jiangbo.365@bytedance.com,
 linux-block@vger.kernel.org, gost.dev@samsung.com, p.raghav@samsung.com,
 linux-kernel@vger.kernel.org, dm-devel@redhat.com, Luis Chamberlain
 <mcgrof@kernel.org>
Subject: [PATCH v4 03/13] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Date: Mon, 16 May 2022 18:54:06 +0200
Message-Id: <20220516165416.171196-4-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516165416.171196-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djP87r7G5uSDKbckLRYfbefzeL32fPM
 FnvfzWa1uPCjkcni5oGdTBYrVx9lsug58IHFYu8tbYtLj1ewW+zZe5LF4vKuOWwW85c9Zbe4
 MeEpo8XnpS3sFmtuPmVx4Pf4d2INm8fOWXfZPS6fLfXYtKqTzWPzknqP3TcbgMKt91k93u+7
 yubRt2UVo8f6LVdZPD5vkgvgjuKySUnNySxLLdK3S+DK2LpgClPBFrGKj7cOsDQwrhXqYuTk
 kBAwkXj05BhbFyMXh5DACkaJH00vWCCcL4wSSze3MUM4nxklDt/tYodpOXQOJrGcUeLJ9i5G
 COc5o8Tytf+B+jk42AS0JBo7wRpEBLIkpp14CFbDLLCYSWLlnslgNcICURJXNjmA1LAIqEo8
 +7KQFcTmFbCS+LyxlxVimbzEzEvf2UHKOQWsJVZ3cUOUCEqcnPmEBcRmBipp3job7B4Jgfmc
 EjPffGWG6HWR6DsBM0dY4tXxLVAPyEj83zmfCcKulnh64zdUcwujRP/O9WwgyySAlvWdyQEx
 mQU0Jdbv0ocod5S4uWQ2VAWfxI23ghAn8ElM2jadGSLMK9HRBg1cJYmdP59ALZWQuNw0hwXC
 9pC4cX4V0wRGxVlInpmF5JlZCHsXMDKvYhRPLS3OTU8tNsxLLdcrTswtLs1L10vOz93ECEx2
 p/8d/7SDce6rj3qHGJk4GA8xSnAwK4nwGlQ0JAnxpiRWVqUW5ccXleakFh9ilOZgURLnTc7c
 kCgkkJ5YkpqdmlqQWgSTZeLglGpgmuSs6+WTvTBt5Tan/oTrV9zFzfWfiBodeq/he5yjmzHn
 3oum2a98jxQm/2Z3OKjZ53ozYoltu8e3o7Ea05ccNXALvztH9drG9LfZdgmnjRVqj9V0N7/R
 Dsye1ndhbWBH8J7bYde3WL/3zdPMjvj7b0dta4p5/yW++dzavZVndu8LeJZ6ynqbXSD/78ln
 M/47POYs0JiTWqehZ5X/PSZ0kzLn18XyVpzfFbk9Lli86nuS8uS03LmoB29PKEsfeLynmyF1
 wtPf1cUyW4PlBYX33d3Vb9JcKrGEZ2sf+89JM2sUVql4/Z/6O3mFT8mxvHMn/sWu+6DL+T3d
 s/R4ldWW3U0P47POr385g33KgQu6SizFGYmGWsxFxYkAHlO3teUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xu7r7GpuSDE4uNrNYfbefzeL32fPM
 FnvfzWa1uPCjkcni5oGdTBYrVx9lsug58IHFYu8tbYtLj1ewW+zZe5LF4vKuOWwW85c9Zbe4
 MeEpo8XnpS3sFmtuPmVx4Pf4d2INm8fOWXfZPS6fLfXYtKqTzWPzknqP3TcbgMKt91k93u+7
 yubRt2UVo8f6LVdZPD5vkgvgjtKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV
 0rezSUnNySxLLdK3S9DL2LpgClPBFrGKj7cOsDQwrhXqYuTkkBAwkTh0ro25i5GLQ0hgKaPE
 rU1P2SESEhK3FzYxQtjCEn+udbFBFD1llGg5fBkowcHBJqAl0dgJVi8iUCAxp38LC0gNs8Ba
 JonXP96DNQsLREhcfL6AGcRmEVCVePZlISuIzStgJfF5Yy8rxAJ5iZmXvrODzOQUsJZY3cUN
 EhYCKvn65BY7RLmgxMmZT1hAbGag8uats5knMArMQpKahSS1gJFpFaNIamlxbnpusZFecWJu
 cWleul5yfu4mRmBkbjv2c8sOxpWvPuodYmTiYDzEKMHBrCTCa1DRkCTEm5JYWZValB9fVJqT
 WnyI0RTo7InMUqLJ+cDUkFcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fE
 wSnVwJTtXWfCzMs3t5YrfM+9w/OKrcv3FO1V59/Sb6jNqWZquEXvqunu1BANBrf32ZNnSc58
 2ir+pox31e2OH6/8itJvXeiZsNLpwLvdO74xp5xZnN1Sa/nBrzyZbffZLTfjArW3svwsWNjT
 9tH+w8zTrAu6bnDPvfxgavqvxOBpF6e/jgt4M+WWuIvYb58dMma3Ckt4Pt7Z7WL+jPUyT9fv
 sy8eiN/dcPfV1/7l1+V9bsydIPTGN+RwX2PDsWYp7nVVCcf3srf8iBLZtPmZ5Kqqx2lbVrDN
 v3nSQs7vmuEMPgWOvqRjFUWilwOP77GUvLo9lXdO+eGVntIfXV5kFfqesBWb6J05vWurUtXr
 3rAPrPxKLMUZiYZazEXFiQCIvkauVQMAAA==
X-CMS-MailID: 20220516165422eucas1p174acec28848a9c2178376f092af3fa1c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220516165422eucas1p174acec28848a9c2178376f092af3fa1c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516165422eucas1p174acec28848a9c2178376f092af3fa1c
References: <20220516165416.171196-1-p.raghav@samsung.com>
 <CGME20220516165422eucas1p174acec28848a9c2178376f092af3fa1c@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220516_095430_509051_63C06F58 
X-CRM114-Status: GOOD (  15.05  )
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


