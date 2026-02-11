Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B051ECD6C1
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 17:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3/j/tJwWriKdo2XeLd8tRCmvMmladxvngqpxCKbGeBA=; b=UmFZkTPrfFaNqVva6vfJPYkHyg
	ODzDhsV5YtGtcEOnkU9uFMl8qED0dopAqcLRZ3WP3qQ1xW1RuDURyiXiIaBUO2trCv0afkQUVPpKk
	txQ/j5NinjgX/12dcqszPyYS3/UFTUBv/IpC/VhyUeLHspAXRzU0++TZgKJrzwb5/Iulhnyq/v4vw
	0Dk/GuRhomWfQ0FauWAbcZRBTLqrU1mW6wKGs8vcBiXCH8nHj+cjg24PzdVixMUrt4ff5UGE1hi24
	YR9LRTrRtJdzqxSa2lp/su6Gv3vSIByGr4E/7rBAWW8UzlRaIsrN3NU2gSOLjXY7ACgW5wPRdJVEm
	ec0lLlaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqDb4-00000000rul-1NJn;
	Wed, 11 Feb 2026 17:01:50 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqDb1-00000000ruN-0lyr
	for linux-nvme@lists.infradead.org;
	Wed, 11 Feb 2026 17:01:49 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C6C55BDF5;
	Wed, 11 Feb 2026 17:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770829300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3/j/tJwWriKdo2XeLd8tRCmvMmladxvngqpxCKbGeBA=;
	b=tSv17q33/S51lTnNewRhQAMpZlgmEqTYi29l8jp8Vc51YHxSkNrNUFp1FXbb5EO2XmMM3D
	Z/kGO0wf0put6BeT2wjtyG5Hj0uNV4aAIyPOQUFk4FrPKUoupELQj5C8+7/B2xm3d75loH
	HVnEodUweO2x0KvCuDFdnXMZpZkO1GI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770829300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3/j/tJwWriKdo2XeLd8tRCmvMmladxvngqpxCKbGeBA=;
	b=xYkmvtwIdHlUmKmAlnYWCFN+DrbgjF47BTvm4sY1KkjBmkDaeH4lLn8xtir1VJg9aG7sXU
	AlxjvXp0YR8A43Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770829295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3/j/tJwWriKdo2XeLd8tRCmvMmladxvngqpxCKbGeBA=;
	b=x6ILwdZxKZesRRQqUgpNn/zAeYZsKVT4igutjko/8CzcFwOdgT9oOvFNTmutEBPaKT8sOC
	Vtc5Ei1VtFsLssfs38UyL4WYeg+ujO2alFnVx6Atr9jat5HrkzsiXJI+YSXyWH+D8ayKaV
	hYvEZLoIESaxDoYdThyQEKIvcPMn74A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770829295;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3/j/tJwWriKdo2XeLd8tRCmvMmladxvngqpxCKbGeBA=;
	b=k+vI1IaVmp8Ore7hv/kuMvuy6wO7BK2ygVO1n7bVKwbGAvDRfERv4Gan9GG7afcKfwo2oc
	49PWT4ErIN6wqnAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E584D3EA64;
	Wed, 11 Feb 2026 17:01:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HL02N+61jGnvdwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 11 Feb 2026 17:01:34 +0000
Date: Wed, 11 Feb 2026 18:01:34 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org, 
	mlombard@bsdbackstore.eu
Subject: Re: [PATCH] nvme: fix memory leak in quirks_param_set()
Message-ID: <08fb9e50-8f60-4a85-aaf7-0dfc77415405@flourine.local>
References: <20260211163028.76913-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211163028.76913-1-mlombard@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_090147_375999_A9C5349F 
X-CRM114-Status: GOOD (  12.85  )
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

On Wed, Feb 11, 2026 at 05:30:28PM +0100, Maurizio Lombardi wrote:
> When loading the nvme module, if the 'quirks' parameter is specified
> via both the kernel command line (e.g., nvme.quirks=...) and the
> modprobe command line (e.g., modprobe nvme quirks=...), the
> quirks_param_set() callback is invoked twice.
> 
> Currently, in the double-invocation scenario, the second call
> overwrites the nvme_pci_quirk_list pointer, causing the memory
> allocated in the first call to leak.
> 
> Fix this by freeing the existing list before assigning the new one.
> 
> Fixes: b4247c8317c5 ("nvme: add support for dynamic quirk configuration via module parameter")
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>

Looks good.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

