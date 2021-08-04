Return-Path: <SRS0=aO7+=M3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA8EC4338F
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 10:06:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1656960BD3
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 10:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1656960BD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7e9EJgRWejoyN8vD7yo9tgRr5ljyk5HRO25OB3wy0f4=; b=Ai2JEtcedKOzlR
	sgfj01fNXusmNwfRLKc+HtTi2lakL3mPGaBtQSqZ2IQeUQXx7OD2neWf21bAWytXL+UquS6Z5/kPI
	JhclNDukmr6eExr1ct/u1QvFr4zP0hs58VC4jYeWsiRuDyfSN5jO/DskvWoGLldBlS7mWQNT/dFdo
	18wmMfDp9vRYbJZ2t9JlZSBfUfWnGyXXBpccIf31WUyrV0R1UEBnbF5THX7K0W1UpCb+Nn8l9FHh+
	Y2qaGFLoJG0XXSxCqGvuRY0wX2CMlOijclZfI5C4YuIv4LwBN0EJaK6WyjwHQA8CZfcRYN0U0BoKX
	DpStsVon9Y6zyZl/X4gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBDn4-005blf-Ba; Wed, 04 Aug 2021 10:06:22 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBDlD-005av0-Dy; Wed, 04 Aug 2021 10:04:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=MYjzWIN6XQEFICmldZLH3sdyvOqOWK9wZMA+6ihrUcA=; b=O7IBlhny6ifqtHjxI13sOJWXUs
 eeyTtmk4QewshMsEtOW3eNvrRQdNTcXOqBxV3+wJs6R9AS4qvUGsrAbhJOf5pIfAicSiQG7xPlYoE
 t+emk+wZ437kh/Dkf98G6hRKjtjigq73lKnJTtZVrWzzNyhvnyouHG6kCdQuqD4YYZ0AIOgCBLbif
 O8hVmpGx7+skcpmL0Q4/OraMOJuqr0hM3s6GRzB40hkeNoAwdK/wELmR3ASeiq4pCL6TaK3mp0BIF
 orbY/uIw8fuLR4GQAqS5iVsyFQ5ZJvfJ+12oftCbUxX0/Gj3WN49MT2HDXMh9xeeaimKyiag4GfBO
 nS8YaNXg==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBDkP-005fZa-K7; Wed, 04 Aug 2021 10:03:49 +0000
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
Subject: [PATCH 09/15] bcache: use bvec_virt
Date: Wed,  4 Aug 2021 11:56:28 +0200
Message-Id: <20210804095634.460779-10-hch@lst.de>
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

Use bvec_virt instead of open coding it.  Note that the existing code is
fine despite ignoring bv_offset as the bio is known to contain exactly
one page from the page allocator per bio_vec.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/bcache/btree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 183a58c89377..0595559de174 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -378,7 +378,7 @@ static void do_btree_node_write(struct btree *b)
 		struct bvec_iter_all iter_all;
 
 		bio_for_each_segment_all(bv, b->bio, iter_all) {
-			memcpy(page_address(bv->bv_page), addr, PAGE_SIZE);
+			memcpy(bvec_virt(bv), addr, PAGE_SIZE);
 			addr += PAGE_SIZE;
 		}
 
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
