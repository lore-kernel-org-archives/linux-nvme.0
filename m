Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FE4CD3442
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2026 16:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iM+EMqG67ceDlpyz95HT7CE+0h/SErmaAKzkWX9kyTQ=; b=KQZ/VdpFbrG0d5VKhXMoK8YHdx
	nvAa78YiuYgbMAFvvWCf23C50FxKe0Z1UpRfgqi2gM4Eu4ep+QfU+AAtjiBuNO3o+U00BupeY4CAM
	3j5WVq8HbLlWQaM3eC2WqLcFfn5v6JUxDSyhITvBI/YAVcAFzrquLGfmjQENLFhznB3bH7KYxAchF
	vkvuPRTUqZkpmrFRajPL5HCzyr5B4wYvAx0ORU/4GHgxw3fNyBvSB3laY4ymhvQd5cTGe7D4iBoML
	WngClqDAKN6KFPb+DaiUwpqVpccuiMklUHVrSXqnWQRQK5aDtHuOzho4Sk3J+OycNenX7yoDVqlGK
	GPJvOfPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL1Vn-00000004K25-41ds;
	Thu, 07 May 2026 16:23:43 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL1Vg-00000004K1K-3fFx
	for linux-nvme@lists.infradead.org;
	Thu, 07 May 2026 16:23:38 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3FD1C5C60F;
	Thu,  7 May 2026 16:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778171013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iM+EMqG67ceDlpyz95HT7CE+0h/SErmaAKzkWX9kyTQ=;
	b=bfsMVyZ40gY4Cg2NV+kAfZPpdig+oLOXDAsTViUebcSdW361TXRO6ItxT6fwmS1oRSpepW
	/ZZeBO+hszWhPvR6CrBtrkGk4PFTVkCi71YIjDpMiLVBbsCQeUuluYZWgVW+WzXk7djca6
	dC7Cl91biYqLwANuXjSrtpBhvsVmef4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778171013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iM+EMqG67ceDlpyz95HT7CE+0h/SErmaAKzkWX9kyTQ=;
	b=mSAN6byIMRUYVpX5i901RNtC4p18d/SE9YrMHAwJJzOm7AC0H+oB+tap6XHbBeFU7HPm6x
	YJzQS38KJQQVARDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778171013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iM+EMqG67ceDlpyz95HT7CE+0h/SErmaAKzkWX9kyTQ=;
	b=bfsMVyZ40gY4Cg2NV+kAfZPpdig+oLOXDAsTViUebcSdW361TXRO6ItxT6fwmS1oRSpepW
	/ZZeBO+hszWhPvR6CrBtrkGk4PFTVkCi71YIjDpMiLVBbsCQeUuluYZWgVW+WzXk7djca6
	dC7Cl91biYqLwANuXjSrtpBhvsVmef4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778171013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iM+EMqG67ceDlpyz95HT7CE+0h/SErmaAKzkWX9kyTQ=;
	b=mSAN6byIMRUYVpX5i901RNtC4p18d/SE9YrMHAwJJzOm7AC0H+oB+tap6XHbBeFU7HPm6x
	YJzQS38KJQQVARDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8871593A7;
	Thu,  7 May 2026 16:23:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gEoqM4S8/GmaKQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 07 May 2026 16:23:32 +0000
Message-ID: <b0e028bb-839a-476d-a640-690a301bd8f6@suse.de>
Date: Thu, 7 May 2026 18:23:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 7/8] nvmet-loop: do not alloc admin tag set during
 reset
To: Maurizio Lombardi <mlombard@arkamax.eu>,
 Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com,
 jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
 mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org,
 hch@lst.de
References: <20260410073924.61078-1-mlombard@redhat.com>
 <20260410073924.61078-8-mlombard@redhat.com>
 <8babbc78-701d-4308-b325-b4b2bab5d2c2@flourine.local>
 <DI4QV80PTNP9.1ZY7L7GFJ8TX5@arkamax.eu>
Content-Language: en-US
From: Daniel Wagner <dwagner@suse.de>
In-Reply-To: <DI4QV80PTNP9.1ZY7L7GFJ8TX5@arkamax.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260507_092337_579032_BEE66F5E 
X-CRM114-Status: GOOD (  13.38  )
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

Hi Maurizio,

On 4/28/26 1:17 PM, Maurizio Lombardi wrote:
> It would be something like this (just a compile tested draft,
> I still need to properly test it, but it should give you an idea):
> 
> 
> nvmet-loop: do not alloc admin tag set during reset
> 
> Currently, resetting a loopback controller unconditionally invokes
> nvme_alloc_admin_tag_set() inside nvme_loop_configure_admin_queue().
> Doing so drops the old queue and allocates a new one. Consequently,
> this reverts the admin queue's timeout (q->rq_timeout) back to the
> module default (NVME_ADMIN_TIMEOUT), completely wiping out any custom
> timeout values the user may have configured via sysfs and potentially
> racing against the sysfs nvme_admin_timeout_store() function
> that may dereference the admin_q pointer during the RESETTING state.
> 
> Decouple the admin tag set lifecycle from the admin queue
> configuration and destruction paths, which are executed during resets;
> Specifically:
> 
> * Move nvme_alloc_admin_tag_set() into nvme_loop_create_ctrl() so it
>    is only allocated once during the initial controller creation.
> 
> * Defer the destruction of the admin tag set to
>    nvme_loop_delete_ctrl_host(), the terminal error-handling
>    paths of nvme_loop_reset_ctrl_work() and
>    nvme_loop_create_ctrl().

This looks way better IMO. So yes please, add use this version.

Thanks,
Daniel

