Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C06C7EE22
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Apr 2023 09:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cGKDfl/XthfWKk15QDiG1O0uY0pyS8zVFh/2tUDjwjY=; b=2chiZ0MJVeunhBbfI1eUTFAwYK
	uCEo1vVyspHaPXydGqPUnsz5iMIt9b7iMDzg3xoxGxFXyCJNjSwDfUXr7hNcgVy9aLodvGxLTP5XC
	BAP/cP/tpSERFxWIforh46bk6JzmYxnzRoDeFyA6AZCKjsy/bSHaujM8Kr4r8WsAkOsmR9kEfGyqX
	VLKJ5HEEtBAIBVdvS5jXezdb6Ql9JtQGQk6eGVr6o8+EJt4uM75tOzJc85dcjv7UkJYD/GIrsAV9w
	id1vOPt2NNMKzHLLk0MXkLA959M5PpbyuuRYMqQd6S1XPkbQWyXCUUqWz0h9RMeX0pSPpg6QJ3EkF
	4r0nZvKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1psh6Q-00CTpG-2y;
	Sat, 29 Apr 2023 09:42:50 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1psh6N-00CTnf-2F
	for linux-nvme@lists.infradead.org;
	Sat, 29 Apr 2023 09:42:49 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230429094246epoutp0369fe2cf59cdb970478083b649f589710~aXov345ZL3037430374epoutp03c
	for <linux-nvme@lists.infradead.org>; Sat, 29 Apr 2023 09:42:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230429094246epoutp0369fe2cf59cdb970478083b649f589710~aXov345ZL3037430374epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1682761366;
	bh=cGKDfl/XthfWKk15QDiG1O0uY0pyS8zVFh/2tUDjwjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CooSrNQQLUGXRa84Lz00nAf3iTLu431vKL52KxL+WBYW9DkpVXtXO57FVry/CTfRH
	 QDC5hTurcj0ci71s03AKidKqvAwoHZ8PnUWUWrZl75vK9gNFEWV7Td5un00PJNULx5
	 j3RsMH3zSmMKXzMc5UXR+QAMDzn4H9gUS0f/r+8Q=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20230429094245epcas5p18b332f08089ce47aef7cf4c022276bb1~aXovUNIjP2857728577epcas5p1f;
	Sat, 29 Apr 2023 09:42:45 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Q7kzR4r5Cz4x9Pp; Sat, 29 Apr
	2023 09:42:43 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	58.50.55646.396EC446; Sat, 29 Apr 2023 18:42:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20230429094243epcas5p13be3ca62dc2b03299d09cafaf11923c1~aXotIHsik1041010410epcas5p1k;
	Sat, 29 Apr 2023 09:42:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230429094243epsmtrp1f27744d43c11881159e6c70a6bf698ea~aXotHXscF0376803768epsmtrp1q;
	Sat, 29 Apr 2023 09:42:43 +0000 (GMT)
X-AuditID: b6c32a4b-913ff7000001d95e-dc-644ce6930268
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	46.38.27706.296EC446; Sat, 29 Apr 2023 18:42:42 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230429094240epsmtip29cd999aa5565b7db1f8bef0f06413366~aXorL5mwJ0703907039epsmtip2R;
	Sat, 29 Apr 2023 09:42:40 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, anuj1072538@gmail.com,
	xiaoguang.wang@linux.alibaba.com, Anuj Gupta <anuj20.g@samsung.com>, Kanchan
	Joshi <joshi.k@samsung.com>
Subject: [RFC PATCH 03/12] fs, block: interface to register/unregister the
 raw-queue
