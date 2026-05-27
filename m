Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03DFCD5BDE
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 08:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=977a+qSrvpHRQv2EJ+wo7dGtItpSp2s4oX0PjoYBUxE=; b=TLFIwQhV7HPq4Bx2NvbXZBWnTc
	+srRg2RE0lsmcyYJg5XgxB9djO/YTBGWCsqjPQ5UoK0dkYyXMMXRYg6SZ2gevtTtLOfPj70kTe9Wg
	lMuZ6fwz+VABsKuOcxmtQM/aloG8sx1gNM9mSbxogWBpLD/wetjz0bSEmp4DWzhEC+eGNyRW8ertr
	6a5/uK3CF43K9MhburaJSGbsSRjMgRvg0yEyc4Rt2qcxQdP+LS63QHgJkBQBCTJ2B4M1zbOxNiM4b
	cmOSlu725dLv6CDmLVA4g1W7wQqlOuX2EEc/zjtq3zgROdDZ4g4v6L3C6KAVeIk3WAZ7JecklKiwI
	SXsVZbww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSA6Z-00000003aJQ-3yWv;
	Wed, 27 May 2026 08:59:11 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSA6X-00000003aIp-0m6G
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 08:59:10 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F6816B349;
	Wed, 27 May 2026 08:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779872346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=977a+qSrvpHRQv2EJ+wo7dGtItpSp2s4oX0PjoYBUxE=;
	b=gK10SUuT6lbqqbS31kyzPsir6baLPihKO+dw2bUO1uW1zCQZF7vlsXNYR5g4w/GHyyi/I2
	ho82JGHgZVCpWu/rHVy5jrbC8we9l3r87Zlrnq6jg9sZUe5S2t01hwFMCvdf4sNRi9DYCW
	ZKRw66x3dp37w6nuuo8MgTVD5PGNhdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779872346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=977a+qSrvpHRQv2EJ+wo7dGtItpSp2s4oX0PjoYBUxE=;
	b=sKdk5VZPACSXDaj7nPx0r8lqAbnQGrrKTcVm+fzQ+e0XHrfRMGhWfEwStUOCl6MzwqFXk/
	lg8+D4UrFcSe9UDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ui+HFhQ7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4k+N5o3+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779872345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=977a+qSrvpHRQv2EJ+wo7dGtItpSp2s4oX0PjoYBUxE=;
	b=Ui+HFhQ7RkndRReirphQRTOzgaHkLCGYn0GN7oCQBLJrWb29im7ZXaGGpvsAxH4AGWwBqo
	lFHp3BBBKEYYzzS/gX0HxLq2vqlI0HzkFsPGnDJiOH4s2EnVeb+jI97rWPkNxzT62FGmbD
	er/Rl+EDiWHOLqa9f/aXzdy4uq/Iplo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779872345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=977a+qSrvpHRQv2EJ+wo7dGtItpSp2s4oX0PjoYBUxE=;
	b=4k+N5o3+5rEunRDnSyrTGVVKA45ZjrfsLhssYJLJN4pvjt0c2gPw0Lm0pJFO0SeLo1g9S1
	ZpfMZ8Ajv7oX0pBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59AED5A74E;
	Wed, 27 May 2026 08:59:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DNcOFVmyFmpbEgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 27 May 2026 08:59:05 +0000
Message-ID: <41835be9-ef00-42c7-a5d3-258f092b59eb@suse.de>
Date: Wed, 27 May 2026 10:59:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/8] net/handshake: Use spin_lock_bh for hn_lock
To: Chuck Lever <cel@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
 <20260525-handshake-file-pin-v3-1-66c616906ead@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260525-handshake-file-pin-v3-1-66c616906ead@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7F6816B349
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,oracle.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_015909_373454_EABE5AF9 
X-CRM114-Status: GOOD (  16.64  )
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

On 5/25/26 18:51, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> nvmet_tcp_state_change(), a socket callback that runs in BH context,
> can reach handshake_req_cancel() via nvmet_tcp_schedule_release_queue()
> and tls_handshake_cancel().  handshake_req_cancel() acquires
> hn->hn_lock with plain spin_lock().  If a process-context thread on
> the same CPU holds hn->hn_lock when a softirq invokes the cancel path,
> the lock attempt deadlocks.  This is the only caller that invokes
> tls_handshake_cancel() from BH context; every other consumer calls it
> from process context.
> 
> Deferring the cancel to process context in the NVMe target is not
> straightforward: nvmet_tcp_schedule_release_queue() must call
> tls_handshake_cancel() atomically with its state transition to
> DISCONNECTING.  If the cancel were deferred, the handshake completion
> callback could fire in the window before the cancel runs, observe the
> unexpected state, and return without dropping its kref on the queue.
> Reworking that interlock is considerably more invasive than hardening
> the handshake lock.  Convert all hn->hn_lock acquisitions from
> spin_lock/spin_unlock to spin_lock_bh/spin_unlock_bh so the lock is
> never taken with softirqs enabled.
> 
> Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/handshake/netlink.c |  4 ++--
>   net/handshake/request.c | 14 +++++++-------
>   net/handshake/tlshd.c   |  2 ++
>   3 files changed, 11 insertions(+), 9 deletions(-)
> 
... and there is always the question whather we should be calling
tls_handshake_cancel() in the first place.
We already call 'tls_handshake_cancel()' from the handshake timeout
handler, and this instance of 'tls_handshake_cancel()' is called
from a socket callback (ie when the soecket is closed or something).
I would have expected that the handshake code cleans up outstanding
requests on socket close already; if so, we can delete the cancel
here.
Hmm?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

