Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33643C0218D
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 08:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UxkkWKKQ9npPlvLt4byT2e5frJD5VAnZb6FKr6wuqik=; b=nXymZwFVlckvyv/68djp8v0v3I
	J7xIZ0DOibMdCTzXYgn61LnFkytZ2QCbglmBdFWhyyfiJWUE/p/VJ95E5ZLOJt5ZjApRxyrZOk78E
	EVclu1Il4pDUf0BJYyIbLqpOdlWj4T+CSZzGS+EorH2vGzxSmGkR/Gq2Ct8riytd/fKRMiwSlkoiU
	r1qlK9xdpQQD+aIos3OUzD3kBpsAxAN0IJiuuwJJPfGl8EiVCSJae7LfaHk6n8vMmfGv+YmUT0X4B
	Hi+OdD/vY4o9b0/gY1lPXPLUHAmZockbI8rkNhjPyyqSDIBLLFDV6hHk43dV0VoMcepywipIehxQ5
	YdrukUjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tch69-00000004P2k-1C80;
	Tue, 28 Jan 2025 08:37:29 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcgxq-00000004OAK-2ZGN
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 08:28:55 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3B0771F381;
	Tue, 28 Jan 2025 08:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738052931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UxkkWKKQ9npPlvLt4byT2e5frJD5VAnZb6FKr6wuqik=;
	b=R4t+q3aeUkq5gSUfALdm9RTVAdkDfA5/L7g/1J6kgH+1MZDFgwqGHsQKxNZQKlfIpqg9AV
	EiWFeHyq6E3EWw67MIee6EkS6cKLJe5a4z5ynFjWUaMhEUiKS517b77tI+SBP+jg7eAe4X
	lbxeVaW3NPrXCZ3OsuhuSaafgzAlvKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738052931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UxkkWKKQ9npPlvLt4byT2e5frJD5VAnZb6FKr6wuqik=;
	b=pOqnaZjmVQwbkncjeoj3ZYcu18GR1pcnQ92H2kRFaWaMqmIJ72J0V23MGLJzFlRS65xBme
	QDD0084L4MABk3Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738052931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UxkkWKKQ9npPlvLt4byT2e5frJD5VAnZb6FKr6wuqik=;
	b=R4t+q3aeUkq5gSUfALdm9RTVAdkDfA5/L7g/1J6kgH+1MZDFgwqGHsQKxNZQKlfIpqg9AV
	EiWFeHyq6E3EWw67MIee6EkS6cKLJe5a4z5ynFjWUaMhEUiKS517b77tI+SBP+jg7eAe4X
	lbxeVaW3NPrXCZ3OsuhuSaafgzAlvKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738052931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UxkkWKKQ9npPlvLt4byT2e5frJD5VAnZb6FKr6wuqik=;
	b=pOqnaZjmVQwbkncjeoj3ZYcu18GR1pcnQ92H2kRFaWaMqmIJ72J0V23MGLJzFlRS65xBme
	QDD0084L4MABk3Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD24813625;
	Tue, 28 Jan 2025 08:28:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Wim0LkKVmGdpLAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 28 Jan 2025 08:28:50 +0000
Message-ID: <f75c62ce-04a7-4bc0-ae77-8ed80842bf37@suse.de>
Date: Tue, 28 Jan 2025 09:28:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nvme-tcp: fix connect failure on receiving partial
 ICResp PDU
To: Caleb Sander <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250124184311.1642797-1-csander@purestorage.com>
 <9ea74200-7cbc-4a30-9503-864dcec9b45d@suse.de>
 <CADUfDZoT7JW+d+j6YNmWJ3CKZ45gbvcUSsE6boZwE1C3iXw2_g@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CADUfDZoT7JW+d+j6YNmWJ3CKZ45gbvcUSsE6boZwE1C3iXw2_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_002854_807705_6BDDC531 
X-CRM114-Status: GOOD (  30.36  )
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

On 1/27/25 18:38, Caleb Sander wrote:
> On Sun, Jan 26, 2025 at 11:37 PM Hannes Reinecke <hare@suse.de> wrote:
>>
>> On 1/24/25 19:43, Caleb Sander Mateos wrote:
>>> nvme_tcp_init_connection() attempts to receive an ICResp PDU but only
>>> checks that the return value from recvmsg() is non-negative. If the
>>> sender closes the TCP connection or sends fewer than 128 bytes, this
>>> check will pass even though the full PDU wasn't received.
>>>
>>> Ensure the full ICResp PDU is received by checking that recvmsg()
>>> returns the expected 128 bytes.
>>>
>>> Additionally set the MSG_WAITALL flag for recvmsg(), as a sender could
>>> split the ICResp over multiple TCP frames. Without MSG_WAITALL,
>>> recvmsg() could return prematurely with only part of the PDU.
>>>
>>> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>>> Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
>>> ---
>>> v4: keep recvmsg() error return value
>>> v3: fix return value to indicate error
>>> v2: add Fixes tag
>>>
>>>    drivers/nvme/host/tcp.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index e9ff6babc540..56679eb8c0d6 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -1446,15 +1446,18 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
>>>        iov.iov_len = sizeof(*icresp);
>>>        if (nvme_tcp_queue_tls(queue)) {
>>>                msg.msg_control = cbuf;
>>>                msg.msg_controllen = sizeof(cbuf);
>>>        }
>>> +     msg.msg_flags = MSG_WAITALL;
>>>        ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
>>>                        iov.iov_len, msg.msg_flags);
>>
>> But won't we have to wait for a TCP timeout now if the sender sends less
>> than 128 bytes? With this patch we always wait for 128 bytes, and
>> possibly wait for TCP timeout if not.
> 
> Yes, if the NVMe/TCP controller sends less than 128 bytes, we need to
> wait for it to send the remainder of the ICResp PDU. That's just how
> the NVMe/TCP protocol works. If we want to protect against
> buggy/malicious controllers that don't send a full ICResp, we need a
> timeout mechanism. That's the purpose of the existing
> `queue->sock->sk->sk_rcvtimeo = 10 * HZ;` in nvme_tcp_alloc_queue().
> Note that recvmsg() timing out was already possible in the original
> code if the controller didn't send anything on the TCP connection
> after accepting it.
> 
Hmm. With checking the code 'rcvtimeo' is only evaluated if MSG_WAITALL
is _not_ set. Makes me wonder why we do set it...
But that's beside the point.

>> Testcase for this would be nice ...
>>
>> And I need to check if secure concatenation is affected here; with
>> secure concatenation we need to peek at the first packet to check
>> if it's an ICRESP or a TLS negotiation.
> 
> Are you saying that with secure concatenation we don't know in advance
> whether the connection is using TLS between the TCP and NVMe/TCP
> protocol layers? Wouldn't the host already need to know that when it
> sent its ICReq PDU?

No, the host doesn't need to know. TLS is enabled by the lower
layers.

But upon further checking, I guess it'll be okay with secure
concatenation.

Nevertheless, I would vastly prefer to have a receive loop here
instead of waiting to receive the full amount as per MSG_WAITALL.
The entire tcp code is using nonblocking calls, so I'd rather
keep it that way and implement a receive loop here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

