Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC015C79FB7
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2026 15:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i/dqMqkRLXLgOf/iN7bfg+WtTxgpBe43DRYOg5f23zY=; b=lVydJ9xocLpjBsOUKwZN3JkBFB
	xHTPM9YzRzBQ5z3hGgEJL8UTts4NmkkwQIXDihKiKItzUXMN2usGLpBy2hGQKuLpdkgDDKZ04qJQQ
	xm7dmBwbFahro7Ey/pSltIBtCJ5m7puihvkAAg9EBfI4yL05VmU39Ga8QClg3STx4a/zOKY9g+91s
	awoToqcXKTfJ86rsIqFuKxDJTK87BOdymxg2Ybp2GsxL7HCo7yvvJY1kqaLCfXXKCpXldpAkmTDie
	SyLl92pFEyfbxCOFNZ0WKe/ATynJJLv1wcAINYNdF43OGeYMFDm0Fdap+8kr0/vC1rdhS2Pbs5EDT
	MTMMc/jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Ki0-0000000CFpe-1GEG;
	Wed, 09 Sep 2026 15:59:36 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Khz-0000000CFox-0bjW
	for linux-nvme@bombadil.infradead.org;
	Wed, 09 Sep 2026 15:59:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=i/dqMqkRLXLgOf/iN7bfg+WtTxgpBe43DRYOg5f23zY=; b=haxTUgG3btJAgPL/jAevTRjhb2
	PyyPYvVwTXSH5Zek9hMPkgPFZ9fYyQppjFA1i2CeH5byn9DZJ9WZeCx2+CK10mfKzdZLMgf7xuRR+
	AV+YMXy//sIKmCzPajxAgog4B2IZS+0A5powHzLSNbxT9lVaeNGoKDcnQs3s2uTyVUrLkO4hIlUML
	8uRk60/tIqXLa50ushFTPAVVm1MDNdZ51uSjy8R0x1xNGp/nn/rXW2/SjpWYbwentxbQXyhMwubGX
	LChzTckr3wVKpjYll6OCDah/z9mvAxbyIbWOZMdPbW2RroxaoALUzrOtELjdIjDvKQJbkKiGEAKGV
	W2DRVBZg==;
Received: from mail-pf1-x464.google.com ([2607:f8b0:4864:20::464])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4Khu-00000001PAv-2SnL
	for linux-nvme@lists.infradead.org;
	Wed, 09 Sep 2026 15:59:33 +0000
Received: by mail-pf1-x464.google.com with SMTP id d2e1a72fcca58-851d4de33a3so57831b3a.2
        for <linux-nvme@lists.infradead.org>; Wed, 09 Sep 2026 08:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788969568; x=1789574368; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i/dqMqkRLXLgOf/iN7bfg+WtTxgpBe43DRYOg5f23zY=;
        b=IsXmg10aSCHNlEteMim7Ua5C2HvBo1924YNrdlal7uulpZxfe3jKw0VF1bzFW3KENG
         vW8+nP+IWHh+aPxwE4WYnvomUKT3jsoHtoMp6a6Ib0yPMKeHNWelopPQzvPO+2UEK6VO
         0SW97AMoLPQkXAb9N9fgSKnEr52YGml7+Bv/UWFj0ccyCA537QEpgPjOHhF9OI/qASeF
         bDZ0RN+er3fzWyHKayAFlGGvZAWWLVlZ95hbgaSlWQMWysBJK8PybnRWvAIsi7q/UpJU
         pOXoyOen69C4W2+fE+8xAaG7eXDAGt40hqPQT7T9i4bIB8/MBKwwj2jbtkrKltoevH4B
         WwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788969568; x=1789574368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i/dqMqkRLXLgOf/iN7bfg+WtTxgpBe43DRYOg5f23zY=;
        b=IuvPPPpDFc/Peyl4vaZDdXAlAHwBuAE7kIGOrPuQHD/CDOGhGn6N6lUEYT8oJX0tQC
         ygv3rJQlwSZOOwiozBzG/ICFrciKUf+Lz71HbGOwKdlz2RdXo0ANAHPuf/v65j7ph4kd
         DKK2xqspVV8vZ3XPRBMtmoS3pB1FUQCEVvcrz3KyHtdT2oFttmztL6H29LiKZZLDeBQC
         xdZhFcIvizm8lXSunzHWMmxX6eI0SLdWQsJ1gPmw7nk8qIH/SqLvaDLVL0Lr9+u2BmkC
         d2VEKKnf6PaXqCezvNpx9aRDyyqPlgowckqOJOAaFXTMHm6Dm99Nfd44EBmXDT8UCN2u
         l0hQ==
X-Forwarded-Encrypted: i=1; AKwUvByjMzjLUgDKwXv864Mu887yvF/PMgr/8XydGrB2+nuzMu6t3G7WAoaWjDfLLGgi2JZnt1t9P2F6pe9P@lists.infradead.org
X-Gm-Message-State: AFuF++l0dMeuXBaCTYi4YOHIaCEcwfTGTLfptj97XZHnISEyB1Xqo1nl
	7oxSOJy/wi1RpPdkH9gZpPzPzyV+0a6dVpmhZ7lFXBMaurNv7fvQHurCzvEMOZaTyUOQ9G8iJu9
	HBb1dSSWbmEQKD5gpL9vkfp+7NPdFEW19qomDUuKVLk15o4iaIFt/
