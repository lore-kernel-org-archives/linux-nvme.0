Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A69C5478C
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 07:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JKIngBWAuNVnuWkFr7r0tsnBVdmK8D3E8dK1xd7Ori8=; b=ediYVKS1bTvmQ2i93fM1vYAGDf
	Gc2zHm3nz+Qw6wcHWn6t5wOrS6UWpWgXj+xXS/HUWmCfTo0zFFx3ueDrUP/FgO8hVHHkdMcx2TMQW
	WbxqlgCkhSI/VVADETG5e9oTSJSRwn3O4YyTe1ocZ0//GyVxwpf5QKCk1IvSGlh30dEV/mDS+6csy
	zIvs+ZUHNeavdaLLuen9NVFccpVk7OFEbwEFMG0VGTOfHxXlDBfhxK9aStA8pxpdg2V3IwilrU42Y
	oZFqsHUy5NGG3IIRFlLpUbhb0MKkEpEjr+pn1RQCQAMbsPXhs+JDjZquqAvhdru1Z8rXkPDutKLIl
	IW+nDrpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhP7Z-0000000CKit-37cU;
	Tue, 05 Mar 2024 07:21:53 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhP7V-0000000CKhd-1Bl6
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 07:21:52 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7DD414EDA1;
	Tue,  5 Mar 2024 07:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709623307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JKIngBWAuNVnuWkFr7r0tsnBVdmK8D3E8dK1xd7Ori8=;
	b=mcCiQMcNhrVYJcnVTcsqySrWaG3raZmWG5+/UEjdR5mX0F2rE2wXukMPd9DdFTHDQFhKP3
	qKsMeKkYOv8IBo8bOdfrqbpQnC6MDFjb+nyTcqGJ3xz3G++wIjahgYvV58lSTeMdSL5Q2k
	tOHPwiKEvXDf37lFRmp1GzsrRo5zsyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709623307;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JKIngBWAuNVnuWkFr7r0tsnBVdmK8D3E8dK1xd7Ori8=;
	b=MUgZErAb2ovKm/gYWC9KzoqELJwYlBkC9IeBwVJf4ut5QKqlfxsXFE0kRpPyBXWK7raDkr
	h5ZrsXUy/6TKwUDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709623307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JKIngBWAuNVnuWkFr7r0tsnBVdmK8D3E8dK1xd7Ori8=;
	b=mcCiQMcNhrVYJcnVTcsqySrWaG3raZmWG5+/UEjdR5mX0F2rE2wXukMPd9DdFTHDQFhKP3
	qKsMeKkYOv8IBo8bOdfrqbpQnC6MDFjb+nyTcqGJ3xz3G++wIjahgYvV58lSTeMdSL5Q2k
	tOHPwiKEvXDf37lFRmp1GzsrRo5zsyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709623307;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JKIngBWAuNVnuWkFr7r0tsnBVdmK8D3E8dK1xd7Ori8=;
	b=MUgZErAb2ovKm/gYWC9KzoqELJwYlBkC9IeBwVJf4ut5QKqlfxsXFE0kRpPyBXWK7raDkr
	h5ZrsXUy/6TKwUDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B5E813466;
	Tue,  5 Mar 2024 07:21:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id AmfAGAvI5mUASgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 05 Mar 2024 07:21:47 +0000
Date: Tue, 5 Mar 2024 08:21:47 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	James Smart <jsmart2021@gmail.com>, Chao Leng <lengchao@huawei.com>
Subject: Re: Re: [PATCH v2 0/2] nvme-fabrics: short-circuit connect retries
Message-ID: <egdy2bnrot3d25bhljhdpitqumxdy4sdledlcgjgupku6cv7jp@skwlwojhdzct>
References: <20240304161006.19328-1-dwagner@suse.de>
 <ZeX3jMpzFjjjjIKV@kbusch-mbp.mynextlight.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeX3jMpzFjjjjIKV@kbusch-mbp.mynextlight.net>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.54 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.74)[83.96%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[lst.de,grimberg.me,suse.de,lists.infradead.org,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240304_232149_501972_DE66B768 
X-CRM114-Status: GOOD (  15.55  )
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

On Mon, Mar 04, 2024 at 09:32:12AM -0700, Keith Busch wrote:
> On Mon, Mar 04, 2024 at 05:10:04PM +0100, Daniel Wagner wrote:
> > I've picked up Hannes' DNR patches. In short the make the transports behave the
> > same way when the DNR bit set on a re-connect attempt. We had a discussion this
> > topic in the past and if I got this right we all agreed is that the host should
> > honor the DNR bit on a connect attempt [1]
> 
> These look good to me. I think, though, if you're submitting a patch on
> behalf of another, you should append your 'Signed-off-by' tag after the
> author's.

Will do. Yesterday was not my best git day for a while...

