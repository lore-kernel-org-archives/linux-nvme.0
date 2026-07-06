Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADA8C43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 11:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mPFnjRiYmzqFmvFXfX8NX3WVZ1A9Cl4gsGAHqkwNSss=; b=VDkPuTK/HYMd2WFawQPCPj0oaI
	3abxb09RUbGzA+UrIaVj7XNpbOy3hJurWLb6v57SRcjskPGE9FuJCxK7VIhY1LJadd9loyVAgKEOP
	wSWna1VWr8AxdELk7z4E1VjaL8A55b9OB3CFbNbe1BdvKb6KfjBzeQIm+zf1IA9A1pFFNtDKFRa2e
	WAcG/vEY7zSAdAqghCo8gkU17Zkdh+ZafJ+o+8xO35bZwZAbb0yfehQuKH7R79L7Nk3jWYUyfDAPn
	oJpQE44aOSomu+3SSdG3NROTMDrZNwOu25YfrTm10xMlbMw3EUcIBGsGzqqwX+QdAlvV2wITFPKSN
	qU9/ahiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wghuu-0000000CQ6T-36vf;
	Mon, 06 Jul 2026 11:55:16 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wghun-0000000CQ5E-3FWv
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 11:55:12 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8C21D75BDD;
	Mon,  6 Jul 2026 11:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783338907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mPFnjRiYmzqFmvFXfX8NX3WVZ1A9Cl4gsGAHqkwNSss=;
	b=JNItCpXXzV+G+W6GmybTwvaWw/d/oat4hUWHriTkgTD6H1PlEGFW2l/lBkOXGtIUz+0Uo0
	I9R1mthuVIhwnL2LVVAgD0Kr9c/e1lI3ZM9j+MgZl5zs+/QeRrIBRyzNwGK6iDj4pLWtlm
	J6AetANtZz+Ymp6kN62iRxvR0kOqN+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783338907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mPFnjRiYmzqFmvFXfX8NX3WVZ1A9Cl4gsGAHqkwNSss=;
	b=8FmwdBcB3ZITf7j+MKx0wCTkn41xyoTDBk49q7s/7qRnEjmfBIiLrc/gylnkUIUOMPoye6
	CwurmI9MuKEQoeDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JNItCpXX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8FmwdBcB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783338907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mPFnjRiYmzqFmvFXfX8NX3WVZ1A9Cl4gsGAHqkwNSss=;
	b=JNItCpXXzV+G+W6GmybTwvaWw/d/oat4hUWHriTkgTD6H1PlEGFW2l/lBkOXGtIUz+0Uo0
	I9R1mthuVIhwnL2LVVAgD0Kr9c/e1lI3ZM9j+MgZl5zs+/QeRrIBRyzNwGK6iDj4pLWtlm
	J6AetANtZz+Ymp6kN62iRxvR0kOqN+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783338907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mPFnjRiYmzqFmvFXfX8NX3WVZ1A9Cl4gsGAHqkwNSss=;
	b=8FmwdBcB3ZITf7j+MKx0wCTkn41xyoTDBk49q7s/7qRnEjmfBIiLrc/gylnkUIUOMPoye6
	CwurmI9MuKEQoeDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72B0F779AA;
	Mon,  6 Jul 2026 11:55:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gYJVGpuXS2pncQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 06 Jul 2026 11:55:07 +0000
Date: Mon, 6 Jul 2026 13:55:02 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	John Garry <john.g.garry@oracle.com>, Nilay Shroff <nilay@linux.ibm.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, xlpang@linux.alibaba.com, 
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v3 3/3] MAINTAINERS: add missing NVMe documentation files
Message-ID: <7f5a765a-1f2b-4d67-b03d-f2cd7c73218c@flourine.local>
References: <20260706023439.3054578-1-kanie@linux.alibaba.com>
 <20260706023439.3054578-4-kanie@linux.alibaba.com>
 <ba0bd2f7-48e2-4a79-ae92-4c856c991d62@flourine.local>
 <d7a0a987-3b79-4c94-ab42-2044556c835e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7a0a987-3b79-4c94-ab42-2044556c835e@linux.alibaba.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8C21D75BDD
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
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_045511_626228_67CC8919 
X-CRM114-Status: GOOD (  16.44  )
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

On Mon, Jul 06, 2026 at 05:54:07PM +0800, Guixin Liu wrote:
> 在 2026/7/6 15:50, Daniel Wagner 写道:
> > On Mon, Jul 06, 2026 at 10:34:39AM +0800, Guixin Liu wrote:
> > >   T:	git git://git.infradead.org/nvme.git
> > > +F:	Documentation/ABI/testing/configfs-nvmet
> > >   F:	drivers/nvme/target/
> > Didn't catch this in the previous path, but why do think these API
> > should be in testing section?
> 
> Some of these interfaces have been around for a long time,
> 
> while others were only added in recent versions.
> 
> I'm not sure what criteria to use for splitting them between stable and
> testing,
> 
> so I've put them all under the testing directory for now.

The NVMe APIs are definitely not in the 'testing' section. The nvmet
APIs are also not in 'testing', IMO. While they are used upstream
predominantly by blktests, there are also people out there using them in
production systems, if we like or not.

