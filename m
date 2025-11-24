Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1AFCFD317
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 02:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7wt4l3Vmobq4GuuMyFPJBgrWPvgmrjYhaZwLaOIoKCQ=; b=CrAQhICowYlYyhtnwlQOrSL3dW
	i2wiGpW6cj9+JUqXvK3mhkVEinhl0iwAdKNhs2dfLyuC9UXpQiYIr4AAhhSEfg1SrajHW0SNBq2Jm
	i3kMP61IqwigR4+9+V5tSWbmPH1C9983Q5rXaIJ4XW1oJJxgm/EVjvaK9RNellwgsGl/0j2boI6my
	y2xh1k3u7EpwCrxFyCSjZWOjURgb4kFkEvX4ISg7eh14GTrtWKcWw72MopDUL5dHAKRNEUJcXJGRc
	5DPp4vHPcZ47Qntz0oDsa/d8FUURtk2lMZUv+sD5TRK+obLt3qaU1pF+YsjV5X4O0BM5BVKxakC3H
	28z2Wb5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNMm3-0000000B02X-2sxL;
	Mon, 24 Nov 2025 02:57:55 +0000
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNMlz-0000000Azyp-097X
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 02:57:53 +0000
Received: by mail-dl1-x122b.google.com with SMTP id a92af1059eb24-11b6bc976d6so4809648c88.0
        for <linux-nvme@lists.infradead.org>; Sun, 23 Nov 2025 18:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763953070; x=1764557870; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wt4l3Vmobq4GuuMyFPJBgrWPvgmrjYhaZwLaOIoKCQ=;
        b=fwtwAn88nYnwFG+Je5/hJS73y0mffBkWPiqyfUvEeNKs86g2mn3gCigD30bCui0Mys
         P7Kd1OR7zPXoaUPRR1QqLa7FX4G3y3Gr+369poN2JzXNwDyyAYnacwbuP1BzwPgHBwwp
         8Y0hX7VU8Q7U8LvJ1oMBMhKf0PN2mVzhcz+AqGvosiPkxwfUOHGpjIXDM1C2OyuuZtqQ
         leFWx8ErTeyGXdwLfbJRr2ekKjoiQVPezjiWY/h5Gz3DkyDF9nzmQ/I4bjlCNlit0URs
         VWfqDtSI6pFu6eL1QQ+WzxpRKMOgZpCZl9CAXtsyHgh6HWeIOIqsy6gVn2YGmDfBl9o6
         bMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763953070; x=1764557870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7wt4l3Vmobq4GuuMyFPJBgrWPvgmrjYhaZwLaOIoKCQ=;
        b=LQFtLczx3Dwjum5dGvslCQFZnMgBDLKaZS+wI81p5aJDTuU5LkTpv2GnO153mURxPx
         2BDhypmzmw49rwr5INM6XvC2788eXzpq6o4KsdiefSt9dX4/AmHvQWutC+MMQZkPW1jX
         ENrk6jl0evmidWtd61n47dpT332zBt4sk6h/Mtljz0opt1wWEUgOZgaQXwbH0uL9qHdn
         5/ovGvrlzsRWtwGg77vs6Cmk/9+92+IJWWSgJEDo5cH1nfyUfaPVuyTrk1hB+RQ3qjuL
         uObsg3AsqMHySTuOOZNq/lUb3Na9VIk1MDzSAbE9Iq+EcUF/5u0BUE6g4jUweQKtuMYP
         SPhg==
X-Forwarded-Encrypted: i=1; AJvYcCWXy0g3karqf2n+Za/4gMI5GRNnx8CsPuQpfMQXOzij07/YfaITM3iZafnShDRVZDOk4EzPbzq7KvS6@lists.infradead.org
X-Gm-Message-State: AOJu0YxEeAMN2xfgSvfJ2KmMpBXb09qLoaB66t8ftyf1Wk1h2IlD846I
	5Y9inFh37rfUj1thMrNfWMAjmWOv4FSLhdUE/vQ9U2yEYPFYu1vDAag/
X-Gm-Gg: ASbGncs8+64DVr0JFAxX/a/6jIUSjXmzEjj9JiYDzxw1oyrkRZTwbyeNaXwKwmdWYjC
	Ew9hBUEiL572IDzZlLzmDYVLHwbfpJuP4MSdsqaOjYktLeeo+xGKwjgN8o+w/r5M7JcU+Ds2yC2
	v9k8/K4DNc0ePWaN9zDM61ShhBWm2tTnZ6CAj6DPmrxf5VFoK7SwTEry5kgoAziPMuoMffazQpE
	u2agF3Fzc0epjhMWc3AxjYc9Qwaw4KUYdrUgX4aSzQc/INPFk22CTuS50mlzdkPFmwm4+VraMmp
	eP9mBAHLNPc39RNj5AN3YHRcUcY7y94cmVvGNrMVJYbyzdU23wxU6dUVv/IZzwgZf7whuouQc/U
	BTSCoC4VKyS1yhYLQ92vZSJM/9oCfNGI/OX8ANXnyrcp6QdVf7AiAXHayZxPjrkAoPH63Y/DoOD
	QUOrPHQUdMIhWgr16XFCe5CcXZRflfUj/8IQWpIuWRNNTdavJiAUFT74b5Fw==
