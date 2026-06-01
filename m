Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A501CD5BD1
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2026 14:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iepYn8laWn7UB8tSCYp0vC7+UIDNR9G1zLwnuC7AGWs=; b=lyHqiIrojRqpN8bRGtJ1A6EjTJ
	B3lwmeHvpFs80QbsObDtWPshpdvx/xDwfVOUoKiL1AQh19Ijcm1rTChTqXvxurgg0XQD9h6q2ybnT
	zW4uzcgBXPSUq50Hjhf4t4g2buVISs/qsIj7e+hKq0WcId51pnMOTvFRqgIzwsI3aIaIbLVsiTDQG
	wtosOxzOcBVXUn1F4hULdyktawL/ZMQ0v3oosjzj5tUnUXwg9PBvc5QNFvwG8XoZW//bN+7Wq8T79
	N3HzIrIOHImO8mUJa4GtdS4Tjbg/y92T429yE8AScIVKHsnAqutnly4yZ1zTGtKoGMV9nos1OLvab
	2Ix7rTMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU3RS-0000000BGRD-3zIS;
	Mon, 01 Jun 2026 14:16:34 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU3RN-0000000BGPc-0Tf6
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jun 2026 14:16:30 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 260416BE28;
	Mon,  1 Jun 2026 14:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780323387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iepYn8laWn7UB8tSCYp0vC7+UIDNR9G1zLwnuC7AGWs=;
	b=Fq2l88bx5fJdCqc8YfdZpsIx/6pXx2UkwnFBR+fwY7ZgUx5mkTFFBkQbwZVWNmSALmTYWY
	3y/72JCSNfVOkI3N6eEjYxTxupei2l+6eqen256XmygD/H/aGGJimqvzrtkqyR95PGxF3O
	g90fkwPo/zj++TEnWTZ8/i9uMHAAwNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780323387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iepYn8laWn7UB8tSCYp0vC7+UIDNR9G1zLwnuC7AGWs=;
	b=jV/GuVQIWgWOQnomA+HZCLEb4cfbXs6BAmkzSPGS+TBZ2qbYGB+sLKTE5Y5D156DgGbfaL
	x6ULDhJPvhq7qcBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Fq2l88bx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="jV/GuVQI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780323387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iepYn8laWn7UB8tSCYp0vC7+UIDNR9G1zLwnuC7AGWs=;
	b=Fq2l88bx5fJdCqc8YfdZpsIx/6pXx2UkwnFBR+fwY7ZgUx5mkTFFBkQbwZVWNmSALmTYWY
	3y/72JCSNfVOkI3N6eEjYxTxupei2l+6eqen256XmygD/H/aGGJimqvzrtkqyR95PGxF3O
	g90fkwPo/zj++TEnWTZ8/i9uMHAAwNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780323387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iepYn8laWn7UB8tSCYp0vC7+UIDNR9G1zLwnuC7AGWs=;
	b=jV/GuVQIWgWOQnomA+HZCLEb4cfbXs6BAmkzSPGS+TBZ2qbYGB+sLKTE5Y5D156DgGbfaL
	x6ULDhJPvhq7qcBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13246779A7;
	Mon,  1 Jun 2026 14:16:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LFn6AjuUHWqKdAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 01 Jun 2026 14:16:27 +0000
Date: Mon, 1 Jun 2026 16:16:26 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org, 
	mkhalfella@purestorage.com, randyj@purestorage.com, hch@lst.de, 
	linux-nvme@lists.infradead.org, emilne@redhat.com
Subject: Re: [PATCH 1/1] nvme-fc: Do not cancel requests in io target before
 it is initialized
Message-ID: <6589513a-6273-4826-9b26-a98cc4d9a4f1@flourine.local>
References: <20260528092734.258899-1-mlombard@redhat.com>
 <20260528092734.258899-2-mlombard@redhat.com>
 <564f1396-dd4a-4246-931e-8541c8625211@flourine.local>
 <DIXN4746EVPY.1U3JU3JVQ1557@arkamax.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIXN4746EVPY.1U3JU3JVQ1557@arkamax.eu>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 260416BE28
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_071629_295754_8741A150 
X-CRM114-Status: GOOD (  12.47  )
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

On Mon, Jun 01, 2026 at 12:28:14PM +0200, Maurizio Lombardi wrote:
> > Again, does makes sense but which tree is this based on? I don't see
> > this hunk in master or in nvme-7.2.
> 
> 
> I am not sure what do you mean, this applies and compiles cleanly
> against master.
> 
> Maybe you are referring to the comment?

I was looking at the wrong function. All good.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

