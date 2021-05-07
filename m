Return-Path: <SRS0=skSE=KC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5CDC433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 01:52:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D23C6103E
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 01:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D23C6103E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4ibur/9w80PFrXUHOBwW/OZhdZ19JxNjUVrPj0/eBaw=; b=RBpLw042VjO6bBp9gp2aYbDHR
	x6Q+MlPzJ6Wv+qvyNZeLo5fL5bmQItHTf2o89BAp3DT278laI1pc50K2plnYI3QElwBnDsnG44spn
	z08yXBnzfcAhEojMU3/p3gk559guA9KQ2sNLvhQ1kt15NydyynzpzB0AHTCuHCyIMKKQjnf6DCrXP
	Q+SOc20+nxiHKVAi4gT7kNzKTKJHFHVsu7790OlJ+Tl/eBSHGq0mTd8KCejSWtHD83zBKvdtaf1+0
	yEtfDc2JZfaS2W4/3eHOZNyZ1LeYFaogCtAh1ML1pGJKBZrz9hP+sfGhZLOm//fUrlzPzxdhllUVw
	n/OlrtW/g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lepee-005oUF-6W; Fri, 07 May 2021 01:51:48 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lepec-005oTx-Ry
 for linux-nvme@desiato.infradead.org; Fri, 07 May 2021 01:51:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=5GZlDdmWqWuF5DH6mWYmdTjGoPeu/zCHub4+OxdffXs=; b=M4m4BQ0SNFyq2yQ2N8p+J5Y1up
 gNlzB6nm1sdn2hy446ss3qybre1rBB+nIcfTV3phKWdrL2EkOTdCt02Apiiv0olv4rCz3YSUw6s0u
 21imx2EhEQ6OxAtor4nvOEZvJEq5UtGRard9bl0fXBbU1JxRIjE99AWh1eZmFfl8sVMODAAsKQDFr
 Vstopnytur7HNkYVSygEhuKs5aZEYiFmBbn4s+04jTTCZ5DENQ4li45MQpp1y8pPYnOqDD5oq2PXc
 gbvIjMuw82MEGBvAJY9rcJ5urAPmHBUywrIgk15aJbd57SmvGbAQ/XbqW2r3Wt24oLKBUkel7cX1H
 GRxf9+ug==;
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lepeZ-006Vpr-9Z
 for linux-nvme@lists.infradead.org; Fri, 07 May 2021 01:51:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1620352303; x=1651888303;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IRozEP1lQUzP//gvSYGHbQLynNlG9ihofD68z4DlDK4=;
 b=fbahy+u+v87R9dZuIUjp6oOBCpk6xs2GpgN5U7AUqm+gV5mfPxl6AAs1
 8iU5VrQWuQhIv5ozP7f6fcRFetEkH3BzKjKjbRjoguFLfZ2BGqhpIy1v9
 4GlN0q0gxR4P+BLjTk6J14+sOpSLht54+AeJVnnO4FEn2yTevLwRidG+w
 2bhQb1/5amuj6OUQPfKMbBL0ML9Sj15idTM2brFHxCofaERA7AH9tgfgX
 FbST5dHCU2v5YW5HC5c/FUlmZaAB0E/QCaguXg9njKKkllHqHJiTzjkxV
 AgGKcmGIiUdbp/Fr6ilyDfI4kbMas3HBTdSj672mMisoLEw7I3IRFBfuB A==;
IronPort-SDR: UdoS1dVGNMRJqYSlqEyNX0MUhnsJWSJHgqm9KyoPytStFnljAOR6J9XuDGPwYo+1Ju38GKTvDH
 In3cerXtORB0e5DeWxu5Kdt8h3rjRJU8lWY/RqhLMv5PpKRZXTak7cNVCFOQ7rPqRX5EFmrSPG
 RKv3xweBSQDOijSk9QFpDat3MVWFlztoLuKElcMgZeRr3J6rwYtGqgf5NyUwobfVsaijOdNOV/
 gZEX9QUCujZkqjy7eizAfE1L+kz27u6wmXdMuEe98dMjQJeRVm9UfrE9m8ZJ3W7VvX8uGZAvAa
 FPs=
