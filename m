Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7256CCA470
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Oct 2025 09:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7hXPaqmmq2s2Y3lyXsf2ahFy73j+9/j9vaK8FcUsZ9k=; b=sMayGF+S3Y6aPIjFOj4eSifJeQ
	Jrd/Xku5aIADIupDoANM7iu4ivLKqBfSiUVwjWHcmG3QKI7Cvxzfy3AUJrA8RHqiXKoROhDno3tn4
	460NlL5ixa4Zt4xYVgcZgBaQlQBlBU9HqmwddUjGOe67FdX42sKk8zFMSP1NM/NfslCsjJorPKcKi
	rTmqyYkyv/O+nvsaQHtcGSDb22UGVoyOnK31jq4R/MRwnclrcxtovRdUyDfpxuizJPEtD0VY4ETGX
	IRT386iXybztiOba0BWla+kV+lwX3sn4JUf+6UuISePdIAAuY2Tfix3z55R4ffYBG6wyApiUiGVJv
	KVFYeqBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v64M5-00000001kBt-2lZe;
	Tue, 07 Oct 2025 09:51:37 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v64M3-00000001kB0-1e9Z
	for linux-nvme@lists.infradead.org;
	Tue, 07 Oct 2025 09:51:36 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 268BE1F7B7;
	Tue,  7 Oct 2025 09:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759830692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hXPaqmmq2s2Y3lyXsf2ahFy73j+9/j9vaK8FcUsZ9k=;
	b=Dnwj/8PaBsqiZdcg3fy/YHJKs9ngFLes8ErwGbAKwBpxAxGkosdYZcymQbd2ezu+WTVvOh
	e1QpViuPhxgMQQ4yLfD/FrYUHHj4gsPvzEilFDUTCJLS2DVWJQMLmx6rWp5rZxeiOdx6Gy
	SZDjIITrSeI0cg8Lu+FveuMjro5lrDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759830692;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hXPaqmmq2s2Y3lyXsf2ahFy73j+9/j9vaK8FcUsZ9k=;
	b=Z0OLcOkBD4fuK/FQWLJqP2gC9h+WJ8a+X/Fg7IIduo2zVzsSLl3DRthWmTP8ohtMoNqrsO
	Iz2K8LoWU5mRJQDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759830692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hXPaqmmq2s2Y3lyXsf2ahFy73j+9/j9vaK8FcUsZ9k=;
	b=Dnwj/8PaBsqiZdcg3fy/YHJKs9ngFLes8ErwGbAKwBpxAxGkosdYZcymQbd2ezu+WTVvOh
	e1QpViuPhxgMQQ4yLfD/FrYUHHj4gsPvzEilFDUTCJLS2DVWJQMLmx6rWp5rZxeiOdx6Gy
	SZDjIITrSeI0cg8Lu+FveuMjro5lrDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759830692;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hXPaqmmq2s2Y3lyXsf2ahFy73j+9/j9vaK8FcUsZ9k=;
	b=Z0OLcOkBD4fuK/FQWLJqP2gC9h+WJ8a+X/Fg7IIduo2zVzsSLl3DRthWmTP8ohtMoNqrsO
	Iz2K8LoWU5mRJQDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2F1013AAC;
	Tue,  7 Oct 2025 09:51:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n320OqPi5Gi2VgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 07 Oct 2025 09:51:31 +0000
Message-ID: <8e5a3ff3-d17a-488f-97fb-3904684edb47@suse.de>
Date: Tue, 7 Oct 2025 11:51:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme/tcp: handle tls partially sent records in
 write_space()
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20251007004634.38716-2-wilfred.opensource@gmail.com>
 <0bf649d5-112f-42a8-bc8d-6ef2199ed19d@suse.de>
 <339cbb66fbcd78d639d0d8463a3a67daf089f40d.camel@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <339cbb66fbcd78d639d0d8463a3a67daf089f40d.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,gmail.com,queasysnail.net,davemloft.net,google.com,redhat.com];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org,vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251007_025135_579339_DC6DF84B 
X-CRM114-Status: GOOD (  16.12  )
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

On 10/7/25 11:24, Wilfred Mallawa wrote:
> On Tue, 2025-10-07 at 07:19 +0200, Hannes Reinecke wrote:
>> On 10/7/25 02:46, Wilfred Mallawa wrote:
>>> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>>>
>>
> [...]
>> I wonder: Do we really need to check for a partially assembled
>> record,
>> or wouldn't it be easier to call queue->write_space() every time
>> here?
>> We sure would end up with executing the callback more often, but if
>> no
>> data is present it shouldn't do any harm.
>>
>> IE just use
>>
>> if (nvme_tcp_queue_tls(queue)
>>       queue->write_space(sk);
> 
> Hey Hannes,
> 
> This was my initial approach, but I figured using
> tls_is_partially_sent_record() might be slightly more efficient. But if
> we think that's negligible, happy to go with this approach (omitting
> the partial record check).
> 
Please do.
Performance testing on NVMe-TCP is notoriously tricky, so for now we
really should not assume anything here.
And it's making the patch _vastly_ simpler, _and_ we don't have to
involve the networking folks here.
We have a similar patch for the data_ready() function in nvmet_tcp(),
and that seemed to work, too.
Nit: we don't unset the 'NOSPACE' flag there. Can you check if that's
really required? And, if it is, fixup nvmet_tcp() to unset it?
Or, if not, modify your patch to not clear it?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

