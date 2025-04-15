Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD0BC369AB
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 09:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5EX3FsjI+r4MtuJi3JOMf2VXqEh6sgsd7WB5NDwN5fA=; b=PFMSYvzU6P5yMHq/7SOdqznAwL
	Qb4Iflsz6jsQPOcQvDY2FLNYQ6hftZ2Eyngg1iwShburVNzuiPPK6E5Hp1cr/yDF8eWQVG8wvlHgx
	IA7m6WWCUZaZwJvD6uUkyldKFZk7ipNY25PzhCw0awrJT2gCD7dHnHz9fPOGQqMWxcJFSH6n1Husm
	0rSRFv9Q1Y/yn82YtNAfAwgYYSE0O8JfXOMEqAck3RwXKEzqr2VqYhJtO40BjJVMBndFBu8Ne4+CQ
	TnIHcJnZEtRwdsEMgKGM3TTV7iYejjJ+y3x9rV8fO6soNwDYzEGiGk6vPtTWtSANeE75BbUbNpYiN
	34uGDiXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4cAV-000000055QB-1AyA;
	Tue, 15 Apr 2025 09:01:23 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4cAS-000000055PQ-14hU
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 09:01:21 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F346E21171;
	Tue, 15 Apr 2025 09:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744707677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5EX3FsjI+r4MtuJi3JOMf2VXqEh6sgsd7WB5NDwN5fA=;
	b=bFv6WReYNYNQIp5uhrUiZDX/nrvg4nksg6J6bONHjxNR4Uxmti7/LlzGk1gmPfmv5gewJ3
	4pYwAEYyZUx53gds+39XMaLOi2qy56bdpG65K9zumnWzJLXwopVSCnaXRf53HEhII78qaB
	JbD09S1p73OUB9uiykL1lz7TM0tZKQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744707677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5EX3FsjI+r4MtuJi3JOMf2VXqEh6sgsd7WB5NDwN5fA=;
	b=dPLdd55A+IzIT8KGv06eKS9qNSWqGCg+q/xilO++NclgJcyIYv0SOTqm7FxbU+7iz1v1zj
	l01UKiStVgyAitCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rRHYzcrJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xWnps56z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744707676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5EX3FsjI+r4MtuJi3JOMf2VXqEh6sgsd7WB5NDwN5fA=;
	b=rRHYzcrJwkHbLl16DRhuJA1yBxTorbmix0DZrYVhiyZmR9eMImmkdpBwzZBVox+1JaNZEG
	JFgtzQt1L7cFzzuQsino+z+CjsGN5R7lwKiXGVKDIUjVUmIrojZKxuINPlWQqb/XeeoChB
	bo8s/NUXjnwOGCauw1RF4XroJZ/oooM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744707676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5EX3FsjI+r4MtuJi3JOMf2VXqEh6sgsd7WB5NDwN5fA=;
	b=xWnps56zugepFKPT6s+Ho2ve3SUR1wraDrr/vuitr9JvU2m6sDxgHffgkxr4Iba9pq1dLb
	6B8GIntmmiVjuRDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4199137A5;
	Tue, 15 Apr 2025 09:01:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Soq6Nlwg/mdfTwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 15 Apr 2025 09:01:16 +0000
Date: Tue, 15 Apr 2025 11:01:08 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	bluca@debian.org, Caleb Sander Mateos <csander@purestorage.com>, 
	Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: nvme-cli connect regression
Message-ID: <066cb0d9-95b1-49ac-92b4-43a212d0a7fa@flourine.local>
References: <b0904029-2ffd-4ea9-a8b7-bf7d4182ea29@flourine.local>
 <6b081163-2b00-4de9-85c1-7bc72909f90c@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b081163-2b00-4de9-85c1-7bc72909f90c@grimberg.me>
X-Rspamd-Queue-Id: F346E21171
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_020120_445193_4FA68D2E 
X-CRM114-Status: UNSURE (   9.17  )
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

On Mon, Apr 14, 2025 at 01:29:42AM +0300, Sagi Grimberg wrote:
> Was this resolved?

I've added a retry loop in libnvme when the write to /dev/nvme-fabrics
returns EINTR. It takes a few days until the newly version hits the test
frameworks and we know for sure that is handled.

> Couldn't follow where the issue was - kernel/userspace?

  [ 10.397892] nvme_tcp: queue 0: failed to receive icresp, error -4

Stable kernels started to return EINTR and one change which touches
this area is:

  578539e09690 ("nvme-tcp: fix connect failure on receiving partial ICResp PDU")

Unfortunately, it's not easy for Luca to build a test kernel. If we
provide one for his distro, he would be willing to tests.

