Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883F7FF8861
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2026 09:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R7uwwT0gVidcFzh7ReelsYrwzanQo5u6EU+2hmjZrfg=; b=pW2vnI9E4d8wqBLWJ7BE6SjNmQ
	Ro8u++EMMIYk1OZgkmkI+le0LjGy0J4iF8jtyAlLgSSR9QbPoLlJYExyvmQGDswPd8FeucXNiZ3I2
	qHaIVtbrzwOjbgfAffAa80ddhOpw049Vs6ddgPL31dCcZMhI1ffwHfgQhtn5Qa7AKRM+JYR+IXC0M
	+joZNGMrvK1lJjXKxWkH1UwrwstW2p84MtcpzS6qmHCkjZdL6Fo2CIvvX/b6BESnkh3DedbIRYAjr
	gpJeoDMmfTzmtN6tnxztYu3U49sxsHQGfvt5SfJZPV6A+E7lC/RKbXpAgANMELweySVUsKdHsj5BU
	ed331RAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHI03-0000000GXkH-0KUi;
	Mon, 27 Apr 2026 09:11:31 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHI00-0000000GXia-0vSq
	for linux-nvme@lists.infradead.org;
	Mon, 27 Apr 2026 09:11:29 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 93ECD6A8EA;
	Mon, 27 Apr 2026 09:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777281086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7uwwT0gVidcFzh7ReelsYrwzanQo5u6EU+2hmjZrfg=;
	b=MIxw+3IqQMeW0zl1hMv+w1Dl/efg7WP0FfLQ2wRsEz8jEocG/tLlVc811HyIH9Mf9Uin61
	wKXZzC6TlXdHP6NnL4inidepGpfghieFJimHKbXAXp/206xwtooJxtgCp0BdOwWOU2Lucp
	icGRfl9ZsrUKoVRZuooNh7wWiXUa9nE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777281086;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7uwwT0gVidcFzh7ReelsYrwzanQo5u6EU+2hmjZrfg=;
	b=n/Z00nd6LvxYNFZR/TeaM85raUEiiiBoJuB/9xO5m7kHkYDxzvGb9CjTjEaZSweWyNRfoi
	7MRK4evG4D0pGDAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777281086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7uwwT0gVidcFzh7ReelsYrwzanQo5u6EU+2hmjZrfg=;
	b=MIxw+3IqQMeW0zl1hMv+w1Dl/efg7WP0FfLQ2wRsEz8jEocG/tLlVc811HyIH9Mf9Uin61
	wKXZzC6TlXdHP6NnL4inidepGpfghieFJimHKbXAXp/206xwtooJxtgCp0BdOwWOU2Lucp
	icGRfl9ZsrUKoVRZuooNh7wWiXUa9nE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777281086;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7uwwT0gVidcFzh7ReelsYrwzanQo5u6EU+2hmjZrfg=;
	b=n/Z00nd6LvxYNFZR/TeaM85raUEiiiBoJuB/9xO5m7kHkYDxzvGb9CjTjEaZSweWyNRfoi
	7MRK4evG4D0pGDAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83D56593B0;
	Mon, 27 Apr 2026 09:11:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MTLdHj4o72k2RQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 27 Apr 2026 09:11:26 +0000
Date: Mon, 27 Apr 2026 11:11:21 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com, 
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org, mlombard@arkamax.eu, 
	mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V3 4/8] nvme: add sysfs attribute to change IO timeout
 per nvme controller
Message-ID: <d776e448-461d-4888-a685-a9af79c61d9c@flourine.local>
References: <20260410073924.61078-1-mlombard@redhat.com>
 <20260410073924.61078-5-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410073924.61078-5-mlombard@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_021128_407625_27E03F70 
X-CRM114-Status: GOOD (  15.64  )
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

On Fri, Apr 10, 2026 at 09:39:20AM +0200, Maurizio Lombardi wrote:
> Currently, there is no method to adjust the timeout values on a
> per controller basis with nvme I/O queues.
> Add an io_timeout attribute to nvme so that different nvme controllers
> which may have different timeout requirements can have custom
> I/O timeouts set.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>  drivers/nvme/host/core.c  |  2 ++
>  drivers/nvme/host/nvme.h  |  1 +
>  drivers/nvme/host/sysfs.c | 47 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 50 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 6dc3d273623c..1b676fd4d454 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4197,6 +4197,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>  		mutex_unlock(&ctrl->namespaces_lock);
>  		goto out_unlink_ns;
>  	}
> +	blk_queue_rq_timeout(ns->queue, ctrl->io_timeout);
>  	nvme_ns_add_to_ctrl_list(ns);
>  	mutex_unlock(&ctrl->namespaces_lock);
>  	synchronize_srcu(&ctrl->srcu);
> @@ -5136,6 +5137,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>  	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
>  	ctrl->ka_last_check_time = jiffies;
>  	ctrl->admin_timeout = NVME_ADMIN_TIMEOUT;
> +	ctrl->io_timeout = NVME_IO_TIMEOUT;

Should this be initialized with the defaults from the module load time?

