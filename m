Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A01CCF9F8
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Nov 2025 07:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YcnGWYma/a63ZuZCz+Xvha5mqSnjWCOzwOq4Z6jHBVM=; b=T5339mFx0xbFP3jorWAhXhzTZ6
	HIiKA4OYUt2bqJxVs4VYTfWg63lKOIQ0UxSoFhLR6htz2npZtpm1xXXR0FLW/S+R8cPtMuF9sUOYM
	axqcbJa11qxLMVFAwisYhLCuXJv84oLXL705sBc40HTEUtDQlwfkL/qjMoHfljkUKUzjI3e1+pHXd
	i4XvF70VSM9gCpbVZUn5r0EoKruqE/ypLWM16hf2oXZ+gh/+yP6576bmE26vWWo4FnqN1pJRnn2ho
	7BCeIYkjTjQOrQgUeGEgtCI+rT3/bKkbAb8kpJsdJO+MrMvzoD+e6GYUAhrzhjSmcvOHA/E3yVa3R
	x821qJYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ4vh-00000008Frz-1yqk;
	Wed, 12 Nov 2025 07:06:09 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ4va-00000008FrG-1HNB
	for linux-nvme@lists.infradead.org;
	Wed, 12 Nov 2025 07:06:08 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5B40B21A91;
	Wed, 12 Nov 2025 07:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762931157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcnGWYma/a63ZuZCz+Xvha5mqSnjWCOzwOq4Z6jHBVM=;
	b=GiOuPgSTWXAhHi1c7kWEzvZWLeJs0H3AUVO2FAOqOOnYAviqSse80KMuAa7u/hHnU5pQm4
	Y2qkfBahJhvm7bsakmggLNx69HN4yTn8uTEQIzJI3Z+DXhG+MNw/YAM8eAbPjIBxmCzeT4
	TBJcjHFvrbLbpkbRNPcfWce1eRnXOkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762931157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcnGWYma/a63ZuZCz+Xvha5mqSnjWCOzwOq4Z6jHBVM=;
	b=b2GRBJPGLtSPvpFhEgK8UppNrDKU8su2CMtYw9TWeqIHzoo6dd2MF1EZJqTG1oyMQbtG01
	ZT3b08iiKdURarAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wLAJrC5+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xnSFYDxi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762931156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcnGWYma/a63ZuZCz+Xvha5mqSnjWCOzwOq4Z6jHBVM=;
	b=wLAJrC5+5CdI63hvIo6YvtXnIBcFX+cNRnc/RTqppg3dzTOlCUk4fmb162QDefCRiwMnR0
	ve2ZLKNcBjR5Vi9AuKgvwJKvR3228Skzuv6/FSBZgYwgg/vGpDawGpUR49qnVEDOMVoAD3
	hy7H6OUbKIxqe7bLiDEZbwA4e0jyf0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762931156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcnGWYma/a63ZuZCz+Xvha5mqSnjWCOzwOq4Z6jHBVM=;
	b=xnSFYDxig7ta+6Es1T9SpmOMbOhMQ96TedL0IxQeE0tT7Y6QhurllHVDoKWblsHylSP7n+
	n90CP4nC3WuKyRCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E672D14DC2;
	Wed, 12 Nov 2025 07:05:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UtyyNdMxFGlVcgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 12 Nov 2025 07:05:55 +0000
Message-ID: <92761459-4d5f-4cca-b0b6-fc359f07ba69@suse.de>
Date: Wed, 12 Nov 2025 08:05:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] nvmet-tcp: Don't error if TLS is enabed on a reset
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20251111234519.3467440-1-alistair.francis@wdc.com>
 <20251111234519.3467440-2-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251111234519.3467440-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5B40B21A91
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me,nvidia.com,lists.infradead.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_230602_523840_D512D70C 
X-CRM114-Status: GOOD (  12.50  )
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

On 11/12/25 00:45, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> If the host sends a AUTH_Negotiate Message on the admin queue with
> REPLACETLSPSK set then we expect and require a TLS connection and
> shouldn't report an error if TLS is enabled.
> 
> This change only enforces the nvmet_queue_tls_keyid() check if we aren't
> resetting the negotiation.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v2:
>   - Fixup long line
> 
>   drivers/nvme/target/auth.c             | 4 ++--
>   drivers/nvme/target/core.c             | 2 +-
>   drivers/nvme/target/fabrics-cmd-auth.c | 3 ++-
>   drivers/nvme/target/nvmet.h            | 4 ++--
>   4 files changed, 7 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

