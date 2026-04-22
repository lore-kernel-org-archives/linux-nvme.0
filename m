Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A953F9B602
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2026 09:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KhQNhOuEpEBVDwAtiGK1A4B3iqMQlRwb1T7Mzo9Rwrs=; b=yjVy59h9k40BwCKLMShNZRTkTW
	rFjOeWFLDtM7PZqRMN0w77P9msy32WbOgdYboMYi5dGALQfbvEuJ/xfwusgU27eEpUiBDuKiNtHFi
	Ci7UJIRUvggQCCBOa0flBH1mcI6iyNs9UH2jO09Lshug91pECsLRyruIGqEy9IVwSCZfodI3drOgt
	3DJMkWQx8vVKtgSqxEE+7XMFx3QeyD+kvbGcPM4T0r1wBymntYfPWqx1B3EdYQgP5I3QfKrlf4b8w
	R8kkeaOeUEZN7F7WAmEq6k8y1U0RTvICU9/SLDF1BlTbpXREvNPv++jEEnlYIS5JkdZbE28VVLS62
	jhn5/dpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFUMJ-00000009u4I-3i8n;
	Wed, 22 Apr 2026 09:59:03 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFUMH-00000009u3R-0Gu7
	for linux-nvme@lists.infradead.org;
	Wed, 22 Apr 2026 09:59:02 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0BC6B5BD12;
	Wed, 22 Apr 2026 09:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776851939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KhQNhOuEpEBVDwAtiGK1A4B3iqMQlRwb1T7Mzo9Rwrs=;
	b=I4xf75Q381I+CYzsNMJF3VmwE9fzoMOYNGJhIq3DAA3IOqH2oikZ78V3PfKuEtc5Sz1+Tw
	DtJlkaV+bwxjiXcINZcSDonHFm2yJXYLqlS32cxm11Yn1fZTvQcHXwcRRpFbzMp1tGctq4
	yQSw2uL9V4L44I4XttZAhVSmKHQr/Qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776851939;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KhQNhOuEpEBVDwAtiGK1A4B3iqMQlRwb1T7Mzo9Rwrs=;
	b=2TKMaBciCGkPXWdNjVsBitYJX55zcoZaD/soGzmltHrBccsATHayKIsYJ9NG8KC8WOx49i
	Ole5jv9dQtXsrdCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=I4xf75Q3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2TKMaBci
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776851939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KhQNhOuEpEBVDwAtiGK1A4B3iqMQlRwb1T7Mzo9Rwrs=;
	b=I4xf75Q381I+CYzsNMJF3VmwE9fzoMOYNGJhIq3DAA3IOqH2oikZ78V3PfKuEtc5Sz1+Tw
	DtJlkaV+bwxjiXcINZcSDonHFm2yJXYLqlS32cxm11Yn1fZTvQcHXwcRRpFbzMp1tGctq4
	yQSw2uL9V4L44I4XttZAhVSmKHQr/Qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776851939;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KhQNhOuEpEBVDwAtiGK1A4B3iqMQlRwb1T7Mzo9Rwrs=;
	b=2TKMaBciCGkPXWdNjVsBitYJX55zcoZaD/soGzmltHrBccsATHayKIsYJ9NG8KC8WOx49i
	Ole5jv9dQtXsrdCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE5F1593AF;
	Wed, 22 Apr 2026 09:58:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bJH5OOKb6GmJVQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 22 Apr 2026 09:58:58 +0000
Date: Wed, 22 Apr 2026 11:58:53 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com, 
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org, mlombard@arkamax.eu, 
	mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V3 1/8] nvme: Let the blocklayer set timeouts for requests
Message-ID: <e1ab5afc-5ebc-4edf-89b3-cbbbe121a507@flourine.local>
References: <20260410073924.61078-1-mlombard@redhat.com>
 <20260410073924.61078-2-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410073924.61078-2-mlombard@redhat.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,amazon.de:email,purestorage.com:email,flourine.local:mid];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email]
X-Rspamd-Queue-Id: 0BC6B5BD12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260422_025901_255989_3382AE56 
X-CRM114-Status: GOOD (  19.07  )
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

On Fri, Apr 10, 2026 at 09:39:17AM +0200, Maurizio Lombardi wrote:
> From: "Heyne, Maximilian" <mheyne@amazon.de>
> 
> When initializing an nvme request which is about to be send to the block
> layer, we do not need to initialize its timeout. If it's left
> uninitialized at 0 the block layer will use the request queue's timeout
> in blk_add_timer (via nvme_start_request which is called from
> nvme_*_queue_rq). These timeouts are setup to either NVME_IO_TIMEOUT or
> NVME_ADMIN_TIMEOUT when the request queues were created.
> 
> Because the io_timeout of the IO queues can be modified via sysfs, the
> following situation can occur:
> 
> 1) NVME_IO_TIMEOUT = 30 (default module parameter)
> 2) nvme1n1 is probed. IO queues default timeout is 30 s
> 3) manually change the IO timeout to 90 s
>    echo 90000 > /sys/class/nvme/nvme1/nvme1n1/queue/io_timeout
> 4) Any call of __submit_sync_cmd on nvme1n1 to an IO queue will issue
>    commands with the 30 s timeout instead of the wanted 90 s which might
>    be more suitable for this device.
> 
> Commit 470e900c8036 ("nvme: refactor nvme_alloc_request") silently
> changed the behavior for ioctl's already because it unconditionally
> overrides the request's timeout that was set in nvme_init_request. If it
> was unset by the user of the ioctl if will be overridden with 0 meaning
> the block layer will pick the request queue's IO timeout.
> 
> Following up on that, this patch further improves the consistency of IO
> timeout usage. However, there are still uses of NVME_IO_TIMEOUT which
> could be inconsistent with what is set in the device's request_queue by
> the user.
> 
> Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>

Maurizio, you need to add your SoB too.

Besides this,
Reviewed-by: Daniel Wagner <dwagner@suse.de>