X-IronPort-AV: E=Sophos;i="5.82,279,1613404800"; d="scan'208";a="166711735"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 May 2021 09:51:42 +0800
IronPort-SDR: 8CNlrq34AScOvE5esxKF7+NzJvvXx91u81otAjsQcZHpeHXOf9iA/5JhaqwrLCS/A9ilNnnGBC
 Jig7wcTyKWcAKY88PW3j+YBUPH0H9NJmMkhiq2T6EVnnueNQiptMTrGDr+4TF+9U939w/dgVoj
 NJ71EbloJcsy99K+k5J6jQF3xQL8a5Jksrv8KLjUhgrSNNMMI9mjTRF+50H8i0TEkbyDUGy0sq
 Gi7PvFUztp5eFyNbCJbr2I6E4sk5BSb8RC4doh+WmH/4IjeWwibgYHruXcLCRt8dSMV7PtUAvT
 YKUqAnk75FZ/cqUOBb8JnDI1
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2021 18:30:22 -0700
IronPort-SDR: Z0rG4KZzDGRwnJFIsGr4WKjPii6nJVKuGRxcUO12z2mWHj1T9QjdDNHZRHqo872utLLx4SjgOm
 Rbi+9xD6NZZOuHaDl8rzqrFX0VElLOtM9a6uydtYbFXYFb5aFeEysjIbH9i0sSgYt0MNbwJhsq
 fd4u26rW39aOMWBVjQeOdwSa/KXGZ6d80yuUTCD91XAQXiT9SIdefJMi3nkRwCbJQjlFR/4JY9
 4xsh/yE0aoiyzGI18Zxf/rmaY0Yb98aYNRTxqVPmj1SN8L1FhwxbfrJp+WwmXJy3Nv4zv5oKEH
 Ozg=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 06 May 2021 18:51:43 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 1/2] nvmet: fix inline bio check for bdev-ns
Date: Thu,  6 May 2021 18:51:35 -0700
Message-Id: <20210507015136.11069-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210507015136.11069-1-chaitanya.kulkarni@wdc.com>
References: <20210507015136.11069-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210506_185143_413725_D1308EDD 
X-CRM114-Status: GOOD (  16.04  )
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

When handling rw commands, for inline bio case we only consider
transfer size. This works well when req->sg_cnt fits into the
req->inline_bvec, but it will result in the warning in 
__bio_add_page() when req->sg_cnt > NVMET_MAX_INLINE_BVEC.

Consider an I/O size 32768 and first page is not aligned to the page
boundary, then I/O is split in following manner :-

[ 2206.256140] nvmet: sg->length 3440 sg->offset 656
[ 2206.256144] nvmet: sg->length 4096 sg->offset 0
[ 2206.256148] nvmet: sg->length 4096 sg->offset 0
[ 2206.256152] nvmet: sg->length 4096 sg->offset 0
[ 2206.256155] nvmet: sg->length 4096 sg->offset 0
[ 2206.256159] nvmet: sg->length 4096 sg->offset 0
[ 2206.256163] nvmet: sg->length 4096 sg->offset 0
[ 2206.256166] nvmet: sg->length 4096 sg->offset 0
[ 2206.256170] nvmet: sg->length 656 sg->offset 0

Now the req->transfer_size == NVMET_MAX_INLINE_DATA_LEN i.e. 32768, but
the req->sg_cnt is (9) > NVMET_MAX_INLINE_BIOVEC which is (8).
This will result in the following warning message :-

nvmet_bdev_execute_rw()
	bio_add_page()
		__bio_add_page()
			WARN_ON_ONCE(bio_full(bio, len));

This scenario is very hard to reproduce on the nvme-loop transport only
with rw commands issued with the passthru IOCTL interface from the host
application and the data buffer is allocated with the malloc() and not
the posix_memalign().

Fixes: 73383adfad24 ("nvmet: don't split large I/Os unconditionally")
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/io-cmd-bdev.c | 2 +-
 drivers/nvme/target/nvmet.h       | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 9a8b3726a37c..429263ca9b97 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -258,7 +258,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 
 	sector = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
 
-	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
+	if (nvmet_use_inline_bvec(req)) {
 		bio = &req->b.inline_bio;
 		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
 	} else {
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 5566ed403576..d69a409515d6 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -616,4 +616,10 @@ static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
 	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
 }
 
+static inline bool nvmet_use_inline_bvec(struct nvmet_req *req)
+{
+	return req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN &&
+	       req->sg_cnt <= NVMET_MAX_INLINE_BIOVEC;
+}
+
 #endif /* _NVMET_H */
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
