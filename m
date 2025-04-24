Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76577C369C2
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 13:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i/K2W5ncqSvxvGO0gXZwnTTuYSRLi6Dm3a0SywDMhEQ=; b=nZGBV7oi4yGtzI6IUY6PS0aOup
	bU5pmrE9ricvZYMffuHSexq9YaKEhjMOPXbR94jvXGy1ewntLm1IrimQrul1ot7dDPi8A7sRJgmQa
	4Ic4M/WT2qb5dP4O5zl3mXGqLj4Wokv5G1xZCizWR1gp/n/r8O/5OUPoaEw/jaBzHHAdDdtWAYvgD
	tcpfxJQQlOFCa7+eZeIm6zZuhFnZ2+uw9BBIMfa7TR3BwZskDqUo4vHElDinfjETdFMukcHxwfFzx
	V/Xzwy8phr6xVVtTgFbHDLa6P1dSTHx9mz/BJsn7Cx5VEago1v4jLdKJeWLF39hAE/L6x/+E79x0d
	XA/yAWJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7wBa-0000000E7bD-19sk;
	Thu, 24 Apr 2025 13:00:14 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7uWi-0000000Dokh-07JZ
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 11:13:57 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2157521125;
	Thu, 24 Apr 2025 11:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745493233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i/K2W5ncqSvxvGO0gXZwnTTuYSRLi6Dm3a0SywDMhEQ=;
	b=QeONCUYQxIo3psidYLLYfgzG2yRpVA55gy9E8Ao1SjxfXW84hwnSrBKKjchZi1UUUtdIpG
	PUHCVTpWg0iyw++SXS9WGGVDyPYI/4+8WpBTxuPlcAEF2YHc0XLqHJuJ2HpZS4CiAQuBKR
	TdhRVmiF3l95H4kLjBiwrdKrPzfb0nI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745493233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i/K2W5ncqSvxvGO0gXZwnTTuYSRLi6Dm3a0SywDMhEQ=;
	b=ZRgl3WivlM9PbiPVp7ZRwv58I12rxKQD3xHZrSi6rpE1jQPRqO00E/W6x7Pe/JP+2WtUJG
	QGpzz7UMpcF2fZCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745493233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i/K2W5ncqSvxvGO0gXZwnTTuYSRLi6Dm3a0SywDMhEQ=;
	b=QeONCUYQxIo3psidYLLYfgzG2yRpVA55gy9E8Ao1SjxfXW84hwnSrBKKjchZi1UUUtdIpG
	PUHCVTpWg0iyw++SXS9WGGVDyPYI/4+8WpBTxuPlcAEF2YHc0XLqHJuJ2HpZS4CiAQuBKR
	TdhRVmiF3l95H4kLjBiwrdKrPzfb0nI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745493233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i/K2W5ncqSvxvGO0gXZwnTTuYSRLi6Dm3a0SywDMhEQ=;
	b=ZRgl3WivlM9PbiPVp7ZRwv58I12rxKQD3xHZrSi6rpE1jQPRqO00E/W6x7Pe/JP+2WtUJG
	QGpzz7UMpcF2fZCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05950139D0;
	Thu, 24 Apr 2025 11:13:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j42wOvAcCmguOAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 24 Apr 2025 11:13:52 +0000
Date: Thu, 24 Apr 2025 13:13:48 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/14] nvmet-fcloop: track ref counts for nports
Message-ID: <9d18c084-afd5-4bd7-8650-496b88584ed4@flourine.local>
References: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
 <20250423-nvmet-fcloop-v5-1-3d7f968728a5@kernel.org>
 <002aee76-9114-4029-85b3-aa04e8ef76ed@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002aee76-9114-4029-85b3-aa04e8ef76ed@suse.de>
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_041356_216087_7B7F21F8 
X-CRM114-Status: GOOD (  13.54  )
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

On Thu, Apr 24, 2025 at 12:08:33PM +0200, Hannes Reinecke wrote:
> > +	nport = fcloop_nport_lookup(nodename, portname);
> > +	if (!nport)
> > +		return -ENOENT;
> > +	spin_lock_irqsave(&fcloop_lock, flags);
> > +	tport = __unlink_target_port(nport);
> >   	spin_unlock_irqrestore(&fcloop_lock, flags);
> Hmm. This now has a race condition; we're taking the lock
> during lokup, drop the lock, take the lock again, and unlink
> the port.
> Please do a __fcloop_nport_lookup() function which doesn't
> take a lock and avoid this race.

The lock is protecting the list iteration not the object itself. The
lookup function will increase the refcount, so it doesn't get freed
after the unlock. How is this racing?

