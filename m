Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8D7C88E53
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2026 13:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iPcHGmruPrfBOdnm7hELzjGcjxWD8A48/oZhR4s2CR4=; b=Ut0dHUCfF3OUyHA7bcJKxp1tx2
	1qchg6LJ2JuV4OtEFBK6mRILwBYNTENE9iCZs/cLCT0szX3aPRhI+7DayWuh3N/fR9tK04/lqxz1A
	28ltRkBvFX57TOpYNDXSO5qn/Bld0BYl73S9P4SFLfnejBncwvcDsM5b6zwbx+axFCugJxRF+iF8S
	byb3DVuc8xwTiQw692BrkbW7LUWIaUL4hmbcPoYjvOC4qPEaq9BEtNy3xD6stfVyNH44v46C1TWXc
	7fafSVT51NFgc4HFA63ljALEQnSqytyd33yj6+AwnbXkZT8Rdz9z4WXYlYGhKn1Jx0/TDVmD4Ss2e
	COZhEvmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6SxH-00000006fZv-3EAm;
	Tue, 15 Sep 2026 13:12:11 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6SxF-00000006fYt-0hNB
	for linux-nvme@lists.infradead.org;
	Tue, 15 Sep 2026 13:12:10 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7AC3021A48;
	Tue, 15 Sep 2026 13:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789477921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iPcHGmruPrfBOdnm7hELzjGcjxWD8A48/oZhR4s2CR4=;
	b=ozPB6W4h4WgOB7pAemiXhbCNidqSquE01Mpt2MYFyETB13rBbFi5VZa0Xs6g9Eo/nly4nc
	+PY3GmCfUbP12jQMNegBtT0TJyUQm9HX2C8qFOHy4l0xadg867thzYaYxo/hoN8Y0vK3lm
	uH/ozSaZAA4A98M4Aux/kcHPBp+TQOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789477921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iPcHGmruPrfBOdnm7hELzjGcjxWD8A48/oZhR4s2CR4=;
	b=doDNOSzGRPqSj87eA2uckVPc/ASqKVX17OyuChXZwvNMkGPKHu6jX4Mt2O3MXDoZiKooc7
	iL/IrmZ0k5mcWAAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="xy9/MuKn";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8XMymwHE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789477917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iPcHGmruPrfBOdnm7hELzjGcjxWD8A48/oZhR4s2CR4=;
	b=xy9/MuKne99zrJqw0J+wG/ouTcDefEJ9FYZSJnwBcSYeZ3ScW7DSR/zORjSeOKvA//WDhS
	woPbEferYz6+Pxhaq0oRRPiDKeQ7PH06FaQ45ogskJ1T8ay0oNvHbcl3NJHT4os6xlNG3P
	ZwekmJj6DprRrPJfGfhaAJK9F9argBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789477917;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iPcHGmruPrfBOdnm7hELzjGcjxWD8A48/oZhR4s2CR4=;
	b=8XMymwHEBos16XlfrsT74E/vLGaHnNvYlxMM92xXMalGmqvFnVjN0lbmf2BH0d4N3BRV1L
	n2hgo3EJbM8+7gCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48FF6136A5;
	Tue, 15 Sep 2026 13:11:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LU0iCR1EqWrRYAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 15 Sep 2026 13:11:57 +0000
Date: Tue, 15 Sep 2026 15:11:56 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org, mlombard@arkamax.eu, 
	hch@lst.de, hare@suse.de
Subject: Re: [PATCH] nvme: do not reset controllers in NVME_CTRL_NEW state
Message-ID: <e6146839-0a52-45d0-8b95-9ae0f7807493@flourine.local>
References: <20260915095827.698928-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915095827.698928-1-mlombard@redhat.com>
X-Rspamd-Queue-Id: 7AC3021A48
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,appspotmail.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_061209_368709_2C98F08F 
X-CRM114-Status: GOOD (  17.66  )
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

On Tue, Sep 15, 2026 at 11:58:27AM +0200, Maurizio Lombardi wrote:
> During NVMe controller creation, the controller is exposed to sysfs via
> nvme_add_ctrl() while it is still in the NVME_CTRL_NEW state.
> This creates a narrow race window where a userspace process can write to
> the reset_controller sysfs node before the initialization thread
> transitions the state to NVME_CTRL_CONNECTING.
> 
> If a reset is triggered during this window, the state machine allows the
> transition from NVME_CTRL_NEW to NVME_CTRL_RESETTING, and the reset work
> is queued. However, the original creation thread continues its execution,
> subsequently moving the state to NVME_CTRL_CONNECTING and finally to
> NVME_CTRL_LIVE.
> 
> When the delayed reset work finally executes, it attempts to tear down
> the controller and transition the state to NVME_CTRL_CONNECTING. Because
> the state is now NVME_CTRL_LIVE, this transition fails, triggering a
> WARN_ON in the reset work.
> 
> Fix this by removing NVME_CTRL_NEW from the allowed prior states for
> the NVME_CTRL_RESETTING transition.
> 
> Fixes: 8bfc3b4c6f9d ("nvmet: switch loopback target state to connecting when resetting")
> Reported-by: syzbot+4a1d521d19d6321f5aad@syzkaller.appspotmail.com
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com or why it was
> there it there in the first place

Looks reasonable. It might be worth explaining why we don't need to
handle the NEW -> RESETTING state transition or why it was there in the
first place.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

