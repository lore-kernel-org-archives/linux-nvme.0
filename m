Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53268C46CD2
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 09:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NWnp6jiMMzTOot4gN/xZQyWbHCyYI7lT4iVyNeo9e2M=; b=hT8WNuGuLtCy3cJ95zIscHrLn0
	pUih3WeqVuwuJTiIbK141HIKLYf3e2aUqf1hQTz42twME8MM59t3p1C+Rb4aVFRvXt7JyZTn1D9W7
	sIixlSylWfTg7CwWOHXrA1dTH7OSP7PvbGYHJboZniEqZV02LRWBXaZqRJlOf3uFf/bj4vvmOhIVH
	JcX1OA6zFDZ07DOgC9Val3e7tiwbY/2PHSgYrIsaXZEglQTVFSu4Ef6TP9LJWW9lnHKbba8Rh31SZ
	sbkjI2WQFbITzjgCXmbzaCx8yWuTWJk0Tp1IVQZYJHJIUFVqenjXAxOyEe41rA0pqWY5ZWn7QYOwp
	OJLHku1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUkkg-0000000G0zh-49Zs;
	Tue, 30 Jan 2024 09:49:59 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUkka-0000000G0vi-3nKY
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 09:49:57 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B337F1F841;
	Tue, 30 Jan 2024 09:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706608187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NWnp6jiMMzTOot4gN/xZQyWbHCyYI7lT4iVyNeo9e2M=;
	b=Z5Yx1iiC/mBJaW/gldGKjtiTC1Nopfg9iL9FuJqOALvYlTyYLlZWf+nc+c3hEna9Zjs/Ch
	EwrOzkdBcoCGvgHnnkqSQuxiNEr4rHuqS4/cVtVn9IyH5OmSV5QTH0c0XdAjRn6rqd2M2/
	8WEcGgQQEon51CXPrv5T5Vagrlw4dSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706608187;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NWnp6jiMMzTOot4gN/xZQyWbHCyYI7lT4iVyNeo9e2M=;
	b=us3GJlEwaluiOuAvpvuSZgVLViIBQr5H+pOmDnfMQU9Iwk9WTawScoUDTAHd0qBKEBWpEe
	upCL0aXt6JHU28Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706608187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NWnp6jiMMzTOot4gN/xZQyWbHCyYI7lT4iVyNeo9e2M=;
	b=Z5Yx1iiC/mBJaW/gldGKjtiTC1Nopfg9iL9FuJqOALvYlTyYLlZWf+nc+c3hEna9Zjs/Ch
	EwrOzkdBcoCGvgHnnkqSQuxiNEr4rHuqS4/cVtVn9IyH5OmSV5QTH0c0XdAjRn6rqd2M2/
	8WEcGgQQEon51CXPrv5T5Vagrlw4dSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706608187;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NWnp6jiMMzTOot4gN/xZQyWbHCyYI7lT4iVyNeo9e2M=;
	b=us3GJlEwaluiOuAvpvuSZgVLViIBQr5H+pOmDnfMQU9Iwk9WTawScoUDTAHd0qBKEBWpEe
	upCL0aXt6JHU28Cw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A00F413462;
	Tue, 30 Jan 2024 09:49:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id j0irJTvGuGWCbwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 30 Jan 2024 09:49:47 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 00/12] enable nvmet-fc for blktests
Date: Tue, 30 Jan 2024 10:49:26 +0100
Message-ID: <20240130094938.1575-1-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_014953_126612_3072B8FE 
X-CRM114-Status: GOOD (  12.25  )
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

The first version which allows to run blktests in loop without crashing or
hanging forever somewhere. The missing fix was the argument swap patch
for list_add_tail, which ensured no response gets dropped on tbe floor.

Note, this runs with the udev auto connect rule running in the background which
injects a lot of additional noise to the test. For example blktests will warn
about 'device not removed', which is correct but this device was not created by
the test, it was created by the udev rule. nvme/003 fails because it disconnects
two devices instead the exptected one.

These are things we have to address in blktests though. So hopefully with these
patches we are getting close to run blktests on a regular basis.

changes:
v4:
 - dropped patches which got applied
 - dropped 'nvmet-fc: free hostport after release reference to tgtport'
 - reworked commit message of 'nvmet-fc: untangle cross refcounting objects'
   and renamed it to 'nvmet-fc: defer cleanup using RCU properly'
 - added 'nvmet-fcloop: swap the list_add_tail arguments'
   and 'nvmet-fc: use RCU list iterator for assoc_list'
 - added RBs
 
v3:
 - collected all patches into one series
 - updated ref counting in nvmet-fc

v2:
  - added RBs
  - added new patches
  - https://lore.kernel.org/linux-nvme/20230620133711.22840-1-dwagner@suse.de/
  
v1:
  - https://lore.kernel.org/linux-nvme/20230615094356.14878-1-dwagner@suse.de/ 


*** BLURB HERE ***

Daniel Wagner (12):
  nvme-fc: do not wait in vain when unloading module
  nvmet-fcloop: swap the list_add_tail arguments
  nvmet-fc: release reference on target port
  nvmet-fc: defer cleanup using RCU properly
  nvmet-fc: free queue and assoc directly
  nvmet-fc: hold reference on hostport match
  nvmet-fc: remove null hostport pointer check
  nvmet-fc: do not tack refs on tgtports from assoc
  nvmet-fc: abort command when there is no binding
  nvmet-fc: avoid deadlock on delete association path
  nvmet-fc: take ref count on tgtport before delete assoc
  nvmet-fc: use RCU list iterator for assoc_list

 drivers/nvme/host/fc.c       |  47 ++---------
 drivers/nvme/target/fc.c     | 156 +++++++++++++++++++----------------
 drivers/nvme/target/fcloop.c |   6 +-
 3 files changed, 93 insertions(+), 116 deletions(-)

-- 
2.43.0


