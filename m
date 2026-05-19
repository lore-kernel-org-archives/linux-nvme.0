Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63AFCD4F5B
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 07:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cI4aPSozWh78t1SQ/0I7HGIjm0423IGba5gD7goL/dc=; b=nYsL5/Xw6Ked/aVW/++6hWNAo2
	02HFXc0P//c+ImQ1gNbpfefVINsz5gCqws5fwbD+Y5N3zIG4PZfpptNWZ28WSiK16zp9kzM13LhRt
	IJMB9HA4b29Tz6frk/jlsok2RrEN3jF+1XGCyZDfgLLzpcAlmTNtc4NH8J3SpsUUIyZ3Ul5Af7dJh
	b5hXR7sdXQDvhDDHeuKaERApiFCF5xSbQaUOKlCMEkaKh9oLm5PSSWINoAleayWW4XYBd7HkQxV60
	T+ZJwXCVdPhk9z+I8kMaIoqW0HTPLDahPXgoAvjME4UGRvBQp9U6kQNoMPM0TIscwDKC4Uq6klKaP
	y9jRRJ5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPFMl-00000000acM-1090;
	Tue, 19 May 2026 07:59:51 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPFMi-00000000abV-3Bxl
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 07:59:50 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0BDCB66DC9;
	Tue, 19 May 2026 07:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779177587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cI4aPSozWh78t1SQ/0I7HGIjm0423IGba5gD7goL/dc=;
	b=K1um8r1v8Yx0gZO6qc3IhyB7LMDT3BIhS0XxPSq6rvSulTwua5OkUN73zskCz69t4Zpfil
	AtT+xr57Kz4RFafFokLbRxKqf4fTD5XDXnUM2uIjsch5Jw/CSc4l+xoVHdivmhLKNktGHz
	83F51CfI0E6wurIbJjMe8d1m2t1tQgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779177587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cI4aPSozWh78t1SQ/0I7HGIjm0423IGba5gD7goL/dc=;
	b=GzWtOa6DuBGtjzOM1Npd67vt4GewXzZn03+/PNF21r8NMJ8pEB9SpAvAAXFvIFzIcfEJhU
	yrO5rx/mbba+tTDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779177587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cI4aPSozWh78t1SQ/0I7HGIjm0423IGba5gD7goL/dc=;
	b=K1um8r1v8Yx0gZO6qc3IhyB7LMDT3BIhS0XxPSq6rvSulTwua5OkUN73zskCz69t4Zpfil
	AtT+xr57Kz4RFafFokLbRxKqf4fTD5XDXnUM2uIjsch5Jw/CSc4l+xoVHdivmhLKNktGHz
	83F51CfI0E6wurIbJjMe8d1m2t1tQgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779177587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cI4aPSozWh78t1SQ/0I7HGIjm0423IGba5gD7goL/dc=;
	b=GzWtOa6DuBGtjzOM1Npd67vt4GewXzZn03+/PNF21r8NMJ8pEB9SpAvAAXFvIFzIcfEJhU
	yrO5rx/mbba+tTDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D45C8593A8;
	Tue, 19 May 2026 07:59:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mDNTM3IYDGp4bwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 May 2026 07:59:46 +0000
Message-ID: <20c1c773-ea29-4c1a-b960-eb12afd2995a@suse.de>
Date: Tue, 19 May 2026 09:59:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 5/7] net/handshake: hand off the pinned file reference
 to accept_doit
To: Chuck Lever <cel@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
 <20260518-handshake-file-pin-v1-5-4bbcb7e62fda@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260518-handshake-file-pin-v1-5-4bbcb7e62fda@oracle.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,oracle.com:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_005948_950659_D2535B57 
X-CRM114-Status: GOOD (  21.43  )
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
> handshake_req_next() removes the request from the per-net
> pending list and drops hn_lock before handshake_nl_accept_doit()
> reads req->hr_sk->sk_socket and dereferences sock->file (once in
> FD_PREPARE() and again in get_file()).  In that window a
> consumer running tls_handshake_cancel() followed by sockfd_put()
> (svc_sock_free) or __fput_sync() (xs_reset_transport) releases
> sock->file.  sock_release() then runs sock_orphan(), zeroing
> sk_socket, and frees the struct socket.  The accept-side code
> either reads NULL through sk_socket or chases freed memory.
> 
> The submit-side sock_hold() does not prevent this.  sk_refcnt
> protects struct sock, but struct socket and sock->file are
> independently refcounted via the file descriptor the consumer
> owns.  Pinning sk leaves sock and sock->file unprotected.
> 
> Retarget the accept-side dereferences at req->hr_file, which was
> pinned at submit time, instead of req->hr_sk->sk_socket->file.
> Pinning on its own is not sufficient: a consumer that cancels
> between handshake_req_next() returning and accept_doit reaching
> FD_PREPARE() takes the !remove_pending() branch in
> handshake_req_cancel() and drops hr_file before the accept side
> takes its own reference.  Hand off an additional file reference
> inside handshake_req_next(), under hn_lock, so the accept side
> operates on a reference that no concurrent handshake_req_cancel()
> can revoke.  FD_PREPARE() consumes that handed-off reference,
> either by transferring it to the new fd in fd_publish() or by
> dropping it in the cleanup destructor on error; the explicit
> get_file() that previously balanced FD_PREPARE() is therefore
> redundant and goes away.
> 
> Update handshake_req_cancel_test2 and _test3 to simulate the
> FD_PREPARE() consumption with an fput() so the kunit file-count
> assertions stay balanced.
> 
> Reported-by: Chris Mason <clm@meta.com>
> Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/handshake/handshake-test.c |  8 ++++++++
>   net/handshake/netlink.c        |  7 ++-----
>   net/handshake/request.c        | 18 ++++++++++++++++++
>   3 files changed, 28 insertions(+), 5 deletions(-)
> 
I _think_ this should fix the issue I had reported about a kernel oops 
in __sys_recvfrom() in tlshd.
Which has all the symptoms described here.
So glad that it's been addressed.

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

