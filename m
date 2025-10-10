Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74E3CAC5BB
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Oct 2025 09:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rF7BMpVZThR98Bnp9/4MuMCPLSZwN4/7FLEGXoFhOKI=; b=RWNDuIm33/M7nBYQp+lN3SpcLj
	cJ0I9pcyIAhekYOcKI5pneRqUxlN1EVcWe/J69buWx82kyrmR5klepGc9FLPrZZXTa3o0npOoud4V
	cZA7F90KDzX7w1F+9KNfSDSsHHZsMZg1wAYlJlE69Lj9w17mwKT5UvvGiZWXfrM5EIOSSf/C6SV/T
	K8AwWtxuWJD7ZdxrNAffa2LKYzOE4rwJXtl7m+v84wfzQjeyJFRMUZIQzMvC41SHxfmDRuI2J45HJ
	BXPHPHKuP2E4jnRcEqQ0mjMJz98g8//NvcGuhzpwkQrVydUu9t9kvUdqpOdjQU6Cds5qre5raRS3e
	ZnNdbzRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v791m-000000086rK-1jjk;
	Fri, 10 Oct 2025 09:03:06 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v791k-000000086qm-1M7O
	for linux-nvme@lists.infradead.org;
	Fri, 10 Oct 2025 09:03:05 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 12F8A1F393;
	Fri, 10 Oct 2025 09:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760086982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rF7BMpVZThR98Bnp9/4MuMCPLSZwN4/7FLEGXoFhOKI=;
	b=GfFW+YpGuEBN55+5IYb9P5DfsWcw5oly3QWY3uyqfcA5uMdwz39ze/FqIYd+Y5t/MYq4Qr
	cienmn2x6D7ADGCacxmnmEofmoLPjfd4BE919IuRkSKNuxB8552cMZUbInjX6Xeezb0MEE
	zHRXzee8SHZPJiua9ekBfHiu8gsYXZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760086982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rF7BMpVZThR98Bnp9/4MuMCPLSZwN4/7FLEGXoFhOKI=;
	b=dET5+Qv2vYZ66/Yg1xFzbvyqKGt/P2l1AJxsGEgNN1qeR0pNAw4ZKUQMi1MYAdhoXZ0023
	Ck9ey12/zw5UzEAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GfFW+YpG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dET5+Qv2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760086982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rF7BMpVZThR98Bnp9/4MuMCPLSZwN4/7FLEGXoFhOKI=;
	b=GfFW+YpGuEBN55+5IYb9P5DfsWcw5oly3QWY3uyqfcA5uMdwz39ze/FqIYd+Y5t/MYq4Qr
	cienmn2x6D7ADGCacxmnmEofmoLPjfd4BE919IuRkSKNuxB8552cMZUbInjX6Xeezb0MEE
	zHRXzee8SHZPJiua9ekBfHiu8gsYXZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760086982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rF7BMpVZThR98Bnp9/4MuMCPLSZwN4/7FLEGXoFhOKI=;
	b=dET5+Qv2vYZ66/Yg1xFzbvyqKGt/P2l1AJxsGEgNN1qeR0pNAw4ZKUQMi1MYAdhoXZ0023
	Ck9ey12/zw5UzEAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC35513A40;
	Fri, 10 Oct 2025 09:03:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K+jSOMXL6GhkWQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 10 Oct 2025 09:03:01 +0000
Message-ID: <6cd3e802-1137-48b6-85b6-e5db1442ee64@suse.de>
Date: Fri, 10 Oct 2025 11:03:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme/tcp: handle tls partially sent records in
 write_space()
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20251010071939.709063-4-wilfred.opensource@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251010071939.709063-4-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 12F8A1F393
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org,vger.kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251010_020304_508717_7559D7B5 
X-CRM114-Status: GOOD (  19.04  )
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

On 10/10/25 09:19, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> With TLS enabled, records that are encrypted and appended to TLS TX
> list can fail to see a retry if the underlying TCP socket is busy, for
> example, hitting an EAGAIN from tcp_sendmsg_locked(). This is not known
> to the NVMe TCP driver, as the TLS layer successfully generated a record.
> 
> Typically, the TLS write_space() callback would ensure such records are
> retried, but in the NVMe TCP Host driver, write_space() invokes
> nvme_tcp_write_space(). This causes a partially sent record in the TLS TX
> list to timeout after not being retried.
> 
> This patch fixes the above by calling queue->write_space(), which calls
> into the TLS layer to retry any pending records.
> 
> Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
> V2->V3: Minor Style Changes
> ---
> drivers/nvme/host/tcp.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 1413788ca7d5..9a96df1a511c 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1081,6 +1081,9 @@ static void nvme_tcp_write_space(struct sock *sk)
>   	queue = sk->sk_user_data;
>   	if (likely(queue && sk_stream_is_writeable(sk))) {
>   		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> +		/* Ensure pending TLS partial records are retried */
> +		if (nvme_tcp_queue_tls(queue))
> +			queue->write_space(sk);
>   		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>   	}
>   	read_unlock_bh(&sk->sk_callback_lock);

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

