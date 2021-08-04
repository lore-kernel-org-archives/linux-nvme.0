Return-Path: <SRS0=aO7+=M3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7F9C4338F
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 09:59:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DEB5601FC
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 09:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9DEB5601FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y7nccLxRkquGcI1cTcA+PkWmJFGYVot66zNbZ/U+dM4=; b=Jc+zq8jnVB33NX
	QqgexDNegTcPIzL6Yaap0S1b9vxWhqkJ7IbPHdFELkXiEsQmqKDNi9Hg29HucrCdsWD2nZBWC6A7n
	3SH6C0rHZa8+wcoSaUqUC7AhpO2pvhsEpHdpNLvCto6rHgrhrt1zH9t5i+fL0uGq9DfZ5RoN+G+m2
	Rnt/qdCk1Ky0RFlRO5UyRFqTDVgnG/BdhJFQqlYXm63Vo4QhkB1z/KoGiEZT/Q1J7E7naeovt4sJh
	8HcB0Dn0fcYHhH12iV2kqjhWjLE/GnBcva/Xoq0mfDTCTX47zzlPQRPcqm5mk62pqrPYdddj6Z8lL
	HNBc7yVt0uHmucydRiDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBDgc-005Yup-Po; Wed, 04 Aug 2021 09:59:42 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBDgb-005Yts-2S; Wed, 04 Aug 2021 09:59:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=C7BNoQnfAhpf1wqghahug1gwysuiZ4tUzmHR/Uv5INQ=; b=DjcorNtLkts0oP6dnpTQfumsvp
 O2P1/zhII9l+7JUkGtZMN2Pn1xTz0ZLBQgMMVSZityRrbsgwhAkYOjzhRRwjxHzFnaLs33AHuOS0f
 3+v2K+PBrXa476TIP8IbNnljuGnrm+SbD9rl5MQwqfsq2is6VruACOLulFtvIYbB+zAWHWjcwxGNF
 Ew5/GSbbMlxTpikTCQjGda88tmEsu5PwVMA3zd0BwewYOk6UeHdzz7NlslL6lXnktoKPgsn1ZtEU5
 gX4nbrwsXi8O41tKqVUHrft0/km/Fas41l1i1kIVNcS5jAgBmoAAV1jnnV2ZJQO8q54pLY2hOG6nR
 FsMBFdRQ==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBDfi-005f2N-DE; Wed, 04 Aug 2021 09:59:07 +0000
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
Subject: [PATCH 03/15] dm: make EBS depend on !HIGHMEM
Date: Wed,  4 Aug 2021 11:56:22 +0200
Message-Id: <20210804095634.460779-4-hch@lst.de>
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

__ebs_rw_bvec use page_address on the submitted bios data, and thus
can't deal with highmem.  Disable the target on highmem configs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 0602e82a9516..ecc559c60d40 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -340,7 +340,7 @@ config DM_WRITECACHE
 
 config DM_EBS
 	tristate "Emulated block size target (EXPERIMENTAL)"
-	depends on BLK_DEV_DM
+	depends on BLK_DEV_DM && !HIGHMEM
 	select DM_BUFIO
 	help
 	  dm-ebs emulates smaller logical block size on backing devices
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
