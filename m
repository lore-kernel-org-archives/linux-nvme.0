Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB79DECAAD8
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 18:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Or6y/P+wCgw7ERLdnKk9k3MTRgFakhY9VTpCDMSU5NU=; b=MMOF6LxVeWyniGdqgyL+u7rNjw
	cdSN3b7aedxfMQi3GMfI0/UNVdUfrw+gOjb7//ljgV9O1LP6ZDZJXADQtdJxVaZVw4DPaIM3ix92q
	ZTabWPN4cf92X07CQXel/b0dAjOeuL7z5mt9MmEbHpobMOBMnKj4LMVk3ciUC5mw/mtGVA3X4SqHm
	JbL1dXj0SNddyZjI0Q3iLz41MBSI7DqWFeF+XWnnDGnLIW4K7FofcRh0or6eXQBBty9Cg7taGANxT
	KEYK1kc9T/FrZO3PSwubWfd5IMEK85AVOU932G54/ni1iqDbu7uIqAUCCdBzC+9+u1VhFEy6e0Bdz
	ZuVp74mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obQvu-00HLEj-OH; Thu, 22 Sep 2022 18:28:22 +0000
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obQvk-00HL8B-8K
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 18:28:13 +0000
Received: by mail-io1-xd2e.google.com with SMTP id v128so8424955ioe.12
        for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 11:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Or6y/P+wCgw7ERLdnKk9k3MTRgFakhY9VTpCDMSU5NU=;
        b=DdaRIUVcXAC0PQL+apg/G+AjI2f67CbJodcek5ww9nFAO2BwNSHNCCxyA69h3aCoaM
         c8dFUovgd1Drm3MhsG5dCul89+q4n+Khw1JhESY3iHgB4ShRhp9VEMVUp57yjQm5v28v
         oSJnU2H3CgZTZONneZYK83VfiSHtzbfpxiz1QfnQqD0bs1K+5tmyijIqbnz6upfKVw3x
         lt4B+nt231UmP2KsK7u07z92rMmNfhf8WijKOrp2pSBhiq43clWLg1ATlroeeG6Z4C9l
         qkGtMckF44rjRNra0MuENekYeSNfiaLmxzoJ9wF2FaIxyxduFLHw9EDTkoOIEt05q2eq
         KFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Or6y/P+wCgw7ERLdnKk9k3MTRgFakhY9VTpCDMSU5NU=;
        b=34yQCLR7jMMocu6ihl1YyrEq/Y5cm91Ujr/I+nDsmmp35AG4ylvb8vqnGTDIG2iT+i
         On/t2dHePGxtwNhbi+nwrvQqTp+q0ZOEegvi5YGzSKHsnxmWNX74gbFK/UA6g8NSZqm3
         RNrErDD+zV/v/+1s+kM8fs2duDKpSUQ8Zgm1p4MlZWTq+/nRU4i+2AKVl4wqpflZk6Uk
         taynj354aGO2YIkWcz11G2DWJeEMHjTPcpo2Rw/uanboR6ERPrpG/OMYBOZx14CC6hgO
         rE3m3yl/mcgDT8muXzS2RBcYdfDNWOaOdQFSWieilfb3seFaxPsCMtima4rwOZ0o6hd7
         MiWg==
X-Gm-Message-State: ACrzQf3XRuIdXf+xvQxriWSHW/wTyY/JioQ9Vf3la2Se6VfdrdnOBAGp
	+l8qaLvir2RYQJIQzD9E8fiH3Q==
X-Google-Smtp-Source: AMsMyM7+Xxg8rN7mARF8H/zFcQ5I90sT+zv1UiDqHoKrC8RjleUl2bwORbdfdB60pONvnVH5WKhLUQ==
X-Received: by 2002:a05:6602:2a42:b0:678:84be:c9ec with SMTP id k2-20020a0566022a4200b0067884bec9ecmr2211543iov.64.1663871290172;
        Thu, 22 Sep 2022 11:28:10 -0700 (PDT)
Received: from m1max.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id q20-20020a05663810d400b0035a468b7fbesm2440646jad.71.2022.09.22.11.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 11:28:09 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>,
	Stefan Roesch <shr@fb.com>
Subject: [PATCH 3/5] block: allow end_io based requests in the completion batch handling
Date: Thu, 22 Sep 2022 12:28:03 -0600
Message-Id: <20220922182805.96173-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220922182805.96173-1-axboe@kernel.dk>
References: <20220922182805.96173-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_112812_354587_6D537D54 
X-CRM114-Status: GOOD (  13.79  )
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

With end_io handlers now being able to potentially pass ownership of
the request upon completion, we can allow requests with end_io handlers
in the batch completion handling.

Co-developed-by: Stefan Roesch <shr@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c         | 13 +++++++++++--
 include/linux/blk-mq.h |  3 ++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a4e018c82b7c..523a201b9acf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -823,8 +823,10 @@ static void blk_complete_request(struct request *req)
 	 * can find how many bytes remain in the request
 	 * later.
 	 */
-	req->bio = NULL;
-	req->__data_len = 0;
+	if (!req->end_io) {
+		req->bio = NULL;
+		req->__data_len = 0;
+	};
 }
 
 /**
@@ -1055,6 +1057,13 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
 
 		rq_qos_done(rq->q, rq);
 
+		/*
+		 * If end_io handler returns NONE, then it still has
+		 * ownership of the request.
+		 */
+		if (rq->end_io && rq->end_io(rq, 0) == RQ_END_IO_NONE)
+			continue;
+
 		WRITE_ONCE(rq->state, MQ_RQ_IDLE);
 		if (!req_ref_put_and_test(rq))
 			continue;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e6fa49dd6196..50811d0fb143 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -853,8 +853,9 @@ static inline bool blk_mq_add_to_batch(struct request *req,
 				       struct io_comp_batch *iob, int ioerror,
 				       void (*complete)(struct io_comp_batch *))
 {
-	if (!iob || (req->rq_flags & RQF_ELV) || req->end_io || ioerror)
+	if (!iob || (req->rq_flags & RQF_ELV) || ioerror)
 		return false;
+
 	if (!iob->complete)
 		iob->complete = complete;
 	else if (iob->complete != complete)
-- 
2.35.1


