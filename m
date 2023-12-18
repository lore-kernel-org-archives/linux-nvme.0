Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D77AC35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 15:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=njLtLC3itym9NrsTnjVi0xLEc93Pwe0Q5O8AXSr4XSM=; b=E+idDvW8+P7NZ3w96NXKbqxgqI
	OkIIfS+H+7nOzrI5nV6mjYFQHdAlQZ3lajoX5oWAcDaxwB8tGJMnROBtoPcVG/HXU3pTxpvIM7qbB
	fqhdVhxzQ7P19wJqn8GzmFsv8XenaM2UPKnZx5pujt2EzgRem7YRbYlWtGIs2giJlaE8aA8+T1tA+
	Z8Jqf+oWUelDJvsDkDZcIYOoUisH4MZX5kQUMYBJ1MF9RGBTPTnvN7d7IeicdY1+3+qmvZjJ4p3tf
	PGv8EIyv9Ks97oG4KVWckCa+nrDgE+C/nP93coOurhsIk0OYPZx8ubzg6HKoGDLvM6OKHbAPtpDiE
	FH/p309Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFFch-00BDqL-0f;
	Mon, 18 Dec 2023 15:33:39 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFFce-00BDpL-1G
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 15:33:38 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 62ADF21F8C;
	Mon, 18 Dec 2023 15:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702913614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=njLtLC3itym9NrsTnjVi0xLEc93Pwe0Q5O8AXSr4XSM=;
	b=AUFeoXIO1HdHPLnHu4g7wm4ibAq19ZvIzhAZDtj9G4QuAA8r9yNxi3rpcj2EvHp+lwV8YS
	iRFxT8c+Y7nH7Z2AAwr6kOqcFYl0o/WR5R9tPANiMMtMCI2B45mPLN9IT+sskp29OJzhXY
	eDEoBZyg6GXgV/ayRwhbeGOnpSzZbok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702913614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=njLtLC3itym9NrsTnjVi0xLEc93Pwe0Q5O8AXSr4XSM=;
	b=/moo3VJ6kR7me9WED5q1w9xpkYI6qcxDve4Sx4CJ4vKP1ezwjdxVt8siVzFkeqt7DJhBeU
	IxFDXoRgRsaMSiAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702913614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=njLtLC3itym9NrsTnjVi0xLEc93Pwe0Q5O8AXSr4XSM=;
	b=AUFeoXIO1HdHPLnHu4g7wm4ibAq19ZvIzhAZDtj9G4QuAA8r9yNxi3rpcj2EvHp+lwV8YS
	iRFxT8c+Y7nH7Z2AAwr6kOqcFYl0o/WR5R9tPANiMMtMCI2B45mPLN9IT+sskp29OJzhXY
	eDEoBZyg6GXgV/ayRwhbeGOnpSzZbok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702913614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=njLtLC3itym9NrsTnjVi0xLEc93Pwe0Q5O8AXSr4XSM=;
	b=/moo3VJ6kR7me9WED5q1w9xpkYI6qcxDve4Sx4CJ4vKP1ezwjdxVt8siVzFkeqt7DJhBeU
	IxFDXoRgRsaMSiAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5240513BC8;
	Mon, 18 Dec 2023 15:33:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id vs5aE05mgGW7fAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 18 Dec 2023 15:33:34 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 00/17] enable nvmet-fc for blktests
Date: Mon, 18 Dec 2023 16:30:48 +0100
Message-ID: <20231218153105.12717-1-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.71 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.926];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_073336_603573_BE7A922C 
X-CRM114-Status: GOOD (  14.58  )
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

Another update on getting nvmet-fc ready for blktests. The main change here is
that I tried make sense of the ref count taking in nvmet-fc. When running
blktests with the auto connect udev rule activated the additional connect
attempt etc made nvmet-fc explode and choke everywhere. After a lot of poking
and pondering I decided to change the rules who the ref counts are taken for the
ctrl, association, target port and host port. This made a big difference and I
am able to get blktests pass the tests.

Also KASAN was reporting a lot of UAFs. There are still some problems left as I
can still observe hangers when running blktests in a loop for a while. But it
doesn't explode immediately so I consider this a win.

Apropos KASAN, it still reports the problem from [1], so anyone who want to run
this series needs to revert ee6fdc5055e9 ("nvme-fc: fix race between error
recovery and creating association").

The first four patches are independent of the rest and could go in sooner.

[1] https://lore.kernel.org/linux-nvme/hkhl56n665uvc6t5d6h3wtx7utkcorw4xlwi7d2t2bnonavhe6@xaan6pu43ap6/

changes:
v3:
 - collected all patches into one series
 - updated ref counting in nvmet-fc

v2:
  - added RBs
  - added new patches
  - https://lore.kernel.org/linux-nvme/20230620133711.22840-1-dwagner@suse.de/
  
v1:
  - https://lore.kernel.org/linux-nvme/20230615094356.14878-1-dwagner@suse.de/ 


Daniel Wagner (16):
  nvmet: report ioccsz and iorcsz for disc ctrl
  nvmet-fc: remove unnecessary bracket
  nvmet-trace: avoid dereferencing pointer too early
  nvmet-trace: null terminate device name string correctly
  nvmet-fcloop: Remove remote port from list when unlinking
  nvme-fc: Do not wait in vain when unloading module
  nvmet-fc: Release reference on target port
  nvmet-fc: untangle cross refcounting objects
  nvmet-fc: free queue and assoc directly
  nvmet-fc: hold reference on hostport match
  nvmet-fc: remove null hostport pointer check
  nvmet-fc: do not tack refs on tgtports from assoc
  nvmet-fc: abort command if when there is binding
  nvmet-fc: free hostport after release reference to tgtport
  nvmet-fc: avoid deadlock on delete association path
  nvmet-fc: take ref count on tgtport before delete assoc

 drivers/nvme/host/fc.c          |  20 +++--
 drivers/nvme/target/discovery.c |  13 +++
 drivers/nvme/target/fc.c        | 153 ++++++++++++++++++--------------
 drivers/nvme/target/fcloop.c    |   7 +-
 drivers/nvme/target/trace.c     |   6 +-
 drivers/nvme/target/trace.h     |  33 ++++---
 6 files changed, 135 insertions(+), 97 deletions(-)

-- 
2.43.0


