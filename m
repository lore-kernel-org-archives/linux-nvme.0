Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23254C3DA7A
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Jan 2023 08:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ki5YCi75NytYdqt7jBnGHXj1OOScNdOplcKKRH7vS3o=; b=UAM80+SEC+Zbv2g2MoGsKwfRVX
	6jBMchL6fKYQUUQumtHecjQqYZ7+0tqs1B6XNc9kjhL4WB2gQErCX9kGqA4RNJgl3xrmGWGnQTUDU
	HGcMA3wljpzH/I6fbUZ5Vq2g62RTqf/kZ0Y5xrKNBseAUGoV4RfpuvlfLbGNB4l1mPwdMj5N60+1p
	NeQ34RMWxTAu9FxFivno1XhJob+ot0hudpjDeQZuI6KI7VZFfG7nVH/tSXNAQTZxAyKTcdkk21W+K
	Ytls7WLbsFwsiJJWwsCSVFc6mIo/WL5fON/0TnbKsQLavUO/bmcUeZVYF+ayDXjPDC1SGy2ayAmwH
	qXyi2W7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDiAn-006eBM-LF; Fri, 06 Jan 2023 08:33:57 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDiAK-006dxQ-Q9
	for linux-nvme@lists.infradead.org; Fri, 06 Jan 2023 08:33:34 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230106083325euoutp02f5a1c10449359bbb15de6098c13adc16~3qy8hiGko2146821468euoutp02m
	for <linux-nvme@lists.infradead.org>; Fri,  6 Jan 2023 08:33:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230106083325euoutp02f5a1c10449359bbb15de6098c13adc16~3qy8hiGko2146821468euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1672994005;
	bh=ki5YCi75NytYdqt7jBnGHXj1OOScNdOplcKKRH7vS3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YtzsNb3p5ukwBbg3Z1DF6RY7c2g7hjRifZy337iRD0UoyWinTYTFvqz05If70KWdW
	 J3a+eKZR3qk6/uvzGxmgvAbd1sgCi9h4q8U1q2BRVNeXc95m2XSKLjvre1KdTwkeYg
	 yThgZYnKFjSmYkEqNBGOXv/UQeHt+mIs9k4NxI1c=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20230106083324eucas1p2a41a4dc8a4943a42cebd2faff7b4f11b~3qy7O-sUd0368903689eucas1p23;
	Fri,  6 Jan 2023 08:33:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 5A.14.61936.3DCD7B36; Fri,  6
	Jan 2023 08:33:23 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20230106083323eucas1p2f0f6d5d5c1c3713be35b841157ae463e~3qy6rXvLi0142401424eucas1p2Q;
	Fri,  6 Jan 2023 08:33:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230106083323eusmtrp21b31fb042b763934d753f5d411f81c64~3qy6qwBSI1128211282eusmtrp2F;
	Fri,  6 Jan 2023 08:33:23 +0000 (GMT)
X-AuditID: cbfec7f4-a2dff7000002f1f0-de-63b7dcd3c38d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id FE.AB.52424.3DCD7B36; Fri,  6
	Jan 2023 08:33:23 +0000 (GMT)
Received: from localhost (unknown [106.210.248.66]) by eusmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20230106083323eusmtip2fe614ae8c9a0dcec5c403fa52c600eb8~3qy6fASkM2941329413eusmtip2G;
	Fri,  6 Jan 2023 08:33:23 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: axboe@kernel.dk
Cc: kernel@pankajraghav.com, linux-kernel@vger.kernel.org, hare@suse.de,
	bvanassche@acm.org, snitzer@kernel.org, dm-devel@redhat.com,
	damien.lemoal@opensource.wdc.com, linux-nvme@lists.infradead.org,
	hch@lst.de, linux-block@vger.kernel.org, gost.dev@samsung.com, Pankaj Raghav
	<p.raghav@samsung.com>
Subject: [PATCH 7/7] dm: call dm_zone_endio after the target endio callback
 for zoned devices
