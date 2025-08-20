Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2AA1CA0EDC
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Aug 2025 08:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TLBoUVTN6+/MetHE5+z2mqlbt/3LzxYoP/Lyc2hclnw=; b=DcbOEisVU+Sq0mcTBzXLgDo/ph
	sjejiYiwBrg9OvvwkrdF0F1LqegY+vxt3lmJ7ik18phsbcclr/oq59M99tJ17z0mJuL76hd/oU4Em
	qTJqHptcUaNVDgnwse3lmPq2TMfJwiBdunSyiWjUJr3oPEAQxh2A2UTeE6pBykBn5L9JZaZoSpqTC
	haiHAruTiuOIeGA6uYPh2DhN69ft1UzEuMRTVi50iGGHQNvsfwnYA9mti+yNE7hzB191qzTds3HCR
	oddfMglnPqtPlXY4yXKZiD1SmSJ5bhDI7d1SoTqs3yjhNeCO499OcemoG3pXWl3htG7YHYyOFeuHw
	78zwQobQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoeQA-0000000Cmkd-3TU3;
	Wed, 20 Aug 2025 08:43:50 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoduH-0000000Cgau-361J
	for linux-nvme@lists.infradead.org;
	Wed, 20 Aug 2025 08:10:55 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B2CE921262;
	Wed, 20 Aug 2025 08:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755677450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TLBoUVTN6+/MetHE5+z2mqlbt/3LzxYoP/Lyc2hclnw=;
	b=LRdLx3ZulQ8QEOKCZol9lIPBqAq6rJ78KGN+K7uT0nV6qKaqo+9dQXSugGK7aP3JyPMWYo
	lfILtN39FLD8QovVJXh0NBGfSKULa4qMQEU9cJNWUhoywAfU1UwqojkW7Hh/mhX5h4533c
	KX23Glj3Q1nEqwaPiIqKS91htvq1vMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755677450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TLBoUVTN6+/MetHE5+z2mqlbt/3LzxYoP/Lyc2hclnw=;
	b=1YyNuOcds4XtDNkW/a0DHbLezJrmHChiVePZr4tlRKEPjoDfLlDu1+EJOIHe2XyjIe0z6A
	78wBBigUWBuL/+Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755677450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TLBoUVTN6+/MetHE5+z2mqlbt/3LzxYoP/Lyc2hclnw=;
	b=LRdLx3ZulQ8QEOKCZol9lIPBqAq6rJ78KGN+K7uT0nV6qKaqo+9dQXSugGK7aP3JyPMWYo
	lfILtN39FLD8QovVJXh0NBGfSKULa4qMQEU9cJNWUhoywAfU1UwqojkW7Hh/mhX5h4533c
	KX23Glj3Q1nEqwaPiIqKS91htvq1vMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755677450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TLBoUVTN6+/MetHE5+z2mqlbt/3LzxYoP/Lyc2hclnw=;
	b=1YyNuOcds4XtDNkW/a0DHbLezJrmHChiVePZr4tlRKEPjoDfLlDu1+EJOIHe2XyjIe0z6A
	78wBBigUWBuL/+Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A015E13867;
	Wed, 20 Aug 2025 08:10:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f4ZUJgqDpWgDZQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 20 Aug 2025 08:10:50 +0000
Date: Wed, 20 Aug 2025 10:10:50 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chris Leech <cleech@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	Prashanth Nayak <prashanth.nayak@netapp.com>, John Meneghini <jmeneghi@redhat.com>
Subject: Re: [PATCH 1/1] libnvme: TLS PSK derivation fixes
Message-ID: <3fc1b734-263e-4580-83f8-6852e72f198d@flourine.local>
References: <20250721021718.1159879-1-cleech@redhat.com>
 <20250721021718.1159879-2-cleech@redhat.com>
 <d8f4ed91-3fcb-45b9-b4d6-900382eb4ae7@suse.de>
 <aH5dbhXOS8h9gxzX@cleech-thinkpadt14sgen2i.rmtusor.csb>
 <3c3c3194-7275-4a77-9397-4c159458f2c5@suse.de>
 <aIPINwQZNxk_7FZs@cleech-thinkpadt14sgen2i.rmtusor.csb>
 <df8bfa36-c1a9-4398-8246-5bc31991b8c9@suse.de>
 <aJrEAia9jVk17y-j@my-developer-toolbox-latest>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJrEAia9jVk17y-j@my-developer-toolbox-latest>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,flourine.local:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_011053_921936_3F76E192 
X-CRM114-Status: GOOD (  12.16  )
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

On Mon, Aug 11, 2025 at 09:33:06PM -0700, Chris Leech wrote:
> If we don't have a resolution by then, maybe this is something we can
> resolve at ALPSS.
> 
> [1] Side note; with nvme_fabrics_cfg _not_ being allocated through
> libnvme, I don't see how the various additions there can be ABI safe. It
> looks to me like this struct alone broke ABI in libnvme 1.4, 1.8, 1.9,
> and 1.11.

I know and I was hopping it wouldn't cause troubles... nvme_fabrics_cfg
is a bit of a problem. I was planing to address this for v2.

