Return-Path: <SRS0=eYGd=M4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F01C4338F
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 13:16:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BD806103B
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 13:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4BD806103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mHx/+D3ydvhTNiz6m/kNUiPQzznQwcz+/DKRSncuJH4=; b=YZnGtKwD5jnk7O
	0bYbo6sLW89uT326t8nilLYvGxDaE4TBFyFZNx6LsL6O6tAHAJn3viWXWO08UM0YXy50Fw2B1s4qU
	xbWq4vWVsFtNeE//4a8IFJ6XBaKEuxTkMSPe6BDTlH+02+zew4gOXdsqYdIxK2mpwkuSn+wuLfkdd
	sHE1l345R5kGv4C9DsROz2hvuVJ1u+orgEXl82qUQNNk0bRLBGeAE+O0CWGhtTV7nSITM0+c0CCHH
	Nujs4g+wAMLZxqKvQnpGAJn6K+SvmXgzG2JFPWO7J5Y9FhyGtyZyDAv7LTGmkGRruODCLAd0VlzH8
	xp5HLqUPvRer4xBcJpwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBdEH-009dtq-TE; Thu, 05 Aug 2021 13:16:09 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBdE4-009dqm-Sh
 for linux-nvme@lists.infradead.org; Thu, 05 Aug 2021 13:15:59 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20210805131552epoutp031b840296328080e12624206c25e82491~Ya2ZjP8Lt0184801848epoutp03N
 for <linux-nvme@lists.infradead.org>; Thu,  5 Aug 2021 13:15:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20210805131552epoutp031b840296328080e12624206c25e82491~Ya2ZjP8Lt0184801848epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1628169352;
 bh=8mgNUqK5xC19AK6FuLtTxaLPmXTM+oRg5NY7JJhIVTg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=l9NFJsD5WorhQSwoSGOrpoucEUg2zwV5ieL06PL1mXrOnNCR3UtfGEU8PpQmKcJf6
 dkRuJ33pD96R98BDhKd8uAuGSIuVuQPTZnN91Ni9crdHttgctvYv3QQVYAkXMReuGO
 5/zLCMpdV7SMcrjls+ditFiph3oGgNZp910Tc4Hc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20210805131551epcas5p383f73278557d321e8076399704b6ce5f~Ya2Ya4p8z1990619906epcas5p39;
 Thu,  5 Aug 2021 13:15:51 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4GgTd00HR2z4x9Pr; Thu,  5 Aug
 2021 13:15:48 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 D9.2F.09595.384EB016; Thu,  5 Aug 2021 22:15:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20210805125917epcas5p4f75c9423a7b886dc79500901cc8f55ab~Yan6807rz1331413314epcas5p4W;
 Thu,  5 Aug 2021 12:59:17 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210805125917epsmtrp28066451799d8e55b4dd82358909e3cbe~Yan68Fg6B2066920669epsmtrp26;
 Thu,  5 Aug 2021 12:59:17 +0000 (GMT)
X-AuditID: b6c32a4a-ed5ff7000000257b-4e-610be4834b5e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 CC.84.32548.5A0EB016; Thu,  5 Aug 2021 21:59:17 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210805125916epsmtip1de40eaff5777bc75236bb0676629dd0a~Yan5W1itq0981609816epsmtip1P;
 Thu,  5 Aug 2021 12:59:16 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 anuj20.g@samsung.com, javier.gonz@samsung.com, hare@suse.de, Kanchan Joshi
 <joshi.k@samsung.com>
Subject: [RFC PATCH 1/6] io_uring: add infra for uring_cmd completion in
 submitter-task.
