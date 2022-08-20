Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF9BC28D13
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Aug 2022 03:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=luIncdN4Xs0/S1pPktHEcbVCfvwuJAGRaiPlDpqB9Rw=; b=3psJ5iNJpie5flkq/6Lfk+f0Ge
	i7gw264BN4cN0UUpy4ZNABwpn/1T6PefjmU8MS2WRvXolJs2seRAh+VotAFoh1U+f08n88BOCNxUR
	LXm1f5+jwwco5KrbRPSL2QNgcWH3xm8p939uZn32agZmzR0fR8dim/2d/ha2XLJOUGd7DfgaUyv8o
	7Feh7Is3VHA7LzS8VlpVVvNiqBwAn86omwmD+n9DkbvKfQG1DpPWLYk8921RWWt3HbexmEGGUH2s5
	uyFXo0lmdR2S7UsDrSZ5yDJEKVl46HKwB+E8uOpWzMjeo49h+2ZlyP6mPwXQOjpi8M7U/fnrw6vCk
	ZL3v51Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPEzB-00Fuur-Q9; Sat, 20 Aug 2022 03:17:21 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPEz4-00Fun3-O5
	for linux-nvme@lists.infradead.org; Sat, 20 Aug 2022 03:17:17 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220820031707epoutp0306a47530fe9886d8bc5cb1ed9426ff07~M70GpasTY0169201692epoutp03D
	for <linux-nvme@lists.infradead.org>; Sat, 20 Aug 2022 03:17:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220820031707epoutp0306a47530fe9886d8bc5cb1ed9426ff07~M70GpasTY0169201692epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1660965427;
	bh=luIncdN4Xs0/S1pPktHEcbVCfvwuJAGRaiPlDpqB9Rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VEKuh8J5pjajX3/vguU+yPKd4jXdus0yaJe97h1MrVJksLh5w5Xkswnpm+R2DVcE2
	 vi2KnrzCyLoCjmpakjm5D0sYATNp7oLpQLQpT51XbJUtyVN64VjJ1MlFIh8zVi9i0P
	 GoiRlu3y3PJkCqVDaaFP/KFEIHKgxrwmRrojHVAk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20220820031707epcas5p1288fc8fde2342ece5e5582cebd57a4fd~M70GU37Pf0245602456epcas5p1B;
	Sat, 20 Aug 2022 03:17:07 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4M8kLn1tH6z4x9Pp; Sat, 20 Aug
	2022 03:17:05 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3A.75.09494.13250036; Sat, 20 Aug 2022 12:17:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20220820031704epcas5p36bf7895aa5e5f8d43384c6de355a70bc~M70DplPqD1841318413epcas5p3I;
	Sat, 20 Aug 2022 03:17:04 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220820031704epsmtrp24667b060f651df782d8b9563e264c33b~M70DorJJY0249702497epsmtrp2M;
	Sat, 20 Aug 2022 03:17:04 +0000 (GMT)
X-AuditID: b6c32a4a-201ff70000012516-98-63005231faad
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	03.12.08802.03250036; Sat, 20 Aug 2022 12:17:04 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220820031703epsmtip13fce5cd82c118468e6b34361096d3549~M70CN-qLp1949119491epsmtip1W;
	Sat, 20 Aug 2022 03:17:03 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, ming.lei@redhat.com, gost.dev@samsung.com, Anuj
	Gupta <anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH for-next v2 1/4] io_uring: introduce
 io_uring_cmd_import_fixed
