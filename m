Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE30C54E55
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 08:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PyH7PV9Y+HU6YteN7n/jOhE0Tv1Rk9CDVFNqMbqJmnM=; b=11h8zoad3NfO/ui3GtYLNfIupG
	lE2+sBGrxxu4iOM/KRWv8MgdkfeIq91W5ORg9PAXkchsPnSWMQOEd5AhDBX8XhqUXzSZ9qTfP6xqe
	v4HKScs3hbNphNBUbFiQu3uAUdG7nbcdcOCk2dYq5Fz9EQXeReANFqs6MLKk0Ju1Nv+aU1aFPh1fB
	AHz81aRJpFKDA/cJuCBS61ZBoyD/CsSgExbC3f/pMYyrDMJJlCLOBjuKot0b0nQf20VZo1NoP+0dK
	K5jNbXJlNmXsMv7l8RO/rVH6jKsI0YKK6QylgZA2F8zQ5nWFB1yIEPEii7KP30ABOXMRHQEiXE58F
	zrEtv1sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhPik-0000000CUS5-2KLf;
	Tue, 05 Mar 2024 08:00:18 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhPic-0000000CUOw-496Y
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 08:00:16 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 68A233F43B;
	Tue,  5 Mar 2024 08:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709625609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PyH7PV9Y+HU6YteN7n/jOhE0Tv1Rk9CDVFNqMbqJmnM=;
	b=ErCAgTyZpz4FpeJ3QMYYYx3CgqYSjF8Y20d61DWBcnYOwIYQylS4UFWDsrKF6q0Y+Df+qU
	pso82TAmA3c2DM8lxanaxAxHhlrNa1B+LYdHDNiB88hIAwFgCXfN+gje7gPSajfY7WmlMC
	l3JlGkafoNZ75IZF3jZ7mLCnwPLfGKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709625609;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PyH7PV9Y+HU6YteN7n/jOhE0Tv1Rk9CDVFNqMbqJmnM=;
	b=ydUnvDrlzBbBfLyN+NLQ3muK0ZhGfLQgNscsYM11TtqubEV12eQxWA7EgKOFCPBLzEIPUL
	TI/97O0P9yginIAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709625609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PyH7PV9Y+HU6YteN7n/jOhE0Tv1Rk9CDVFNqMbqJmnM=;
	b=ErCAgTyZpz4FpeJ3QMYYYx3CgqYSjF8Y20d61DWBcnYOwIYQylS4UFWDsrKF6q0Y+Df+qU
	pso82TAmA3c2DM8lxanaxAxHhlrNa1B+LYdHDNiB88hIAwFgCXfN+gje7gPSajfY7WmlMC
	l3JlGkafoNZ75IZF3jZ7mLCnwPLfGKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709625609;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PyH7PV9Y+HU6YteN7n/jOhE0Tv1Rk9CDVFNqMbqJmnM=;
	b=ydUnvDrlzBbBfLyN+NLQ3muK0ZhGfLQgNscsYM11TtqubEV12eQxWA7EgKOFCPBLzEIPUL
	TI/97O0P9yginIAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E8CC13A5D;
	Tue,  5 Mar 2024 08:00:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 1ROaEgnR5mW1UQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 05 Mar 2024 08:00:09 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 0/2] nvme-fabrics: short-circuit connect retries 
Date: Tue,  5 Mar 2024 09:00:03 +0100
Message-ID: <20240305080005.3638-1-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [2.81 / 50.00];
	 ARC_NA(0.00)[];
	 SUBJECT_ENDS_SPACES(0.50)[];
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
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.39)[90.79%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_000011_325139_5F73556A 
X-CRM114-Status: UNSURE (   9.82  )
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

I've picked up Hannes' DNR patches. In short the make the transports behave the
same way when the DNR bit set on a re-connect attempt. We had a discussion this
topic in the past and if I got this right we all agreed is that the host should
honor the DNR bit on a connect attempt [1]

The nvme/045 test case (authentication tests) in blktests is a good test case
for this after extending it slightly. TCP and RDMA try to reconnect with an
invalid key over and over again, while loop and FC stop after the first fail.

[1] https://lore.kernel.org/linux-nvme/20220927143157.3659-1-dwagner@suse.de/

changes:
v3:
  - added my SOB tag
  - fixed indention

v2:
  - refresh/rebase on current head
  - extended blktests (nvme/045) to cover this case
    (see separate post)
  - https://lore.kernel.org/linux-nvme/20240304161006.19328-1-dwagner@suse.de/
  
v1:
  - initial version
  - https://lore.kernel.org/linux-nvme/20210623143250.82445-1-hare@suse.de/

Hannes Reinecke (2):
  nvme-tcp: short-circuit reconnect retries
  nvme-rdma: short-circuit reconnect retries

 drivers/nvme/host/rdma.c | 22 +++++++++++++++-------
 drivers/nvme/host/tcp.c  | 23 +++++++++++++++--------
 2 files changed, 30 insertions(+), 15 deletions(-)

-- 
2.44.0


