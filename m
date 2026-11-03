Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5DE606A31B
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 19:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aRPugT/A;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=N7So9mXD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=XEpLQlM4niyRTTg5pX/GDc+5D2VROd0b+UsPN2wwGc0=; b=aRPugT/A7KwWv7pe6bVC1GKqa3
	c6NUNOHP76lzQFde9aMMIWpTph5QaiwpBCwS3OhaxnWPH0nI/6/z73Ku3KHpEnEkNnJvZxvrlMDLL
	QlZUiwcGNkEempS8vGHPEp1asXzjD+oGHyJQIXTgPDrl9UnYK6zjEImqPFfTlYj7a0KxkAE4Aas9N
	/j/szHLvHvHQS8rVNpRSEZACpComIh2ZUuh5c5H6mG3qu5gDCTcbgtaHr6Uy6p0/RsgXmJbu2h1zt
	ZJYAoWaUkD2y6g2dlWQ8QJplbNqcGUTXzyOZKz76dBnxGFv7hgvU/JFoTDONCqKD+4DG+CdHhsJbf
	mW1xL11g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOK0f-00000003VWT-3BZd;
	Tue, 03 Nov 2026 19:17:29 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOK0a-00000003VW4-3ZDx
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 19:17:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=XEpLQlM4niyRTTg5pX/GDc+5D2VROd0b+UsPN2wwGc0=; t=1793733444; x=2109093444; 
	b=N7So9mXDkskUBW80BNGCK/jjYqJZ8wVrOvOCfE53z0/l5A+gb9pfLdlm+xt+GYjJFxn/nHSpR36
	5Q6yfHVongAmk+affP9Dp1r5Juk8SHOdylqpjcXDgwQSjIDq2yM9vqXmNh/VILk+zsosvH0loUnVe
	iuNrG1d5MnzDmpR35lQjjXk9ToylIpqALvrzTqRrpcTVrT0BFJdM50XOTLl9b5CpKpIzPK3ylCbBJ
	e5tU3ukL++UrgD+Kxy4cwObHByKnexidOPW/M9crVxdhtwoGw76U2onj4ejszETqcPuL1iWgdsokM
	eu0xrRX+VHKp+n/AQrvbz+LyIKyD/QV78+4w==;
