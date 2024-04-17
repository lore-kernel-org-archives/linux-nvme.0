Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDACC4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Apr 2024 08:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Xz5CD1HvzqnifI1MFHqnaz4hvKyBfZ1p1ZNtdHMkBrk=; b=IA/Qb4kNWYQbDU7y8+ytWnTmf1
	ZLCObMBYRBGKG1eqSNcMIJK3Ldw193drPN45DiatyZKY/25UcGG1ZZVQvQwdfO+TIjPuTKisL6y2a
	z939QTG3C2TYn+IIs6bsnSxRiB0118wUFuCEdNRrVUjul3l/PnaOolf+EBygE7A08XxgF9xrXB8tm
	FKI6CZ+NKRBwghHtpwIPB8qMrk+EveydGiuNf7xawJ0Ajw/GAhskXL3JdqPXxN6a9iNicTDTBwZjy
	u5aqN4UE9QQm7oyxPKKViMqD7SqHYfNCaJ6mODjfvhUnXIMrUXPUKEfRlH06ZQ1A8Zn+MtuyUAzhj
	hSDs6mKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx0jN-0000000FEY4-2SxR;
	Wed, 17 Apr 2024 08:33:25 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx0jI-0000000FEWC-1cJT
	for linux-nvme@lists.infradead.org;
	Wed, 17 Apr 2024 08:33:24 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EFF7C339E7;
	Wed, 17 Apr 2024 08:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713342798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Xz5CD1HvzqnifI1MFHqnaz4hvKyBfZ1p1ZNtdHMkBrk=;
	b=xzCzPwjMqbUagqWt6VHqCxSi/V5TZbvCt+yr3eeT4Tya0sWf3UHcKX+EMQJiHviE7XuNXZ
	cGHCCj1KjV3Idf1nDSCi32AJCSAj/XJZp64OJOcOjKdQdfY1PI4VLgzPeJhxKvOcvcRBs+
	AaHXu1k8Yz1EzP4vk1y6tGqvbYAYdSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713342798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Xz5CD1HvzqnifI1MFHqnaz4hvKyBfZ1p1ZNtdHMkBrk=;
	b=OBnjyVXxuGNpG11DrtwyYrGqSheco8ppKEvwUTAVk0CpNmVPDXiRNf4pE9KEs8c82J0J7/
	0/jAEj47GxDDZdCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RtZoG4fc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yP08TYnb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713342797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Xz5CD1HvzqnifI1MFHqnaz4hvKyBfZ1p1ZNtdHMkBrk=;
	b=RtZoG4fcwSJN5DVZom3o+St6ohILjO1Ah7xpvaCcHCd6dLdINvjCJexU0WNBgBigWzAwU0
	w9bI4i06bsrZQFwAXBxeMCMUo0tJ1gutVK56MFUXAnjeQ76C579yKKz5sVd/mPTvoI34S0
	9mnhJj9hl/i9zGy+JpMm/YFOybmHSZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713342797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Xz5CD1HvzqnifI1MFHqnaz4hvKyBfZ1p1ZNtdHMkBrk=;
	b=yP08TYnbbjjAbzN4aSwLdU1lJkMLYSoqvIPsAN4qnv4mbZQaA/UBncCO5WYr4pG+zWeVGw
	sWBqisWPSNJk0fAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC6B81384C;
	Wed, 17 Apr 2024 08:33:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0FBwNE2JH2aEQwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 17 Apr 2024 08:33:17 +0000
Date: Wed, 17 Apr 2024 10:33:17 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
	Tomasz Zawadzki <tomasz.zawadzki@intel.com>, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: nvme-cli spdk plugin
Message-ID: <xulnfwru3jfl2nooq27yym7nx3cdpxqslzqz5nvwnkymncapnt@pzascju2tmvf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-1.94 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.93)[86.35%];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EFF7C339E7
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240417_013320_606163_D4D567A1 
X-CRM114-Status: UNSURE (   9.95  )
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

There is a PR [1] pending, adding a spdk plugin for nvme-cli. The
problem this new plugin tries to solve is, that with the recent change
to use sysfs only for discovering the nvme subystem, nvme-cli
lost support for spdk.

My question is, should we have a special plugin for 'list' and
'list-subsystem' or should we try to get this somehow integrated into
the existing code? So that 'list' just works?

Obviously, it would be nice if we could discover the spdk devices via
sysfs.

Thoughts?

https://github.com/linux-nvme/nvme-cli/pull/2295