Date: Sat, 29 Apr 2023 15:09:16 +0530
Message-Id: <20230429093925.133327-4-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230429093925.133327-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmuu7kZz4pBi8vKll8/PqbxaJpwl9m
	i9V3+9ksbh7YyWSxcvVRJot3redYLI7+f8tmMenQNUaLvbe0LeYve8puse71exaLTX9PMjnw
	eOycdZfd4/y9jSwel8+Wemxa1cnmsfOhpcfmJfUeu282sHn0bVnF6PF5k1wAZ1S2TUZqYkpq
	kUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QvUoKZYk5pUChgMTi
	YiV9O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7Iwf+1uZC5Zw
	VSxdq9bAeJaji5GTQ0LARGLynalMXYxcHEICuxklPvzZwQLhfGKUePFqDVTmG6PE8nmbGWFa
	ei9+ZYNI7GWU+H1xGjuE85lR4vXJ3cxdjBwcbAKaEhcml4I0iAi4SDStnQrWwAwyqWn3XBaQ
	hLBAmMSMx6vBprIIqErsW/+UHcTmFbCU+LW6kwlim7zEzEvfweKcAlYS32eAzAepEZQ4OfMJ
	2BxmoJrmrbOZQRZICCzkkFh6eQtUs4vE7zOz2SBsYYlXx7ewQ9hSEi/726DsZIlLM89B1ZdI
	PN5zEMq2l2g91Q/2DDPQM+t36UPs4pPo/f2ECSQsIcAr0dEmBFGtKHFv0lNWCFtc4uGMJawQ
	JR4SR18mQ4Knl1Hi3cUW9gmM8rOQfDALyQezEJYtYGRexSiZWlCcm55abFpgnJdaDo/X5Pzc
	TYzgVKvlvYPx0YMPeocYmTgYDzFKcDArifDyVrqnCPGmJFZWpRblxxeV5qQWH2I0BQbxRGYp
	0eR8YLLPK4k3NLE0MDEzMzOxNDYzVBLnVbc9mSwkkJ5YkpqdmlqQWgTTx8TBKdXAtPzmbwfu
	pWWHn86Z8LesS/mbpyVXwdHHKZ41AZxhxU6u0devXT95Iqjp759yK9lw5Y3LZD7mCQWtSrO8
	U7FHmNt8/2eDzC9fn/EuXswxL5J7odfsl+an74n1PBSsnDv5TO2re8Ezz5SkTGLy7Jg9xbdk
	j+u69bNvbIr5/toxLXzed+arU+dNXs1X6CBVqTltms4emzyRHi/JiiJzVcVzmRpvmk5cc/5y
	2Ffsoph/SbS3tv/+y+Uzxa+XiC/M9sj45mDEkME9/W9Cx8tfzsdnbfacNOsGZ6IRm1DbhrCj
	u69yvd2tOpf/6IF5Mh3pRyrs+rMUIk4W8P3/sfFZePi5vnINi4XbJfjNRB49f+RyXImlOCPR
	UIu5qDgRAHcRTy4+BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSvO6kZz4pBt1rrS0+fv3NYtE04S+z
	xeq7/WwWNw/sZLJYufook8W71nMsFkf/v2WzmHToGqPF3lvaFvOXPWW3WPf6PYvFpr8nmRx4
	PHbOusvucf7eRhaPy2dLPTat6mTz2PnQ0mPzknqP3Tcb2Dz6tqxi9Pi8SS6AM4rLJiU1J7Ms
	tUjfLoEr48f+VuaCJVwVS9eqNTCe5ehi5OSQEDCR6L34la2LkYtDSGA3o0Tviv1MEAlxieZr
	P9ghbGGJlf+es0MUfWSU2PFtMpDDwcEmoClxYXIpSI2IgJdE+9tZYIOYBf4xSrz/ehlskLBA
	iMS5eY/ABrEIqErsW/8UzOYVsJT4tboTapm8xMxL38HinAJWEt9n7GYGmS8EVNO4IB6iXFDi
	5MwnLCA2M1B589bZzBMYBWYhSc1CklrAyLSKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93
	EyM4SrQ0dzBuX/VB7xAjEwfjIUYJDmYlEV7eSvcUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwX
	uk7GCwmkJ5akZqemFqQWwWSZODilGpgsk26+f5zl2zxDcVqxv4VBiNmPwnWyjg79L2d7BDlX
	Lryfwnf/EL/ZvmynaTd6Ot8JVn/7e1lSWqj072H2Vc66z5N35kzmnPUp9Gxap+VdFo5Dmzfs
	7X3iJKzFITGhY4VH7/x/9heko/afmV7ZqLbtT+jO73H2h9SmbRGcrDZrcZhu9yXxaGfLEqVt
	3sXlXN97hQxzBUOXFuttaJi0WPnFkxipCdvDuNxPak1MOiPhvv/O3JwJOo9ulZ3NYp92uq7v
	7NkV/GVGCf3xFXYX1xstXNa9LkH/s6KIm7F/6JkwVZE3Gsn+E4+q/dm75lZl4Oa52naXyt9c
	nXp97sqk9KSA7/d5w+JvZVef2m0i26bEUpyRaKjFXFScCACTtju/AQMAAA==
X-CMS-MailID: 20230429094243epcas5p13be3ca62dc2b03299d09cafaf11923c1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230429094243epcas5p13be3ca62dc2b03299d09cafaf11923c1
References: <20230429093925.133327-1-joshi.k@samsung.com>
	<CGME20230429094243epcas5p13be3ca62dc2b03299d09cafaf11923c1@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230429_024248_047351_9988269B 
X-CRM114-Status: GOOD (  12.96  )
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

From: Anuj Gupta <anuj20.g@samsung.com>

Introduce register/unregister callbacks to fops and mq_ops, so that
callers can attach/detach to raw-queues.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 include/linux/blk-mq.h | 2 ++
 include/linux/fs.h     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 06caacd77ed6..7d6790be4847 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -657,6 +657,8 @@ struct blk_mq_ops {
 	 * information about a request.
 	 */
 	void (*show_rq)(struct seq_file *m, struct request *rq);
+	int (*register_queue)(void *data);
+	int (*unregister_queue)(void *data, int qid);
 #endif
 };
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 475d88640d3d..79acccc5e7d4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1798,6 +1798,8 @@ struct file_operations {
 	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
 				unsigned int poll_flags);
+	int (*register_queue)(struct file *f);
+	int (*unregister_queue)(struct file *f, int qid);
 } __randomize_layout;
 
 struct inode_operations {
-- 
2.25.1


