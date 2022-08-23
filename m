Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F069C32774
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Aug 2022 07:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EvM12OtBZswmtqps6W446O4uuQ2rfAM6CRFzYh12zU4=; b=GOPs7JgH+mLWsIhgG05VyQlDUd
	eWNl+AXlFh4s/qqd98DVLijRKgESMd9q8JvGbVI2Gn7wH1kfVE0mWiwXVALzlSjY/nJkfaQ12rP2w
	qW2zy3hYswGdVXf/aeguXRYrdjuNarYudj05WwZldk7HvCnlYV7rRGNY/lDdBnEhH8JbM8VZyMwG9
	ikSIXJnMLZohMOMyzi0yJhkiOA56Hv2pdcqwfI2RhH7PpJJbVqwUyA5UZ4GBpKlq9ukCBwcy2ynjW
	xMPmwQ252HCFTzyBYE7DVSOXYOT/VvCfkgRKoYbi3wzsVsQIm6fiZOQd1iGPsfCgXbVciJNZuOsx4
	WusGWPgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQOat-003ZX6-On; Tue, 23 Aug 2022 07:45:03 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQOaq-003ZRg-SQ
	for linux-nvme@lists.infradead.org; Tue, 23 Aug 2022 07:45:02 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B387D5CE40;
	Tue, 23 Aug 2022 07:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661240695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EvM12OtBZswmtqps6W446O4uuQ2rfAM6CRFzYh12zU4=;
	b=Cwb20HGFoDFJnUCcxJymVONpLbMKWKPHsutL/Hfr2FjfAtdyD6mY3hk40zw6fEmiG+RNzS
	+9tNcou+My+1O5TGccJQsHoO2Vqrn2Ejn98qO5JYZn89JEgNsK/vGk7LysvB2MM5vdVxGb
	vwCyI7WAnzGLAGuvK7kT5KO3/WUiqi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661240695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EvM12OtBZswmtqps6W446O4uuQ2rfAM6CRFzYh12zU4=;
	b=x6XDuuvNwbkbi80jNusSRxa0a0oCuOVqoGmohbyBp4x7rLgmhzTn/NGSkbu7TzjY0RJy3K
	l+aASozO9UllzwDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5E9F13AB7;
	Tue, 23 Aug 2022 07:44:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id sRp2KHeFBGMuQwAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 23 Aug 2022 07:44:55 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 0/3] Handle number of queue changes
Date: Tue, 23 Aug 2022 09:44:48 +0200
Message-Id: <20220823074451.12170-1-dwagner@suse.de>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220823_004501_111742_C908F969 
X-CRM114-Status: GOOD (  14.81  )
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

Updated this series to a proper patch series with Sagi's feedback
addressed.

This version updates the caller side of nvme_tcp_start_io_queues()
which queues need to be started instead making
nvme_tcp_start_io_queues() re-entrant safe.

I tested this properly with nvme-tcp but due to lack of hardware the
nvme-rdma is only compile tested.

Daniel


From the previous cover letter:

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


changes:
v2:
 - removed debug logging
 - pass in queue range idx as argument to nvme_tcp_start_io_queues
v1:
 - https://lore.kernel.org/linux-nvme/20220812142824.17766-1-dwagner@suse.de/

Daniel Wagner (3):
  nvmet: Expose max queues to sysfs
  nvme-tcp: Handle number of queue changes
  nvme-rdma: Handle number of queue changes

 drivers/nvme/host/rdma.c       | 26 ++++++++++++---
 drivers/nvme/host/tcp.c        | 59 ++++++++++++++++++++++------------
 drivers/nvme/target/configfs.c | 25 ++++++++++++++
 3 files changed, 84 insertions(+), 26 deletions(-)

-- 
2.37.1


