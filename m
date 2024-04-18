Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC141C4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Apr 2024 12:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oSSUZe9vEtPcyjlEe9DygPINi9bJ+OBmBEg6+UFeJnA=; b=xdHAy13xL44iT58b5p2q0qawEe
	K4rrBlhiSa7HafbC8Ic1Bcu4GneT4Po7I4M7zJ3Mw9/iNFhuRlK6Mv6ibFIwwLnYXfHTxcmU6UoYc
	dmQXCCHqv4qewEhpJvSP/wTtPy3OGnUjk5+Qbkiy/pPPfFWNls1kb9rIHWtnDLO/oVhBBKAZrP4l8
	/Kt5hM08DyGJ9RmqQzbfRbrTpI2Sv/SEwO8CsCYkU7IrP5M/t5Wb1gLGlL8hMJNEUpQkUg0IEqQvh
	e/e0KhYuZgQ/z4morZnxjX2FOljZM8onglM1T1gJyXFOG15K/9pP0s+eX7D2Bu/siL9c0qEVcn2b1
	E7XO33AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxQVX-000000026v8-1ngT;
	Thu, 18 Apr 2024 12:04:51 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxQVS-000000026uI-2iM5
	for linux-nvme@lists.infradead.org;
	Thu, 18 Apr 2024 12:04:49 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9AFBE34EA6;
	Thu, 18 Apr 2024 12:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713441884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oSSUZe9vEtPcyjlEe9DygPINi9bJ+OBmBEg6+UFeJnA=;
	b=wPOJR/UgFPlvwUPdn6TOKP/2yxYO7KsC0nQ6jXZwULvhIykZ9nvGZ7zInGuWdlq05UfRZo
	u9N2pC6OhAw9o0dgls/MYy8246ahFqw1URNBe8RvevP3z/IWWS3X33+JQCD/EewDcdQBGj
	6X9cK5eJUT1XgCq4QvN03QELRK1ichg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713441884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oSSUZe9vEtPcyjlEe9DygPINi9bJ+OBmBEg6+UFeJnA=;
	b=n16+hIYiSH92o6cNrJL3azL3K57dvUqWu2+a16/Lvkl/CUDyxCezMGaTMa3dfjThS3qWoe
	uM5TAQ5XqMp/ZcDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="wPOJR/Ug";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=n16+hIYi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713441884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oSSUZe9vEtPcyjlEe9DygPINi9bJ+OBmBEg6+UFeJnA=;
	b=wPOJR/UgFPlvwUPdn6TOKP/2yxYO7KsC0nQ6jXZwULvhIykZ9nvGZ7zInGuWdlq05UfRZo
	u9N2pC6OhAw9o0dgls/MYy8246ahFqw1URNBe8RvevP3z/IWWS3X33+JQCD/EewDcdQBGj
	6X9cK5eJUT1XgCq4QvN03QELRK1ichg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713441884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oSSUZe9vEtPcyjlEe9DygPINi9bJ+OBmBEg6+UFeJnA=;
	b=n16+hIYiSH92o6cNrJL3azL3K57dvUqWu2+a16/Lvkl/CUDyxCezMGaTMa3dfjThS3qWoe
	uM5TAQ5XqMp/ZcDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86EDA13687;
	Thu, 18 Apr 2024 12:04:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tiFDH1wMIWbXbwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 18 Apr 2024 12:04:44 +0000
Date: Thu, 18 Apr 2024 14:04:43 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>, Tomasz Zawadzki <tomasz.zawadzki@intel.com>, 
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-cli spdk plugin
Message-ID: <dt4i42she4qbl7wuvqtvzswtszc3vj6hawklsgd5zfquvaedyf@nfyoswrl3br3>
References: <xulnfwru3jfl2nooq27yym7nx3cdpxqslzqz5nvwnkymncapnt@pzascju2tmvf>
 <20240417142610.GA31809@lst.de>
 <7a926cbb-51f9-4e03-b737-b4434b1270dd@kernel.dk>
 <4f80a818-0e3e-48fd-a28d-aeaf11491253@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f80a818-0e3e-48fd-a28d-aeaf11491253@grimberg.me>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9AFBE34EA6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_050446_954423_4664B075 
X-CRM114-Status: GOOD (  21.08  )
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

On Thu, Apr 18, 2024 at 12:22:56PM +0300, Sagi Grimberg wrote:
> > > І don't think nvme-cli should deal with anything that is not driven
> > > by the kernel nvme driver.
> > Exactly, why on earth would we care about spdk at all in the first
> > place, nvme-cli or not.
>
> As long as it does not introduce a maintenance overhead I don't particularly
> care. My suggestion was simply to make nvme-cli operate on a path-prefix,
> which is a very minor change. One can even argue that its justified for a
> container
> bind mounts (although I've never seen someone bind mount to targets other
> than /sys and /dev ...)

FWIW, libnvme is already able to read from any prefix. This is feature
used in the unit tests. So getting the library to read also from a
'well-known' other path shouldn't be to hard to get working.

I don't mind to work on this or maintain this part.

> In any event, if the spdk folks can make their devices interop with
> nvme-cli, I personally
> am not strictly against it if it doesn't require a burden on nvme-cli.

Same here. I don't mind the plugin as such though would prefer if spdk
would also mimic the sysfs interface. My original question was if we
insist that spdk is providing a sysfs interface. If the general
consensus is, we don't really care about it, then I don't mind adding it
as plugin. A plugin is easily removed if things go south.