X-Google-Smtp-Source: AGHT+IFpsDs+kXmQXVU6E1/nGle2v7URUru8XFd/49TW2BQ+0epIeeb7LYLuuNciA5YRvlLXxX79hA==
X-Received: by 2002:a05:7022:3d0e:b0:11b:3eb7:f9d7 with SMTP id a92af1059eb24-11c94b601c2mr7020409c88.14.1763953070114;
        Sun, 23 Nov 2025 18:57:50 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e6da4dsm58917652c88.9.2025.11.23.18.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 18:57:49 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: axboe@kernel.dk,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	yukuai@fnnas.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	jaegeuk@kernel.org,
	chao@kernel.org,
	cem@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-xfs@vger.kernel.org,
	bpf@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH V2 5/5] xfs: ignore discard return value
Date: Sun, 23 Nov 2025 18:57:37 -0800
Message-Id: <20251124025737.203571-6-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20251124025737.203571-1-ckulkarnilinux@gmail.com>
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_185752_399935_121EC4B5 
X-CRM114-Status: GOOD (  13.94  )
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

__blkdev_issue_discard() always returns 0, making all error checking
in XFS discard functions dead code.

Change xfs_discard_extents() return type to void, remove error variable,
error checking, and error logging for the __blkdev_issue_discard() call
in same function.

Update xfs_trim_perag_extents() and xfs_trim_rtgroup_extents() to
ignore the xfs_discard_extents() return value and error checking
code.

Update xfs_discard_rtdev_extents() to ignore __blkdev_issue_discard()
return value and error checking code.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 fs/xfs/xfs_discard.c | 27 +++++----------------------
 fs/xfs/xfs_discard.h |  2 +-
 2 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
index 6917de832191..b6ffe4807a11 100644
--- a/fs/xfs/xfs_discard.c
+++ b/fs/xfs/xfs_discard.c
@@ -108,7 +108,7 @@ xfs_discard_endio(
  * list. We plug and chain the bios so that we only need a single completion
  * call to clear all the busy extents once the discards are complete.
  */
-int
+void
 xfs_discard_extents(
 	struct xfs_mount	*mp,
 	struct xfs_busy_extents	*extents)
@@ -116,7 +116,6 @@ xfs_discard_extents(
 	struct xfs_extent_busy	*busyp;
 	struct bio		*bio = NULL;
 	struct blk_plug		plug;
-	int			error = 0;
 
 	blk_start_plug(&plug);
 	list_for_each_entry(busyp, &extents->extent_list, list) {
@@ -126,18 +125,10 @@ xfs_discard_extents(
 
 		trace_xfs_discard_extent(xg, busyp->bno, busyp->length);
 
-		error = __blkdev_issue_discard(btp->bt_bdev,
+		__blkdev_issue_discard(btp->bt_bdev,
 				xfs_gbno_to_daddr(xg, busyp->bno),
 				XFS_FSB_TO_BB(mp, busyp->length),
 				GFP_KERNEL, &bio);
-		if (error && error != -EOPNOTSUPP) {
-			xfs_info(mp,
-	 "discard failed for extent [0x%llx,%u], error %d",
-				 (unsigned long long)busyp->bno,
-				 busyp->length,
-				 error);
-			break;
-		}
 	}
 
 	if (bio) {
@@ -148,8 +139,6 @@ xfs_discard_extents(
 		xfs_discard_endio_work(&extents->endio_work);
 	}
 	blk_finish_plug(&plug);
-
-	return error;
 }
 
 /*
@@ -385,9 +374,7 @@ xfs_trim_perag_extents(
 		 * list  after this function call, as it may have been freed by
 		 * the time control returns to us.
 		 */
-		error = xfs_discard_extents(pag_mount(pag), extents);
-		if (error)
-			break;
+		xfs_discard_extents(pag_mount(pag), extents);
 
 		if (xfs_trim_should_stop())
 			break;
@@ -496,12 +483,10 @@ xfs_discard_rtdev_extents(
 
 		trace_xfs_discard_rtextent(mp, busyp->bno, busyp->length);
 
-		error = __blkdev_issue_discard(bdev,
+		__blkdev_issue_discard(bdev,
 				xfs_rtb_to_daddr(mp, busyp->bno),
 				XFS_FSB_TO_BB(mp, busyp->length),
 				GFP_NOFS, &bio);
-		if (error)
-			break;
 	}
 	xfs_discard_free_rtdev_extents(tr);
 
@@ -741,9 +726,7 @@ xfs_trim_rtgroup_extents(
 		 * list  after this function call, as it may have been freed by
 		 * the time control returns to us.
 		 */
-		error = xfs_discard_extents(rtg_mount(rtg), tr.extents);
-		if (error)
-			break;
+		xfs_discard_extents(rtg_mount(rtg), tr.extents);
 
 		low = tr.restart_rtx;
 	} while (!xfs_trim_should_stop() && low <= high);
diff --git a/fs/xfs/xfs_discard.h b/fs/xfs/xfs_discard.h
index 2b1a85223a56..8c5cc4af6a07 100644
--- a/fs/xfs/xfs_discard.h
+++ b/fs/xfs/xfs_discard.h
@@ -6,7 +6,7 @@ struct fstrim_range;
 struct xfs_mount;
 struct xfs_busy_extents;
 
-int xfs_discard_extents(struct xfs_mount *mp, struct xfs_busy_extents *busy);
+void xfs_discard_extents(struct xfs_mount *mp, struct xfs_busy_extents *busy);
 int xfs_ioc_trim(struct xfs_mount *mp, struct fstrim_range __user *fstrim);
 
 #endif /* XFS_DISCARD_H */
-- 
2.40.0


