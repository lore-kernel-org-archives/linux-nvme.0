Return-Path: <SRS0=aO7+=M3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E8BC4338F
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 09:58:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEBEC61004
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 09:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DEBEC61004
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=32svFaa6BcWZDR6GBoOhzm5+8uNoxafAhHXr9k599eY=; b=t5sak2LqAWbjb4
	Jyn2G+ad9EhOxEJyWCvsG2O9OJUn3isOxylOt1dnxQ7SwEHNLoBFrvbBaWaTDMlSUpXFG2L41aUpO
	rMtjZXTqi96KiT/062iav/SqkfzvVoaclfqhW3kVvnDkmwDU7O59phMQgXTFad6tkshTQ8VivihPv
	eZHkAXwRqeuodSEi3Wx74WKCqa3cK2TPReYWDYazrTesyA1/ZaDS2LX5sfI0FLXxVBANL7CBkg754
	3P27WsJpWsrd4VYlJwqg2lxNL45GVkTIHVcqJ1Xx4y0bDP/BzXAQ3zc2zLfj/uyE27TKGC93KNmBp
	EBqBSfIwBJmRvhyDoaIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBDew-005YC4-2h; Wed, 04 Aug 2021 09:57:58 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBDeu-005YB0-DD; Wed, 04 Aug 2021 09:57:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=UJrCb7CGT+ZAjfUzBrDvox/kj9NEI6DcJ2NjSWkF2zM=; b=sYPxayznDPwIRyL7nKUygoZD3k
 dt/bjMT5bAbfRZ13gnpvjc5NY9EksxP5d32LJBcepAgioku0FtN2VHK7R7M7Afs6OF/FfY8D4q2NS
 Ys9QfpkLm0yZEn2Yq8/JAyeP6uZhYAYHcOZgrcndDEeHPgfKy9aR+1m/S5KIqNBPJusPfmCvukDGK
 HDIiS0Sp1Dg5y6Sguy/uqGCvuCY2RruHbmHkNPU54WL6WooDs1ZFZ0+/VZCp4ENDmurNe1u3w4CYN
 wJPMT1dd8CyN11OgdFiYEiEIAngynUkdd6r9ITrs/sxLPRokEREfq2f3JisClKZP8l+gfo3TC+ru9
 p2MBCyUQ==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBDeG-005eu2-Q4; Wed, 04 Aug 2021 09:57:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Geoff Levand <geoff@infradead.org>, Ilya Dryomov <idryomov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Song Liu <song@kernel.org>, Mike Snitzer <snitzer@redhat.com>,
 Coly Li <colyli@suse.de>, Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Phillip Lougher <phillip@squashfs.org.uk>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-um@lists.infradead.org,
 ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org
Subject: [PATCH 01/15] bvec: add a bvec_virt helper
Date: Wed,  4 Aug 2021 11:56:20 +0200
Message-Id: <20210804095634.460779-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210804095634.460779-1-hch@lst.de>
References: <20210804095634.460779-1-hch@lst.de>
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

Add a helper to get the virtual address for a bvec.  This avoids that
all callers need to know about the page + offset representation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bvec.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index f9fa43b940ff..0e9bdd42dafb 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -229,4 +229,16 @@ static inline void memzero_bvec(struct bio_vec *bvec)
 	memzero_page(bvec->bv_page, bvec->bv_offset, bvec->bv_len);
 }
 
+/**
+ * bvec_virt - return the virtual address for a bvec
+ * @bvec: bvec to return the virtual address for
+ *
+ * Note: the caller must ensure that @bvec->bv_page is not a highmem page.
+ */
+static inline void *bvec_virt(struct bio_vec *bvec)
+{
+	WARN_ON_ONCE(PageHighMem(bvec->bv_page));
+	return page_address(bvec->bv_page) + bvec->bv_offset;
+}
+
 #endif /* __LINUX_BVEC_H */
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
