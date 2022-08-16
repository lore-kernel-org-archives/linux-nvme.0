Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61CEC25B0E
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Aug 2022 13:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lA4ACIhgPS1mwgZjIDSka7RcIpNQB3Ybt1avCcUQ/Cs=; b=H3j7svCpHmEtRNLSe0OjvkeyZs
	y4E0OOckpDnEL3eUhfAaPcxvDxAJdjMI0qi6w2JqOpXM5v6js+CtyL1tWqOp4aWrWPJMvKV3E3xt4
	OyfmtkBe1BYXzsyjXMMH3MQHI4+ummSFs0YUYIwiON+zh+BRpzei3XhyJtIyhfoIghvVdGFuSOm3Z
	PU5UWy4QR9zZLV9p1P/NVQwQl3FHuKen96NM7vxHTHplbRW9P5Z6ZBGAOJ91fD3xC2uQyM8EvswQQ
	YBSxSm1SaTxAT5FFzr9yrfdZzGUU6Zv8QNTXv4OQbVi/EAoeRxZ32+VV2QDwIyKJ28MoYTT0xqbOD
	o9cTPS6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNwT9-002llH-At; Tue, 16 Aug 2022 13:18:55 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNwQD-002jpC-5g
	for linux-nvme@lists.infradead.org; Tue, 16 Aug 2022 13:15:56 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220816131551euoutp010ded2431d5ae54516daa55c456af3150~L1ZuVnSUk0139901399euoutp01Q
	for <linux-nvme@lists.infradead.org>; Tue, 16 Aug 2022 13:15:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220816131551euoutp010ded2431d5ae54516daa55c456af3150~L1ZuVnSUk0139901399euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1660655751;
	bh=lA4ACIhgPS1mwgZjIDSka7RcIpNQB3Ybt1avCcUQ/Cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fDH38K2GOpbfY5X1mZbPN66TF+MO4Q70j41XtLjvIForjppk7GPpF6aTfBLwqLmJ1
	 IivBhqLpJIsDwa7NrIgmxiI1HDfVACr9zHnGCjgI0Mq3moj0cM7XfejZsSwPTA6bil
	 L7rOZwyMMrJTNw/zXsJYG9CfVx2R1LJCdw3+y7Wc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20220816131549eucas1p17fa1579e347d9cfeef06118a51426172~L1Zsdxeee0548905489eucas1p16;
	Tue, 16 Aug 2022 13:15:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 03.75.09580.5889BF26; Tue, 16
	Aug 2022 14:15:49 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220816131549eucas1p2b7079d3222e2a3313c7bf19c712d6e0e~L1ZsCVUUl3098130981eucas1p2I;
	Tue, 16 Aug 2022 13:15:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220816131549eusmtrp20ef0d99d7fedbc189849e7809c5d583a~L1ZsBcCrj0621306213eusmtrp2c;
	Tue, 16 Aug 2022 13:15:49 +0000 (GMT)
X-AuditID: cbfec7f5-1bfc7a800000256c-f5-62fb98856cc8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 06.31.09038.5889BF26; Tue, 16
	Aug 2022 14:15:49 +0100 (BST)
Received: from localhost (unknown [106.210.248.74]) by eusmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20220816131548eusmtip1614be62435f7387e8d91eace6aacd19c~L1ZrtB0c12694326943eusmtip1D;
	Tue, 16 Aug 2022 13:15:48 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: damien.lemoal@opensource.wdc.com, axboe@kernel.dk, snitzer@kernel.org,
	hch@lst.de, agk@redhat.com
Cc: pankydev8@gmail.com, gost.dev@samsung.com, matias.bjorling@wdc.com,
	hare@suse.de, bvanassche@acm.org, linux-kernel@vger.kernel.org,
	dm-devel@redhat.com, linux-nvme@lists.infradead.org, jaegeuk@kernel.org,
	Johannes.Thumshirn@wdc.com, linux-block@vger.kernel.org, Pankaj Raghav
	<p.raghav@samsung.com>
Subject: [PATCH v11 11/13] dm: call dm_zone_endio after the target endio
 callback for zoned devices
