Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956F7C00140
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Aug 2022 14:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jWm/oZYqq7d02Joc/D/Fg/uHR4v53ZwdMalxwu9sIX0=; b=uJJ04RbY405hM/X7HHbyjCK4tU
	Iyk2bj1VPuqgGSmRGxrQ9He3znPjxl8S72Wu04rWoaohrIOKdO+NJcKXnOGuNo6nv3jBP71SZ4FBZ
	65Ijk9vkBCehrPVSIQfGiCzprB8LvlXGM37s/+9g/GPa8d9DBT4gXDREWhgjvzow9TE7RbS+ESrUw
	isv7G/2oSeY/bd4mVB5W2DtirDIAJoLfQhq0NgZLfFINaPrmjjrtC/AwCMfnkBpXtK8gav9dAv0Fj
	wCHmklmJobP6LW8jWuwf6VXckMRyOnhgAFVYVykSK2P/WeT2GcLjwvz8+Rah27i778WPsDPdkc3uV
	/cV1515w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMVgr-008wiu-9V; Fri, 12 Aug 2022 14:31:09 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMVgk-008wgf-PK
	for linux-nvme@lists.infradead.org; Fri, 12 Aug 2022 14:31:04 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5DA76224D0;
	Fri, 12 Aug 2022 14:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1660314569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jWm/oZYqq7d02Joc/D/Fg/uHR4v53ZwdMalxwu9sIX0=;
	b=dr0GS3pPc97jUpDM9LBdX0s5N46w1UQVaEFuDaqz8dK5o/3aPJkgyDKFpI270DqZEGi/XG
	p5Z8G7wVlW71vnazCfLZP+YH9bEL9RpyrfwiP9bA7T2+v4PQjj/K3/8YlxxebNudQF49/u
	CLIlJWsZdmpgOaW5YlrCV9dj7AiyDVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1660314569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jWm/oZYqq7d02Joc/D/Fg/uHR4v53ZwdMalxwu9sIX0=;
	b=1s+2T19+ifotRJb4wLoaLVgL+ZIMEJYMeKO1HM0Sln5wJixQn+LQJ0la26vYFDW4VCfFLa
	/dQnLBetAjivwWAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5011813AAE;
	Fri, 12 Aug 2022 14:29:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id U3QYE8lj9mLxSAAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 12 Aug 2022 14:29:29 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [RFC] nvme-tcp: Handle number of queue changes
Date: Fri, 12 Aug 2022 16:28:24 +0200
Message-Id: <20220812142824.17766-1-dwagner@suse.de>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220812_073103_005747_6624AD0A 
X-CRM114-Status: GOOD (  22.47  )
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

On reconnect, the number of queues might have changed. In the case
where the old number of queues is lower than the new one, we try to
restart the new number of queues. At this point though, the tagset
is has not yet been updated and the operations fails.

Thus, on reconnect only start only the old number of queues, then update
the tag set and then start the rest of the newly added queues.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

We got a report from our customer that a firmware upgrade on the
storage array is able to 'break' host. This is caused a change of
number of queues which the target supports after a reconnect.

Let's assume the number of queues is 8 and all is working fine. Then
the connection is dropped and the host starts to try to
reconnect. Eventually, this succeeds but now the new number of queues
is 10:

nvme0: creating 8 I/O queues.
nvme0: mapped 8/0/0 default/read/poll queues.
nvme0: new ctrl: NQN "nvmet-test", addr 10.100.128.29:4420
nvme0: queue 0: timeout request 0x0 type 4
nvme0: starting error recovery
nvme0: failed nvme_keep_alive_end_io error=10
nvme0: Reconnecting in 10 seconds...
nvme0: failed to connect socket: -110
nvme0: Failed reconnect attempt 1
nvme0: Reconnecting in 10 seconds...
nvme0: creating 10 I/O queues.
nvme0: Connect command failed, error wo/DNR bit: -16389
nvme0: failed to connect queue: 9 ret=-5
nvme0: Failed reconnect attempt 2

As you can see queue number 9 is not able to connect.

