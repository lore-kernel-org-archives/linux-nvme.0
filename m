Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A9DC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Dec 2023 09:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8LqHwD4UGn1zZYNa5Woz1k2VMDd8pQo3bwLIR8Mlgw0=; b=r2HwjVoxjKdCQq2LE9ZsW/aLXu
	lXSElXbZE52gtQuG8P9BJCRWjHExv0VmYdtCzCn9/nLRS9B23mgjIvHRJRBQHmTktrmA0DFUgys72
	CcLfxzeazlfwvq06iDPqUHE3M4BLGKtD1hfQKPwcgfRAVVUofT6DQw4AynX8EtiIknY1nqT5EXC16
	PPgLDE13wRF+DCrUlCVtoMfc68PDpGdOdd7B66ucOxcv9ZupCx71vv/zdop64dOWKJkBcSo3m+FZl
	xAm7dIkHPyxtHq4ORch87Xs60174ALTyAtWMtMOaQrF4/M/a15oS/S10IQUz+N7OgTzIZlzKdeqXz
	SQWmDPqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDi6I-00HLqY-0N;
	Thu, 14 Dec 2023 09:33:50 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDi6F-00HLps-17
	for linux-nvme@lists.infradead.org;
	Thu, 14 Dec 2023 09:33:49 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EEA55220E0;
	Thu, 14 Dec 2023 09:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702546423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8LqHwD4UGn1zZYNa5Woz1k2VMDd8pQo3bwLIR8Mlgw0=;
	b=KiyCg9T6jGKbZVGUnw7BORbHd6Z0pp2GszcyINcAEI+B4KSglvg7qvLiTqrF8ahMzUl6Rg
	N+WF9j86ZO5PsJb4ovvO6xNwDD8ekrm3WcRrtT6pkRyn+3m98DTheFVeP8jlJlSAM8+xp3
	WZz1KJxXeh6+t+8WUIFzjxBj+8tMmWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702546423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8LqHwD4UGn1zZYNa5Woz1k2VMDd8pQo3bwLIR8Mlgw0=;
	b=fkjkBDFBg5ZewdPz8vlQ2a4obfMBtqOnIjr0gLTCSBWKgDl0pDyebDt4A+XWs2O5QfPtxd
	nKCfqOq1iAega/Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702546423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8LqHwD4UGn1zZYNa5Woz1k2VMDd8pQo3bwLIR8Mlgw0=;
	b=KiyCg9T6jGKbZVGUnw7BORbHd6Z0pp2GszcyINcAEI+B4KSglvg7qvLiTqrF8ahMzUl6Rg
	N+WF9j86ZO5PsJb4ovvO6xNwDD8ekrm3WcRrtT6pkRyn+3m98DTheFVeP8jlJlSAM8+xp3
	WZz1KJxXeh6+t+8WUIFzjxBj+8tMmWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702546423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8LqHwD4UGn1zZYNa5Woz1k2VMDd8pQo3bwLIR8Mlgw0=;
	b=fkjkBDFBg5ZewdPz8vlQ2a4obfMBtqOnIjr0gLTCSBWKgDl0pDyebDt4A+XWs2O5QfPtxd
	nKCfqOq1iAega/Dg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DEA68138F2;
	Thu, 14 Dec 2023 09:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id WzWuNfbLemU1PwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 14 Dec 2023 09:33:42 +0000
Date: Thu, 14 Dec 2023 10:31:28 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v5 1/6] nvme: move ns id info to struct nvme_ns_head
Message-ID: <jt7wqbbuk7wh2dxjkkbdxp7afwy5y5yaudz4jg4ucnxbwz3nni@rg7hzchx6qix>
References: <20231208105337.23409-1-dwagner@suse.de>
 <20231208105337.23409-2-dwagner@suse.de>
 <bf20cb2a-0985-467b-842b-6b5fd752f14b@grimberg.me>
 <7ldcd6imhzxhn3wsirhxxyhb75x5iay2p67p2i4qi2euyztc5i@nbjtvyixifqm>
 <20231213153833.GC7301@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213153833.GC7301@lst.de>
X-Spamd-Result: default: False [-11.17 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(0.00)[~all:c];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 DMARC_POLICY_ALLOW(0.00)[suse.de,none];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MX_GOOD(-0.01)[];
	 DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.16)[69.18%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 WHITELIST_DMARC(-7.00)[suse.de:D:+];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EEA55220E0
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KiyCg9T6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fkjkBDFB;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dwagner@suse.de) smtp.mailfrom=dwagner@suse.de
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_013347_547936_FF1BB534 
X-CRM114-Status: GOOD (  19.48  )
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

On Wed, Dec 13, 2023 at 04:38:34PM +0100, Christoph Hellwig wrote:
> On Wed, Dec 13, 2023 at 03:54:25PM +0100, Daniel Wagner wrote:
> > > I think that the whole PI stuff needs to be taken with a bit more
> > > consideration because if not all paths agree on the pi (as we have
> > > hbas with fabrics) we can't just override or do a logical or on
> > > the capabilities/attributes.
> > 
> > So should the PI variables stay in nvme_ns at this point? Or should I
> > add some checks which avoid an override and warn in this case?
> 
> Didn't we merge the patch from max to require uniform PI setups
> for all controllers that we're using in a multipath setup?  I'll
> check the code after finishing a few more things if no one remembers
> offhand.

The newest discussion on this topic I found was this:

https://lore.kernel.org/linux-nvme/ec66d848-5246-529a-7050-afca3d1d981f@nvidia.com/

