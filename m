Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BA0606A31E
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SLRq+cFH;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=pfn4kK5d;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=59GVsKrf;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=pfn4kK5d;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=59GVsKrf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=bsG7crIIuAMMMeIJH2tXsDbmQj/vvYfAUVvbzdxkpL4=; b=SLRq+cFHKxXuNH
	VTdAx79afwOV4B9LGTQd13AvdE54GAc9zEwb9hbNJeK48E8CgWCs623ih8p6cKUwVPmQLgjURf9Uu
	J79fzbaEVIsM4CEbgxRkjd17vtoxVd+49vngodHXu291xLrOtvhNRRtIMda48lGNvhl2IfrnFSamd
	PDwsERZWsP8rY6YdIGeuXskuwkRgyIgBFnX9zYcBBcjRyAphb9y9XMtdZlBwgV38lr6Fi5urgGsK9
	GF7SE4lMnfv9Ip/3YN4C73DRdKZN6aas8B88ITOVKmnvxDpcxzlWbb+6ox7+SbotH5yfZb+Yxl+MS
	mhNwYhAHb0wVgWEM7V2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4x2-00000007FOe-0fiC;
	Wed, 28 Oct 2026 14:48:28 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4wy-00000007FO5-3eWz
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 14:48:26 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8AF3F22117;
	Wed, 28 Oct 2026 14:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793198902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsG7crIIuAMMMeIJH2tXsDbmQj/vvYfAUVvbzdxkpL4=;
	b=pfn4kK5d+rDIAG3rbOXd6tXkIfpmj5nNhmMDTolo6hiJBmWkiubuN9OIzjdrIBgXCSLL4P
	0hJJTly/TJOInjx22Yt/cF94WriS6JC7idV3zlRTmqi4lMjqhswg1M9/s35IIiWKq9ljkT
	Dhu8jpm8ej0TpdqI8SLI8wU3QCwFi0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793198902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsG7crIIuAMMMeIJH2tXsDbmQj/vvYfAUVvbzdxkpL4=;
	b=59GVsKrf5jliqBjkYtcu3V/6JQkKOzB4KjKlaUFqvACyS/JvazmdaMphS3/HD3KqpNTkLK
	bzpnYUPmjNo0d9CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793198902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsG7crIIuAMMMeIJH2tXsDbmQj/vvYfAUVvbzdxkpL4=;
	b=pfn4kK5d+rDIAG3rbOXd6tXkIfpmj5nNhmMDTolo6hiJBmWkiubuN9OIzjdrIBgXCSLL4P
	0hJJTly/TJOInjx22Yt/cF94WriS6JC7idV3zlRTmqi4lMjqhswg1M9/s35IIiWKq9ljkT
	Dhu8jpm8ej0TpdqI8SLI8wU3QCwFi0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793198902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsG7crIIuAMMMeIJH2tXsDbmQj/vvYfAUVvbzdxkpL4=;
	b=59GVsKrf5jliqBjkYtcu3V/6JQkKOzB4KjKlaUFqvACyS/JvazmdaMphS3/HD3KqpNTkLK
	bzpnYUPmjNo0d9CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D6D513419;
	Wed, 28 Oct 2026 14:48:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7WU4OjUL4mpRDgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 28 Oct 2026 14:48:22 +0000
Message-ID: <fe2db289-20e4-4496-8263-4897b3259f83@suse.de>
Date: Wed, 28 Oct 2026 15:48:21 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: Check the admin queue before reading its TLS key
 in debugfs
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261028064417.548948-1-kanie@linux.alibaba.com>
 <2f4468e2-9b25-4df7-8ad9-606a9aee2e0b@suse.de>
 <db1819ed-a087-46fa-acab-9f94ec778ce6@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <db1819ed-a087-46fa-acab-9f94ec778ce6@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.997];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,alibaba.com:email];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,alibaba.com:email]
X-Spam-Score: -13.29
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_074825_069305_EFE662E2 
X-CRM114-Status: GOOD (  18.49  )
X-Spam-Score: -4.4 (----)
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 9:24 AM, Guixin Liu wrote:
> 
> 
> 在 2026/10/28 15:42, Hannes Reinecke 写道:
>> On 10/28/26 7:44 AM, Guixin Liu wrote:
>>> nvmet_ctrl_tls_key_show() dereferences ctrl->sqs[0] unconditionally,
>>> but the admin queue is not installed yet while the controller is
>>> being created, and sqs[0] is set to NULL again when it is destroyed.
>>> Reading the tls_key debugfs entry in either window crashes the kernel.
>>>
>>> Only query the queue's TLS key when the admin queue is present and
>>> report 0 otherwise.
>>>
>>> Fixes: 316dabe6089fe ("nvmet: add tls_concat and tls_key debugfs entries")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>>> ---
>>>    drivers/nvme/target/debugfs.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
>>> index e85fe1d4c9f8..a27a501fe61a 100644
>>> --- a/drivers/nvme/target/debugfs.c
>>> +++ b/drivers/nvme/target/debugfs.c
>>> @@ -136,8 +136,10 @@ NVMET_DEBUGFS_ATTR(nvmet_ctrl_host_traddr);
>>>    static int nvmet_ctrl_tls_key_show(struct seq_file *m, void *p)
>>>    {
>>>        struct nvmet_ctrl *ctrl = m->private;
>>> -    key_serial_t keyid = nvmet_queue_tls_keyid(ctrl->sqs[0]);
>>> +    key_serial_t keyid = 0;
>>>    +    if (ctrl->sqs[0])
>>> +        keyid = nvmet_queue_tls_keyid(ctrl->sqs[0]);
>>>        seq_printf(m, "%08x\n", keyid);
>>>        return 0;
>>>    }
>>
>> I think it might be easier if 'nvmet_queue_tls_keyid()' would accept
>> a NULL argument.
> This is simpler, however Sashiko's review points out that after the
> NULL check, sq->tls_key clould be freed by nvmet_sq_put_tls_key(),
> or sq itself could be destroyed.
> 
> My idea is store admin queue's tls_key to nvmet_ctrl to prevent access
> sq and sq->tls_key in debugfs interface, what do you think?
> 
Argl. Don't.

I would do something like

key_serial_t keyid = ctrl->sqs ? nvmet_queue_tls_keyid(ctrl->sqs[0]):0;

to make it clear that ctrl->sqs might be NULL here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

