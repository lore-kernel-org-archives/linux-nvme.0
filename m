Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675EBC54ED0
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 10:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L36lwljlqMD0aYeNn5rHtteD0CmLa5fppTcwExjJASI=; b=ciGqJZ3TlC0wHAWFhJcsRwndlJ
	b7sqZY+RzcNBPYNvfwMmqG1CZ1nVo5x0z9VoQGl9euiim6JrCug+nLjXbZBOhXyZh1tv7U/Smd3PL
	h2udHb6nlLsUqEaiy4V6oZzbQXMqSRbAurPuhZqLeCVSLhtCUQfGfqivjw5HKZTX2xyBrcUp6ogms
	N356YwgANsAoMZ43NbxFbvGi3lVjSAMmGNB1kRpdrxJPynRcm2c5RIXIJNt102pm7UrQT5DZQjEm/
	4/EkVCyVrHw4G00bjSJuppaFltNxuCc2KDOUm7Y/0OCOr3vLuyk4TLSkz89FVCg7GVoYFQXtFS3c8
	TaLgnS7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHgi9-0000000FTQH-29tq;
	Wed, 21 May 2025 10:30:09 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHgTJ-0000000FQEX-1ppn
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 10:14:50 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E15102091C;
	Wed, 21 May 2025 10:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L36lwljlqMD0aYeNn5rHtteD0CmLa5fppTcwExjJASI=;
	b=QLRiqsff1PXVC4ebs47iVDAj9bjOQIt1c0CnHRTEMseXBG+fkje2ZRSMjdqD+YSs5jOsCl
	o4jQrtV7w8jgoqwXj40WdbJ44PHdjOWpQcW1sKLDBqkTTL0nubcMWysCziZcQGpZED8fcK
	FTcNoCJUocsQIO58pNf84ixZcjfcRd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L36lwljlqMD0aYeNn5rHtteD0CmLa5fppTcwExjJASI=;
	b=7Tcs6OFNkrhdUZr5DXGs+h4wuBJXJS/duVQn3F403sruvpVYIiH3maFj8l7hdvg1LHXH9e
	azFddiKUWVlLDLDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L36lwljlqMD0aYeNn5rHtteD0CmLa5fppTcwExjJASI=;
	b=UcOSS4V/CIYcsAFikTmh8Lnd+u2+Rz4F5QpXvq2Q/uUzZ2MAXdoUhzLrTkf1i0JlacDit7
	4pe8TJf6gRdKS2K5WtGX3NkA7DGbR2t8hPH7/56y3SSsAIt0ZTZ0iZEUv6kqNc79FbVhFA
	9UPOvmBE7ojbVx8BF3/AWxVhyErPcCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822487;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L36lwljlqMD0aYeNn5rHtteD0CmLa5fppTcwExjJASI=;
	b=Wvag8WbDuD/UYUAsBDOpPwvRjKhLe1BQsFtT5zquE0FcLHyrLIQGXR5CxcNfPOInIyeGkG
	cb+Th4UTTIjwvVCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8BCD13AA0;
	Wed, 21 May 2025 10:14:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kKxWLJenLWiqTAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 May 2025 10:14:47 +0000
Message-ID: <c46209ce-3e28-4a18-83c2-3ff6d442cf8d@suse.de>
Date: Wed, 21 May 2025 12:14:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] net: fold __skb_checksum() into skb_checksum()
To: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
References: <20250519175012.36581-1-ebiggers@kernel.org>
 <20250519175012.36581-7-ebiggers@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250519175012.36581-7-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.20 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,iogearbox.net,gmail.com,grimberg.me,kernel.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_031449_619777_A719B247 
X-CRM114-Status: GOOD (  11.37  )
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

On 5/19/25 19:50, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Now that the only remaining caller of __skb_checksum() is
> skb_checksum(), fold __skb_checksum() into skb_checksum().  This makes
> struct skb_checksum_ops unnecessary, so remove that too and simply do
> the "regular" net checksum.  It also makes the wrapper functions
> csum_partial_ext() and csum_block_add_ext() unnecessary, so remove those
> too and just use the underlying functions.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   include/linux/skbuff.h |  9 -------
>   include/net/checksum.h | 12 ---------
>   net/core/skbuff.c      | 59 +++++-------------------------------------
>   3 files changed, 7 insertions(+), 73 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

