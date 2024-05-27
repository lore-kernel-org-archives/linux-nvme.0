Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3308CC25B7D
	for <linux-nvme@archiver.kernel.org>; Mon, 27 May 2024 05:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=c9APcHVdDGjvejR95I5qDmibZbtEE3iBL0oxAxp23II=; b=bpMkFeeBCtIPa3tEm2Cu2iZehO
	1j2TOLdRQ+xocXZuWmhBHPbXYR+/6NsLWsW1o+sz4yLWQmA9WgO3tIyH5SgqoqOXv3cU4Fpq/NeYW
	RRRMic2r83TYeNLqhxSNLvP1BhtlGOqsRmqVL5Edf9oCUB25xdOlOP/zLXay9WEjYlaePl836l1W6
	AAPGg6wBe/3bZ5wQsmxktTNWJTQM3qYrXr1KmCfqG/nhTm47vGfC9pffL3XpbM7tawq9rCmHTKo7m
	RIb/l7Xtz0yHtQ6f/Br1BRZtZeVtznX2tHTrZ6WUpEe/wjZgk8uMcXuRnr0WO7OH2hlYXNTOueDJG
	CEPwz1yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBSiL-0000000Dobb-398E;
	Mon, 27 May 2024 05:16:05 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBSi7-0000000DoUi-1fpo
	for linux-nvme@lists.infradead.org;
	Mon, 27 May 2024 05:16:01 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A47921C46;
	Mon, 27 May 2024 05:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716786941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=c9APcHVdDGjvejR95I5qDmibZbtEE3iBL0oxAxp23II=;
	b=HhWDw8QaLhj2qVHjmYof0ylWjHvfnFmuqcLhxUMOWtIoyzppPO3Ny0lG2Hve26IDMfe5wJ
	Ug3hU6PkbNopSxm4SmFevUV/8kKrlUaVMNbdCRslc/YBwlJQHb3GJtf/XOdJH/vSWBOOv0
	zTxMjzEfofs9CikIB3recENMB0s+kJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716786941;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=c9APcHVdDGjvejR95I5qDmibZbtEE3iBL0oxAxp23II=;
	b=k4MaesZ30z3yLgYvBQQs8RlCCDrb+U8S6jkzCEpwfxwgdRDIdIz1gDLPO7lMM+ubXhCrxj
	C4yoBEHmuHJ+FrAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716786941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=c9APcHVdDGjvejR95I5qDmibZbtEE3iBL0oxAxp23II=;
	b=HhWDw8QaLhj2qVHjmYof0ylWjHvfnFmuqcLhxUMOWtIoyzppPO3Ny0lG2Hve26IDMfe5wJ
	Ug3hU6PkbNopSxm4SmFevUV/8kKrlUaVMNbdCRslc/YBwlJQHb3GJtf/XOdJH/vSWBOOv0
	zTxMjzEfofs9CikIB3recENMB0s+kJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716786941;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=c9APcHVdDGjvejR95I5qDmibZbtEE3iBL0oxAxp23II=;
	b=k4MaesZ30z3yLgYvBQQs8RlCCDrb+U8S6jkzCEpwfxwgdRDIdIz1gDLPO7lMM+ubXhCrxj
	C4yoBEHmuHJ+FrAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1780713A6B;
	Mon, 27 May 2024 05:15:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yW9ABP0WVGZYYQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 27 May 2024 05:15:41 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 0/7] nvmet: debugfs support
Date: Mon, 27 May 2024 07:15:18 +0200
Message-ID: <20240527051525.762-1-dwagner@suse.de>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240526_221551_920685_8ADA6668 
X-CRM114-Status: GOOD (  14.48  )
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

I've picked up Hannes series, because it allows to reset a controler which is
very helpful to implement failover tests in blktests.


Original cover letter:

taking up the original patchset for nvmet debugfs
I've improved upon that submission by modifying
the layout:

/dev/kernel/debug/nvmet
  <subsysnqn>
    ctrl<cntlid>
      port
      state
      hostnqn
      kato
      host_traddr

The 'state' attribute is the value of the
CSTS register; one can trigger a controller reset
by writing 'fatal' into it (to set CSTS.CFS).

Changes to v4:
  add RV by Chaitanya
  addresse comments from CChaitanya

Changes to v3:
- drop patch to add queue entries
  Reviews from Sagi

Changes to v2:
- Move the 'host_traddr' attribute to the
  controller directory
- Rename callback to 'host_traddr'


Hannes Reinecke (7):
  nvmet: add debugfs support
  nvmet: add 'host_traddr' callback for debugfs
  nvmet-tcp: implement host_traddr()
  nvmet-rdma: implement host_traddr()
  nvmet-fc: implement host_traddr()
  nvme-fcloop: implement 'host_traddr'
  lpfc_nvmet: implement 'host_traddr'

 drivers/nvme/target/Kconfig    |   9 ++
 drivers/nvme/target/Makefile   |   1 +
 drivers/nvme/target/core.c     |  30 ++++-
 drivers/nvme/target/debugfs.c  | 202 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/debugfs.h  |  42 +++++++
 drivers/nvme/target/fc.c       |  33 ++++++
 drivers/nvme/target/fcloop.c   |  11 ++
 drivers/nvme/target/nvmet.h    |  12 +-
 drivers/nvme/target/rdma.c     |  12 ++
 drivers/nvme/target/tcp.c      |  14 +++
 drivers/scsi/lpfc/lpfc_nvmet.c |  11 ++
 include/linux/nvme-fc-driver.h |   4 +
 12 files changed, 378 insertions(+), 3 deletions(-)
 create mode 100644 drivers/nvme/target/debugfs.c
 create mode 100644 drivers/nvme/target/debugfs.h

-- 
2.45.1


