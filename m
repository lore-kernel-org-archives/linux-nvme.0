Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D02C10DCE
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Dec 2023 10:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6Zx4HAi3MJCgNFhjRTmgq2e0WGxIXkyuLgVhCxu8ER4=; b=tON1jjAqTUNmgezt26gv551DPO
	mzmoWVlb2Tp4y4ao1coRaxHte2vncKmkpqsaK+JIGBBZiHClV6B7TxGGaDz0vNpthMfszlEMZEv/V
	LgwXt5Lu/+KJUT5jOAawdeTZ6EjL0wZ53iOUZjt65TG9J/Bsc4fFoDaq4XTnfcYVeuKYQrHJ2LR6P
	aAYrNW3aOpQ0w4YstEpvtTNfADAzGp3R6Udodg4nZ8aat0tS4PI1rgkaJiLhUDf3sa6yqCsG9cm9i
	uTWGMTPdFUVuTyF4Lu+ENGRvCHYiU0G7ZUxsCHCcy3jYdtvmmqCsVhO3IRhRCPM1YfPROQhPXv8L8
	aNAyVOZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBYUT-00FIdl-0h;
	Fri, 08 Dec 2023 10:53:53 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBYUM-00FIZs-1N
	for linux-nvme@lists.infradead.org;
	Fri, 08 Dec 2023 10:53:49 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DEC0421188;
	Fri,  8 Dec 2023 10:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702032822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6Zx4HAi3MJCgNFhjRTmgq2e0WGxIXkyuLgVhCxu8ER4=;
	b=RsM65RxuZ6KhnsXcJTF2e2b6V4QR+YE9Vpt3JG3588WOLNGuB564xU9WIcUxF3AemyyLFo
	3ZJtxIv6T4wexY2IdLb9hWoXJtEX6hqo3Ed2jyMp0QkR/hV9EI6n9+EfDoQu4oeLO/j9dP
	x6gRH67YwfTuKVgBuyVmwe+ITwtMJlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702032822;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6Zx4HAi3MJCgNFhjRTmgq2e0WGxIXkyuLgVhCxu8ER4=;
	b=z9ziEXhl7MuZz6oxhcmGhYOBJOQPPJhPPkJPgIFPaAqVKoFoPPPDauT0uscSKBgfRIcXbu
	22phbi0vZgNTQaCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702032821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6Zx4HAi3MJCgNFhjRTmgq2e0WGxIXkyuLgVhCxu8ER4=;
	b=k+A13JlbZTevnEwzRtZOvgLGvMpi5AFZtYRF/yqpUr/Xv1hFLcLawFYIyq37oE4gCZvnWG
	5uj9wS2lB9GntbdzMqflUCDPPjei4vGIPuziiMQDvYhcPycnI9tt0l61M/uEoWLtWsvbjf
	axWPIcz+qKKYhta6BR6JfZ5na49aUI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702032821;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6Zx4HAi3MJCgNFhjRTmgq2e0WGxIXkyuLgVhCxu8ER4=;
	b=K2Soa8xnuHMJGI690socST+ObCRivTV0kP1mykMJ4tC+GQHxh0+40N5wVbprkVB77usy/Q
	5C1LL1WM0mEQAJCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C0C5B138FF;
	Fri,  8 Dec 2023 10:53:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id +maaLbX1cmUtVgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 08 Dec 2023 10:53:41 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 0/6] nvme: add csi, ms and nuse to sysfs
Date: Fri,  8 Dec 2023 11:53:31 +0100
Message-ID: <20231208105337.23409-1-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.29 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(0.00)[~all:c];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 DMARC_POLICY_ALLOW(0.00)[suse.de,none];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MX_GOOD(-0.01)[];
	 DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 WHITELIST_DMARC(-7.00)[suse.de:D:+];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spamd-Bar: /
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: DEC0421188
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=k+A13Jlb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=K2Soa8xn;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dwagner@suse.de) smtp.mailfrom=dwagner@suse.de;
	dmarc=pass (policy=none) header.from=suse.de
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231208_025346_635779_DBC2117E 
X-CRM114-Status: UNSURE (   9.94  )
X-CRM114-Notice: Please train this message.
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

I've added two new refactoring patches which convert a bunch of functions to
accpet nvme_ns_head instead of nvme_ns. Though I've left out the conversion of
nvme_update_ns_info_block because there are still users of nvme_ns deeper down
the callchain.

Besides this I've addressed all comments from v4, remove debug output, silence
ratelimit messages and revert the nvme_ns_head coversion in
nvme_zns_alloc_report_buffer.

The benchmark numbers are still roughly the same and all blktests for all
transports pass with this change. My previous claim in v3 that something is
broken for rdma turned out it's my test that setup was b0rken.

Thanks,
Daniel

libnvme changes:
  https://github.com/igaw/libnvme/tree/tree-no-cmd
  
changes:
v5:
 - reverted trigger happy conversion to nvme_ns_head in
   nvme_zns_alloc_report_buffer
 - removed debug output
 - added refactoring patches
 - ratelimit silence suppress messages
 - added reviewed tags

v4:
 - drop 'use nvme_ns_head instead nvme_ns' patches
 - ratelimit nuse update per namespace not globally
 - rename ns attribute group
 - added non-multipath nuse update logic
 - added cacheline optimization
 - https://lore.kernel.org/linux-nvme/20231207123624.29959-1-dwagner@suse.de/

v3:
 - cut overlong lines shorter
 - fixed disk (queuedata) initialization order
 - more testing with blktest
 - added nuse ratelimit
 - added reviewed tags
 - https://lore.kernel.org/linux-nvme/20231206081244.32733-1-dwagner@suse.de/

v2:
 - moved ns id data to nvme_ns_head
 - dropped ds, nsze
 - https://lore.kernel.org/linux-nvme/20231201092735.28592-1-dwagner@suse.de/

v1:
 - initial version
 - https://lore.kernel.org/linux-nvme/20231127103208.25748-1-dwagner@suse.de/


Daniel Wagner (6):
  nvme: move ns id info to struct nvme_ns_head
  nvme: refactor ns info helpers
  nvme: refactor ns info setup function
  nvme: rename ns attribute group
  nvme: add csi, ms and nuse to sysfs
  nvme: repack struct nvme_ns_head

 drivers/nvme/host/core.c      | 168 ++++++++++++++++++----------------
 drivers/nvme/host/ioctl.c     |   8 +-
 drivers/nvme/host/multipath.c |   2 +-
 drivers/nvme/host/nvme.h      |  44 +++++----
 drivers/nvme/host/rdma.c      |   4 +-
 drivers/nvme/host/sysfs.c     |  99 ++++++++++++++++++--
 drivers/nvme/host/zns.c       |  35 +++----
 7 files changed, 233 insertions(+), 127 deletions(-)

-- 
2.43.0


