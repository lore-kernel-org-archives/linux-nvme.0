Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F46103E169
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2026 12:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GR+pFJmfdmADD21c25pbEU0rkRVfvHS+y2UyZS4mSTI=; b=Y7Rl/UR35zYTdZW0b4I3G9C3Rn
	QoqWTtYj30evOpIMRO4zQZdX16Qlu26nXG5vZorXBxzyOTj8czBBCj+ExTeWtaw9+mlvz8rYSOFBX
	KVQuswarjP++GxbQCyzbpgT985dHTwjEdFU8NVwT/uyKPY5WFalZVyiDusjR1GxaPZCyVZVKp+sCE
	2gRd/V1VoeqpGBUS8d87bHxwmkqRY8RKmWiH4KP86Uw2YofHtJmsfMy2wqvVjyOlVE/l+3pb+26ez
	KSY+dUVSY8+CHlAoPkRH2sbDKF8wQofB4+yOQ4FWr2vpvLQqgATFOipYNg+uF2YboR12+Aa6ZABQe
	t7DdHadw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2pgK-00000008MVb-2QeQ;
	Wed, 18 Mar 2026 12:07:24 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2pgB-00000008MVE-0z16
	for linux-nvme@lists.infradead.org;
	Wed, 18 Mar 2026 12:07:16 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 297DA5BEB0;
	Wed, 18 Mar 2026 12:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773835631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GR+pFJmfdmADD21c25pbEU0rkRVfvHS+y2UyZS4mSTI=;
	b=cDt3ObFZobQDI1z0jEsPVIH7H9Djy//gedLT4HV16dvG6osbZN6zOzZa1bbePkm6TUFTid
	Hz4is8iITA5M4i506lYpq1nYzRd/I2RBX52xITOm8CNXOoHonw4Gp/Sf+1lrqbuLmkaXFz
	8GCjHdN5nUzhA2suVXDVgkHEDpeO38A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773835631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GR+pFJmfdmADD21c25pbEU0rkRVfvHS+y2UyZS4mSTI=;
	b=d9cAlFgjzrp4yW87FmFhHFuAuZvSZoIrT+M8UlR5LwNS53s7CFA/yCDGltm1YmSHqQ4eHL
	MUIzHZpJ2xU45zDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cDt3ObFZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=d9cAlFgj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773835631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GR+pFJmfdmADD21c25pbEU0rkRVfvHS+y2UyZS4mSTI=;
	b=cDt3ObFZobQDI1z0jEsPVIH7H9Djy//gedLT4HV16dvG6osbZN6zOzZa1bbePkm6TUFTid
	Hz4is8iITA5M4i506lYpq1nYzRd/I2RBX52xITOm8CNXOoHonw4Gp/Sf+1lrqbuLmkaXFz
	8GCjHdN5nUzhA2suVXDVgkHEDpeO38A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773835631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GR+pFJmfdmADD21c25pbEU0rkRVfvHS+y2UyZS4mSTI=;
	b=d9cAlFgjzrp4yW87FmFhHFuAuZvSZoIrT+M8UlR5LwNS53s7CFA/yCDGltm1YmSHqQ4eHL
	MUIzHZpJ2xU45zDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18E7C4273B;
	Wed, 18 Mar 2026 12:07:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ge7gBG+VummPSwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 18 Mar 2026 12:07:11 +0000
Date: Wed, 18 Mar 2026 13:07:10 +0100
From: Daniel Wagner <dwagner@suse.de>
To: "Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: libnvme API review
Message-ID: <0b954855-c99c-4165-a804-edde9a34f1a7@flourine.local>
References: <d5b9ca7f-8fd1-48ea-a883-79e92d92ec7e@flourine.local>
 <MW4PR84MB223598544C3E0EC5DA7FAAA09840A@MW4PR84MB2235.NAMPRD84.PROD.OUTLOOK.COM>
 <93520cef-9e3a-4832-9bfa-a0f2c36246e3@flourine.local>
 <SJ0PR84MB2231AC08CA04F54CC29F03319841A@SJ0PR84MB2231.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR84MB2231AC08CA04F54CC29F03319841A@SJ0PR84MB2231.NAMPRD84.PROD.OUTLOOK.COM>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 297DA5BEB0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_050715_502919_FC8324FD 
X-CRM114-Status: GOOD (  14.27  )
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

On Tue, Mar 17, 2026 at 11:10:06PM +0000, Ballard, Curtis C (HPE Storage) wrote:
> With this style and goal in mind something like the name Keith Bush suggested
> in a little bit later message makes a lot of sense to me. His suggestion of
> "nvme_do_subystem_reset" would follow the kernel's naming scheme while 
> the NVMe action that is performed matches the NVMe name.

Which other function would get the nvme_do_ renaming?

[lib]nvme_do_subsystem_reset
[lib]nvme_do_ctrl_reset
[lib]nvme_do_ns_rescan

[lib]nvme_submit_admin_passthru
[lib]nvme_submit_io_passthru
[lib]nvme_get_nsid

> >The only way I currently see to resolve this is by using a different
> >prefix for the library APIs (e.g., libnvme_) and reserving the nvme_
> >prefix exclusively for NVMe spec APIs. However, I am unsure if this
> >approach will reach a consensus here.
> 
> This approach looks like a really clean and easy to understand split to me.
> That sounds like it would mean more renaming though.

Christoph is also in favor this change. So if no one objects, I'll go
ahead and update those interfaces accordingly.

Any opinion/suggestion on the prefix name?

- libnvme: probably the one which wont conflict with anything else
- libn: too close to libnl (netlink)
- ln: too short?
- ...

While a bit long I'd say libnvme is likely to cause the least problem in
the long run. 

