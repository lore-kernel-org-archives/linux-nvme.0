Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABCACD4F57
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 07:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BajQC+5sYEP4FXnTqsvlmtfnE6e07wzfI4oyozjDq5Q=; b=VLoKaWTlrhJnLDZNjR5xbrUCol
	mx//dSBQDa5CTsopEvLLMalCezDc0me7HD/i/fNU3fLoXYo3xMqNlGYByGGBICV2ssnhYZL/OIrpc
	PwuZ8t4+2jhdfbQudkPZ7fDcaO1JKr1ExoKL4K06FUmlKxY/lWxKnBjGl5yTDtgjPjnjIVTOpoOK5
	BYhtz2YsPexS9qu0GE4OJMp13aEXUqofMA6YGRSqC68rLJNuleWhvegjNdx7CrGE0PR0ssGdp60Zw
	xK0EbJDGPt2s3l2CXrk01nwGnzgiV9VY73jbjuEVAITsfifKXNV71zdub1ensV30gE4h6+tQkBrpb
	rQslJ3mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPExs-00000000WCU-2rBu;
	Tue, 19 May 2026 07:34:08 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPExq-00000000WAu-0IBS
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 07:34:07 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A8C035CAFC;
	Tue, 19 May 2026 07:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779176042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BajQC+5sYEP4FXnTqsvlmtfnE6e07wzfI4oyozjDq5Q=;
	b=QBDzXkkflDQ3fPEoqG74bx8JlDg3d/ooyJjIbA/hyw+13Z9TX/Iw7hReSlxFVIieeBcjfO
	jI1pZ5PqgyheXRXYW65Vwyvlku7j4ERmm1K1ykViGggAV1mL/8Z4FFhOvnaIMcRIdjUzTJ
	pqARPDLDMYYHu7kJofPSuPtQq48XUgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779176042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BajQC+5sYEP4FXnTqsvlmtfnE6e07wzfI4oyozjDq5Q=;
	b=o4AxXcA6pdV7qnI0Pp4guyU4qjVdsa8idy08+oRWy2tezgyYRSVvbiusFeaNkVz8xyA9qU
	S+173QmmY5huXsBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779176042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BajQC+5sYEP4FXnTqsvlmtfnE6e07wzfI4oyozjDq5Q=;
	b=QBDzXkkflDQ3fPEoqG74bx8JlDg3d/ooyJjIbA/hyw+13Z9TX/Iw7hReSlxFVIieeBcjfO
	jI1pZ5PqgyheXRXYW65Vwyvlku7j4ERmm1K1ykViGggAV1mL/8Z4FFhOvnaIMcRIdjUzTJ
	pqARPDLDMYYHu7kJofPSuPtQq48XUgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779176042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BajQC+5sYEP4FXnTqsvlmtfnE6e07wzfI4oyozjDq5Q=;
	b=o4AxXcA6pdV7qnI0Pp4guyU4qjVdsa8idy08+oRWy2tezgyYRSVvbiusFeaNkVz8xyA9qU
	S+173QmmY5huXsBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83832593A8;
	Tue, 19 May 2026 07:34:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4cdGH2oSDGrmVQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 May 2026 07:34:02 +0000
Message-ID: <556f3d0c-8e69-49cc-84ce-3358eb3996b8@suse.de>
Date: Tue, 19 May 2026 09:33:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/7] net/handshake: Drain pending requests at net
 namespace exit
To: Chuck Lever <cel@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
 <20260518-handshake-file-pin-v1-1-4bbcb7e62fda@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260518-handshake-file-pin-v1-1-4bbcb7e62fda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_003406_255305_4668CED3 
X-CRM114-Status: GOOD (  20.59  )
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
> The arguments to list_splice_init() in handshake_net_exit() are
> reversed. The call moves the local empty "requests" list onto
> hn->hn_requests, leaving the local list empty, so the subsequent
> drain loop runs zero iterations. Pending handshake requests that
> had not yet been accepted are not torn down when the net namespace
> is destroyed; each one keeps a reference on a socket file and on
> the handshake_req allocation.
> 
> Pass the source and destination in the documented order
> (list_splice_init(list, head) moves list onto head) so the pending
> list is transferred to the local scratch list and drained through
> handshake_complete().
> 
> Fixing the splice direction exposes a list-corruption race. After
> the splice each req->hr_list still has non-empty link pointers,
> threading the stack-local scratch list rather than hn_requests.
> A concurrent handshake_req_cancel() -- for example, from sunrpc's
> TLS timeout on a kernel socket whose netns reference was not
> taken -- finds the request through the rhashtable, calls
> remove_pending(), and sees !list_empty(&req->hr_list).
> __remove_pending_locked() then list_del_init()s an entry off the
> scratch list while the drain iterates, corrupting it. The same
> call arriving after the drain loop has run list_del() on an
> entry hits LIST_POISON instead.
> 
> Have remove_pending() check HANDSHAKE_F_NET_DRAINING under
> hn_lock and report not-found when drain is in progress. The
> drain has already taken ownership; handshake_complete()'s
> existing test_and_set on HANDSHAKE_F_REQ_COMPLETED still
> arbitrates between drain and cancel for who calls the consumer's
> hp_done. Use list_del_init() rather than list_del() in the drain
> so req->hr_list does not carry LIST_POISON after drain releases
> the entry.
> 
> Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/handshake/netlink.c | 4 ++--
>   net/handshake/request.c | 3 ++-
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

