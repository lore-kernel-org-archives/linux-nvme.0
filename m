Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C52C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Apr 2022 14:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=nSmbBxBfN8BTVVKIfY7Z2v94wVQbbOI4IOoj9oWEch4=; b=scaqPrLvDsTFE2k3v1r77yPTOO
	SBRUaU55Id0l29rTSlkvYg1gXB2O2BH4jR9gMZ1kgItUrF6pOEWNUnhrxMA7ARf+uOiaOiu9bKr9Z
	lxiEoLb9F8YbMEObrp1Xb/pmhGeTRBmF0RDm+BF1oFmdQd84Yyuh9Uk7P5rXc38htx/47ykVqQLN8
	LfCM29xRqN8bxtKHGbxcKtq7KVn5633UGIJ4eGwjQLKpu0ibRkkObDxaAMsI+G158rXSOmCQqFvny
	nfE6XdzEdgz14IEMKZK8dG/RHeMOICr0tc6KkSqojHcxdygCEnLOwksdMWf2tNn2qK7LR1UE527PH
	+CpE/i2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1naHzI-005ueU-UE; Fri, 01 Apr 2022 14:10:52 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1naHz4-005uXl-6N
 for linux-nvme@lists.infradead.org; Fri, 01 Apr 2022 14:10:41 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20220401141025epoutp02e644e127aeb63a0a9ebead0c815e28f0~hyxQd-ZEO1714417144epoutp02j
 for <linux-nvme@lists.infradead.org>; Fri,  1 Apr 2022 14:10:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20220401141025epoutp02e644e127aeb63a0a9ebead0c815e28f0~hyxQd-ZEO1714417144epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1648822225;
 bh=nSmbBxBfN8BTVVKIfY7Z2v94wVQbbOI4IOoj9oWEch4=;
 h=From:To:Cc:Subject:Date:References:From;
 b=IJ4Fv1PMwIAhzVLwNaluNG5bzzN2xUsT5zoqVJKaaOuXlFTWQ/rt1muagcUh1cloH
 Tta4MTdg7kz6HkF/1axR5hQNah7lgKdyzTpjOwXGmHiSw/QVIltCVOve9UdxWJE7h0
 7byg4SLauqwnZhf/SDOYgomKgha8a74vXA7R2ZSk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTP id
 20220401141025epcas5p1ef7da88b4e30f563b3ab5dd0bbdf4272~hyxP0UhD32244722447epcas5p17;
 Fri,  1 Apr 2022 14:10:25 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4KVMWc6v5vz4x9Pp; Fri,  1 Apr
 2022 14:10:20 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 35.82.06423.CC707426; Fri,  1 Apr 2022 23:10:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20220401110829epcas5p39f3cf4d3f6eb8a5c59794787a2b72b15~hwSZjUvnx2406524065epcas5p3E;
 Fri,  1 Apr 2022 11:08:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220401110829epsmtrp2382ac90b1534b9d94b1c0c2ab0bf3c52~hwSZihUxz2799827998epsmtrp2i;
 Fri,  1 Apr 2022 11:08:29 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-c5-624707cceaab
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 B0.63.24342.D2DD6426; Fri,  1 Apr 2022 20:08:29 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220401110827epsmtip115d20d172cfc33bafe4a43a71f6537b2~hwSX6X6Is2320023200epsmtip1P;
 Fri,  1 Apr 2022 11:08:27 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 asml.silence@gmail.com, ming.lei@redhat.com, mcgrof@kernel.org,
 pankydev8@gmail.com, javier@javigon.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com
