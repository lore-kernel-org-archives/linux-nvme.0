Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8EAC433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 20:17:55 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB4A66101C
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 20:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4A66101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6oHBodJsdlFtQbr4q+8hrt9jisJfNkl2J8nvEiwJHKU=; b=pX8iDm3WpmAwrsiUfYHo/t7AN
	0Y5VF3bN6jBGy2CDaa6VZH4Nv3bpireojPBwGm2MrYR0LSH8lE6iOfLys/Drmq9nmI05KkipI9pNs
	CaJFuJmaosDTgLOxTWL5arrKpUYaV1gfG7DFEhPu/WREKTy/cnivW5IYAUb4YJIZGPhx4mwK3YdYl
	N3/A+rDEnyU+hDOhgsb3PgKZjyzW/nG8eqc6Hr8YhKzQU/JpR4P7YAu/tgfozsPpejRrQcNRAr6l6
	Ea5Gl9d3wAz9CIy9EeSG049zK8thRpKBeToUy7savlF4xB/82Yp+6KYkhaGzK6FFf2cMzZ9F6z2dP
	K0RcTfiEw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lX8Qk-00HEnC-A5; Thu, 15 Apr 2021 20:17:38 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lX8Qe-00HEmh-MD
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 20:17:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=NLydBAR2kumqE5k5kKI9tHIQqPcxVy4dfuH+wZIeYpA=; b=zlnR6xJxvszYT93cM+ulf7pTsE
 azvbXiGHV+Hu8WFpNYPvw0mMuef5QwQnmH+H5yCpDxbUjC41S+G/FyhARhuoc3s26y8r/nYw9+O6N
 XeQqU6oqD8344O9WryyXwfu7iX/7f8VFuiEv4iQE57u4PG8Eu/APLs8+4jJyUNr0ZT2LWqJbxpYIZ
 hwJu+R4gQjpO9vnOtS14t/xRSCEzcfjrv7I96yPwbOt2EqH9VsVnxvrLX5XaXiuujZ1rxwlKV1kO0
 XYevTwSDVUCctVIAlCEowiTJvvunaNSoOoSGnrjZJp9H3AGLZoMiObPlKS/js5UyUNRCbr0COt48j
 DdW/UO/Q==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lX8Qc-008s3E-61
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 20:17:31 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 032FC6101C;
 Thu, 15 Apr 2021 20:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618517848;
 bh=ArY0/vGTxB8PR9cKRlx6Fbp0tzDuY8E7M/hjMixn6hs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dLQSHqzZfsj6Vddyr+j1OxhOr420hwUNfSyyEFZqsxJJNTIm7bakAoVnuNK9sG21J
 CkXKjOhl6LKn4f4wu5j0psymyzxBlm/dW1Gs0GnaQxi/f1pBrFEOl7xz8piCtpugmu
 USBSIfdg14nIEg2k+d9LjvGL5Sr2x2SXosK/j6/7mxkZapY6OiaqJjvkxD4GtZECzD
 fOvQBaamwX5MPlqjUnnjDQQ0kLgXxLB2IMbcANE2hbY9vwoV5KrVBA8Kl5Fmz7Et6B
 UxAK2dqfN3LiT3lSmEs6c93YrIWQ1PeWt1At4vaw79ORi21DrKHdTAvs1pyNw5Bx3M
 SrNs3/qyd2gyw==
Date: Thu, 15 Apr 2021 13:17:26 -0700
From: Keith Busch <kbusch@kernel.org>
To: Yuanyuan Zhong <yzhong@purestorage.com>
Cc: Chaitanya.Kulkarni@wdc.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, cachen@purestorage.com
Subject: Re: [PATCH v2] nvme-core: initialize status to NVME_SC_HOST_PATH_ERROR
Message-ID: <20210415201726.GB2452080@dhcp-10-100-145-180.wdc.com>
References: <BYAPR04MB49656BC34E2C7AA4E3324DF2864F9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210414170833.24929-1-yzhong@purestorage.com>
 <20210415193030.GA2452080@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210415193030.GA2452080@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_131730_284268_E1C544A4 
X-CRM114-Status: GOOD (  19.42  )
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

On Thu, Apr 15, 2021 at 12:30:30PM -0700, Keith Busch wrote:
> On Wed, Apr 14, 2021 at 11:08:33AM -0600, Yuanyuan Zhong wrote:
> > Block layer blk_end_sync_rq() silently drops blk_status_t error.
> > When ->queue_rq returns error, nvme driver should set nvme status
> > explicitly. Otherwise the passthrough command may take the stale
> > status as result. A typical value zero will be interpreted as
> > NVME_SC_SUCCESS, despite the dispatching error from ->queue_rq.
> > 
> > Instead of trying to fix it for every error return, this change
> > initialize the status to NVME_SC_HOST_PATH_ERROR during
> > nvme_clear_nvme_request().
> 
> It doesn't look like these types of errors are unique to nvme. Could we
> not just have blk_execute_rq() return an error instead?

The following enables all callers to know if queue_rq() failed:

---
diff --git a/block/blk-exec.c b/block/blk-exec.c
index beae70a0e5e5..6d12524a91f9 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -21,7 +21,7 @@ static void blk_end_sync_rq(struct request *rq, blk_status_t error)
 {
 	struct completion *waiting = rq->end_io_data;
 
-	rq->end_io_data = NULL;
+	rq->end_io_data = ERR_PTR(blk_status_to_errno(error));
 
 	/*
 	 * complete last, if this is a stack request the process (and thus
@@ -73,7 +73,7 @@ EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
  *    Insert a fully prepared request at the back of the I/O scheduler queue
  *    for execution and wait for completion.
  */
-void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
+int blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
 {
 	DECLARE_COMPLETION_ONSTACK(wait);
 	unsigned long hang_check;
@@ -87,5 +87,6 @@ void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
 		while (!wait_for_completion_io_timeout(&wait, hang_check * (HZ/2)));
 	else
 		wait_for_completion_io(&wait);
+	return PTR_ERR_OR_ZERO(rq->end_io_data);
 }
 EXPORT_SYMBOL(blk_execute_rq);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1a6f89d1110c..9ed540d168af 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -933,7 +933,7 @@ extern int blk_rq_map_kern(struct request_queue *, struct request *, void *, uns
 extern int blk_rq_map_user_iov(struct request_queue *, struct request *,
 			       struct rq_map_data *, const struct iov_iter *,
 			       gfp_t);
-extern void blk_execute_rq(struct gendisk *, struct request *, int);
+extern int blk_execute_rq(struct gendisk *, struct request *, int);
 extern void blk_execute_rq_nowait(struct gendisk *,
 				  struct request *, int, rq_end_io_fn *);
 
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
