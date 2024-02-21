Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B66C48BC3
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Feb 2024 13:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FXYeO62jt9+Uvzxj4QWHRpl/i6uARaBpK/5WbPWR/5A=; b=fJ94KtofGis2apZHvnCU6NbSL/
	bow7YDw8OEBWmFwoThSXa80aaDOTPC/Vj6CVq8yANz4IHRLdqYv96iVi0ejARUP3VBe/gMIZcg7dX
	ah+kwk4+gMMEfB9Qz7iwpq4XPdImsPMx6uWW8grQCvrAXxFgcuPAEXnkd4Q40UhUNkig8N/EbLgVx
	5YNg7NCez8F282T7FVIAzKAPz1AFSB4kDfcfFp93O+RBfkrTY9KmkUHczNF8z4ZJrsjjgMkqJnCpY
	VX72PsCX4YAQLxh0XGuh7yjV9QInielEzWxTaaPMabidHTMqiSlt6eBeJpo19DcgL3K7g4OLBERsX
	En8cmLjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcmaA-000000011NL-396j;
	Wed, 21 Feb 2024 13:24:18 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcma6-000000011Ja-1Ndr
	for linux-nvme@lists.infradead.org;
	Wed, 21 Feb 2024 13:24:18 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A3A71FB5A;
	Wed, 21 Feb 2024 13:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708521852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FXYeO62jt9+Uvzxj4QWHRpl/i6uARaBpK/5WbPWR/5A=;
	b=BKHjPqQFR2lMS9ieo/ImpwT1ocXaX64aj3z+DNnsCRElZXJJ91+lJmLaBFA5l9IZRx7af6
	nPmUDp0+fFC4gKLUrbD1aW4qMa6yobFNCCRnh0jw4lhVx0NGpAepbs7qjOQnE1jj4zoVAK
	cGnHBFxhcq31rhWsHn+FQiXI94Vab2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708521852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FXYeO62jt9+Uvzxj4QWHRpl/i6uARaBpK/5WbPWR/5A=;
	b=kGD9s/1GY1rVNGYQa0q+inpgvp1K+HEm4NkXsju9dn1UsLhQ60dsqGYOl9yJHQRAH8AgXs
	NbZZaHIjPnHil8BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708521852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FXYeO62jt9+Uvzxj4QWHRpl/i6uARaBpK/5WbPWR/5A=;
	b=BKHjPqQFR2lMS9ieo/ImpwT1ocXaX64aj3z+DNnsCRElZXJJ91+lJmLaBFA5l9IZRx7af6
	nPmUDp0+fFC4gKLUrbD1aW4qMa6yobFNCCRnh0jw4lhVx0NGpAepbs7qjOQnE1jj4zoVAK
	cGnHBFxhcq31rhWsHn+FQiXI94Vab2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708521852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FXYeO62jt9+Uvzxj4QWHRpl/i6uARaBpK/5WbPWR/5A=;
	b=kGD9s/1GY1rVNGYQa0q+inpgvp1K+HEm4NkXsju9dn1UsLhQ60dsqGYOl9yJHQRAH8AgXs
	NbZZaHIjPnHil8BA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 67D7A13A25;
	Wed, 21 Feb 2024 13:24:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id WgHsF3z51WUSPQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 21 Feb 2024 13:24:12 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 0/5] nvme-fc: fix blktests nvme/041
Date: Wed, 21 Feb 2024 14:23:59 +0100
Message-ID: <20240221132404.6311-1-dwagner@suse.de>
X-Mailer: git-send-email 2.43.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BKHjPqQF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="kGD9s/1G"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
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
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 7A3A71FB5A
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_052414_542582_FD6B3E42 
X-CRM114-Status: GOOD (  11.97  )
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

As suggested by Keith I've merged the new flag for nvme-fabrics with the last
patch. I also added some information why nvme-fc is handling the initial connect
attempt differently as requested by Christoph.

The new flag is called connect_async and the default is false/0. I've tested
with a patched nvme-cli/libnvme version and all looks good. When this series is
accepted I'll update nvme-cli/libnvme accordingly. Note, that even with an older
nvme-cli the blktests (especially nvme/041) will pass with a newer kernel.

(nvme/048 is still fails but this is a different problem. On my TODO list)

changes:
v2:
 - renamed flag to connect_async, default false
 - add info to commit message why nvme-fc is different
 - merged connect_async with 'nvme-fc: wait for
   initial connect attempt to finish'

v1:
 - renamed 'nvme-fc: redesign locking and refcounting'
   to 'nvme-fc: reorder ctrl ref counting and cleanup code path'
 - testing with scsi/nvme dev_loss_tmo on real hw
 - removed rport ref counting part
 - collected RB tags
 - https://lore.kernel.org/linux-nvme/20240219131531.15134-1-dwagner@suse.de/
 
v0:
 - initial version
 - https://lore.kernel.org/linux-nvme/20240216084526.14133-1-dwagner@suse.de/

Daniel Wagner (5):
  nvme-fc: rename free_ctrl callback to match name pattern
  nvme-fc: do not retry when auth fails or connection is refused
  nvme-fabrics: introduce ref counting for nvmf_ctrl_options
  nvme-fc: reorder ctrl ref counting and cleanup code path
  nvme-fc: wait for initial connect attempt to finish

 drivers/nvme/host/fabrics.c |  39 +++++++++-
 drivers/nvme/host/fabrics.h |   9 ++-
 drivers/nvme/host/fc.c      | 145 +++++++++++++++++-------------------
 drivers/nvme/host/rdma.c    |  18 +++--
 drivers/nvme/host/tcp.c     |  21 ++++--
 drivers/nvme/target/loop.c  |  19 +++--
 6 files changed, 152 insertions(+), 99 deletions(-)

-- 
2.43.1


