Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2F2C4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Apr 2024 13:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hP3+rSE6dC1kyvM4PrsVsdM9kaG51YId12Fi+b44hcM=; b=OIDnL4W4Xwrx5/ibyupj1RmR1g
	WEAxOPwNafYOqoBKYk28HCo+bDDS/Phe8hpKkCaI9GVvNFPiDImcMcPUYxxDF/TIs8bHz79Hso5aF
	va1e9JNN2L8flfWqjFwfr3NuhQH7mCUs0SidyhhHJBcCokKb+86m7ZZJm4xilGNnPM3Mcttxw+0sB
	uaEcB+spqKsbFqs6kOGi+Gr9iv6c+YEMacfMbJG/0LhtvrzADZRUUT0ootjF+ICi+a1zrW4Lu3O+B
	6iY2+EtVqCZwNudj7fk2BFM+JQNR57wXJh1XdUsIUDOkL0T2CQWRO4XC8DHKzInifzRYdBKwhdsvk
	740xuaVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1nOa-00000006UiK-3Paq;
	Tue, 30 Apr 2024 13:19:44 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1nOW-00000006Uh2-1aMX
	for linux-nvme@lists.infradead.org;
	Tue, 30 Apr 2024 13:19:43 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 622C91F7E3;
	Tue, 30 Apr 2024 13:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714483175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hP3+rSE6dC1kyvM4PrsVsdM9kaG51YId12Fi+b44hcM=;
	b=XqKNPmxVbiW1ma3f5nSK4ojPJovfZdxxRlSBljL6bzxex075dvFUL81+hYyCV2/K5fX50p
	bSvWcfzVFIWL+FKEljz5p9Tl4h6c2B+nsEh1tT7rUXJoZDOhmllHDm3u8ZWtdq1F+fSvuk
	Fnp9nyoAofBsaEOTR4X+P0N1BXqAQgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714483175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hP3+rSE6dC1kyvM4PrsVsdM9kaG51YId12Fi+b44hcM=;
	b=+cGZ9RCyuylUPb1e/HJB/Z2fU/Ssz7jqsHk54J1+9nZr8CC0WoAvquxQe90Gv/d/HFtqld
	BfG9U2yIejIiGgAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XqKNPmxV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+cGZ9RCy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714483175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hP3+rSE6dC1kyvM4PrsVsdM9kaG51YId12Fi+b44hcM=;
	b=XqKNPmxVbiW1ma3f5nSK4ojPJovfZdxxRlSBljL6bzxex075dvFUL81+hYyCV2/K5fX50p
	bSvWcfzVFIWL+FKEljz5p9Tl4h6c2B+nsEh1tT7rUXJoZDOhmllHDm3u8ZWtdq1F+fSvuk
	Fnp9nyoAofBsaEOTR4X+P0N1BXqAQgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714483175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hP3+rSE6dC1kyvM4PrsVsdM9kaG51YId12Fi+b44hcM=;
	b=+cGZ9RCyuylUPb1e/HJB/Z2fU/Ssz7jqsHk54J1+9nZr8CC0WoAvquxQe90Gv/d/HFtqld
	BfG9U2yIejIiGgAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F747133A7;
	Tue, 30 Apr 2024 13:19:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gyT2EefvMGZgMAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 30 Apr 2024 13:19:35 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v7 0/5] nvme-fabrics: short-circuit connect retries
Date: Tue, 30 Apr 2024 15:19:23 +0200
Message-ID: <20240430131928.29766-1-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 622C91F7E3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240430_061940_647396_7D9C3FB0 
X-CRM114-Status: GOOD (  14.01  )
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

I've splitted the last patch into the hopefully non controversial part 'do not
retry when DNR is set' and the 'don't retry auth failures'. I hope we can get at
least the first few patches in and have a lively discussion on the final patch
at LSF.

changes:
v7:
 - updated commit message patch #3
 - split last patch so that only the DNR checks
   are added first and then the auth reconnect failure test

v6:
  - reorder series
  - extended nvmf_should_reconnect
  - added auth retry logic
  - https://lore.kernel.org/linux-nvme/20240415124220.5433-1-dwagner@suse.de/
  
v5:
  - nvme: do not mix kernel error code with nvme status
  - nvmet: separate nvme status from dhchap status
  - https://lore.kernel.org/linux-nvme/20240409093510.12321-1-dwagner@suse.de/

v4:
  - rebased
  - added 'nvme: fixes for authentication errors' series
  - https://lore.kernel.org/all/20240404154500.2101-1-dwagner@suse.de/

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
  nvme: do not retry authentication failures

Hannes Reinecke (4):
  nvmet: lock config semaphore when accessing DH-HMAC-CHAP key
  nvmet: return DHCHAP status codes from nvmet_setup_auth()
  nvme: return kernel error codes for admin queue connect
  nvme-fabrics: short-circuit reconnect retries

 drivers/nvme/host/auth.c               |  6 +--
 drivers/nvme/host/core.c               |  6 +--
 drivers/nvme/host/fabrics.c            | 51 ++++++++++++++++----------
 drivers/nvme/host/fabrics.h            |  2 +-
 drivers/nvme/host/fc.c                 |  4 +-
 drivers/nvme/host/nvme.h               |  2 +-
 drivers/nvme/host/rdma.c               | 19 ++++++----
 drivers/nvme/host/tcp.c                | 22 +++++++----
 drivers/nvme/target/auth.c             | 22 +++++------
 drivers/nvme/target/configfs.c         | 22 ++++++++---
 drivers/nvme/target/fabrics-cmd-auth.c | 49 +++++++++++++------------
 drivers/nvme/target/fabrics-cmd.c      | 11 +++---
 drivers/nvme/target/nvmet.h            |  8 ++--
 13 files changed, 129 insertions(+), 95 deletions(-)

-- 
2.44.0


