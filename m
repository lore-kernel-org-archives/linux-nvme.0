Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4EDC369A9
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 13:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y2epGjcmKvJhQTpWKHhYmv8HYnIBJ+VqFT0VdqeNyqM=; b=ng0o/govCEal+9TG2S+aIOCijD
	Q7QxgEAm5D9K8WNM+WHHe6Ck/spe2sKOynD1JrTGrhRKnK+QpNQKhXNi9PQjcHImzzt0cKX8V3g82
	0hqnaYdQQkjGKZ5axmA3TE8k0WOjgFPAVcZyywpRjQd3RQOIooybb0ZJUd3tYwIm3W9HGRO9dKlYR
	bDPLczVu4+1ZshFLH9CM9rFTTk09LuoF7Bh0QR/FgvgN7Nxhibtf+UdTHTJC6axukXAgg1tgF7uaL
	GGzNORj9tTzoUxK/ZzgXIxH4Lf5/t7pBwINocBv3YTzG9QdDQJxn+JMiUbvgOE29M6Qlo4NVynvTo
	YPGY9+Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u28mB-000000046fC-0sI9;
	Tue, 08 Apr 2025 13:14:03 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u26zu-00000003pOO-3jIi
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 11:20:08 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5AC652111F;
	Tue,  8 Apr 2025 11:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744111203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2epGjcmKvJhQTpWKHhYmv8HYnIBJ+VqFT0VdqeNyqM=;
	b=ZjSNMmcpuKoFAbwrpTD/N3QE2g+JjQyjYIKW2DfBbLAYrGSq6bu5m3WA/bJqrDi1orIeqq
	3Kx4Rc1JcxDVETnH8lqcwsJUMIemXwcJEEmbWY+4qX3uKuTz3V7e5pv778QdMN1bB8pWCa
	FkG8hUaqN5aRJ/pKLNbtgtFzKpDtRDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744111203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2epGjcmKvJhQTpWKHhYmv8HYnIBJ+VqFT0VdqeNyqM=;
	b=uRaQTp4HM1YiYFlOYbCX+gu+BBcd3TuO5em2xQbrxFM/F4mG3/Crwan046WPqnppAnqLsP
	qm/r1DVFdhuO4+DA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ou1eIImZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3NECoo1T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744111202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2epGjcmKvJhQTpWKHhYmv8HYnIBJ+VqFT0VdqeNyqM=;
	b=ou1eIImZxqXvyBcPgJZLf+434L96g38FQ+GLqb/4KwM0udIIgD8hUm6TdDGDxjaMEMANqz
	zBxnO/2C8eEhfGUEOTr/HPL1+zM5sLYBvCZLSlSCa7/J5AkfVrOVp1W72qhai7TqFDeqw0
	ESKtF4CFbYm2RrFFM4BpoubtAuCk0o8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744111202;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2epGjcmKvJhQTpWKHhYmv8HYnIBJ+VqFT0VdqeNyqM=;
	b=3NECoo1TAy+G1ykYMFG+aK1bPcYEl9VlHbzG03xzZ1pKPCk5/N38A75At/yLm869W7bc/Q
	ctG6CFKWguaUZVBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B56A13691;
	Tue,  8 Apr 2025 11:20:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rRlvEWIG9WdDCAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 08 Apr 2025 11:20:02 +0000
Date: Tue, 8 Apr 2025 13:20:01 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/18] nvmet-fcloop: allocate/free fcloop_lsreq
 directly
Message-ID: <3bca3fe4-3a1c-43f9-a0c2-96ab1887f3c8@flourine.local>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-10-05fec0fc02f6@kernel.org>
 <603b438e-02f6-4f01-8ffa-12ab6ec8e745@suse.de>
 <984ea057-de15-472a-9be3-79594f6bfc00@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <984ea057-de15-472a-9be3-79594f6bfc00@flourine.local>
X-Rspamd-Queue-Id: 5AC652111F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,flourine.local:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_042007_080626_E34ED37D 
X-CRM114-Status: GOOD (  13.32  )
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

On Tue, Mar 18, 2025 at 02:58:35PM +0100, Daniel Wagner wrote:
> On Tue, Mar 18, 2025 at 12:17:11PM +0100, Hannes Reinecke wrote:
> > > +	tls_req = kmalloc(sizeof(*tls_req), GFP_KERNEL);
> > > +	if (!tls_req)
> > > +		return -ENOMEM;
> > 
> > This cries out for kmem_cache_alloc() ...
> 
> Okay, will switch to this API. FWIW, in the same call path there are
> more kmallocs.

This change send me down yet another rabbit hole because when
deallocatin the cache, it reported a leak caused by a list_add_tail(x,
y) vs list_add_tail(y,x) bug which I missed the last time...

