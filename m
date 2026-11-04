Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFFD606A31B
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3OzdTr/f;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lIqW8eSG;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=z0YdSJGh;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lIqW8eSG;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=z0YdSJGh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zs89ZAnRU7u7fNPI9JMnf/JQdJIJ8e7hYCupNJEz1H0=; b=3OzdTr/fVxkFbnEJ4mWmmAZzZn
	YJFkfJx+bMQSAALdEdNn1GfScwRD+DXeoxS6UTmfB8S9HbWPP8/gqi6FgV7ZHhEIBoOWro5MhkIUZ
	iy4YZUUKwevcElWda5RHuW76hcuqu/OPNkCOQ3JVoGrBAu4Yl6PUVHm9b32QJpyEM0LRH4syecyWn
	L5L1PsB6e2f6w0n/7r0MbSDIgpJ/1xBA/mWlb7Ugj5eo4mTgoEJvmUlG0U6ASx4K67qZ9PZw/05hg
	OaVE2q40FbSzKfGXFBD/yR7poHHhOwXAXzf5W5EJllEYeVdodJWfWDu873+dB6BZnytfXb9JyKTYh
	PcItnTig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOY8j-00000004z60-254i;
	Wed, 04 Nov 2026 10:22:45 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOY8h-00000004z4n-1Npr
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 10:22:44 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1F34D21FBC;
	Wed,  4 Nov 2026 10:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793787760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zs89ZAnRU7u7fNPI9JMnf/JQdJIJ8e7hYCupNJEz1H0=;
	b=lIqW8eSGG/RrurF3PqsLcLYd4Y/cWy3HNf8HnX1ftX3deKcgYcx0KrKhQxwetL/2ntI9ul
	xa5FxpVd2XC1eyel3TRjSDR1a+Gr6s/eOhQUkEW96/rTq8SvTrx47J06IlyDr5yzYcpBga
	/whwKkFM+FaB38G4wTyDyNPSjMFtsGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793787760;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zs89ZAnRU7u7fNPI9JMnf/JQdJIJ8e7hYCupNJEz1H0=;
	b=z0YdSJGhEoQUayOwoADqTrcCgKbD3U6MCsJNIFs7WZPTNzS9OHslckXy5cgThSao7YGbX4
	33dpTRUc1ewtDZCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793787760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zs89ZAnRU7u7fNPI9JMnf/JQdJIJ8e7hYCupNJEz1H0=;
	b=lIqW8eSGG/RrurF3PqsLcLYd4Y/cWy3HNf8HnX1ftX3deKcgYcx0KrKhQxwetL/2ntI9ul
	xa5FxpVd2XC1eyel3TRjSDR1a+Gr6s/eOhQUkEW96/rTq8SvTrx47J06IlyDr5yzYcpBga
	/whwKkFM+FaB38G4wTyDyNPSjMFtsGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793787760;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zs89ZAnRU7u7fNPI9JMnf/JQdJIJ8e7hYCupNJEz1H0=;
	b=z0YdSJGhEoQUayOwoADqTrcCgKbD3U6MCsJNIFs7WZPTNzS9OHslckXy5cgThSao7YGbX4
	33dpTRUc1ewtDZCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8503134F0;
	Wed,  4 Nov 2026 10:22:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g0GvJ28H62o+bAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Nov 2026 10:22:39 +0000
Date: Wed, 4 Nov 2026 11:22:34 +0100
From: Daniel Wagner <dwagner@suse.de>
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] blk-mq: use a housekeeping CPU for passthrough
 requests on isolated hctxs
Message-ID: <623dff5b-f2ff-4ab5-a6c7-196f5b203919@flourine.local>
References: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de>
 <sashiko-outbox-195610@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-195610@kernel.org>
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_022243_535821_AA80E794 
X-CRM114-Status: GOOD (  10.54  )
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 03:22:29PM +0000, sashiko-bot@kernel.org wrote:
> Should this check !blk_mq_hctx_has_online_cpu(data.hctx, nr_cpu_ids) (or
> ensure blk_mq_map_swqueue() sets BLK_MQ_S_INACTIVE when an hctx has no
> online CPUs mapped)?

Yes, this is correct. I'll extend the patch and add this to the commit message:

    When all mapped CPUs are offline at queue setup, BLK_MQ_S_INACTIVE is
    not set, as only the CPU offline callback sets it. The
    blk_mq_hctx_has_online_cpu test catches this case. It uses the queue
    map, so it also finds online isolated CPUs.

    When the last mapped CPU goes offline, the CPU offline callback sets
    BLK_MQ_S_INACTIVE while the CPU is still in cpu_online_mask, so
    blk_mq_hctx_has_online_cpu still finds it. The BLK_MQ_S_INACTIVE test
    catches this case.

