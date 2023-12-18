Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDC7C46CD2
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 17:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MWYDStw9L70g5Zod1mNSFlqE3RQHs5nnHmAPxDPRssE=; b=w00q6Ic73HxW6zgt5WRHV/oe3D
	N9Awx/TaAqvOqipj+w3aU+B3yLIQWWwXbJOvRXg7sVYoO8959I0MLPrODzfQjlJkW5C8mQMEQJJXy
	EYlVz2HgoHksUa18qgoEJmTVcsO02qU5hNHm0MxDOpdG+nxu6AWnMp0h4cSCpIspkrGuiuj4USLEO
	c5+qfepYhFgNz0F8oBUSi1wr/K2Pbbu9rFl+8M8qpJi2EOxV4TXwhICIbz2p1vqs8x4Rb7U5EAmEV
	XurZUz4aO5KnhUuchw0CL2rELZp+5p5PkZWbKbG4xR38rNrE6a5aqU+BMWI/T0aw/e0N0+T0JqEor
	C09nx3WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFGyN-00BXy5-16;
	Mon, 18 Dec 2023 17:00:07 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFGyI-00BXup-19
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 17:00:04 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D39FA21EF5;
	Mon, 18 Dec 2023 16:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702918800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MWYDStw9L70g5Zod1mNSFlqE3RQHs5nnHmAPxDPRssE=;
	b=cAxXR+pHWkRuzuTKvZFWyo6rfT0PC0drfIqS8xOMKZ0hzdVX4xW2VlUgntgl1C1UqSif1k
	eTbT+LZox0Uy/+g/b0YwNjsRlfJGGZhjjTbZ7kom/m19WPH2n/1ExpGwRKbwvHPtvLv9ye
	jTkdg/NEX9SqMX8CHJ+XxrEnNM5970Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702918800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MWYDStw9L70g5Zod1mNSFlqE3RQHs5nnHmAPxDPRssE=;
	b=52DZ6vTdaqtPqXSlsmvasQ/oW8UedV9sVs2T7bAAeIV1m8iZpMRmO7CABH2lZMOLYoG4aU
	D8Dg0uJ5BxiutGDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702918799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MWYDStw9L70g5Zod1mNSFlqE3RQHs5nnHmAPxDPRssE=;
	b=DppdkvQigj7Q4wD3rzocvUIo5UYpYKHMrbS2FdqGRipEAhYtNII6kq2EDF5t0fsLPSGHZm
	TIXecfcGTw9QbNu0oBb0TNPaobQFX4ojdf9jvUAa+2CeAbC/7in0GQlezT0jhikSyc9M4g
	xohH4ap0jx0SPkULDG65qmQZ7qChaFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702918799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MWYDStw9L70g5Zod1mNSFlqE3RQHs5nnHmAPxDPRssE=;
	b=nYGz42lRbI8gFvP2HXoZ8wAI7L0eWd/31XM431AcKXegqekv4fJ8ln8xr3BleZuS/eTew+
	b/mYTwsJSExoNHBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B6D8A13927;
	Mon, 18 Dec 2023 16:59:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id OR9PLI96gGU6DwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 18 Dec 2023 16:59:59 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v6 0/6] nvme: add csi, ms and nuse to sysfs
Date: Mon, 18 Dec 2023 17:59:48 +0100
Message-ID: <20231218165954.29652-1-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DppdkvQi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nYGz42lR
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [6.59 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: D39FA21EF5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_090002_967934_C767BD27 
X-CRM114-Status: GOOD (  10.28  )
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

Rebased on the current nvme/nvme-6.8 branch and added the Review tags. Also
addressed the printk format issue pointed out by Chaitanya.

About PI: I've added a note to the first commit pointing on this topic. I
understood from the discussion, that yes it is an issue but it already exists
and we will address this in future.

Thanks,
Daniel

libnvme changes:
  https://github.com/igaw/libnvme/tree/tree-no-cmd
  
changes:
v6:
 - rebased on nvme/nvme-6.8
 - collected Reviewed tags
 - updated printk format

v5:
 - reverted trigger happy conversion to nvme_ns_head in
   nvme_zns_alloc_report_buffer
 - removed debug output
 - added refactoring patches
 - ratelimit silence suppress messages
 - added reviewed tags
 - https://lore.kernel.org/linux-nvme/20231208105337.23409-1-dwagner@suse.de/

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


