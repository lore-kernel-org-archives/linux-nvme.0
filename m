Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859EB606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Rk8z1beP;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cMrpVW3h;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YVADMuNF;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cMrpVW3h;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YVADMuNF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PmquBilGb5hrp883yKVM0nTODQavPyFSDwNyzzpvQWM=; b=Rk8z1beP9ZEyHGty3NUoEBns9D
	R609N3Y2YsqCsLv6OCCbLxpW4qhv1+3v3zGx+rEGPbJyKpC2zI4doYJcHQqTXK7z9L3cDDSZKs/+z
	Q0PW3AJs9CbMAIHY7NkRssaCg1pyR2pMQUCLs1HPACuXy7xbaBcfsARngbzrhuk6deuFPeq0fxoEL
	WsbSutyrfMwTSvcxNdMNJzkvoblYJMOCXt+1WvR3GkySVvsepMKizAKB999g67vFtNmTDQhuKO3D3
	IA5pV40bfojIppA3KaUpxxkFTIwbcC46SLDOikriEN5/06Fmq5OnGLt4ObJ3ml37sYp1gV/f6bOqk
	P9QjDdyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRQxp-00000009KrE-0mdC;
	Thu, 12 Nov 2026 09:19:25 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRQxn-00000009Kqo-0Qpz
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 09:19:24 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C72B21CA4;
	Thu, 12 Nov 2026 09:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794475161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PmquBilGb5hrp883yKVM0nTODQavPyFSDwNyzzpvQWM=;
	b=cMrpVW3hg/K3dYZ3kwvxt5uoM6LWDEixdnkjEosMKBhCF5eUx3Jblmd2oBkLo6gSi++LS4
	DYeHrGl4quKc0U8y4kv3TEorHpyAAza1+xLoBcSbTR953t6T1CRxS419GdzSzdjVUG9b8y
	NePlsNB0ghJVj4F5mK4MDrnNXVhhuRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794475161;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PmquBilGb5hrp883yKVM0nTODQavPyFSDwNyzzpvQWM=;
	b=YVADMuNFmoFfyl9EJYMlJdJ03wGKRVLX13OaggLAb+KCbOrjxPve0NYqwRY/7z8zYu8r8Q
	vxvy8QNpI//Kx+Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794475161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PmquBilGb5hrp883yKVM0nTODQavPyFSDwNyzzpvQWM=;
	b=cMrpVW3hg/K3dYZ3kwvxt5uoM6LWDEixdnkjEosMKBhCF5eUx3Jblmd2oBkLo6gSi++LS4
	DYeHrGl4quKc0U8y4kv3TEorHpyAAza1+xLoBcSbTR953t6T1CRxS419GdzSzdjVUG9b8y
	NePlsNB0ghJVj4F5mK4MDrnNXVhhuRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794475161;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PmquBilGb5hrp883yKVM0nTODQavPyFSDwNyzzpvQWM=;
	b=YVADMuNFmoFfyl9EJYMlJdJ03wGKRVLX13OaggLAb+KCbOrjxPve0NYqwRY/7z8zYu8r8Q
	vxvy8QNpI//Kx+Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34560134A0;
	Thu, 12 Nov 2026 09:19:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Tk11BpmE9Wo3ewAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 12 Nov 2026 09:19:21 +0000
Date: Thu, 12 Nov 2026 10:19:16 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests 00/10] nvme: make NVME_TARGET_CONTROL work with
 remote targets
Message-ID: <4352fde1-faca-41da-bac0-9106a4e5b1c9@flourine.local>
References: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
 <avREkjfeJjzFg-0x@shinmob>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avREkjfeJjzFg-0x@shinmob>
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_011923_314613_D6E94645 
X-CRM114-Status: UNSURE (   9.89  )
X-CRM114-Notice: Please train this message.
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

On Wed, Nov 11, 2026 at 07:36:31PM +0900, Shin'ichiro Kawasaki wrote:
> Daniel, thank you for the series. I walked through the patches and all look
> valuable. I applied first six patches. I made minor comments on the two patches
> out of the left four patches. Please see if they make sense for you.

Thanks, yes sure, I'll update the remaining patches.

