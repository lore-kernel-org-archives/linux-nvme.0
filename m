Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06F7CFD2F6
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Dec 2025 15:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LNeLGy/zjpql2kXCkFr8XeMTEV3ES+WnHxQAyPKOG9k=; b=NZi/dKx4SYgSL93h4DvrjVwh0S
	fiH9xOMJ4w5kvcQOvRizAeGlB/8a7xdy7jsiGrs3NwqXZf+IWktvKgvp4h0X2/MGBNEPdMK06XH9h
	AiuvY+1rzQrl3QgvwEv0WM0/vr7Eyj5loqwHPMWocINiYluCN11ybyLp8fnPtnNf865wzzbjFZmLU
	J3m0isj8rfE7QUYh6mNE2fVhU+0rHSeFPQSYEgLps5GxcD6sgTxwPwqHzefO/+HQ8cNjhE+OX3VnQ
	Ipl2QRDUOp53OXW4VyYkBOwquKs4781BYrHagK6eZyXcej5IBYnU513eciOlxl6/pJEbj4+rHI+R0
	47YBPp1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQSOX-00000005Yjd-2nLy;
	Tue, 02 Dec 2025 15:34:25 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQSOV-00000005YjA-1HmA
	for linux-nvme@lists.infradead.org;
	Tue, 02 Dec 2025 15:34:24 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2609F5BD4D;
	Tue,  2 Dec 2025 15:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764689660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LNeLGy/zjpql2kXCkFr8XeMTEV3ES+WnHxQAyPKOG9k=;
	b=EE7v91ofMqIJjZw6P7uIQw3P0TzAgu57QzOsutslnBOavY4QhpjhPk005WRWFKKfYoDHYL
	wigkQ2mw7yJ7oZlrgSmFlxtykJZbdM3pyFVgcQGo3NLTkFXxFWTIGFOldg3Q8vN3P90NGF
	bpc+pQVSjDljvRrcNJcw7IALIt7Th3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764689660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LNeLGy/zjpql2kXCkFr8XeMTEV3ES+WnHxQAyPKOG9k=;
	b=r/LgDe3sQvGySTYKr44DkBTtHn4ahnkbF+/7mQ5JGLbY2aLkbntrELovOBI2eJTGGfPoqY
	ZCJCpq2iTVPwKKAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=W5XJk3j5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hQPOlI+G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764689659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LNeLGy/zjpql2kXCkFr8XeMTEV3ES+WnHxQAyPKOG9k=;
	b=W5XJk3j5wGIdemV+j/85yZIf2d2VHDrFEVmz6+9j7P02YIl/d92vcwpyYX6ZWMXu1cz3WB
	7BSmqco9ui7hRpPivBDXeAmwqAFyQ7qSBF5m6r5pCJVnlSlWMRruevlrPRh/P9r+3eMQ9g
	AkteitjkzV6LJpdV49Q2n0RT9aGff+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764689659;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LNeLGy/zjpql2kXCkFr8XeMTEV3ES+WnHxQAyPKOG9k=;
	b=hQPOlI+GC9fTYPgcevMNmI5InxIIJhYfrf2tCBpfv9xTnPhiJeyG/hdBR6scTRdsMCXTv8
	o44fr9T/ntbuxxCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1E773EA63;
	Tue,  2 Dec 2025 15:34:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id shUrLvoGL2k8MwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 02 Dec 2025 15:34:18 +0000
Message-ID: <4b5a6010-3404-43ab-8964-d704dbeac6d9@suse.de>
Date: Tue, 2 Dec 2025 16:34:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] net/handshake: Define handshake_req_keyupdate
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20251202013429.1199659-1-alistair.francis@wdc.com>
 <20251202013429.1199659-3-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251202013429.1199659-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2609F5BD4D
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.de:email,wdc.com:email];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251202_073423_514016_6E212BA8 
X-CRM114-Status: GOOD (  14.66  )
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

On 12/2/25 02:34, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Add a new handshake_req_keyupdate() function which is similar to the
> existing handshake_req_submit().
> 
> The new handshake_req_keyupdate() does not add the request to the hash
> table (unlike handshake_req_submit()) but instead uses the existing
> request from the initial handshake.
> 
> During the initial handshake handshake_req_submit() will add the request
> to the hash table. The request will not be removed from the hash table
> unless the socket is closed (reference count hits zero).
> 
> After the initial handshake handshake_req_keyupdate() can be used to re-use
> the existing request in the hash table to trigger a KeyUpdate with
> userspace.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v6:
>   - New patch
> 
>   net/handshake/handshake.h |  2 +
>   net/handshake/request.c   | 95 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 97 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

