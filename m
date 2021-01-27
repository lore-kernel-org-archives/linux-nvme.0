Return-Path: <SRS0=3Lap=G6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064D6C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 15:02:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B53207D0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 15:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B53207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yBLNvvp6XoG1R4ttx9urEbPBM5+cnHhqdX4MSthWKpc=; b=Lnj0diYe8gXVrLkvxcrMikIg3
	gRJwK3fre9TS+sO45KS8m1ByCi6qKEpTZM+FLHQeYR56m47LokiKgQCQxUyENUbanJfOH3FPz3Dfv
	d4JjkBJIbsKeJdObpwZ/uKpxj+RnJpNGPSA+wjaMp2lA/jWk/hIidcKKpiVtsvH7i7Pf1oqE41SGQ
	kn5igbbvq+6n15FwTxYzo3MncUzbKD7CljRcWfhouuXYoIvTC7LAeNrD5qN8JayW9o5rpKM/6n6eu
	O2/jx28AwgHqiIeW4gK62W3I53+yvLxkXMHl6oX/6Jhhqhn0xGl5RuemkyCAzuJ+nHM8NzbRVUJ6w
	9OQduIBGQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4mKX-00012m-Kw; Wed, 27 Jan 2021 15:02:01 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4mKI-0000vN-2Z
 for linux-nvme@lists.infradead.org; Wed, 27 Jan 2021 15:01:47 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20210127150141epoutp0222b9b262be6a094a63997f37a24c97a6~eHujUPtL_0139301393epoutp020
 for <linux-nvme@lists.infradead.org>; Wed, 27 Jan 2021 15:01:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20210127150141epoutp0222b9b262be6a094a63997f37a24c97a6~eHujUPtL_0139301393epoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1611759702;
 bh=GV3ACHLLXyiQg4BzUblRVcIeExfz/GyxJRRnouQFv4w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ktm8h4jkbBhjzpvZ78rTvZHtuNS4SH4Vttl1nT417HJelDlB1YNXO3l/lUzcXKZi0
 dPJC3Q4mKPhad+8G/Kz65P0t3BKigSJcGgAV/6M9SEZXs0FUUH3eZP5R9zb11wwqFp
 d8L+Bd8ebuXWRi0QGSMAe6xtPCnkoQhyqUDj9BkM=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20210127150141epcas5p303b95d3003294829d0ed9257258ac418~eHuiqXRnB0898508985epcas5p3R;
 Wed, 27 Jan 2021 15:01:41 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 6E.23.15682.55081106; Thu, 28 Jan 2021 00:01:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20210127150140epcas5p32832cc0c0db953db199eb9dd326f2d4c~eHuhmDGHu0202502025epcas5p38;
 Wed, 27 Jan 2021 15:01:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210127150140epsmtrp10851bb7716b9e70ca56d17cee799a874~eHuhlGxLa0033500335epsmtrp1g;
 Wed, 27 Jan 2021 15:01:40 +0000 (GMT)
X-AuditID: b6c32a49-8bfff70000013d42-c3-60118055eebc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 1C.05.13470.35081106; Thu, 28 Jan 2021 00:01:40 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210127150138epsmtip2911ba1cea583786e803f14fb2ba17c0f~eHufq2ViP2133921339epsmtip2_;
 Wed, 27 Jan 2021 15:01:37 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Subject: [RFC PATCH 1/4] block: introduce async ioctl operation
