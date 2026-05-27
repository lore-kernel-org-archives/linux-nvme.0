Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2223CD4F54
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 17:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FquF5TRsyuRxxCso6UuAHSdVWzsEcorBxS2pYHqNBzA=; b=WEXY+eRwSjys6/TIjidr7KsPKr
	OVdYj/kDArwEvigcCHcHfwAKLesE3bCN8HjxowMr56QWRauu/o05QPaC6s4V7xHw2RMMIIhHeH5L1
	wgd2b8GXo1L+J/d7TO/3of1h3px+ORgcn8J/NgVcLYeTyAec5gQ43tmKi5BF7mEpIsYMfne1lR6hZ
	0DOBuXr4LVQhnJ/OtN/Xuukxjg/gXSN5oDuQayZzxhamLwKshBwo8jemFaZ7LL4WVKnKncL+5LM8j
	u9oYy5dTz5NtPLOL2AA6xJoioJoD5vMfXvHzhS6cIlrJVryxcqa2ZPPoqNSq/83ZIeeKBce+Pi5+u
	xmRNbhFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSI7L-00000004aQH-2ALP;
	Wed, 27 May 2026 17:32:31 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSI7J-00000004aPv-2KXd
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 17:32:30 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 66A9C6ACD9;
	Wed, 27 May 2026 17:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779903147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FquF5TRsyuRxxCso6UuAHSdVWzsEcorBxS2pYHqNBzA=;
	b=1SBAOK7k5G/dKvMqwMLmxLKAN/4AWLOiB6wweE3uAcRfWu2uKENHcxCe0iXRL49BJHCtiD
	BSVNTrFz7YOId1tk7EvgeQDXMUBkXjAIKitc7y0YR8KRR4TyybgqFisLDIIjDnfBOfVIpL
	jslwhoHKxQTxy9Vzga15PaD/D+iFhT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779903147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FquF5TRsyuRxxCso6UuAHSdVWzsEcorBxS2pYHqNBzA=;
	b=DifxZ3a4nR4PBQaDIXAqU6wi7vYcyddkNIINHRynyUrZuzn+kO3a4MWhp+oD3Mn1q5o9/L
	RNCc+jRHCi1JPuBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779903143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FquF5TRsyuRxxCso6UuAHSdVWzsEcorBxS2pYHqNBzA=;
	b=Fy/zUNdlkkLzrNMMmVc3XfQSB3CCQx9IhquQGrV31Rxcx/7iquK083SmGmfSStzfgv4EeC
	FFKjCWz+/Z0XKuyWIq+J2qHLxaLHuTz1pdtrfDmQ910uUNjrMYcMZV/F/L2jHwh+2loCih
	/wYrVWyFp+FyZQ/ghutFcIWAx+/eqr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779903143;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FquF5TRsyuRxxCso6UuAHSdVWzsEcorBxS2pYHqNBzA=;
	b=mH3+nsXeApTs4ZhlMqioy+cZG8MxuKR6XOrNQGZzfGW5kHhjD86crchHop6wpPISKSit97
	eSI2smTh+TWnz3Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDD665A93A;
	Wed, 27 May 2026 17:32:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g1omLKYqF2rhHgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 27 May 2026 17:32:22 +0000
Message-ID: <d733383f-534a-4e1a-9f46-8e2b1d07fb41@suse.de>
Date: Wed, 27 May 2026 19:32:21 +0200
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
 <41835be9-ef00-42c7-a5d3-258f092b59eb@suse.de>
 <eb4de53b-f96c-4905-b67a-90790d5e4007@app.fastmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <eb4de53b-f96c-4905-b67a-90790d5e4007@app.fastmail.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,oracle.com:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_103229_892903_81BD8398 
X-CRM114-Status: GOOD (  26.13  )
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

On 5/27/26 16:24, Chuck Lever wrote:
> 
> 
> On Wed, May 27, 2026, at 4:59 AM, Hannes Reinecke wrote:
>> On 5/25/26 18:51, Chuck Lever wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>
>>> nvmet_tcp_state_change(), a socket callback that runs in BH context,
>>> can reach handshake_req_cancel() via nvmet_tcp_schedule_release_queue()
>>> and tls_handshake_cancel().  handshake_req_cancel() acquires
>>> hn->hn_lock with plain spin_lock().  If a process-context thread on
>>> the same CPU holds hn->hn_lock when a softirq invokes the cancel path,
>>> the lock attempt deadlocks.  This is the only caller that invokes
>>> tls_handshake_cancel() from BH context; every other consumer calls it
>>> from process context.
>>>
>>> Deferring the cancel to process context in the NVMe target is not
>>> straightforward: nvmet_tcp_schedule_release_queue() must call
>>> tls_handshake_cancel() atomically with its state transition to
>>> DISCONNECTING.  If the cancel were deferred, the handshake completion
>>> callback could fire in the window before the cancel runs, observe the
>>> unexpected state, and return without dropping its kref on the queue.
>>> Reworking that interlock is considerably more invasive than hardening
>>> the handshake lock.  Convert all hn->hn_lock acquisitions from
>>> spin_lock/spin_unlock to spin_lock_bh/spin_unlock_bh so the lock is
>>> never taken with softirqs enabled.
>>>
>>> Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>>    net/handshake/netlink.c |  4 ++--
>>>    net/handshake/request.c | 14 +++++++-------
>>>    net/handshake/tlshd.c   |  2 ++
>>>    3 files changed, 11 insertions(+), 9 deletions(-)
>>>
>> ... and there is always the question whather we should be calling
>> tls_handshake_cancel() in the first place.
>> We already call 'tls_handshake_cancel()' from the handshake timeout
>> handler, and this instance of 'tls_handshake_cancel()' is called
>> from a socket callback (ie when the soecket is closed or something).
>> I would have expected that the handshake code cleans up outstanding
>> requests on socket close already; if so, we can delete the cancel
>> here.
> 
> The handshake layer doesn't auto-cancel on socket close.
> 
> handshake_sk_destruct() fires when the sock refcount reaches
> zero, but it only frees the handshake_req and removes it from
> the hash table. It does not set HANDSHAKE_F_REQ_COMPLETED or
> invoke the consumer's done callback. It assumes the request
> was already completed or canceled before the socket reached
> final destruction.
> 
> The timeout handler and the state-change path cover different
> failure modes. The timeout fires when tlshd is slow or absent.
> The state-change callback fires when the remote peer resets or
> closes the connection while the handshake is still in
> progress -- that can happen well before the timeout expires.
> 
> Without the cancel in nvmet_tcp_schedule_release_queue(), the
> race plays out as follows: the state-change callback
> transitions the queue to DISCONNECTING and drops its kref.
> Then tlshd finishes and the handshake layer calls
> nvmet_tcp_tls_handshake_done(). That callback sees the queue
> is not in TLS_HANDSHAKE state, hits the WARN_ON, and returns
> without dropping its own kref -- leaking the queue.
> 
> The cancel makes the teardown race-free: either cancel wins
> and the completion callback never fires, or completion already
> won and cancel returns false. Either way, exactly one side
> drops the kref.
> 
> The SunRPC consumers (client and server) avoid this problem by
> blocking a thread on wait_for_completion() during the
> handshake. A socket state change wakes the waiter indirectly
> through the completion callback, and the waiter handles
> cleanup. nvme-tcp's handshake is fully asynchronous -- there
> is no blocked thread to wake, so the state-change callback is
> the only context that can cancel the handshake before queue
> teardown begins.
> 

Thanks for the clarification. That's what I had (implicitely)
assumed, so the tls_handshake_cancel() needs to stay.

So you can add my:

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

