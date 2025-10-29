Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E4CCCF9EB
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 09:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mMzMkIhr2csP1RAIcfnMJjjjIR8xekvGgOWHT2VTmjo=; b=aiTGHVQK0yWv7+RDYHL5omRYO7
	3DGr2/a8KQsqZzJbqShoDiMn30jRrIw/aiDnFHhXJfYtLIaVEaJ0TYQRTkBqDN4UHRXDjJJlP+wHi
	mlBQgrCt1ofTSKv75mtsAFdgulSWUIvLg/dU2tlaeBxGMa7OirY8DuiLPvmALextIpQaEPbcNcDwU
	bgvCR3E0DLkP9dUVaD0VhZ8xtWqgbPc5yg4J0qLxzIpDLz/eaOWs5xcKlF5hMj063I7+HQXJ2ul+7
	P7XMaucw4bYut37m9sbl7H32/uadBnM0x526pRcXbm2oW/BnyBEc1xauVD/gJchgrZQtYnzNpFAeR
	ijMgcrfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE2kk-00000000YRz-33Po;
	Wed, 29 Oct 2025 09:46:02 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE2ki-00000000YP6-1hxo
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 09:46:01 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EEEA022E01;
	Wed, 29 Oct 2025 09:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761731158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mMzMkIhr2csP1RAIcfnMJjjjIR8xekvGgOWHT2VTmjo=;
	b=vMntPZn0kvJk+1egHN9oCha3u5+he6hkhymqP8LCw30AiCHIEolKmPTQ3q9tbsYNo9j6WV
	xqSLAgWnSIhvaBXeU5oL1jkf73DAlWOfkUakHvBBJmsM546ODua624OvoQps9Pxn7ERmxM
	pzfBfNINEnvmk/NDwgFT0LdMeuPdMKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761731158;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mMzMkIhr2csP1RAIcfnMJjjjIR8xekvGgOWHT2VTmjo=;
	b=TzsomlI/4e8f5SYnzAOHDgRQm47ZAuC1s36wOAmMi0Dum5sLaHLAmcYj4UCs0qT0/Tdyfq
	bM5LRT5tPPYh+eAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zU49dr6I;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=B4YEExPV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761731157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mMzMkIhr2csP1RAIcfnMJjjjIR8xekvGgOWHT2VTmjo=;
	b=zU49dr6I5ttvo3n8Gj6G5OOH1pjaq2xdFtmvDyBWIl3s0fvtNIju3SoH0rpEJSE0oWJlhI
	RJ/q+pl52K0w+Y6VvFfwZ6UgoGT6/mtWgczLghewZD80BIJU99C3m1nlaSczfb6/K90GNn
	/ma94LWfoagI8+e7ipRV2Nv+I3MFYf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761731157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mMzMkIhr2csP1RAIcfnMJjjjIR8xekvGgOWHT2VTmjo=;
	b=B4YEExPVJk7pSLH2KYJOFNKkLJ8K+gzFwh0AFtuteTGksW31MWu3N7W2uSqGX7FyBLSwjG
	PljVrH3QFw9enpAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF61F1396A;
	Wed, 29 Oct 2025 09:45:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fv2RNVXiAWmdEwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 29 Oct 2025 09:45:57 +0000
Date: Wed, 29 Oct 2025 10:45:57 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>, 
	John Meneghini <jmeneghi@redhat.com>, Bryan Gurney <bgurney@redhat.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: drop bogus nid quirk for multipath devices which
 passed id test
Message-ID: <bd91a6c1-cefc-43e2-8dd8-48b7ea241ded@flourine.local>
References: <20251028-bogus-id-check-v1-1-c087a98b5466@kernel.org>
 <20251029074403.GA30412@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029074403.GA30412@lst.de>
X-Rspamd-Queue-Id: EEEA022E01
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_024600_602442_1E7836B8 
X-CRM114-Status: GOOD (  14.42  )
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

On Wed, Oct 29, 2025 at 08:44:03AM +0100, Christoph Hellwig wrote:
> But more imporantly dropping the quirk for multipath devices is
> fundamentally the wrong thing to do, as we really need proper IDs for
> multipathing. So just add another entry for the Dell device using
> the dell subvendor/subdevice id that does not have the quirk.

The problem it is not possible to distinguish between the two devices
based on subvendor/subdevice ids. I've tried to find some way to keep
those two devices apart, serial numbers but I don't think there is
something usable. Thus the idea to rely our own sanity checks and
enable the feature if these pass. 

