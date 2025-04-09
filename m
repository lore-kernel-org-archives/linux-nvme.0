Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98060C36002
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 11:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n9vsSoBRvFz6cDO+x236b9qNdiIFDos4QuXLUYcIcr4=; b=yKIYr/TIEPQEeQB91YT6mjU4c4
	hXDp5PtScgAr6l/pEQ2Oq00snwxMPcLQLNvhVX+61XQcyDZFzeuBlLricLiDaJdwcbLqpcghqNjf5
	nBVoeGOzvQtzTi/CtbtA4HCleiVL8dQPKIPH5/msjKEkduBu8o1PL2ChjU76rzRvy/iv2xG7bR6CA
	oHeTCwx/RbA0xYuTjvt3nU8nxHYnBoUnIJ4JlUqx7vWLkJMpkTi2OO8wGEsOGHsKfi9wZOgmCPMY0
	g5RmO3BCmyYWqiJuYjt95dkx1shsqDUZ92TpDYSTJtC2eHI9I9zTCi4/tNGQsqOwQEd/iDociLb8z
	zkDO7L+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2TjI-000000071By-0FNE;
	Wed, 09 Apr 2025 11:36:28 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2TjF-000000071BP-3OWe
	for linux-nvme@lists.infradead.org;
	Wed, 09 Apr 2025 11:36:27 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A5341F38D;
	Wed,  9 Apr 2025 11:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744198582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n9vsSoBRvFz6cDO+x236b9qNdiIFDos4QuXLUYcIcr4=;
	b=KzogP8tebc7wf9A7yXNU9RaGoVDlqRkl4AsbS6vYjSd/CLDcH2Q4pFVZYlzKHL8aihlCuP
	datp1h4VEYSi/lc8oZxhsyN+WAUbI3wCvajAnTfyzb5kuJQkZQ2UbxDeTw8aLIfO1YzEXz
	4sE7Wt+3e0Qs1YoYlO58G+Sv8K0RbNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744198582;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n9vsSoBRvFz6cDO+x236b9qNdiIFDos4QuXLUYcIcr4=;
	b=zhXRD+nPD3mZaXFhxP0tJ9FEYUqbPcG+o65SMS387Bkt2S7EJFP4OZvHnU0T4pKud965Z4
	LFNN+v+bDjDIcmAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KzogP8te;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zhXRD+nP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744198582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n9vsSoBRvFz6cDO+x236b9qNdiIFDos4QuXLUYcIcr4=;
	b=KzogP8tebc7wf9A7yXNU9RaGoVDlqRkl4AsbS6vYjSd/CLDcH2Q4pFVZYlzKHL8aihlCuP
	datp1h4VEYSi/lc8oZxhsyN+WAUbI3wCvajAnTfyzb5kuJQkZQ2UbxDeTw8aLIfO1YzEXz
	4sE7Wt+3e0Qs1YoYlO58G+Sv8K0RbNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744198582;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n9vsSoBRvFz6cDO+x236b9qNdiIFDos4QuXLUYcIcr4=;
	b=zhXRD+nPD3mZaXFhxP0tJ9FEYUqbPcG+o65SMS387Bkt2S7EJFP4OZvHnU0T4pKud965Z4
	LFNN+v+bDjDIcmAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77AF013691;
	Wed,  9 Apr 2025 11:36:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l76YHLZb9me6GgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 09 Apr 2025 11:36:22 +0000
Date: Wed, 9 Apr 2025 13:36:18 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	hare@kernel.org, kbusch@kernel.org, gjoyce@ibm.com
Subject: Re: [PATCH 3/3] tree: add attribute numa_nodes for NVMe path object
Message-ID: <1609c2ac-b75c-4541-b46d-569a5031bd98@flourine.local>
References: <20250405130255.448345-1-nilay@linux.ibm.com>
 <20250405130255.448345-4-nilay@linux.ibm.com>
 <1f88256a-f36f-4a34-96e2-53d2b6da7764@flourine.local>
 <4db3b302-3a07-4e82-aa5c-c63c55de2c6f@linux.ibm.com>
 <89bce70c-8eac-4dee-a5ca-4aa52fa5687f@flourine.local>
 <fd2407c9-e180-4785-a71f-944ea40edfe3@linux.ibm.com>
 <9b957880-ec3b-4b22-a923-f5b91dee9b76@flourine.local>
 <72649ea2-35c8-4c97-a3af-3f1c38bf7303@suse.de>
 <cb240c7d-ce29-4c7d-a205-13466d5b749f@flourine.local>
 <50c27880-70e6-49c6-a1d4-6be1eb272c38@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c27880-70e6-49c6-a1d4-6be1eb272c38@linux.ibm.com>
X-Rspamd-Queue-Id: 8A5341F38D
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_043626_009259_26A001A8 
X-CRM114-Status: GOOD (  10.45  )
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

On Wed, Apr 09, 2025 at 03:08:40PM +0530, Nilay Shroff wrote:
> Makes sense. For the this patchset, I will spin a new series and send
> after incorporating comments. We shall address cached vs non-cached 
> version of APIs in another series (probably when we implement nvme
> top).

Okay.

> However, I like the idea of Hannes to only have non-cached APIs. May be, 
> we should be able to convert existing cached APIs to non-cached APIs 
> (or limit to only those APIs required for nvme top) without any side
> effect.

I expect some more changes due to the 'nvme top' command, but as you
suggest, let's first get this series right.

