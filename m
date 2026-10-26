Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A8C606A32E
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hRd9/d66;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=QjN06VLf;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=EWaScf3V;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=JRAOKct7;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dKKBWg0j
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NRXmX1LQaD4nTvonCMOQXJ6Q4DMR8wpEHC1TVq+oymM=; b=hRd9/d660VvVW2PDullmVsnnOe
	3JG0IbWU6KBhxAXEdZxYeHmf4aKPW4hOp8PcrFHfVaDf5+CJnNbGXIkEUBfnJ8rn+l15Xb4lyG+rl
	jJULwCYHuZ2n1Iqk7VycchG8Szh0sPSEqbGliVUbQvRsLS2IZx/xi/6YldSkV0b6vaYbU9GfAKLib
	OkH2kFLUdhj38bI0PixmG5Ae0fD5AUstU74Ig4Y7WZLitI7g9pCP4Hsewz1yXnTYlbosfGn7RIY0k
	+YBgTyOgN277jUvNTMxBh6XZE3xwAfjg6zpp5gILzc7QuaAGiRKr0lPvthS6VvC5a/Hkgcbp+3Yt+
	ScSC7aFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLIJo-00000002IUy-1K6Q;
	Mon, 26 Oct 2026 10:52:44 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLIJl-00000002ITd-33FE
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 10:52:43 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 63CFC2214B;
	Mon, 26 Oct 2026 10:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793011958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NRXmX1LQaD4nTvonCMOQXJ6Q4DMR8wpEHC1TVq+oymM=;
	b=QjN06VLf57sU4gCbur+qkI3dK3P6wJiv0u+YCvNB24JmpMfJyKDSKS06YH4qpg5ohqgIjQ
	aU3K4pohAFPnt0WVoWQLS/7sAap6gpxBOc+otaKKOdz7iJXUwUTPbFtGqWa0vSBIGISX4Q
	1ppyzNMlfxbuE/xE5pmUDsj2/rinIMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793011958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NRXmX1LQaD4nTvonCMOQXJ6Q4DMR8wpEHC1TVq+oymM=;
	b=EWaScf3V2FMA3RS7dgUWDmZh0Z8WgLUVZIGIitDeHZ4c/YaBUooN/xCxKh8ysFX7lPkAeG
	qz/TMs2WoVzOGrBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793011956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NRXmX1LQaD4nTvonCMOQXJ6Q4DMR8wpEHC1TVq+oymM=;
	b=JRAOKct7/QymLHc4CXIhtJcUYcHu9UVr4JmCcKzdddU/SlU1GG8Bdwgi50TL0NxJpjeYcE
	ETwU9t9zCa40ORocN7wXSXlZrbZdIbGog3w3uXujMBVU9rdToDc4brm72M+0b4Te2pbBkH
	dukb0SnqE3QbP+k3mt9FXBwPPCtGiAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793011956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NRXmX1LQaD4nTvonCMOQXJ6Q4DMR8wpEHC1TVq+oymM=;
	b=dKKBWg0jNv2CtDHwFFWpPRdNfuKsUk17LXiDM562H0RSLpccWADE07UWajhhqseSsZufS6
	AwgX3uaWlvMzKYCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 310C313319;
	Mon, 26 Oct 2026 10:52:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /Y5iA/Qw32oKUAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 26 Oct 2026 10:52:36 +0000
Date: Mon, 26 Oct 2026 11:52:27 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-fc: Tear down the association when the admin queue
 allocation fails
Message-ID: <35b2f2d9-f174-49bc-8d30-34fe145d1d7e@flourine.local>
References: <20261026104456.3672246-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026104456.3672246-1-kanie@linux.alibaba.com>
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,alibaba.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_035241_921159_96FD015F 
X-CRM114-Status: GOOD (  16.84  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 06:44:56PM +0800, Guixin Liu wrote:
> When the initial admin queue allocation fails after a new association
> was created, nvmet_fc_ls_create_association() only drops the
> association reference, which frees the association.  By then the
> association is already on the target port's assoc_list, though, and
> removal from that list only happens in nvmet_fc_delete_target_assoc(),
> which this error path never calls.  The freed association stays on the
> list, where later lookups and the port teardown can access it, and the
> target port reference taken at allocation time leaks.
> 
> A remote host can trigger this reliably with a Create Association LS
> requesting a queue too large to allocate.
> 
> Schedule the regular association teardown instead of dropping the
> reference directly.  The teardown removes the association from the
> list and releases the target port reference before the final reference
> drop frees it.
> 
> Fixes: 0cab4404874f ("nvme-fc: fix a missing queue put in nvmet_fc_ls_create_association")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Looks good to me.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

