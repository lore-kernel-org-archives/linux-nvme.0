Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B148606A32C
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dMHwKbuk;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fK9OJ8BN;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oQ2QNvW9;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GfxejqrD;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GVnFgtgW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=VwtEDaQcAhVmJ7JYis2QG6RHgDJgRtJGtpize8EwNyM=; b=dMHwKbukHhGoNa
	CuRt71vgxncYoDGes8fBrEJLr+oe5wGhDaW/Z3awrPo0T8Hw47NaWZY7122fo+Qop3qwkFQEP7Ar8
	LNZeDmiY0lyOVqfI2H2i1a3Fn78HLVwiY46SYSmGGeoE71psH0FXHav5tfGXkbrTJU9NQEN2Y7IWW
	ez3WcFwvh/5oncquG1iAPCW6iIf5mLExlWmZOQnHRY9A8BxUK7whJHAuMmjABV2k2MAwUN6UO/XiV
	mLthzls36/1ZHqT3cSV8L769nlL1hJsKFWjnkGk1IqRVwAmbwUx9fz0kFqd5t1pSdcvjdvuLT4vDq
	g/C9xGh87W0XkhVzqM2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOEil-00000002agr-2cUH;
	Tue, 03 Nov 2026 13:38:39 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOEii-00000002ag7-40WM
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 13:38:38 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E17121FB80;
	Tue,  3 Nov 2026 13:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793713115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwtEDaQcAhVmJ7JYis2QG6RHgDJgRtJGtpize8EwNyM=;
	b=fK9OJ8BNI9aFq2ckciDxFFRzZSJOQbPQhL/Jioi2978AmliL+wz+xMPyiD0UX0tz9JEewd
	K9Qy6Ik2DOZiCU+62rKQbeteVfQkUtYIWx7gvC8gWhnbpIOjodXQh3hf1XDusyq9YIWZh0
	zXKgOaCfQOwP/cWIafyk8AEpEnsvbng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793713115;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwtEDaQcAhVmJ7JYis2QG6RHgDJgRtJGtpize8EwNyM=;
	b=oQ2QNvW9ltAmIDJSwbHEx03IPD2xbKC5ZRY2nTHMdMICuV7+yIc9RfqvctXTy8EMQS4Buh
	EoJc2EWrWOFCiQCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793713114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwtEDaQcAhVmJ7JYis2QG6RHgDJgRtJGtpize8EwNyM=;
	b=GfxejqrDcSQuy3ht0KaTITE0qUp0G5cPTk5r8YpZk5nA3OV9/4DRfD47Y8jApjEm2cTaoG
	UajEi6W0pV6z4LnGYJcy6kpvPIqb+gD9OHcVlVCe0/OTCGKgkcoMHHWSR/sJDa/4mb1dCm
	aNoKFtcXzCBwFb2j35yujFju3xyF+Zs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793713114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwtEDaQcAhVmJ7JYis2QG6RHgDJgRtJGtpize8EwNyM=;
	b=GVnFgtgWSPNFvkdLx2A9GYbgN3wUlmyGTdnZwalznI3alnRXGLJFKw2S9dbE++humhkZcu
	vgEWc+ssAYj4aTAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57169134B8;
	Tue,  3 Nov 2026 13:38:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I67sC9rj6WoUSgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Nov 2026 13:38:34 +0000
Message-ID: <9d264274-adcd-4e01-afe4-dbb96bb1ecd0@suse.de>
Date: Tue, 3 Nov 2026 14:38:33 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/5] tls: update the RX key when a KeyUpdate
 is received
To: Martin Belanger <martin.nvme.dev@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Hannes Reinecke <hare@kernel.org>, Chuck Lever <cel@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Martin Belanger <martin.belanger@dell.com>
References: <20261102-keyupdate-rfc-v4-0-f17419972b9f@gmail.com>
 <20261102-keyupdate-rfc-v4-3-f17419972b9f@gmail.com>
 <dd6d8c92-a96c-4bb3-aee1-a28f2156fb9d@suse.de>
 <46288afa-affe-4262-bd0d-38a16f4608b4@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <46288afa-affe-4262-bd0d-38a16f4608b4@gmail.com>
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,lwn.net,linuxfoundation.org,infradead.org];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.79
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_053837_147962_AD318870 
X-CRM114-Status: GOOD (  18.00  )
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 12:23 PM, Martin Belanger wrote:
> 
> 
> On 11/3/26 02:15, Hannes Reinecke wrote:
>> On 11/2/26 5:58 PM, Martin Belanger via B4 Relay wrote:
>>> From: Martin Belanger <martin.belanger@dell.com>
>>>
[ .. ]
>>> @@ -2023,9 +2041,8 @@ ssize_t tls_sw_splice_read(struct socket *sock, 
>>> loff_t *ppos,
>>>       if (err)
>>>           goto splice_read_end;
>>> -    if (!skb_queue_empty(&ctx->rx_list)) {
>>> -        skb = __skb_dequeue(&ctx->rx_list);
>>> -    } else {
>>> +    skb = __skb_dequeue(&ctx->rx_list);
>>> +    while (!skb) {
>>>           struct tls_decrypt_arg darg;
>>>           err = tls_rx_rec_wait(sk, nonblock, true, false);
>>
>> Why this change? Looks a bit out of place here...
> 
> splice() handles a single record. With this patch,
> tls_rx_one_record() returns 1 for a KeyUpdate that the kernel
> consumed. splice() then frees that record and has no skb to pass to
> the user, so it must wait for the next record. The loop does that.
> recvmsg() and read_sock() already loop over records, so there a
> "continue" is enough.
> 
> The unconditional __skb_dequeue() only sets skb for the loop test.
> It returns NULL on an empty queue, so it does the same as the old
> skb_queue_empty() check.
> 
> I can move the restructuring into a separate patch without a
> functional change, if you prefer.
> 
Yes, I guess that would be best. Having a separate patch also allows
you to describe the rationale (as you just did) and avoids confusion
why a change for 'splice' ended up in a keyupdate patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

