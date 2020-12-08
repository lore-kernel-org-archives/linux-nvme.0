Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CD1C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 16:37:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3528233CF
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 16:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3528233CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lvGZRucw23PY0Gzgt+PhjCxoLuNpCQCdhZ6ZNsMuzjQ=; b=k3ggLyFj7437qn5nGcaKgbyPu
	90rs3MeSt2cCOJmZQWPJHhOWvBYAX+0P6mXUoeqHIuZjIw6WtOD0R8UuLG3jhJi4gZyweb1xEplUF
	GycqAseMbgWL6I4qx+Wf5Laihu5kQlFeopOO4cdvW3HDAumcUxkIdXYU4oUPWDbmFUJOFnJnJdvMr
	Hk+/K/zSuCfkrHTjs4MxiQL7vIJBzB9weM5gxxl9vmcO/2EWFQT7DbJ/w3sFjNirjGIJ2QkJhyRJ/
	D1ugetAesfl6iCk32YauMyrj4qYlWUMw3y+pIpIn+xxBdc0P4maYpHnK5Me6vEmS4pRJywyAX3Sxz
	5LEAOUYkA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmfzf-0002KT-JY; Tue, 08 Dec 2020 16:37:39 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmfzM-0002AT-CY
 for linux-nvme@merlin.infradead.org; Tue, 08 Dec 2020 16:37:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=mDWnaDevg6j/LIqbxuNXDRQmS3LZ4FlK87nsZVHjQJ8=; b=JFMbcCImgU0rQUC46Gh5jSfyXr
 R7nm/tGTSpS/6kdC5nXL0AcPvDP40nPp/xnt3K/t0jcNxJSy2Q00sNapIdBCx2b17aOaWfL2viSLb
 47tiNb+yd8CJy2aC1M+1ZWgg+0TQiG2VyKp7kdrO9eVD0TftLKPaM1GNODR7R53T8XiaJdQlzVdse
 sngMuhgBgn9AbqpL+X1QiU78oC1SF/J7r7DPoKLZyhopVWOMTBQL/1mCBUouLBSaa4r7jorYr9uoa
 AxkxjKPnp82d7a6vH8VlGv8HCE+DtQGF9GPk+/kycHqR3cnS7P4KER/8iMbofhUXyiu64iqu9ITK1
 IZNixDFg==;
Received: from [2001:4bb8:188:f36:7a30:8a2b:aea3:231b] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmfzK-0001OD-V7; Tue, 08 Dec 2020 16:37:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/6] nvme: allow revalidate to set a namespace read-only
Date: Tue,  8 Dec 2020 17:28:29 +0100
Message-Id: <20201208162829.2424563-7-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208162829.2424563-1-hch@lst.de>
References: <20201208162829.2424563-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@redhat.com>,
 Oleksii Kurochko <olkuroch@cisco.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
 ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Unconditionally call set_disk_ro now that it only updates the hardware
state.  This allows to properly set up the Linux devices read-only when
the controller turns a previously writable namespace read-only.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/nvme/host/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ce1b6151944131..3a0557ccc9fc5d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2114,9 +2114,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	nvme_config_discard(disk, ns);
 	nvme_config_write_zeroes(disk, ns);
 
-	if ((id->nsattr & NVME_NS_ATTR_RO) ||
-	    test_bit(NVME_NS_FORCE_RO, &ns->flags))
-		set_disk_ro(disk, true);
+	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO) ||
+		test_bit(NVME_NS_FORCE_RO, &ns->flags));
 }
 
 static inline bool nvme_first_scan(struct gendisk *disk)
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
