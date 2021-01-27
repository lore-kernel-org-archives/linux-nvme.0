Return-Path: <SRS0=3Lap=G6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25A1C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 15:02:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70FEF207E2
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 15:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FEF207E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NDHFD1MHudjYVRlF5ccGujho4aDgPmlANmfiSQR1rVw=; b=V1KF7LU52peYBhr5nk17qZ2GB
	pgrwoTPLhGXaYjMKLQ2ZceDlLeicbc9hXBwPxiMPq3QmgMxhxZbYvL0HZQfmgJThI2emRSGvrKJaY
	hfhTcAlwlZx67viLJVfkEbLIRmFRDvr8c5FlmHUO07BboPq1mym0UdiBDAj623sO+H3eUmyosxTPJ
	PXNufxlBcTXhYtLuKxNB6gfrI8sY7BzrlLwcG5ZwQ8vR/+zsA+HC3gXoU9MI5CyahVHv6ldZsQyqo
	Qllm3wHZUylLiiy0acMvVjt65jbopjhzCCGZS2xXEtTvTHVrtpU44wTPg707r1mL53ieF3RjAOJmD
	1zONxRBpA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4mKg-00017i-5Q; Wed, 27 Jan 2021 15:02:10 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4mKL-0000wl-Dt
 for linux-nvme@lists.infradead.org; Wed, 27 Jan 2021 15:01:51 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20210127150145epoutp015bbbb444f5cb3e576b1a0c32ef4e1f6a~eHumslrlK2044220442epoutp01O
 for <linux-nvme@lists.infradead.org>; Wed, 27 Jan 2021 15:01:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20210127150145epoutp015bbbb444f5cb3e576b1a0c32ef4e1f6a~eHumslrlK2044220442epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1611759705;
 bh=qDFCbUu7mCmhIQNv7XiLqxaYQTf9AOTX3utazaqJrYM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hGS0kR++QZe4O1Zq1hNZRXrX1OilDFr/+pycsQlZhe+PxwmWevtYCTtAvULekJafC
 5luLqsV34ZQACY5M/XauTl2XIi4bg6cThlOfRkJrJSPHIMG2QegbJAtH0KwBG2f3OW
 tM0gXrCrLT74l/79yGXy4V2dHYpTVb8NB+iZPa/Y=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20210127150145epcas5p38b2fbd59dddcb8a6d91326fd5b74ce9a~eHumRu10w0898508985epcas5p3Z;
 Wed, 27 Jan 2021 15:01:45 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 7F.F8.50652.95081106; Thu, 28 Jan 2021 00:01:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20210127150144epcas5p29ccb35d7e7170aba7947b5ee16fd2db0~eHulPqUp80627206272epcas5p2I;
 Wed, 27 Jan 2021 15:01:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210127150144epsmtrp12f6e3f4430a280ee7acb8444459c6b28~eHulOzQAq0033500335epsmtrp1o;
 Wed, 27 Jan 2021 15:01:44 +0000 (GMT)
X-AuditID: b6c32a4a-6b3ff7000000c5dc-98-60118059bdc0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 CD.05.13470.75081106; Thu, 28 Jan 2021 00:01:43 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210127150141epsmtip22609fef0295d7e19992f935dc198e3c3~eHujKTNWv2088420884epsmtip2M;
 Wed, 27 Jan 2021 15:01:41 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Subject: [RFC PATCH 2/4] kernel: export task_work_add
