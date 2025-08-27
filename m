Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E96EC8303F
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Aug 2025 08:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iXYFH/w22lgzk5dZiG+aXEjUjCZJIZJlelztnHxh41k=; b=gXKGGuV5uUzsoCguYP5n0QxPIA
	URjHC1CeT6WQhcn46mT5TSw6Vq6vvZgatpwc97u5B0pGeeRiHzB7vaXAY59TU2OI/0LVgcgPw1Lke
	7bTKBk2UibD8VitzTgCNm+XTTP0x8/SlQXE3qejI3kZwL0dCodKng+aL9MeWlnWa82NoL7JBLA34V
	zDyAnur/PCK++NSivLciQOOyAzOrKOvQiM1e41hNyVUE2Wd/KUPtHAlFC5hRMTY1fAtbTsMzaOxbO
	X3bfn6tbcib64I4NdRnY2Cus/HWiq9TcCUVQbX/xh//Rl23BEBcXWSohOE8b/PmUVZfKqFQytdFRD
	OHQKjAFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urBdN-0000000EgoB-2zqL;
	Wed, 27 Aug 2025 08:35:57 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urBEu-0000000EbY4-0Ics
	for linux-nvme@lists.infradead.org;
	Wed, 27 Aug 2025 08:10:41 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4FF4D1FEFC;
	Wed, 27 Aug 2025 08:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756282238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXYFH/w22lgzk5dZiG+aXEjUjCZJIZJlelztnHxh41k=;
	b=eaRDOAPhwR1/E22hiTZmGb2TWaubRBJZSPZAgAZP3PynemMRNVYOaxzYqBT3y9ATC3BtIr
	1uQkT8IBaXLlyPwRNDlF6e4Vcimc5uJiBlFrxIx1zkcoqLdxhWeho4vLql6IFsHrdAfnfw
	CM4doCGOUQUg93uCiunnI+Wpn0jVxt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756282238;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXYFH/w22lgzk5dZiG+aXEjUjCZJIZJlelztnHxh41k=;
	b=OYkUr+gdwroog+cn0k3VLMxNvCbFM689WADSPDXfagtSIYqK+Y3a8FBPCX3yUgmieXo649
	hS7xIlOZPQJplSBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eaRDOAPh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OYkUr+gd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756282238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXYFH/w22lgzk5dZiG+aXEjUjCZJIZJlelztnHxh41k=;
	b=eaRDOAPhwR1/E22hiTZmGb2TWaubRBJZSPZAgAZP3PynemMRNVYOaxzYqBT3y9ATC3BtIr
	1uQkT8IBaXLlyPwRNDlF6e4Vcimc5uJiBlFrxIx1zkcoqLdxhWeho4vLql6IFsHrdAfnfw
	CM4doCGOUQUg93uCiunnI+Wpn0jVxt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756282238;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXYFH/w22lgzk5dZiG+aXEjUjCZJIZJlelztnHxh41k=;
	b=OYkUr+gdwroog+cn0k3VLMxNvCbFM689WADSPDXfagtSIYqK+Y3a8FBPCX3yUgmieXo649
	hS7xIlOZPQJplSBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E52A13310;
	Wed, 27 Aug 2025 08:10:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XMm5DX69rmjgeAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 27 Aug 2025 08:10:38 +0000
Date: Wed, 27 Aug 2025 10:10:37 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com, 
	chaitanyak@nvidia.com
Subject: Re: [PATCH blktests 2/2] nvme/{003,041,044,052,057,058,060,062}:
 update arg for _nvme_connect_subsys
Message-ID: <37eb864a-d343-478f-a03b-7f6dced20099@flourine.local>
References: <20250822151159.3248900-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822151159.3248900-1-yi.zhang@redhat.com>
X-Rspamd-Queue-Id: 4FF4D1FEFC
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250827_011040_275998_80D3DF38 
X-CRM114-Status: GOOD (  11.87  )
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

On Fri, Aug 22, 2025 at 11:11:59AM -0400, Yi Zhang wrote:
> The previous patch changed the default behavior of _nvme_connect_subsys
> to wait for the namespace ready, but we have some cases that don't need
> to wait for the controller or namespace ready, so add
> --no-wait-ns/--no-wait for these cases

Looks okay for the time being. I think we should start to check the
return value from _nvme_connect_subsys and report an error if it isn't
what the test expects.

Reviewed-by: Daniel Wagner <dwagner@suse.de>


