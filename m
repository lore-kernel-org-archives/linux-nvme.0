Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD57C04A95
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 17:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VLoCFLXBp82iOTzKgyetXtUrw6dZfbKcf6Fwvb6vl3E=; b=agkjJgLGovPBDOIcEUR2+cmkXH
	gTgnXrSbQVG3st7+8Sn9+BP2NqdOqoJ4Bgw4cWMkGpqvROJIJ6p8AuUKzMHsRMR0o9p/j2vm5ABJj
	t0WVXej7kOsApV+RVGmcqMkc5uE2KkaSAWoTwlNRaqYLYegty4v3A/BVfCHCHkzelFcQaAoPji3y5
	kz0gm6rc6FWAqDrB3kAgq5joDtIFSQ7MHAWfnPBHMj6DDgTSobe6Uvc+YhUGVr9LkEveDdLzuUhPa
	XxIe2Lg75/Cn0cna6DQqnTwX3iJ+2WeSufBXaBl7WmVXvMXX/XJGPdg0Da0TtLqMKDk1PteXkHNym
	4pn9HaUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obmd6-005Acy-VJ; Fri, 23 Sep 2022 17:38:25 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obmbM-0059jO-ED
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 17:36:44 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220923173634euoutp01e4853b0d7b5def512eaa85a69e8dd6ca~XjeM68fCK1802418024euoutp01S
	for <linux-nvme@lists.infradead.org>; Fri, 23 Sep 2022 17:36:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220923173634euoutp01e4853b0d7b5def512eaa85a69e8dd6ca~XjeM68fCK1802418024euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1663954594;
	bh=VLoCFLXBp82iOTzKgyetXtUrw6dZfbKcf6Fwvb6vl3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k62M06N5VRQ1Cx3KQa8ca6GIO0VEfSRvMWRsAx6JcvenLGNqqZdW0QMIobWcVqTwo
	 CfdUCfREE/8cqGbl4TpVHOx6GTuEMLQYdPSR3N3ofDEosv/XBgGmCI/Vt+QZYK/zqe
	 M8ACSS8Oih4r9nrqk2WKYrj7pVz+eQ0uSLuYCZqY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20220923173632eucas1p1e9795110811de8541695b2c4f2710fb0~XjeK9i_9O1387913879eucas1p1N;
	Fri, 23 Sep 2022 17:36:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 22.2F.07817.0AEED236; Fri, 23
	Sep 2022 18:36:32 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220923173631eucas1p23cceb8438d6b8b9c3460192c0ad2472d~XjeKiK2ty2441724417eucas1p2L;
	Fri, 23 Sep 2022 17:36:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220923173631eusmtrp24c355eec72b16adf2b5af6b9f91c9d89~XjeKhNNeo1023410234eusmtrp2-;
	Fri, 23 Sep 2022 17:36:31 +0000 (GMT)
X-AuditID: cbfec7f4-893ff70000011e89-3d-632deea03b08
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id EC.5F.10862.F9EED236; Fri, 23
	Sep 2022 18:36:31 +0100 (BST)
Received: from localhost (unknown [106.210.248.168]) by eusmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20220923173631eusmtip2e03787d8bb3d48ec0db7b3d7ae7a333e~XjeKHxeXU2194521945eusmtip2g;
	Fri, 23 Sep 2022 17:36:31 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: snitzer@kernel.org, axboe@kernel.dk, agk@redhat.com, hch@lst.de,
	damien.lemoal@opensource.wdc.com
Cc: jaegeuk@kernel.org, gost.dev@samsung.com, bvanassche@acm.org,
	linux-kernel@vger.kernel.org, hare@suse.de, matias.bjorling@wdc.com,
	Johannes.Thumshirn@wdc.com, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, pankydev8@gmail.com, dm-devel@redhat.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v15 11/13] dm: call dm_zone_endio after the target endio
 callback for zoned devices