Date: Sat, 20 Aug 2022 08:36:17 +0530
Message-Id: <20220820030620.59003-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220820030620.59003-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmhq5hEEOyQVMnl0XThL/MFqvv9rNZ
	3Dywk8li5eqjTBbvWs+xWBz9/5bNYtKha4wWe29pW8xf9pTd4tDkZiYHLo/LZ0s9Nq3qZPPY
	vKTeY/fNBjaP9/uusnn0bVnF6PF5k1wAe1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGh
	rqGlhbmSQl5ibqqtkotPgK5bZg7QcUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpSc
	ApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IwnryILzvNXtK7tYGpgnMTbxcjBISFgItHy2LqL
	kYtDSGA3o8T84z3MEM4nRolVn/6zQjifGSVePWxm6WLkBOvYurWXHSKxi1HifsceNriq55t+
	sYLMZRPQlLgwuRSkQUTASGL/p5Ngk5gFLjBKnGz6ygySEBYIkDgzfQEjiM0ioCpx4exPVhCb
	V8BC4veEA+wQ2+QlZl76DmZzClhKNC3/zQhRIyhxcuYTsIuYgWqat84Gu1tCoJVDYsfi94wQ
	zS4SjYcXMEPYwhKvjm+BGiol8fndXjYIO1ni0sxzTBB2icTjPQehbHuJ1lP9zCDPMAM9s36X
	PsQuPone30+YIGHHK9HRJgRRrShxb9JTVghbXOLhjCVQtofEhgmvoeHTwyjxuHMi2wRG+VlI
	XpiF5IVZCNsWMDKvYpRMLSjOTU8tNi0wyksth8drcn7uJkZwEtXy2sH48MEHvUOMTByMhxgl
	OJiVRHhv3PmTJMSbklhZlVqUH19UmpNafIjRFBjGE5mlRJPzgWk8ryTe0MTSwMTMzMzE0tjM
	UEmc1+vqpiQhgfTEktTs1NSC1CKYPiYOTqkGJm6X/W58JY7tssz7Pzx8u1xdOnX1iU9b+A9I
	fd93Wlmo/ntjvVBNIu+OjX8FNgVvKJxipbT/d8GfmmPnvmT92TorN3TTpdnHlr1+zfRF/72d
	48qST87bmi+sU5804VOxLccf0bXSfhHm3c7zHmQceOBc+lGmT1zAauPUDS9X2upvn65Q6zMn
	vWia9jGBXrdibqNmvsiDzcfKnol25W3/zp4/Key4+PH6ezP5BI43xTYufBXyprv2xYzYB8wf
	wvX0NlXLeXKYycQ8sE/59CUtu6L6g+TLt9Lu2wM619Zt3aeXGxhgc0wmqm1VqI56hp3VCbvd
	m5iLjoa0sO77br9WSq58eRfvDVutE315x/LNlFiKMxINtZiLihMBzhCIyisEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsWy7bCSnK5BEEOyQds/ZYumCX+ZLVbf7Wez
	uHlgJ5PFytVHmSzetZ5jsTj6/y2bxaRD1xgt9t7Stpi/7Cm7xaHJzUwOXB6Xz5Z6bFrVyeax
	eUm9x+6bDWwe7/ddZfPo27KK0ePzJrkA9igum5TUnMyy1CJ9uwSujCevIgvO81e0ru1gamCc
	xNvFyMkhIWAisXVrLzuILSSwg1Hi6hlZiLi4RPO1H+wQtrDEyn/PgWwuoJqPjBJNHe9Zuxg5
	ONgENCUuTC4FqRERMJNYengNC4jNLHCDUWLbhHwQW1jAT+LX+71sIDaLgKrEhbM/WUFsXgEL
	id8TDkDNl5eYeek7mM0pYCnRtPw3I8Q9FhLPZ79gg6gXlDg58wnUfHmJ5q2zmScwCsxCkpqF
	JLWAkWkVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZw8Gtp7WDcs+qD3iFGJg7GQ4wS
	HMxKIrw37vxJEuJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNT
	qoEpoSxvps+qc4Z8Zea/3EPW73l7JknP4s9Ns7OF1lxFj1acXNC9/rLFAeY9vban+dmLwwob
	39z8J17xRipX0mPmc8tjl+pnqTBe4OmtCWJZuUj1e+RugU+nqo9mO/07dWp61JZ3b3ZuSC3V
	LFX5qTFDmHOfROo8hrL9Srdm3PsZsvHDPY3TL006Ft5pXXhOkfP4tbvNU58LHtynyLWiX/Ph
	Lq/AiUEVjJkugQ3aXvLL932seRW06Grm518z1LM3/ljD2xwnfPXtPotl7V+6XzI+W7mJd4XU
	40KnhxaWHwq084/W7lN4lLLsiHXSd7mj038InfnIXjk3zEPed3WG51lzf8vWtpg98lUagY2W
	TZ+MlFiKMxINtZiLihMBigT5PO0CAAA=
X-CMS-MailID: 20220820031704epcas5p36bf7895aa5e5f8d43384c6de355a70bc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220820031704epcas5p36bf7895aa5e5f8d43384c6de355a70bc
References: <20220820030620.59003-1-joshi.k@samsung.com>
	<CGME20220820031704epcas5p36bf7895aa5e5f8d43384c6de355a70bc@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220819_201716_106651_75035C57 
X-CRM114-Status: GOOD (  13.51  )
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

This is a new helper that callers can use to obtain a bvec iterator for
the previously mapped buffer. This is preparatory work to enable
fixed-buffer support for io_uring_cmd.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 include/linux/io_uring.h |  7 +++++++
 io_uring/uring_cmd.c     | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index 58676c0a398f..60aba10468fc 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -32,6 +32,8 @@ struct io_uring_cmd {
 };
 
 #if defined(CONFIG_IO_URING)
+int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
+		struct iov_iter *iter, void *ioucmd)
 void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret, ssize_t res2);
 void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
 			void (*task_work_cb)(struct io_uring_cmd *));
@@ -59,6 +61,11 @@ static inline void io_uring_free(struct task_struct *tsk)
 		__io_uring_free(tsk);
 }
 #else
+int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
+		struct iov_iter *iter, void *ioucmd)
+{
+	return -1;
+}
 static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret,
 		ssize_t ret2)
 {
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 8900856fa588..ff65cc8ab6cc 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -121,3 +121,13 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 
 	return IOU_ISSUE_SKIP_COMPLETE;
 }
+
+int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len,
+		int rw, struct iov_iter *iter, void *ioucmd)
+{
+	struct io_kiocb *req = container_of(ioucmd, struct io_kiocb, uring_cmd);
+	struct io_mapped_ubuf *imu = req->imu;
+
+	return io_import_fixed(rw, iter, imu, ubuf, len);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
-- 
2.25.1


