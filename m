Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6364AC0218C
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jan 2025 08:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pcJWvty6IsJLPlgXPzoyMqK/3ezLNnrgcU5Soq1Ovy8=; b=y6c+G9DhexZnRfctT70lIMpBvm
	IJg360xuXnwUfFO39gX3158MedbctTu22j74b1uFa7s2ulKjEJ4Zjpw7lT1a/EaHh5bqSPqnFca2P
	YEDL3Tkev9SICzNzRsKjqXTYpPd5f/oX7ROomQqTYNaT/p/dPzsccaodHW+F72ETwc7vbfS7PXMk3
	E3Yv0blWAiS2mi5zLh1kGOcUaALGpWW16BL2I2H4fukEglaJrrQ/hq7Dd5V+szl//phC6wauOiO4l
	9fXIFmTQovz1xNwsOXkIC9DUQ1R6xgg5JsXmWO3gzRXbkt/XSyPZi1QFgGFT963edrXAhhXTRcty5
	B+y5nJnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcKCt-00000001s5Y-3Bnd;
	Mon, 27 Jan 2025 08:10:55 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcKBm-00000001ryA-1wTJ
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jan 2025 08:09:48 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A714921114;
	Mon, 27 Jan 2025 08:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737965384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pcJWvty6IsJLPlgXPzoyMqK/3ezLNnrgcU5Soq1Ovy8=;
	b=kOGV0enlKVmVUCgIHqCx54N6eCEo0IdIK3X5U+we8bySrz1c8/AEt3zscMvlVE32YicB2S
	cBf52Y6ZizEmCsVZZRdbj7W6liD1cythfJY8CAxgRVP9KMI429hdZ445zBVhgvEDppqgTf
	SOxLnITO/Y1j+IXA590K+tokygcnfdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737965384;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pcJWvty6IsJLPlgXPzoyMqK/3ezLNnrgcU5Soq1Ovy8=;
	b=fXIZMlqPRDCElrqNnZHmEL0iqUY+Aumm2py+vpKPVxMPbPV75i9Fp8vfuVixlx7504V3/+
	ciqZyxABjoXt/KAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737965384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pcJWvty6IsJLPlgXPzoyMqK/3ezLNnrgcU5Soq1Ovy8=;
	b=kOGV0enlKVmVUCgIHqCx54N6eCEo0IdIK3X5U+we8bySrz1c8/AEt3zscMvlVE32YicB2S
	cBf52Y6ZizEmCsVZZRdbj7W6liD1cythfJY8CAxgRVP9KMI429hdZ445zBVhgvEDppqgTf
	SOxLnITO/Y1j+IXA590K+tokygcnfdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737965384;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pcJWvty6IsJLPlgXPzoyMqK/3ezLNnrgcU5Soq1Ovy8=;
	b=fXIZMlqPRDCElrqNnZHmEL0iqUY+Aumm2py+vpKPVxMPbPV75i9Fp8vfuVixlx7504V3/+
	ciqZyxABjoXt/KAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E9C613715;
	Mon, 27 Jan 2025 08:09:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NXhKFUg/l2etewAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 27 Jan 2025 08:09:44 +0000
Message-ID: <80138543-2b15-47bf-9b0a-d959ce79001f@suse.de>
Date: Mon, 27 Jan 2025 09:09:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nvme-tcp: fix connect failure on receiving partial
 ICResp PDU
From: Hannes Reinecke <hare@suse.de>
To: Caleb Sander Mateos <csander@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250124184311.1642797-1-csander@purestorage.com>
 <9ea74200-7cbc-4a30-9503-864dcec9b45d@suse.de>
Content-Language: en-US
In-Reply-To: <9ea74200-7cbc-4a30-9503-864dcec9b45d@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,purestorage.com:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250127_000946_678525_3E79177F 
X-CRM114-Status: GOOD (  25.57  )
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

On 1/27/25 08:37, Hannes Reinecke wrote:
> On 1/24/25 19:43, Caleb Sander Mateos wrote:
>> nvme_tcp_init_connection() attempts to receive an ICResp PDU but only
>> checks that the return value from recvmsg() is non-negative. If the
>> sender closes the TCP connection or sends fewer than 128 bytes, this
>> check will pass even though the full PDU wasn't received.
>>
>> Ensure the full ICResp PDU is received by checking that recvmsg()
>> returns the expected 128 bytes.
>>
>> Additionally set the MSG_WAITALL flag for recvmsg(), as a sender could
>> split the ICResp over multiple TCP frames. Without MSG_WAITALL,
>> recvmsg() could return prematurely with only part of the PDU.
>>
>> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>> Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
>> ---
>> v4: keep recvmsg() error return value
>> v3: fix return value to indicate error
>> v2: add Fixes tag
>>
>>   drivers/nvme/host/tcp.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index e9ff6babc540..56679eb8c0d6 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -1446,15 +1446,18 @@ static int nvme_tcp_init_connection(struct 
>> nvme_tcp_queue *queue)
>>       iov.iov_len = sizeof(*icresp);
>>       if (nvme_tcp_queue_tls(queue)) {
>>           msg.msg_control = cbuf;
>>           msg.msg_controllen = sizeof(cbuf);
>>       }
>> +    msg.msg_flags = MSG_WAITALL;
>>       ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
>>               iov.iov_len, msg.msg_flags);
> 
> But won't we have to wait for a TCP timeout now if the sender sends less 
> than 128 bytes? With this patch we always wait for 128 bytes, and
> possibly wait for TCP timeout if not.
> Testcase for this would be nice ...
> 
> And I need to check if secure concatenation is affected here; with
> secure concatenation we need to peek at the first packet to check
> if it's an ICRESP or a TLS negotiation.
> 
And wouldn't this patch be sufficient here?

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 841238f38fdd..85b1328a8757 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1451,12 +1451,13 @@ static int nvme_tcp_init_connection(struct 
nvme_tcp_queue *queue)
         }
         ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
                         iov.iov_len, msg.msg_flags);
+       if (ret == 0)
+               ret = -ENOTCONN;
         if (ret < 0) {
                 pr_warn("queue %d: failed to receive icresp, error %d\n",
                         nvme_tcp_queue_id(queue), ret);
                 goto free_icresp;
         }
-       ret = -ENOTCONN;
         if (nvme_tcp_queue_tls(queue)) {
                 ctype = tls_get_record_type(queue->sock->sk,
                                             (struct cmsghdr *)cbuf);

icresp validity is checked later in the code, so if we haven't received
a full icresp we _should_ fail those tests. And then we don't really
have to check how many bytes we've received.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

