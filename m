Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C034C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 11 May 2022 06:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8xiYrko6rIA/t1XZ8brbc5BcZyXVArJHEmfIcGi7GXo=; b=hClU1eqUjL6GI6yYLcd3uwtCfV
	dyn4fEKT0ZAwfdTOHODClnK32Avh/heSSr/WHr7sBkcKjHzz9ftUyxUEIdebUH9tIsko4F+p65z18
	cCW+PMDJxhgD8/3NaUdPA/F3FZO1KWG/LYHTuN82f1fj1o31kP3frIL3NR6RTBQoxmQEzDRGEoxMj
	il1zveEaEbqxI8O8OdC57nqMRKWL6ExHUbddjSt2S8dQRxyn2glyfAOH7V+QX+fU7lEUNsvYCChIv
	59i5pALNAT1fzvVeTxKBMM+6zNLx+od8wUbyb/KtM5mmVC7CgsfJqCTmSH4GAabhiGGm/7jp7xbCJ
	pbvYyAng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nofu1-005SGr-7b; Wed, 11 May 2022 06:32:53 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noft7-005Ria-HO
 for linux-nvme@lists.infradead.org; Wed, 11 May 2022 06:32:02 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20220511063153epoutp02c4456aa9d2d3bb874966d0803ea3b907~t_UUaMoDj1640316403epoutp02O
 for <linux-nvme@lists.infradead.org>; Wed, 11 May 2022 06:31:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20220511063153epoutp02c4456aa9d2d3bb874966d0803ea3b907~t_UUaMoDj1640316403epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1652250713;
 bh=8xiYrko6rIA/t1XZ8brbc5BcZyXVArJHEmfIcGi7GXo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OKZvw5k2MgD0dt07ylW+XkTNE6mH7Yg0JJc/neQGP2KXnrAPArBETof7HFlhRhdh7
 d9kSgOJRNylUu8Q5lHkTgTqxdYwDpPv4y8WPV6C2sPyTYvwCFO3Yh9W7uhUIE3F4nF
 HfBdsQmBLm7/Lvr9Qsc1UOmuhbRCZMTzG5xIZL6I=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTP id
 20220511063152epcas5p1117b324bfab9f8ac49aeb900ae0c9661~t_UT41WE91834918349epcas5p10;
 Wed, 11 May 2022 06:31:52 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4KylS33zsCz4x9QK; Wed, 11 May
 2022 06:31:47 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 8F.86.09827.F485B726; Wed, 11 May 2022 15:31:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20220511055320epcas5p2457aaf8e7405387282f60831f5a4eca9~t9yqoJiH92174421744epcas5p2c;
 Wed, 11 May 2022 05:53:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220511055320epsmtrp28b603b78544cb81e37bf42afd406d4d8~t9yqnGLdN1209712097epsmtrp2D;
 Wed, 11 May 2022 05:53:20 +0000 (GMT)
X-AuditID: b6c32a4a-b51ff70000002663-d6-627b584fd7fb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 59.28.11276.05F4B726; Wed, 11 May 2022 14:53:20 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220511055319epsmtip1931e81a5c413546407ba038c230268c1~t9ypAEq_H2389123891epsmtip1M;
 Wed, 11 May 2022 05:53:19 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 asml.silence@gmail.com, ming.lei@redhat.com, mcgrof@kernel.org, shr@fb.com,
 joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
