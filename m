Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2601FC433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 23 May 2022 15:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Fxe0Ylp1t5/DKUOHE8SchCeGiq/pOipSGzFASryS0q4=; b=hSuxya+CdbPcLgrigAVg2SlQfc
	n7QVEns5IH4iF4Nm9SfsNLz7wzgmj3vGVXLtAGicAFaKjIbMhk0NxH/bNgk7Sw3kwX1mCXZjTA1GO
	X9xGkkU2FK4RykMoutiGv06oYTFCZNwAoDwwVIZlxgHfLHp2JV6ffBCnAFQ32uSmhbYNTjo2n5lZg
	XEy5HBW/fxvQ6Sce0EgPFrWncE9g3CzToAmWKzEvKBXC3HJo+an9Zh5Tz7lwOwZkje3zzPumzmAYV
	uuVwR9P4/tbRE9Es93BgB+czu4qW/Zsl/w1Mgaw6Wfj/QB+9GkvTe43kFAgL1PE60ewUKTceJG/to
	BpUAEyRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nt9rs-004uBR-N3; Mon, 23 May 2022 15:21:12 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nt9rq-004u9c-7T
 for linux-nvme@lists.infradead.org; Mon, 23 May 2022 15:21:11 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 2878121AB0
 for <linux-nvme@lists.infradead.org>; Mon, 23 May 2022 15:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1653319265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Fxe0Ylp1t5/DKUOHE8SchCeGiq/pOipSGzFASryS0q4=;
 b=TM6V9rbxhdPpXA89SBSeEyuOZa+J56Bt3QiDX6EhCIjaMH3uJDbbgK60qP+wgng/XRvgEd
 LTrdQhX6un/2RawGyDYNEByqbUtv+Ufz56WeI5ahP3eAMYQl75eVIbQgtnYOQ6gXcpHemu
 y90b6LTDy+FQywF7qtaLgPa2FHcA/S0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1653319265;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Fxe0Ylp1t5/DKUOHE8SchCeGiq/pOipSGzFASryS0q4=;
 b=fulUCuneMnP0p/1EJ23MA98MwVfO6oXNCB3aX8t08tI8bsEW9eQcgg1FDVkfzTGwQuCDxH
 i3J2nVVg8KDVlZAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 20E082C141;
 Mon, 23 May 2022 15:21:05 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id 133AB519461E; Mon, 23 May 2022 17:21:05 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [RFC] nvme-rdma: Stop queues when starting with error recovery
Date: Mon, 23 May 2022 17:21:02 +0200
Message-Id: <20220523152102.41000-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220523_082110_502336_C0EEE666 
X-CRM114-Status: GOOD (  13.38  )
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

When we enter error recovery we should stop all queue activities and
all armed timers.

For example, we could arming an ANATT timer right before we enter
error recovery but do not successfully recover before the timer
fires. The timer is supposed only be active when the controller is in
LIVE state hence we should call nvme_stop_ctrl when starting with the
recover activites.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

The nvme_stop_ctrl() does cancel pending ANATT timers. But so far I
don't got hold of logs when the two controllers get back live. So this
might not work as expected.

My question is do we just want to cancel the timer or is
nvme_stop_ctrl() the right function here. Obviously, the same problem
exists for nvme-tcp.

[  889.241541] nvme nvme0: creating 4 I/O queues.                                                                                                                          
[  892.341152] nvme nvme0: mapped 4/0/0 default/read/poll queues.                                                                                                          
[  892.350942] nvme nvme0: new ctrl: NQN "XXX", addr 192.20.93.101:4420                                           
[  892.402493] nvme nvme1: creating 4 I/O queues.                                                                                                                          
[  895.392810] nvme nvme1: mapped 4/0/0 default/read/poll queues.                                                                                                          
[  895.402029] nvme nvme1: new ctrl: NQN "XXX", addr 192.20.93.102:4420                                           
[  895.471730] nvme nvme2: creating 4 I/O queues.                                                                                                                          
[  898.509195] nvme nvme2: mapped 4/0/0 default/read/poll queues.                                                                                                          
[  898.519015] nvme nvme2: new ctrl: NQN "XXX", addr 192.20.193.101:4420                                          
[  898.571169] nvme nvme3: creating 4 I/O queues.                                                                                                                          
[  901.592283] nvme nvme3: mapped 4/0/0 default/read/poll queues.                                                                                                          
[  901.601832] nvme nvme3: new ctrl: NQN "XXX", addr 192.20.193.102:4420

[  983.429977] nvme nvme3: I/O 0 QID 0 timeout                                                                                                                             
[  983.434472] nvme nvme3: starting error recovery                                                                                                                         
[  984.549958] nvme nvme0: I/O 0 QID 0 timeout                                                                                                                             
[  984.554452] nvme nvme0: starting error recovery                                                                                                                         
[  986.962375] nvme nvme3: failed nvme_keep_alive_end_io error=10                                                                                                          
[  986.986898] nvme nvme3: Reconnecting in 10 seconds...

[ 1226.486740] nvme nvme3: Reconnecting in 10 seconds...                                                                                                                   
[ 1227.749980] nvme nvme0: rdma connection establishment failed (-110)                                                                                                     
[ 1227.761593] nvme nvme0: Failed reconnect attempt 18                                                                                                                     
[ 1227.766848] nvme nvme0: Reconnecting in 10 seconds...                                                                                                                   

[ 1235.685958] nvme nvme0: ANATT timeout, resetting controller.                                                                                                            
[ 1235.692107] nvme nvme3: ANATT timeout, resetting controller.  

 drivers/nvme/host/rdma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index b87c8ae41d9b..209dd1becd6c 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1197,8 +1197,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
 			struct nvme_rdma_ctrl, err_work);
 
-	nvme_stop_keep_alive(&ctrl->ctrl);
-	flush_work(&ctrl->ctrl.async_event_work);
+	nvme_stop_ctrl(&ctrl->ctrl);
 	nvme_rdma_teardown_io_queues(ctrl, false);
 	nvme_start_queues(&ctrl->ctrl);
 	nvme_rdma_teardown_admin_queue(ctrl, false);
-- 
2.29.2


