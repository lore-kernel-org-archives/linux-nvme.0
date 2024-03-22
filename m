Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDF7CD11DF
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Mar 2024 15:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RpDx1t1PNzRt7JlAIOUfBWMUpNjOYXIq/Luidyv1GR0=; b=cs8iHM3Polzxc8XEqeiObByA0k
	rb10DkUWSBytoS2E76hZOwomzHcH0GAwO/OThjcXJeFnK56awYSRxxBkCR7CwQ6uLmeHAr20EuRiq
	E0R2DCYanYSDeHwjUi0sXXfn7AM23/joBqBIv08zTFmA9Kq/Kup11oy8kUYMWqJz7R6es+C2bYxJ8
	Kae9xTplcptLVPBPY8TWTHr6cI3w4N2NE+8MgkB+74C2enj9cGevhdUEALXiA7CODE5jlNbhKJLky
	XoVzT/v7NCfChHyTYD5meNbbSNaeDFXwRWOSe/VctXlHSl5U1Q5NORHC4LZJK+Bnb85VwWskmxzaw
	0oXkM5Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rngPh-00000007f5H-0vH4;
	Fri, 22 Mar 2024 15:02:33 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnfHp-00000007Pmx-3sGr
	for linux-nvme@lists.infradead.org;
	Fri, 22 Mar 2024 13:50:24 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0A51338563;
	Fri, 22 Mar 2024 13:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711115419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RpDx1t1PNzRt7JlAIOUfBWMUpNjOYXIq/Luidyv1GR0=;
	b=VcyhggSWqV9APfBT5Uz9nhEpgyy3qrYdSjTnqdDjdvfmR5qAUUQJqarcZk0vdFzE2hlcH/
	h6KvzZeuS1s0ylvh8codJGDDyKdjHlTd4w6luZUIgspX/X4fCI638el2C1X4bx/WelUtLj
	eSQXVKmqO7OC8Xyv4QG1nHd5mhWFbuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711115419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RpDx1t1PNzRt7JlAIOUfBWMUpNjOYXIq/Luidyv1GR0=;
	b=fCy1LbUzZs338gPfjRmdLzB6Gw/YiOfpxPVfNYHtCspyYGG9F1Rfar6Mbln++kkHohQWZz
	c3L3npIYyqbOo0DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711115419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RpDx1t1PNzRt7JlAIOUfBWMUpNjOYXIq/Luidyv1GR0=;
	b=VcyhggSWqV9APfBT5Uz9nhEpgyy3qrYdSjTnqdDjdvfmR5qAUUQJqarcZk0vdFzE2hlcH/
	h6KvzZeuS1s0ylvh8codJGDDyKdjHlTd4w6luZUIgspX/X4fCI638el2C1X4bx/WelUtLj
	eSQXVKmqO7OC8Xyv4QG1nHd5mhWFbuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711115419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RpDx1t1PNzRt7JlAIOUfBWMUpNjOYXIq/Luidyv1GR0=;
	b=fCy1LbUzZs338gPfjRmdLzB6Gw/YiOfpxPVfNYHtCspyYGG9F1Rfar6Mbln++kkHohQWZz
	c3L3npIYyqbOo0DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBF16136AD;
	Fri, 22 Mar 2024 13:50:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EXp7OZqM/WV3JAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 22 Mar 2024 13:50:18 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 00/18] refactoring and various cleanups/fixes
Date: Fri, 22 Mar 2024 14:49:57 +0100
Message-ID: <20240322135015.14712-1-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240322_065022_145627_219EF675 
X-CRM114-Status: GOOD (  10.26  )
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

Updated the series to include all the feedback from Shinichiro.

changes:
 v2:
  - addressed 'make check' errors
  - squashed 'nvme/rc: remove correct port from target'
    into 'nvme/rc: add nqn/uuid args to target setup/cleanup helper'
  - reordered patches
  - added 'nvme: drop default trtype argument for _nvmet_passthru_target_connect'

 v1:
   - https://lore.kernel.org/linux-nvme/20240321094727.6503-1-dwagner@suse.de/

Daniel Wagner (18):
  nvme/rc: silence error on module unload for fc
  nvme/rc: silence fcloop cleanup failures
  nvme/rc: log error if stale configuration is found
  common/xfs: propagate errors from _xfs_run_fio_verify_io
  nvme/{012,013,035}: check return value of _xfs_run_fio_verify_io
  nvme/rc: use long command line option for nvme
  nvme/{014,015,018,019,020,023,024,026,045,046}: use long command line
    option for nvme
  nvme/rc: connect subsys only support long options
  nvme/rc: add nqn/uuid args to target setup/cleanup helper
  nvme/rc: remove unused connect options
  nvme/rc: do not cleanup external managed loop device
  nvme/031: do not open code target setup/cleanup
  nvme: drop default trtype argument for _nvmet_connect_subsys
  nvme: drop default trtype argument for _nvmet_passthru_target_connect
  nvme: drop default subsysnqn argument from
    _nvme_{connect|disconnect}_subsys
  nvme/{041,042,043,044,045,048}: do not pass default host{nqn|id} to
    _nvme_connect_subsys
  nvme: don't assume namespace id
  nvme/028: drop unused nvmedev

 common/xfs     |   9 ++-
 tests/nvme/003 |   4 +-
 tests/nvme/004 |   5 +-
 tests/nvme/005 |   2 +-
 tests/nvme/008 |   4 +-
 tests/nvme/009 |   4 +-
 tests/nvme/010 |  11 ++--
 tests/nvme/011 |  11 ++--
 tests/nvme/012 |  13 ++--
 tests/nvme/013 |  13 ++--
 tests/nvme/014 |  17 +++--
 tests/nvme/015 |  17 +++--
 tests/nvme/018 |  20 +++---
 tests/nvme/019 |  13 ++--
 tests/nvme/020 |  12 ++--
 tests/nvme/021 |  11 ++--
 tests/nvme/022 |   4 +-
 tests/nvme/023 |  11 ++--
 tests/nvme/024 |  12 ++--
 tests/nvme/025 |  11 ++--
 tests/nvme/026 |  11 ++--
 tests/nvme/027 |   4 +-
 tests/nvme/028 |   9 +--
 tests/nvme/029 |  11 ++--
 tests/nvme/031 |  16 ++---
 tests/nvme/033 |   2 +-
 tests/nvme/034 |   2 +-
 tests/nvme/035 |   6 +-
 tests/nvme/036 |   2 +-
 tests/nvme/037 |   3 +-
 tests/nvme/040 |   6 +-
 tests/nvme/041 |  13 ++--
 tests/nvme/042 |  14 ++--
 tests/nvme/043 |  14 ++--
 tests/nvme/044 |  28 +++-----
 tests/nvme/045 |  17 ++---
 tests/nvme/046 |   7 +-
 tests/nvme/047 |  16 ++---
 tests/nvme/048 |   9 +--
 tests/nvme/rc  | 175 ++++++++++++++++++++++++++++++++-----------------
 40 files changed, 292 insertions(+), 277 deletions(-)

-- 
2.44.0


