Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08052CD1284
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ELeYmpZSqSBqztt4rYwLki4oPTWM6rd/sK49O5iGwsk=; b=EZyBIxEnmt8zXtH7txGbTqX1SM
	m7lfOZqylancTc3YZH0Jz+hUQXvbOgL1nZFbJMzwsBy+tWQPPneb5Lu9fRjORRJxtX1a27+9xrmNK
	CVC0zCT0dgr4etRJufFZ/k4W+7tlaMGhsTenJKvKdqOC4eAw0f6UmOKQHwvCO09JBM64Gj2mTQ4Qc
	LIggaJBHNRDa1eFLP/2H90jz4rnx+WHSguKxDqVrNFUWn5vNHBWZxYifv+t8wlLdLtMqRWmQuj+6h
	nbIY9XpApMwVG3EsBFq2BLEF8p91Vn4bLhyVUBq+zwwZFLbRc7PWfdqad+0N4VU9S/J+m4GgOEq0b
	ZVzolybQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsPMi-00000003KAF-3ySx;
	Thu, 04 Apr 2024 15:51:00 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsPMY-00000003K7G-2ErK
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 15:50:54 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 40FBD37D06;
	Thu,  4 Apr 2024 15:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712245848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ELeYmpZSqSBqztt4rYwLki4oPTWM6rd/sK49O5iGwsk=;
	b=axyLZBFS2JIHKKcD4c/MGuJb+N0h9T8iAfdrzuxUrF5fn84pP1IdinZDyVZeOexr312G0E
	0vemBLyROQsAf7h1SO8R1NZGZ1oWloNUHlMeAnCvJwGIrIw8zw7llfqhHZwFY2YGGl10UV
	sO6Qj9hntbllR/6pBugr4/sX3czGRIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712245848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ELeYmpZSqSBqztt4rYwLki4oPTWM6rd/sK49O5iGwsk=;
	b=fni6zS40K6AsJYihBWp8sga7YHBUgRYNavy/pHbWc8vXmMdgXlrALBExej33pm67HkfIW3
	kLjao9og39I9DoBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zvJxnq5h;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ubp8xBGp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712245847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ELeYmpZSqSBqztt4rYwLki4oPTWM6rd/sK49O5iGwsk=;
	b=zvJxnq5hSZaXmyXD5esjgGgogBjAQ4SHsaG6Pgo3suV66dB/YilFj+4OCoePp3W2t0uUWP
	Xkc5kBZobJW+vVDBp5NJLEYnXgbfq8TVfJeE5sckQNUEynrJD3FDnDx0z23IyvNGtheAYP
	3zgSuZEY5XBZ2cuTwGJlXanBD1DUOy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712245847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ELeYmpZSqSBqztt4rYwLki4oPTWM6rd/sK49O5iGwsk=;
	b=ubp8xBGpeAZVgP02pfo1ISowLOzkJn8VJ+Ko4bOtxo56CRdyXbbOYwDFKUfigCbKCh2qdv
	xBuYmF51dAI0xMAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F84513298;
	Thu,  4 Apr 2024 15:50:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id /4cTC1fMDmbEIwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 04 Apr 2024 15:50:47 +0000
Date: Thu, 4 Apr 2024 17:50:46 +0200
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] nvme-fabrics: short-circuit connect retries
Message-ID: <vqywie3ud6pxvfjtvks2smhy37qvtexikh56syu63c33gxw5pc@myqmkna3fhq2>
References: <20240404154500.2101-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404154500.2101-1-dwagner@suse.de>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 40FBD37D06
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_085050_770315_0FBE1CA5 
X-CRM114-Status: UNSURE (   9.33  )
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

On Thu, Apr 04, 2024 at 05:44:55PM +0200, Daniel Wagner wrote:
> changes:
> v4:
>   - rebased
>   - added 'nvme: fixes for authentication errors' series
>     https://lore.kernel.org/linux-nvme/20240301112823.132570-1-hare@kernel.org/

Please ignore v4 for now. I've forgot to update 'nvme: fixes for
authentication errors' series.

