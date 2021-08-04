Return-Path: <SRS0=aO7+=M3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A526C4320A
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 10:09:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DCCB60BD3
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 10:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0DCCB60BD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gwO+/BvM8GevH8twWwWs+AhOoWZjVHDO2TO0098ZoyA=; b=Jpw/1av0cb8c7T
	7PMi//4+WxlDHCvfEiDVkuvobliEbm+XR798BAymJ2XsSuPJq3FpEAmKFiYqkI6eJr38Ms5yYJQhi
	wbiEnS7XDCrxpfdwqtwibV3gS6S7GRgL21xxnRiJ5C0QrXztX2cYh7jbtwKWSGrWbFh7GjaTDUePW
	O4jg9MRTA7Mi1MHclxHoR+TKoKJIc9jP6WDYpoq8V6oiJBSkyrilv9VufeygQaJgGz9oObdyfzN7/
	oJ5L2ys8/7+5/46otbGSqLbFtYVDauhuNSYaAZg7hn/6D2bXL1RB4/ENMtexIeDw0ow5eDy4dLYWE
	33OuaeRChfjeM73QtWdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBDpq-005cub-0M; Wed, 04 Aug 2021 10:09:14 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBDmp-005beh-Th; Wed, 04 Aug 2021 10:06:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=NZknjnxuRdtVbQDQYhSn8YTBpZ/TDM68s7+7a3SjKg0=; b=btczJd5QJxPrmePLIu+d3R+FxZ
 iP+SfhLRaRrUCwlvcXh6uqOXKqHWDqH+IS9T4Qr1c3Y3S5zGwPZuvTui5y1euzpNDTmFWZuRemdqz
 PNgBVV0qeCdgNBkm473GGvmEIjMhT/3eTMMMJd3gyghRK90WdcWMWwiSOzomnsUnqLz235mJAIKXg
 xQBi5388xGH/XQ1fLh82k3mCJ3JLqUErRqrn41ICzF8+Z001NhPZh567KvBZo+EHrbeVp7XYo2jAz
 2Io/T7Mo6KNEag5y4PJfRwGSCnXSdGAYE6mzQ9DuGxwarjmBMxhWvYeh15e+JnfvyM32rPYPjokZ2
 EBliTZcQ==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBDly-005fn4-Il; Wed, 04 Aug 2021 10:05:46 +0000
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
Subject: [PATCH 11/15] ubd: use bvec_virt
Date: Wed,  4 Aug 2021 11:56:30 +0200
Message-Id: <20210804095634.460779-12-hch@lst.de>
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

Use bvec_virt instead of open coding it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/drivers/ubd_kern.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index e497185dd393..cd9dc0556e91 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1268,8 +1268,7 @@ static void ubd_map_req(struct ubd *dev, struct io_thread_req *io_req,
 		rq_for_each_segment(bvec, req, iter) {
 			BUG_ON(i >= io_req->desc_cnt);
 
-			io_req->io_desc[i].buffer =
-				page_address(bvec.bv_page) + bvec.bv_offset;
+			io_req->io_desc[i].buffer = bvec_virt(&bvec);
 			io_req->io_desc[i].length = bvec.bv_len;
 			i++;
 		}
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