Subject: [RFC 0/5] big-cqe based uring-passthru
Date: Fri,  1 Apr 2022 16:33:05 +0530
Message-Id: <20220401110310.611869-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmhu4Zdvckg707TC2aJvxltpizahuj
 xeq7/WwWK1cfZbJ413qOxaLz9AUmi/NvDzNZzF/2lN3ixoSnjBaHJjczWay5+ZTFgdtj56y7
 7B7NC+6weFw+W+qxaVUnm8fmJfUeu282sHm833eVzaNvyypGj8+b5AI4o7JtMlITU1KLFFLz
 kvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4COVVIoS8wpBQoFJBYXK+nb
 2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZ0xobmIquMlV0Xt7
 O1sD416OLkZODgkBE4m5M/+wdzFycQgJ7GaUaDj8lQ3C+cQosf/VeijnG6NE36VPjDAtvyc/
 h0rsZZTYfn8nI4TzmVFiyYLVQMM4ONgENCUuTC4FaRARkJf4cnstC0gNs8A1RonHrw6xgSSE
 BfQlbr2bDjaVRUBV4sCe5ywgNq+ApcShWYtYILbJS8y89J0dIi4ocXLmE7A4M1C8eetsZoia
 Tg6J37PFIGwXifU7JrNB2MISr45vYYewpSQ+v9sLFU+WaN1+GexOCYESoJvVIcL2Ehf3/GUC
 CTMDnb9+lz5EWFZi6ql1TBBb+SR6fz9hgojzSuyYB2MrStyb9JQVwhaXeDhjCZTtIdE3ZSHY
 h0ICsRLvJl9insAoPwvJM7OQPDMLYfMCRuZVjJKpBcW56anFpgWGeanl8HhNzs/dxAhOslqe
 OxjvPvigd4iRiYPxEKMEB7OSCO/VWNckId6UxMqq1KL8+KLSnNTiQ4ymwBCeyCwlmpwPTPN5
 JfGGJpYGJmZmZiaWxmaGSuK8p9M3JAoJpCeWpGanphakFsH0MXFwSjUw2UvX5lS5/6m2XDA/
 5Pzcl48YPbhuLhGzuJa5asUL3VvLs8q9VCWex9286ivXumt+s9/C4/b/11kG7PnT2ZC9TE/I
 SvJ20fOY+U4dJwSSGEvs1BTO7M//uTOR5YZubIuwR975ORuU5xtntTzImaJYbr8+7ukHqyVx
 bHKPPD7tk3wROj1T2SL++fE81vQFDbklsQZtZ445vvv93nDVrC/bubQTxW/9bTy23yHGq+79
 4Wb/ZbftrpkUfCyIuXbIK8ri1T1No+Rr3yed2CGSXGxtukrfftKGJ7Xn1u7f3M6nWrkr7cqq
 VZr6YXKF16YqHnD4vbpBMSDI7bzY8YcZ/x5ezzqw5uZCpnqe6d/e7ovbpcRSnJFoqMVcVJwI
 AEHx4GQ7BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWy7bCSnK7uXbckgz0XWC2aJvxltpizahuj
 xeq7/WwWK1cfZbJ413qOxaLz9AUmi/NvDzNZzF/2lN3ixoSnjBaHJjczWay5+ZTFgdtj56y7
 7B7NC+6weFw+W+qxaVUnm8fmJfUeu282sHm833eVzaNvyypGj8+b5AI4o7hsUlJzMstSi/Tt
 ErgyJjQ3MRXc5Krovb2drYFxL0cXIyeHhICJxO/Jz9m6GLk4hAR2M0ocn9rFBJEQl2i+9oMd
 whaWWPnvOZgtJPCRUeLeA6BmDg42AU2JC5NLQcIiAooSGz82MYLMYRZ4wChxf/pvNpCEsIC+
 xK130xlBbBYBVYkDe56zgNi8ApYSh2YtYoGYLy8x89J3doi4oMTJmU/A4sxA8eats5knMPLN
 QpKahSS1gJFpFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcMBrae5g3L7qg94hRiYO
 xkOMEhzMSiK8V2Ndk4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgST
 ZeLglGpgOih5zXRqk84nLo2ort9LpEz7hYsKqj5a/F/+zoNZdc90Bo2AWR1ndnrfEdrYYic6
 Uabw3crY/B/3pmzwmK++T2vNN98llivbqhoXeanJ1lqEVv/a1z97SkVNaveBGQ87tSczvTX8
 mX749ZQ47bwAs9QvDmKezzqEFn1etmsNM/fy34ZrJp10F351Ie9P9ooHVbZlSw5IF2iJTw/5
 fWFKmHHFOc2pS1qy3b3ei3r83ngs1PU/X+avhQpfFR7IH7OUdJ13xczX70jSqlN7/htf+vBu
 JrfXzz/v5z+6bR367837Vslnc/TNYrsDjBn3TPn+p1RXapHD4pa/l86wpk50379aN7QoweeC
 1JyqA3Gej5VYijMSDbWYi4oTAaxMJvrnAgAA
X-CMS-MailID: 20220401110829epcas5p39f3cf4d3f6eb8a5c59794787a2b72b15
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220401110829epcas5p39f3cf4d3f6eb8a5c59794787a2b72b15
References: <CGME20220401110829epcas5p39f3cf4d3f6eb8a5c59794787a2b72b15@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220401_071038_653605_467CF6C7 
X-CRM114-Status: GOOD (  12.18  )
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

So this is a trimmed-down series primarily to test the
waters with 32-byte CQE (patch 4).
This big-cqe is created by combining two adjacent 16b CQEs.
And that is done when ring is setup with IORING_SETUP_CQE32 flag.

nvme-passthru sends one result to bigcqe->res and another result (8 bytes)
gets updated to bigcqe->res2.
As always, fio is modified to test the interface:
https://github.com/joshkan/fio/tree/big-cqe

Limited testing ATM, as plumbing itself is in early stage with patch 4.
Patches are against for-next (linux-block),
on top of 9e9d83faa ("io_uring: Remove unneeded test in io_run_task_work_sig")

Jens Axboe (3):
  io_uring: add support for 128-byte SQEs
  fs: add file_operations->async_cmd()
  io_uring: add infra and support for IORING_OP_URING_CMD

Kanchan Joshi (2):
  io_uring: add support for big-cqe
  nvme: wire-up support for async-passthru on char-device.

 drivers/nvme/host/core.c      |   1 +
 drivers/nvme/host/ioctl.c     | 187 ++++++++++++++++++++++++++++------
 drivers/nvme/host/multipath.c |   1 +
 drivers/nvme/host/nvme.h      |   3 +
 fs/io_uring.c                 | 168 ++++++++++++++++++++++++++----
 include/linux/fs.h            |   2 +
 include/linux/io_uring.h      |  33 ++++++
 include/uapi/linux/io_uring.h |  26 ++++-
 8 files changed, 369 insertions(+), 52 deletions(-)

-- 
2.25.1


