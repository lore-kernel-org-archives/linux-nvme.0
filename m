Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F15606A31F
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 07:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gR2ZRQo1;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RjgAH1HD;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=v6oD0L1W;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RjgAH1HD;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=v6oD0L1W
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=AuAv2eYPoMaDiX95eQHdX4lkmF9eQuCjw5mck6WOBR4=; b=gR2ZRQo1r7xA1i
	wEgzA57RTGOMFFeaafd4JIrjCUUt0DVuR4YE4BLyvhE1+IHEQIkU+/23nKWPBUAhA44onM0BFbTWJ
	6LxIcGEorZ5S+GdJXh0lvHfT5D79V26Un1coRCex+gBmBvHh9ycGIGNdMbbxo5+1q15zbPDAQ5rFg
	HQlsGD4a/bty7lbM3rnMjWAmCWABIzf4r/1qrqV9fsph2BdwdTSK35MpxoQQhOP4D/x7PFR+XebTV
	c3DSNMNvkw+w2EB8IRpQgMG5nfGYv1Eg8k23EXewWFE6hOqr4MxuqaxDie7SYyzPv2DKAYQ0EXJI9
	HIozZ2nnyk2GaPq0xLQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLyNs-00000006UJE-2ops;
	Wed, 28 Oct 2026 07:47:44 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLyNp-00000006UIb-34PO
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 07:47:42 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0523C22117;
	Wed, 28 Oct 2026 07:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793173660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AuAv2eYPoMaDiX95eQHdX4lkmF9eQuCjw5mck6WOBR4=;
	b=RjgAH1HDC/B870RWG0V2P7cQe4kWercx/7wdbVAvXc3ksy5Eikwea8Jroh6KS21YGR5nMX
	ol8+xNxJ53882viH/Cep2etKR54YuUMQjl35QsiqxdT+W/7pa/MXhNTl1NdWpSNAoEDAzJ
	PjWcdWPhorTsFXh9OvnarYZ5VIp2uV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793173660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AuAv2eYPoMaDiX95eQHdX4lkmF9eQuCjw5mck6WOBR4=;
	b=v6oD0L1WZjDPXrrNYwvqHafspqBdpHEIcN2GE7aOEDvFdZ/QuBb+2c362FF8DJthHoa4sy
	CiFXrm/qsmWEzlBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793173660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AuAv2eYPoMaDiX95eQHdX4lkmF9eQuCjw5mck6WOBR4=;
	b=RjgAH1HDC/B870RWG0V2P7cQe4kWercx/7wdbVAvXc3ksy5Eikwea8Jroh6KS21YGR5nMX
	ol8+xNxJ53882viH/Cep2etKR54YuUMQjl35QsiqxdT+W/7pa/MXhNTl1NdWpSNAoEDAzJ
	PjWcdWPhorTsFXh9OvnarYZ5VIp2uV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793173660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AuAv2eYPoMaDiX95eQHdX4lkmF9eQuCjw5mck6WOBR4=;
	b=v6oD0L1WZjDPXrrNYwvqHafspqBdpHEIcN2GE7aOEDvFdZ/QuBb+2c362FF8DJthHoa4sy
	CiFXrm/qsmWEzlBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 622511321C;
	Wed, 28 Oct 2026 07:47:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8GAICJuo4WoRVAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 28 Oct 2026 07:47:39 +0000
Message-ID: <f424d050-fa3f-4ad6-b7ca-92acff3b21dd@suse.de>
Date: Wed, 28 Oct 2026 08:47:38 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] nvme-tcp: validate the TLS handshake timeout
To: Yingjie Wang <1075151112@qq.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1793103202.git.1075151112@qq.com>
 <tencent_02EC3FD2E750D09B95ACA70091EE65DE0906@qq.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <tencent_02EC3FD2E750D09B95ACA70091EE65DE0906@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_TO(0.00)[qq.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[qq.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,qq.com:email]
X-Spam-Score: -13.29
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_004741_920063_6B91E8B4 
X-CRM114-Status: GOOD (  14.76  )
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

On 10/27/26 1:13 PM, Yingjie Wang wrote:
> tls_handshake_timeout is writable but stored as a signed int. Multiplying
> the value by MSEC_PER_SEC and HZ therefore uses signed arithmetic.
> 
> With HZ=1000, setting it to 2147484 overflows both multiplications. If
> the handshake request is accepted and its completion remains pending,
> schedule_timeout() reports a wrong timeout value with a stack dump and
> returns zero. The handshake then fails immediately with -ETIMEDOUT,
> while the handshake agent was given about 24.9 days. Negative values
> such as -1 have the same kernel-side effect.
> 
> Store the parameter as an unsigned int and reject values that cannot be
> represented both by tls_handshake_args::ta_timeout_ms and by a safe
> jiffies delay. Take one snapshot so a concurrent parameter update cannot
> give the handshake agent and completion wait different timeouts.
> Document the accepted range for built-in use.
> 
> wait_for_completion_interruptible_timeout() returns the remaining
> jiffies as a long after a successful completion. Keep that result in a
> long because an accepted timeout can exceed INT_MAX jiffies on 64-bit
> systems.
> 
> Negative and oversized values now fail with -EINVAL. Keep zero valid,
> preserving the existing immediate-timeout behavior.
> 
> Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yingjie Wang <1075151112@qq.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  5 +++
>   drivers/nvme/host/tcp.c                       | 34 ++++++++++++++-----
>   2 files changed, 31 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

