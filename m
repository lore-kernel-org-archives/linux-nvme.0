Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB730C67861
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Apr 2024 09:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nUZ9ROs7tpTwP9jEjvqFK44yrx0e5Jmd5Sv60LZqK4I=; b=frqPqPobS3KJBYLTI3w7uQkk/j
	zHpY7FbmZs1HoXIsBLPxK13MlEaA4QiNMLhDxrHG47AZdodshWv7OHA4y5NlVuINdWxDObBZpn7QD
	k6fVRk0LwXyVJGrSJ+dKvN8Hj+qCDiy4v6VIcKTjLxcs+lQZeYKUl5DPv+P+8k3JlIaHNnsFPVutP
	YhjnPIPOUmZyq6HOmbtc5YqmyzRygk+oSBW+SqxlN6HiX1t1yy+BJFlf21S1XsQvvGuLtuRtaTzS5
	wwrjb5V+BeJUmqLLm0I2xLBGdxuHrfb58KBVSY3HuFp16jrks/eYw32RqVlacRufRKcYHV7/5dFSk
	zS0Fw7hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ru7t0-00000001EQD-1oBt;
	Tue, 09 Apr 2024 09:35:26 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ru7ss-00000001EMk-05ad
	for linux-nvme@lists.infradead.org;
	Tue, 09 Apr 2024 09:35:21 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D6A49338F0;
	Tue,  9 Apr 2024 09:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712655315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nUZ9ROs7tpTwP9jEjvqFK44yrx0e5Jmd5Sv60LZqK4I=;
	b=fFKQLJxF5Sx9Z3WCfDQGHeQqkPfTBdPiVS9uaQu0ZmROvDf6pGO6QcVstd2qYpEeiig+TK
	tEn2Ljx7YENoCfxW8C4ca+ikub6UBXlIWEnBHf1z/Zje83fX4MhLagrQTBpXIpTcWAubDp
	PcIhcq7CzWd7Ft3/V+WxC8HY/BFdkXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712655315;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nUZ9ROs7tpTwP9jEjvqFK44yrx0e5Jmd5Sv60LZqK4I=;
	b=FNABl6cJGpeEBQlBU/K8Mm09lKZzNt788E9+9MYt1gI/5LQtNb/wyn3Jd2G6hJV6mIxIyD
	QO7xh8Oy1gBBsIAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712655314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nUZ9ROs7tpTwP9jEjvqFK44yrx0e5Jmd5Sv60LZqK4I=;
	b=KtPOUBoJmAiexeFmHfU8KA1zrBu/2kSzD5CRBSH7RJCFm2UYWKdvOaSFFxUzFAWTtLbWDB
	2NsOX2TOCeLJb2Ix4tY+tiXGYKWfWinE0Um4NWHszr6XHLmnzKMHYMwdqEuNjnFTf0FoA+
	Gb6moj7hScC1HYaLeRHqF2/cdfaN0sY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712655314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nUZ9ROs7tpTwP9jEjvqFK44yrx0e5Jmd5Sv60LZqK4I=;
	b=gkScyaKVjDdusLWMjbQaatRFk/hyna8IDDuS1PE+rgpQBinJu39SYTbW3Ellcyjj2u3Ktn
	qcNTy0jSMErfrhAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BF7A81332F;
	Tue,  9 Apr 2024 09:35:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id +bcWLtILFWafRwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 09 Apr 2024 09:35:14 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 0/6]  nvme-fabrics: short-circuit connect retries
Date: Tue,  9 Apr 2024 11:35:04 +0200
Message-ID: <20240409093510.12321-1-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_023518_242765_30287B94 
X-CRM114-Status: GOOD (  14.14  )
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

The first patch returns only kernel error codes now and avoids overwriting error
codes later. Thje newly introduced helper for deciding if a reconnect should be
attempted is the only place where we have the logic (and documentation).

On the target side I've separate the nvme status from the dhchap status handling
which made it a bit clearer. I was tempted to refactor the code in
nvmet_execute_auth_send to avoid hitting the 80 chars limit but didn't came up
with something nice yet. So let's keep this change at a minimum before any
refactoring attempts.

I've tested with blktests and also an real hardware for nvme-fc.

changes:
v5:
  - nvme: do not mix kernel error code with nvme status
  - nvmet: separate nvme status from dhchap status
  - https://lore.kernel.org/all/20240404154500.2101-1-dwagner@suse.de/

v4:
  - rebased
  - added 'nvme: fixes for authentication errors' series
    https://lore.kernel.org/linux-nvme/20240301112823.132570-1-hare@kernel.org/

v3:
  - added my SOB tag
  - fixed indention
  - https://lore.kernel.org/linux-nvme/20240305080005.3638-1-dwagner@suse.de/

v2:
  - refresh/rebase on current head
  - extended blktests (nvme/045) to cover this case
    (see separate post)
  - https://lore.kernel.org/linux-nvme/20240304161006.19328-1-dwagner@suse.de/
  
v1:
  - initial version
  - https://lore.kernel.org/linux-nvme/20210623143250.82445-1-hare@suse.de/


Daniel Wagner (1):
  nvme-fc: use nvme_ctrl_reconnect to decide reconnect attempts

Hannes Reinecke (5):
  nvme: authentication error are always non-retryable
  nvmet: lock config semaphore when accessing DH-HMAC-CHAP key
  nvme-tcp: short-circuit reconnect retries
  nvme-rdma: short-circuit reconnect retries
  nvmet: return DHCHAP status codes from nvmet_setup_auth()

 drivers/nvme/host/core.c               |  6 ++--
 drivers/nvme/host/fabrics.c            | 25 ++++++-------
 drivers/nvme/host/fc.c                 |  4 +--
 drivers/nvme/host/nvme.h               | 26 +++++++++++++-
 drivers/nvme/host/rdma.c               | 22 ++++++++----
 drivers/nvme/host/tcp.c                | 23 +++++++-----
 drivers/nvme/target/auth.c             | 22 ++++++------
 drivers/nvme/target/configfs.c         | 22 +++++++++---
 drivers/nvme/target/fabrics-cmd-auth.c | 49 +++++++++++++-------------
 drivers/nvme/target/fabrics-cmd.c      | 11 +++---
 drivers/nvme/target/nvmet.h            |  8 ++---
 11 files changed, 134 insertions(+), 84 deletions(-)

-- 
2.44.0


