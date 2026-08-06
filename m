Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D394BC56208
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2026 12:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ndsVTs8Vb4+eWTvpoW1bxOyGOZV5iCDP4dM9epJVIgo=; b=lxvCgevSGiWB4dVEWyqxz2IHid
	RZpz3Jx6+q4poN64awDYyg8XvIhElx4tLj70lpekUmmj8//yXKcmf8Pz0XWF0FnRnRazC9FxMz9m5
	0IKiLkVGgHuxuJtw8x0yj0n/tf2cmZ2SDjYFJ0em4I+2jx6F/+oaOoM3VlxzA2WzY54sXwp0ber8/
	rIazBoFQSHGhqKcsgUKQA2oA0UEpCQpGh9IPoQIVAWqpre82m8ntRYP33TLKpa/WqTaIQa2EXLC4s
	AfX0uMfoPZZBuikbMCWN6mZw8T+B9zvqEVsaQiH9XzKhy84MZQ8YVUvYsiV2BxW8eJ5aKdyMhYROA
	s+H/XGww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrxV1-00000005oqC-3zF9;
	Thu, 06 Aug 2026 12:47:03 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrxUz-00000005opB-2tm1
	for linux-nvme@lists.infradead.org;
	Thu, 06 Aug 2026 12:47:03 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0E4983E05;
	Thu,  6 Aug 2026 12:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786020413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ndsVTs8Vb4+eWTvpoW1bxOyGOZV5iCDP4dM9epJVIgo=;
	b=Rx15opfQXS5I3BI39vYnXEpPK/6+OPHkvqqji4tLlzKku/Xc6VW1gR3VU7lJyBZ9UCeTNp
	O1OLt4KJuPtI9h4nkUAIXto4iIz3JE3/D3v9brY3vNTdU+ysTWk0Bz72JiMBX/rNhuG6LD
	rja9LRVJst/3YwYzzLbRs5QQbddnOEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786020413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ndsVTs8Vb4+eWTvpoW1bxOyGOZV5iCDP4dM9epJVIgo=;
	b=ij5WXpgQwjwrIfHUCG6fP9eCVZIcTGBRs92l4E4ZBQVxNZ2zPeiM9Vh3cfBeHjx0dF8qrn
	EJ2MYvLH7AURu0Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786020409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ndsVTs8Vb4+eWTvpoW1bxOyGOZV5iCDP4dM9epJVIgo=;
	b=bYbp36UWOtJUk0fZmU0sGrRv9Bu4Tnr8ByfdLzmQh2naGO+RpNe+tDStvLM9gLurgmg0X+
	VhHOE5UGWpSZRGgktzb03YrTHRM5Dm0JPVkZdS+4M0sTrj7l5DK/u/XxGXvgeGF37/08VV
	W4XVv8Dn7AyGtJSYnk16XdW0oLyBt6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786020409;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ndsVTs8Vb4+eWTvpoW1bxOyGOZV5iCDP4dM9epJVIgo=;
	b=jRs2wpRpRyVO8JwTQsP0w9mj/IQ9sgFTK1BHSozyRZ/gGqCawjxNpxEQ2GQs0LqXASM8eG
	NWq7q07Ab8dB7rDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF646779B6;
	Thu,  6 Aug 2026 12:46:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FV/AODiCdGqzcQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 06 Aug 2026 12:46:48 +0000
Date: Thu, 6 Aug 2026 14:46:44 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Cc: Chris Leech <cleech@redhat.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Dmitry Bogdanov <d.bogdanov@yadro.com>
Subject: Re: [PATCH] nvme-tcp: fix usage of page_frag_cache
Message-ID: <7d7f4d21-eb8a-46ad-a903-873f2d90b4a5@flourine.local>
References: <20260716-nvme-tcp-page_fraq_cache-v1-1-ea660828cf93@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716-nvme-tcp-page_fraq_cache-v1-1-ea660828cf93@kernel.org>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260806_054701_874387_5238822C 
X-CRM114-Status: GOOD (  14.37  )
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

On Thu, Jul 16, 2026 at 04:42:19PM +0200, Daniel Wagner wrote:
> From: Dmitry Bogdanov <d.bogdanov@yadro.com>
> 
> nvme uses page_frag_cache to preallocate PDU for each preallocated request
> of block device. Block devices are created in parallel threads,
> consequently page_frag_cache is used in not thread-safe manner.
> That leads to incorrect refcounting of backstore pages and premature free.
> 
> That can be catched by !sendpage_ok inside network stack:
> 
> WARNING: CPU: 7 PID: 467 at ../net/core/skbuff.c:6931 skb_splice_from_iter+0xfa/0x310.
> 	tcp_sendmsg_locked+0x782/0xce0
> 	tcp_sendmsg+0x27/0x40
> 	sock_sendmsg+0x8b/0xa0
> 	nvme_tcp_try_send_cmd_pdu+0x149/0x2a0
> Then random panic may occur.
> 
> Fix that by serializing the usage of page_frag_cache.
> 
> Fixes: 4e893ca81170 ("nvme_core: scan namespaces asynchronously")
> Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
> If the target exposes many namespaces (>1000) and the host has many CPUs (>80),
> it is trivial to trigger the allocation race condition in nvme_tcp_init_request
> which results in the logs below:

Any chance to move forward with this on?

