Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511E9D44D75
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 14:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z41P+Tw8TmI51MCW7/+1acKX4G7SIcvf+xBvm2RWHlk=; b=U23REkh4XJkpofAEiFAwyyfnby
	P9EYaWxTlvEwXV3SpByew/pmy/Eg/LZ8n4M5883LTPeHXcWdtfZ8CpfVd4eXWRVf/nB3FqNMpWfNQ
	eB0HgisOn+dc7BxwFA99Tyf2+o4t64/E3vvP4UPFTICankZ2w7OeWY4SgaeL8YiyuJofO7ocE6+1S
	a3ktowKbinyIN8tJT7ySdcbiffExdKQVghRRCoRfkt9yo0cjPxeKNzk19vwLE0uE86mCizSK0W/n/
	WziIordCD/hWwMVyHYdmrpekqY+g9RBue5aVtjcPsZZVB4h8MXNyVihw7NltLBnvrRkV4NL6g6mCZ
	PRMYGsHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8h6K-00000003dzN-0tcH;
	Wed, 06 Nov 2024 14:33:40 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8h2L-00000003cBa-2ZEc
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 14:29:36 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241106142931epoutp03f97a1dc5c97994f13460a5452bf797ec~FZ3H8l04l2108421084epoutp03p
	for <linux-nvme@lists.infradead.org>; Wed,  6 Nov 2024 14:29:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241106142931epoutp03f97a1dc5c97994f13460a5452bf797ec~FZ3H8l04l2108421084epoutp03p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730903371;
	bh=Z41P+Tw8TmI51MCW7/+1acKX4G7SIcvf+xBvm2RWHlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uwV+EPz9lMUKrpbgertevat9Q++ydKf3GukrbWcimb1rBY8GEXSXqsZSnf5EA6DvK
	 oKGexyo+fnsZcIMmfmfa/pcCgh+sWbYEedSWolWJThqBDKQmV4/ERhVaocWtcae6//
	 oA3a9Yz1R1BHk/SDjXm2mAeialMAdYNQowlsRBoY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241106142930epcas5p2dd9b01b267bd6084c28270f3401b3601~FZ3Hfu1Zv0777107771epcas5p2c;
	Wed,  6 Nov 2024 14:29:30 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Xk6zD5rN7z4x9Px; Wed,  6 Nov
	2024 14:29:28 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2C.E2.09800.84D7B276; Wed,  6 Nov 2024 23:29:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20241106122715epcas5p1ccc25dc0bbfae6db881fecb6bd00d5e0~FYMYmh6mZ1859418594epcas5p1U;
	Wed,  6 Nov 2024 12:27:15 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241106122715epsmtrp2700194294705744c4474f89630fe94f7~FYMYltGYz2560925609epsmtrp2g;
	Wed,  6 Nov 2024 12:27:15 +0000 (GMT)
X-AuditID: b6c32a4b-4a7fa70000002648-68-672b7d4826bb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	89.23.08227.3A06B276; Wed,  6 Nov 2024 21:27:15 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241106122713epsmtip1504a45f8be2e394b46a5894582a9adb7~FYMWCOyXs0829608296epsmtip1C;
	Wed,  6 Nov 2024 12:27:13 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>, Anuj
	Gupta <anuj20.g@samsung.com>
Subject: [PATCH v8 08/10] nvme: add support for passing on the application
 tag