Subject: [PATCH v5 6/6] io_uring: finish IOPOLL/ioprio prep handler removal
Date: Wed, 11 May 2022 11:17:50 +0530
Message-Id: <20220511054750.20432-7-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511054750.20432-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmuq5/RHWSwfNbxhZNE/4yW8xZtY3R
 YvXdfjaLmwd2MlmsXH2UyeJd6zkWi/NvDzNZzF/2lN3ixoSnjBaHJjczWVx9eYDdgdtjYvM7
 do+ds+6ye1w+W+qxaVUnm8fmJfUeu282sHm833eVzaNvyypGj8+b5AI4o7JtMlITU1KLFFLz
 kvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4COVVIoS8wpBQoFJBYXK+nb
 2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZ7y4uZyx4BxfxdEj
 a1kaGL9ydzFycEgImEi0XBDuYuTiEBLYzSix4mcjWxcjJ5DziVFi5zl1CPsbo8TK+2ogNkj9
 uhst7BANexkl7m7pY4RwPgN1377BCDKVTUBT4sLkUpAGEQF5iS+317KA1DALnGWUmHbrECtI
 QljAW+LHhh/sIDaLgKrEtwdPGUFsXgELiU1PbjNCbJOXmHnpO1gNp4ClxJbN89ghagQlTs58
 wgJiMwPVNG+dzQyyQEJgIYfElMadTBDNLhJ3zrxjhrCFJV4d38IOYUtJfH63lw3CTpZo3X6Z
 HRIUJRJLFqhDhO0lLu75ywQSZgb6Zf0ufYiwrMTUU+uYINbySfT+fgK1iVdixzwYW1Hi3qSn
 rBC2uMTDGUugbA+Jq3NWQcOqh1Fi6eoepgmMCrOQvDMLyTuzEFYvYGRexSiZWlCcm55abFpg
 lJdaDo/i5PzcTYzg1KvltYPx4YMPeocYmTgYDzFKcDArifDu76tIEuJNSaysSi3Kjy8qzUkt
 PsRoCgzvicxSosn5wOSfVxJvaGJpYGJmZmZiaWxmqCTOezp9Q6KQQHpiSWp2ampBahFMHxMH
 p1QDE4fEdB77h0pLw6Lfq86b9DpxT+EJhjs8rwQfbljOeM15yo2SFzfebL57e2rZAsHWyM42
 iS9s2/tskjWDd2nE36mf6FHQeml9tW30xeWnGrfdLTGM3LKtx8tin2fRu0mVNd/n3vjw6L3H
 28SV7adqnfJ0De5pa+g9zNi0P6a4p1f2j0GCQKCrXl3DAxO/P3lWF+9PmRVhV37i3beYxU9V
 7wi1nn1clPDM/tGrE1ILDx69NG9FUOjqNnk1nTm11eknF1Wnz/J/+eSZ0KdAweu+5yrDpTb9
 6P+hfeyg4sTGoPT9Zw/0GR8/4/l2atm+uT7PPJSNY/zSjDVyzX6GOokIBR14+Y+7IvL0wY+Z
 /DqS25RYijMSDbWYi4oTAdIiqUtGBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSnG6Af3WSwbE5hhZNE/4yW8xZtY3R
 YvXdfjaLmwd2MlmsXH2UyeJd6zkWi/NvDzNZzF/2lN3ixoSnjBaHJjczWVx9eYDdgdtjYvM7
 do+ds+6ye1w+W+qxaVUnm8fmJfUeu282sHm833eVzaNvyypGj8+b5AI4o7hsUlJzMstSi/Tt
 ErgyXtxczlhwjq/i6JG1LA2MX7m7GDk5JARMJNbdaGHvYuTiEBLYzSjxZ+N0JoiEuETztR/s
 ELawxMp/z6GKPjJK3P18k62LkYODTUBT4sLkUpAaEQFFiY0fmxhBapgFbjJKPG69xgySEBbw
 lvixAWIQi4CqxLcHTxlBbF4BC4lNT24zQiyQl5h56TtYDaeApcSWzfPAbCGgmqNLJrJB1AtK
 nJz5hAXEZgaqb946m3kCo8AsJKlZSFILGJlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefn
 bmIEx4iW5g7G7as+6B1iZOJgPMQowcGsJMK7v68iSYg3JbGyKrUoP76oNCe1+BCjNAeLkjjv
 ha6T8UIC6YklqdmpqQWpRTBZJg5OqQYmGeH5SfMTDRdvZ33He+nhqudlk9tuXj5orfT17orA
 IvMc08D6Xr6TV9NPazDrP1n+SXWlwuN2w6vtIhs6NaJbF0wuF99R+Gn7469/n4mbmGmvuuEd
 GVvPbHPf//rDwN2mB40XNOx598cn/PmC64Ufw6NOhHzf/ryrj12m+5f9jrvt29Wbo6aLn/l2
 ozIofbvgT/PZB3Zsb+eRuOPw5KhhkqVIwZ9/q2fd2+zywfTOq6y7LGu0sx4eWFW7crGI+Vn5
 WSnh00xvHekUfHdakqGKsWkr/xL9bc25bFp3E80O7FZSe69iX27n/uF0nOWZ4O4N58vyt+kd
 Yp54fgVvfG7T5B3COhOf7be3OvimsK0oXYmlOCPRUIu5qDgRANfl9XEAAwAA
X-CMS-MailID: 20220511055320epcas5p2457aaf8e7405387282f60831f5a4eca9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220511055320epcas5p2457aaf8e7405387282f60831f5a4eca9
References: <20220511054750.20432-1-joshi.k@samsung.com>
 <CGME20220511055320epcas5p2457aaf8e7405387282f60831f5a4eca9@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_233158_017053_F4E357C4 
X-CRM114-Status: GOOD (  15.94  )
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

From: Jens Axboe <axboe@kernel.dk>

Commit 73911426aaaa unified the checking of this, but was done before we
had a few new opcode handlers.

Finish the job and apply it to the xattr/socket/uring_cmd handlers as
well so we check and use this fully consistently.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 592be5b89add..44c57dca358d 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4517,10 +4517,6 @@ static int __io_getxattr_prep(struct io_kiocb *req,
 	const char __user *name;
 	int ret;
 
-	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
-		return -EINVAL;
-	if (unlikely(sqe->ioprio))
-		return -EINVAL;
 	if (unlikely(req->flags & REQ_F_FIXED_FILE))
 		return -EBADF;
 
@@ -4630,10 +4626,6 @@ static int __io_setxattr_prep(struct io_kiocb *req,
 	const char __user *name;
 	int ret;
 
-	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
-		return -EINVAL;
-	if (unlikely(sqe->ioprio))
-		return -EINVAL;
 	if (unlikely(req->flags & REQ_F_FIXED_FILE))
 		return -EBADF;
 
@@ -4968,7 +4960,7 @@ static int io_uring_cmd_prep(struct io_kiocb *req,
 {
 	struct io_uring_cmd *ioucmd = &req->uring_cmd;
 
-	if (sqe->ioprio || sqe->rw_flags)
+	if (sqe->rw_flags)
 		return -EINVAL;
 	ioucmd->cmd = sqe->cmd;
 	ioucmd->cmd_op = READ_ONCE(sqe->cmd_op);
@@ -6405,9 +6397,7 @@ static int io_socket_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_socket *sock = &req->sock;
 
-	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
-		return -EINVAL;
-	if (sqe->ioprio || sqe->addr || sqe->rw_flags || sqe->buf_index)
+	if (sqe->addr || sqe->rw_flags || sqe->buf_index)
 		return -EINVAL;
 
 	sock->domain = READ_ONCE(sqe->fd);
-- 
2.25.1


