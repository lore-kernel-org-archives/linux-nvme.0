Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEFCD1039A
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 15:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8WZvTDx7v4/rD0qDDUqXOgr/o9cMvYL1RJfXmMPAIoo=; b=HWznIJRkZUdsH/gnmKJH540Lgg
	Hwhf5ssxFMU1sOuOfXTV6Bk9F+rM1cIhthbkcCkd/RQAQMOUNi5IBlIewJ0dwHfelqB0KI8Fh8yjz
	wibLVO1kzf/wFHqMVNtvJFR2Vje3AC4Cdn43jQsUTSMkF6kcetMczgaQItidgwz48OTGAxZq40vLY
	spbKfUf7NiZBwlpA1ansIFl4ICbklKpNZPVRVcYJ1oYUXgAZnzaxVFw9hXNyTO+PalthItec210M3
	T+pZ/wupgSRUshAWIweu7dKP4zCHcedTcctB8hJNTLIGTnmVrbbcMAhbL3ea0T+VIeOCW3ceQDju6
	ipotxZTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Mfk-00000004KbG-3Rr0;
	Fri, 25 Oct 2024 15:56:20 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4MfM-00000004KXb-1xhD
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 15:56:19 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CECB51FB87;
	Fri, 25 Oct 2024 15:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729871755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8WZvTDx7v4/rD0qDDUqXOgr/o9cMvYL1RJfXmMPAIoo=;
	b=vnYyc7IRp8Qc5sZ85VXRjpAIVtxDmo5PgxeJVmD/akLr7hyZ/Y0SxBxRW3GgwD+43e5JbZ
	f44Ck/ArseX3yMbuohqfbb+D1dSJPBjGpqkgoeVMaeezwumDuorsfn31qE4rKystNUAa24
	imO1oDy2m8nypb9GI7+PG+M/Hkv0cXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729871755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8WZvTDx7v4/rD0qDDUqXOgr/o9cMvYL1RJfXmMPAIoo=;
	b=227gvN94S2RGihVcTIgbbxac9IqPrxjmYkIUsseOSNomKqu7O4lTm1B1qG5IOAVT2OXh8/
	Le8owXxAG3HvxsDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ziq+NUa7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bWpVUXEX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729871754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8WZvTDx7v4/rD0qDDUqXOgr/o9cMvYL1RJfXmMPAIoo=;
	b=ziq+NUa74kVUj70tYI+tiAOXNceO/jL5ThW7hFkDpwbNQV/QXdIpVnROidPFqB4axL5maq
	y6Ke2CemLPIXAJ2bobyTxSYTB781R5xpUhyT8Jpv9JSo2jZTbkDmZyv0wrTDWv9uQhG6Ae
	pHaBq9+zc6eiWzSHokjz3fBxe0pwVmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729871754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8WZvTDx7v4/rD0qDDUqXOgr/o9cMvYL1RJfXmMPAIoo=;
	b=bWpVUXEX90spnIEgVFi1P8XeqKXYNGrkyt9LEBLS+Uvu6tnw2Mg6E1GTG33dFIa2h7ix4D
	G+7T785g8nRcFaDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1D78132D3;
	Fri, 25 Oct 2024 15:55:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Kg7vKIq/G2fodgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 25 Oct 2024 15:55:54 +0000
Date: Fri, 25 Oct 2024 17:55:53 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 15/15] nvme, md/001: support only long options
 for _create_nvmet_subsystem()
Message-ID: <5bc766ae-a659-4d3d-85fa-5ce7843c0d2c@flourine.local>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
 <20241024010025.2216242-16-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024010025.2216242-16-shinichiro.kawasaki@wdc.com>
X-Rspamd-Queue-Id: CECB51FB87
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_085556_685208_45C95F08 
X-CRM114-Status: UNSURE (   8.12  )
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

On Thu, Oct 24, 2024 at 10:00:25AM GMT, Shin'ichiro Kawasaki wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Most callers use the default settings anyway, so simplify them
> by using long options for _create_nvmet_subsystem().
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> [Shin'ichiro: rebased on the commit e3fe06e and resolved conflicts]
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