Date: Fri, 23 Sep 2022 19:36:16 +0200
Message-Id: <20220923173618.6899-12-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220923173618.6899-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7djPc7oL3ukmGzx5wm+x/tQxZovVd/vZ
	LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
	/rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
	m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBEcdmkpOZklqUW6dslcGWs37OBqWAe
	X8WURdvZGhgvcncxcnJICJhILJhylK2LkYtDSGAFo8TuWU9YQRJCAl8YJW4/C4RIfGaU+HDj
	LgtMx4sjc5khEssZJd70zIfqeMkoses+YxcjBwebgJZEYyc7SFhEIF3i+Nab7CD1zALbmCTa
	Zu4EGyQskCpxfOdeMJtFQFWi9ch2ZhCbV8BSYv7umVDL5CVmXvrODjKTEyje31gDUSIocXLm
	E7ASZqCS5q2zwe6REFjPKdGx/S8jRK+LxIKzZ6FsYYlXx7ewQ9gyEv93zmeCsKslnt74DdXc
	wijRv3M9G8gyCQFrib4zOSAms4CmxPpd+hDljhLNG14zQlTwSdx4KwhxAp/EpG3TmSHCvBId
	bUIQ1UoSO38+gVoqIXG5aQ7UUx4SX17uY5zAqDgLyTOzkDwzC2HvAkbmVYziqaXFuempxUZ5
	qeV6xYm5xaV56XrJ+bmbGIEp8PS/4192MC5/9VHvECMTB+MhRgkOZiUR3pSLuslCvCmJlVWp
	RfnxRaU5qcWHGKU5WJTEedlmaCULCaQnlqRmp6YWpBbBZJk4OKUamPxciu/Uzf+q0qr7oy87
	vTu6z+7f18NWK6cvjHhvXCzJxVI+2XSfvs/9H3YrqrbEvH9jstb1RETv3mhvPWU/+Q/su/64
	+6hwSh6u2bxfQClqvqPg6mUzG2v+3klvvVhd7dV4a8srYctjR9xkChyTVY+bFk364rgi84xH
	7avPM7Z82braW5lH8OWuw4eUttr1GZr8mvK6fo22R7RTfNxZ23fzb+nv44yc+C1wR3e33PIo
	T2fJu3K3heudbpqxnoljiWqaMWnR5JIVatPsNHgMrwVlnkuqXDePvy3xbaBmxyddgf2WYuVp
	6osmqt1yWJBhVOLgJxJx88WVDu9dbcsMZ/qIv+g+ZcZg0Sf9/TivEktxRqKhFnNRcSIAWGcn
	fvADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xe7rz3+kmG2xfpm2x/tQxZovVd/vZ
	LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
	/rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
	m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6Rla
	WugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GWs37OBqWAeX8WURdvZGhgvcncxcnJICJhI
	vDgyl7mLkYtDSGApo8Sb3T1MEAkJidsLmxghbGGJP9e62CCKnjNKTNu9nL2LkYODTUBLorGT
	HaRGRCBX4tjae6wgNcwCR5gk2nbfB0sICyRLLHvyhBXEZhFQlWg9sp0ZxOYVsJSYv3smC8QC
	eYmZl76DzeQEivc31oCEhQQsJM4vfsQOUS4ocXLmE7ByZqDy5q2zmScwCsxCkpqFJLWAkWkV
	o0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYMRuO/Zzyw7Gla8+6h1iZOJgPMQowcGsJMKbclE3
	WYg3JbGyKrUoP76oNCe1+BCjKdDZE5mlRJPzgSkjryTe0MzA1NDEzNLA1NLMWEmc17OgI1FI
	ID2xJDU7NbUgtQimj4mDU6qBqaXwcaWWRlDSlXkubLWdEUqiC+9P5TX58ZF7vjPffsaexqzO
	1xNnT+iT62p8Efhry7bZf3hX2kn4dq5ckmg2I/Tgwbkdiyv3ZwtKz1iXzumr+XpPtbhssdnh
	IvHdP2oVLnWEzDNn0VYJnO370KHt/7Q8loqfFy2qfn5pU+vbfJ3x+Z7KRZps7mXmvG9qZL3C
	zCIO9/NHnFI5xfx9CkdxNnuPEE8Zc8HU8w8+PJgVIHLP5Kj8hEtMMa8cH5p6lFu4Xi1vqfbs
	496ywNal99GD+PUihz3lw11W6h+6tUNnbqj82yse22929n08tkafJzwjrX3TsfzFOo8kUuzy
	ZrM99BDdVKIUz5N8w+/5ZV0lluKMREMt5qLiRABm3IwQYQMAAA==
X-CMS-MailID: 20220923173631eucas1p23cceb8438d6b8b9c3460192c0ad2472d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220923173631eucas1p23cceb8438d6b8b9c3460192c0ad2472d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220923173631eucas1p23cceb8438d6b8b9c3460192c0ad2472d
References: <20220923173618.6899-1-p.raghav@samsung.com>
	<CGME20220923173631eucas1p23cceb8438d6b8b9c3460192c0ad2472d@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_103636_785137_C95E16EA 
X-CRM114-Status: GOOD (  16.06  )
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

dm_zone_endio() updates the bi_sector of orig bio for zoned devices that
uses either native append or append emulation, and it is called before the
endio of the target. But target endio can still update the clone bio
after dm_zone_endio is called, thereby, the orig bio does not contain
the updated information anymore.

Currently, this is not a problem as the targets that support zoned devices
such as dm-zoned, dm-linear, and dm-crypt do not have an endio function,
and even if they do (such as dm-flakey), they don't modify the
bio->bi_iter.bi_sector of the cloned bio that is used to update the
orig_bio's bi_sector in dm_zone_endio function.

This is a prep patch for the new dm-po2zoned target as it modifies
bi_sector in the endio callback.

Call dm_zone_endio for zoned devices after calling the target's endio
function.

Reviewed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/md/dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 7c35dea88ed1..874e1dc9fc26 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1122,10 +1122,6 @@ static void clone_endio(struct bio *bio)
 			disable_write_zeroes(md);
 	}
 
-	if (static_branch_unlikely(&zoned_enabled) &&
-	    unlikely(bdev_is_zoned(bio->bi_bdev)))
-		dm_zone_endio(io, bio);
-
 	if (endio) {
 		int r = endio(ti, bio, &error);
 		switch (r) {
@@ -1154,6 +1150,10 @@ static void clone_endio(struct bio *bio)
 		}
 	}
 
+	if (static_branch_unlikely(&zoned_enabled) &&
+	    unlikely(bdev_is_zoned(bio->bi_bdev)))
+		dm_zone_endio(io, bio);
+
 	if (static_branch_unlikely(&swap_bios_enabled) &&
 	    unlikely(swap_bios_limit(ti, bio)))
 		up(&md->swap_bios_semaphore);
-- 
2.25.1


