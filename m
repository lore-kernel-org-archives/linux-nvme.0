Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B57606A31C
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Nov 2026 07:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=THbCL/3c;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Ld4olRjF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6YL41pu2;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=COkFDrT7;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/RT5H8SM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qPzFvGwary6XtF1vhpofaO32V5oBK6kaWHDOY7t80lM=; b=THbCL/3c2X87Ep
	OJx/G1Ml99ZmWttvt97su8Fqic7LJQAwCqC67ROR9dH3Wges/yvehXdejE7rW4JzpjmC+1NDwWUCg
	iCDaf/nHdXBNve0+lp2xWtmA5/m7dZ5Ygu9ORWnxxq008WuoFLZvSmqy4/BWVQbhbMktzc4VUA/+5
	qGqgaecG7709EoALGt8/ZcCJgPZrZp/PEkFOaxieeUOda9N5vvtIWmWC4EMq0Mk15TCxfjE47BO4B
	Wci14Pvq3r/ZkBa/7BDIzzAlrz8xk0UAzbkZJn2Yp92kag9nPL+alJNkJ3KdpCOGjRj4YiEuOjE2f
	S58HsCdswCHRLLVrl2zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTDXf-00000004lv9-1N00;
	Tue, 17 Nov 2026 07:23:47 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTDXc-00000004luB-0ER1
	for linux-nvme@lists.infradead.org;
	Tue, 17 Nov 2026 07:23:46 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 63F2C2234D;
	Tue, 17 Nov 2026 07:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794900220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPzFvGwary6XtF1vhpofaO32V5oBK6kaWHDOY7t80lM=;
	b=Ld4olRjFCqxeOROvTW2RFTtRvw/ijDB/F3Ov/BP6HF2IdRM4srCIH/NPKpLl5jj8U04ynz
	vCYYXra/D57QCW8NmZmQM63OMMn3FgH+KFqzOF29NeD9SVJzcB8IF6SxRbvfithGXU/MoS
	Is5zcAmKlWj/pizsN6dZtjkKiMlstKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794900220;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPzFvGwary6XtF1vhpofaO32V5oBK6kaWHDOY7t80lM=;
	b=6YL41pu2Lhseh+OV/9cIwyxvaiYG9/K2ZiKYM36gJXUn+MHlIWQ5YMZOxcVX42L6J96y0q
	T6OlrQGBbzu0twBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=COkFDrT7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/RT5H8SM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794900219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPzFvGwary6XtF1vhpofaO32V5oBK6kaWHDOY7t80lM=;
	b=COkFDrT7KliRIVbPcoWZUeyoR2ZrKW9c1BJj20FqwhKAIzV4v1+LCevlj/LFCGsMS+j1MA
	nlEd3X7ZtiaQUyMwfOsxaBeZI7p04ErGKl4z6LGRPjxLJv44vXu+3ltAtmaZvcA8kXxBVN
	S/Stapj14RrtRMwstU9EEFo9FVp/DoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794900219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPzFvGwary6XtF1vhpofaO32V5oBK6kaWHDOY7t80lM=;
	b=/RT5H8SMLiZXdziW4dUImNhWfmR4/plJCUAyv2J7V71OgJrJJfINIbe3o/MA13CwIGptX1
	9jHnCO2JU0YfrrCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05A001334C;
	Tue, 17 Nov 2026 07:23:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HT5iMPoA/GpnfQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 17 Nov 2026 07:23:38 +0000
Message-ID: <0366b9fc-50b4-4739-9564-53c8783bdb0c@suse.de>
Date: Tue, 17 Nov 2026 08:23:38 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] nvme-auth: fix data race on ctrl->transaction
To: Keith Busch <kbusch@kernel.org>
Cc: Guixin Liu <kanie@linux.alibaba.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org
References: <20261116081211.1757155-1-kanie@linux.alibaba.com>
 <20261116081211.1757155-3-kanie@linux.alibaba.com>
 <6dc083eb-7286-418b-92fe-f7245f653ba0@suse.de> <avsjKMMlQPPit6IY@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <avsjKMMlQPPit6IY@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 63F2C2234D
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email]
X-Spam-Score: -13.50
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_232344_243725_09303CD6 
X-CRM114-Status: GOOD (  22.93  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 4:37 PM, Keith Busch wrote:
> On Mon, Nov 16, 2026 at 02:22:51PM +0100, Hannes Reinecke wrote:
>> On 11/16/26 9:12 AM, Guixin Liu wrote:
>>> nvme_ctrl_auth_work() queues the DH-HMAC-CHAP exchange of every queue
>>> on nvme-auth-wq without waiting for them, so multiple
>>> nvme_queue_auth_work() instances run concurrently and all increment
>>> ctrl->transaction in nvme_queue_auth_work(). The plain increment is a
>>> data race, and the lost updates hand the same transaction id to
>>> concurrent queues.
>>>
>>> The counter does not need to be shared at all: the controller only
>>> echoes the transaction id within a queue, so a per-queue counter is
>>> sufficient. Increment chap->transaction instead, drop the reset in
>>> nvme_auth_reset_dhchap() so the id stays monotonic across
>>> re-authentication, and remove the now unused ctrl->transaction field.
>>>
>> I disagree. The authentication transaction ID identifies the
>> transaction itself, and is used to differentiate between different
>> transactions. As such it needs to be unique within each queue.
> 
> But the proposal *is* unique within the queue. It's just not unique at
> the controller level, and it sounds like the protocol doesn't need to
> be.
> 
>> But as it carries controller-specific data we should also ensure
>> the ID is unique per controller, ensuring we catch any possible
>> misdirected authentication packet.
> 
> I don't understand. The qid:T_ID tuple already identifies the
> transaction. If a controller mixes up transactions across queues, it's
> already broken in ways we can't fix, so we shouldn't design around it.
>   
>> It should be possible to move the controller value to an atomic
>> value, and then we could do
> 
> If there's no protocol reason to require this type of uniqueness, then
> I'm not seeing why the driver is putting this constraint on itself.

It's somewhat ambiguous.
Spec says 'carrying the same transaction identifier value for the entire
authentication transaction' (for AUTH_negotiate), and later on 'carrying
the same transaction identifier' (for any other AUTH message).
So actually we just have to make sure they are identical.
(The random number is '4' ...)

But the overall idea here is to distinguish transactions, so the 
implication is that each transaction should carry different identifiers.
And my issue here is precisely 'each transaction'. Surely within each
queue, but I'd really would want to distinguish _across_ queues, too.
(And possibly with a random starting value to boot).
Just to avoid any fuzzers trying to be clever with guessing the 
authentication ID (or bugs setting the transaction ID to 0 for every
queue ... same reason why we introduced the 'genctr' for the command
ID).

But if you don't feel that's an issue, fine, I'll be shutting up.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