X-Gm-Gg: AYBFou2nIq49nsO+DtS34/xAXMjghM0zii0/HcnN02ZUg8Tgg83ffa8C3/9mvFv1nZQ
	02nV0r2bzmRtiYWD1GWP3UCkwO8jpt6Zt38wLhNKVY5D2rMjlF4pAVOu9A0E3XUndDpX6Yl/JXq
	zNijLaG7jQfbdmAQNiVICeAhqlXrx9jZyMmw1Jyu90oTbXpX5Z/qWm/IRVYIrruTrarfVMEdUEb
	8/sTdkB5xpS06zenYS/1wMXGnxFyvRWlHVRAS3KqijYt9ZM8U9CEH3VfvQ42rtYGgfm0AfkGFxU
	bJ4/enbZAPC4V15GMc5/VesgNB1XH23sgg/Yy//0iIK/9bLEt4jK5HZ7OofPJJD5ihnbzCAx1Vt
	lCLKvXZGPh9gVjhSg6g==
X-Received: by 2002:a05:6a00:7186:b0:869:2a17:bd35 with SMTP id d2e1a72fcca58-8692a2706b3mr1512386b3a.3.1788969568156;
        Wed, 09 Sep 2026 08:59:28 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-8652a30058bsm2816265b3a.8.2026.09.09.08.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 08:59:28 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.12.104])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 5FD82402B4;
	Wed,  9 Sep 2026 09:59:27 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 5A45BE4026F; Wed,  9 Sep 2026 09:59:27 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Ming Lei <tom.leiming@gmail.com>,
	io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 3/3] nvme/ioctl: call io_uring_cmd_set_res32() in ->end_io()
Date: Wed,  9 Sep 2026 09:58:48 -0600
Message-ID: <20260909155848.2069290-4-csander@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909155848.2069290-1-csander@purestorage.com>
References: <20260909155848.2069290-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_165930_753236_6E34BF11 
X-CRM114-Status: GOOD (  16.24  )
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

io_uring_cmd_set_res32() only performs loads and stores to the io_uring
request state, so it's safe to call in interrupt context. Move the call
from the nvme_uring_task_cb() task work to nvme_uring_cmd_end_io(). This
unifies the 2 places setting the NVMe status and result on the uring_cmd
and removes the need to pass them through struct nvme_uring_cmd_pdu,
saving 16 bytes and a couple memory accesses.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/ioctl.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 6539d4750098..3aa5d2f2dfbb 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -421,12 +421,10 @@ struct nvme_uring_data {
  * Expect build errors if this grows larger than that.
  */
 struct nvme_uring_cmd_pdu {
 	struct request *req;
 	struct bio *bio;
-	u64 result;
-	int status;
 };
 
 static inline struct nvme_uring_cmd_pdu *nvme_uring_cmd_pdu(
 		struct io_uring_cmd *ioucmd)
 {
@@ -438,29 +436,30 @@ static void nvme_uring_task_cb(struct io_tw_req tw_req, io_tw_token_t tw)
 	struct io_uring_cmd *ioucmd = io_uring_cmd_from_tw(tw_req);
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
 
 	if (pdu->bio)
 		blk_rq_unmap_user(pdu->bio);
-	io_uring_cmd_done32(ioucmd, pdu->status, pdu->result,
-			    IO_URING_CMD_TASK_WORK_ISSUE_FLAGS);
+	__io_uring_cmd_done(ioucmd, IO_URING_CMD_TASK_WORK_ISSUE_FLAGS);
 }
 
 static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 						blk_status_t err,
 						const struct io_comp_batch *iob)
 {
 	struct io_uring_cmd *ioucmd = req->end_io_data;
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
+	u64 result = le64_to_cpu(nvme_req(req)->result.u64);
+	int status;
 
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED) {
-		pdu->status = -EINTR;
+		status = -EINTR;
 	} else {
-		pdu->status = nvme_req(req)->status;
-		if (!pdu->status)
-			pdu->status = blk_status_to_errno(err);
+		status = nvme_req(req)->status;
+		if (!status)
+			status = blk_status_to_errno(err);
 	}
-	pdu->result = le64_to_cpu(nvme_req(req)->result.u64);
+	io_uring_cmd_set_res32(ioucmd, status, result);
 
 	/*
 	 * For IOPOLL, check if this completion is happening in the context
 	 * of the same io_ring that owns the request (local context). If so,
 	 * we can complete inline without task_work overhead. Otherwise, we
@@ -469,11 +468,11 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 	 */
 	if (blk_rq_is_poll(req) && iob &&
 	    iob->poll_ctx == io_uring_cmd_ctx_handle(ioucmd)) {
 		if (pdu->bio)
 			blk_rq_unmap_user(pdu->bio);
-		io_uring_cmd_done32(ioucmd, pdu->status, pdu->result, 0);
+		__io_uring_cmd_done(ioucmd, 0);
 	} else {
 		io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
 	}
 	return RQ_END_IO_FREE;
 }
-- 
2.55.0


