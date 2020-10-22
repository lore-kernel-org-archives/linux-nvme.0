Return-Path: <SRS0=3deH=D5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E0BC2D0A3
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 01:03:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED99223FB
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 01:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OcdDNHuI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OIFSng9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED99223FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LkSJaOXnhc0rloJLXIgQJKqD+8v+hroy8TTceH3oJTA=; b=OcdDNHuILbMhBceM3KYxqYpia
	8GuByKzAteVHODBseCFm0xHOdtYsObcmwILo4iySL5dzXsjakcX+O2QSKR5hm+/sfx/BG7ELgDKic
	lUAjR3nBmGFs8yJby0rMuMsDa0MJ5T3Hv+gtp0+SBNjTXZGTizJzIg63+IZlX22e0NftFYbv6K9Rt
	He0eGe3IF/f2IwuQdFx8uLJdj2gknDKUykA06YJuj1atJUc2qWKx7YYJ/L+95VL0MURSHK2E6Oke+
	LpOtHfgkOmqyPk06FAL3YPy0vWfgDjKLAq8jLCvpOj6LE8XQdUnmEiRpA12NRpebwMCjUIgODrH2I
	0QHP2pc6A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVP0f-00049m-Mk; Thu, 22 Oct 2020 01:03:17 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVP0d-00048t-1m
 for linux-nvme@lists.infradead.org; Thu, 22 Oct 2020 01:03:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603328595; x=1634864595;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/RfTDNkwgpWkWBDLqJjIjFnT/dbeT/R3kr2Wn8mjMuQ=;
 b=OIFSng9WbE339fNpWMHs14XmpEdPVpkVJmyF5REOirDfOGWUw7NG3cOT
 0dIVKTaIUj3NSUX0quewuH/Y7HEknNGiRvj76t6FUODa+HytuLkKkxC/0
 wB+WDUaWuyjTzrUahx/tp3uvicvxU/659iZvqrx8eX6CoTN7s4Tvzi5sR
 gkWW4iuQe1MD6WDWmsljnKOn+Zrdu5My8sjH0Kpjaf4QZ1q/S84UhAKL7
 6PyEYbpE5dezUNUEaCmWeV6RXT06QFQRyLZzi4E4e2VFz/mCDFI9EHQ/Q
 etoN2QsKAK5mfFs10iUPw/dVQPTdyuUtcPHYOx+AL7BnaqIUVnnXBWsZg w==;
IronPort-SDR: HhK7V3TeJTqA5St9tkPrWu0J7rtN/b8H6BtzGmgKQLHGDGoNLl/vBX7JWpfGSAVMQg4PBrHwT3
 PnfL4qhXpLkgo8cTBZu+EoVsiZ79Ntn/6+UGUw/YyAbC40Plxl+fr5kY2Et4p/Nts7AKxW9b2f
 Hw3W9PA8cBhRxJfa6UFnqBBVE6wvARC1/G3L5jrsoUQUuuTn5xm8f+34vlw0VQIO8U6qekbhZg
 zu235S5qAj09t76rHRhyMazKezp61f1kmH3kGF8y7zJdNRMGGBZhThhQ/dfpYVRmp95418K+vc
 Ia8=
X-IronPort-AV: E=Sophos;i="5.77,402,1596470400"; d="scan'208";a="150653012"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2020 09:03:13 +0800
IronPort-SDR: qrtbkU2w32YH9dSnPpygmQ0NhHx3hCk25quoDQ9pOAMdIdyFlaYszOPpoCzrzPp6NbEHwBGoWI
 bcIDDnwdgyMljlQVDIJZvJ+u6ERTIwrdZ92iPJtBbG/UjnbslrW/2NgI61lsJA/mlNtX3wFQVn
 ZX/LmkUfMjTYyyA1xuxMdACL4fVz8D23qvmDBFEeG+agxpFyvyOfi287Y/e2C8U+B6gorEcWYc
 DzyO6AnEenT+HQbdzgnmStz2Wrt/LL6JZz/ohj175ySL9HN9JGGe3KzzTlm59bfKQwJNIJng51
 DtyGpl+O/bXXg3J/RTtGCeqx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2020 17:48:45 -0700
IronPort-SDR: R3PBID0f94uoiQ6ju64A/GLZ0XL/NIYbC2b0dR2GUtfcspSUZDFR0ENg/IrW2Ne1/h5dyHGvf0
 7hl+sMUvNM4dxTMcOcFD5WyxfBT59aRnqRUtemncthgRfF42nLwrr9Il5y4fF0u84wdUdhXxxb
 HmNNBYlsaF9q7Lm8IITGcmV69bL6xuOotmIAEIE8fTfz2HPr8I9cgz89xMBn4dwQhCgJTg+/Qr
 Fuh7agPymWeQj/CviyKDo0c+XKra0++jIl+j5SLkoMd0ckvnoV7/+e0HpOT/ZPiwv7Yy336yK3
 /Ig=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 21 Oct 2020 18:03:13 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V3 4/6] block: move blk_rq_bio_prep() to linux/blk-mq.h
Date: Wed, 21 Oct 2020 18:02:32 -0700
Message-Id: <20201022010234.8304-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
References: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201021_210315_238732_98A339D8 
X-CRM114-Status: GOOD (  13.05  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is a preparation patch to have minimal block layer request bio
append functionality in the context of the NVMeOF Passthru driver which
falls in the fast path and doesn't need calls from blk_rq_append_bio().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 block/blk.h            | 12 ------------
 include/linux/blk-mq.h | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index dfab98465db9..e05507a8d1e3 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -91,18 +91,6 @@ static inline bool bvec_gap_to_prev(struct request_queue *q,
 	return __bvec_gap_to_prev(q, bprv, offset);
 }
 
-static inline void blk_rq_bio_prep(struct request *rq, struct bio *bio,
-		unsigned int nr_segs)
-{
-	rq->nr_phys_segments = nr_segs;
-	rq->__data_len = bio->bi_iter.bi_size;
-	rq->bio = rq->biotail = bio;
-	rq->ioprio = bio_prio(bio);
-
-	if (bio->bi_disk)
-		rq->rq_disk = bio->bi_disk;
-}
-
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 void blk_flush_integrity(void);
 bool __bio_integrity_endio(struct bio *);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b23eeca4d677..d1d277073761 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -591,6 +591,18 @@ static inline void blk_mq_cleanup_rq(struct request *rq)
 		rq->q->mq_ops->cleanup_rq(rq);
 }
 
+static inline void blk_rq_bio_prep(struct request *rq, struct bio *bio,
+		unsigned int nr_segs)
+{
+	rq->nr_phys_segments = nr_segs;
+	rq->__data_len = bio->bi_iter.bi_size;
+	rq->bio = rq->biotail = bio;
+	rq->ioprio = bio_prio(bio);
+
+	if (bio->bi_disk)
+		rq->rq_disk = bio->bi_disk;
+}
+
 blk_qc_t blk_mq_submit_bio(struct bio *bio);
 
 #endif
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
