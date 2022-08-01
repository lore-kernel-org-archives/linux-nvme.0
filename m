Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91218C00144
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Aug 2022 08:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=E8c/rb2vJg+rmIEETIk4Mn42/EzF+XKV2ty0ibIQD+s=; b=aQvyaJvyk63ig7V+4cQzHwH55v
	Avtq0JhTB2jZW/w651HJzuY0e/DLjPrQ21EztqT9pnlBcbpK6WoJL5XibcVdc8C7LbuLadr44JWQD
	n0iiitiBzYUtQ7u0N1yWH7RcudWXBnUVmkNL5mGNePoO5DyjpLR54NKsH/qkIzv2QlIK/YD4AWf80
	bKs4TT8XE13UY7m0lM5leeJNSdNAKwOVxIsqsH6GWFugnFivq1BGXP0k0LqzEtCe+vGiBH1hJ6Gfh
	H8QtkFn8NbV81oYCcgxRKPGASm1M9wZTTb9EIEgbteSOfQ4JBjpWmwMwdTvxZzH2jsqLAY+Aq7fLz
	+jZsf4FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIQW6-003onD-Sg; Mon, 01 Aug 2022 08:11:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIQW1-003ojK-37
	for linux-nvme@lists.infradead.org; Mon, 01 Aug 2022 08:11:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659341461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E8c/rb2vJg+rmIEETIk4Mn42/EzF+XKV2ty0ibIQD+s=;
	b=FSYzEs35fd24pSwX56E9aAoxwTSvTqrERGtJI4PmlIzLL3EVr7OcaedyDKqjIrsLypQYQq
	py7zNXOGYdn0nCFlSU2YSFL1wiDHSHoMuXkrs7ciJp48WB1X9XNhcVs7nEPMrRrFCzioeZ
	DpFei5aiNvrWGf2t8hIQMccxUlOGksM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-vqeSkZ7fPY263evNeOkyPw-1; Mon, 01 Aug 2022 04:09:02 -0400
X-MC-Unique: vqeSkZ7fPY263evNeOkyPw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 734698039AA;
	Mon,  1 Aug 2022 08:09:02 +0000 (UTC)
Received: from raketa.redhat.com (unknown [10.40.192.42])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8992B492C3B;
	Mon,  1 Aug 2022 08:09:01 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	hch@lst.de,
	kbusch@kernel.org
Subject: [PATCH] nvme-host tcp: check if the queue is allocated before stopping it
Date: Mon,  1 Aug 2022 10:09:00 +0200
Message-Id: <20220801080900.391575-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_011105_250589_B1D10FDD 
X-CRM114-Status: GOOD (  14.93  )
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

When an error is detected and the host reconnects, the
nvme_tcp_error_recovery_work() function is called and starts
tearing down the io queues and de-allocating them;
If at the same time the "nvme" process deletes the controller via sysfs,
the nvme_tcp_delete_ctrl() gets called and waits until the
nvme_tcp_error_recovery_work() finishes its job; then starts
tearing down the io queues, but at this point they have already
been freed and the mutexes are destroyed.

Calling mutex_lock() against a destroyed mutex triggers a warning:

[ 1299.025575] nvme nvme1: Reconnecting in 10 seconds...
[ 1299.636449] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[ 1299.645262] ------------[ cut here ]------------
[ 1299.649949] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
[ 1299.649971] WARNING: CPU: 4 PID: 104150 at kernel/locking/mutex.c:579 __mutex_lock+0x2d0/0x7dc

[ 1299.717934] CPU: 4 PID: 104150 Comm: nvme
[ 1299.828075] Call trace:
[ 1299.830526]  __mutex_lock+0x2d0/0x7dc
[ 1299.834203]  mutex_lock_nested+0x64/0xd4
[ 1299.838139]  nvme_tcp_stop_queue+0x54/0xe0 [nvme_tcp]
[ 1299.843211]  nvme_tcp_teardown_io_queues.part.0+0x90/0x280 [nvme_tcp]
[ 1299.849672]  nvme_tcp_delete_ctrl+0x6c/0xf0 [nvme_tcp]
[ 1299.854831]  nvme_do_delete_ctrl+0x108/0x120 [nvme_core]
[ 1299.860181]  nvme_sysfs_delete+0xec/0xf0 [nvme_core]
[ 1299.865179]  dev_attr_store+0x40/0x70

Fix the warning by checking if the queues are allocated
in the nvme_tcp_stop_queue(). If they are not, it makes no
sense to try to stop them.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ac74dce3e95b..ab9bb5c98c78 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1619,6 +1619,9 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
 
+	if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
+		return;
+
 	mutex_lock(&queue->queue_lock);
 	if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
 		__nvme_tcp_stop_queue(queue);
-- 
2.31.1


