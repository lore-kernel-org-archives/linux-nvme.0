Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E038606A882
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 07:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ubPZS7pc;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xkqr1Qf7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=++VuCi8t;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xkqr1Qf7;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=++VuCi8t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=b71x4uZul/6b+3X6jLqjB42CxacMpuPRIUrtp5H8w/A=; b=ubPZS7pc3paaSe
	+2oKPsytBN6oGXmZjNWTUaDz0CUY4dnvGRccJqIZS+wwpacTAsmXHqT3BIhV2NDxt7KuUY6zIV/5c
	CYjF0btGFSlTRifMly1o1U+ta23r0CEA/U19MO+CsmKe5eygb1QSqLxYmF8Pr5gH3lMEp5CaKzktl
	FeF+F9LOrceUDR5TFEr7hl6YR45JrTvCYcUjyy8E/HGKBk5scmc+u6sz4HoJ/RaiYM5n9+r9fwDvo
	1mUXH+dHPFWLtJ2E6wMUiuZZcRmgTm4ZOZfhs0bcvmFWt711RNDBOa2iK33reHZU3tBdrmrS5ZDxT
	KdhvJQfKna8r133Ow3PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRm3Z-0000000Bwik-1DJa;
	Fri, 13 Nov 2026 07:50:45 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRm3U-0000000Bwi1-146w
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 07:50:44 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 543DA1F7C4;
	Fri, 13 Nov 2026 07:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794556238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b71x4uZul/6b+3X6jLqjB42CxacMpuPRIUrtp5H8w/A=;
	b=xkqr1Qf7BocL1yDK529ZLgijmaviG94/Nq3VzRRiGVCFB74YlSHzKOH1J3Vf5AID1uwPRY
	aNER5hoDYq3tBFDgcnG0BC44xYFgSxedal9H1pMuZ5vbx6YObRJjk/6y8gxvlTTZsXK6lB
	GDSAovZWnJMTW6IgX60tO7NaotaYA0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794556238;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b71x4uZul/6b+3X6jLqjB42CxacMpuPRIUrtp5H8w/A=;
	b=++VuCi8t9zj9I3gXaCvV1+87YxIKuicC5x7LQmKu9z9VhU7I1a8gUc88MHu1ibzYKACP+X
	rC04V0/tsRYMpzBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794556238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b71x4uZul/6b+3X6jLqjB42CxacMpuPRIUrtp5H8w/A=;
	b=xkqr1Qf7BocL1yDK529ZLgijmaviG94/Nq3VzRRiGVCFB74YlSHzKOH1J3Vf5AID1uwPRY
	aNER5hoDYq3tBFDgcnG0BC44xYFgSxedal9H1pMuZ5vbx6YObRJjk/6y8gxvlTTZsXK6lB
	GDSAovZWnJMTW6IgX60tO7NaotaYA0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794556238;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b71x4uZul/6b+3X6jLqjB42CxacMpuPRIUrtp5H8w/A=;
	b=++VuCi8t9zj9I3gXaCvV1+87YxIKuicC5x7LQmKu9z9VhU7I1a8gUc88MHu1ibzYKACP+X
	rC04V0/tsRYMpzBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6F481344A;
	Fri, 13 Nov 2026 07:50:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4EARKk3B9moIWgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 13 Nov 2026 07:50:37 +0000
Message-ID: <4ece1bef-cb4d-4a84-a2e0-bd3e3cf1e229@suse.de>
Date: Fri, 13 Nov 2026 08:50:37 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] nvme-tcp: consume TLS records without application
 data
To: martin.nvme.dev@gmail.com, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Martin Belanger <martin.belanger@dell.com>, stable@vger.kernel.org
References: <20261112-nvme-tcp-live-ctrlrec-v3-0-49760bd9eaa8@gmail.com>
 <20261112-nvme-tcp-live-ctrlrec-v3-3-49760bd9eaa8@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261112-nvme-tcp-live-ctrlrec-v3-3-49760bd9eaa8@gmail.com>
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
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -11.79
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_235040_496780_A5A352D2 
X-CRM114-Status: GOOD (  17.41  )
X-Spam-Score: -4.4 (----)
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

On 11/12/26 10:13 PM, Martin Belanger via B4 Relay wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> A peer may send a TLS record without application data at any time
> after the handshake: a NewSessionTicket, a KeyUpdate or an alert.
> tls_sw_read_sock() cannot pass such a record to nvme_tcp_recv_skb().
> It returns -EINVAL and leaves the record at the head of the receive
> queue. nvme_tcp_try_recv() then starts error recovery, and the
> controller reconnects.
> 
> TLS 1.3 allows a server to send a NewSessionTicket at any time after
> the handshake (RFC 8446, section 4.6.1). Alerts can also arrive at any
> time.
> 
> On -EINVAL, read the record with recvmsg(), which reports the record
> type. Discard handshake messages other than KeyUpdate. Log alerts, and
> fail the queue on a fatal alert. Fail the queue on a KeyUpdate, which
> nvme-tcp cannot answer, and on any other record type. recvmsg() takes
> the socket lock, so release it around the read.
> 
> Handle these records in one helper, also for the records that arrive
> ahead of the ICResp. A warning alert ahead of the ICResp no longer fails
> the connection.
> 
> On a poll queue, nvme_tcp_poll() and nvme_tcp_io_work() can both see
> the record while the socket lock is released. A queue flag makes sure
> that only one of them reads it.
> 
> svc_tcp_recvfrom() in sunrpc handles -EINVAL from read_sock() the same
> way.
> 
> Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
> Cc: stable@vger.kernel.org
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> ---
>   drivers/nvme/host/tcp.c | 113 +++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 97 insertions(+), 16 deletions(-)
> 
Far better.

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

