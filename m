Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A758ECF11FC
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2024 15:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MeWOxdYhWBqRDdWRkA0HNTcqby3S9Ndz/tGgBkoI4+E=; b=3k/3tSar+K9htXsgqTgvng4HIm
	0/1juLOugLtwgnxj/xPxL6rftOIESaeWkzpYb8riJmiS4xxFkkj+FAwL1DEu/BUPcXHr932CE6T3S
	4i96xA4xPvnb5qrbemb01ZFr56Hu4N8qdNii954JlYtHW6e/Xu5BFHRDNXaaVlnLpnb4G0bn7zly+
	cBys0AtzLiAKo4HNjRTWKjwLqnhmazD+sdBQSKJCdwOVK9ybyYRRyDOSk3aTRN8cbL0d4ImA9R+6U
	K5XxZ8qoSig/v2FSov+UOUYMmMWqke/UEqQX92KjdA7zUA4hliAxzAPaDCSfcxuS0OTUrG0BJNw8i
	/YjEVYlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syuwA-0000000DIJf-22Ko;
	Thu, 10 Oct 2024 15:18:46 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syuSH-0000000DBV8-35M5
	for linux-nvme@lists.infradead.org;
	Thu, 10 Oct 2024 14:47:56 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4CCFD21D12;
	Thu, 10 Oct 2024 14:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728571670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MeWOxdYhWBqRDdWRkA0HNTcqby3S9Ndz/tGgBkoI4+E=;
	b=fjxkuoVdu4wisgWh/UV7VjjPoszqpwii1aaRElQAoHPuSWhNVLJiK8APUn6IlXyTehxUEI
	eHebpk6HhghJAXmAbPnhD9t/qc7YBt5NNi/cDYP/9TyX7CVPqtI49hjbwGTUDtTdGjuL14
	fczsaOuAUciqRp6qv03tac4VMFetRVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728571670;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MeWOxdYhWBqRDdWRkA0HNTcqby3S9Ndz/tGgBkoI4+E=;
	b=6e8BIXC8UToX786zeAxjfaQdHEeP9D4XGRsq9pzt6iU9HD+kan85xOocaNCt/V99Vdow5d
	zxaDetQYjQozCTDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fjxkuoVd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6e8BIXC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728571670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MeWOxdYhWBqRDdWRkA0HNTcqby3S9Ndz/tGgBkoI4+E=;
	b=fjxkuoVdu4wisgWh/UV7VjjPoszqpwii1aaRElQAoHPuSWhNVLJiK8APUn6IlXyTehxUEI
	eHebpk6HhghJAXmAbPnhD9t/qc7YBt5NNi/cDYP/9TyX7CVPqtI49hjbwGTUDtTdGjuL14
	fczsaOuAUciqRp6qv03tac4VMFetRVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728571670;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MeWOxdYhWBqRDdWRkA0HNTcqby3S9Ndz/tGgBkoI4+E=;
	b=6e8BIXC8UToX786zeAxjfaQdHEeP9D4XGRsq9pzt6iU9HD+kan85xOocaNCt/V99Vdow5d
	zxaDetQYjQozCTDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27FB01370C;
	Thu, 10 Oct 2024 14:47:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ygtkBxbpB2cobgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 10 Oct 2024 14:47:50 +0000
Date: Thu, 10 Oct 2024 16:47:49 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Matias =?utf-8?B?QmrDuHJsaW5n?= <m@bjorling.me>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, dlemoal@kernel.org, 
	cassel@kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matias =?utf-8?B?QmrDuHJsaW5n?= <matias.bjorling@wdc.com>
Subject: Re: [PATCH 1/2] nvme: make independent ns identify default
Message-ID: <d98d0311-b5a8-46f3-bdc2-6265ed00fb2e@flourine.local>
References: <20241008145503.987195-1-m@bjorling.me>
 <20241008145503.987195-2-m@bjorling.me>
 <20241009074611.GB16181@lst.de>
 <0076eb5e-6816-490e-abaf-a0a4a25a2915@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0076eb5e-6816-490e-abaf-a0a4a25a2915@bjorling.me>
X-Rspamd-Queue-Id: 4CCFD21D12
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
X-CRM114-CacheID: sfid-20241010_074753_956516_95AEDD61 
X-CRM114-Status: GOOD (  17.28  )
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

On Wed, Oct 09, 2024 at 03:19:59PM GMT, Matias Bjørling wrote:
> On 09-10-2024 09:46, Christoph Hellwig wrote:
> > On Tue, Oct 08, 2024 at 04:55:02PM +0200, Matias Bjørling wrote:
> > > However, the independent namespace data structure
> > > is mandatory for devices that implement features from the 2.0+
> > > specification. Therefore, we can check this data structure first. If
> > > unavailable, retrieve the generic attributes from the NVM command set
> > > identify namespace data structure.
> > 
> > I'm not a huge fan of this.  For pre-2.0 controllers this means
> > we'll now send a command that will fail most of them time.  And for
> > all the cheap low-end consumer device I'm actually worried that they'll
> > get it wrong and break something.
> > 
> 
> It's a good point. Damien, Keith, and I were debating it during ALPSS. They
> preferred the "send command and see if it fails" approach over writing
> specific conditions where it would apply. Note that Keith did suggest to
> avoid the command on 1.0 and 1.1 devices, and they were known to fail with
> unsupported CNS ids.

FWIW, there are some devices out there which will log these attempts and
spam their error logs. There were plenty of reports against nvme-cli
when nvme-cli issued a command which could fail.

