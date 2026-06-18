Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E56CD98ED
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2026 13:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ho5rR2oOL3wMo5IaPcEjfQ/vQ078WNrO/SrMDBGoMko=; b=PhqYu3KxdFclrZkpXF/jrk3Vvx
	0pplIaMKy1RLdvxKGgNti3/wEDgYfmva/whxmuomy1vpyXhA8/Sh4VoM24Khe6LY1yUzylqSIbaSC
	Ld7H0P1Mw9GzuhQKRd29z506Fr+5Jb64cJHdEY0f85A1HwFkixPRlo4IJtkMjU+17QMauDTqD3rnd
	Ik4riunH86c3PAnUuJ6wYNSyr5V3OEmHVlsqGSQ/+7twAC9tdRVWgN3MwiIxjREkbs822PwF1RD6t
	te8SyqZOHRsz5BWDj3EEUIcLkzrlzf6Vi71m8rJnem+LCjQzVSw8tpbs0Cnefk20oBod3Jtn//qT5
	oweIr7qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waCOF-00000001JnH-0Wow;
	Thu, 18 Jun 2026 13:02:39 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waCOC-00000001Jma-0AuC
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jun 2026 13:02:37 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B09186D26F;
	Thu, 18 Jun 2026 13:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781787752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ho5rR2oOL3wMo5IaPcEjfQ/vQ078WNrO/SrMDBGoMko=;
	b=M3YCLGPy/bIqRnpNhTBO28Hfm1cCdbjI9zpI+0DdIMucdP61M/KP6aT86VEsP6BepjvL6c
	KtNyMqsaCAICDjz2LS9rlThXwxHNjPNkSw3+CUcm5BFZLz0gtXrg11/0htX2GO52P/GQhH
	JuYYcW17aVcNx7Lw3yZ1xW+aHjuTjSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781787752;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ho5rR2oOL3wMo5IaPcEjfQ/vQ078WNrO/SrMDBGoMko=;
	b=o9jxKOIJ69NIwS5QSXGtHzxhske+vcP8BWpUwk1VIlbLI8zyRMx3VsbOg1ow+UZyJ5G1i2
	yg+sogMMILhGe+Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781787752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ho5rR2oOL3wMo5IaPcEjfQ/vQ078WNrO/SrMDBGoMko=;
	b=M3YCLGPy/bIqRnpNhTBO28Hfm1cCdbjI9zpI+0DdIMucdP61M/KP6aT86VEsP6BepjvL6c
	KtNyMqsaCAICDjz2LS9rlThXwxHNjPNkSw3+CUcm5BFZLz0gtXrg11/0htX2GO52P/GQhH
	JuYYcW17aVcNx7Lw3yZ1xW+aHjuTjSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781787752;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ho5rR2oOL3wMo5IaPcEjfQ/vQ078WNrO/SrMDBGoMko=;
	b=o9jxKOIJ69NIwS5QSXGtHzxhske+vcP8BWpUwk1VIlbLI8zyRMx3VsbOg1ow+UZyJ5G1i2
	yg+sogMMILhGe+Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D7AF779A8;
	Thu, 18 Jun 2026 13:02:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VrvIJGjsM2rEQwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 18 Jun 2026 13:02:32 +0000
Date: Thu, 18 Jun 2026 15:02:31 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-multipath: expose path_state via sysfs
Message-ID: <498d2a2f-8545-470e-b42a-dd47e26a948a@flourine.local>
References: <20260617121543.2291455-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617121543.2291455-1-kanie@linux.alibaba.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260618_060236_238125_F31F3080 
X-CRM114-Status: GOOD (  13.96  )
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

On Wed, Jun 17, 2026 at 08:15:43PM +0800, Guixin Liu wrote:
> Add a read-only "path_state" sysfs attribute to each NVMe path namespace
> device (/sys/class/nvme/nvmeX/nvmeXcYnZ/path_state) that exposes whether
> the path is currently enabled or disabled.
> 
> The attribute reflects the result of nvme_path_is_disabled(), showing
> "disabled" when the controller is not live/deleting, the namespace has
> an ANA state change pending, or the namespace is not ready. Otherwise
> it shows "enabled".
> 
> This gives userspace visibility into the multipath path selection state
> without requiring users to piece together controller state and namespace
> flags manually.

The ctrl state is already exposed to the sysfs. What's the use case for
this sysfs entry?

