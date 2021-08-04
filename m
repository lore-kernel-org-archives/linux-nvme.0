Return-Path: <SRS0=aO7+=M3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0988DC4338F
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 10:07:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF75F60F0F
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 10:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CF75F60F0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x7YCneJ70iSgQbBZv+Fnzvd7QHIkM/UKVsBItAmHnJw=; b=viFgR8sUTV72ym
	EWWSf9/rSLzRNvRxAx5b1GvwZC4H4U7UJtSuTpytsU9letI7SK+kaAfq4voQ/7f9Qzw+lmSUjFpzl
	4/I4DxA5nDE4LOfZpWACU4rAE9/B6kDsLybcPNe34zdrUIew+yT47bURejysfz1JoDm6rcA1r5AEm
	6TZUFRF1f17E5yI2jmjW2JKPqSMuSLm/bIHTbIRji7X6aBZPNsVpPOnfviTdtXZXlExQtDyzXmZc9
	vUAHTzO1WqiURc4uixxcdRuqUyCy+6pwfTlNscDC5ShMGLQlx3rfwYnP4l2xEonKTeg4/Lk88eJAB
	E9zxkOHwOn1ybocS+NQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBDoA-005cFM-0S; Wed, 04 Aug 2021 10:07:30 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBDlz-005bI9-Hy; Wed, 04 Aug 2021 10:05:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=dYcXyjvxFPaNEf5TNwLHSpdHad4RJoLUYH/Eh2LY224=; b=M53rJ+CQ8lQ4cD7WtCKS/GnMEp
 odCybjbHRrL6lXoV/C4xRLyzI3taQPoI5jeicWaJKCFztdZWjTcUyCISpGMaPta3MOa/dW3GPAJXi
 NZizDS/+2ezXcfB4Z5v0ipw/q8fzOnp+93V+AIQSmf+Um+lCBP3IQuVu9DH4qzGA4odDqxR6+Dbyq
 jbtPWT4pJbPEsvgX4jFyWinGFi+017VlG4xfdXAJqDMjWiB0Tewr9GBWCVI24qNaCZOnnXM5pag4g
 rZhKGgG18ckW2QamG0HaY188YH4xbwMuGQhuQRojd55CrYDHWEzPTM9PBroO1FVr7G6wqdCzH8FTF
 TxAjFTOQ==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBDlD-005fg4-2r; Wed, 04 Aug 2021 10:04:34 +0000
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
Subject: [PATCH 10/15] sd: use bvec_virt
Date: Wed,  4 Aug 2021 11:56:29 +0200
Message-Id: <20210804095634.460779-11-hch@lst.de>
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
 drivers/scsi/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index b8d55af763f9..5b5b8266e142 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -886,7 +886,7 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
 	cmd->cmnd[0] = UNMAP;
 	cmd->cmnd[8] = 24;
 
-	buf = page_address(rq->special_vec.bv_page);
+	buf = bvec_virt(&rq->special_vec);
 	put_unaligned_be16(6 + 16, &buf[0]);
 	put_unaligned_be16(16, &buf[2]);
 	put_unaligned_be64(lba, &buf[8]);
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
