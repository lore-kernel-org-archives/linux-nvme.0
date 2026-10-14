Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F21CC6B1A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 12:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vJ5FuPZQSLLcddc8F4+UNpgQoDesEeQ4ARu/7Faqk30=; b=joowKBDunoVQJU+m/QfuhfD4qa
	+H5ZnPmGepFXJawfsARUwy9dyBNtjvhN32o0iMfYlklyCSRaBw/XeO07SFZFi7JHHJgUTGVgRmvH9
	L5jzhJCXbpezhO8a2Hp1NyKwdye+GTHJfB+dyEhrl5+nZkxDOMXQKPYwMgRoCuNXtKtTtbZaH5zA+
	uirUM3rYnILGNYSfNq2xbWgi+rzEbgVGcUOoyMULUMd4Q6GJMDeFdPLS7Qz6JQBmHviS5adh/nHln
	yQuKKfImEQylAg3ezDPZuLKJ2W6/6wES1OUnkqWUqUZLBfwixQ/WJbLtXyOZpF/BkDIiV3GAgy8ce
	VhKqfkhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGyO7-0000000FUIn-1Bdb;
	Wed, 14 Oct 2026 12:47:19 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGyO0-0000000FUFy-3iEh
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 12:47:17 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E3A4A22157;
	Wed, 14 Oct 2026 12:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791982031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vJ5FuPZQSLLcddc8F4+UNpgQoDesEeQ4ARu/7Faqk30=;
	b=FCkPvbmxrnCXVLHKAEe9d0LZkPAk5oh+SYPUSAbIwGlaYSGZ06mz2hC8dKhxX/3xfYTrvi
	NM0BHQNrQ9D8Z3GUE9RK768AphO1Dt2johxqaMZhAA2LWtS3MVYpHAl/HO6Yf1I+ioduUz
	epA9wUUZIYrpr5Bx7v86QUDzJ2DMFBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791982031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vJ5FuPZQSLLcddc8F4+UNpgQoDesEeQ4ARu/7Faqk30=;
	b=SLFXcVyT1/X9fJQiW0xfRSwbsp2SQ4hKzKYmkuBun4OVOIc4yxyPCsUQCNz4KzHZ50rCUd
	AIRjVpSV4/IyvdBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pEPtb0KI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Zk6opYEU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791982030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vJ5FuPZQSLLcddc8F4+UNpgQoDesEeQ4ARu/7Faqk30=;
	b=pEPtb0KIQ55LFhdLlCWDsXexv44Wn3RwwfbqaLDlFGHI5NpW5GSAuk9Jt3qJjSWBNoZKVs
	c14dR6xJ5M+LnHfyYxLjWWezKxfmsvqOOAfaTTG32MCKxhxMMV3+j7NLR6cPohjcZNKSQD
	lIxgeU8cIVHIEDHMyCa/NMLijiCJp5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791982030;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vJ5FuPZQSLLcddc8F4+UNpgQoDesEeQ4ARu/7Faqk30=;
	b=Zk6opYEUHCAAlEHOM+ihvqNS5ERLsh/ZdZmd6OUgv+XZ4gIIW+mQKObazh0YQVCCSuUHvA
	XYGkKhiL+mYItnAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC6541368E;
	Wed, 14 Oct 2026 12:47:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vi5DIc55z2r9DQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 14 Oct 2026 12:47:10 +0000
Date: Wed, 14 Oct 2026 14:47:05 +0200
From: Daniel Wagner <dwagner@suse.de>
To: martin.nvme.dev@gmail.com
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Hannes Reinecke <hare@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH v2] nvme: make the DH-HMAC-CHAP secret attributes
 readable by root only
Message-ID: <c26a89df-4d19-43bb-8bb5-631a132ef6e7@flourine.local>
References: <20261014-nvme-dhchap-secret-mode-v2-1-00f153e9d8de@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-nvme-dhchap-secret-mode-v2-1-00f153e9d8de@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim]
X-Rspamd-Queue-Id: E3A4A22157
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_054715_610456_9095D634 
X-CRM114-Status: GOOD (  13.66  )
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

On Wed, Oct 14, 2026 at 08:02:57AM -0400, Martin Belanger via B4 Relay wrote:
> From: Martin Belanger <martin.nvme.dev@gmail.com>
> 
> The dhchap_secret and dhchap_ctrl_secret sysfs attributes have mode
> 0644. Their show functions return the secret, so any local user can
> read the DH-HMAC-CHAP secrets of a connected controller.
> 
> Define them with DEVICE_ATTR_ADMIN_RW(), which sets mode 0600. The
> macro takes the show and store functions from the attribute name, so
> rename them. Writing the attributes was already limited to root and is
> not changed.
> 
> Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
> Cc: stable@vger.kernel.org
> Cc: Daniel Wagner <wagi@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Martin Belanger <martin.nvme.dev@gmail.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>


