Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2272ACD6E41
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 14:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TPU49W2hwaIaGf+pDDgyJSSdFTnXEcdNkRBctuZHsJg=; b=iVx03tSnWHoPW+CYyrr9YTuqRD
	4ZLHTzCS+RffboXdyqqnOQhvqVt6tvnErHSF0rSR8vLkCm0qUyZmTN3jl3gyCavB0uYrk3Fm4YQjd
	zt4nU70BSmc2nM47NgptIkY2AKl53MW4nJNfgkbtrYrfqISKNApF8N7PbXw5l3hx+9yI2SsGq84Y6
	NKq3FxTtN9GgDQ1D0ov14gwzByR0eR1+aFUJKcYKONhCXubU9LsAmvKRrA4xfGdNQB+Xh3kAvxWn9
	AKiYRrLOamg0l1LsV3MHvJL5WBvJequr65f44r0xFq6A/0+Pxo4U4QXt53Nv7yuMrfKjMLYjZ97BL
	EBgcp2sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFBS-00000004I0n-1r1K;
	Wed, 27 May 2026 14:24:34 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFBR-00000004I0d-2dy3
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 14:24:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BB953601E6;
	Wed, 27 May 2026 14:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259631F00A3D;
	Wed, 27 May 2026 14:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779891872;
	bh=TPU49W2hwaIaGf+pDDgyJSSdFTnXEcdNkRBctuZHsJg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=bLUGKfn1I3aM9RNqHphi8bVB4PHi5hEmYxJ7dWFDv1srbKu8Ey6qt9vuPBVrO8kNX
	 Ok4ya71W9mBAaH3kwypKTiZsZzOE9QvkpVDbJQ8cFlZVghWsdz3Iit1kXVMSboqBq7
	 dCOZIlzQB9hmb6lQ9PS36Lzv3kDyVL1PiBpmbPIl+W8VZ+WBWyodkBPEERhZEJSHix
	 AchiZhkfM570bXPuhtNDTfSEFy+NAvhcqgIqAIg++F3jg8E8s0jj+vOnkNAb/84tKN
	 UqGYPotcd3/GaS29RTV0jxnUlP4ZtdDN+P/aCdjx/hoYN7412BeVMI07Txg7NlNK8Q
	 L2Vvgml0hZvQg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 589D7F40074;
	Wed, 27 May 2026 10:24:31 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 27 May 2026 10:24:31 -0400
X-ME-Sender: <xms:n_4Waldm0F6Iy00U_W_wyBpr_F4NkrY9YN8DZIQugU-tAceZBhDqgA>
    <xme:n_4WauCQcEDJv8EW3FNK9CN72oDAY8nm9IgSr1dl9neH3BOuwi9vGDiSdnn8EMv_P
    HLpZuYUWiNZsReuV2eHsDMX7TFSUwmH5F3TEMZzwDyV15pgyNXSNqo>
X-ME-Proxy-Cause: dmFkZTFkiGgRNatvhpg/n6hWRe4iphBkR6LbmxVXxr5lu/ub+8c9VoiQl27L8zv87bQ+EI
    5oMIGijjhLLpIWOZxBhgevrAUKKTUiPP8qjXpZNFuFExctanYfD+CVUUedhh/ORUS2QnkO
    GBpfW+ofXIiUYXJWdW5LT0mUDt23VZ/qy8Uq9upz6yiZ5YRWhmDxWsdSCDCXa6prIj105V
    Z+dkhWNitSWwRj9wbkS5LcKvlqyC6EtPFNO+Z1X8GCgMDH4r0UzJEC/OnBMdZ1AJvCoqi0
    bkeQiGCQylK+aU39FPsfiIJpE5p8XEKf+iGbn3CS1o1llBQofG21vMuVsxD8yCsaX6ciV6
    xIHRBphWC8b+VdHcj36ExVw8+wFToy4pSwaah2f6p3VO22S1p/4FTFGunhF/tdxFHQ9WUe
    lVIJbXEvgfaNlXT+0vpjwXpvDMT7l2yFZ/e+rlSJkNYsHHA0rWPaf2bnduTUDFzRM5w87m
    FwZq+qhfxS2VuLI9J0b/NfauLgtNgJJeueJy8ELXQn3vFW4al+h0wed+fR0IUyWDZXRCpP
    Xf4++E8gUZEuc4ybHQFUcYx6RchxpsPCerBUj+hwbo3rbLxQo3o3V9jFUAwjmgMhyz5ynJ
    t5bAmBIXwww/1snZYixhQ/BZSnvCw5+mJhrSINo3IXmhT4HylE21sjQE6rkA
