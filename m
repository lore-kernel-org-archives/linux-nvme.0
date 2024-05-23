Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC0BC25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 09:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YWlvwKKQuk/iYE4AtnLRZsBi8gD3O8iX92QzgRpy/DM=; b=0vzKXZ4+bLx6EbwlL0Dl5a+TX9
	lYRb0RAdo9/uc64336ykJJH0g84heANVCuOs0151A7/1iaFfeZLVxpGFhTDLcDs6+L/h8La+IhTEm
	m2WIDMhFQxa/WTcYL1RT+FqNcKNgoQqYBhWYRxc/AM/HYt75WugL4d6bUTQ5heUUsLMilyyoVhbwB
	Es3k0HwtUwsEnXuytx2hIwIK21RncqhrSMarCApXz+THkkLKKSZw7Jzwin5PvDyjMRO3/jVgk522m
	WAGGkpKHR9HlE8DBCcemdf7Nz2QSBp0uo+hVUqlSWOYvsDBJfdqR3q8hWFqK1FWz9IVo8vw6ia090
	i3FnJ7nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA4yZ-00000005jv6-3U26;
	Thu, 23 May 2024 09:43:07 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA4yT-00000005juC-2xmC
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 09:43:05 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BBE0F2008A;
	Thu, 23 May 2024 09:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716457379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YWlvwKKQuk/iYE4AtnLRZsBi8gD3O8iX92QzgRpy/DM=;
	b=2PuPxN0vkwjIqV65nZqrEcWowwXkCg0GXaK2jIKmwIZfhrsrKN1X5YXlZOH2KWo0Ef9g9k
	atBrP5SU4329b1oR/PktxcLbqTh0iS+sIsWLjr5hE/87dwhCIerDWAcGSq7womj28RsfJ3
	ySw+cSo/IWNHRyAybpNrtr82THt55gE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716457379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YWlvwKKQuk/iYE4AtnLRZsBi8gD3O8iX92QzgRpy/DM=;
	b=ZlPCnpBWymmiKtGnLygFtOqkuGlIEHKOt2fBqQtwLcKpjlb/ETPk3nVUHQVXi8O+PWe556
	BxP48y3vkGxNMaDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716457379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YWlvwKKQuk/iYE4AtnLRZsBi8gD3O8iX92QzgRpy/DM=;
	b=2PuPxN0vkwjIqV65nZqrEcWowwXkCg0GXaK2jIKmwIZfhrsrKN1X5YXlZOH2KWo0Ef9g9k
	atBrP5SU4329b1oR/PktxcLbqTh0iS+sIsWLjr5hE/87dwhCIerDWAcGSq7womj28RsfJ3
	ySw+cSo/IWNHRyAybpNrtr82THt55gE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716457379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YWlvwKKQuk/iYE4AtnLRZsBi8gD3O8iX92QzgRpy/DM=;
	b=ZlPCnpBWymmiKtGnLygFtOqkuGlIEHKOt2fBqQtwLcKpjlb/ETPk3nVUHQVXi8O+PWe556
	BxP48y3vkGxNMaDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9711E13A6C;
	Thu, 23 May 2024 09:42:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gQBtJKMPT2ZBBAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 23 May 2024 09:42:59 +0000
Message-ID: <317aa608-b5a8-4669-9cac-68964bc7a887@suse.de>
Date: Thu, 23 May 2024 11:42:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: fix possible memory leak when tearing down a
 controller
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Yi Zhang <yi.zhang@redhat.com>
References: <20240428084949.61931-1-sagi@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240428084949.61931-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.28 / 50.00];
	BAYES_HAM(-2.99)[99.95%];
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
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_024301_935767_35DFFC3A 
X-CRM114-Status: GOOD (  14.06  )
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

On 4/28/24 10:49, Sagi Grimberg wrote:
> When we teardown the controller, we wait for pending I/Os to complete
> (sq->ref on all queues to drop to zero) and then we go over the commands,
> and free their command buffers in case they are still fetching data from
> the host (e.g. processing nvme writes) and have yet to take a reference
> on the sq.
> 
> However, we may miss the case where commands have failed before executing
> and are queued for sending a response, but will never occur because the
> queue socket is already down. In this case we may miss deallocating command
> buffers.
> 
> Solve this by freeing all commands buffers as nvmet_tcp_free_cmd_buffers is
> idempotent anyways.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/target/tcp.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes



