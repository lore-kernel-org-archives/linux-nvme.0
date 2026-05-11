Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7820FCD37AC
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 09:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=44ovicq5CK3mSb7jkFtcwBBGSKF2FfmxRSXqQNOzrr8=; b=gaVyAMjPvl8ZiAHZIcGsPj+zzF
	aPD7XbqKSv1X8s5ihMGQ9r/MwvTEg9DLr1RCybQ8mjDGB/5H8Abn0KGw5SkkjxLhOgx48ZOX5nH2H
	lriD7/fs4BDaLZ8IY+J1hVFph0opEedbAWZradAQ1Y2sbrrWR0KgokyAWvlJwbwcLBUC3kUR1tviT
	E+yOQAdbKu51tO1OIg3Ap9lA2IuAJhElKGf8oLqqPFRx3cbVOLhRswgHJ3+MDKMgCOJsNDNQtMOcO
	B/n5XLhOdEgQxeY4tsrQdDij95jvG2N4WjKNqDr7gUnfmrvZXJf0lhBDYDZd0ChLGSomlFMRKD2+n
	AQH3GGuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMNMq-0000000D1VV-2zYj;
	Mon, 11 May 2026 09:56:04 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMNMo-0000000D1Ud-1Yps
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 09:56:03 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 73E546A7C8;
	Mon, 11 May 2026 09:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778493360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=44ovicq5CK3mSb7jkFtcwBBGSKF2FfmxRSXqQNOzrr8=;
	b=L29edVtro3Rx51W97qf9MeZnJqkgRt3+f0ZUyzID5XsWsv+uJt+wGJbOmSnjeVz1VrYjvC
	ppSrDTv0/Dd58Za+72a3QJe+25fCV2Y5Vtv2JDtVYuQakGFew6tPAM+dRY0Hi0U4qgAqQy
	FGHbqagkXWAuKtcqQfKkukWw6me1uj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778493360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=44ovicq5CK3mSb7jkFtcwBBGSKF2FfmxRSXqQNOzrr8=;
	b=mvrmXoPGIN0Pf6z+m5PnWcQHRI31nDF9Tf5Z5T7nTyN/spSuD0JSQSY2HjGr1RD6FAEZta
	CiKEd/GPTWmvNNCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778493359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=44ovicq5CK3mSb7jkFtcwBBGSKF2FfmxRSXqQNOzrr8=;
	b=TiV4YXBzwsQ4LKZEiYwlOuvYQ/rNj6s65aw8IZ0QUu3pwSkNsKN/W1hCowOCTcJZz5ImAC
	cZoqFx+Qy5X6H6JaRpyTYzbtunq+lCNp56ntSF7ACO/OlnzwHaIDVoFm5offtk3oVdmjaH
	IOx1rWgE4/e/TxayeDgV6gdBDyQjkQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778493359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=44ovicq5CK3mSb7jkFtcwBBGSKF2FfmxRSXqQNOzrr8=;
	b=12Bh7/4FyWlnmJ9UHdYmdW6mF1OHcKDHduriqRqPlv8heJN5RW73dEApXuoYYASjtK1dFE
	g8wuwgV/g0WA+qDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C5F5593A3;
	Mon, 11 May 2026 09:55:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tk9ODq+nAWp3SgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 11 May 2026 09:55:59 +0000
Message-ID: <917e7f85-4f4e-4fdf-9c9b-b0cdd70f0596@suse.de>
Date: Mon, 11 May 2026 11:55:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 8/9] nvmet-loop: do not alloc admin tag set during
 reset
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com,
 linux-nvme@lists.infradead.org, dwagner@suse.de, mlombard@arkamax.eu,
 mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org,
 hch@lst.de
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-9-mlombard@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260508133335.98612-9-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_025602_560702_5C2107D8 
X-CRM114-Status: GOOD (  12.49  )
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

On 5/8/26 15:33, Maurizio Lombardi wrote:
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
>    nvme_loop_delete_ctrl_host() and the terminal error-handling
>    paths of nvme_loop_reset_ctrl_work() and
>    nvme_loop_create_ctrl().
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/target/loop.c | 31 ++++++++++++++++---------------
>   1 file changed, 16 insertions(+), 15 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

