Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3595C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 10:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=0pQiRgqgR9+aEEiBeGGauO5uGLC1xxh54Zd+ZA5QK8M=; b=RpoE91lE5wGLkjnjQESVU/8aKF
	qeA0zt5+ymVVB5aD21fF7Omu3Pf1IrlBKcIm4Avw8mktQad+FFV9OuZMIyH6nTf/25gpDRdl0xEeo
	8gQUscKFZ0eeF86yuf1/bku08X8E67bRFqBWXFGnWvt+dbO6rDYDIPU/05B5I7TsFcABGdls8bL2h
	9I07dys+plygp1Wlvzv9q8GVbe/1AZNdtRy1TsH6doxH+7vodLAjYEaoW0qGIL0LXsEz791nP2Mg8
	cF5QWvScOossorhzLJ47qYLZDqx+eiVyHj7quqa9YMPnJouEFwy/SelYwl6hIYqtuHZJt7FPPZd29
	vV2/eocQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrzld-00BrEA-M1; Fri, 20 May 2022 10:21:57 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrzlZ-00BrCy-OI
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 10:21:55 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20220520102149epoutp022e2abf5b4aecd0163fe947cbac359e95~wyQprEqnv1099110991epoutp02C
 for <linux-nvme@lists.infradead.org>; Fri, 20 May 2022 10:21:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20220520102149epoutp022e2abf5b4aecd0163fe947cbac359e95~wyQprEqnv1099110991epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1653042109;
 bh=0pQiRgqgR9+aEEiBeGGauO5uGLC1xxh54Zd+ZA5QK8M=;
 h=From:To:Cc:Subject:Date:References:From;
 b=ZJAKCG07imt6EaZk1z4JWIL5u0wdOrWbR724ydpyXt8OBfaglT6k1anq/Bx/hy2nB
 ZLNHSar+GgQiM2BodeLW65Sp8bNOGSpsftY3RIEAC+O/CEqSSxGeAqngf9C5sBgfWH
 +ma+yVnzwQVRbDPwWFnO2TOw/dMZWJXOLXumSRNQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTP id
 20220520102149epcas5p177dbfa05442a20046fa3b885564db505~wyQpYDImA1893018930epcas5p1_;
 Fri, 20 May 2022 10:21:49 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4L4N7D53g6z4x9Pp; Fri, 20 May
 2022 10:21:44 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 63.6B.10063.4BB67826; Fri, 20 May 2022 19:21:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20220520091211epcas5p3bf0725dce4d84f1fdde8cc4a4050ca37~wxT2Fy4wP0166501665epcas5p33;
 Fri, 20 May 2022 09:12:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220520091211epsmtrp299aedb2bf36fe97a83e02b60357b145f~wxT2E6WZj2958829588epsmtrp2K;
 Fri, 20 May 2022 09:12:11 +0000 (GMT)
X-AuditID: b6c32a49-4cbff7000000274f-02-62876bb45735
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 A0.1F.11276.B6B57826; Fri, 20 May 2022 18:12:11 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220520091210epsmtip185fcded0910013ebde320166108290ab~wxT1HKa_v0837608376epsmtip1W;
 Fri, 20 May 2022 09:12:10 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com, joshiiitr@gmail.com
