Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46237606A31B
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 01:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UQ1FfH7g;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NI4YALaf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=YAPw36bN6z5G4jhzwc7LG1dI4oYvBGi8gU50kqerDng=; b=UQ1FfH7gXD67on
	b4TWsn3CmVEBSKcSNTFuaMPN2/gn/ZfPckhyCTVev0dT7BrfWFeU1IisyxuO1NqMOctB+dEHl+LcG
	/B+UKgbfqS90Ypux88KzVvlHPlkK+y5Hab8HmexONm38XUMuijVfyWz+u37yCqeDqXKrtgOyyGdWx
	ylvb9y7LKIEpYQMNUL1YKwGZIXFZGXbxYVMy/ctM4yBmsTJpPBpR6AvTV5sbp9bqbMk+jSFFOGAoh
	UOC/0lswWcq7A23FZgKiiOCkJOZYNEjs6JORYFotpHCT/ziTClmVWDuRnMQOAcyCgOWBFpne2pHqp
	2JPjbcSNSZtC+zTVgnWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9EG-0000000B1GM-3pq1;
	Fri, 06 Nov 2026 01:58:56 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9EE-0000000B1Ct-1NFF
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 01:58:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793930332; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=YAPw36bN6z5G4jhzwc7LG1dI4oYvBGi8gU50kqerDng=;
	b=NI4YALafL8m3uSk+yBdmH7HQAYfFxT9nTs03XV9rPiz1RgFcljyJXMcjAp5I5T3q4AlrImSLgBr5jVfPL7kI6jXvPDVFbh+Vefszq5CZfzNjDRXsbxA5cj5u3ZgGMglF9eltOJ7mMvtcDYEoWb5aBM1rDS1sl7nTteKidEJZo3I=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEA1qJq_1793930331;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEA1qJq_1793930331 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 09:58:52 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 5/6] nvmet: fix controller reference leak in nvmet_install_queue() error paths
Date: Fri,  6 Nov 2026 09:58:41 +0800
Message-ID: <20261106015842.3534898-6-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261106015842.3534898-1-kanie@linux.alibaba.com>
References: <20261106015842.3534898-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_175854_516234_F384EFBC 
X-CRM114-Status: GOOD (  11.23  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvmet_install_queue() takes a controller reference for req->cq->ctrl
and installs the controller in both req->sq->ctrl and req->cq->ctrl,
but neither error path undoes its work: the busy return after the
failed cq->ctrl cmpxchg leaves sq->ctrl set and the reference taken,
and the err path for a failed transport ->install_queue() clears
sq->ctrl but leaves cq->ctrl set with the reference still held.

The queue is then permanently wedged: a connect retry finds the stale
cq->ctrl, takes another reference and fails again, and the leaked
references keep the controller alive forever. Clearing cq->ctrl also
matters because the caller drops its own reference, which can be the
last one on the admin connect path, leaving cq->ctrl dangling.

Roll back the sq->ctrl assignment and drop the reference on both
error paths, and also clear ctrl->cqs[qid] on the err path to mirror
what nvmet_cq_destroy() would do.

Fixes: bb78836b3a7ca ("nvmet: fabrics: add CQ init and destroy")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/fabrics-cmd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index fc626c2fd2c9..773dad857a35 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -216,6 +216,8 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 	if (old) {
 		pr_warn("queue already connected!\n");
 		req->error_loc = offsetof(struct nvmf_connect_command, opcode);
+		req->sq->ctrl = NULL;
+		nvmet_ctrl_put(ctrl);
 		return NVME_SC_CONNECT_CTRL_BUSY | NVME_STATUS_DNR;
 	}
 
@@ -234,6 +236,7 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 			pr_err("failed to install queue %d cntlid %d ret %x\n",
 				qid, ctrl->cntlid, ret);
 			ctrl->sqs[qid] = NULL;
+			ctrl->cqs[qid] = NULL;
 			goto err;
 		}
 	}
@@ -242,6 +245,8 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 
 err:
 	req->sq->ctrl = NULL;
+	req->cq->ctrl = NULL;
+	nvmet_ctrl_put(ctrl);
 	return ret;
 }
 
-- 
2.43.7


