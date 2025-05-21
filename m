Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388DAC2D0CD
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 10:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fcxd8g5b5LVlH9ETZbXkzCfIBrcRd911KmW5mOi+rYQ=; b=YFF4H4Kj/kLic//6vzcv+RCqaD
	vONkvLFzpg2X0ZVJ7jrU4GyoCHavod1Uh4qpvZ3+Eb+4TBoaxOXl2Gao4+a4rHZtdFn97yATv/qbu
	x8fVM4KWzHZSrIsbrV6E4nFGBB3WFzT+at8dTAHFCVLXkCmH6f6/VycalyR710ZPFcAoCq/3eDGWR
	opcGf++lb8BSVA5pKRn5o1W2hKy5J9vlu2KCLYhX1khySvUUsK/rPURjU1dQ+Q1PQrfpRVq3NAKkO
	Q/8tb3HzHUBFKhN34BGv5hdCh/v4e5BLEHFnbIxfPTMv8vTBDhpYv9J0j20om+RfJvHwZkriu3qTV
	Qi12nx1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHgiF-0000000FTbC-2E0v;
	Wed, 21 May 2025 10:30:15 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHgW0-0000000FQmQ-0cK9
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 10:17:37 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BED3922436;
	Wed, 21 May 2025 10:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcxd8g5b5LVlH9ETZbXkzCfIBrcRd911KmW5mOi+rYQ=;
	b=BPRI0ioiEdjk3AcbDRMMrlXUroHEzhI8OJ3d73iha6czXodvKCp3UR/9haCrHiSYx02pUD
	/644klZxV5wu+4+0rM5tQ+hjBCSC+3KnfbDjrDCysdmjxLrhymDsWFqy2DBzWeGiyK85Z8
	ACBq6oArABQEDpJpzpZ/7uYSPYSAp68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcxd8g5b5LVlH9ETZbXkzCfIBrcRd911KmW5mOi+rYQ=;
	b=I5wFhC9LXjmpHUiM0WD+/40yRVsi5v2LS6YlY8690tt6dMM/N/2rZ6VMB/CgZjRO+oout0
	c5nNOqxv7DPMejBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcxd8g5b5LVlH9ETZbXkzCfIBrcRd911KmW5mOi+rYQ=;
	b=BPRI0ioiEdjk3AcbDRMMrlXUroHEzhI8OJ3d73iha6czXodvKCp3UR/9haCrHiSYx02pUD
	/644klZxV5wu+4+0rM5tQ+hjBCSC+3KnfbDjrDCysdmjxLrhymDsWFqy2DBzWeGiyK85Z8
	ACBq6oArABQEDpJpzpZ/7uYSPYSAp68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcxd8g5b5LVlH9ETZbXkzCfIBrcRd911KmW5mOi+rYQ=;
	b=I5wFhC9LXjmpHUiM0WD+/40yRVsi5v2LS6YlY8690tt6dMM/N/2rZ6VMB/CgZjRO+oout0
	c5nNOqxv7DPMejBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7206813AA0;
	Wed, 21 May 2025 10:17:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cinuFT6oLWh2TQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 May 2025 10:17:34 +0000
Message-ID: <f3731222-9666-4813-aac9-050f8b40844d@suse.de>
Date: Wed, 21 May 2025 12:17:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] nvme-tcp: use crc32c() and
 skb_copy_and_crc32c_datagram_iter()
To: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20250519175012.36581-1-ebiggers@kernel.org>
 <20250519175012.36581-10-ebiggers@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250519175012.36581-10-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,iogearbox.net,gmail.com,grimberg.me,kernel.org,lst.de];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_031736_470594_BD038611 
X-CRM114-Status: GOOD (  12.25  )
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

On 5/19/25 19:50, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Now that the crc32c() library function directly takes advantage of
> architecture-specific optimizations and there also now exists a function
> skb_copy_and_crc32c_datagram_iter(), it is unnecessary to go through the
> crypto_ahash API.  Just use those functions.  This is much simpler, and
> it also improves performance due to eliminating the crypto API overhead.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   drivers/nvme/host/Kconfig |   4 +-
>   drivers/nvme/host/tcp.c   | 124 ++++++++++++--------------------------
>   2 files changed, 42 insertions(+), 86 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

