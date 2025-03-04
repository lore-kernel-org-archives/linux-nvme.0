Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBE2C021B8
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Mar 2025 15:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cX6k9psTnQCcVskkQ80w3Ui6nPJZVH+Jx2TP5xA1oDo=; b=LVfVh6mv+vPs5tX+UQU/y7Esyx
	x15BgseoT4YU0et4wSzHyR783BTA+JqrT21RBH8S+JhvKWe6aLkCgmnWhHkO1fJpbRj67F/3f8q39
	9A1JXN4bI7N0+bjUTsFR10wFp3rD/533n8NAqHEz/GjYcA/ydw9UH1+buOUzMbWE3Azach0m9PXCx
	BIJCeXJ5bOJWretvfDweR8N3dzVBt+T79sja6RUETJzgqAqFN19z12bY9OWy4Is4CkbJpSgmn6Lw6
	B9pk/qBTMvpKE4I/Aw1O2VCygAa61QpMu+7yxJw9wdg9zET7KiXb8rIWMBaw+wIldl8xyB9kF1bwq
	DUB20N+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpUSQ-00000005H1h-33Nq;
	Tue, 04 Mar 2025 15:45:22 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpTvD-000000058rw-32vp
	for linux-nvme@lists.infradead.org;
	Tue, 04 Mar 2025 15:11:04 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 46F5C1F745;
	Tue,  4 Mar 2025 15:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741101062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cX6k9psTnQCcVskkQ80w3Ui6nPJZVH+Jx2TP5xA1oDo=;
	b=FtdXr/sbgTevIT7kLTiK2NqosX3i1oi7WsvBkLuBm9F4T0zoBRDP1oaV8SQQYN8ocOD0MJ
	FA5Dpuzm2GR0/ZCpoOfivGWieCOmC3FDj6ZXSx6s2SBLzlHvPdB5WcA2s4m5jD0qAfwrA6
	dCLLgQ0DAlPOuhAH1fx/RpnEP9cRWUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741101062;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cX6k9psTnQCcVskkQ80w3Ui6nPJZVH+Jx2TP5xA1oDo=;
	b=O9OuXOL506gxbwAPJXlyJuzp3cqCXrhd2a580OA85f0RTsUnzcmJXek/pOnMGjpsQfz8Ha
	0OJ9qlGJh6wOnQAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741101062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cX6k9psTnQCcVskkQ80w3Ui6nPJZVH+Jx2TP5xA1oDo=;
	b=FtdXr/sbgTevIT7kLTiK2NqosX3i1oi7WsvBkLuBm9F4T0zoBRDP1oaV8SQQYN8ocOD0MJ
	FA5Dpuzm2GR0/ZCpoOfivGWieCOmC3FDj6ZXSx6s2SBLzlHvPdB5WcA2s4m5jD0qAfwrA6
	dCLLgQ0DAlPOuhAH1fx/RpnEP9cRWUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741101062;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cX6k9psTnQCcVskkQ80w3Ui6nPJZVH+Jx2TP5xA1oDo=;
	b=O9OuXOL506gxbwAPJXlyJuzp3cqCXrhd2a580OA85f0RTsUnzcmJXek/pOnMGjpsQfz8Ha
	0OJ9qlGJh6wOnQAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 269B313967;
	Tue,  4 Mar 2025 15:11:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T8QBCQYYx2c8PwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 04 Mar 2025 15:11:02 +0000
Message-ID: <24870f73-97f9-496d-a1ca-787b54c222e4@suse.de>
Date: Tue, 4 Mar 2025 16:11:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel oops with 6.14 when enabling TLS
To: Vlastimil Babka <vbabka@suse.cz>, Hannes Reinecke <hare@suse.com>,
 Matthew Wilcox <willy@infradead.org>, Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <08c29e4b-2f71-4b6d-8046-27e407214d8c@suse.com>
 <509dd4d3-85e9-40b2-a967-8c937909a1bf@suse.com>
 <Z8W8OtJYFzr9OQac@casper.infradead.org>
 <Z8W_1l7lCFqMiwXV@casper.infradead.org>
 <15be2446-f096-45b9-aaf3-b371a694049d@suse.com>
 <Z8XPYNw4BSAWPAWT@casper.infradead.org>
 <edf65d4e-90f0-4b12-b04f-35e97974a36f@suse.cz>
 <95b0b93b-3b27-4482-8965-01963cc8beb8@suse.cz>
 <fcfa11c6-2738-4a2e-baa8-09fa8f79cbf3@suse.de>
 <a466b577-6156-4501-9756-1e9960aa4891@suse.cz>
 <6877dfb1-9f44-4023-bb6d-e7530d03e33c@suse.com>
 <db1a4681-1882-4e0a-b96f-a793e8fffb56@suse.cz>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <db1a4681-1882-4e0a-b96f-a793e8fffb56@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[suse.cz,suse.com,infradead.org,nvidia.com,gmail.com,kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250304_071103_932028_24FD36CF 
X-CRM114-Status: GOOD (  10.40  )
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

On 3/4/25 11:26, Vlastimil Babka wrote:
> On 3/4/25 11:20, Hannes Reinecke wrote:

[ .. ]
>> So I'd be happy with an 'easy' fix for now. Obviously :-)
>>

With this patch:

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 65f550cb5081..b035a9928cdd 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1190,8 +1190,14 @@ static ssize_t __iov_iter_get_pages_alloc(struct 
iov_iter *i,
                 if (!n)
                         return -ENOMEM;
                 p = *pages;
-               for (int k = 0; k < n; k++)
-                       get_page(p[k] = page + k);
+               for (int k = 0; k < n; k++) {
+                       if (!get_page_unless_zero(p[k] = page + k)) {
+                               pr_warn("%s: frozen page %d of %d\n",
+                                       __func__, k, n);
+                               return -ENOMEM;
+                       }
+               }
+
                 maxsize = min_t(size_t, maxsize, n * PAGE_SIZE - *start);
                 i->count -= maxsize;
                 i->iov_offset += maxsize;


the system doesn't crash anymore:
[   51.520949] __iov_iter_get_pages_alloc: frozen page 0 of 1
[   51.536393] nvme nvme0: creating 4 I/O queues.
[   51.968897] nvme nvme0: mapped 4/0/0 default/read/poll queues.
[   51.972207] __iov_iter_get_pages_alloc: frozen page 0 of 1
[   51.974528] __iov_iter_get_pages_alloc: frozen page 0 of 1
[   51.976928] __iov_iter_get_pages_alloc: frozen page 0 of 1
[   51.978980] __iov_iter_get_pages_alloc: frozen page 0 of 1
[   51.981236] nvme nvme0: new ctrl: NQN "nqn.blktests-subsystem-1", 
addr 10.161.9.19:4420, hostnqn: 
nqn.2014-08.org.nvmexpress:uuid:027a49dc-b554-40e5-b0f9-0a9ea03ec30c

and the allocation in question is coming from
drivers/nvme/host/fabrics.c:nvmf_connect_data_prep(), which
coincidentally _is_ a kmalloc()ed buffer.

But TLS doesn't work, either:

[   58.886754] nvme nvme0: I/O tag 1 (3001) type 4 opcode 0x18 (Keep 
Alive) QID 0 timeout
[   58.889112] nvme nvme0: starting error recovery
[   58.892176] nvme nvme0: failed nvme_keep_alive_end_io error=10
[   58.892282] nvme nvme0: reading non-mdts-limits failed: -4
[   58.902490] nvme nvme0: Reconnecting in 10 seconds...

(probably not surprising seeing that an error is returned ..)

So yeah, looks like TLS has issues with kmalloced data.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