Date: Wed, 27 Jan 2021 20:30:26 +0530
Message-Id: <20210127150029.13766-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210127150029.13766-1-joshi.k@samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfVCLcRz32/Ps2bMx9zTSz7iNHe4KJZfzcyScOw+uK+fcyR31xHOJmtma
 8r6jusrMSyXlJUeh6UqzJi1vYzKO6MV0Z5VLdxSFOSJK27OO/z7f7+f7+X5+n+/9SExSzZeS
 icoUVq1kkhSECLc8CAycvU7nFzen9vFoNFCQx0fXXMcIVHbNzkO9Gc9x1PnGLUD2oU8EOml7
 BVDdbQeOmmrPEqj4cpcAWQaKMdScdxFDFT19OOrpdxBLxtINbVU43fRMS5uM2QR9o+QgbW3V
 EbTBbAS02ySLFmwQLdrCJiXuYtUhi+NEW1ur9HzV29FptwoqMR1oF+YAIQmpMGg1/uHnABEp
 oawA1t9/BLjiK4AfCsoxrvgOYHquHoxI3K/zBRxxG8BvFjuPK9wAPrt3eJghSYIKhC9ytR7B
 eGo5fDFwzyvAqF4AG9rM3k3jqAhoe5qLeTBOTYftP3R8DxZTCJ7vsPA4NzksbPwh8GAhtQA2
 W0y+GT/oKHyHezA2PHO4+oz3qZAqJeGTbrOAEy+HzowW36JxsLt+pC+FH45l+rAG/npj94mz
 AHTqCnGOiIAv6/7wPGmw4TSVtSGc2Vh4dOCdtw0pMczKlHDTU2HbyS4+hwPg29MlPkzDtv77
 vmvphw9UX0QcB/Ki/zIU/Zeh6J/bBYAZwURWpUlOYDXzVKFKNjVYwyRrtMqE4M07kk3A+7OC
 VtYAV8fnYBvgkcAGIIkpxosXT/GLk4i3MLv3sOodsWptEquxgUkkrggQ18zpiJVQCUwKu51l
 Vax6hOWRQqmOd0XEyCrvnOiPPGV31X0XSuRrTQ3mmajDuKJ5gb/rY0Vm2TYiypDu7zBmj3JO
 qMIHa1Z3Dxbf4P1eu/onZlVnGltCc+ILtWzf8WZ9i73vuiGtotg23aCS9fPJ6PQhs7RrLu18
 ZJqljAq56YqZnx9RidobD1RPXeYeU6pLKY+JNaTaW7NS6iMdcH1i0sySSzmdJ46iwYdlF8NF
 p6J2le7sfS8YOvdlXbRTEfPrvbTHuq9sz4yw1I3YhMkZg1ZG+nHV3ij8kIzedGTN0uyFk9Nc
 4aumhQjGxHfqGLneuki+Uh7pHJXXeumuJSAxfBlz9ZU7fn+Lv7FuomxWgjRMrlfgmq1MaBCm
 1jB/AROfUpjIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSvG5Ig2CCwaypTBa/p09htVh9t5/N
 YuXqo0wW71rPsVg8vvOZ3eLo/7dsFpMOXWO02LP3JIvF5V1z2CzmL3vKbrHt93xmiytTFjFb
 rHv9nsXi9Y+TbA58HufvbWTxuHy21GPTqk42j81L6j1232xg8+jbsorR4/MmuQD2KC6blNSc
 zLLUIn27BK6Mmxt7WAseclfsnL6euYHxPmcXIyeHhICJxOcbU9m7GLk4hAR2M0o8+vKbBSIh
 LtF87Qc7hC0ssfLfc6iij4wSt5d1M3YxcnCwCWhKXJhcCmKKCHhJbFtqCFLCLPCNUWLN2lOs
 IL3CAvYSh05PZgaxWQRUJe5/bwCL8wpYSMx7sI0JYr68xMxL38F2cQpYSlzZtgmsRgio5v2E
 h2wQ9YISJ2c+AbuNGai+eets5gmMArOQpGYhSS1gZFrFKJlaUJybnltsWGCYl1quV5yYW1ya
 l66XnJ+7iREcK1qaOxi3r/qgd4iRiYPxEKMEB7OSCK+dgmCCEG9KYmVValF+fFFpTmrxIUZp
 DhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUxFCQm1MyKmRS60uN6z+xm/xrTm33/3hj59
 t8ZkVdsXh3KlbZusrPM6PcM7kjvXOW7cx5QjtWgZnyBLXnRr+vcd7AEH9Zl7F+/ifb1cTsn1
 LtNzoXtsNiFKHFt+LbgqrTTjyfV82zUdz+2aVNINu/qXlvfFyDcs/cP4NdY+SjzEYssCxzls
 j0Sk4mTkRGbPVJ9dcsY5YqLjg+or4aeZDBOfGt5oP3K690IZp52H5nJP/9asjAzhqycSLYMW
 Kjp55trn1ioXnX1612dVu6TP9NVrp74NStFsXb6AO+vkRN380EWNrh4hepK36j0lhbalZxk0
 9y3JUY07qFX/OeBq9dJ1EhavbUoPpB9SEQ5VYinOSDTUYi4qTgQAj1Uq1gQDAAA=
X-CMS-MailID: 20210127150140epcas5p32832cc0c0db953db199eb9dd326f2d4c
X-Msg-Generator: CA
CMS-TYPE: 105P
X-CMS-RootMailID: 20210127150140epcas5p32832cc0c0db953db199eb9dd326f2d4c
References: <20210127150029.13766-1-joshi.k@samsung.com>
 <CGME20210127150140epcas5p32832cc0c0db953db199eb9dd326f2d4c@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_100146_650577_18B0A800 
X-CRM114-Status: GOOD (  14.97  )
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

Add a new block-dev operation for async-ioctl.
Driver managing the block-dev can choose to implement it.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 include/linux/blkdev.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f94ee3089e01..c9f6cc26d675 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1848,6 +1848,16 @@ static inline void blk_ksm_unregister(struct request_queue *q) { }
 
 #endif /* CONFIG_BLK_INLINE_ENCRYPTION */
 
+struct pt_ioctl_ctx {
+	/* submitter task context */
+	struct task_struct *task;
+	/* callback supplied by upper layer */
+	void (*pt_complete)(struct pt_ioctl_ctx *ptioc, long ret);
+	/* driver-allocated data */
+	void *ioc_data;
+	/* to schedule task-work */
+	struct callback_head pt_work;
+};
 
 struct block_device_operations {
 	blk_qc_t (*submit_bio) (struct bio *bio);
@@ -1856,6 +1866,8 @@ struct block_device_operations {
 	int (*rw_page)(struct block_device *, sector_t, struct page *, unsigned int);
 	int (*ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);
 	int (*compat_ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);
+	int (*async_ioctl) (struct block_device *, fmode_t, unsigned, unsigned long,
+				struct pt_ioctl_ctx *);
 	unsigned int (*check_events) (struct gendisk *disk,
 				      unsigned int clearing);
 	void (*unlock_native_capacity) (struct gendisk *);
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
