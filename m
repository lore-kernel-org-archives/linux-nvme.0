Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D229CD4F52
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 08:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n+tkiZkbFahlsQ3PpXuWXmKySLsE4NqqO7zpi111kOU=; b=LELdy8e6Td6nqc4W70Ya7cHYlo
	qfAUNmJDznv5I6SsnyEdQznAIpXo0tnnLnTl6Pb4f5BXyPfjxlHrB0/ddsHGVb33p1cB0Y9HibiDd
	Fgs4gKsFBa1hlT861GD50WGD1MRpwLjtk/BdOf9N2/EszwYaAN0ZFDdD/qNiUKP1WTbaC7oNnN7Hi
	dYaXAFNYq2T2AtTxzrS0xwNBfa0odDnC5AnhJz8SeNmLUzhQyC6sr9zJIbwbKB1hjtPncavfryG6D
	WEeMU/17KVBMP/wlHqJHKeLFdRu4lqAgM1AfDy3FI0Q0o1UT+j7/fktptP1UtEJGqd2EaretZvDDD
	i+JTV8JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPFO9-00000000axP-2Ejr;
	Tue, 19 May 2026 08:01:17 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPFO6-00000000avw-3RGS
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 08:01:16 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 641C566DE0;
	Tue, 19 May 2026 08:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779177673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+tkiZkbFahlsQ3PpXuWXmKySLsE4NqqO7zpi111kOU=;
	b=dWgXVszOHSvTAxL1R6XhNnzAMF45MeoGSNYRk8y3Q36K/evpsAV6Q2lKNcZ/pF4N2LMgvA
	DY3y/HU4nTtxGZSOS2wxryKPj0xGEArw0CYElh60jcHkQ1Oegg3H8YCh7HoLDrtIlvuojR
	pqxjM7C2BSMJzgZuoDi8HCqcMGMVBSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779177673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+tkiZkbFahlsQ3PpXuWXmKySLsE4NqqO7zpi111kOU=;
	b=4U7yZB6/A3ReGNvSgiWPoMCuojXWYWhZV65WBrbGFj+rVAybJDMY18Oi5BSnPftt+kuPaG
	xgZFnbZ/ReOWhIAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eQXV43ea;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sphRMA2L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779177672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+tkiZkbFahlsQ3PpXuWXmKySLsE4NqqO7zpi111kOU=;
	b=eQXV43eaHNXfHxZvBEiZzBfUimYlNoFtK0FIMsSbwRV9n9TVNLYnQYnnFQADElbYlRXQPh
	p22gD8Cv/ivhNgFScbbcMKzvdKOy7CKx/dG5qD90UIq+vY+6ISTO43kc9CM+Ki3Uf+ImK+
	/DnJNrAx+SGFE1/GiBxVSscL/UZJLBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779177672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+tkiZkbFahlsQ3PpXuWXmKySLsE4NqqO7zpi111kOU=;
	b=sphRMA2L+WfjInq+EeM9tT+hMSMHvphQ0aASHDLqICExeREbsQ+U3p81gniIrzkdKZq5/1
	sL9oTJAe4ETcXmBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B494593A8;
	Tue, 19 May 2026 08:01:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id egXLDcgYDGoncQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 May 2026 08:01:12 +0000
Message-ID: <8fecedbf-1fdf-49ad-a7bf-f2ef2c68906c@suse.de>
Date: Tue, 19 May 2026 10:01:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 6/7] net/handshake: Close the submit-side sock_hold
 race
To: Chuck Lever <cel@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
 <20260518-handshake-file-pin-v1-6-4bbcb7e62fda@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260518-handshake-file-pin-v1-6-4bbcb7e62fda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,oracle.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 641C566DE0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_010115_009609_2A4C0EC5 
X-CRM114-Status: GOOD (  14.08  )
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

On 5/18/26 20:24, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> handshake_req_submit() publishes the request via
> handshake_req_hash_add() and __add_pending_locked(), drops
> hn_lock, and calls handshake_genl_notify() (which can sleep)
> before taking sock_hold() on req->hr_sk. A fast tlshd ACCEPT
> followed by DONE can drive handshake_complete()'s sock_put()
> into the window between the spin_unlock and the late
> sock_hold(); on a system where the consumer's fd held the
> only sk reference, the late sock_hold() then operates on an
> sk whose refcount has reached zero.
> 
> The preceding two patches install an explicit file reference
> on struct handshake_req. That file pins sock->file, which
> pins the embedded struct socket, which defers inet_release()'s
> sock_put(). As long as hr_file is held, sk cannot reach refcount
> zero from the consumer side, and the submit-side sock_hold()
> with its matching sock_put() calls in handshake_complete() and
> handshake_req_cancel() is now redundant.
> 
> Drop all three. Submit's pinning is strictly the file reference
> acquired earlier in the function, and the lifetime story is
> contained in a single get_file()/fput() pair.
> 
> Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/handshake/request.c | 12 ------------
>   1 file changed, 12 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