X-ME-Proxy: <xmx:n_4WalYKMK-TXvg0uVe6A7cV79kvIgenhrn1ozYvS1bmCb1PIB_alw>
    <xmx:n_4WaiwpcC4q-m5oUdINOywjC8EOb-YaPtuqOxrm1ebTmhwXP7kdFA>
    <xmx:n_4WakMxPyRr-ZtOz0nnEK9D_UQbQRUlf2j-lzXZLLTgC-cpM8rLRg>
    <xmx:n_4WahfLWx5S-psgl_YH4yTgIjg0kNbqjwAkfwtN9jOj2_mpFZ36Uw>
    <xmx:n_4WapQtqikmRpWxM7KRkThODh_Pcf2NKX72Dy9d6R4CVcM9DOHpqGVi>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 324CE780077; Wed, 27 May 2026 10:24:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AnKL6hs-MIXF
Date: Wed, 27 May 2026 10:24:11 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Hannes Reinecke" <hare@suse.de>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>
Cc: "Chris Mason" <clm@meta.com>, "Christian Brauner" <brauner@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <eb4de53b-f96c-4905-b67a-90790d5e4007@app.fastmail.com>
In-Reply-To: <41835be9-ef00-42c7-a5d3-258f092b59eb@suse.de>
References: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
 <20260525-handshake-file-pin-v3-1-66c616906ead@oracle.com>
 <41835be9-ef00-42c7-a5d3-258f092b59eb@suse.de>
Subject: Re: [PATCH net v3 1/8] net/handshake: Use spin_lock_bh for hn_lock
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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



On Wed, May 27, 2026, at 4:59 AM, Hannes Reinecke wrote:
> On 5/25/26 18:51, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> 
>> nvmet_tcp_state_change(), a socket callback that runs in BH context,
>> can reach handshake_req_cancel() via nvmet_tcp_schedule_release_queue()
>> and tls_handshake_cancel().  handshake_req_cancel() acquires
>> hn->hn_lock with plain spin_lock().  If a process-context thread on
>> the same CPU holds hn->hn_lock when a softirq invokes the cancel path,
>> the lock attempt deadlocks.  This is the only caller that invokes
>> tls_handshake_cancel() from BH context; every other consumer calls it
>> from process context.
>> 
>> Deferring the cancel to process context in the NVMe target is not
>> straightforward: nvmet_tcp_schedule_release_queue() must call
>> tls_handshake_cancel() atomically with its state transition to
>> DISCONNECTING.  If the cancel were deferred, the handshake completion
>> callback could fire in the window before the cancel runs, observe the
>> unexpected state, and return without dropping its kref on the queue.
>> Reworking that interlock is considerably more invasive than hardening
>> the handshake lock.  Convert all hn->hn_lock acquisitions from
>> spin_lock/spin_unlock to spin_lock_bh/spin_unlock_bh so the lock is
>> never taken with softirqs enabled.
>> 
>> Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>   net/handshake/netlink.c |  4 ++--
>>   net/handshake/request.c | 14 +++++++-------
>>   net/handshake/tlshd.c   |  2 ++
>>   3 files changed, 11 insertions(+), 9 deletions(-)
>> 
> ... and there is always the question whather we should be calling
> tls_handshake_cancel() in the first place.
> We already call 'tls_handshake_cancel()' from the handshake timeout
> handler, and this instance of 'tls_handshake_cancel()' is called
> from a socket callback (ie when the soecket is closed or something).
> I would have expected that the handshake code cleans up outstanding
> requests on socket close already; if so, we can delete the cancel
> here.

The handshake layer doesn't auto-cancel on socket close.

handshake_sk_destruct() fires when the sock refcount reaches
zero, but it only frees the handshake_req and removes it from
the hash table. It does not set HANDSHAKE_F_REQ_COMPLETED or
invoke the consumer's done callback. It assumes the request
was already completed or canceled before the socket reached
final destruction.

The timeout handler and the state-change path cover different
failure modes. The timeout fires when tlshd is slow or absent.
The state-change callback fires when the remote peer resets or
closes the connection while the handshake is still in
progress -- that can happen well before the timeout expires.

Without the cancel in nvmet_tcp_schedule_release_queue(), the
race plays out as follows: the state-change callback
transitions the queue to DISCONNECTING and drops its kref.
Then tlshd finishes and the handshake layer calls
nvmet_tcp_tls_handshake_done(). That callback sees the queue
is not in TLS_HANDSHAKE state, hits the WARN_ON, and returns
without dropping its own kref -- leaking the queue.

The cancel makes the teardown race-free: either cancel wins
and the completion callback never fires, or completion already
won and cancel returns false. Either way, exactly one side
drops the kref.

The SunRPC consumers (client and server) avoid this problem by
blocking a thread on wait_for_completion() during the
handshake. A socket state change wakes the waiter indirectly
through the completion callback, and the waiter handles
cleanup. nvme-tcp's handshake is fully asynchronous -- there
is no blocked thread to wake, so the state-change callback is
the only context that can cancel the handshake before queue
teardown begins.

-- 
Chuck Lever

