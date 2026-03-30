Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AFEFB3D00
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Mar 2026 10:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xUYgtWSkD23iS2hN+E5og2Pq6uOO1yiKUVexXSUvCEc=; b=bsY6kMuEo40KXgxUOTbWvB2e5w
	NMP3OmtGgTwOTTDLqX4EaeRVPQND2xZokBlgXz5IF+r14ISImgaQeIRBR1J8dtXFrxb3oFsoBVDwq
	aD3DwusCw+ACP3ZvcQT56ZuUfimhoaFKXjX0IlyhzwMSOHX+/vjP5+PNAdY9Er4+t0jQ+8c2twAiH
	O30E9ys6ms8A2fNIvU+PgRbKYYUcMmKPpi8SlJeVDSz7S4V6PmiBHT5rtWn9A3Yjs/KTDveKkSL+3
	4ML9uMADGik2zqbgM7aVt/GHdkGmMxm3DFCaek5FCNotzhP1AsOoR0s7XC+xZpHRH+x68+y5Qzkz7
	fIBCPbSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7A9A-0000000B5nX-0aM2;
	Mon, 30 Mar 2026 10:47:04 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7A97-0000000B5n5-2iHl
	for linux-nvme@lists.infradead.org;
	Mon, 30 Mar 2026 10:47:02 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 997F55BD2D;
	Mon, 30 Mar 2026 10:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774867619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xUYgtWSkD23iS2hN+E5og2Pq6uOO1yiKUVexXSUvCEc=;
	b=uGNpqmxPDdYoULeVpdEctfvUe0WpgO/uV4OTBZSdWtwpG/wxBQOPMWImYefPWzTh1zC/y3
	DP5rTivktaqQhj5fnRBY4LXTIGK2bb3nnQpEryzVsdV5aMWzDsxlJAVq2uy+11B9e50LvH
	KHewRa16IOMFcIJf8CK+ov3d1fpeDFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774867619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xUYgtWSkD23iS2hN+E5og2Pq6uOO1yiKUVexXSUvCEc=;
	b=kKcsaaZ+zJxZi6RXn08GM30iDWod+AMy1vX3sr8j97QdNZWZkY0U+kOKPwOKVehEthUd+Z
	kURAi9XcrnrcivBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uGNpqmxP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kKcsaaZ+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774867619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xUYgtWSkD23iS2hN+E5og2Pq6uOO1yiKUVexXSUvCEc=;
	b=uGNpqmxPDdYoULeVpdEctfvUe0WpgO/uV4OTBZSdWtwpG/wxBQOPMWImYefPWzTh1zC/y3
	DP5rTivktaqQhj5fnRBY4LXTIGK2bb3nnQpEryzVsdV5aMWzDsxlJAVq2uy+11B9e50LvH
	KHewRa16IOMFcIJf8CK+ov3d1fpeDFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774867619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xUYgtWSkD23iS2hN+E5og2Pq6uOO1yiKUVexXSUvCEc=;
	b=kKcsaaZ+zJxZi6RXn08GM30iDWod+AMy1vX3sr8j97QdNZWZkY0U+kOKPwOKVehEthUd+Z
	kURAi9XcrnrcivBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6447C4A0A2;
	Mon, 30 Mar 2026 10:46:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l1VSF6NUymltcwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 30 Mar 2026 10:46:59 +0000
Message-ID: <75cec270-3376-4613-b2e7-c8610f8abe5c@suse.de>
Date: Mon, 30 Mar 2026 12:46:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/15] nvme: Introduce FENCING and FENCED controller
 states
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart833426@gmail.com>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
 <20260328004518.1729186-8-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260328004518.1729186-8-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[purestorage.com,broadcom.com,gmail.com,nvidia.com,kernel.dk,kernel.org,grimberg.me];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Queue-Id: 997F55BD2D
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260330_034701_830173_880A86F7 
X-CRM114-Status: GOOD (  14.75  )
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

On 3/28/26 01:43, Mohamed Khalfella wrote:
> FENCING is a new controller state that a LIVE controller enters when an
> error is encountered. While in FENCING state, inflight IOs that timeout
> are not canceled because they should be held until either CCR succeeds
> or time-based recovery completes. While the queues remain alive, requests
> are not allowed to be sent in this state, and the controller cannot be
> reset or deleted. This is intentional because resetting or deleting the
> controller results in canceling inflight IOs.
> 
> FENCED is a short-term state the controller enters before it is reset.
> It exists only to prevent manual resets from happening while controller
> is in FENCING state.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/core.c  | 27 +++++++++++++++++++++++++--
>   drivers/nvme/host/nvme.h  |  4 ++++
>   drivers/nvme/host/sysfs.c |  2 ++
>   3 files changed, 31 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