Date: Tue, 16 Aug 2022 15:15:34 +0200
Message-Id: <20220816131536.189406-12-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220816131536.189406-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsWy7djP87qtM34nGcxer2ex/tQxZovVd/vZ
	LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
	/rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
	m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBEcdmkpOZklqUW6dslcGWsPK9a8Ja3
	YtafXvYGxqXcXYycHBICJhIrvz9hAbGFBFYwSiw7ntbFyAVkf2GUmDfrGguE85lR4vDxbmaY
	jkU7NkB1LGeU2HIuE6LoBaNE/4pjrF2MHBxsAloSjZ3sIDUiAukSU1pegg1iFtjGJPHm0gRG
	kISwQKrEsYUnmUDqWQRUJSb2hICEeQWsJRq7FzJB7JKXmHnpO9gcTqD4v4ZVLBA1ghInZ0Jc
	zQxU07x1NjPIfAmB9ZwSd843QzW7SBw+8RDKFpZ4dXwLO4QtI/F/53yoeLXE0xu/oZpbgB7Y
	uZ4N5CAJoG19Z3JATGYBTYn1u/Qhyh0lup6dZISo4JO48VYQ4gQ+iUnbpjNDhHklOtqEIKqV
	JHb+fAK1VELictMcFgjbQ+LwtLdMExgVZyF5ZhaSZ2Yh7F3AyLyKUTy1tDg3PbXYOC+1XK84
	Mbe4NC9dLzk/dxMjMAGe/nf86w7GFa8+6h1iZOJgPMQowcGsJMIr+OJHkhBvSmJlVWpRfnxR
	aU5q8SFGaQ4WJXHe5MwNiUIC6YklqdmpqQWpRTBZJg5OqQYmg43lYqWr/t/dsTW6jjG1TfG+
	bcTBlcabmQUuavncvPqomvuMnG6zuoz+49Wnzx57b/l286yri7wcxdR9/91RPWn3+EXJqsl5
	YpE5mg4XJRjV20tXcDgwzWD/ejUxaUtE94xviZl9l2d5mVzYtc1rV94U3oMaFR3/tDMXzK10
	VVh6Lmvutlt9DIdvXWxL+K7xW4T59c+pwvsXSu21uX/Fk+FhbMvM70vXf7S6fT5dvPb2EfF+
	3lrzt5bBFyY5/r3kPPf2a80lIqZS596fYHHQOv7WOL2tJCbaburkSzzlNk8r3f/ZNs6bFyi1
	7+f701tn7Jh2cv9+HnV7wTlzdP9NY5c9op2kpdT4V1d4uprRdCWW4oxEQy3mouJEAEubS8rv
	AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xu7qtM34nGcw9KGCx/tQxZovVd/vZ
	LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
	/rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
	m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6Rla
	WugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GWsPK9a8Ja3YtafXvYGxqXcXYycHBICJhKL
	dmxg6WLk4hASWMoo8erPVFaIhITE7YVNjBC2sMSfa11sEEXPGCX+b1vP3MXIwcEmoCXR2MkO
	UiMikCuxaFkHK0gNs8ARJokF05czgySEBZIlWvYsAqtnEVCVmNgTAhLmFbCWaOxeyAQxX15i
	5qXvYHM4geL/GlaxgNhCAlYSbccuM0PUC0qcnPkELM4MVN+8dTbzBEaBWUhSs5CkFjAyrWIU
	SS0tzk3PLTbSK07MLS7NS9dLzs/dxAiM123Hfm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeAVf/EgS
	4k1JrKxKLcqPLyrNSS0+xGgKdPZEZinR5HxgwsgriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJI
	TyxJzU5NLUgtgulj4uCUamDSEHjPfFm5rvvMA7+NM780TA/V+izLrL2eRXOj+JLNi5qu5+of
	fBxYrPX1iWjuntp5t5TjEuwPRE3VPVB9UXXKXOW3NzhNv/SwnFEWNhO5vP5X/dn1wqW5ZV8C
	kv59ePlQ/XwJY2KD93/1SQ1c1YXO3V8aug2Sk1h7wpbZT927p+33VoOaz4x758pNiSoMe/J6
	ZcXvdUHvzxaZy3Bf+RvdcWWVyoOgz128WzUl2MtmaV5heJK2eaF6AmtN0Q3zrUwipm4Xznzg
	b32ypMn/enqP8RvduZYrWzyP1sza6MUWWLDpzM17vLb3U7a6sYZacKxjnXB82+PkV2tUgvz4
	/WbMTd4SxcQzw7Ti9a7m/eZKLMUZiYZazEXFiQC25n6hYAMAAA==
X-CMS-MailID: 20220816131549eucas1p2b7079d3222e2a3313c7bf19c712d6e0e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220816131549eucas1p2b7079d3222e2a3313c7bf19c712d6e0e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220816131549eucas1p2b7079d3222e2a3313c7bf19c712d6e0e
References: <20220816131536.189406-1-p.raghav@samsung.com>
	<CGME20220816131549eucas1p2b7079d3222e2a3313c7bf19c712d6e0e@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220816_061553_624193_130ECDE1 
X-CRM114-Status: GOOD (  15.83  )
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

This is a prep patch for the new dm-po2zone target as it modifies
bi_sector in the endio callback.

Call dm_zone_endio for zoned devices after calling the target's endio
function.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/md/dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 60549b65c799..58b392c51d04 100644
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