Date: Thu,  5 Aug 2021 18:25:34 +0530
Message-Id: <20210805125539.66958-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805125539.66958-1-joshi.k@samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmpm7zE+5Eg887DSyaJvxltlh9t5/N
 Ys+iSUwWK1cfZbJ413qOxeLxnc/sFkf/v2WzmHToGqPF/GVP2S2uTFnE7MDlcflsqcemVZ1s
 HpuX1HvsvtnA5tG3ZRWjx+bT1R6fN8kFsEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
 6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaekUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJ
 KTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM7YfuIaU0GvSEXP7gtsDYy/BboYOTkkBEwk5u9Z
 xdbFyMUhJLCbUeLLxsfsEM4nRol75xuYIJzPjBITvq5k7mLkAGtZfcEOpFtIYBdQ0W5HuJrW
 NXPYQGrYBDQlLkwuBakRETCS2P/pJCtIDbPAIkaJrfd/M4MkhAWiJKbv+QhWzyKgKjHjuCNI
 mFfAQuL/i5eMENfJS8y89J0dxOYUsJT4fGgvK0SNoMTJmU9YQGxmoJrmrbOZIeo7OSSm3vWF
 sF0kOjZOZoKwhSVeHd/CDmFLSXx+t5cNwi6W+HXnKDPIbRICHYwS1xtmskAk7CUu7vnLBHIb
 M9Av63fpQ4RlJaaeWscEsZdPovf3E6j5vBI75sHYihL3Jj1lhbDFJR7OWAJle0g0L2lkgYRV
 D6NEz7kXTBMYFWYh+WcWkn9mIaxewMi8ilEytaA4Nz212LTAKC+1HB7Hyfm5mxjByVXLawfj
 wwcf9A4xMnEwHmKU4GBWEuFNXsyVKMSbklhZlVqUH19UmpNafIjRFBjeE5mlRJPzgek9ryTe
 0MTSwMTMzMzE0tjMUEmclz3+a4KQQHpiSWp2ampBahFMHxMHp1QDU9JxeUlLnvon1nMd38eu
 6YwUPbr+Iu905cgXvPFyoQKFSfMa/T1D7psp9yktzMqZ+Dn08OzlzWKayqbn0i7FTlYx/br8
 29SpjaF7y9odn7QsfM4SdPe2Mn+5vKqQW3WkSxjD4+nzRVxjS+QOiNsWzvkpZpthyOi+X2a/
 hmRc14t7J3d4Lc5jklN/sDGm55a35tNLhzteJb84bHzoaH/AjcRZBbbv0+vr76p+sXa50hYw
 5UvVjLd9e46u+L50xeVJvKqbNl2Xf7vp79odjif2mvTF+hmcNe9UTNnMVzB5q6CpX5fRyvwg
 0w0lz7ef9Dn9OHeF7ncJFyG2f9ImNjmWdy9rlXLe7F1x787ZyVwFSizFGYmGWsxFxYkAxpGq
 aTcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsWy7bCSnO7SB9yJBo+/aVs0TfjLbLH6bj+b
 xZ5Fk5gsVq4+ymTxrvUci8XjO5/ZLY7+f8tmMenQNUaL+cuesltcmbKI2YHL4/LZUo9NqzrZ
 PDYvqffYfbOBzaNvyypGj82nqz0+b5ILYI/isklJzcksSy3St0vgyth+4hpTQa9IRc/uC2wN
 jL8Fuhg5OCQETCRWX7DrYuTiEBLYwSgx6eM+9i5GTqC4uETztR9QtrDEyn/P2SGKPjJKnN67
 lh2kmU1AU+LC5FKQGhEBM4mlh9ewgNQwC6xglNjd95sRJCEsECHxpL+RFaSeRUBVYsZxR5Aw
 r4CFxP8XLxkh5stLzLz0HWwXp4ClxOdDe8HKhYBqZm6NgCgXlDg58wkLiM0MVN68dTbzBEaB
 WUhSs5CkFjAyrWKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECA5+La0djHtWfdA7xMjE
 wXiIUYKDWUmEN3kxV6IQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotg
 skwcnFINTKyujg9uHX8cczK1MIzhvuHz9LTe1GSjI/sfGt/2Ud095blaFvtfXy5DZt7fh3QU
 1p2MOz3B4bBbedvRQ3v0fvPtjqhew71w87wPb6Ue33VPmaB84VaAwYE/hTFLbe7fXeZTtGOx
 7PTIhsDVGzljpZtf2K99V/hsz2KuuuMn+bgnR2fkmurERdnITOQ1bDfKCHrTlhTOltG8IqLi
 DqPD1QvpZv+nnHxzIma70vZaAd5DVzV2H0y0Lg//3yD3cK9N6swdSwo3P2A3dzNkesf+c3Pe
 tujYv0mctt2Pcg14r/7Ri0qIm+mXaLHi2ZOw5zodop7Re//laVnsnbQg0KPJZUM6k6pIm+6z
 hRM83zFqK7EUZyQaajEXFScCAG+cx9HtAgAA
X-CMS-MailID: 20210805125917epcas5p4f75c9423a7b886dc79500901cc8f55ab
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210805125917epcas5p4f75c9423a7b886dc79500901cc8f55ab
References: <20210805125539.66958-1-joshi.k@samsung.com>
 <CGME20210805125917epcas5p4f75c9423a7b886dc79500901cc8f55ab@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210805_061557_339026_845F40AA 
X-CRM114-Status: GOOD (  16.42  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Completion of a uring_cmd ioctl may involve referencing certain
ioctl-specific fields, requiring original submitter context.
Export an API that driver can use for this purpose.
The API facilitates reusing task-work infra of io_uring, while driver
gets to implement cmd-specific handling in a callback.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/io_uring.c            | 16 ++++++++++++++++
 include/linux/io_uring.h |  8 ++++++++
 2 files changed, 24 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 481ebd20352c..b73bc16c3e70 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2041,6 +2041,22 @@ static void io_req_task_submit(struct io_kiocb *req)
 	mutex_unlock(&ctx->uring_lock);
 }
 
+static void io_uring_cmd_work(struct io_kiocb *req)
+{
+	req->uring_cmd.driver_cb(&req->uring_cmd);
+}
+
+void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
+			void (*driver_cb)(struct io_uring_cmd *))
+{
+	struct io_kiocb *req = container_of(ioucmd, struct io_kiocb, uring_cmd);
+
+	req->uring_cmd.driver_cb = driver_cb;
+	req->io_task_work.func = io_uring_cmd_work;
+	io_req_task_work_add(req);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_complete_in_task);
+
 static void io_req_task_queue_fail(struct io_kiocb *req, int ret)
 {
 	req->result = ret;
diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index ea20c16f9a64..235d1603f97e 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -14,11 +14,15 @@ struct io_uring_cmd {
 	__u16		op;
 	__u16		unused;
 	__u32		len;
+	/* used if driver requires update in task context*/
+	void (*driver_cb)(struct io_uring_cmd *cmd);
 	__u64		pdu[5];	/* 40 bytes available inline for free use */
 };
 
 #if defined(CONFIG_IO_URING)
 void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret);
+void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
+			void (*driver_cb)(struct io_uring_cmd *));
 struct sock *io_uring_get_socket(struct file *file);
 void __io_uring_cancel(struct files_struct *files);
 void __io_uring_free(struct task_struct *tsk);
@@ -41,6 +45,10 @@ static inline void io_uring_free(struct task_struct *tsk)
 static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret)
 {
 }
+static inline void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
+			void (*driver_cb)(struct io_uring_cmd *))
+{
+}
 static inline struct sock *io_uring_get_socket(struct file *file)
 {
 	return NULL;
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
