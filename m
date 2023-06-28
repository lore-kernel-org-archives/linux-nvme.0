Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBB3EB64D7
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jun 2023 15:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zv6B/Q4RjEXb57EGS3C2zPEi9FvspmBPaHYAN25eDeI=; b=g5AufEBEJW6OdjDq6AE/FY7/wD
	yGC3zOjzo3BDFGwTZ0wSDiOVSfpw9T7hFRUvpRbyYZXZsY7CE0yIUQsfljFcMQWwk2xiBVQiwaVd6
	knH+/KZb/0SPDBJby3/pZYDqDCuBJ/PDUbR8FVU8yH/pu3LfYqWzvRYYPAocvu+7Gmj1QymjPKzjA
	z46196gOEgnQLMuJ+gJ69Q0DsjP99k+y4XRQSYG94KBa4xd7+wHpiT5/g8EA7nBa3JzT4kMSDbU/v
	oH6+4ktfaB6lFjRaG9g+fyK9XDt/eUsPH3MVO4eCM0Lg1ruQtSdAax+ZeRgGtJ5UFL0JC150XPDHf
	UniZTtxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEWuF-00Fwwo-2K;
	Wed, 28 Jun 2023 15:16:31 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEWuB-00Fwuf-2o
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jun 2023 15:16:29 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 88A8F2185C;
	Wed, 28 Jun 2023 15:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1687965385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zv6B/Q4RjEXb57EGS3C2zPEi9FvspmBPaHYAN25eDeI=;
	b=rTdOIKrniP8M0nfVB6GfSGoo97mEymqi5OwLhCzFUnqbeSxTqQLamoMddRALP6vwvQ9305
	Za6BG7YnKYOMcv29J3ndKB4GvyyVlWlYYUsO4vKZqUIl3QNogyqP6dMCulX8NcFZniiMsw
	6rfcmxPvcocd0uivgRUX03b10tSJGLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687965385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zv6B/Q4RjEXb57EGS3C2zPEi9FvspmBPaHYAN25eDeI=;
	b=Qed9wGMKuxajgT9cX6h+1A1kvviTydJNDv/uHApQnUQTBZ7+nTHSbyvWiYHrVFplzH3O0e
	wRNTMW4OQ5HuGeCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B463138E8;
	Wed, 28 Jun 2023 15:16:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id iZwUHslOnGQuOQAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 28 Jun 2023 15:16:25 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <jsmart2021@gmail.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 0/3] More fixes for FC enabling
Date: Wed, 28 Jun 2023 17:16:20 +0200
Message-ID: <20230628151623.11340-1-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_081628_070965_D69577A0 
X-CRM114-Status: UNSURE (   9.02  )
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

I (think) address all the feedback I got from Sagi and Shinichiro except one.
The _have_nvme_cli_context() (previously _nvme_cli_support_context()) function
is still there. I didn't find any other good way to achieve this and I found in
blktests another function doing the same: _have_fio_zbd_zonemode().

Daniel

changes:
v2:
  - nvme/048:
    - untaggle waiting for state change and queue count check
    - make all variables local
    - compare numbers not strings
  - nvme/rc:
    - rename _nvme_cli_supports_context to _have_nvme_cli_context
    - only add --context for fc
    - reordered setup/cleanup
  - nvme/{041,042,043,044,045,048}:
    - move all changes related to this patch
v1:
  - https://lore.kernel.org/linux-nvme/20230620132703.20648-1-dwagner@suse.de/

Daniel Wagner (3):
  nvme/048: Check for queue count check directly
  nvme/rc: Avoid triggering host nvme-cli autoconnect
  nvme/{041,042,043,044,045,048}: Use default hostnqn and hostid

 tests/nvme/041 |  8 ++---
 tests/nvme/042 |  8 ++---
 tests/nvme/043 |  8 ++---
 tests/nvme/044 |  8 ++---
 tests/nvme/045 |  8 ++---
 tests/nvme/048 | 32 +++++++++++++-------
 tests/nvme/rc  | 81 +++++++++++++++++++++++++++++++++++++++++++-------
 7 files changed, 103 insertions(+), 50 deletions(-)

-- 
2.41.0