Date: Fri,  6 Jan 2023 09:33:17 +0100
Message-Id: <20230106083317.93938-8-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230106083317.93938-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsWy7djPc7qX72xPNvi01dpi9d1+NotpH34y
	W/w+e57ZYu+72awWNw/sZLLYs2gSk8XK1UeZLM68/MxisfeWtsXlXXPYLOYve8pu8XlpC7vF
	iVvSDrwel694e1w+W+qxaVUnm8fmJfUeu282sHnsbL3P6nF2paPH+31X2Tz6tqxi9Nh8utrj
	8ya5AO4oLpuU1JzMstQifbsErozTq7IKXvJW9E1rZWtgXMPdxcjJISFgIjGnr4cdxBYSWMEo
	0XE8BcL+wigx/4Z2FyMXkP2ZUWL/2alsMA2dP36wQiSWM0rsfnqABcJ5wSjxbcYDxi5GDg42
	AS2Jxk6wqSICwhL7O1rBapgFNjNJ3P69lhEkISwQL3FhXQfYVBYBVYmP/ffYQHp5BSwlPpzN
	hVgmLzHz0newOZwCVhLPp69hArF5BQQlTs58wgJiMwPVNG+dzQwyX0KgnVPiz9XTLBDNLhLz
	LnxjhrCFJV4d38IOYctI/N85nwnCrpZ4euM3VHMLo0T/zvVgR0gIWEv0nckBMZkFNCXW79KH
	KHeU2H/+BiNEBZ/EjbeCECfwSUzaNp0ZIswr0dEmBFGtJLHz5xOopRISl5vmQB3mIbGs8Q/r
	BEbFWUiemYXkmVkIexcwMq9iFE8tLc5NTy02ykst1ytOzC0uzUvXS87P3cQITGan/x3/soNx
	+auPeocYmTgYDzFKcDArifCW9W9LFuJNSaysSi3Kjy8qzUktPsQozcGiJM47Y+v8ZCGB9MSS
	1OzU1ILUIpgsEwenVANTadtTYcPT903PZf6LiTt++ZyYFk/qhOh3/5MVbz25vK4rcOMElTDP
	9TEBfw4Z8VT/vFK7ZdK6K8zLBMWVTcRZ2/N4drdZPkhn7VA6p7lJvX0Vp/+BuQXOJ6trQs/m
	yeR8n6DR0Lho71HO1e6TqpWL+Het2h6w1ITnR+wklQ+JXwxuaWlG7l4x48h5w0mac08m9K9/
	G5lZGPlQ90fB83vKHB+E5v7Un6DE9rt5A/fe/dwGj0rOb9127q+XXdO5pJ2srU8+XAld5MZ9
	zr+5WG2Hxeqn7UoHpI7z9/tndB/bd6aGgffM5vzuq4Y2X04od4t0y5+fIez98GH2HouK3SL+
	Cgu3bpRXsN40PybyKNtXJZbijERDLeai4kQAPHRhhtUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xe7qX72xPNni9R9pi9d1+NotpH34y
	W/w+e57ZYu+72awWNw/sZLLYs2gSk8XK1UeZLM68/MxisfeWtsXlXXPYLOYve8pu8XlpC7vF
	iVvSDrwel694e1w+W+qxaVUnm8fmJfUeu282sHnsbL3P6nF2paPH+31X2Tz6tqxi9Nh8utrj
	8ya5AO4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsE
	vYzTq7IKXvJW9E1rZWtgXMPdxcjJISFgItH54wdrFyMXh5DAUkaJz99uMUMkJCRuL2xihLCF
	Jf5c62KDKHoGVDR5FlCCg4NNQEuisZMdpEYEqGZ/RysLSA2zwEEmiWdTvoMNEhaIlXh4djtY
	EYuAqsTH/ntsIL28ApYSH87mQsyXl5h56TtYCaeAlcTz6WuYQGwhoJKOj71sIDavgKDEyZlP
	WEBsZqD65q2zmScwCsxCkpqFJLWAkWkVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYOxtO/Zz
	yw7Gla8+6h1iZOJgPMQowcGsJMJb1r8tWYg3JbGyKrUoP76oNCe1+BCjKdDZE5mlRJPzgdGf
	VxJvaGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAxGHALnq8uOu5I6vY
	iwOrt6eJ3LbvVd1r4uVvJDFBK83eKabvpn3mrAzzO3dOuZxT+XtivsWGK8y2KjHVorNqyp2P
	1UuwBJ3+E9l4oeCCb0KMQ/2W2zeLHrsGq/zqW7R9yQE/b6OOmFW55styWvY4LP78+b24kW5p
	s4NH159l1oIacYtbPa5Z2XFNuKemGNs57T2bi4KKo0Nmr5LPqcK/lm5lWrMvF3st5Z0vLHD1
	RO6bk1yy10rqlyaEb0v+uuYzw9c8t6lB008qGuRus/VcOeniyoZFsqb3sq0VQz6Xd4vdvvMj
	2n/blJh4443s7Mz5mlqR0/fMUBDnrwg+ERR5+fO5nUKTGT58vn7gFZ8SS3FGoqEWc1FxIgDt
	M+6dRgMAAA==
X-CMS-MailID: 20230106083323eucas1p2f0f6d5d5c1c3713be35b841157ae463e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230106083323eucas1p2f0f6d5d5c1c3713be35b841157ae463e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230106083323eucas1p2f0f6d5d5c1c3713be35b841157ae463e
References: <20230106083317.93938-1-p.raghav@samsung.com>
	<CGME20230106083323eucas1p2f0f6d5d5c1c3713be35b841157ae463e@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230106_003329_503253_454B98E4 
X-CRM114-Status: GOOD (  15.46  )
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

Call dm_zone_endio for zoned devices after calling the target's endio
function.

Reviewed-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/md/dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index b424a6ee27ba..fdef74fe8bd1 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1109,10 +1109,6 @@ static void clone_endio(struct bio *bio)
 			disable_write_zeroes(md);
 	}
 
-	if (static_branch_unlikely(&zoned_enabled) &&
-	    unlikely(bdev_is_zoned(bio->bi_bdev)))
-		dm_zone_endio(io, bio);
-
 	if (endio) {
 		int r = endio(ti, bio, &error);
 		switch (r) {
@@ -1141,6 +1137,10 @@ static void clone_endio(struct bio *bio)
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


