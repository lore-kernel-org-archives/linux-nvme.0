Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FE7C0218C
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jan 2025 07:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KI1GZvIbQWWOKmubBEYYwZB7PMeem/+3YRsB0elMrbY=; b=bXuz1Y1l2fbQ/eTYYQXXT4odZa
	fkz0T/NxBvqwN9UhMCDl8iIpMODCFEz0rZuNsVur+HbL63w/UARqt4uvgawkPbjy1gmv1A8/Wmo/Y
	FhegU8mvlh/94yvwZvegDimLxWe0DAqEyDh+RFyxOC4be9Y7pWQ3sq3lgtrgd3IQ+Ecu5D1uk8aKM
	6mkmrHMChqHrI+tF67az4bnaex9U1zZXsSRGnGLYTlsIj82i6Fyuw1OLP4CrgsQKR0nnmEeoErj5s
	sXA6I/uhvYY0C7vNpVEcUdzR4AKfGfvmfTF1ZAKdIVeNjq2R4TniZrDVKokdikPRP3X3Lw7iRl7WQ
	tZV7qaLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcJgk-00000001pPM-2MP1;
	Mon, 27 Jan 2025 07:37:42 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcJgh-00000001pOc-0Rcm
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jan 2025 07:37:40 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 720EC1F38F;
	Mon, 27 Jan 2025 07:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737963457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KI1GZvIbQWWOKmubBEYYwZB7PMeem/+3YRsB0elMrbY=;
	b=oQKTbdA8q6PNCOcj12SVTyN9gGiW1IW4DKt9ren54EfmaKSfEnlWK6fHYWW7shuUiPXt/4
	B30T5Lpkn+cNZggzZ39TquVDNhe3z0BKI+JicM19HhY4ns6lYNRaWcl/kXiKlCQamtN1Si
	IQgi16n2jJ5NWuXCRFyT9Ovcz2JvB/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737963457;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KI1GZvIbQWWOKmubBEYYwZB7PMeem/+3YRsB0elMrbY=;
	b=p6R6li745OMQtCK20DYcYY9SCCrkM205m9OUOjkU2ryd6/9XQHzJcJ50/3DP86ad1YZlU3
	t96H92md2Sr8Y3BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oQKTbdA8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=p6R6li74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737963457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KI1GZvIbQWWOKmubBEYYwZB7PMeem/+3YRsB0elMrbY=;
	b=oQKTbdA8q6PNCOcj12SVTyN9gGiW1IW4DKt9ren54EfmaKSfEnlWK6fHYWW7shuUiPXt/4
	B30T5Lpkn+cNZggzZ39TquVDNhe3z0BKI+JicM19HhY4ns6lYNRaWcl/kXiKlCQamtN1Si
	IQgi16n2jJ5NWuXCRFyT9Ovcz2JvB/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737963457;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KI1GZvIbQWWOKmubBEYYwZB7PMeem/+3YRsB0elMrbY=;
	b=p6R6li745OMQtCK20DYcYY9SCCrkM205m9OUOjkU2ryd6/9XQHzJcJ50/3DP86ad1YZlU3
	t96H92md2Sr8Y3BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2561A137C0;
	Mon, 27 Jan 2025 07:37:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Hmp+B8E3l2eRIQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 27 Jan 2025 07:37:37 +0000
Message-ID: <9ea74200-7cbc-4a30-9503-864dcec9b45d@suse.de>
Date: Mon, 27 Jan 2025 08:37:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nvme-tcp: fix connect failure on receiving partial
 ICResp PDU
To: Caleb Sander Mateos <csander@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250124184311.1642797-1-csander@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250124184311.1642797-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 720EC1F38F
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250126_233739_315920_34C60939 
X-CRM114-Status: GOOD (  21.95  )
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

On 1/24/25 19:43, Caleb Sander Mateos wrote:
> nvme_tcp_init_connection() attempts to receive an ICResp PDU but only
> checks that the return value from recvmsg() is non-negative. If the
> sender closes the TCP connection or sends fewer than 128 bytes, this
> check will pass even though the full PDU wasn't received.
> 
> Ensure the full ICResp PDU is received by checking that recvmsg()
> returns the expected 128 bytes.
> 
> Additionally set the MSG_WAITALL flag for recvmsg(), as a sender could
> split the ICResp over multiple TCP frames. Without MSG_WAITALL,
> recvmsg() could return prematurely with only part of the PDU.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
> ---
> v4: keep recvmsg() error return value
> v3: fix return value to indicate error
> v2: add Fixes tag
> 
>   drivers/nvme/host/tcp.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index e9ff6babc540..56679eb8c0d6 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1446,15 +1446,18 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
>   	iov.iov_len = sizeof(*icresp);
>   	if (nvme_tcp_queue_tls(queue)) {
>   		msg.msg_control = cbuf;
>   		msg.msg_controllen = sizeof(cbuf);
>   	}
> +	msg.msg_flags = MSG_WAITALL;
>   	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
>   			iov.iov_len, msg.msg_flags);

But won't we have to wait for a TCP timeout now if the sender sends less 
than 128 bytes? With this patch we always wait for 128 bytes, and
possibly wait for TCP timeout if not.
Testcase for this would be nice ...

And I need to check if secure concatenation is affected here; with
secure concatenation we need to peek at the first packet to check
if it's an ICRESP or a TLS negotiation.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

