Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02B8C0219B
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2025 22:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SKvTNxV2tmW1+uX2nwZylXBcfJZ2zB8IOfXHJ511yIo=; b=fpDmV38K3rdMI7WnMzo9WIqciq
	IDYiT6YMsBaTRA8AUe9iGn30UnMjpSo+0dKm4fUbWxyf1dee/n8Cc6QygYtUIrFtovt6Co/FPr1OM
	rN3NzOJjOY8Ly/ToippYgZPd39OynGEgJk2hBoMuVGZFp2JF8y2ewxZcsh4PYpRQcc8sSnP5G0hwg
	f7gepfwpOUCzo8QYFGiXGCt9LL3h0gxwVLAfWGbpPOJKQ7Gwg+COOeSfwFCueRgEaUTBTa4Uu2Acm
	Z7LJz8jBCzBYBQXfjJzd/qKtNnZp1IE40TeSS+SN8gn1TtJjUdbQpHJ3M6JmFa+ckD3/MM/QPy2QV
	VyfBYxyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thye6-00000005SZV-1FDj;
	Tue, 11 Feb 2025 22:22:22 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thyco-00000005SIC-2l2R
	for linux-nvme@lists.infradead.org;
	Tue, 11 Feb 2025 22:21:03 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 918101F451;
	Tue, 11 Feb 2025 22:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739312459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKvTNxV2tmW1+uX2nwZylXBcfJZ2zB8IOfXHJ511yIo=;
	b=yynztlexDkECKvRrgsBUeoV05QnTE36FztKjlqfNUqmy90Hl7OAccYNRf2zDIoJ1BW6DC9
	iH4ma08rghmRcnb7tQO+PhU6nG7H8tB90lgne0T96cQr8Rng9t7WWBOrYG320m3C/86N/1
	zmGf6DqVKY8HJ2/r42cEgZHCzo5n9do=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739312459;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKvTNxV2tmW1+uX2nwZylXBcfJZ2zB8IOfXHJ511yIo=;
	b=MnwUGPjLLB3tg37/imVgZJswoE0wZUN9OnadofMCCC3ovsY5VRwuXI73rq0XuS7KxheLKJ
	0vGNnQCfoeFguIAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yynztlex;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MnwUGPjL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739312459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKvTNxV2tmW1+uX2nwZylXBcfJZ2zB8IOfXHJ511yIo=;
	b=yynztlexDkECKvRrgsBUeoV05QnTE36FztKjlqfNUqmy90Hl7OAccYNRf2zDIoJ1BW6DC9
	iH4ma08rghmRcnb7tQO+PhU6nG7H8tB90lgne0T96cQr8Rng9t7WWBOrYG320m3C/86N/1
	zmGf6DqVKY8HJ2/r42cEgZHCzo5n9do=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739312459;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKvTNxV2tmW1+uX2nwZylXBcfJZ2zB8IOfXHJ511yIo=;
	b=MnwUGPjLLB3tg37/imVgZJswoE0wZUN9OnadofMCCC3ovsY5VRwuXI73rq0XuS7KxheLKJ
	0vGNnQCfoeFguIAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0FC013715;
	Tue, 11 Feb 2025 22:20:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hOpkMz3Nq2eDYgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 11 Feb 2025 22:20:45 +0000
Message-ID: <67dd48a5-a6a8-4a90-b515-fae0057309da@suse.de>
Date: Tue, 11 Feb 2025 23:20:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nvme-tcp: fix connect failure on receiving partial
 ICResp PDU
To: Caleb Sander <csander@purestorage.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250124184311.1642797-1-csander@purestorage.com>
 <9ea74200-7cbc-4a30-9503-864dcec9b45d@suse.de>
 <CADUfDZoT7JW+d+j6YNmWJ3CKZ45gbvcUSsE6boZwE1C3iXw2_g@mail.gmail.com>
 <f75c62ce-04a7-4bc0-ae77-8ed80842bf37@suse.de>
 <CADUfDZrvHmYQgqu5GiQDrAg_MOEiRigCLCmBSO6jeyd1z+Q-JQ@mail.gmail.com>
 <3bcc6e3f-5172-40d4-a4d4-b0f914b9406b@grimberg.me>
 <CADUfDZq3ZqpP9hZhgG1gzyyggG6SCQiHqHdgbm95TU2oZ5QFUQ@mail.gmail.com>
 <17d0b30a-758c-4a84-9879-0a070656f15e@suse.de>
 <CADUfDZqy4tO5DxWejvBN7-xBVfCfKae4PDq70NYsgMhU+kkJ-A@mail.gmail.com>
 <CADUfDZp5E-oc+ikHQxvFyR7nLPWiOjqKQudC04roarn5ps9w1A@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CADUfDZp5E-oc+ikHQxvFyR7nLPWiOjqKQudC04roarn5ps9w1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 918101F451
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250211_142102_844513_80F40A6D 
X-CRM114-Status: UNSURE (   6.94  )
X-CRM114-Notice: Please train this message.
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

On 2/10/25 18:24, Caleb Sander wrote:
> Gentle ping on this patch. Sagi reviewed it, and I don't hear any
> additional comments from Hannes.
> 
Because you convinced me :-)

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

