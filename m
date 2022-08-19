Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932CBC32771
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Aug 2022 07:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=a+f1B4c1i+AZ2GarnN4KZY0AG5dvjKV+3OdA1Itfi+8=; b=QF1dZQH+cCPDAgLJYnzLlOUXFn
	nZ8njAP7YtA+X7P1AFxLBYtGxPAPLy6LtTWH+Xb8pXX7tzR9jUfTfSlsYswbVly9o4Ey6r2Z8ZMXM
	C3pKzvkqoAfwfKlph8G4Btgri/nIVLbp0iqFbLRv6uxl94bNMYZ897Z3w2G/SFVSHoTTIA+pfxnK0
	67G+YDGLZDPrI2zRPlG3/2wYFsf5GP9Uaumtvk3GihP0AYzwYVdrMrXKdVZKo0+oHHbhgtYm5J8Wy
	6JrLKPtrEnybkcaxSAAyBvfgnlNx9qfJjvukvW4xUeNKTD7DsWLQzsdvpHveOaIbvnMFq+rIUmVhh
	5qngWA0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOwmq-003cbJ-6b; Fri, 19 Aug 2022 07:51:24 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOwmn-003cZT-Gc
	for linux-nvme@lists.infradead.org; Fri, 19 Aug 2022 07:51:22 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FE21344EB
	for <linux-nvme@lists.infradead.org>; Fri, 19 Aug 2022 07:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1660895478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=a+f1B4c1i+AZ2GarnN4KZY0AG5dvjKV+3OdA1Itfi+8=;
	b=nfLuL0ELMTONfib2D0sQL2NgUHuIqMGLV/VybjISAJSTK7pSTHz7EUwjlU+ttNlQvhZDoM
	zO3kikV88VovOlZn0DDa8Wx9lc1sq/aDY4MAUxFwhOEDlHkaTi0lizMDPkh97bM+A+sAVv
	/dR9Ak0uWdeQViGwZl4ucmOObtnWHpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1660895478;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=a+f1B4c1i+AZ2GarnN4KZY0AG5dvjKV+3OdA1Itfi+8=;
	b=03/gcx7ysYWfudMOd4gybmw1tmMcglf63v9NVrDc+McgZ+r4MfOrJ1OAMLMS360WQ//LOn
	fYZFV6BD/7rR2oDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 410D813AC1
	for <linux-nvme@lists.infradead.org>; Fri, 19 Aug 2022 07:51:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id x1/YD/ZA/2JjVwAAMHmgww
	(envelope-from <dwagner@suse.de>)
	for <linux-nvme@lists.infradead.org>; Fri, 19 Aug 2022 07:51:18 +0000
Date: Fri, 19 Aug 2022 09:51:17 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Subject: crash at nvme_tcp_init_iter with header digest enabled
Message-ID: <20220819075117.rzvbecyvh2wuwokj@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220819_005121_745613_D2A363B5 
X-CRM114-Status: GOOD (  12.95  )
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

Hi,

we got a customer bug report against our downstream kernel
when doing fail over tests with header digest enabled.

The whole crash looks like an user after free bug but
so far we were not able to figure out where it happens.

  nvme nvme13: queue 1: header digest flag is cleared
  nvme nvme13: receive failed:  -71
  nvme nvme13: starting error recovery
  nvme nvme7: Reconnecting in 10 seconds...

  RIP: nvme_tcp_init_iter

  nvme_tcp_recv_skb
  ? tcp_mstamp_refresh
  ? nvme_tcp_submit_async_event
  tcp_read_sock
  nvme_tcp_try_recv
  nvme_tcp_io_work
  process_one_work
  ? process_one_work
  worker_thread
  ? process_one_work
  kthread
  ? set_kthread_struct
  ret_from_fork

In order to rule out that this caused by an reuse of a command id, I
added a test patch which always clears the request pointer (see below)
and hoped to see

   "got bad cqe.command_id %#x on queue %d\n"

but there was none. Instead the crash disappeared. It looks like we are
not clearing the request in the error path, but so far I haven't figured
out how this is related to the header digest enabled.

Anyway, this is just a FYI and in case anyone has an idea where to poke
at; I am listening.

Thanks,
Daniel



diff --git a/block/blk-mq.c b/block/blk-mq.c
index 98cc93d58575..bfadccb90be6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -847,6 +847,13 @@ struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
 }
 EXPORT_SYMBOL(blk_mq_tag_to_rq);
 
+void blk_mq_tag_reset(struct blk_mq_tags *tags, unsigned int tag)
+{
+	struct request *rq = tags->rqs[tag];
+	cmpxchg(&tags->rqs[tag], rq, NULL);
+}
+EXPORT_SYMBOL(blk_mq_tag_reset);
+
 static bool blk_mq_rq_inflight(struct blk_mq_hw_ctx *hctx, struct request *rq,
 			       void *priv, bool reserved)
 {
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 78cfe97031ca..f9a641fb7353 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -504,6 +504,8 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
 		return -EINVAL;
 	}
+	blk_mq_tag_reset(nvme_tcp_tagset(queue),
+			 nvme_tag_from_cid(cqe->command_id));
 
 	req = blk_mq_rq_to_pdu(rq);
 	if (req->status == cpu_to_le16(NVME_SC_SUCCESS))
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1d18447ebebc..a338ec65f3c8 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -470,6 +470,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 		unsigned int op, blk_mq_req_flags_t flags,
 		unsigned int hctx_idx);
 struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag);
+void blk_mq_tag_reset(struct blk_mq_tags *tags, unsigned int tag);
 
 enum {
 	BLK_MQ_UNIQUE_TAG_BITS = 16,


