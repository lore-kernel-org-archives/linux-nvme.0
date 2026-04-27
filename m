Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6E9FF885E
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2026 12:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8E0j0qaiWo5RL6nEmdxBqy83fKGr6nzEnpBK+pKOxg0=; b=uFNazElw1HM94e8oxy23QZDyNt
	WtqJ0Hckp4zSb/3ZYjj8vEbAUin7XV3QJ5n5ymqSQjHloNyaYrD/iq20qdq56PPUic6h/YEZ/efug
	ZlJYDMs9umK2p0hmZidhZrH05YOPvTkUgXa87yJHSvwIxZNIX6aVDGhybo37hWD1kDXTJqbz/S5OC
	cj5JfOh+S2HmyTN9An6VM8+XknCjIfrf1Vx9vkR3LDZ1ZbMmWb+WNIHnPyp7IExkXMEOOXy+rCNIO
	fs0hJCV+y1Fni+Q4fwWKIWkrJr+dYv37TFdWlukRUovtEOV+chh/FmH1WAwq+EV/XMP7mqM0i5Cjk
	rxmM3hDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHKte-0000000Gs8M-4AJO;
	Mon, 27 Apr 2026 12:17:06 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHKtc-0000000Gs7Y-1YbX
	for linux-nvme@lists.infradead.org;
	Mon, 27 Apr 2026 12:17:05 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A163F6A824;
	Mon, 27 Apr 2026 12:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777292222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8E0j0qaiWo5RL6nEmdxBqy83fKGr6nzEnpBK+pKOxg0=;
	b=SPHZY+vPF5mPc2cp0BgtqKgaPHft9zLZhQQFkEERdjzPTRNUAQ/Sqvj15yfdRkoJVkhxJr
	V4d50YnSsJG4HUEkufNv/qQIZKxt4PYU5TENj0M1uLXNO38cc/mw8F7XhIukp7qx5F+oFJ
	I5WanBGKGDSqk8gRNFMMd6KzbTm6gQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777292222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8E0j0qaiWo5RL6nEmdxBqy83fKGr6nzEnpBK+pKOxg0=;
	b=6NVqeGaWPMWfmYH9DMTLeihxyYgIFDqndOPJvAvXtBEPFvXOrkd3wSKRT2pJeJI43JojFR
	qG+vGxpDVKWI/3Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SPHZY+vP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6NVqeGaW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777292222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8E0j0qaiWo5RL6nEmdxBqy83fKGr6nzEnpBK+pKOxg0=;
	b=SPHZY+vPF5mPc2cp0BgtqKgaPHft9zLZhQQFkEERdjzPTRNUAQ/Sqvj15yfdRkoJVkhxJr
	V4d50YnSsJG4HUEkufNv/qQIZKxt4PYU5TENj0M1uLXNO38cc/mw8F7XhIukp7qx5F+oFJ
	I5WanBGKGDSqk8gRNFMMd6KzbTm6gQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777292222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8E0j0qaiWo5RL6nEmdxBqy83fKGr6nzEnpBK+pKOxg0=;
	b=6NVqeGaWPMWfmYH9DMTLeihxyYgIFDqndOPJvAvXtBEPFvXOrkd3wSKRT2pJeJI43JojFR
	qG+vGxpDVKWI/3Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90EC8593B1;
	Mon, 27 Apr 2026 12:17:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Dfs+Ir5T72mNDQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 27 Apr 2026 12:17:02 +0000
Date: Mon, 27 Apr 2026 14:17:01 +0200
From: Daniel Wagner <dwagner@suse.de>
To: John Garry <john.g.garry@oracle.com>
Cc: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, nilay@linux.ibm.com
Subject: Re: [PATCH blktests] nvme/068: add a test for multipath delayed
 removal
Message-ID: <655129a4-de84-4c10-9e55-f75143684b7c@flourine.local>
References: <20260415104111.1439459-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415104111.1439459-1-john.g.garry@oracle.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A163F6A824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_051704_556154_F256C944 
X-CRM114-Status: GOOD (  12.43  )
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

On Wed, Apr 15, 2026 at 10:41:11AM +0000, John Garry wrote:
> +	# Part a: Prove that writes fail when no path returns. Any reads or
> +	#	  writes are queued during the delayed removal period. If no
> +	#	  paths return before the timer expires, then those IOs should
> +	#	  fail.
> +	#	  During the delayed removal period, ensure that the module
> +	#	  refcnt is incremented, to prove that we cannot remove the
> +	#	  driver during this period.
> +	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
> +	ns=$(_find_nvme_ns "${def_subsys_uuid}")
> +	refcnt=$(_module_use_count nvme_core)
> +	echo 10 > "/sys/block/"$ns"/delayed_removal_secs"
> +	refcnt_orig=$(_module_use_count nvme_core)
> +	_nvme_disconnect_ctrl "${nvmedev}"
> +	sleep 1

Is there a better alternative to sleep for these tests? I'm worried
about reliability and the extra runtime added by idling.

