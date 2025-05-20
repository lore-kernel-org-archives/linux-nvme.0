Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73BCC3ABDD
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 07:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OKLSjKXL5nKN4MquH6Di6ixGaI9EKtLbhgoW/rC5a00=; b=Xby17ydFF7VShs6geEhop9or7Q
	NdJKxkqh4nkSTOcQYYmbyyiHEYG4cOjfnC0zn9LRCFbyL9CnC2hobdhx5i2UbxC3RPaCEGXgChsbD
	WhJeWrXBVXzP4emdgUmrYJy1pWAmVRhQ40PBzgUZTdN6RUbXU/6VTkZJNSt4zBl5jfMgyZ4Ek8J2z
	0HSVwqqg9QU4UU+Aod2Fwy4R+nCA5cn4FErUlVu+7sip8FoiOO5DsJ8xrXwcsE00l/r/y/KnBCo54
	X1hLka2MbZfrlZwCLL+xbPYSxfL1JGg4O6NjvsutFj6oGI58r30eYsbLMWOCHIFGE3tnBC5Ut7TrQ
	pKdrv8bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHHFA-0000000BpJr-1Oe2;
	Tue, 20 May 2025 07:18:32 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHHF8-0000000BpJN-07uL
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 07:18:31 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0EE4822CE6;
	Tue, 20 May 2025 07:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747725508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OKLSjKXL5nKN4MquH6Di6ixGaI9EKtLbhgoW/rC5a00=;
	b=W6sRYbGlT6Fus8s5AUq4Jn/MCvhWhJQm0Q1DX5+4A6devxCB4ilYAxbk+sTeGpfiT4UrKv
	5yXX71H4G/n5bqrqivqUqEUtgT6YYmj165hW/Os/6m9iZWSaNKtey8DcvLjpSziWRpgLyd
	H/neivrZlgoXF7bRB5W2RBt3Z61nFiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747725508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OKLSjKXL5nKN4MquH6Di6ixGaI9EKtLbhgoW/rC5a00=;
	b=gtxo02b5otaBWmpOZJ1G9ZWYn3jCt1oskgjjxos5r1vvUoDRNsL0sOlc3oFu1flqJXvbeJ
	zGDm9Aa/UxBhiWCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=W6sRYbGl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gtxo02b5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747725508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OKLSjKXL5nKN4MquH6Di6ixGaI9EKtLbhgoW/rC5a00=;
	b=W6sRYbGlT6Fus8s5AUq4Jn/MCvhWhJQm0Q1DX5+4A6devxCB4ilYAxbk+sTeGpfiT4UrKv
	5yXX71H4G/n5bqrqivqUqEUtgT6YYmj165hW/Os/6m9iZWSaNKtey8DcvLjpSziWRpgLyd
	H/neivrZlgoXF7bRB5W2RBt3Z61nFiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747725508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OKLSjKXL5nKN4MquH6Di6ixGaI9EKtLbhgoW/rC5a00=;
	b=gtxo02b5otaBWmpOZJ1G9ZWYn3jCt1oskgjjxos5r1vvUoDRNsL0sOlc3oFu1flqJXvbeJ
	zGDm9Aa/UxBhiWCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E473313A3E;
	Tue, 20 May 2025 07:18:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7DXhNMMsLGj5NgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 20 May 2025 07:18:27 +0000
Date: Tue, 20 May 2025 09:18:19 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Daniel Wagner <wagi@kernel.org>, 
	Hannes Reinecke <hare@suse.de>, Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-cli & json vs blktests
Message-ID: <a1e7dd62-b96b-4925-a9eb-d2cf181bd4f1@flourine.local>
References: <20250519054905.GA6156@lst.de>
 <30a83f60-34eb-4940-b322-8ed31f091435@flourine.local>
 <20250519095642.GA21183@lst.de>
 <c8ea015a-8b60-4ffc-a706-f7eb5b65042c@flourine.local>
 <0362bd4f-4655-4f93-8023-945cacf31aba@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0362bd4f-4655-4f93-8023-945cacf31aba@nvidia.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0EE4822CE6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	URIBL_BLOCKED(0.00)[flourine.local:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_001830_215874_C3768899 
X-CRM114-Status: GOOD (  13.78  )
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

On Mon, May 19, 2025 at 11:31:36PM +0000, Chaitanya Kulkarni wrote:
> > Okay, so the Makefile is not really working in your workflow as expected. I see
> > there are two targets 'clean' and 'purge'. I suppose it would make sense
> > to model the 'clean' target more what autotools  & co are doing. Really
> > wiping everything away. Let me fix this.
> 
> yes please hope should fix the issue that I'm also seeing from last week.

I've updated the Makefile. The 'clean' target is now doing a proper
cleanup and deletes all the build artifacts and configuration files.

