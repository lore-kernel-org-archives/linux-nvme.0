Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8D4E83054
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 05:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3KIIEfAQN9YX047MvUAtQhbHRSzfXzkurmgKcnHJx6Q=; b=iqG8Dggp1bEnU4e3ZnzegIKUBt
	xhBrtL0faWr4he9kMn8Pz1bW4FpBMgalHtcY0l4hIyMNEIMch2O7B2HOAaFvE693pAe3XFClvmTTt
	rxmzysX0XmMKHtPzhXeudEJRG4lu9t0Q1fkJv0tT/WOFQDuVLzW2Y/u/+hOfZPKJNAgVaIuY/+fNs
	bDB5o0vsLQY0GlyjzHleW+RpHLP7y0UpO21n2/3XWnv2vxiDGf8FVOB6GWflRsPADMVK/xigTYwNP
	fZQoNv4u0IidQyqJinIzPFXuLlCe9yTNN6pemguXL2kB89o7kqxaHyE6GTtWr44yRfi+Sun0JKikO
	56VJ8xKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn95C-000000067IS-3t0t;
	Tue, 03 Feb 2026 05:36:14 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn958-000000067I3-2MID
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 05:36:13 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 72C865BCCC;
	Tue,  3 Feb 2026 05:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770096968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3KIIEfAQN9YX047MvUAtQhbHRSzfXzkurmgKcnHJx6Q=;
	b=wVBFzX3JHYleWmVgtYNk6Qf97IHWnsi9vGTA1S6/D39lFjMVT2z4H948Ws4w9lUbjVEUyv
	DmSiox83+3NH0wcslejtvVVdcfqh9CCdb4Oy7i6U7b2oYHzaHzGGqPmNv9hbZN9kVsK6rI
	AVmHuMrx461vmu1sOrOpo7aevxSs7Jo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770096968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3KIIEfAQN9YX047MvUAtQhbHRSzfXzkurmgKcnHJx6Q=;
	b=LcKWGTH+z4ePLVLlfaT+KSd1VhebbB+3zUS2WXar3GNqV6rJ6+CwS3r78n5Jr2rWjYJARc
	j6wv7rl+MMzI57Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Y+OMrhIt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ULSJKaHE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770096967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3KIIEfAQN9YX047MvUAtQhbHRSzfXzkurmgKcnHJx6Q=;
	b=Y+OMrhItjVMjsPpIvVseLAkvvgQxaMq4qsQTPKl1ZpKR3bY0EWiCbQcfPBkhuRJuf1BgDn
	bZ29TTTjf37l+vzALQ5JOapjMGDcOmK9iXGat361gf3UlhTt5LGoQKYx6LSOGn9m814z/D
	WELhKFn5Sbd0tuZuPhb0vkLl+mepItQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770096967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3KIIEfAQN9YX047MvUAtQhbHRSzfXzkurmgKcnHJx6Q=;
	b=ULSJKaHEaE2Kx+rBRz6WZuNItXyffruN10BMWaho6FxCY5dSDtxC+EkxiNw/wah/+96s85
	COIK3kDkdXBpCmAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFF9B3EA62;
	Tue,  3 Feb 2026 05:36:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +2YBHEKJgWmmDAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Feb 2026 05:36:02 +0000
Message-ID: <fc21f807-91b8-4ef5-86a8-171932616567@suse.de>
Date: Tue, 3 Feb 2026 06:35:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] nvme-rdma: Use CCR to recover controller that
 hits an error
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-12-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260130223531.2478849-12-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[purestorage.com,broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 72C865BCCC
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_213612_316162_A42126B3 
X-CRM114-Status: GOOD (  14.61  )
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

On 1/30/26 23:34, Mohamed Khalfella wrote:
> An alive nvme controller that hits an error now will move to FENCING
> state instead of RESETTING state. ctrl->fencing_work attempts CCR to
> terminate inflight IOs. If CCR succeeds, switch to FENCED -> RESETTING
> and continue error recovery as usual. If CCR fails, the behavior depends
> on whether the subsystem supports CQT or not. If CQT is not supported
> then reset the controller immediately as if CCR succeeded in order to
> maintain the current behavior. If CQT is supported switch to time-based
> recovery. Schedule ctrl->fenced_work resets the controller when time
> based recovery finishes.
> 
> Either ctrl->err_work or ctrl->reset_work can run after a controller is
> fenced. Flush fencing work when either work run.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/rdma.c | 62 +++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 61 insertions(+), 1 deletion(-)
> 
The rdma driver is largely similar to the tcp one, so comments there
apply to both, one would guess.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

