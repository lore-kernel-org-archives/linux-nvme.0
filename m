Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A93C0218A
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2025 15:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QXqnGoRaI66tmMlBOUK4wmzdfIDwO2FaFNK6NEuhUPU=; b=OJkWORZb43CNRbBc1TkrTQdwDF
	dnkyj/Bm7NGBkyVQ2Y5AAZhTo5imY3tsKveDtZTjDDC0csZlTK1yrEeP10use10P3xDWEWuwFUeMO
	mD4PSiK4BxUVx7fjT58ttppAPjizFVfz3xwwMtCBJnsS1zBbs/de3fv+PhkVqpK6e4cRDbIF7yADH
	X+D95IOcZr+/m8JqeYZhQRTEJrXWjzRbOOYUXMbL77J5yjfhfKnF+5M02nblEIFU0FQ9c9qkdV2eR
	10lEPqIUOtqhoI92vnNIpO16wKMRdoMH7hxf1yfEFxGUGfKUkhevx6SZcwPpDGrkdrmg1nRLTIv2/
	bHmT+n0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdWQI-0000000941W-0ZXP;
	Thu, 30 Jan 2025 15:25:42 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdWQF-00000009416-23Te
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jan 2025 15:25:40 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 479892117F;
	Thu, 30 Jan 2025 15:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738250736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXqnGoRaI66tmMlBOUK4wmzdfIDwO2FaFNK6NEuhUPU=;
	b=G/S331RPzqeN8RLclPgCZBvBthOz9gB0ZitX2Gu7+lqZBITnB+iVcui5MiN0z6054kMZBJ
	Y0w3l7l4GvrqnG9F10YFNzG1AomoaKlytP4D/FkYjh/G8Xo7s07rmyaUPealClXSDO+Apy
	mcblW5qFWlKL7U7Ik2gyZpv3NQK+3qg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738250736;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXqnGoRaI66tmMlBOUK4wmzdfIDwO2FaFNK6NEuhUPU=;
	b=BeuH8oCIrs5fkeTJQo5zyGo2q6mVspG5ylgU7tjnLP6tQ9TxyUfBBvZkA1p2+pIaWKDzrW
	Me9Q9u8TRgnZbbAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="G/S331RP";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BeuH8oCI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738250736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXqnGoRaI66tmMlBOUK4wmzdfIDwO2FaFNK6NEuhUPU=;
	b=G/S331RPzqeN8RLclPgCZBvBthOz9gB0ZitX2Gu7+lqZBITnB+iVcui5MiN0z6054kMZBJ
	Y0w3l7l4GvrqnG9F10YFNzG1AomoaKlytP4D/FkYjh/G8Xo7s07rmyaUPealClXSDO+Apy
	mcblW5qFWlKL7U7Ik2gyZpv3NQK+3qg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738250736;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXqnGoRaI66tmMlBOUK4wmzdfIDwO2FaFNK6NEuhUPU=;
	b=BeuH8oCIrs5fkeTJQo5zyGo2q6mVspG5ylgU7tjnLP6tQ9TxyUfBBvZkA1p2+pIaWKDzrW
	Me9Q9u8TRgnZbbAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3477B1366F;
	Thu, 30 Jan 2025 15:25:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /PP1C/CZm2cXBQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 30 Jan 2025 15:25:36 +0000
Date: Thu, 30 Jan 2025 16:25:35 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>, 
	James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] nvme-tcp: rate limit error message in send path
Message-ID: <216ab5ef-1c8b-4f3e-8a1a-f11e28994620@flourine.local>
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
 <20250128-nvme-misc-fixes-v1-1-40c586581171@kernel.org>
 <20250129060534.GA29266@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129060534.GA29266@lst.de>
X-Rspamd-Queue-Id: 479892117F
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250130_072539_678791_CA480574 
X-CRM114-Status: GOOD (  17.76  )
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

On Wed, Jan 29, 2025 at 07:05:34AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 28, 2025 at 05:34:46PM +0100, Daniel Wagner wrote:
> > If a lot of request are in the queue, this message is spamming the logs,
> > thus rate limit it.
> 
> Are in the queue when what happens?  Not that I'm against this,
> but if we have a known condition where this error is printed a lot
> we should probably skip it entirely for that?

The condition is that all the elements in the queue->send_list could fail as a
batch. I had a bug in my patches which re-queued all the failed command
immediately and semd them out again, thus spamming the log.

This behavior doesn't exist in upstream. I just thought it might make
sense to rate limit as precaution. I don't know if it is worth the code
churn.

