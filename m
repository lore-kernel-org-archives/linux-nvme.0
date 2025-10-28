Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A72DCCF9E0
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Oct 2025 15:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+crhKvqkHlfXPE3UZGCDMo5igLkxWQZ3nmbdzOcy9cw=; b=2V5MkVn7xWnkq/skL6gtDPu3OE
	vXmW76u2zZ47NQQdedlhP28geMGo9Czmb+m8pE9E83gAv1rBG9JDaLpF1e2krBrAPcsKuxr88aFyZ
	L8sGzIhI6Yb8G8WB7PaIXMDrk0cymLDEmQUpnp1qYUyL2dQXd4hU7DSCUoWn8uqM5ofWXWiYtHvel
	f9FN5YQ77LSYMZxIPGbsNappFE4augUDn5Re1jHx0OtB24/5XfuFwevkYPaN/+TkVZpVP02oTyylX
	GSJlqXCB22FrJWqsY6G2+QZhsmeXeXyYb0hhv6DQU9Doq80m/sRgUgFmu8mTq9fGMzNTAjxSTuBYW
	Heu0rx3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDlup-0000000GEOs-1QaV;
	Tue, 28 Oct 2025 15:47:19 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDlum-0000000GENs-0g15
	for linux-nvme@lists.infradead.org;
	Tue, 28 Oct 2025 15:47:17 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 985EA218E6;
	Tue, 28 Oct 2025 15:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761666432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+crhKvqkHlfXPE3UZGCDMo5igLkxWQZ3nmbdzOcy9cw=;
	b=D76UCDz7DnzAaKKMymz8WmD9RlXz6AT3hn+oCSGhtPrtYCEZ5dU2A6IqQxBd+AzszQFJ+O
	kkWDjv8q9iTAJRj+vHLNKr1lbW5GdhjvjbrnWjQ4dg4/L3AliO85vnbqhntuoG2QqMW6ij
	0f8Z94QFuM8b4cEunGnDFGRO1bmXJyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761666432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+crhKvqkHlfXPE3UZGCDMo5igLkxWQZ3nmbdzOcy9cw=;
	b=j+tgclw9OAAxATNDtHBsxRfctv1tA7Qv7PKPJmGZ33BnIbidLnd0oqjkJ0RHN2z/ne0jrv
	+zPxGkHxUG3cPkCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=D76UCDz7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=j+tgclw9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761666432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+crhKvqkHlfXPE3UZGCDMo5igLkxWQZ3nmbdzOcy9cw=;
	b=D76UCDz7DnzAaKKMymz8WmD9RlXz6AT3hn+oCSGhtPrtYCEZ5dU2A6IqQxBd+AzszQFJ+O
	kkWDjv8q9iTAJRj+vHLNKr1lbW5GdhjvjbrnWjQ4dg4/L3AliO85vnbqhntuoG2QqMW6ij
	0f8Z94QFuM8b4cEunGnDFGRO1bmXJyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761666432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+crhKvqkHlfXPE3UZGCDMo5igLkxWQZ3nmbdzOcy9cw=;
	b=j+tgclw9OAAxATNDtHBsxRfctv1tA7Qv7PKPJmGZ33BnIbidLnd0oqjkJ0RHN2z/ne0jrv
	+zPxGkHxUG3cPkCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8889613A7D;
	Tue, 28 Oct 2025 15:47:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FIl4IIDlAGlebQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 28 Oct 2025 15:47:12 +0000
Date: Tue, 28 Oct 2025 16:47:12 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] nvmet-fc: use pr_* print macros instead of dev_*
Message-ID: <83e3fc56-9bb3-4372-95e1-3b318c34e26b@flourine.local>
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
 <20251028-nvmet-fcloop-fixes-v1-5-765427148613@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-5-765427148613@kernel.org>
X-Rspamd-Queue-Id: 985EA218E6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_084716_345982_AD8E1672 
X-CRM114-Status: GOOD (  13.46  )
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

On Tue, Oct 28, 2025 at 04:26:24PM +0100, Daniel Wagner wrote:
> Many of the nvmet-fc log messages cannot print the device used, because
> it's not there yet:
> 
>   (NULL device *): {0:0} Association deleted
> 
> Use the pr_* macros consistently throughout the module and match the
> output of the nvme-fc module.
> 
> Using port:association ids are more useful when debugging what's going
> on, because these match now with the log entries from nvme-fc.

Signed-off-by: Daniel Wagner <wagi@kernel.org>

