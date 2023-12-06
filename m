Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019A7C4167B
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Dec 2023 08:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0EQpfS7ucerLfy2TMEIonaRwXBXatilAvTAIHrEXghw=; b=fEgMo1XL2woMB5Cq/8g24Lei9f
	8VuDH5137tuPFJLQBCpi4Sk3Fo6HDaF7YNblAQDpX2Z7EgFBGspNkBm8tXckuW/OXXkQ4TWu3ROvM
	pJlkDgA3LcJIygvWWCC2LuFifNHFEyzOV4bUAncxNiGXwVR8tRQI1gg1JHaq/9iOVKanwr+o0j7v/
	TqTkmbIvfqlp/vptzMXpMKpeqaLrLcDJ5NoV8W9At26Z2ZZ3moQcsM3YfSPyBoS/8GAMyasz0z7iH
	KdT8cRk0+u3vqiFTKZzaj8iVxayIVkoSX1SLumT2cgqm8e826wz9YZqVyAcwIEjtoBXEVei/T4j70
	wF5Hbqrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAn1c-009Mnj-2m;
	Wed, 06 Dec 2023 08:12:56 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAn1Z-009MlL-0N
	for linux-nvme@lists.infradead.org;
	Wed, 06 Dec 2023 08:12:54 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 069232206B;
	Wed,  6 Dec 2023 08:12:49 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E5D57133DD;
	Wed,  6 Dec 2023 08:12:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id TNGhNgAtcGUPHgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 06 Dec 2023 08:12:48 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 0/4] nvme: add csi, ms and nuse to sysfs
Date: Wed,  6 Dec 2023 09:12:40 +0100
Message-ID: <20231206081244.32733-1-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [4.21 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(2.22)[0.738];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(0.00)[~all:c];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spamd-Bar: ++++
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dwagner@suse.de) smtp.mailfrom=dwagner@suse.de
X-Rspamd-Queue-Id: 069232206B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_001253_326183_02A23EE8 
X-CRM114-Status: UNSURE (   9.00  )
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

I'v dropped the RFC status and tested it lot more which found an obvious bug.
When initializating the disk in nvme_alloc_ns, the ns->head pointer was still
NULL. This is why I added the 'nvme: initialize head before namespace' patch.

I can't really explain why my testing didn't catch this earlier. Anyway, I
rebuild my test setup completely to make sure I got the most obvious things
tested. The blktests with loop and nvme-tcp pass, nvme-rdma breaks but so does
the base line test. So not a regression by this series.

Thanks,
Daniel

libnvme changes:
  https://github.com/igaw/libnvme/tree/tree-no-cmd
  
changes:
v3:
 - cut overlong lines shorter
 - fixed disk (queuedata) initialization order
 - more testing with blktest
 - added nuse ratelimit
 - added reviewed tags

v2:
 - moved ns id data to nvme_ns_head
 - dropped ds, nsze
 - https://lore.kernel.org/linux-nvme/20231201092735.28592-1-dwagner@suse.de/

v1:
 - initial version
 - https://lore.kernel.org/linux-nvme/20231127103208.25748-1-dwagner@suse.de/

Daniel Wagner (4):
  nvme: lookup ctrl from request instead from namespace
  nvme: initialize head before namespace
  nvme: move ns id info to struct nvme_ns_head
  nvme: add csi, ms and nuse to sysfs

 drivers/nvme/host/apple.c      |   4 +-
 drivers/nvme/host/core.c       | 279 +++++++++++++++++++--------------
 drivers/nvme/host/fc.c         |   4 +-
 drivers/nvme/host/ioctl.c      |  20 +--
 drivers/nvme/host/multipath.c  |  31 ++--
 drivers/nvme/host/nvme.h       |  62 ++++----
 drivers/nvme/host/rdma.c       |  10 +-
 drivers/nvme/host/sysfs.c      |  31 ++++
 drivers/nvme/host/tcp.c        |   8 +-
 drivers/nvme/host/zns.c        |  34 ++--
 drivers/nvme/target/loop.c     |   4 +-
 drivers/nvme/target/passthru.c |   8 +-
 12 files changed, 291 insertions(+), 204 deletions(-)

-- 
2.43.0


