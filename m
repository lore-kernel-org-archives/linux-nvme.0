Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2946C48BF8
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Feb 2024 13:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=G5EyMVdXXxhNc2ezMbCFmBs8mUlofzAqan8kAI7uhmc=; b=j9yqkG2CDlqmhPS0uxlJwiDqh7
	1S4pwsXEHPWqFUyrgx9IRgn3Pvi+URpFV8VpwT+FXKDgIoF746UbxsU0ICA+Ra7CeLg8P/dNwf+Vj
	FdEyhVY3WrhYj5TwXyWTVbIiLzVn0Bn5M1l01wxjcRv7BnA7D9al4G7p4ZWcceBUM7zxFQBVpw87V
	vnNDaPqvcLQUq2jQxNWURnbN6Q0j/2iNpPdusNO0sk9ubOLlDPGVYh4m+cZ1faX9Qx5zPGi+0fNbv
	zerk+FHSfZq0y+DVFBLpqOlKHsfwCqny1vxc9yUNDIdpd+ZxGWLispqFft3n21rXqN32GM7eJBbzx
	GsrS+GIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc3Uj-0000000AaTf-45Sy;
	Mon, 19 Feb 2024 13:15:41 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc3Uf-0000000AaQB-0H2m
	for linux-nvme@lists.infradead.org;
	Mon, 19 Feb 2024 13:15:40 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8FAF821DF1;
	Mon, 19 Feb 2024 13:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708348533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=G5EyMVdXXxhNc2ezMbCFmBs8mUlofzAqan8kAI7uhmc=;
	b=yJY5W4nPGU6Ze3DkQHAD9GkzYwPrLXb1xk0AAyzz5CKEqxycKCnd4Dy/9w3vn/eF2fhz46
	zcVlFUSVZCNaiRlTCG+jTTouKYpuTlmThhWzZyEY7KnPatCsUYczud1QQoDH02hhZnJ32z
	W/SRDvyHMuaH+4u90AZrvTo6sCpwR0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708348533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=G5EyMVdXXxhNc2ezMbCFmBs8mUlofzAqan8kAI7uhmc=;
	b=PHvv8t4+rHhV9q790jaKpq03kTYi9g+bod7oVrzpcXGOxx3EXBUeT973h2X+Y9O4OoHmYu
	CANxfNFTuoDlBzDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708348533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=G5EyMVdXXxhNc2ezMbCFmBs8mUlofzAqan8kAI7uhmc=;
	b=yJY5W4nPGU6Ze3DkQHAD9GkzYwPrLXb1xk0AAyzz5CKEqxycKCnd4Dy/9w3vn/eF2fhz46
	zcVlFUSVZCNaiRlTCG+jTTouKYpuTlmThhWzZyEY7KnPatCsUYczud1QQoDH02hhZnJ32z
	W/SRDvyHMuaH+4u90AZrvTo6sCpwR0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708348533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=G5EyMVdXXxhNc2ezMbCFmBs8mUlofzAqan8kAI7uhmc=;
	b=PHvv8t4+rHhV9q790jaKpq03kTYi9g+bod7oVrzpcXGOxx3EXBUeT973h2X+Y9O4OoHmYu
	CANxfNFTuoDlBzDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BC7F139C6;
	Mon, 19 Feb 2024 13:15:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id bOXGHHVU02X2AgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 19 Feb 2024 13:15:33 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v1 0/6] nvme-fc: fix blktests nvme/041
Date: Mon, 19 Feb 2024 14:15:25 +0100
Message-ID: <20240219131531.15134-1-dwagner@suse.de>
X-Mailer: git-send-email 2.43.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yJY5W4nP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PHvv8t4+
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.63 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.86)[94.17%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Queue-Id: 8FAF821DF1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_051537_285023_FF00310B 
X-CRM114-Status: GOOD (  10.05  )
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

I've dropped the rport ref counting change in the main patch and gave it another
round of testing. This time with dev_loss_tmo active with SCSI and NVME enabled
on the same rport. Nothing exploded, all resources were released correctly.

I am not so happy with the 'connect_sync' name yet (patch #1) but we still have
to agree on that offloading the initial connect attemp is correct. James and
Hannes are strongly in favour for this approach as far I can tell.

changes:
v1:
 - renamed 'nvme-fc: redesign locking and refcounting'
   to 'nvme-fc: reorder ctrl ref counting and cleanup code path'
 - testing with scsi/nvme dev_loss_tmo on real hw
 - removed rport ref counting part
 - collected RB tags
v0:
 - initial version
 - https://lore.kernel.org/linux-nvme/20240216084526.14133-1-dwagner@suse.de/

Daniel Wagner (6):
  nvme-fabrics: introduce connect_sync option
  nvme-fc: rename free_ctrl callback to match name pattern
  nvme-fc: do not retry when auth fails or connection is refused
  nvme-fabrics: introduce ref counting for nvmf_ctrl_options
  nvme-fc: reorder ctrl ref counting and cleanup code path
  nvme-fc: wait for connect attempt to finish

 drivers/nvme/host/fabrics.c |  28 ++++++-
 drivers/nvme/host/fabrics.h |   9 ++-
 drivers/nvme/host/fc.c      | 145 +++++++++++++++++-------------------
 drivers/nvme/host/rdma.c    |  18 +++--
 drivers/nvme/host/tcp.c     |  21 ++++--
 drivers/nvme/target/loop.c  |  19 +++--
 6 files changed, 141 insertions(+), 99 deletions(-)

-- 
2.43.1