Date: Wed, 27 Jan 2021 20:30:27 +0530
Message-Id: <20210127150029.13766-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210127150029.13766-1-joshi.k@samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7bCmum5kg2CCwbnnLBa/p09htVh9t5/N
 YuXqo0wW71rPsVg8vvOZ3eLo/7dsFpMOXWO02LP3JIvF5V1z2CzmL3vKbrHt93xmiytTFjFb
 rHv9nsXi9Y+TbA58HufvbWTxuHy21GPTqk42j81L6j1232xg8+jbsorR4/MmuQD2KC6blNSc
 zLLUIn27BK6Ml4vXsBccYa040LqEuYHxOEsXIyeHhICJxKrt39hBbCGB3YwSjWcMIexPjBKP
 p3F3MXIB2d8YJTbef84I03DjQQsrRGIvo8SVa1+gnM+MEkd63wON5eBgE9CUuDC5FKRBRMBF
 4sLvA+wgNcwC7xglzt/bAjZJWMBUYtbpDjCbRUBV4vj500wgNq+AhcScH9vZILbJS8y89B3s
 PE4BS4kr2zaxQtQISpyc+QTsBWagmuats5lBFkgIrOSQODFxAtRvLhKnb0xghbCFJV4d38IO
 YUtJvOxvg7KLJX7dOQrV3MEocb1hJlSzvcTFPX+ZQL5hBvpm/S59iGV8Er2/n4CFJQR4JTra
 hCCqFSXuTXoKtUpc4uGMJVC2h8SqKUdYIAHUwyix9sc79gmM8rOQ/DALyQ+zELYtYGRexSiZ
 WlCcm55abFpglJdarlecmFtcmpeul5yfu4kRnK60vHYwPnzwQe8QIxMH4yFGCQ5mJRFeOwXB
 BCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8OwwexAsJpCeWpGanphakFsFkmTg4pRqYTPgtL5xv
 eXQ4VywtP53rYWXGkS6JdenunPtm2ld+/X3iUdEXO3PGkAtJ+jN5t+suaOncUWantU+H95wk
 85dDAQIvw0965ex7f3TW8rC134NNZ7QvunSMI0c+LSRR/fzMv8+PNs8KF2w/fGbK+m/L9RXs
 xCr7ckqkNHb/1d46QbOhYf2xWhVlRSVmrskcwg8D/u1sahebXmA9tyZBykI3eeGnL0XWi2Y4
 eYXN5vur8fRRyScDpp18K65NdqpbsO6ycqxABxv3PBftr2/zjnc8duLPElb7ZN6f4jnnpatR
 p+Lx2XYm65MPvanQuaaiIRNUuyfjl/FdGfaEYpU7h+fvOu5/PnmZ1krtba8lZzMrsRRnJBpq
 MRcVJwIAget2JsYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSvG54g2CCwew9Zha/p09htVh9t5/N
 YuXqo0wW71rPsVg8vvOZ3eLo/7dsFpMOXWO02LP3JIvF5V1z2CzmL3vKbrHt93xmiytTFjFb
 rHv9nsXi9Y+TbA58HufvbWTxuHy21GPTqk42j81L6j1232xg8+jbsorR4/MmuQD2KC6blNSc
 zLLUIn27BK6Ml4vXsBccYa040LqEuYHxOEsXIyeHhICJxI0HLaxdjFwcQgK7GSXO7vrFDJEQ
 l2i+9oMdwhaWWPnvOTtE0UdGiZ0rzgB1cHCwCWhKXJhcCmKKCHhJbFtqCFLCLPCNUWLN2lOs
 IL3CAqYSs053MILYLAKqEsfPn2YCsXkFLCTm/NjOBjFfXmLmpe9guzgFLCWubNsE1isEVPN+
 wkM2iHpBiZMzn4AdzQxU37x1NvMERoFZSFKzkKQWMDKtYpRMLSjOTc8tNiwwzEst1ytOzC0u
 zUvXS87P3cQIjhUtzR2M21d90DvEyMTBeIhRgoNZSYTXTkEwQYg3JbGyKrUoP76oNCe1+BCj
 NAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQam49ppVx/bRb5XXlqZLV+cb734WUqHGWfw
 6vCnG+JW/9OYJeBokP/CrrF727vU79eTWRovpk0/eONun+TvuCVrmg6qL/97TbrmWc7khR7F
 f7LbXTnevQ/al7n8RkZBhoTZH1XL/VxPWV55L8lZmr+2YGftuT9NFXscLN7v9Fu3gPWMs9DV
 fyx7rS5OKX+Q/K3fxGL2jKOn7b1fvitxWNHmXX6asVrOz8D93L/TKWw5y36ueZ9X/l7U8fn1
 iQFChv9elK00ar12OnvX/Jcv66esZrS4wSLnxPx6fvFrz42rRaM3HQ4WiX78t/HPDNstToKu
 yrt0P75Sfu923S7/9IYPGScFfQz3ZTCZbpaf/8+FSYmlOCPRUIu5qDgRACIMJm4EAwAA
X-CMS-MailID: 20210127150144epcas5p29ccb35d7e7170aba7947b5ee16fd2db0
X-Msg-Generator: CA
CMS-TYPE: 105P
X-CMS-RootMailID: 20210127150144epcas5p29ccb35d7e7170aba7947b5ee16fd2db0
References: <20210127150029.13766-1-joshi.k@samsung.com>
 <CGME20210127150144epcas5p29ccb35d7e7170aba7947b5ee16fd2db0@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_100149_966660_784A601E 
X-CRM114-Status: GOOD (  17.75  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: selvakuma.s1@samsung.com, Kanchan Joshi <joshi.k@samsung.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 javier.gonz@samsung.com, nj.shetty@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Task-work infra is required to introduce async-ioctl in nvme driver.
Without this being exported, NVMe needs to be built statically.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 kernel/task_work.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/task_work.c b/kernel/task_work.c
index 9cde961875c0..3cf413c89639 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -57,7 +57,7 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 
 	return 0;
 }
-
+EXPORT_SYMBOL(task_work_add);
 /**
  * task_work_cancel - cancel a pending work added by task_work_add()
  * @task: the task which should execute the work
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
