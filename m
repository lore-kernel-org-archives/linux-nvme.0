Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062C4CD3424
	for <linux-nvme@archiver.kernel.org>; Sun,  3 May 2026 17:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=igqop5cPlde3fb4LTUkcOr8qP5rp2OJ4q578vCorbe4=; b=sv+D+GQoROA9sbexUQ1yTWl2jb
	+FgyUc+o92ntT79I95Wakv7CMKzlFUgMFzMfFZatu47sct9Q53clwCM/cMqFwz7B/LZLAAa4r3AeI
	bHqP3bx11PaM+tMGe89CqeBfACJFbvaS8jyDubTBk2LbdQwj6R7akmhzbPoeTGZFQ/D2lALGF1fZL
	XAmgyKCYGBPWwvjuREXajGZsiQl1m9iMCgqucfrHe0w7v56Ewlz8I9fdYyRhfI2xaQxpiputgrM+r
	vZOd3FLVckE15KpgOQkQa8rj1tGL2jJFxleRi1TOEz6OTyNkp3XWBYkn6IrBUpVATxKIPuzpLcIQ3
	zTIH/lcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJant-0000000BQa1-26qH;
	Sun, 03 May 2026 17:40:29 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJanr-0000000BQZB-2Lru
	for linux-nvme@lists.infradead.org;
	Sun, 03 May 2026 17:40:28 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4CD826A87D;
	Sun,  3 May 2026 17:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777830023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=igqop5cPlde3fb4LTUkcOr8qP5rp2OJ4q578vCorbe4=;
	b=zebRgMI0Ah8C7mtrXcDIzdo55/tIRj37b6jfgiJqiuN3e72p4rwJ8Of4/A72sVeHa4044s
	0MeEaJYvjXnsPc8Htu3uIRQkK3ZW1d/C+K5Ehku0PiemmADTMLEHVFH4Sgij2ZbhQ/peft
	SP6L8TnSYvViSoY1a3qV5rCXSfoZx44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777830023;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=igqop5cPlde3fb4LTUkcOr8qP5rp2OJ4q578vCorbe4=;
	b=IzDB4HTG4yF/DE8VB02r/hhHzKpL9gA2y6sX/3+VwIhgfzpf0rCNuFOPOF63zsK1EU3oV1
	hzwUD7P+zH6uXjCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zebRgMI0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IzDB4HTG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777830023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=igqop5cPlde3fb4LTUkcOr8qP5rp2OJ4q578vCorbe4=;
	b=zebRgMI0Ah8C7mtrXcDIzdo55/tIRj37b6jfgiJqiuN3e72p4rwJ8Of4/A72sVeHa4044s
	0MeEaJYvjXnsPc8Htu3uIRQkK3ZW1d/C+K5Ehku0PiemmADTMLEHVFH4Sgij2ZbhQ/peft
	SP6L8TnSYvViSoY1a3qV5rCXSfoZx44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777830023;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=igqop5cPlde3fb4LTUkcOr8qP5rp2OJ4q578vCorbe4=;
	b=IzDB4HTG4yF/DE8VB02r/hhHzKpL9gA2y6sX/3+VwIhgfzpf0rCNuFOPOF63zsK1EU3oV1
	hzwUD7P+zH6uXjCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33A7F593A3;
	Sun,  3 May 2026 17:40:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fFGJCoeI92kJcgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Sun, 03 May 2026 17:40:23 +0000
Date: Sun, 3 May 2026 19:40:21 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.com, kbusch@kernel.org, 
	hch@lst.de, gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: Re: [PATCH 0/7] nvme-cli: add nvme top command for real-time
 monitoring
Message-ID: <ce49c901-7879-468b-afe4-88cd2c3c3dec@flourine.local>
References: <20260430105234.1172446-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430105234.1172446-1-nilay@linux.ibm.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Queue-Id: 4CD826A87D
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260503_104027_750707_3C4C8283 
X-CRM114-Status: UNSURE (   7.12  )
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

On Thu, Apr 30, 2026 at 04:22:21PM +0530, Nilay Shroff wrote:
> As usual feedback, comments, and suggestions are welcome!

I gave it a quick test. Overall looks pretty good and useful. One thing
I noticed was that the table width jumped around when the bandwith was
not constant, e.g jumping between 0 and some value. But that is minor
thing. Let's discuss and collect some feedaback during LSFMM.

Cheers,
Daniel

