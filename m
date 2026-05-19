Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BA1CD4F5B
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 07:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gs9k8KdLzc/e52jeBD+E/kRY12OZR57QS+tDyPt1+6s=; b=kddrZnha+5P0XCJduEspK+o70y
	SD6McTB/DUFg+Bgl8AJcrtgKB51LkQ4ydJVpwd6luVHLuIP8HUu8sgZorIv9po2qdLisbNNRzN8fQ
	ZqdjghZUAgvA0/J+AhSnleatFI+jmO0NfL99eZExFGCGISL7S2oczF37G7a/rNAT0LFqJXv2JT2Wp
	zumHgLFP1/aAArKnEpuUVFJRtTWOHxRfFw2lcFeM0sNpXEMhBnmLAf0xXEp45iHTKQ2a7689Kv2FZ
	a/xvgJ6Ifqq+lYszX51rMBEm8YDVan7cEHaenxt8KpQyYriFrvcVBWWjHkxAXaAXf3BpNVzlkWcnE
	FJAV1Vfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPFAY-00000000YZp-1PV0;
	Tue, 19 May 2026 07:47:14 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPFAU-00000000YYw-481V
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 07:47:13 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D340E6A87E;
	Tue, 19 May 2026 07:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779176828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gs9k8KdLzc/e52jeBD+E/kRY12OZR57QS+tDyPt1+6s=;
	b=BT9lY7XaMOXE2QxpzLbKfmE8iPaN7bVwCbACJMORW5z+HFegvmfDjvReIpa9SdzG4okcXM
	DpsbMZkRm1JIMS7Vf0bT0liPWJsmoX2aBVjDtr4l3qG/ds1BDzABCSL8Yq9hl7PVtMWcPx
	iMvSTwKomJFhwKEoorF8jvIBJnnMDVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779176828;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gs9k8KdLzc/e52jeBD+E/kRY12OZR57QS+tDyPt1+6s=;
	b=RRGWgfTfhEgSJY97glMUtN3oKsCR8zA5oPxRJfKIVjZaTCLaqip834AKqwaQXwVYUoxWg5
	GqakPJf2VGoq6rAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FLl1CWGL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="C/hLsOIX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779176824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gs9k8KdLzc/e52jeBD+E/kRY12OZR57QS+tDyPt1+6s=;
	b=FLl1CWGLJJeMWjwK6hzZcNkXwjTlCsMUQL7PrrjIiYrPbIkaAKKsqA76KBA4bqnMdOVI29
	ANhcF6QH9vXkUmnmDYs5ATpqtj+zTy+zTnnRzTXB5qk3eGtmvedDOxUIxaQEXmgsDVAEZO
	wo8CarcJ0KULU7bUMDtG9eA7ShimTAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779176824;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gs9k8KdLzc/e52jeBD+E/kRY12OZR57QS+tDyPt1+6s=;
	b=C/hLsOIXoKkTkYGnRXAP+oXTXT1l4fpx31Oc/AlZURDa3cObHMPtf3PeTdn/xuxyl2Kmrr
	hjY8GyHfBsOWsTCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99FCB593A8;
	Tue, 19 May 2026 07:47:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IF7vJHgVDGpMYgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 May 2026 07:47:04 +0000
Message-ID: <794447b7-ae61-4524-894b-45f05e5b5eec@suse.de>
Date: Tue, 19 May 2026 09:47:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/7] net/handshake: Pass negative errno through
 handshake_complete()
To: Chuck Lever <cel@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
 <20260518-handshake-file-pin-v1-3-4bbcb7e62fda@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260518-handshake-file-pin-v1-3-4bbcb7e62fda@oracle.com>
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
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,oracle.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Queue-Id: D340E6A87E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_004711_173947_E50B7EC5 
X-CRM114-Status: GOOD (  18.57  )
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
> handshake_complete() declares status as unsigned int and
> tls_handshake_done() negates that value (-status) before handing
> it to the TLS consumer. Consumers match on negative errno
> constants -- xs_tls_handshake_done() has
> 
> 	switch (status) {
> 	case 0:
> 	case -EACCES:
> 	case -ETIMEDOUT:
> 		lower_transport->xprt_err = status;
> 		break;
> 	default:
> 		lower_transport->xprt_err = -EACCES;
> 	}
> 
> so the API as designed expects callers to pass positive errno
> values that the tlshd shim then negates.
> 
> Three internal callers in handshake_nl_accept_doit(), the
> net-exit drain, and a kunit test follow kernel convention and
> pass negative errnos -- -EIO, -ETIMEDOUT, -ETIMEDOUT. The
> implicit conversion to unsigned int turns -ETIMEDOUT into
> 0xFFFFFF92; the subsequent -status in tls_handshake_done()
> wraps back to 110, the consumer's switch falls through, and
> the xprt reports -EACCES on what should be -ETIMEDOUT or -EIO.
> 
> Fix the API rather than the call sites. The natural kernel
> convention is negative errno in, negative errno out. Change
> handshake_complete() and hp_done to take int status, drop the
> negation in tls_handshake_done(), and negate once in
> handshake_nl_done_doit() where status arrives from the wire
> as an unsigned netlink attribute. The three internal callers
> were already correct under that convention and need no change.
> 
> At the same wire boundary, clamp values above MAX_ERRNO to the
> default -EIO. A well-behaved tlshd never sends such a value,
> but negating an unconstrained u32 invokes signed-integer
> overflow when the high bit is set, which UBSAN would report.
> 
> Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/handshake/handshake-test.c | 2 +-
>   net/handshake/handshake.h      | 4 ++--
>   net/handshake/netlink.c        | 9 +++++++--
>   net/handshake/request.c        | 2 +-
>   net/handshake/tlshd.c          | 4 ++--
>   5 files changed, 13 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannex
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

