Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7B0C021AD
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2025 08:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z3Y/31AEQgxstuZ0UZ278NeUsHwU5UxgxRZ8S/efaBA=; b=FTN6OMsAA/8MVEM1N3C8vJMT2O
	yROm+Mj2LWdfrHtifu5HJt6C6ut3iBKtQC6mmz6WwOAhRUGMcqkJVZYRzwKPqexZzEn/wK35Sy42P
	3MzWhPsXoFjs9BLJj9Iatnp1YIewQnMdZ8S1TLiTwue6BOSBHl12NJZVaV2Y5jks/Fq/uCcO4nhyc
	EB9460Spa9gDu9llgrrSEuoTUWG3daLwKCVElVHqoOiWcFkShhxTBSlARLxj8QwuYmAppBdAe9cAj
	8gwWEwXSgQTHsuQDAjl5TMgJ3MDMiB90j0gY4p0OvnkIcbm07WKxImajMibyJF1vHwcnZEXsGKtDa
	B7M1jIzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tl1UN-0000000HGgP-14cW;
	Thu, 20 Feb 2025 08:00:55 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tl1UJ-0000000HGfi-3cz0
	for linux-nvme@lists.infradead.org;
	Thu, 20 Feb 2025 08:00:53 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4CDFC210FF;
	Thu, 20 Feb 2025 08:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740038448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3Y/31AEQgxstuZ0UZ278NeUsHwU5UxgxRZ8S/efaBA=;
	b=n57tXNTW2qNlqOGlth76nN9gVsZzl1YZZ95vIkWUItc00WuDW1uYzdx1cEzKgORXoDmzhM
	mDap7BAOwxnI7SpO+8whYxAlkdPb3mot2MG2gefY6McSS50oLtwgQ5ianTqko1AAtcISwJ
	OvHw6Zpsg7PHwcy5oRpmV+fu1f1aLTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740038448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3Y/31AEQgxstuZ0UZ278NeUsHwU5UxgxRZ8S/efaBA=;
	b=tyNXfKUEuZgByB0DccOcsQfdABmi+BTe1PNlAzA5w1jvzp4DVgx7IWJ+v6HP1xgOB6vjg0
	zzNTIJcxsnMYoeAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cTawJ26l;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=V5afU3kx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740038447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3Y/31AEQgxstuZ0UZ278NeUsHwU5UxgxRZ8S/efaBA=;
	b=cTawJ26lCWq8AkcA+TuYSbYZtn3CYNIBG2xz4mKI3ggr16mJuutX7KPI5vQR2OaS7RaZ6u
	3ZMXVR5V7zhRPI2WgrBBcKQuNPQ8ZlIV7uak2IR72KxgibQsigUbgWji+cCSIcaBjNsIhm
	NYrbGy8dVLSD4L5qPsLX6TVjraXwN6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740038447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3Y/31AEQgxstuZ0UZ278NeUsHwU5UxgxRZ8S/efaBA=;
	b=V5afU3kxqXFTdbG+Z5mDvdmoBlbjccG0bxgb2ATDVic7VUnMnSMwn0Ul12m22vO0deayrf
	vNvU1sLcycXqhwAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DE3E13301;
	Thu, 20 Feb 2025 08:00:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /xoeDi/htmekVAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 20 Feb 2025 08:00:47 +0000
Date: Thu, 20 Feb 2025 09:00:46 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, 
	Hannes Reinecke <hare@suse.de>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] nvme-fc: fix schedule in atomic context
Message-ID: <16476728-c964-4912-983e-446a44004314@flourine.local>
References: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
X-Rspamd-Queue-Id: 4CDFC210FF
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_000052_045189_85FA12AC 
X-CRM114-Status: GOOD (  20.69  )
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

On Fri, Feb 14, 2025 at 09:02:02AM +0100, Daniel Wagner wrote:
> Shinichiro reported [1] the recent change in the nvme-fc setup path [2]
> introduced a bug. I didn't spot the schedule call in
> nvme_change_ctrl_state.
> 
> It turns out the locking is not necessary if we make the state machine a
> bit more restrictive and only allow entering the LIVE state from
> CONNECTING. If we do this, it's possible to ensure we either enter LIVE
> only if there was no connection loss event. Also the connection loss
> event handler should always trigger the reset handler to avoid a
> read-write race on the state machine state variable.
> 
> I've tried to replicate the original problem once again and wrote a new
> blktest which tries to trigger the race condition. I let it run a for a
> while and nothing broke, but I can't be sure it is really gone. The rest
> of the blktests also passed. Unfortunatly, the test box with FC hardware
> is currently not working, so I can't test this with real hardware.
> 
> [1] https://lore.kernel.org/all/denqwui6sl5erqmz2gvrwueyxakl5txzbbiu3fgebryzrfxunm@iwxuthct377m/
> [2] https://lore.kernel.org/all/20250109-nvme-fc-handle-com-lost-v4-3-fe5cae17b492@kernel.org/

ping

