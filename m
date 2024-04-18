Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E52C4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Apr 2024 10:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a3pnaH989WYTyxOy6i7/TTmy3CM22FhmBMpZf8Apfto=; b=fE4UwXEX3FHBy+Bqm8xLID7a+X
	hKQWM9sy7WxGwWD2cpxr5G67b1b6DQWppstp0CfE8ak9TfdeCsu5xB134JBTG0ncLUH2Mj2YWfIJf
	VyhvCANdQWEDN4ZanQI59DEgpu/kSfa483j+P88ITdbZOhEAlQL5IPX2dpAo4zhAlidX+fNT7qH/S
	5EifcAyGGEnXjADFXtFvlD/8EKVVWS0M3HF86evAVlLsEX1McBGrvbPPexNhrInjTsmiXkVmos7s9
	bzUZ0PfMUjHBweC89qFs9sgaMHtKU6aWR/ApanbnvlXBGHOolMFNGkP9slEylXInP4fjcaJxSopyN
	9AN5dCjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxOvQ-00000001mxa-0jRT;
	Thu, 18 Apr 2024 10:23:28 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxOvJ-00000001mvQ-3GOV
	for linux-nvme@lists.infradead.org;
	Thu, 18 Apr 2024 10:23:25 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4D54B34091;
	Thu, 18 Apr 2024 10:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713435798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3pnaH989WYTyxOy6i7/TTmy3CM22FhmBMpZf8Apfto=;
	b=KY2O1i2UQlRvTeWzlfYYDh2xKj/crIIOmRhX7rT0LIK0qsJw+v9Zk1WEBp3iQ9h7ssrPUw
	Y6iGZWZZ7v9yDzrXH6YbimhJujifJwPX9csupzeXnRf89fGrPfBtqoIbS9zuo6CIDA1v7v
	OYBFyIWW954rWuDVh/czlZZxpW0DRog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713435798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3pnaH989WYTyxOy6i7/TTmy3CM22FhmBMpZf8Apfto=;
	b=P0ZqVeePlGY/GvTLn87cRHwDm4z3uEmd2A5fz00o01Dbc4LhirSqhsBwG90ldY76bo717t
	WvlrF3Gate0hC8CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713435797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3pnaH989WYTyxOy6i7/TTmy3CM22FhmBMpZf8Apfto=;
	b=EF7RHCk5ETdjDRrESzfWaf/0PmCMjy9XP4PY6O9tQsLkuvUqGo3cKU2wVidY4MMWKwMLhY
	L9Bc9zogsKJdlmgjnuTxi1wpwLRAUpd7wAqPUfGQOIAf60U2v6ZCgxbrHNIBRxcIJEPHtu
	tp/GNdcOjdL47yWlpiIw+ETv5/BlclU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713435797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3pnaH989WYTyxOy6i7/TTmy3CM22FhmBMpZf8Apfto=;
	b=HgsRLTy/uqwbfNrlX6jfuo855wa2/NzMJ0MB9buC+IONyxnFBgdM7BfneLR0Cb7o7/oaIe
	ejDe0HSQPsuo/QCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BB7A13687;
	Thu, 18 Apr 2024 10:23:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /YKADZX0IGZUTQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 18 Apr 2024 10:23:17 +0000
Message-ID: <52554de3-7d4c-4754-af7a-9baa7778fff8@suse.de>
Date: Thu, 18 Apr 2024 12:23:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-tcp: strict pdu pacing to avoid send stalls on TLS
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240418101831.41954-1-hare@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240418101831.41954-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_032322_016832_208F2F84 
X-CRM114-Status: GOOD (  19.36  )
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

On 4/18/24 12:18, Hannes Reinecke wrote:
> TLS requires a strict pdu pacing via MSG_EOR to signal the end
> of a record and subsequent encryption. If we do not set MSG_EOR
> at the end of a sequence the record won't be closed, encryption
> doesn't start, and we end up with a send stall as the message
> will never be passed on to the TCP layer.
> So do not check for the queue status when TLS is enabled but
> rather make the MSG_MORE setting dependent on the current
> request only.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/host/tcp.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 2b821cbbdf1f..aef1bb8d2f2b 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -369,12 +369,17 @@ static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
>   	} while (ret > 0);
>   }
>   
> -static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
> +static inline bool nvme_tcp_queue_has_pending(struct nvme_tcp_queue *queue)
>   {
>   	return !list_empty(&queue->send_list) ||
>   		!llist_empty(&queue->req_list);
>   }
>   
> +static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
> +{
> +	return !nvme_tcp_tls_enabled(queue) && nvme_tcp_queue_has_pending(queue);
> +}
> +
>   static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
>   		bool sync, bool last)
>   {
> @@ -395,7 +400,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
>   		mutex_unlock(&queue->send_mutex);
>   	}
>   
> -	if (last && nvme_tcp_queue_more(queue))
> +	if (last && nvme_tcp_queue_has_pending(queue))
>   		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>   }
>   
Bah. Missed the preliminary patch. Forget this one, I'll resend.

Cheers,

Hannes


