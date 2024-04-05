Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF09CD11C2
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Apr 2024 04:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vOErrd8uoawU54yQrnXW1/oxi80SWgbz1aMnO/XvxPc=; b=cxeXsMQQUC+t4qe3S6yoo3MpV5
	Sup/093AUF8BVKvkak7zv1t5EjMfXVTilwjydH7MRys0OY1jh4DJ49+zT3elC8Drbv0AjwNxip046
	k8L1T43R0YQ+5a1pWO2ah2KaosC8MTTMN/ASa0svSp6G3GuPBuYfF2Is28zG99EwHRdY09OYkhbXC
	LwhJxH+wlXKunU3XS8UOIQVTSShmyynXbz1q9LCHQ13KgsnVddtFCSLxo+PakTpyz7iTytJ2nFfhx
	1IswSoKD9nTySGnFQlSgpph3AMj+Sv8mMSElR36NWDsCezUsdEWIrIpY+3XnSV5hcNr5SXEu/SQ5l
	OO0Q/gWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsbP5-00000005B7c-0s7A;
	Fri, 05 Apr 2024 04:42:15 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsbP1-00000005B6O-3u07
	for linux-nvme@lists.infradead.org;
	Fri, 05 Apr 2024 04:42:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6A7DF61898;
	Fri,  5 Apr 2024 04:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8532C433F1;
	Fri,  5 Apr 2024 04:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712292131;
	bh=6IgWUvJqcNdjsX7V3ibm78gJ0SitnuzQFFEgbizFsdw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iU0GmWRe3EFLdoGzcGJH4N5xBvrUhOfZdyEiljLXyx7lVuCE0obHgNfFZHTvc9/Ck
	 2sd+yGS476eoAZP1glK4W3KgNswbEZQcVaWGSB+mwC+oJ8qGZuHFpEL5fTaYYuRJ/c
	 g0VfCB/vc7Mdx7GhitO4ufhMQdTuuUQ0Jf07HHY5dCkQ6O0NbwAVN87ygCFwuCcP7o
	 vV8Vht4QqnpTT8f2UC2f0fBZbXek+651oDYcc43wnsK9Fo7wzrcx3WJTbiKerdGLG6
	 cvwKFVi/KAYzY37D/SzZGZdFJ8WfQ0uk7dAQeLvccHH4nczDcYkCSApxaCkU6CSl6c
	 WPNh2AeByNwdA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 01/28] block: Restore sector of flush requests
Date: Fri,  5 Apr 2024 13:41:40 +0900
Message-ID: <20240405044207.1123462-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405044207.1123462-1-dlemoal@kernel.org>
References: <20240405044207.1123462-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_214212_111307_B05E18AD 
X-CRM114-Status: GOOD (  13.04  )
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

On completion of a flush sequence, blk_flush_restore_request() restores
the bio of a request to the original submitted BIO. However, the last
use of the request in the flush sequence may have been for a POSTFLUSH
which does not have a sector. So make sure to restore the request sector
using the iter sector of the original BIO. This BIO has not changed yet
since the completions of the flush sequence intermediate steps use
requeueing of the request until all steps are completed.

Restoring the request sector ensures that blk_mq_end_request() will see
a valid sector as originally set when the flush BIO was submitted.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Hans Holmberg <hans.holmberg@wdc.com>
---
 block/blk-flush.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index b0f314f4bc14..2f58ae018464 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -130,6 +130,7 @@ static void blk_flush_restore_request(struct request *rq)
 	 * original @rq->bio.  Restore it.
 	 */
 	rq->bio = rq->biotail;
+	rq->__sector = rq->bio->bi_iter.bi_sector;
 
 	/* make @rq a normal request */
 	rq->rq_flags &= ~RQF_FLUSH_SEQ;
-- 
2.44.0


