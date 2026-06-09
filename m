Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCA8CD8CAE
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2026 06:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cO0TS6ZXRdzfE2WsluHxfQNoDvWGY14VYEsWciA7wwQ=; b=4ALTVzEJpKKAOeWrPCJZjXibZs
	bcTXQ4w/BEywoVCEjh2BdbKCunxC8JkpX/eQtLBAVclVg7j3fe8c3tgeFNp3ZfKdO+AeX7ygDmRC7
	YU1tyJcviV6nwrIesPDvfUk3wGXNI/gKpvD/sHpA1zfNy5g9t+YcwzSKalxSDePS+2Vm/zChtFH0o
	SYB91OMU1vrj95Iyona8JHUkmTPhqFwFve/JIQh3j7pb+HyM+8mARERtUEp0OMtRTp2uYoene7LNb
	olJ4m+fnDJSfYewGhr4skMRd+0khU7h1/ou3o5bc0t3Cv6vNck7EmZB3SCSPt5uaLPefEx2aWw2IY
	lNR1Xx1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWq97-00000004tWY-3kNd;
	Tue, 09 Jun 2026 06:41:09 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWq95-00000004tVf-0qyV
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jun 2026 06:41:08 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4148375A1E;
	Tue,  9 Jun 2026 06:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780987263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cO0TS6ZXRdzfE2WsluHxfQNoDvWGY14VYEsWciA7wwQ=;
	b=uO+CVRNCVQNPJGpGo84zxPmocmTGbnUhLoV8MliKlsH5YGkBncbjbLtHmHzhuiUlBaE39k
	6rsIaaAb24XnvKmTz6o9XzykF8goFUncuhmQpARCvUBO9MVrYdjbFLqOxoExqdsxfrPDDv
	enrS7D3C6um5GeOY4wldYZWstn26Gt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780987263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cO0TS6ZXRdzfE2WsluHxfQNoDvWGY14VYEsWciA7wwQ=;
	b=69E88WFqJZAWV1eGCkfLrbih0oqp1SWf7BqiFsJtOw7J250qXVOYQxQ3aaGk7B0xOWQ4R3
	PXvjETXgf1pLGrBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780987262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cO0TS6ZXRdzfE2WsluHxfQNoDvWGY14VYEsWciA7wwQ=;
	b=tSSm9SWFlcl2Oz2TziMuAy9qLSMcs8sSmKLFGOflXo/jRrD6zFo9rQaUjYAirvWHuw4Rg0
	37jC5Cor11PKXjm7lqVtYkCxAWFa7mqkzjlCtfnMkQ+X71UoC04Mj2yhCpL4vSPG1CtbvP
	70nR/doZeKmuA2T2PAOZJjNvT/5GEwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780987262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cO0TS6ZXRdzfE2WsluHxfQNoDvWGY14VYEsWciA7wwQ=;
	b=ykD56Yw/RLLYbvoR3fovvfzZeSZOKIYyDCd6BMcQ4FOCCQt9KQlPhvrM0OxtxU0Uvirzmw
	o2rybcBNgv+BYsBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64393779A7;
	Tue,  9 Jun 2026 06:41:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fDHdFn21J2oAbwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 09 Jun 2026 06:41:01 +0000
Message-ID: <40199ef9-416e-4a58-908a-ed514dfd6ff2@suse.de>
Date: Tue, 9 Jun 2026 08:41:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] handshake: Add tags to "done" downcall
To: Chuck Lever <cel@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20260605-tls-session-tags-v1-0-47bd1d94d552@oracle.com>
 <20260605-tls-session-tags-v1-2-47bd1d94d552@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260605-tls-session-tags-v1-2-47bd1d94d552@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,oracle.com:email,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,linux-foundation.org,queasysnail.net,kernel.dk,lst.de,grimberg.me,nvidia.com,brown.name,oracle.com,talpey.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLh3g55kcpku8oef9ktzra4k57)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,oracle.com:email,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_234107_547662_6C3B20A1 
X-CRM114-Status: GOOD (  21.06  )
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

On 6/5/26 19:34, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> We'd like tlshd to tag certificates according to admin-defined
> characteristics. The tag list is to be returned on a successful
> handshake. Upper Layer Protocols (such as NFS) can then authorize
> access based on the set of tags returned to the kernel.
> 
> For example, suppose NFSD wants to restrict access to an export to
> only clients that present certificates whose issuer DN contains
> "O=Oracle". tlshd can parse incoming certificates, and add an
> "oraclegroup" tag to handshakes where a client presents a
> certificate with "O=Oracle" somewhere in its Issuer field. NFSD can
> then be configured to look for that tag and permit access only when
> it is present. NFSD needs no knowledge of x.509 certificates.
> 
> This patch plumbs in the netlink protocol elements for tlshd to
> return a list of tags to the kernel when a TLS or QUIC handshake
> succeeds. Subsequent patches add tag extraction and storage in
> the handshake layer.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   Documentation/netlink/specs/handshake.yaml | 11 +++++++++++
>   include/uapi/linux/handshake.h             |  3 +++
>   net/handshake/genl.c                       |  5 +++--
>   3 files changed, 17 insertions(+), 2 deletions(-)
> 
Not sure if I agree with this; to my untrained eye the 'tag' attribute 
is just a string, and someone else will have to parse that. But we
are at the netlink level here, so we _can_ have nested tags.
Wouldn't it be better to make 'tags' a nested tag (ie a list of tags)
such that we can avoid parsing in the caller/consumer?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

