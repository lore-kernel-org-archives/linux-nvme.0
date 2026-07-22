Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1280BC4453C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2026 18:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V5hliKyCAPWFZqHS5mW2T1dJRPt4J/vTka7mcNCHq10=; b=c63a35jpO/4KUREflI5omlRw1f
	KWRLPZGsdzNUwK6rCJCx2uZ9vvKLk/AVuOL1wEk17l9h5n6qiG6AOQMLEQKWrrjjfylBMCrJbZHhq
	Z1JQuWISAXM4OuIljk91lLwg9znnZKVnLBMw/4Up79vigK71Vr+m9uLF+poslrwlICnjWdipEeLBY
	BWry5wryhkMr7Mc8fcjTTTexZFnEi2elIlMSbiAc+JF6OXk6xHISIWWu+nws4jQfxbWaQmmdZVdgE
	Yn6tbQkP0+rtyGlKFDvrS4itYeDMpxuNuIU/GD/1TF9GcrR1L6jTrNC5JTTxVaRDklLnZd3Hm7dqK
	B6HSvMcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmc9r-0000000Cags-139A;
	Wed, 22 Jul 2026 18:59:07 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmc9o-0000000Caeg-1rPa
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jul 2026 18:59:05 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so94471485e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 22 Jul 2026 11:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784746743; x=1785351543; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V5hliKyCAPWFZqHS5mW2T1dJRPt4J/vTka7mcNCHq10=;
        b=afyzuj0YUnFbISSqWsU5OgMlUV1JvgaRTi0GjZx7WfwuitD7PwOTmKX0TVKK6w8PAK
         Bo1kSGy6J7G5M4IOq6CDq0xRJqgG27k3JZ0XMf179+dW/aHD1w/bUvSpvVXzLk7wHntQ
         m7mtBrlUVJfthNR2FyIJrdfNEzkk/Mfa8uCKuA3oNkbj6tTN2LTOqSsj7elvkDhSJipi
         6GZAD4ugNF1k6n/5ivuN/GSNwHbfsqAnA/h+2JEd0QUsCnRLJOFiwN7u1dhOAk1qR6Vm
         riFeCN/DGhEKXT2yOQ/98/6Pk6FpXKjL/pqBk3CuC2ZOEPKVclef0MD7P/yI9pF5zgs0
         GCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746743; x=1785351543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V5hliKyCAPWFZqHS5mW2T1dJRPt4J/vTka7mcNCHq10=;
        b=U+6e0AUl/MieGuPe1tfGXAYANgFgwVxbEG1rBNCdegQQJRYw7LTcmvLsRKhlMN5w2U
         iZ9G68SpMjbtRUfHHmE2HnZv99ur1Ptql95riKHSm8XFMXyfzT45BDsVda/yIswpltIV
         Dueal9dv6STnP3gfnkj9OvEwXk429aThWVhX25ccidMQlLZ1Mnjm+Eex5KBCEqGmyIgO
         06FnzjYw0J7mrj0Ygo1+bneu/b7fOLFlKpRZ5JGXF81/roZCYrhyWvaJKFrCtCFW2xrf
         mMqhDyjhDCeyLeBM9AYMTDh/PtHI1OU4o0EcYM8fn/kFgknlvUyhnl3GrpWFtrOZeEW2
         EIAQ==
X-Forwarded-Encrypted: i=1; AHgh+RqYJ9TfjsmC+OMF9Jg+uu6TwW8xVLpmy+Ss+2bEE0Bid3qx3O/c0uuG5TZvEV7AwwqQeAkrpknue+91@lists.infradead.org
X-Gm-Message-State: AOJu0Ywkyac0eYVCyC3XSurgWI4EgS+Pci2C3Ktig1P/gto6gLLVl+FB
	14pF0JiTZ6fJMR7X4JNMWSdevUQm0PNF0XMFezieRfozM8kxvmhHjR+AAi5sIqU91Q==