As the order of starting and unfreezing is important we can't just
move the start of the queues after the tagset update. So my stupid
idea was to start just the older number of queues and then the rest.

This seems work:

nvme nvme0: creating 4 I/O queues.
nvme nvme0: mapped 4/0/0 default/read/poll queues.
nvme_tcp_start_io_queues nr_hw_queues 4 queue_count 5 qcnt 5
nvme_tcp_start_io_queues nr_hw_queues 4 queue_count 5 qcnt 5
nvme nvme0: new ctrl: NQN "nvmet-test", addr 10.100.128.29:4420
nvme nvme0: queue 0: timeout request 0x0 type 4
nvme nvme0: starting error recovery
nvme0: Keep Alive(0x18), Unknown (sct 0x3 / sc 0x71) 
nvme nvme0: failed nvme_keep_alive_end_io error=10
nvme nvme0: Reconnecting in 10 seconds...
nvme nvme0: creating 6 I/O queues.
nvme_tcp_start_io_queues nr_hw_queues 4 queue_count 7 qcnt 5
nvme nvme0: mapped 6/0/0 default/read/poll queues.
nvme_tcp_start_io_queues nr_hw_queues 6 queue_count 7 qcnt 7
nvme nvme0: Successfully reconnected (1 attempt)
nvme nvme0: starting error recovery
nvme0: Keep Alive(0x18), Unknown (sct 0x3 / sc 0x71) 
nvme nvme0: failed nvme_keep_alive_end_io error=10
nvme nvme0: Reconnecting in 10 seconds...
nvme nvme0: creating 4 I/O queues.
nvme_tcp_start_io_queues nr_hw_queues 6 queue_count 5 qcnt 5
nvme nvme0: mapped 4/0/0 default/read/poll queues.
nvme_tcp_start_io_queues nr_hw_queues 4 queue_count 5 qcnt 5
nvme nvme0: Successfully reconnected (1 attempt)

And yes, the patch per se is ugly, but I didn't want to reorganize
code at this point. It just an illustration of my idea.

Feedback highly appreciated!

Thanks,
Daniel


 drivers/nvme/host/tcp.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index e82dcfcda29b..177d2f5d9047 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1671,6 +1671,9 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	int ret;
 
+	if (test_bit(NVME_TCP_Q_LIVE, &ctrl->queues[idx].flags))
+		return 0;
+
 	if (idx)
 		ret = nvmf_connect_io_queue(nctrl, idx);
 	else
@@ -1759,12 +1762,18 @@ static void nvme_tcp_stop_io_queues(struct nvme_ctrl *ctrl)
 		nvme_tcp_stop_queue(ctrl, i);
 }
 
-static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl)
+static int nvme_tcp_start_io_queues(struct nvme_ctrl *nctrl)
 {
-	int i, ret;
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+	int i, ret, qcnt;
 
-	for (i = 1; i < ctrl->queue_count; i++) {
-		ret = nvme_tcp_start_queue(ctrl, i);
+	qcnt = min(ctrl->tag_set.nr_hw_queues + 1, nctrl->queue_count);
+
+	dev_info(nctrl->device, "nr_hw_queues %d queue_count %d qcnt %d\n",
+	         ctrl->tag_set.nr_hw_queues, nctrl->queue_count, qcnt);
+
+	for (i = 1; i < qcnt; i++) {
+		ret = nvme_tcp_start_queue(nctrl, i);
 		if (ret)
 			goto out_stop_queues;
 	}
@@ -1773,7 +1782,7 @@ static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl)
 
 out_stop_queues:
 	for (i--; i >= 1; i--)
-		nvme_tcp_stop_queue(ctrl, i);
+		nvme_tcp_stop_queue(nctrl, i);
 	return ret;
 }
 
@@ -1934,6 +1943,10 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 		nvme_unfreeze(ctrl);
 	}
 
+	ret = nvme_tcp_start_io_queues(ctrl);
+	if (ret)
+		goto out_cleanup_connect_q;
+
 	return 0;
 
 out_wait_freeze_timed_out:
-- 
2.37.1


