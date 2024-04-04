Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91139CD1284
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 14:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jx+Z6u7CMBxXJn4u8BfxCYjEhAj4yGi0JtxFz9G1eOs=; b=cMg+o4pSavwEgUtFOE5SLWieX4
	NfJ7r6w5LRf2VGAUvoWvPYeleTxLbW19P7yFxEi+kpK8Ba9gnrB6TB+y5J9D/pZdI72NOFckfcq/z
	VIRI9WaOT5cx0n1yypAFyxqqcVaByjNdBzmqwl3kU+BytrxSAEz1C1+jx+VLXBhhdHjZkVAM8vtWO
	AZmONVaDXHAWKbh/dyo9i0+S+kxufnn3fNLtHpoQW9u8H1z0fkl37PAnGxJsCAfhppLtXRCnGrQFV
	vfrhDRUUinp1HjGYV5CVeGBUDeR9laoqhHIpMxCg/6ehIpqHeslQcCpz5FdwRTAb4ydg57BUr2Uc8
	nGJc5RCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsOHm-000000034lW-0WoE;
	Thu, 04 Apr 2024 14:41:50 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsOHd-000000034he-2aEN
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 14:41:46 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 50AFF5F804;
	Thu,  4 Apr 2024 14:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712241697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jx+Z6u7CMBxXJn4u8BfxCYjEhAj4yGi0JtxFz9G1eOs=;
	b=vuS/JLAD/Nx9ZCXZizupAiRGETXWU6gNFkIZlQ+ckepX8OeN7FzysxM80h7tS1kXGjA9W7
	uPrK8kiyiMtvtgWP874f5nM5i1ffeKVRv4t4Auk207lkvAl4mQ+ocVETRq2YjmA4l+6jzT
	T0dxl3jW9Kjbjcf0nXPR/U9rtJ0AT5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712241697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jx+Z6u7CMBxXJn4u8BfxCYjEhAj4yGi0JtxFz9G1eOs=;
	b=75MSEi25yJ7fQczoNtdvibhiDCX/QX9IQ+YJm5obMUoaBeLHJFjUiZ3H/R5NLgrcR0tq61
	hurafUUijdS6xHCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="vuS/JLAD";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=75MSEi25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712241697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jx+Z6u7CMBxXJn4u8BfxCYjEhAj4yGi0JtxFz9G1eOs=;
	b=vuS/JLAD/Nx9ZCXZizupAiRGETXWU6gNFkIZlQ+ckepX8OeN7FzysxM80h7tS1kXGjA9W7
	uPrK8kiyiMtvtgWP874f5nM5i1ffeKVRv4t4Auk207lkvAl4mQ+ocVETRq2YjmA4l+6jzT
	T0dxl3jW9Kjbjcf0nXPR/U9rtJ0AT5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712241697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jx+Z6u7CMBxXJn4u8BfxCYjEhAj4yGi0JtxFz9G1eOs=;
	b=75MSEi25yJ7fQczoNtdvibhiDCX/QX9IQ+YJm5obMUoaBeLHJFjUiZ3H/R5NLgrcR0tq61
	hurafUUijdS6xHCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 317A613298;
	Thu,  4 Apr 2024 14:41:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id e0+QCiG8DmZmDQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 04 Apr 2024 14:41:37 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 0/2] nvme(t)-fc: couple of fixes/cleanups
Date: Thu,  4 Apr 2024 16:41:29 +0200
Message-ID: <20240404144131.17988-1-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 50AFF5F804
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.02 / 50.00];
	BAYES_HAM(-2.01)[95.14%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:dkim];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_074142_045755_E84263C8 
X-CRM114-Status: UNSURE (   8.24  )
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

Both patches are just a rebased to the current nvme-6.9 head.

Daniel Wagner (2):
  nvmet-fc: move RCU read lock to nvmet_fc_assoc_exists
  nvme-fc: rename free_ctrl callback to match name pattern

 drivers/nvme/host/fc.c   |  4 ++--
 drivers/nvme/target/fc.c | 17 ++++++++++-------
 2 files changed, 12 insertions(+), 9 deletions(-)

-- 
2.44.0


