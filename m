Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81944C4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Apr 2024 12:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xCUjHhPcLIikr2Xjthccw3uC0sbKS2tipG0r76S/jOQ=; b=YHuW0YWxZGEBlkV8F0oMnRJBr8
	TXtpQnldoQsAadml9OmnVuz2r8IulQCJxZipZ5LlhAJ6m4PRZXyGt0qBWYBNd+iqTHRnVYX6UZMKg
	5lwO7ule7XZqaJKKIwAAL73WZ+fWHl7M75vj0yqkrPf7hmPMgaSNMKyK88EYi1um594WDaqsIEwgw
	dA1APjPdV0DEaGm0Q2G+a4CBjZU1xLvHg6WrOxr40RkjxU3pWoU8wtLadR/UKuSvES9KgJxfaYwSL
	Eur1UgxN+7a4HtEzkBOHaGxKvQ91IBD54zEPM6Wg4UONFusbJi9FTPcbHbalGDABbDb4oeqBODO3g
	iYDkNYRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwLfW-00000008EmJ-0VoO;
	Mon, 15 Apr 2024 12:42:42 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwLfH-00000008Edh-0TiU
	for linux-nvme@lists.infradead.org;
	Mon, 15 Apr 2024 12:42:35 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 97A025CF88;
	Mon, 15 Apr 2024 12:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713184942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xCUjHhPcLIikr2Xjthccw3uC0sbKS2tipG0r76S/jOQ=;
	b=Riq6rqQ863fIP0WTUEZ9AYHsttx6WtbFG6GhrtY0125ZA1XqBdg05Z+731h0s5j3uLtvxI
	GMgctyXGuwlBGAPH4IB8AKstPkD1AdnOlfsXzdXrru7uz0UlsBqU4bBL6KkT3/tJES4fr2
	pwyyWbUU25CwCSsOnJ2v8hZSiNWkRJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713184942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xCUjHhPcLIikr2Xjthccw3uC0sbKS2tipG0r76S/jOQ=;
	b=kBnk/nnKfEiUIbOYOphI7IXXBw5HpS8tW5ggSgUAI6iPVvTMaIAPcZebgEVNlCTSi3tQbX
	zLoN/jLcDZ+NR3Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713184942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xCUjHhPcLIikr2Xjthccw3uC0sbKS2tipG0r76S/jOQ=;
	b=Riq6rqQ863fIP0WTUEZ9AYHsttx6WtbFG6GhrtY0125ZA1XqBdg05Z+731h0s5j3uLtvxI
	GMgctyXGuwlBGAPH4IB8AKstPkD1AdnOlfsXzdXrru7uz0UlsBqU4bBL6KkT3/tJES4fr2
	pwyyWbUU25CwCSsOnJ2v8hZSiNWkRJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713184942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xCUjHhPcLIikr2Xjthccw3uC0sbKS2tipG0r76S/jOQ=;
	b=kBnk/nnKfEiUIbOYOphI7IXXBw5HpS8tW5ggSgUAI6iPVvTMaIAPcZebgEVNlCTSi3tQbX
	zLoN/jLcDZ+NR3Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A8B91386E;
	Mon, 15 Apr 2024 12:42:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7pyxHK4gHWYnAwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 15 Apr 2024 12:42:22 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v6 0/5] nvme-fabrics: short-circuit connect retries
Date: Mon, 15 Apr 2024 14:42:15 +0200
Message-ID: <20240415124220.5433-1-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_HAS_DN(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240415_054227_344480_B3337A79 
X-CRM114-Status: GOOD (  13.51  )
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

I've resorted the series so that the nvmet changes come first instead as the
last patch. These changes are necessary to get the host code tested.

The second big changes is moving the logic into the existing helper
nvmf_should_reconnect, all the transports get updated in one go.

And lastely, I've added a retry auth failure patch as requested by Sagi. I
explictly decided against to count these error from the normal retry counter
(nr_reconnects) as this would make it unnecessary complex to map the two
different max limits into one counter.

changes:
v6:
  - reorder series
  - extended nvmf_should_reconnect
  - added auth retry logic
  
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
  nvme-fabrics: handle transient auth failures

Hannes Reinecke (4):
  nvmet: lock config semaphore when accessing DH-HMAC-CHAP key
  nvmet: return DHCHAP status codes from nvmet_setup_auth()
  nvme: authentication error are always non-retryable
  nvme-fabrics: short-circuit reconnect retries

 drivers/nvme/host/auth.c               |  4 +-
 drivers/nvme/host/core.c               |  6 +--
 drivers/nvme/host/fabrics.c            | 58 +++++++++++++++++---------
 drivers/nvme/host/fabrics.h            |  2 +-
 drivers/nvme/host/fc.c                 |  6 +--
 drivers/nvme/host/nvme.h               |  3 +-
 drivers/nvme/host/rdma.c               | 20 +++++----
 drivers/nvme/host/tcp.c                | 23 ++++++----
 drivers/nvme/target/auth.c             | 22 +++++-----
 drivers/nvme/target/configfs.c         | 22 +++++++---
 drivers/nvme/target/fabrics-cmd-auth.c | 49 +++++++++++-----------
 drivers/nvme/target/fabrics-cmd.c      | 11 ++---
 drivers/nvme/target/nvmet.h            |  8 ++--
 13 files changed, 140 insertions(+), 94 deletions(-)

-- 
2.44.0