X-Gm-Gg: AR+sD11nN1iFKPhtOX8Gm6SvHVegsy4XGJ5sMSv0gQYOGZOZKALUaIJNXA/sjXaTbes
	6XlxBszTQbbeZYKfcqPZg+6J3MhGfJv3cna6g+dGZLottWI5vSUFb/ZH/HGMjekJ5e8j1jR7T1R
	7nE/sneNkeHHreUvk6iGUK1UUyMPHYWEhjCTRdx3ecE/NFNCMM5qtU2bZbYJ0Zg6oPHd//Hkwr/
	wUI0KrF3teNfyvAtA0125wGUWTA1nwYh3NESu+RNoAYE1IDx8/y/lFErXy80WCPS480qVBNB9Vz
	T05AJ9eGLMtDIHq/ltXmNNeAf9vVz846rLbNxcKzjce2E3+Mv0UNILbjmUUeBuhv7vC4DpOK7NC
	Qc+6nqlK/z+4RFlYmhmnK+xAEwVgEeOfnGG9xx/lKT/2erRTvkrcpHcIss7vDG1MjHVJ/56VGQn
	HS6u86AYaq5hPpH1FuW6MoxNGnCDghup0KOMdsovwHdugB+4k=
X-Received: by 2002:a05:600c:c174:b0:495:63e4:7f78 with SMTP id 5b1f17b1804b1-49563e47fa7mr133877135e9.10.1784746742455;
        Wed, 22 Jul 2026 11:59:02 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495730353d9sm13740055e9.12.2026.07.22.11.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:59:02 -0700 (PDT)
From: Mykola Marzhan <mykola@meshstor.io>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 2/9] md: ensure REQ_NOMERGE is set on P2PDMA bios
Date: Wed, 22 Jul 2026 20:58:34 +0200
Message-ID: <20260722185841.449934-3-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260722185841.449934-1-mykola@meshstor.io>
References: <20260722185841.449934-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_115904_514431_CAE054A9 
X-CRM114-Status: GOOD (  15.46  )
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

md_submit_bio() strips REQ_NOMERGE from every bio.  For P2PDMA bios
the flag is what keeps requests single-provider (see
__bio_add_page()): merging a P2PDMA bio with one over a different
pgmap, or over host memory, maps the merged request with the wrong
bus address.  Set the flag on P2PDMA bios -- bios built via
bio_iov_bvec_set() arrive without it -- and keep stripping it
otherwise.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/md.c | 10 ++++++++--
 drivers/md/md.h | 15 +++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index d1465bcd86c8..3770bdb4d4b2 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -451,8 +451,14 @@ static void md_submit_bio(struct bio *bio)
 		return;
 	}
 
-	/* bio could be mergeable after passing to underlayer */
-	bio->bi_opf &= ~REQ_NOMERGE;
+	/*
+	 * A bio md split may merge again below md -- except P2PDMA bios,
+	 * which must stay single-provider (see __bio_add_page()).
+	 */
+	if (md_bio_is_p2pdma(bio))
+		bio->bi_opf |= REQ_NOMERGE;
+	else
+		bio->bi_opf &= ~REQ_NOMERGE;
 
 	md_handle_request(mddev, bio);
 }
diff --git a/drivers/md/md.h b/drivers/md/md.h
index d8daf0f75cbb..73df1a6eccd8 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -11,8 +11,10 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/badblocks.h>
+#include <linux/bio.h>
 #include <linux/kobject.h>
 #include <linux/list.h>
+#include <linux/memremap.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/timer.h>
@@ -22,6 +24,19 @@
 #include <trace/events/block.h>
 
 #define MaxSector (~(sector_t)0)
+
+/*
+ * P2P and host pages never mix within a bio, so the first bvec is
+ * representative.  Read bi_io_vec directly: bio_first_bvec_all()
+ * WARNs on the split clones md handles, and data-less bios have no
+ * bi_io_vec.  Not valid after the bio's iterator is consumed.
+ */
+static inline bool md_bio_is_p2pdma(struct bio *bio)
+{
+	return bio_has_data(bio) && bio->bi_io_vec &&
+	       is_pci_p2pdma_page(bio->bi_io_vec->bv_page);
+}
+
 /*
  * Number of guaranteed raid bios in case of extreme VM load:
  */
-- 
2.52.0