Date: Wed,  6 Nov 2024 17:48:40 +0530
Message-Id: <20241106121842.5004-9-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241106121842.5004-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHJsWRmVeSWpSXmKPExsWy7bCmhq5HrXa6Qdt0TYuPX3+zWDRN+Mts
	MWfVNkaL1Xf72SxeH/7EaHHzwE4mi5WrjzJZvGs9x2Ixe3ozk8XR/2/ZLCYdusZosfeWtsWe
	vSdZLOYve8pu0X19B5vF8uP/mCzO/z3OanF+1hx2ByGPnbPusntcPlvqsWlVJ5vH5iX1Hrtv
	NrB5fHx6i8Wjb8sqRo8zC46we3zeJOex6clbpgCuqGybjNTElNQihdS85PyUzLx0WyXv4Hjn
	eFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKCflBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2
	SqkFKTkFJgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGY1z+tgKtnBXLFo0gamB8ShnFyMHh4SA
	icTJI1ZdjJwcQgK7GSXefAvrYuQCsj8xSrw694sZwvnGKHF56m5GkCqQhs5ZvawQib2MEtcW
	f2OHcD4zSmxuW8AGUsUmoC5x5HkrI0hCRGAPo0TvwtMsIA6zwAQmiQXTtzCDVAkLBEhcOLWS
	FcRmEVCVuNrzACzOK2Ah8aflGAvEPnmJmZe+s4PYnAKWEmc/b2OEqBGUODnzCVgNM1BN89bZ
	YMdKCFzhkGh5u4gNotlFYvbJZVCDhCVeHd/CDmFLSXx+txeqJl3ix+WnTBB2gUTzsX1Qj9pL
	tJ7qZwaFErOApsT6XfoQYVmJqafWMUHs5ZPo/f0EqpVXYsc8GFtJon3lHChbQmLvuQYo20Pi
	ycsb0EDtAQZq30WWCYwKs5D8MwvJP7MQVi9gZF7FKJlaUJybnlpsWmCcl1oOj+bk/NxNjOCE
	ruW9g/HRgw96hxiZOBgPMUpwMCuJ8PpHaacL8aYkVlalFuXHF5XmpBYfYjQFBvhEZinR5Hxg
	TskriTc0sTQwMTMzM7E0NjNUEud93To3RUggPbEkNTs1tSC1CKaPiYNTqoFp56IlYi6Lq7jv
	OOuc+HIvirVmokKkyZwVTDYVivfuGXbKRLj0L+1Z/5KXX/Ti4efnWY9OXh2vp/Wk0v3723r/
	jFVL9h4y+sT66EJU9wt30+41slGLN/u2PC7t3s81eeZrpo9aLoISf1gTw1oKpG7dFLxhIHdC
	8hzv3H2Tbq5vvbSqO6vi0/OgsgX6NxiMj3/mMOQt71DfrqEl/aGeTz+CJ0p6qvTj88rc/n+V
	37s2MTbJ3WMI189jPD1JicPvzLS/0mk2hUstl75okp4Uv+370p6va/JXhy7ZtUE0VfbOl5OK
	z15uFOS53aKce+ehKMfL66VTyh6kTVX5bMi/Jal3CVdN6V9NzhsFSzXE/rAqsRRnJBpqMRcV
	JwIAse/fPXEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsWy7bCSnO7iBO10g717DS0+fv3NYtE04S+z
	xZxV2xgtVt/tZ7N4ffgTo8XNAzuZLFauPspk8a71HIvF7OnNTBZH/79ls5h06Bqjxd5b2hZ7
	9p5ksZi/7Cm7Rff1HWwWy4//Y7I4//c4q8X5WXPYHYQ8ds66y+5x+Wypx6ZVnWwem5fUe+y+
	2cDm8fHpLRaPvi2rGD3OLDjC7vF5k5zHpidvmQK4orhsUlJzMstSi/TtErgyGuf0sRVs4a5Y
	tGgCUwPjUc4uRk4OCQETic5ZvaxdjFwcQgK7GSXuTpnNDJGQkDj1chkjhC0ssfLfc3aIoo+M
	En0Xf4Il2ATUJY48bwWzRQROMErMn+gGUsQsMINJ4vefBSwgCWEBP4k755+ygdgsAqoSV3se
	gG3gFbCQ+NNyjAVig7zEzEvf2UFsTgFLibOft4ENFQKpWdAHVS8ocXLmE7B6ZqD65q2zmScw
	CsxCkpqFJLWAkWkVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZwzGlp7WDcs+qD3iFG
	Jg7GQ4wSHMxKIrz+UdrpQrwpiZVVqUX58UWlOanFhxilOViUxHm/ve5NERJITyxJzU5NLUgt
	gskycXBKNTCVNETMalH11WiS3+J6Wqjv5gaLn692CT7dK+9utdyDY6+rQcnKBVd+q5U8dJby
	btRy2Z+nx/Y5kG3DKSavlu6074vVvI7tNd9kErbUv8aGcWbfVl2+OqUrGr+6vulf5ejnD4zQ
	LPD0i3CWMBCS5by266RsePXx501n5E5GL76ccFXdx8Z0geOy30LxhfyfL99clhi67ZqN3QeN
	xHNBQnO3bfnQfm4+o9nyx8dfzz//v/Xc4/qatPqezXEC2YqOT0uqSqX6FjsrvVZdbrLyM5//
	wnaPXj3HrIBnXaFyC/9sv5Zazv8vkqfr6KlzlnUHBK1/6nBpNTqa+yxT2mIzedvr9U/c5q10
	mMi6ZOmJd0osxRmJhlrMRcWJANbZOvMoAwAA
X-CMS-MailID: 20241106122715epcas5p1ccc25dc0bbfae6db881fecb6bd00d5e0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241106122715epcas5p1ccc25dc0bbfae6db881fecb6bd00d5e0
References: <20241106121842.5004-1-anuj20.g@samsung.com>
	<CGME20241106122715epcas5p1ccc25dc0bbfae6db881fecb6bd00d5e0@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241106_062934_081279_BEFC1703 
X-CRM114-Status: GOOD (  16.54  )
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

From: Kanchan Joshi <joshi.k@samsung.com>

With user integrity buffer, there is a way to specify the app_tag.
Set the corresponding protocol specific flags and send the app_tag down.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f1d1b243d8bc..dac2678cad96 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -883,6 +883,12 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	return BLK_STS_OK;
 }
 
+static void nvme_set_app_tag(struct request *req, struct nvme_command *cmnd)
+{
+	cmnd->rw.lbat = cpu_to_le16(bio_integrity(req->bio)->app_tag);
+	cmnd->rw.lbatm = cpu_to_le16(0xffff);
+}
+
 static void nvme_set_ref_tag(struct nvme_ns *ns, struct nvme_command *cmnd,
 			      struct request *req)
 {
@@ -1023,6 +1029,10 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 				control |= NVME_RW_APPEND_PIREMAP;
 			nvme_set_ref_tag(ns, cmnd, req);
 		}
+		if (bio_integrity_flagged(req->bio, BIP_CHECK_APPTAG)) {
+			control |= NVME_RW_PRINFO_PRCHK_APP;
+			nvme_set_app_tag(req, cmnd);
+		}
 	}
 
 	cmnd->rw.control = cpu_to_le16(control);
-- 
2.25.1


