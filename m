Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842A2C5DF86
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 11:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FUbOFNxHUTC7V8JQSoLDqtKrp+gj9YqDk+TO38MWE6I=; b=tBKIFB01pvZinUEM/bPxzV3pZO
	jYyiKwLPrFr3MsyzWPXO8LEJAEI5y0EnonazhTzD1fwI/SJktEAkV7V8HUQ7X22No/+brVGyWPZxp
	Btq09vTESRXg8oi2MfD/GxQ1RDc7bPAyid52Zzmaa7gYA2aIF3UXJlYiOZ6rN5qbTWJLIOuAfCT4j
	cfD2wpjymCCFOBWk2bp7G7/+ycORRwVZE1663LfsQfmlSqOZTN93qof4Fo4/rEF6dLAx9kh3BMlqY
	A+6kvmf2Tpo+ZVuWdHzotU/mVfUKsLJmMitXWEjrSf3OAU47ufQDYcWezvaVhljj4O5MnOsPTpSgh
	os4G/xgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwevh-00000009iMT-1sQW;
	Wed, 19 Aug 2026 11:58:01 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwevf-00000009iLx-1lSe
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 11:58:00 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0A63684AFA
	for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2026 11:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787140672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=FUbOFNxHUTC7V8JQSoLDqtKrp+gj9YqDk+TO38MWE6I=;
	b=vpD/fIERkr9dA9wLQkU1wrQzScCphDy/NbCl66vM0kztnncjTn7RKVrEvf6qC3HGWlOxfe
	gDm2guwwfgd2Zk6WYJJDXDYgVLKwNNCBJjND15MdYgxXXeP1lf3McD3T4m+uspO7HqKgPq
	FXsQ2wI/5JLJ/TzBjlL8sW+RQyx4dfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787140672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=FUbOFNxHUTC7V8JQSoLDqtKrp+gj9YqDk+TO38MWE6I=;
	b=VP4t1xzx/GafjCs2Tkwz1aPKKcvmDKp3fqaL9/e3ClJTk9ZDa32LPXxuDcpceblBcSyLlL
	S//ks8Va4xiuxIBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787140668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=FUbOFNxHUTC7V8JQSoLDqtKrp+gj9YqDk+TO38MWE6I=;
	b=t0DBx7d3YBJmgCMOqCUscsv12rwfY2AHtq7y4vEKZMBqo7T8x5FZ+VfppJnDxWdxxuy7Pj
	obf6aa9/w6UZIjOpsl7uUGL3HN+OiHRfejy9rCbuXVlnPZfXx/48EsVVgjt0QGEVTm9q8q
	EebeM01HKSy93GOgrlaaqnLaB+1nzuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787140668;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=FUbOFNxHUTC7V8JQSoLDqtKrp+gj9YqDk+TO38MWE6I=;
	b=1s7/r45G/fWJPbx2px7IYPqtNvKyASgi8fYSgVnAelGcZQ2y4V6c6V4xKTLr78nbSb2QrF
	Ip+XNDMuaGQKUcBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAE3E2F81
	for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2026 11:57:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8g+rNzuahWo8bwAAD6G6ig
	(envelope-from <dwagner@suse.de>)
	for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2026 11:57:47 +0000
Date: Wed, 19 Aug 2026 13:57:43 +0200
From: Daniel Wagner <dwagner@suse.de>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [ANNOUNCE] nvmetcli v0.9
Message-ID: <dcbb3a2f-98be-4506-9b98-45e764c78620@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-1.89 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.59)[81.62%];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-nvme@lists.infradead.org];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_045759_609080_B347B8A7 
X-CRM114-Status: GOOD (  10.30  )
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

A new release of nvmetcli v0.9 is available.

 New features
  - NVMe passthru target support

    Configure passthru targets via configshell (Nilay Shroff)
 
  - Reservation configuration support

    Persistent reservation settings can be saved/restored (Guixin Liu)

  - DHCHAP attribute persistence

    Host DHCHAP authentication values (dhchap_*) are now correctly
    saved and restored under hosts/ (Hannes Reinecke)
    
  - discovery_nqn configfs attribute

    read/modify the persistent discovery NQN (Hannes Reinecke)

  - Non-interactive command execution

    nvmetcli can now run an arbitrary shell command directly from the
    command line instead of requiring the interactive shell
    (Maurizio Lombardi)

  Build & packaging
  - Migrated from setup.py to PEP 517/518 packaging (pyproject.toml)

  - Removed the python-kmod dependency; falls back to invoking the kmod
    binary directly when kmodpy is unavailable

  - Removed use of the six compatibility package (Python 2 support fully
    dropped) (Ales Novak)

  - Added a GitHub Actions CI workflow for build/test, plus linting
    (flake8, pylint) and mypy type-checking gates

  Code quality / maintenance
  - Added type annotations across nvmet/nvmetcli

  - Converted %-style string formatting to f-strings (Ales Novak)

  - Added docstrings to modules, classes, and methods (Ales Novak)

  - Tightened exception handling (narrower except clauses, proper raise
     ... from)
     
  - Reorganized imports and kernel-module loading logic (Ales Novak)
  
  - Tests now fall back to temporary sparse files as backing devices
    when real block devices aren't available
    
Naturally, right after cutting the release, I discovered a bug in the
Makefile for running tests on Debian. The fix is already in the tree if
you need it.

Daniel

