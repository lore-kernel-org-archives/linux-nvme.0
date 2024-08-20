Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6656C531DC
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Aug 2024 14:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CsgPtatDExPP1jrSfSsmW8hqO74SxPHgUyBqFyAc7/o=; b=C2mp2omUQMvmOGTUL9f5sPe42j
	ev8z0ibinMQcbS2FfoGondUSWx5mTwNQAuaVvuUzWvWN+VPgAFdOX1KoWSQTPxghD8RI5URkT1ha2
	UJNuM0AnbifBVjwT5k7Js+qtVCk39VJS1ixqF1xg3h4NymyphzwkjiAcmze+GG64aksgvR3FvRirs
	XrlC9zMNaDQBkzi2cTOrGhlFT4/NrWtIGRpRgCL74QV7ogexCJe47emuAVc0o6xTlbWXp6pdSrz+p
	RwbzmRAP5tqQH0enowU0AJQIUbXtQA+uWkyt3STuFHikFXQKu/6gU0Axda7PShFiQvLMOm08xDTjg
	J739Fz/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgPX5-00000005ToU-2X7Z;
	Tue, 20 Aug 2024 14:08:23 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgPV6-00000005TGJ-3Yyr
	for linux-nvme@lists.infradead.org;
	Tue, 20 Aug 2024 14:06:24 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 92FF91FFF9
	for <linux-nvme@lists.infradead.org>; Tue, 20 Aug 2024 14:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724162777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CsgPtatDExPP1jrSfSsmW8hqO74SxPHgUyBqFyAc7/o=;
	b=1tm9qoxkLL8LRYxFbH038pOU7sjd6FAriwzhszdb8McIYZ5hc/iygI+tic75nJmTMQlW6t
	KIQvciyzwhxyjhgoGM+cQ9CfEvKY2K/HZj4I7asVXQ7GqyeCXuYU+j5pZn93UkxLEhUM9J
	mPSW35pe4btRQIBjmF569qWHPRtpPL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724162777;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CsgPtatDExPP1jrSfSsmW8hqO74SxPHgUyBqFyAc7/o=;
	b=Ddxn2ZgKVKZjYfr8+LzBQirRmQD9s2jEiE/C+o+2aHkV/21Khn+YMfVaeTwEUZLBkCgqdu
	SsoxxB6BamJDCADQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724162777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CsgPtatDExPP1jrSfSsmW8hqO74SxPHgUyBqFyAc7/o=;
	b=1tm9qoxkLL8LRYxFbH038pOU7sjd6FAriwzhszdb8McIYZ5hc/iygI+tic75nJmTMQlW6t
	KIQvciyzwhxyjhgoGM+cQ9CfEvKY2K/HZj4I7asVXQ7GqyeCXuYU+j5pZn93UkxLEhUM9J
	mPSW35pe4btRQIBjmF569qWHPRtpPL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724162777;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CsgPtatDExPP1jrSfSsmW8hqO74SxPHgUyBqFyAc7/o=;
	b=Ddxn2ZgKVKZjYfr8+LzBQirRmQD9s2jEiE/C+o+2aHkV/21Khn+YMfVaeTwEUZLBkCgqdu
	SsoxxB6BamJDCADQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85A5813A17
	for <linux-nvme@lists.infradead.org>; Tue, 20 Aug 2024 14:06:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0U8WH9mixGZnGwAAD6G6ig
	(envelope-from <hare@suse.de>)
	for <linux-nvme@lists.infradead.org>; Tue, 20 Aug 2024 14:06:17 +0000
Message-ID: <98c91e6e-e390-45a7-81fa-a4eaa7e85b44@suse.de>
Date: Tue, 20 Aug 2024 16:06:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvme: restrict authentication to the admin queue
To: linux-nvme@lists.infradead.org
References: <20240717110338.27332-1-hare@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240717110338.27332-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	PREVIOUSLY_DELIVERED(0.00)[linux-nvme@lists.infradead.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240820_070621_061164_55A23B67 
X-CRM114-Status: GOOD (  15.63  )
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

On 7/17/24 13:03, Hannes Reinecke wrote:
> Hi all,
> 
> it might be an idea to restrict authentication to the admin queue only,
> as authentication on I/O queues brings only so much additional benefit,
> and the entire authentication is noticeably faster.
> This patchsets enables the host to handle this situation, and adds a
> new configfs entry 'dhchap_admin_only' for the target to enable this
> behaviour.
> Patches are on top of my 'secure-concat.v5' branch on kernel.org.
> 
> As usual, comments and reviews are welcome.
> 
> Hannes Reinecke (2):
>    nvme: Do not re-authenticate queues with no prior authentication
>    nvmet: Implement 'admin_only' authentication
> 
>   drivers/nvme/host/auth.c               | 17 ++++++++++++++++-
>   drivers/nvme/target/auth.c             | 11 +++++++----
>   drivers/nvme/target/configfs.c         | 24 ++++++++++++++++++++++++
>   drivers/nvme/target/fabrics-cmd-auth.c |  7 +++++++
>   drivers/nvme/target/fabrics-cmd.c      |  7 +++++--
>   drivers/nvme/target/nvmet.h            |  2 ++
>   6 files changed, 61 insertions(+), 7 deletions(-)
> 
Ping? What's the status here? Should I resend?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


