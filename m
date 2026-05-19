Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD3DCD4851
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 08:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=STwL8GvCZtScpGgUVumoXH1C8pO1Bs/hWghMOOBjJzI=; b=npP4O+qutplF4eBppnQWlQhkmD
	PQiZvdAAhb7t8AFvog357lrvq1ErVc20raHBstqsBC8t9g2xmI5E1UIzfsE+gnL+tO6zJPdCraDZ/
	MSRtvww6LsiBT57ObWuNDXn6gQsCje08E/2XW5kEqaxf17czz2JUj1IiX+fTDoIM4VlrTn4WKsFq1
	4YZSLHRjbBHCOZBIHityK4dSjiGicFfwSeFR0/Kil52xHjadT2y0Ckw3kOTKYnsPEIlu7w9Sg0kOC
	gNNMDsYnSYgFEnut/QSyit2OnAKFOYsu7XyhzhviCPC7E43WDi4VfalwJ34+kCP+KHgiebMq659Jz
	AHCNgAmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPG8m-00000000jzT-3p5F;
	Tue, 19 May 2026 08:49:28 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPG8j-00000000jyU-3lHe
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 08:49:27 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E4A9C5E0BE;
	Tue, 19 May 2026 08:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779180564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STwL8GvCZtScpGgUVumoXH1C8pO1Bs/hWghMOOBjJzI=;
	b=rFrNYMlqlJcvYdgmlgfX2YB7x4ivn103hK7Wj7PIgFuiO2fMin38FyJCNLNnLJ2SMNjf+f
	AHLlL4r13h46wOFCUut8e2qc4V6LtJGMISoAjpbR1aMBAQRa69NTrl92AU94v/usgkNPxA
	SyMl+XvXNvKEx95DigGIDgAoMAk0SJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779180564;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STwL8GvCZtScpGgUVumoXH1C8pO1Bs/hWghMOOBjJzI=;
	b=12VNs1d9P7VglP9fAjy2buakp4dr/B7DdAVCVnQ7t7boGcN7apAVzxyVUrDHl+L/FWsJLa
	93ou3OCAbYELsKDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VXBjdnOi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="n/TY2cN3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779180563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STwL8GvCZtScpGgUVumoXH1C8pO1Bs/hWghMOOBjJzI=;
	b=VXBjdnOiCoLzWyAv+BQPNbVffUMn/otWUf3pC/TAr9ojmvWIb4eJHq49xG59itOFfvKOmq
	gZ+jZNKYMV2HVkwjsrhz1gnEpUDfij6gmSzNfVNmmKiSIDWL7+EF8CsskD0Ids5tcRppAU
	FY6GUlffXW3lPArf2Z+qtUcS3lNJmwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779180563;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STwL8GvCZtScpGgUVumoXH1C8pO1Bs/hWghMOOBjJzI=;
	b=n/TY2cN3IgpVkQNB+9yRL5OHJfcZbBgfd4gAkHrC0R+OtiDkzFTjJ8JXQKU6VESixNDflq
	6al535ipksLxDVAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B83C2593A8;
	Tue, 19 May 2026 08:49:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QXGdKxMkDGrCIgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 May 2026 08:49:23 +0000
Message-ID: <851abf6e-1349-413f-9b91-b59810fa5e2a@suse.de>
Date: Tue, 19 May 2026 10:49:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 3/7] nvme: add sysfs attribute to change admin timeout
 per nvme controller
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com,
 linux-nvme@lists.infradead.org, dwagner@suse.de, mlombard@arkamax.eu,
 mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org,
 hch@lst.de
References: <20260514083255.41109-1-mlombard@redhat.com>
 <20260514083255.41109-4-mlombard@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260514083255.41109-4-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim,suse.de:mid,grimberg.me:email];
	URIBL_BLOCKED(0.00)[grimberg.me:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim,suse.de:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E4A9C5E0BE
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_014926_081980_22D82063 
X-CRM114-Status: GOOD (  12.59  )
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

On 5/14/26 10:32, Maurizio Lombardi wrote:
> Currently, there is no method to adjust the timeout values on a
> per-controller basis with nvme admin queues.
> Add an admin_timeout attribute to nvme so that different nvme controllers
> which may have different timeout requirements can have custom admin
> timeouts set.
> 
> The admin timeout is also applied to the fabrics queue (fabrics_q).
> The fabrics queue is utilized for fabric-specific administrative and
> control operations, such as Connect and Property Get/Set commands.
> 
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/host/core.c  |  1 +
>   drivers/nvme/host/nvme.h  |  1 +
>   drivers/nvme/host/pci.c   |  2 +-
>   drivers/nvme/host/sysfs.c | 41 +++++++++++++++++++++++++++++++++++++++
>   4 files changed, 44 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

