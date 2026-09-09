Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FD9C79FAD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2026 09:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aSi7B9SonVk0DeLuK1En2cYRE5SojfjDQM48aJ4GYY0=; b=AnwZIFwZT6vP9ChZi+ckYSBFus
	WSz76QCjgYd8m53S+2s56VhULTgplKCsbFoPBTTcJq6cIhRI80Gp5GqbtFSVFA+8QebjGlVrCpx95
	k/ZH7EMbpnaLeNo/J6LEOGpvCR52cjXm59X71e8ZtzH8IpLdgRMCvypf586Q4lHmVTHM+9xRQB+JV
	PxMkE7eBjCS4VKChTNR6Q7v2grGMZhwqfjYoMdhy2BPGNHxhBV8pbUp39oouAHo2ChcnSTUfCmPQN
	iX6+0Ij0nkwPYSJAShkfz24hBg9iTQmPBuKks4Kh2UIwXYI95anqULcsOym+8ajS1mIO7bG2wV+RY
	Osbr/jwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4EF8-0000000BFAI-1XMV;
	Wed, 09 Sep 2026 09:05:22 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4EF4-0000000BF9j-3UpI
	for linux-nvme@lists.infradead.org;
	Wed, 09 Sep 2026 09:05:20 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8AD3E21AB9;
	Wed,  9 Sep 2026 09:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788944710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aSi7B9SonVk0DeLuK1En2cYRE5SojfjDQM48aJ4GYY0=;
	b=z9GIs38DRCAjUrryh4ssmV6EbiUnvR15Rfcr1lqfPzvMP2/x33B5IShspUd9S1HbFa8qnV
	wgPrMGqT8JaC/d/OicvQJfPYpCc3ZIDSVxq9UC+ByAmdHDzwMj9ujZwa48jh2+1nhCfgbV
	bxwcVZmbckPcq48JxA9pNc7WVro8+kU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788944710;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aSi7B9SonVk0DeLuK1En2cYRE5SojfjDQM48aJ4GYY0=;
	b=cV2DmTfg/E/CuW6y6dvoRGjYk7mY1jWWtpWeb0R7WjoGpwlhhb/AZUXU+tCH6VU50yPZoq
	ct0/xU3d9maJHPAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NWqLE2gv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=n81rzUZV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788944706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aSi7B9SonVk0DeLuK1En2cYRE5SojfjDQM48aJ4GYY0=;
	b=NWqLE2gvIWA5AfrhZM62SJOz9GMfy6U7ruUl76GRtUSCGENW+9iTLx9MjHKO6WbAuzuoZP
	jiu7JMPqaOsLGes6yF1ynCcqEhjOGYkcQb+fkXCHJ8FHi41qJzZ/ht0hzehtZYO3r8ucbT
	Fk6aXeyqhXT5Q/YVZpyEq9QEiiAhWgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788944706;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aSi7B9SonVk0DeLuK1En2cYRE5SojfjDQM48aJ4GYY0=;
	b=n81rzUZVhziFWYlQZvaoQDROHbFxUpZV3YLWijZk+bAUE/eDJhWhZ1pQ9SEHb+Y9ni9d2P
	A95KCSeiydY2ufCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A1021347F;
	Wed,  9 Sep 2026 09:05:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OC35FUIhoWrsVwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 09 Sep 2026 09:05:06 +0000
Date: Wed, 9 Sep 2026 11:05:01 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mlombard@arkamax.eu, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fc: do not warn on controller removal race
Message-ID: <a81ce60c-684e-4ec9-a180-9cd53ff9bb0e@flourine.local>
References: <20260908143434.105513-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908143434.105513-1-mlombard@redhat.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8AD3E21AB9
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,flourine.local:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_020519_025471_EF59B599 
X-CRM114-Status: GOOD (  13.25  )
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

On Tue, Sep 08, 2026 at 04:34:34PM +0200, Maurizio Lombardi wrote:
> In nvme_fc_reconnect_or_delete(), the system attempts to remove
> the controller when reconnect limits are reached by calling
> nvme_delete_ctrl(). This call is currently wrapped in a WARN_ON().
> 
> If a user concurrently deletes the controller via sysfs, the
> controller's state may have already transitioned out of the
> CONNECTING state. When this happens, nvme_delete_ctrl() correctly
> rejects the operation and returns -EBUSY. Because of the WARN_ON()
> wrapper, this race condition triggers an unnecessary kernel warning
> stack trace.
> 
> Remove the WARN_ON() macro around nvme_delete_ctrl();
> this allows the system to safely ignore the -EBUSY return value
> if the controller is already being deleted.

Yes, this makes sense.

Reviewed-by: Daniel Wagner <dwagner@suse.de >

