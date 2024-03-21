Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823E3CD11DB
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 09:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kKA51qgyv6QF5Yf1pHjBEQQT4fuXgc6nnR2Y7Rj9gkA=; b=S0ndgaAiyBrSnixzumZGXRlM1w
	HwY0CM74W157+OenLohiTvAC1za5YsjGwvixliML+Z4te7WQzSAlxslP3fJTlsanui/DVqchit9rm
	/+tPW1DZizsaHH2hU5h+3ZpdTP9veuc0/71g5OskTM9K3lvceuhxCrzVpWo3aV0aYiJSNJaSbIj/6
	Q88O4FmfVTBCTzCLK2DT32pHLMcfjZlvpoasGiQx7zz1IpkFiJj3D3aQt3b9HtCwxThfLiZKQqK42
	GKhNQwJBMfoDF3d9SmIABDfvQx+JzgBfYIrxuVQlW0cNCXPFsK75bGeKzzgoIdOIMtijiY+oWByql
	NRejCH7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnF1S-00000002Wm2-0kMs;
	Thu, 21 Mar 2024 09:47:42 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnF1K-00000002Wi4-2D9C
	for linux-nvme@lists.infradead.org;
	Thu, 21 Mar 2024 09:47:39 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5856137158;
	Thu, 21 Mar 2024 09:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kKA51qgyv6QF5Yf1pHjBEQQT4fuXgc6nnR2Y7Rj9gkA=;
	b=twooA3ZkEhYqCmM0Ne86LpY0FrPjMoVH2Jz7D5Te4uWbhe06BzM1grtlhtT+ZifRDbx5z7
	HMr9ZLya2mA06w0wLP7rdib1KhdKNpo3lzlG9W0JqeNcWVFcf16wcH7ivHK7PLLVLYq28y
	dquRQT2Q3JfVZdsmE6AZqruURDaqzRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kKA51qgyv6QF5Yf1pHjBEQQT4fuXgc6nnR2Y7Rj9gkA=;
	b=fUOErFJMXOqKUfS2RX+kysNvH68cY1ECZp3hVOZDa99tupLMgKBOocahNajqeANVYvux0O
	Nu70vJm5yGuFjbAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kKA51qgyv6QF5Yf1pHjBEQQT4fuXgc6nnR2Y7Rj9gkA=;
	b=twooA3ZkEhYqCmM0Ne86LpY0FrPjMoVH2Jz7D5Te4uWbhe06BzM1grtlhtT+ZifRDbx5z7
	HMr9ZLya2mA06w0wLP7rdib1KhdKNpo3lzlG9W0JqeNcWVFcf16wcH7ivHK7PLLVLYq28y
	dquRQT2Q3JfVZdsmE6AZqruURDaqzRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kKA51qgyv6QF5Yf1pHjBEQQT4fuXgc6nnR2Y7Rj9gkA=;
	b=fUOErFJMXOqKUfS2RX+kysNvH68cY1ECZp3hVOZDa99tupLMgKBOocahNajqeANVYvux0O
	Nu70vJm5yGuFjbAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4656113976;
	Thu, 21 Mar 2024 09:47:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ijDSDzIC/GWyDwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Mar 2024 09:47:30 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 00/18] refactoring and various cleanups/fixes
Date: Thu, 21 Mar 2024 10:47:09 +0100
Message-ID: <20240321094727.6503-1-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=twooA3Zk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fUOErFJM
X-Spamd-Bar: /
X-Spamd-Result: default: False [0.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5856137158
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_024734_743970_BD556B23 
X-CRM114-Status: GOOD (  11.00  )
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

While working on two new features I collected a bunch of patches which I think
make sense to review and merge them indepenedly. And I got a few more ideas for
refactoring and cleanups. But one step after the other.

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
  nvme/rc: remove correct port from target
  nvme/031: do not open code target setup/cleanup
  nvme/{rc,031}: do not cleanup external managed loop device
  nvme: drop default trtype argument for _nvmet_connect_subsys
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
 tests/nvme/029 |  10 +--
 tests/nvme/031 |  14 ++--
 tests/nvme/035 |   4 +-
 tests/nvme/040 |   6 +-
 tests/nvme/041 |  13 ++--
 tests/nvme/042 |  14 ++--
 tests/nvme/043 |  14 ++--
 tests/nvme/044 |  28 +++-----
 tests/nvme/045 |  17 ++---
 tests/nvme/046 |   7 +-
 tests/nvme/047 |  16 ++---
 tests/nvme/048 |   9 +--
 tests/nvme/rc  | 170 +++++++++++++++++++++++++++++++++----------------
 36 files changed, 282 insertions(+), 268 deletions(-)

-- 
2.44.0


