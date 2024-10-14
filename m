Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63BED18129
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 15:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dDl5ih4b2hme/soWUt7faSN5N69XStcc2zAJbBJj9fI=; b=zO2XyorcbdiPHZjYKola9xV1F0
	yppVSD0Ur71xqnaGJTeHAfTFQK8CYnTfBTNzcqQ1UkoplUOuah/1mydO/lieSxKtcxm6n3herbVdA
	pU4kSv5hKS7IzkfFT0UW3I8+TnRAW73jSlbRNdNfGlOYcYAlpq38jH421bfp0E8VijT33RAQdQYWJ
	2cApV/18pFzZpTVXpIcvCePTWm/58sJ3TcM82WcOzuXsAL/Q2y0AexyHJD0B1bEU+VPJfSw89vDwb
	m83Em3QiPWNMflFlTmO49I62hdtCZG+OxVHsKegeeANIMcZSM9x7tghtz/2oWQNZZ3VKExSMzud0x
	ouBMJmkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0N6j-00000005gRs-2los;
	Mon, 14 Oct 2024 15:35:41 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0MAm-00000005Ugg-0q0i
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 14:35:53 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4207721B4F;
	Mon, 14 Oct 2024 14:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728916546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dDl5ih4b2hme/soWUt7faSN5N69XStcc2zAJbBJj9fI=;
	b=FXJjuSA+gsdFfg0jqxc+tl1AzDzyUCNuTWXfmPIigul4TE/L2JB47gT2X1qRvYF53Te/hG
	knKJF569nXrJ7ElyE92BC8DTUoXuOpi5tpBBebu0w+Dfhh3o7fyUmArRLYjIPR21c7Nh4J
	2Bsf7OzU8PLwYBjvnwgdzT4m1ngGEVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728916546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dDl5ih4b2hme/soWUt7faSN5N69XStcc2zAJbBJj9fI=;
	b=8pr4bi1wa4JdzDen/THOLLfuBYpwqqGybt+eKg9/E2TrDLsEq9xXvbNNDwbdQxGesHaqjR
	opWuViWmGPMDOyDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FXJjuSA+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8pr4bi1w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728916546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dDl5ih4b2hme/soWUt7faSN5N69XStcc2zAJbBJj9fI=;
	b=FXJjuSA+gsdFfg0jqxc+tl1AzDzyUCNuTWXfmPIigul4TE/L2JB47gT2X1qRvYF53Te/hG
	knKJF569nXrJ7ElyE92BC8DTUoXuOpi5tpBBebu0w+Dfhh3o7fyUmArRLYjIPR21c7Nh4J
	2Bsf7OzU8PLwYBjvnwgdzT4m1ngGEVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728916546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dDl5ih4b2hme/soWUt7faSN5N69XStcc2zAJbBJj9fI=;
	b=8pr4bi1wa4JdzDen/THOLLfuBYpwqqGybt+eKg9/E2TrDLsEq9xXvbNNDwbdQxGesHaqjR
	opWuViWmGPMDOyDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23D1E13A42;
	Mon, 14 Oct 2024 14:35:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KnLdBkIsDWdaagAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 14 Oct 2024 14:35:46 +0000
Date: Mon, 14 Oct 2024 16:35:45 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-tcp uaf when tls setup fails
Message-ID: <d4a742e5-3639-467d-9ce9-a1b50211667b@flourine.local>
References: <8bb28305-01b3-4d68-bc74-bdbd9352b1c1@flourine.local>
 <5b68b804-337f-4cec-9d90-6f727baaabbd@flourine.local>
 <77f84f3b-86ff-4d26-ab25-a0355bcb0e40@flourine.local>
 <eb2298da-1d64-4424-a462-9056f722b5d7@suse.de>
 <a5ec9717-ebb0-4cdf-aaad-17f8a247a2c3@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5ec9717-ebb0-4cdf-aaad-17f8a247a2c3@flourine.local>
X-Rspamd-Queue-Id: 4207721B4F
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_073548_569758_B2E0888D 
X-CRM114-Status: UNSURE (   7.62  )
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

The errno EXDEV is from blk_mq_alloc_request_hctx. There is check if the
hctx is mapped to anyting. I forgot that I still had the --isolcpus
stuff enabled, thus the allocator returns EXDEV.

But the cleanup path still seems to miss to stop something and the
timeout handler fires 5 seconds later after the connection attempt
failed. This could be the keep alive timer...