Received: from 186-249-149-105.shared.desktop.com.br ([186.249.149.105] helo=[127.0.1.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xOK0M-001Wjb-W9; Tue, 03 Nov 2026 20:17:11 +0100
From: Mauricio Faria de Oliveira <mfo@igalia.com>
Date: Tue, 03 Nov 2026 16:18:25 -0300
Subject: [PATCH] nvme: reject completions for requests that are not in
 flight
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-nvme-double-cmpl-uaf-blk-mq-v1-1-b10fea474423@igalia.com>
X-B4-Tracking: v=1; b=H4sIAIAz6moC/x3MQQqFIBAA0KvErBtIi/r8q0QL07GG1EopgujuS
 cu3eTckikwJ/sUNkU5OvIYMURagZxUmQjbZICvZClFJDKcnNOsxOkLtN4eHsji6Bf2OVBv5s12
 jjbKQhy2S5evb++F5Xjm4lo1tAAAA
X-Change-ID: 20261102-nvme-double-cmpl-uaf-blk-mq-e3d28f74cdaf
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Chao Shi <coshi036@gmail.com>, kernel-dev@igalia.com, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mauricio Faria de Oliveira <mfo@igalia.com>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_111725_181972_389EEB66 
X-CRM114-Status: GOOD (  21.35  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chao Shi <coshi036@gmail.com>

There are a few kernel crash reports from the Steam Deck where incorrect
completions received by the nvme driver have a command id/tag associated
with a freed request (rq->mq_hctx = NULL), dereferencing a NULL pointer.

  nvme_handle_cqe()
  -> nvme_try_complete_req(req, ...)
     -> blk_mq_complete_request_remote(req)
        -> if ((rq->mq_hctx->nr_ctx == 1 &&   /* Oops! */

Although the usual suspect is the nvme device firmware, one report shows
incorrect completions also received by the ath11k wireless driver at the
same time, which suggests the underlying issue might be something else.

  [ 2585.223155] ath11k_pci 0000:03:00.0: tx completion for unknown msdu_id 0
  [ 2585.223163] ath11k_pci 0000:03:00.0: tx completion for unknown msdu_id 0
  ...
  [ 2585.228077] nvme nvme0: request 0xec genctr mismatch (got 0x2 expected 0xa)
  [ 2585.228079] nvme nvme0: invalid id 8428 completed on queue 3
  [ 2585.228205] nvme nvme0: request 0xe2 genctr mismatch (got 0xe expected 0x2)
  [ 2585.228208] nvme nvme0: invalid id 57570 completed on queue 3
  ...
  [ 2585.228726] BUG: kernel NULL pointer dereference, address: 00000000000000fe
  ...
  [ 2585.228752] RIP: 0010:blk_mq_complete_request_remote+0x1c/0x160
  ...
  [ 2585.228787] Call Trace:
  [ 2585.228790]  <IRQ>
  [ 2585.228828]  nvme_poll_cq+0x14b/0x300
  [ 2585.228838]  nvme_irq+0x41/0x80
  [ 2585.228845]  __handle_irq_event_percpu+0x4a/0x180
  [ 2585.228850]  handle_irq_event+0x38/0x90
  [ 2585.228853]  handle_edge_irq+0x8b/0x230
  [ 2585.228858]  __common_interrupt+0x3e/0x90
  [ 2585.228862]  common_interrupt+0x80/0xa0
  [ 2585.228866]  </IRQ>
  [ 2585.228868]  <TASK>
  ...

However, even when the nvme device firmware is at fault and need an update,
it is interesting for the kernel not to crash, so that it is even possible
to run the firmware update where the issue happens frequently or early on,
and while waiting for the update to be made available by the device vendor.

The fix is to check that a request is actually in-flight before completing
it. This has been previously reported and proposed by Chao Shi, found with
fuzzing, but without further feedback since July. I happened to learn of it
only after root-cause analysis and reaching a similar conclusion, checking
for prior work/feedback, thus keeping them as Author/Signed-off-by, adding
myself as Co-developed-by for the commit message and root cause analysis.

In Chao Shi's patch, there's been feedback/question of whether this should
be done in blk-mq, as this is not specific to nvme. I'd say no, at first:
- Some blk-mq calls for completion have no return value (e.g., completion
  on other CPUs), which suggests maybe an API change and updates to many
  callers, all for an edge case.
- An alternative available currently might be blk_mq_ops.complete(), but
  that is handled in the driver anyway, with risk of hitting an error in
  blk-mq (like this) as the code changes, and seems semantically wrong,
  i.e., completing a request that should not have been completed.
- Keeping in mind a small fix for stable, for now, should this be merged.
- But happy to take suggestions if blk-mq is indeed the way to go.

This has been tested with a synthetic reproducer produced by an LLM.

Originally-by: Chao Shi <coshi036@gmail.com>
Signed-off-by: Chao Shi <coshi036@gmail.com>
Link: https://lore.kernel.org/linux-nvme/20260522153034.2168862-1-coshi036@gmail.com/
Link: https://lore.kernel.org/linux-nvme/20260715005105.1115958-1-coshi036@gmail.com/
Co-developed-by: Mauricio Faria de Oliveira <mfo@igalia.com>
Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
---
 drivers/nvme/host/nvme.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2d8f681079e85601a92624d196e77f1ba3ace34a..3ba0666da7be6a3de2e5f0fd50155af115b4e1f6 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -708,6 +708,11 @@ static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
 			tag, genctr, nvme_genctr_mask(nvme_req(rq)->genctr));
 		return NULL;
 	}
+	if (unlikely(blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT)) {
+		dev_err(nvme_req(rq)->ctrl->device,
+			"completion for request %#x not in flight\n", tag);
+		return NULL;
+	}
 	return rq;
 }
 

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-nvme-double-cmpl-uaf-blk-mq-e3d28f74cdaf

Best regards,
-- 
Mauricio Faria de Oliveira <mfo@igalia.com>


