Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210AFC25B76
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jun 2024 07:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a5QpIqfLnJmZAO1whz9lIXGN+ri4N7A336dW2TxOKdI=; b=EjLEkBE2xZWBqOKcmqiungXj/a
	6/CJ1sX9SaKW5JAREjqD+PZMOz90EVwpNCjn7zGJg//zSrrHzyj9KLgh0UX8HpEsoYbmjgD2hmpTt
	Vuk37iUQ9EPJcaL5kvTAsC3yLt/F8uvo7V9pSo7dfGi7+nknZDM8TpoSiGa4d60PZgPUDq0BKqD41
	UzvInwlEkOZ0gIHWKo9UMjGVfPDz7ltPIg2E67WVxCQwFuLxLRk4xkJjLYTdua40I+UkupRb206pS
	EhaqueeZQL+/f0bQOc5xI60rX96n+UAJIexhaG+aVU9MKBMmZmd9dfJlhqZgRvaoBCHkxWqWDiXq5
	ZLfVEYRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE221-0000000Fsri-2K23;
	Mon, 03 Jun 2024 07:23:01 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE21w-0000000Fsqq-0HjS
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jun 2024 07:22:59 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5ABEC2221A;
	Mon,  3 Jun 2024 07:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717399374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a5QpIqfLnJmZAO1whz9lIXGN+ri4N7A336dW2TxOKdI=;
	b=HxLZlnwBB2TkzeR8grhT0rAtRkvdG7boLeJ77/jVS3I/ERP5OJsd4tZO23SxYRE0oMfSrK
	mwjABGG6RMHClHBenSebONwLu8pAfL37Jtpz18XimeVahqWa5npRyeHNxS/HfH6/EWMl87
	sFh/5zfz662TIszGDMKAOMhP3FwJa2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717399374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a5QpIqfLnJmZAO1whz9lIXGN+ri4N7A336dW2TxOKdI=;
	b=TpIhuXrQOjYUWJupSGP8NFbzhMTAqEJHxeuoho8wDaXBGNRMRg0aQCWNUN58mKgF2CkxjV
	RBrq57FI9mOzx2AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717399374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a5QpIqfLnJmZAO1whz9lIXGN+ri4N7A336dW2TxOKdI=;
	b=HxLZlnwBB2TkzeR8grhT0rAtRkvdG7boLeJ77/jVS3I/ERP5OJsd4tZO23SxYRE0oMfSrK
	mwjABGG6RMHClHBenSebONwLu8pAfL37Jtpz18XimeVahqWa5npRyeHNxS/HfH6/EWMl87
	sFh/5zfz662TIszGDMKAOMhP3FwJa2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717399374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a5QpIqfLnJmZAO1whz9lIXGN+ri4N7A336dW2TxOKdI=;
	b=TpIhuXrQOjYUWJupSGP8NFbzhMTAqEJHxeuoho8wDaXBGNRMRg0aQCWNUN58mKgF2CkxjV
	RBrq57FI9mOzx2AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8AB0139CB;
	Mon,  3 Jun 2024 07:22:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PsJOKk1vXWa1VwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 03 Jun 2024 07:22:53 +0000
Message-ID: <2be3230e-993a-46af-ad46-4da16c7a7d25@suse.de>
Date: Mon, 3 Jun 2024 09:22:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nvme-tcp: use sendpages_ok() instead of sendpage_ok()
Content-Language: en-US
To: Ofir Gal <ofir.gal@volumez.com>, davem@davemloft.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, ceph-devel@vger.kernel.org
Cc: dhowells@redhat.com, edumazet@google.com, pabeni@redhat.com,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
References: <20240530132629.4180932-1-ofir.gal@volumez.com>
 <20240530132629.4180932-3-ofir.gal@volumez.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240530132629.4180932-3-ofir.gal@volumez.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_002256_287416_5EBDAED4 
X-CRM114-Status: GOOD (  18.08  )
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

On 5/30/24 15:26, Ofir Gal wrote:
> Currently nvme_tcp_try_send_data() use sendpage_ok() in order to disable
> MSG_SPLICE_PAGES, it check the first page of the iterator, the iterator
> may represent contiguous pages.
> 
> MSG_SPLICE_PAGES enables skb_splice_from_iter() which checks all the
> pages it sends with sendpage_ok().
> 
> When nvme_tcp_try_send_data() sends an iterator that the first page is
> sendable, but one of the other pages isn't skb_splice_from_iter() warns
> and aborts the data transfer.
> 
> Using the new helper sendpages_ok() in order to disable MSG_SPLICE_PAGES
> solves the issue.
> 
> Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
> ---
>   drivers/nvme/host/tcp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 8b5e4327fe83..9f0fd14cbcb7 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1051,7 +1051,7 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
>   		else
>   			msg.msg_flags |= MSG_MORE;
>   
> -		if (!sendpage_ok(page))
> +		if (!sendpages_ok(page, len, offset))
>   			msg.msg_flags &= ~MSG_SPLICE_PAGES;
>   
>   		bvec_set_page(&bvec, page, len, offset);
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


