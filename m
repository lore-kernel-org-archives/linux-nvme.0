Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C52F3C9BC
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Feb 2026 16:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ttbHm5RTO/Dzl7qCo7SvH4Km/2zZmWiCTwCtb7uTuzA=; b=xsFv7rXf/ve2mA6ERj0LuoL+GP
	uL11c72To4/IQLDMFlVJ6agFphUbSowQ0eUfp5zbkWrso6TXGsPjr+AaXX96OaN4ZrS0mgSdgy680
	3gPKnaltv1z9ALgVJZ4+0THgfLIuOB2XhJwIvG3IL2ZvebqsHJwDIknZ6uCfirs3eZ1wJarM9aZaC
	zQqDE7SCWcHWVz6UIs1xut+eOz/bkQnTG2BMVsJNA5pyg1aFVCrPv5pVxm0DV/mQ3kYTZd5VIeNAj
	YKyxVrqwZCh1uCgD1nVvF1f9jjjUMF42tSjSaLNr6Gk5mrSN0h7rgA4Y+JNJZoQgGWEaq97FneU1g
	TDTeeieA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuvSi-00000002Pj1-3ofx;
	Tue, 24 Feb 2026 16:40:40 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuvSf-00000002Pig-4Ba2
	for linux-nvme@lists.infradead.org;
	Tue, 24 Feb 2026 16:40:39 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B5BA5BD8B;
	Tue, 24 Feb 2026 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771951234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ttbHm5RTO/Dzl7qCo7SvH4Km/2zZmWiCTwCtb7uTuzA=;
	b=oXPIb6YQaaoSuquJ2dgOazaYfr9RJMkpHL/cJpX+F6O3Rvkcnc4tp1d539mOj8oU1YGmXi
	GtmoclFTnrbShjmUGpwkYmrEWqtxHrTErJQJTSIv/tXFGpcgoo2N3wY3UhmVWcmWMWYt7y
	jHGLaMkkNyYT7mjpJ/m+opIymq2y8G4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771951234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ttbHm5RTO/Dzl7qCo7SvH4Km/2zZmWiCTwCtb7uTuzA=;
	b=wpXVfrxYlXxN7LkA2dr1FU/Sv4e22p8syLbGskBZgPjMWpcNscwTZlLN5WAm7/yTkFTGSZ
	HOdqv0cjvQF6cuAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771951234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ttbHm5RTO/Dzl7qCo7SvH4Km/2zZmWiCTwCtb7uTuzA=;
	b=oXPIb6YQaaoSuquJ2dgOazaYfr9RJMkpHL/cJpX+F6O3Rvkcnc4tp1d539mOj8oU1YGmXi
	GtmoclFTnrbShjmUGpwkYmrEWqtxHrTErJQJTSIv/tXFGpcgoo2N3wY3UhmVWcmWMWYt7y
	jHGLaMkkNyYT7mjpJ/m+opIymq2y8G4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771951234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ttbHm5RTO/Dzl7qCo7SvH4Km/2zZmWiCTwCtb7uTuzA=;
	b=wpXVfrxYlXxN7LkA2dr1FU/Sv4e22p8syLbGskBZgPjMWpcNscwTZlLN5WAm7/yTkFTGSZ
	HOdqv0cjvQF6cuAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82BA63EA68;
	Tue, 24 Feb 2026 16:40:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LbO1HoLUnWlKWQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 24 Feb 2026 16:40:34 +0000
Date: Tue, 24 Feb 2026 17:40:33 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests 0/3] fix module unload failures
Message-ID: <ad4c1108-8604-4a09-b3fb-e8f77a4abbcf@flourine.local>
References: <20260223035023.21902-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223035023.21902-1-shinichiro.kawasaki@wdc.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_084038_218660_95EDDF3E 
X-CRM114-Status: GOOD (  20.91  )
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

On Mon, Feb 23, 2026 at 12:50:20PM +0900, Shin'ichiro Kawasaki wrote:
> Since the recent commit 7c3ad92d3d8f ("check: check reference count for
> modprobe --remove --wait success case"), the test case nvme/060 started
> printing the error message below:
> 
>   modprobe with --wait option succeeded but still nvmet has references
> 
> This error indicates that the nvmet modules failed to unload as
> expected. While the root cause has existed for a long time, the trigger
> commit exposed the problem. I took a look in the failure, and observed
> the failure scenario as follows:
> 
> - The failure occurs when the test case is executed multiple times for
>   different transport types. At the first step, nvme/060 is executed for
>   the loop transport. Although nvme/060 was not designed to run for this
>   transport type, its requirement check leaves two modules loaded: nvmet
>   and nvme-loop.
> 
> - At the second step, when nvme/060 is executed for the rdma transport,
>   the helper function _setup_nvmet() loads the nvmet-rdma module for
>   testing. After the test completes, the helper function
>   _cleanup_nvmet() attempts to unload the nvmet-rdma and nvmet modules.
>   While it succeeds to unload the nvmet-rdma module, it fails to unload
>   the nvmet module because the nvme-loop module is still using the nvmet
>   module. Hence the error message.
> 
> From these observations, I identified two problems below.
> 
> 1) The requirement check for the loop transport left the nvmet and nvme-
>    loop modules loaded and it affected the following test. In the
>    current implementation, the helper function _unload_modules() is
>    called once, only after nvme/060 has been executed for all specified
>    transport types. Instead, _unload_modules() should be called after
>    each run of test test case for every transport. This ensures that the
>    modules loaded for the requirement check are unloaded.
> 
> 2) When _setup_nvmet() does not load the nvmet module, there is no need
>    for _cleanup_nvmet() to attempts to unload it. _cleanup_nvmet()
>    should unload a module only if it was loaded by _setup_nvmet().
> 
> This series addresses these two problems. The first patch fixes the
> first problem. The other two patches fix the second problem.

Looks good to me.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

