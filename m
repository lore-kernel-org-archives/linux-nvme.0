Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D73C4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Apr 2024 07:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AyMJqciR9v4GhYKpDskHi99+yLlhayX6e+VOTttUvOM=; b=UhAcdtjhD8dbGoGjbWFxzFLtmH
	Yk8J6MCQ/q4eoicJEwFVIhXJsb/68xfmz70tals2ZQg22t+lrxgm4YdxLJ8IUFUuEFdAUo2hKF1PK
	mwVFCRItZ+FPb9plc+soLmPB8ZxGkcpW6dS/2laHfyo6gy0DFuIEZog7VrBbSJUY5RJoxsJJJKb7V
	QSY5cG3ZErswL+qQqfmtJIJbAwdbIznq+Rv1a8Mpm8LVTYiEIpWWft+yb3tY/hNLmAj3iWVGD0e+1
	njLYCeOCLZxqawdE+7Q2wnOkLAUufPibTyvWWJFn9RtCHhTmZpsieCWsydWpbGElxIGJgVzAGnQB9
	A5ePTjhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwzxT-0000000F4qy-1vvC;
	Wed, 17 Apr 2024 07:43:55 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwzxP-0000000F4pi-1bDv
	for linux-nvme@lists.infradead.org;
	Wed, 17 Apr 2024 07:43:54 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 206A633951;
	Wed, 17 Apr 2024 07:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713339829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AyMJqciR9v4GhYKpDskHi99+yLlhayX6e+VOTttUvOM=;
	b=NHFc9qXdfuQo22QrPElorSJ6/EYcEYqDmR9A4Girh5gs3jcD8OWBo3aBKCroe2mamSi2k2
	LqkskIYB2L8ZG0zs26znH2n0bdAh0K5hj9NrQaE085rFN2G8q8TrEoJGv4w3yt6penaE9r
	hUmvZQRTDapXWXVr92mZjP1FZaf18Eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713339829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AyMJqciR9v4GhYKpDskHi99+yLlhayX6e+VOTttUvOM=;
	b=9ZkCPWw7dIsepJnaSm8NUexpvBbbVwo7cqTjU9iQm59dd+iDqu8qBmS96chcb24F5+D+tR
	3oamDK7DELpfPPCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NHFc9qXd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9ZkCPWw7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713339829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AyMJqciR9v4GhYKpDskHi99+yLlhayX6e+VOTttUvOM=;
	b=NHFc9qXdfuQo22QrPElorSJ6/EYcEYqDmR9A4Girh5gs3jcD8OWBo3aBKCroe2mamSi2k2
	LqkskIYB2L8ZG0zs26znH2n0bdAh0K5hj9NrQaE085rFN2G8q8TrEoJGv4w3yt6penaE9r
	hUmvZQRTDapXWXVr92mZjP1FZaf18Eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713339829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AyMJqciR9v4GhYKpDskHi99+yLlhayX6e+VOTttUvOM=;
	b=9ZkCPWw7dIsepJnaSm8NUexpvBbbVwo7cqTjU9iQm59dd+iDqu8qBmS96chcb24F5+D+tR
	3oamDK7DELpfPPCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E35C13957;
	Wed, 17 Apr 2024 07:43:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EYMGArV9H2aKMQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 17 Apr 2024 07:43:49 +0000
Date: Wed, 17 Apr 2024 09:43:48 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Israel Rukshin <israelr@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, 
	Linux-nvme <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] fabrics: Always pass hostid and hostnqn
Message-ID: <smw6zosemix363eqa6qfagib26xunkwykgitjfpixuknsndtca@vr3fbavsf7zl>
References: <1713249176-7837-1-git-send-email-israelr@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1713249176-7837-1-git-send-email-israelr@nvidia.com>
X-Spamd-Result: default: False [-2.92 / 50.00];
	BAYES_HAM(-1.91)[94.54%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 206A633951
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240417_004351_591944_EEB62B47 
X-CRM114-Status: UNSURE (   9.50  )
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

On Tue, Apr 16, 2024 at 06:32:55AM +0000, Israel Rukshin wrote:
> +void nvmf_set_hostid_and_hostnqn(char **hostid, char **hostnqn)
> +{
> +	if (!*hostid)
> +		*hostid = nvmf_hostid_from_file();
> +	if (!*hostnqn)
> +		*hostnqn = nvmf_hostnqn_from_file();

Please use a local pointer variable and do the final assign the
result argument pointer variable at the end of the function. This avoids
the dereferencing of hostid and hostnqn all the time.

Rest looks good.

