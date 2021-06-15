Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEB9C48BE5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 14:38:30 +0000 (UTC)
Received: from bombadil.infradead.org (unknown [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 311E461490
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 14:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311E461490
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wx/RWPfFQPA+P6+rek9jUUAMrTbR5xMPvy/TcjQKy5k=; b=tNshWk6B0Lwdgc
	87xildofPhbjTpUzq5Y0LjldZ1zip9n4hOfR0xCvPEK9EAQW8aIxreCwgjgCVwRM5Q6MNcTrlq4cX
	v3wAD/cwXIu6vFhSPVNQeHNgvAxCQWkjKp8QNdrqUmNiipO5nfoYlVLNatYBAqiTjp/BkrB54DNdn
	piUXWJvD8s54XbGaHaO+pdsagG1gF+xBv5dVvClERo28QaeE3yVEaEPIbb1Kwp1WJI+g5+78jXhSq
	hwe5q0XJEAHM27t8AQ6xeAWeEmyAeq14upNXehfWS1DVAR1fYCQ7WHshMb/8dFYgOR7suXh8ZgwO9
	v8hq2eZThPsDF4uh64+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltACN-000eBx-VQ; Tue, 15 Jun 2021 14:37:52 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt9Nc-000FmL-DQ
 for linux-nvme@bombadil.infradead.org; Tue, 15 Jun 2021 13:45:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=b9J7Zh7mkJRtOXX/Ega3sU9zRRLyGipCQbOE94xKi2A=; b=oK3hjzGcp5Op2i80fsjtCbcwHV
 KyhsGRXou9+Ur2B7kvaUv30ulLotaBG4k3K44o+SGRLs1mumDS2KmQ7K3a2s4mknGsVYNS4qIpH80
 d3dC/Vq7dyxRyVUFx5g223F1waQDJt4fUS5F0N0IQJR/UXIM9N0HpiwE97tSTkZ4Z1KjAGdZM2iRP
 dGWZ/Qtz+8Kr/nEm5/GMR8pa0nKsbNyiBPoUdiTQXdI1sp30BlifoC9du/N5iQ8cgEMQZcfyBJD5M
 /0fkb1ordUr30F5GW21GJZ+KZxIOhcDMRoTr9omYglK12AQivYM7zAOEfwONSsOFzP2Kpr3rO2gMC
 8hwmg8EA==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt8rx-006nI5-Tk; Tue, 15 Jun 2021 13:12:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 07/16] blk-mq: remove blk_qc_t_valid
Date: Tue, 15 Jun 2021 15:10:25 +0200
Message-Id: <20210615131034.752623-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615131034.752623-1-hch@lst.de>
References: <20210615131034.752623-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

Move the trivial check into the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 block/blk-mq.c            | 2 +-
 include/linux/blk_types.h | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index eb861839ff49..cb94cf9bcf99 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3997,7 +3997,7 @@ static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
  */
 int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 {
-	if (!blk_qc_t_valid(cookie) ||
+	if (cookie == BLK_QC_T_NONE ||
 	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		return 0;
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index abe00ac81b2e..295addd38390 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -506,11 +506,6 @@ typedef unsigned int blk_qc_t;
 #define BLK_QC_T_SHIFT		16
 #define BLK_QC_T_INTERNAL	(1U << 31)
 
-static inline bool blk_qc_t_valid(blk_qc_t cookie)
-{
-	return cookie != BLK_QC_T_NONE;
-}
-
 struct blk_rq_stat {
 	u64 mean;
 	u64 min;
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
