Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FF2C88E7F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2026 14:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eFz2AThlVU/v0O9zeGtcuIj7Eh7/LYzigKpAfgn/FF8=; b=0ONWCpZmksurGZ435E/6Y5MZ2V
	K02oD0+aUWvyfJlA5nAa43s9M8cA/Jxu6Mjw69tXWq3yyBGgY7Z8pbhdB0bS7gMGjp+2MabFtHI7X
	FwbrwvnB9J/vsYSZoNaMl7fpei6hbd5LyRfjf1KxYN87R0kjzzCoGdRnEJZgmWNyQ5IGlqjqLLHLW
	tIDtqw/kkVb4IHAouLKUHhGUkICjnxbIOH/iab1yodDIfnudsiwKt1nbAr/GQhdL9s6BwfHXs2bAm
	YXWdoqvIt94YIQlgatSbpE4ykAswEq9EesW80eJLVB6/i9EKgzGzvPAUkfSm2y6Dooki5Cl5zaUH+
	WBAKkI6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6UTp-000000070vs-2GOs;
	Tue, 15 Sep 2026 14:49:53 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6UTj-000000070uG-05o5
	for linux-nvme@lists.infradead.org;
	Tue, 15 Sep 2026 14:49:48 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D921321E1D;
	Tue, 15 Sep 2026 14:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789483781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eFz2AThlVU/v0O9zeGtcuIj7Eh7/LYzigKpAfgn/FF8=;
	b=QVveEQJfbPrWp7HLujOWkXTbhNMXYht0WttbjHpFqpPfplaSMmYeWhvgKtT6yZn+vLbglW
	1Hpid1EDFZ0sLqMSNF5AfIFp+oPBcbW7ig6vYhSkPAaJsWfGVRYHV+ESLtIVpRQ2fBq0bn
	1knhRyBbFsylfMQ7WKQZ1NVmB8ZVBC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789483781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eFz2AThlVU/v0O9zeGtcuIj7Eh7/LYzigKpAfgn/FF8=;
	b=VJZNkjzOiorAcmth5+rD7QW34iRufjT6FtLunprsyBra/Cpc1TicrzeaqjSorR+KzZHNTs
	F7bV/nhC9Og/ntAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789483776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eFz2AThlVU/v0O9zeGtcuIj7Eh7/LYzigKpAfgn/FF8=;
	b=l6ZLdufBGEjhjBAGiOE3LpSgJCqEhWj28+TagtCxL4nPDeu1ibkGoiz73kkoNCYC6EqikL
	3EhG2RDZmrfAX8RYNtzZZG0nlz4oWWEMuQnPIivlJ9DbQ7yX+hS7d9+/tuRJPmdSGHtZqn
	Uw2pA3WhpZR7w5MEWkybAWgOvFxu6LI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789483776;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eFz2AThlVU/v0O9zeGtcuIj7Eh7/LYzigKpAfgn/FF8=;
	b=AqdseJt0kiWqF4gcJmlKeL9A2Z4ojWXVUqM0ZMIfiidqoEOCmOOhwQ6xMKY1nV4z7zz9Cm
	Dbhid8637VQeElAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6B1213432;
	Tue, 15 Sep 2026 14:49:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w7cGIABbqWrATAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 15 Sep 2026 14:49:36 +0000
Date: Tue, 15 Sep 2026 16:49:31 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org, 
	linux-nvme@lists.infradead.org, hch@lst.de, hare@suse.de
Subject: Re: [PATCH] nvme: do not reset controllers in NVME_CTRL_NEW state
Message-ID: <10649bfb-a250-4352-a858-4e9b03457ae0@flourine.local>
References: <20260915095827.698928-1-mlombard@redhat.com>
 <e6146839-0a52-45d0-8b95-9ae0f7807493@flourine.local>
 <DLFXS43UXYEC.MEIQ5NBK049N@arkamax.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLFXS43UXYEC.MEIQ5NBK049N@arkamax.eu>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_074947_221645_354845FB 
X-CRM114-Status: GOOD (  14.23  )
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

On Tue, Sep 15, 2026 at 03:49:36PM +0200, Maurizio Lombardi wrote:
> "
>  Fix this by removing NVME_CTRL_NEW from the allowed prior states for
>  the NVME_CTRL_RESETTING transition. It is safe to drop this transition
>  entirely because a controller in the NVME_CTRL_NEW state is merely
>  allocated and not yet initialized, a reset operation at this stage is
>  meaningless.
> "
> 
> For what concernes the "why it was there in the first place" question,
> I think that the reason is that in ancient times a CONNECTING state
> didn't exist. The controller initialization was done via a reset;
> so the transition was NEW -> RESETTING -> LIVE.

This rings a bell. With the introduction of the fabrics drivers, the
CONNECTING state was introduced and the PCI driver didn't use the
CONNECTING state for while. But due to various reasons, the PCI
transport follows the same state transitions as the fabrics ones now.

I am just a bit careful with the state machine, even obvious correct
changes can introduce subtle regressions.


