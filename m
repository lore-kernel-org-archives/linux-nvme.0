Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA112C25B76
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jun 2024 07:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rp339kq5sMQTQWuAgyY0m8zVUYDlI1+PpQaPOqzv8ng=; b=WHzNKL6NAF1WkuIFJls4P/Ehqn
	LDeuIJgpspA/iqH+59+avqtZrT+kswZl9SoeISF7MzKCKTr5YFvLGaIB9JOchnLs4FfcL9FssYUeW
	rCO+tlKtbzgek5mVbABIfkNMyw+sorZwEeYKqDcLkuWEOw50fNHCnSEqgWBcEcRNT47ZsXzuxnMSd
	NI+AZka4emhS3LGcRkCfejE4N8VDEnATwRUQlxik+uv0Pz6KBSd4QfuBxqqSGGOYa4iPVKC7dxsgq
	c+9w3A+rE7DkymVbCnPDEFEC9Ao25kkfEjeKfLNe2bv0QGTKWHgQH50VCeKq2Y6c7UX1PwxF0lrs/
	jbpC7s2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE1yG-0000000FsCS-2zMb;
	Mon, 03 Jun 2024 07:19:08 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE1yC-0000000FsB8-141h
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jun 2024 07:19:06 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 45EFA22217;
	Mon,  3 Jun 2024 07:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717399141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rp339kq5sMQTQWuAgyY0m8zVUYDlI1+PpQaPOqzv8ng=;
	b=fnNJiHwBn3EBwbLR6b0INrZic0HiwD5nE/AzhTHwVemqKAr6wSxyvTmxhEzzhnhLhSytkm
	DhGpmdrtBdLLPPhMdRVouJrABaOrTPbFBlIt1RS3PwsZA4xOemteHineY8crjZp+56uiB0
	jO/ARokZxeBMqA7k0jXW38SVaK3ZjHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717399141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rp339kq5sMQTQWuAgyY0m8zVUYDlI1+PpQaPOqzv8ng=;
	b=+BqH44Boug2vgP3fIw56KDp0Y7IfzweIa9mb3N/D/cFRGerQ8GiNxtTH2np83XLVaQLlvj
	6QmJY1UpMnYEMKAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717399141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rp339kq5sMQTQWuAgyY0m8zVUYDlI1+PpQaPOqzv8ng=;
	b=fnNJiHwBn3EBwbLR6b0INrZic0HiwD5nE/AzhTHwVemqKAr6wSxyvTmxhEzzhnhLhSytkm
	DhGpmdrtBdLLPPhMdRVouJrABaOrTPbFBlIt1RS3PwsZA4xOemteHineY8crjZp+56uiB0
	jO/ARokZxeBMqA7k0jXW38SVaK3ZjHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717399141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rp339kq5sMQTQWuAgyY0m8zVUYDlI1+PpQaPOqzv8ng=;
	b=+BqH44Boug2vgP3fIw56KDp0Y7IfzweIa9mb3N/D/cFRGerQ8GiNxtTH2np83XLVaQLlvj
	6QmJY1UpMnYEMKAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A91F13A93;
	Mon,  3 Jun 2024 07:19:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pZqII2RuXWakVgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 03 Jun 2024 07:19:00 +0000
Message-ID: <8fc3fc34-2861-429e-9716-b25b90049693@suse.de>
Date: Mon, 3 Jun 2024 09:18:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] net: introduce helper sendpages_ok()
Content-Language: en-US
To: Ofir Gal <ofir.gal@volumez.com>, davem@davemloft.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, ceph-devel@vger.kernel.org
Cc: dhowells@redhat.com, edumazet@google.com, pabeni@redhat.com,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
 christoph.boehmwalder@linbit.com, idryomov@gmail.com, xiubli@redhat.com
References: <20240530132629.4180932-1-ofir.gal@volumez.com>
 <20240530132629.4180932-2-ofir.gal@volumez.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240530132629.4180932-2-ofir.gal@volumez.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,google.com,kernel.org,kernel.dk,lst.de,grimberg.me,linbit.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_001904_475925_0B9FB459 
X-CRM114-Status: GOOD (  22.79  )
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
> Network drivers are using sendpage_ok() to check the first page of an
> iterator in order to disable MSG_SPLICE_PAGES. The iterator can
> represent list of contiguous pages.
> 
> When MSG_SPLICE_PAGES is enabled skb_splice_from_iter() is being used,
> it requires all pages in the iterator to be sendable. Therefore it needs
> to check that each page is sendable.
> 
> The patch introduces a helper sendpages_ok(), it returns true if all the
> contiguous pages are sendable.
> 
> Drivers who want to send contiguous pages with MSG_SPLICE_PAGES may use
> this helper to check whether the page list is OK. If the helper does not
> return true, the driver should remove MSG_SPLICE_PAGES flag.
> 
> Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
> ---
>   include/linux/net.h | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/include/linux/net.h b/include/linux/net.h
> index 688320b79fcc..b33bdc3e2031 100644
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -322,6 +322,26 @@ static inline bool sendpage_ok(struct page *page)
>   	return !PageSlab(page) && page_count(page) >= 1;
>   }
>   
> +/*
> + * Check sendpage_ok on contiguous pages.
> + */
> +static inline bool sendpages_ok(struct page *page, size_t len, size_t offset)
> +{
> +	unsigned int pagecount;
> +	size_t page_offset;
> +	int k;
> +
> +	page = page + offset / PAGE_SIZE;
> +	page_offset = offset % PAGE_SIZE;
> +	pagecount = DIV_ROUND_UP(len + page_offset, PAGE_SIZE);
> +
Don't we miss the first page for offset > PAGE_SIZE?
I'd rather check for all pages from 'page' up to (offset + len), just
to be on the safe side.

> +	for (k = 0; k < pagecount; k++)
> +		if (!sendpage_ok(page + k))
> +			return false;
> +
> +	return true;
> +}
> +
>   int kernel_sendmsg(struct socket *sock, struct msghdr *msg, struct kvec *vec,
>   		   size_t num, size_t len);
>   int kernel_sendmsg_locked(struct sock *sk, struct msghdr *msg,

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


