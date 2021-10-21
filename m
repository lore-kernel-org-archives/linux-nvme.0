Return-Path: <SRS0=gxeb=PJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3358CC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Oct 2021 08:42:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA625610A3
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Oct 2021 08:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EA625610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GxqV4GzgSGYR4iAttf66EuGf6k/FIWcaoUbxmisqZEo=; b=PDCmA3NrE3EpwFLJUyRWzDN2tS
	18XGRUIKev4c+8vhUeOHj1DuGZQR/B2fwSjA8C+8ntah8HITER543LpZ9LFMVcgi4n8mmp9AJD2hn
	z5IfE5DNXO0jWyh0Bz97vMicdHRCzSdSXauI3knIlyS77XIPogNVt34c/ehfoN88H75HudAlwJnFU
	nngdLyXmCn2MlN5qtIP/shTTAZFquqoCj2vpNa/GkDKyFdL4ylWNXNsTfpvQz2fhG1iu56QVusaDz
	nRfNBE2tu0HpreibIZ2c/CMPh/w78zSvpAyYBZ0WhzkizKBKSQnEWHp3B9FiOYtIW3ZEPEk0WU76A
	d23KMU7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mdTee-006s65-Ke; Thu, 21 Oct 2021 08:42:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdTeL-006rzj-Rk
 for linux-nvme@lists.infradead.org; Thu, 21 Oct 2021 08:42:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634805727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GxqV4GzgSGYR4iAttf66EuGf6k/FIWcaoUbxmisqZEo=;
 b=KX4fX7haZY4qdUWBtpS2nnCjmp9IvmOxHbT8ZiwFg275jVukMvQdn/+2ast2YXxclxyWru
 EGBFNL8DQfsVIfFcxQZIJBPtxYvHxslZb9o2+SUNPRmLU/AcobmBKbdF8mFTlbu4Ch+NEF
 fhOrbF1qm38jLfKbcUl6BQ1bxc1jYQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-IHdsdiukNQKJZs3wJSaR_g-1; Thu, 21 Oct 2021 04:42:04 -0400
X-MC-Unique: IHdsdiukNQKJZs3wJSaR_g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 463B080A5C0;
 Thu, 21 Oct 2021 08:42:03 +0000 (UTC)
Received: from raketa.redhat.com (unknown [10.40.193.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9BC4019D9F;
 Thu, 21 Oct 2021 08:42:01 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, hare@suse.de, chaitanya.kulkarni@wdc.com,
 jmeneghi@redhat.com
Subject: [PATCH 2/2] nvmet: fix a race condition between release_queue and
 io_work
Date: Thu, 21 Oct 2021 10:41:55 +0200
Message-Id: <20211021084155.16109-3-mlombard@redhat.com>
In-Reply-To: <20211021084155.16109-1-mlombard@redhat.com>
References: <20211021084155.16109-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211021_014210_131266_1ACAC9D4 
X-CRM114-Status: GOOD (  13.89  )
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

If the initiator executes a reset controller operation while
performing I/O, the target kernel will crash because of a race condition
between release_queue and io_work;
nvmet_tcp_uninit_data_in_cmds() may be executed while io_work
is running, calling flush_work(io_work) was not sufficient to
prevent this because io_work could requeue itself.

* Fix this bug by preventing io_work from being enqueued when
sk_user_data is NULL (it means that the queue is going to be deleted)

* Ensure that all the memory allocated for the commands' iovec is freed

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/tcp.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 2f03a94725ae..1eedbd83c95f 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -551,6 +551,7 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 	struct nvmet_tcp_cmd *cmd =
 		container_of(req, struct nvmet_tcp_cmd, req);
 	struct nvmet_tcp_queue	*queue = cmd->queue;
+	struct socket *sock = queue->sock;
 	struct nvme_sgl_desc *sgl;
 	u32 len;
 
@@ -570,7 +571,10 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 	}
 
 	llist_add(&cmd->lentry, &queue->resp_list);
-	queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &cmd->queue->io_work);
+	read_lock_bh(&sock->sk->sk_callback_lock);
+	if (likely(sock->sk->sk_user_data))
+		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &cmd->queue->io_work);
+	read_unlock_bh(&sock->sk->sk_callback_lock);
 }
 
 static void nvmet_tcp_execute_request(struct nvmet_tcp_cmd *cmd)
@@ -1427,7 +1431,9 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 
 	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
 		if (nvmet_tcp_need_data_in(cmd))
-			nvmet_tcp_finish_cmd(cmd);
+			nvmet_req_uninit(&cmd->req);
+		nvmet_tcp_unmap_pdu_iovec(cmd);
+		nvmet_tcp_free_iovec(cmd);
 	}
 
 	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
@@ -1447,11 +1453,10 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	mutex_unlock(&nvmet_tcp_queue_mutex);
 
 	nvmet_tcp_restore_socket_callbacks(queue);
-	flush_work(&queue->io_work);
+	cancel_work_sync(&queue->io_work);
 
 	nvmet_tcp_uninit_data_in_cmds(queue);
 	nvmet_sq_destroy(&queue->nvme_sq);
-	cancel_work_sync(&queue->io_work);
 	sock_release(queue->sock);
 	nvmet_tcp_free_cmds(queue);
 	if (queue->hdr_digest || queue->data_digest)
-- 
2.27.0


