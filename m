Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE71E606D802
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nUcX7cDy;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wKFhpKn8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7EwAjiQX;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wKFhpKn8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7EwAjiQX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=hAJtqAUg3MfDfcplgjk/O3ozi5Dl/AosfPRtaJzcQcs=; b=nUcX7cDyEx35SV
	hjPf3jf3Y4NwcsSghxJG+SviNhiGYONU6f2ZyHiiEOuN9JhB5Q1dkgeFq9idih3DayTeq7jJAClag
	gbDVcA1Wk5kTPur7WyQl+zog35qFzGYenva9mexVi77kCEEVrvGFWTdlpnqSccueBlO1v0XdTeSNm
	gHNn5TGoEYpyrSrbEaACyrMjNmg9Lr3FxX1ENirRKIF10cWPvzq/FYaO22JMhNtRdfJLX7nZeEV1j
	pQv6jq7XXfW87k23VHjS4qUvvPINNmbUbQCNB+pRVq5tN2Wl2VBc3PEZZU1dXq8ZcAf5Jra57yBsH
	uNdKMfWpMoXnc5EzwCvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOELQ-00000002Vh1-2ECc;
	Tue, 03 Nov 2026 13:14:32 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOELN-00000002Vef-0iKJ
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 13:14:31 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1C76821F33;
	Tue,  3 Nov 2026 13:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793711667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hAJtqAUg3MfDfcplgjk/O3ozi5Dl/AosfPRtaJzcQcs=;
	b=wKFhpKn8FbpiC1Ry3ukLnKh9WcjasGmPN3hj4tWGmwvoCWlXXC7jWfNDr6IOKpEW3Soqjj
	VsOjjo+tDi8Vi/p7BV0jxsqUJR6vthFZJmG0lnnU0OVHzEykYuhxwy/bDHI9VQ6lVyuAPH
	uI68YrZX+vbMKz1n1uNoumBoxINPezk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793711667;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hAJtqAUg3MfDfcplgjk/O3ozi5Dl/AosfPRtaJzcQcs=;
	b=7EwAjiQXMuoVIB5khWZ2AS/zoAA6A/P0hTHchANcF8Y8UpIscgPh1ZNQF+3nWUZAJKeqP7
	0kR5dx1SK/d2i6Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793711667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hAJtqAUg3MfDfcplgjk/O3ozi5Dl/AosfPRtaJzcQcs=;
	b=wKFhpKn8FbpiC1Ry3ukLnKh9WcjasGmPN3hj4tWGmwvoCWlXXC7jWfNDr6IOKpEW3Soqjj
	VsOjjo+tDi8Vi/p7BV0jxsqUJR6vthFZJmG0lnnU0OVHzEykYuhxwy/bDHI9VQ6lVyuAPH
	uI68YrZX+vbMKz1n1uNoumBoxINPezk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793711667;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hAJtqAUg3MfDfcplgjk/O3ozi5Dl/AosfPRtaJzcQcs=;
	b=7EwAjiQXMuoVIB5khWZ2AS/zoAA6A/P0hTHchANcF8Y8UpIscgPh1ZNQF+3nWUZAJKeqP7
	0kR5dx1SK/d2i6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D002C1350A;
	Tue,  3 Nov 2026 13:14:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 416+KjLe6WoEMQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Nov 2026 13:14:26 +0000
Message-ID: <46911561-1659-44ad-be43-61036548d626@suse.de>
Date: Tue, 3 Nov 2026 14:14:26 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: remove namespaces in parallel
To: Qiliang Yuan <odys.yuan@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Hannes Reinecke <hare@kernel.org>,
 Ming Lei <tom.leiming@gmail.com>, Nilay Shroff <nilay@linux.ibm.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Stuart Hayes <stuart.w.hayes@gmail.com>
References: <20261103-bug-nvme-remove-ns-async-v2-1-44e43766e44a@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261103-bug-nvme-remove-ns-async-v2-1-44e43766e44a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-11.79 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,kernel.org,gmail.com,linux.ibm.com,wdc.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -11.79
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_051429_376065_6B3DBADA 
X-CRM114-Status: GOOD (  19.09  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 7:28 AM, Qiliang Yuan wrote:
> nvme_remove_namespaces() removes the namespaces of a controller one
> after another. Each removal waits for RCU grace periods in
> del_gendisk() for the namespace and for its multipath head, about
> 20 ms in all.
> 
> Deleting a controller, such as disconnecting from a fabrics target,
> thus takes time proportional to its namespace count, over a second for
> 64 namespaces. Scanning had the same problem until commit 4e893ca81170
> ("nvme_core: scan namespaces asynchronously") made it add namespaces
> in parallel.
> 
> Remove the namespaces through an async domain the same way, and wait
> for all of them before returning. Each removal still waits about
> 20 ms, but the waits now overlap: a grace period is system-wide, so
> removals that wait at the same time are released by the same grace
> periods instead of each needing its own.
> 
> Disconnect time from a target on the same host, over tcp to 127.0.0.1
> and over nvme-loop, with 4 I/O queues, median of 3 runs on each of two
> boots per kernel:
> 
>    namespaces  transport  before              after
>             8  tcp         170 /  171 ms        85 /   91 ms
>            32  tcp         628 /  628 ms       294 /  293 ms
>            64  tcp        1201 / 1308 ms       533 /  550 ms
>            64  loop       1988 / 1913 ms      1283 / 1200 ms
> 
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> ---
> V1 -> V2:
> - Explain why removing the namespaces in parallel saves time
> - Drop patch 2 until the elevator switch locking change settles:
>    https://lore.kernel.org/r/20261031044141.5569-1-laveeshb@laveeshbansal.com
> 
> v1: https://lore.kernel.org/r/20261102-bug-nvme-remove-ns-async-v1-0-61780fee111c@gmail.com
> ---
>   drivers/nvme/host/core.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

