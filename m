Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4720CFA74C
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Oct 2024 07:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jyxrtMMo0srSDOrWZHBgsSXMGmObm4rbinVPxzSbSSA=; b=o1l3ZUjWB055jo1oq3jTAHs6Oj
	orvHxPw+ia7BglTVyp0K5XMfdmPrNTB7pXIfkdq0MMdBz4FPgdmE5LjboAHW5bjIwy5/P+ec4tBe/
	KQYMIhF0T2XcLd0MHsNUYQ1mLrGgTIS9TRmF6VjHmsKK0feJXQvsg2UXKp/rGiL9LtPOiiIwXwlSV
	06vzKO8i+81jtrEysPvAtC9pQfEgw+iKKW+j4MHGpyTWiVgS9T5AbShoXTzw8oXp8PqU4BtkUX/HN
	paHQhuN/n/hNFtjGCUTTAsM0DrhWHpvgf3QVxnajFJdJlyy5/sVKOavjFhZeSPGVhAtceUhFNwpM4
	/Qr0jRLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swcwW-0000000BF7H-1u1A;
	Fri, 04 Oct 2024 07:41:40 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swcwR-0000000BF5v-1c6X
	for linux-nvme@lists.infradead.org;
	Fri, 04 Oct 2024 07:41:38 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1527C1F787;
	Fri,  4 Oct 2024 07:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728027691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyxrtMMo0srSDOrWZHBgsSXMGmObm4rbinVPxzSbSSA=;
	b=0ayjNZCAJuzk9FPdz0lNNAIHAjGzBQkehtg5k4BO7Tn9GWFM03F2fgn51vuHi4MnzUzCJo
	xf8I/d/O1vXyaLSmUiCS8r0gKwihIA8m1FnDNtum3y4XRFGb1l3gzmLhHaTEUvXz0+1PhW
	mYbYSvhY+6D43YSSS1Xbto/mp9ox2KM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728027691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyxrtMMo0srSDOrWZHBgsSXMGmObm4rbinVPxzSbSSA=;
	b=Nap7D6nox78gwGU0Gk4bZhlDQcvv9TSMJyPbweOE2u0hbVZ3HlXUn+c3LKrUuCACXa5ZhT
	V68GtUO4owjXynAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0ayjNZCA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Nap7D6no
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728027691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyxrtMMo0srSDOrWZHBgsSXMGmObm4rbinVPxzSbSSA=;
	b=0ayjNZCAJuzk9FPdz0lNNAIHAjGzBQkehtg5k4BO7Tn9GWFM03F2fgn51vuHi4MnzUzCJo
	xf8I/d/O1vXyaLSmUiCS8r0gKwihIA8m1FnDNtum3y4XRFGb1l3gzmLhHaTEUvXz0+1PhW
	mYbYSvhY+6D43YSSS1Xbto/mp9ox2KM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728027691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyxrtMMo0srSDOrWZHBgsSXMGmObm4rbinVPxzSbSSA=;
	b=Nap7D6nox78gwGU0Gk4bZhlDQcvv9TSMJyPbweOE2u0hbVZ3HlXUn+c3LKrUuCACXa5ZhT
	V68GtUO4owjXynAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0F2713A6E;
	Fri,  4 Oct 2024 07:41:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RlrwLCqc/2bFZwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 04 Oct 2024 07:41:30 +0000
Message-ID: <6a03901d-01cd-4ed9-baf9-4d31add2c555@suse.de>
Date: Fri, 4 Oct 2024 09:41:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: tcp: avoid race between queue_lock lock and
 destroy
To: Keith Busch <kbusch@kernel.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Akinobu Mita <akinobu.mita@gmail.com>,
 Martin Belanger <martin.belanger@dell.com>,
 Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>
References: <20241002045141.1975881-1-shinichiro.kawasaki@wdc.com>
 <Zv77BPZnS2hJMUjZ@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Zv77BPZnS2hJMUjZ@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1527C1F787
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,gmail.com,dell.com,infradead.org,grimberg.me];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241004_004135_594327_0C78708E 
X-CRM114-Status: GOOD (  18.62  )
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

On 10/3/24 22:13, Keith Busch wrote:
> On Wed, Oct 02, 2024 at 01:51:41PM +0900, Shin'ichiro Kawasaki wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> Commit 76d54bf20cdc ("nvme-tcp: don't access released socket during
>> error recovery") added a mutex_lock() call for the queue->queue_lock
>> in nvme_tcp_get_address(). However, the mutex_lock() races with
>> mutex_destroy() in nvme_tcp_free_queue(), and causes the WARN below.
> 
> <snip>
> 
>> The WARN is observed when the blktests test case nvme/014 is repeated
>> with tcp transport. It is rare, and 200 times repeat is required to
>> recreate in some test environments.
>>
>> To avoid the WARN, check the NVME_TCP_Q_LIVE flag before locking
>> queue->queue_lock. The flag is cleared long time before the lock gets
>> destroyed.
> 
> I've applied this to nvme-6.12, but the existence of this queue_lock
> seems strange. It looks like tcp is relying on blk-mq's timeout to
> individually complete requests after the queue is stopped, but I feel
> like there should be a way to complete everything in a single batch. We
> have the generic nvme_cancel_request() for this reason, but fabrics has
> it's own other way to do it once at a time?

nvme_cancel_request() just terminates the command internally, so it's of 
limited use for fabrics where we need to synchronize with the controller 
about when to retry commands.
Using the timeout handler is a bit unfortunate; while we start error 
recovery from the timeout handler (which then proceeds to abort all 
commands) other timeouts might be triggering in between leading to
interesting race conditions.
There is a TPAR pending for implementing a third-party controller reset
command which will clear that up, so I've held off trying to work on
that until the TPAR is ratified.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


