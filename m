Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D759CC25B74
	for <linux-nvme@archiver.kernel.org>; Mon, 27 May 2024 05:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yL3OkjSn/joP5CTfrw8FswmbUW8dPja+JhBVwn2WA1Y=; b=M0I3iJpSEqCeJ1OYL4jrdGj4pz
	zg09drkqGoBVnY0JcirPE/0f8JAodSBsXKazK37uNmxUCuScIN0gCfWm2VFcjR2d1pvM8XTn53w1G
	azvpCneGi3VPQf1SCoahjp2AjVBL1Y+PUpYVwMAnt6FuYNXv8+PvlRDRWgK5CpuWJSTmjgh4hfI1K
	qw5exPK/eorTf/RMZkol6vkRntHgH84yXirX62PauEek/omGpLJq2AfXOWq4cDgZpGs60XSJPhwck
	bqHp7whBosa2ieaUN1doLFJY7iJR9T+nSpEVzb4KfSDiCXOHpX6vXw727TJWtJja+ZzxrxFpU+Zwa
	569fYajQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBSoE-0000000Dpem-3q7J;
	Mon, 27 May 2024 05:22:10 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBSoA-0000000Dpdk-3j7q
	for linux-nvme@lists.infradead.org;
	Mon, 27 May 2024 05:22:09 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8F45321C50;
	Mon, 27 May 2024 05:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716787325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yL3OkjSn/joP5CTfrw8FswmbUW8dPja+JhBVwn2WA1Y=;
	b=zhyue7kmcTTiHcKHAHozBPRS8NTtx47wFFK4W94/Co3k6qRX+HSVBBD2nGvcATAhE9P9gz
	dIhEP/j2/Mgi1vKUnezlvhx2vlTlHhL2Tm724Dh3tqviBdtj0wgQ90SK8rq8TEsO2G36aL
	XkaD2QRpr+GVwD630gK76P7gIgG3YcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716787325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yL3OkjSn/joP5CTfrw8FswmbUW8dPja+JhBVwn2WA1Y=;
	b=BA4VVN7wAt/MC04GumajUuuPn0eKoPUXSpOyfeszH/BIno30wFY99pDwih+S9uszxyykSD
	unDSJgiCRVyCXPBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716787325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yL3OkjSn/joP5CTfrw8FswmbUW8dPja+JhBVwn2WA1Y=;
	b=zhyue7kmcTTiHcKHAHozBPRS8NTtx47wFFK4W94/Co3k6qRX+HSVBBD2nGvcATAhE9P9gz
	dIhEP/j2/Mgi1vKUnezlvhx2vlTlHhL2Tm724Dh3tqviBdtj0wgQ90SK8rq8TEsO2G36aL
	XkaD2QRpr+GVwD630gK76P7gIgG3YcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716787325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yL3OkjSn/joP5CTfrw8FswmbUW8dPja+JhBVwn2WA1Y=;
	b=BA4VVN7wAt/MC04GumajUuuPn0eKoPUXSpOyfeszH/BIno30wFY99pDwih+S9uszxyykSD
	unDSJgiCRVyCXPBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 705B313A6B;
	Mon, 27 May 2024 05:22:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t+G9GX0YVGY8WQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 27 May 2024 05:22:05 +0000
Date: Mon, 27 May 2024 07:22:04 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	Hannes Reinecke <hare@suse.de>, Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: blktests nvme/042 nvme/043 fail ?
Message-ID: <zew5dsxhh4l5qbfzcdfiggtpqqteutp6mos4fymyblvxaimsmy@boybcks5hw27>
References: <64656570-645e-4b82-8ef6-06cb36916f5f@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64656570-645e-4b82-8ef6-06cb36916f5f@grimberg.me>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	SUBJECT_ENDS_QUESTION(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240526_222207_212519_0278AFD3 
X-CRM114-Status: UNSURE (   7.95  )
X-CRM114-Notice: Please train this message.
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

On Sun, May 26, 2024 at 01:17:25PM GMT, Sagi Grimberg wrote:
> Is anyone else seeing these errors?

No, I haven't seen these yet. Which branch is this, nvme-6.10 or master?
I'll try to reproduce it.