Subject: [PATCH v3 0/2] uring-passthrough for admin commands
Date: Fri, 20 May 2022 14:36:28 +0530
Message-Id: <20220520090630.70394-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmuu6W7PYkg2k3TSxW3+1ns7h5YCeT
 xcrVR5kszr89zGQx6dA1Rov5y56yO7B57Jx1l93j8tlSj02rOtk8Ni+p99h9s4HNo2/LKsYA
 tqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygK5QU
 yhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BSYFesWJucWleel6eaklVoYGBkamQIUJ
 2Rkrp0cX9LBXXGy5xNLAeIq1i5GTQ0LAROLjnJnMXYxcHEICuxkl/vRcYoNwPjFKdF1YygJS
 JSTwjVHi/oIwmI4HXa3sEPG9jBJP+0IgGj4zSjya+Yupi5GDg01AU+LC5FKQGhEBI4n9n06C
 bWMW8Je4sn4fO0iJsICNxKFPViBhFgFVieV/dzKB2LwCFhKHb55kg1glLzHz0nd2iLigxMmZ
 T1ggxshLNG+dDXa0hMApdomPLa0sIDMlBFwkpr3Nh+gVlnh1fAs7hC0l8fndXqiZyRKt2y+z
 Q5SXSCxZoA4Rtpe4uOcv2PHMQMev36UPEZaVmHpqHRPEVj6J3t9PmCDivBI75sHYihL3Jj2F
 Bqe4xMMZS6BsD4l/+1pZIQEVK3Ho4V7WCYzys5A8MwvJM7MQNi9gZF7FKJlaUJybnlpsWmCY
 l1oOj9Lk/NxNjOBkqOW5g/Hugw96hxiZOBgPMUpwMCuJ8DLmtiQJ8aYkVlalFuXHF5XmpBYf
 YjQFhvBEZinR5HxgOs4riTc0sTQwMTMzM7E0NjNUEucV+N+YJCSQnliSmp2aWpBaBNPHxMEp
 1cBk5vG1/ZD2rhnP9RhOFm+5WvpqAXeuAPsnM+M5B/Z2z2C2P/4nfqFFvJSkXuHORxcv6jA+
 6VNTzwzTdOGwEfSe/fWCb+z62StmtHYeM79h/4PJ8ypPWfIWsYLpZ7RMf5i6zu0Rj7qmxXbY
 /3bonA3nP92rO768l3d2+iojHs7Gn2UM996f7bT51Dkj9xbrxvxTspp/Uh9YaDXperg/+Rvz
 7bzMRJ6jItwibrE9T0+uEFQqTeY6ODXLv/CAyrVFzkvnV600mszRwl2+Yfab19Kru/OF+TOV
 qrK26B3Ke8bxKUr1qJY9e/Oz6frbb62Q6Fjw4yVb1IxbK2yUeJxe/eGYmTY3r2nq27pNcza9
 neGnxFKckWioxVxUnAgA0BJcCQ8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSnG52dHuSwcsPPBar7/azWdw8sJPJ
 YuXqo0wW598eZrKYdOgao8X8ZU/ZHdg8ds66y+5x+Wypx6ZVnWwem5fUe+y+2cDm0bdlFWMA
 WxSXTUpqTmZZapG+XQJXxsrp0QU97BUXWy6xNDCeYu1i5OSQEDCReNDVyt7FyMUhJLCbUeLa
 8U9sEAlxieZrP9ghbGGJlf+eQxV9ZJRYt+wMUBEHB5uApsSFyaUgNSICZhJLD69hAbGZBQIl
 unvus4CUCAvYSBz6ZAUSZhFQlVj+dycTiM0rYCFx+OZJqFXyEjMvfWeHiAtKnJz5BGqMvETz
 1tnMExj5ZiFJzUKSWsDItIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzg8tTR3MG5f
 9UHvECMTB+MhRgkOZiURXsbcliQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRm
 p6YWpBbBZJk4OKUamLYwxVaurUh8uIDtywfRxy+/RekJdu008zmjyyC1a7HY3g8vdzueCAif
 /aT5w9ejJ6Ltyy9xvfq68cgatos/xAXz7919Ib9foqpG8sG2uqm8X4O5uv2ez+x33W50+pEh
 99lc6z2vlh7fbqCRaesncnJfW1vBhztnr5w+pXr0bvLidYv188+3dqxIOhRdF2sZkLJrvZ7m
 5fmT+LOzfOtcGdWt7voVMN3VLtF+KjexIHP9x/Bpy2ZN5eJyspxy+XiR0paCd7fSzh+3YrgQ
 P3/jt8NKsxPaH1187v29e/nlP2cu/9j+Jtp5zqL02qdGBs5Fjv3qF290tHaskZmf2RCYX3Hu
 tsONXq1dGrO//fr9Q+OUEktxRqKhFnNRcSIAblL2Pb4CAAA=
X-CMS-MailID: 20220520091211epcas5p3bf0725dce4d84f1fdde8cc4a4050ca37
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220520091211epcas5p3bf0725dce4d84f1fdde8cc4a4050ca37
References: <CGME20220520091211epcas5p3bf0725dce4d84f1fdde8cc4a4050ca37@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220520_032154_467619_5D7B46A4 
X-CRM114-Status: GOOD (  13.09  )
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

Hi Jens,

The series enables uring-passthrough for admin-commands.
Please see if this can go in.

Patch 1 is prep.
Patch 2 adds new opcodes for admin uring-passthrough, and enables it on
nvme controller dev(/dev/nvmeX).It reuses the code of io-command
passthrough, with the only difference that commands are issued on admin
queue.

Changes since v2:
- add vectored variant too
- apply reviewed-by tag

Changes since v1:
- drop the code that supports this op over ns char device
- apply reviewed-by tag

Kanchan Joshi (2):
  nvme: helper for uring-passthrough checks
  nvme: enable uring-passthrough for admin commands

 drivers/nvme/host/core.c        |  1 +
 drivers/nvme/host/ioctl.c       | 47 +++++++++++++++++++++++++++------
 drivers/nvme/host/nvme.h        |  1 +
 include/uapi/linux/nvme_ioctl.h |  2 ++
 4 files changed, 43 insertions(+), 8 deletions(-)

-- 
2.25.1


