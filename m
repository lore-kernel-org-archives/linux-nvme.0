Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9566DC27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 11:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HPrEsNhrIiTbmPWriUWwjbFXqL/xJ8ZfeQ6NuIj/pgg=; b=eLX+YomTGZu5jJYX67NkXejFBV
	bKAgJIbwaXf6hkgeyHvGrZcplgGuU9/dS7cUxAO0XOYkeo5dGISoSbD6u/xI9GCAd6TB9sCC4d4re
	RGJgKd27D/uH5xsWHhvvD5q2ErcqF78/b9gMOlOlqBGY9I581TqTBDWg7YAAJqudA+MEzDTm1iHXu
	fACrTUfjflV71w7xEvTCM783qrqeba3f3QK9Nn9als/7g1alPecoQIXHnd1ECq/i/p5qXd/T+BKJN
	gaY34X2dni5QwKgmYGP/KhXIpOLxAU9yMPPMTyEtPmlOhYtX+HNYVOJH2zW6nAj1MQq7F0ov3xzGq
	/kxIZIEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHLmi-0000000CNb8-2q10;
	Wed, 12 Jun 2024 11:04:56 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHLmd-0000000CNZD-1mD0
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 11:04:54 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5CF59342A9;
	Wed, 12 Jun 2024 11:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718190289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HPrEsNhrIiTbmPWriUWwjbFXqL/xJ8ZfeQ6NuIj/pgg=;
	b=tJV/q19IKZjeyKh7poBV0R6j6pE+7GUWcHhyI/VELSRtyoThc9sol+RdQpzJx2mFehlYl2
	DzXYvHa53w2YIi7Si/c4Pa1FoEvR81bbBMu2Y2TO0TqsIdTXPGGWRJIpaan6TZGcHJftOq
	eXf+tAc49FKwLGg4W6batHpsMSTAxiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718190289;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HPrEsNhrIiTbmPWriUWwjbFXqL/xJ8ZfeQ6NuIj/pgg=;
	b=MypfmEtic9X9ey2isuqKZobK7QyBIJbHnMN4sPmrJaR/1zSj1nShPdGkvi/oRCEyo/Qrzo
	ixoBm/+qJdQ5SjDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ukzd8zMl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VvGc9K05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718190288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HPrEsNhrIiTbmPWriUWwjbFXqL/xJ8ZfeQ6NuIj/pgg=;
	b=Ukzd8zMlA6aoR1BCKymMmbOlPYabb4TJMb20ul9vgZ3+Ma8sRbU2wgBk4lzzn5F6Cy39F3
	48zuv2KIZH9csmqPnCmKOeNHGxqGKse4jKwr7Y8zz/nFvZ7GrFBJaqnuwOPVltNEBW4n7V
	MRRpyrAkViAC8ikIaBGZ9G84q8yfphE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718190288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HPrEsNhrIiTbmPWriUWwjbFXqL/xJ8ZfeQ6NuIj/pgg=;
	b=VvGc9K05OdkRqu/q6DrUgHZg8qhSHvNiMO9XbGNC6F7DtN+tqda3e63pZBt3J8S/L+KI0o
	WW+VZVe15XXD9tAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51697137DF;
	Wed, 12 Jun 2024 11:04:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0QbXE9CAaWaUDQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 12 Jun 2024 11:04:48 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC blktests v2 00/03] Add support to run against real target
Date: Wed, 12 Jun 2024 13:04:41 +0200
Message-ID: <20240612110444.4507-1-dwagner@suse.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.40 / 50.00];
	BAYES_HAM(-1.39)[90.83%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5CF59342A9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_040451_640594_5F6ABA7E 
X-CRM114-Status: GOOD (  14.91  )
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

I've updated this series and added a simple example how to use it. I didn't
really know where to put it, so I added this part to new directorty called
'contrib'.

Don't know if we want to keep adding environment variables for this or if it
would be simpler to pass in a configuration file. The environemnt variable are
fairly simple to handle and it works. Adding a configuraiton file adds more code
to blktests.

changes:
v2:
  - many of the preperation patches have been merged, drop them
  - added a python script which implements the blktests API
  - add some documentation how to use it
  - changed the casing of the environment variables to upper case

v1:
  - initial version
  - https://lore.kernel.org/linux-nvme/20240318093856.22307-1-dwagner@suse.de/
  


Daniel Wagner (3):
  nvme/rc: introduce remote target support
  nvme/030: only run against kernel soft target
  contrib: add remote target setup/cleanup script

 Documentation/running-tests.md |   9 +++
 contrib/nvme_target_control.py | 110 +++++++++++++++++++++++++++++++++
 contrib/nvmet-subsys.jinja2    |  71 +++++++++++++++++++++
 tests/nvme/030                 |   1 +
 tests/nvme/rc                  |  56 +++++++++++++++--
 5 files changed, 243 insertions(+), 4 deletions(-)
 create mode 100755 contrib/nvme_target_control.py
 create mode 100644 contrib/nvmet-subsys.jinja2

-- 
2.45.2


