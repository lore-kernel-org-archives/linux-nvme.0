Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701DAC4167B
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Dec 2023 09:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WOtDxc+0CUVH1bgxuNgGLc6i5JbaWlWpPk+72gmy0nQ=; b=dfeh/6lLbTC2BBc8zvOGisU6ii
	jUGNAH+SP7FKrizNcoN3Ohhgnb2kcJbJ7tRfb8fk72t6rh6AIYQ1/WMvliwIi/xRRK9r8c5HjZ1un
	Gkji1srE96ykjnnfTNfk5FOZxdyqqGsglXXojZ3fMXaKSAcs3C3YO18SMjNbonIihL1Y2y25LKS4i
	abvrZWsXLjxlR648idecN96bETl9/L9JsAiVSjwp6MXKiH5mSQFnI02rWjBN25cZ1cak1MamxK1zl
	xGf1WYvSIRqT9KCI2vMb936E2x7faH74k8S4jwXHxSaR5Xke3ZJ8mTqN1n5s5S60AK+J2X2pho/A8
	VeOKPR3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8zoP-00D5UB-1y;
	Fri, 01 Dec 2023 09:27:53 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8zoM-00D5Sb-2B
	for linux-nvme@lists.infradead.org;
	Fri, 01 Dec 2023 09:27:52 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6DAD621C3E;
	Fri,  1 Dec 2023 09:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701422866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WOtDxc+0CUVH1bgxuNgGLc6i5JbaWlWpPk+72gmy0nQ=;
	b=dSU/z05URucCogX6a95hB/5PICcSlu/D5r7y6UaiH2YwO58AHna24Prpx3p5oocfr4QqZ8
	542O2gKNAL+2j3mj+41WSJCtXixNydmHuxP8Al7rHOILSH6L8wHXDmXG2Otd2fG+S1+NLH
	6eRItJGUob9JyIQ8RMOvvzUY/hu/Vt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701422866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WOtDxc+0CUVH1bgxuNgGLc6i5JbaWlWpPk+72gmy0nQ=;
	b=FlIzCByVIt2Es8zV7fh8DvnbmGHKBD5ByyJ3yAP0J+DGex8F+DNxhlDxKuzPULKrVxmiim
	133dIuUe826VGhBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C41013928;
	Fri,  1 Dec 2023 09:27:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Uh0XFRKnaWULZgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 01 Dec 2023 09:27:46 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC v2 0/3] nvme: add csi, ms and nuse to sysfs
Date: Fri,  1 Dec 2023 10:27:32 +0100
Message-ID: <20231201092735.28592-1-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [3.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[12.67%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231201_012750_865391_11D805D4 
X-CRM114-Status: UNSURE (   9.69  )
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

I've moved all ns id info to nvms_ns_head in this version as we discussed in v1
(hope I understood it right). The change was pretty much straightforward except for 

  nvme_mpath_clear_current_path
  nvme_mpath_revalidate_paths
  nvme_failover_req

where there is need to access a nvme_ns pointer again. I've tested this change
with the nvme-pci and nvme-tcp transport so far.

Thanks,
Daniel

libnvme changes:
  https://github.com/igaw/libnvme/tree/tree-no-cmd
  
changes:

v2:
 - moved ns id data to nvme_ns_head
 - dropped ds, nsze

v1:
 - initial version
 - https://lore.kernel.org/linux-nvme/20231127103208.25748-1-dwagner@suse.de/

Daniel Wagner (3):
  nvme: lookup ctrl from request instead from namespace
  nvme: move ns id info to struct nvme_ns_head
  nvme: add csi, ms and nuse to sysfs

 drivers/nvme/host/apple.c      |   4 +-
 drivers/nvme/host/core.c       | 191 +++++++++++++++++----------------
 drivers/nvme/host/fc.c         |   4 +-
 drivers/nvme/host/ioctl.c      |  20 ++--
 drivers/nvme/host/multipath.c  |  40 +++----
 drivers/nvme/host/nvme.h       |  57 +++++-----
 drivers/nvme/host/rdma.c       |  10 +-
 drivers/nvme/host/sysfs.c      |  24 +++++
 drivers/nvme/host/tcp.c        |   8 +-
 drivers/nvme/host/zns.c        |  30 +++---
 drivers/nvme/target/loop.c     |   4 +-
 drivers/nvme/target/passthru.c |   8 +-
 12 files changed, 216 insertions(+), 184 deletions(-)

-- 
2.43.0


