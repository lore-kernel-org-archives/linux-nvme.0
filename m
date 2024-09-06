Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B207CE7AE8
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 08:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pvl+2iA+yatOmdxtVC+0Yr8+8QG9IIw/fmOw7tPseRU=; b=n7sAQu7qQr4V8xwzy8+y553Hbc
	Q2KzQ+mA0+LBe7RQHyUrjcuR6u5QF6SlzMpd2skdzKDQo0L9pPgGdwBW6YjAie6oNselIdmLVdyEB
	CfFvdb24ELpe71LjeElgLnrZEWS4gFndNcW7HaEmQhVXSdI4GRUZgklMI9i8wNsC6XmKSxaoAlCgo
	vpY55EbaHg2uTpqBcv0pgKB57L9TPzKnVbziRJ7G1+LESm/jGq0kNz+a/FcdT7ItWlmSS6A4D9x2y
	0XkC+l/FMS6T5KLxIwdqFKcouv5XCX/pvTlokichIDxoDKhODBf6cWvw4aL54oTW9RXUCUNIhC6XU
	1SV4c1DQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smUQ6-0000000BLYq-2GKM;
	Fri, 06 Sep 2024 08:34:18 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smUGw-0000000BIes-2SD6
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 08:24:55 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A736E211B2;
	Fri,  6 Sep 2024 08:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725611088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvl+2iA+yatOmdxtVC+0Yr8+8QG9IIw/fmOw7tPseRU=;
	b=uryO0oIINs6X34DN4WOuFFOEukZYBvCzjo+491uGKUww0wcjuOAtrYffzlPgzJDFHB+lwQ
	WEb2QC70F6Tkmhur7WK9LMacK8VjwH7Ts3FuFiFcLxzrV6GR3Azg5RybfQzER+mvThshlS
	1/LyBmg6zAMYjeHB5IEDtyE8YPQbpvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725611088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvl+2iA+yatOmdxtVC+0Yr8+8QG9IIw/fmOw7tPseRU=;
	b=v4H869JJFl1VnEq2YTwzRF6fWSCqLgbNDCjFrx72uk7OM2l8WG9poQ4MhVgPRxK7KV+/HC
	ybuvwbKGCKv+CoDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725611088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvl+2iA+yatOmdxtVC+0Yr8+8QG9IIw/fmOw7tPseRU=;
	b=uryO0oIINs6X34DN4WOuFFOEukZYBvCzjo+491uGKUww0wcjuOAtrYffzlPgzJDFHB+lwQ
	WEb2QC70F6Tkmhur7WK9LMacK8VjwH7Ts3FuFiFcLxzrV6GR3Azg5RybfQzER+mvThshlS
	1/LyBmg6zAMYjeHB5IEDtyE8YPQbpvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725611088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvl+2iA+yatOmdxtVC+0Yr8+8QG9IIw/fmOw7tPseRU=;
	b=v4H869JJFl1VnEq2YTwzRF6fWSCqLgbNDCjFrx72uk7OM2l8WG9poQ4MhVgPRxK7KV+/HC
	ybuvwbKGCKv+CoDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89525136A8;
	Fri,  6 Sep 2024 08:24:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2b8bIVC82mbmRQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 06 Sep 2024 08:24:48 +0000
Message-ID: <2ed1a7ca-9591-4726-bba2-c091f28cd91e@suse.de>
Date: Fri, 6 Sep 2024 10:24:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: get rid of a high-order allocation
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Maurizio Lombardi <mlombard@redhat.com>
References: <20240826120333.529128-1-sagi@grimberg.me>
 <a58ae8bf-fffd-467d-8c37-d94217eebcb4@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <a58ae8bf-fffd-467d-8c37-d94217eebcb4@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_012450_812745_F4071FB9 
X-CRM114-Status: GOOD (  11.90  )
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

On 9/6/24 09:28, Sagi Grimberg wrote:
> 
> 
> 
> On 26/08/2024 15:03, Sagi Grimberg wrote:
>> Allocating the queue commands array leads to a high order
>> allocation.
>>
>> The current size of nvmet_tcp_cmd is 704 bytes. Allocating
>> 128 of those (default queue depth) means that we are allocating
>> an array of 90K bytes. There is no reason why this will be
>> a single contiguous allocation. Change the allocation to be
>> kvcalloc instead.
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>> Hannes, I did not test tls (I wish there were blktests for it)
>> Can you please double check that nothing breaks? Given that now
>> cmd->recv_cbuf is coming from a virtually contiguous allocation
>> (which shouldn't be a problem as far as I can tell...)
> 
> Hannes, can you assist here please?

Sure. I'm just about to respin my tls patches, and will give this
one a spin, too.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


