Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A118AC48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 11:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R/6rnq2fulmVaab7I+CrnbDWh6KTcAjm8jlxwOIBhYY=; b=3i1FvzdcvmvjzPUDlOrxTiJfie
	bLB6o5rSzV3Y5TLY+ZoDAdh5ugHitJ73Cfs4gufUyApULrIXAgqlwzPBJ5c9p/foEhE2V+JnihnYN
	UPvwBkibYihAAPxkw1xvRXgq2S4Vh1hf9CfyHeLVJiGmPANQxMEx3Cq9nXYp+n3t41QG+a54uIewH
	TY1EJEED9bKR6QLGWYz5RyYNvEiKXsl753LtxMbihvmlmHU1TD3baga0Iv5faaTyke296zNgWZP83
	YM1YzRHF7raFwOFmYsG1VVzndiJ4a1O3UdJ2Bu/VlSbZLQQLpFHnpkVUdq9mTAMp1mcFSyXSBbfOV
	glZKbJVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riCKd-00000004S9v-1Pqn;
	Thu, 07 Mar 2024 11:54:39 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riCKX-00000004S7I-30uH
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 11:54:37 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 976B9560C;
	Thu,  7 Mar 2024 11:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709811468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/6rnq2fulmVaab7I+CrnbDWh6KTcAjm8jlxwOIBhYY=;
	b=zYm5qCrzQ8rMckO/ebe0q2c73Io0LeqOqXcWM6NXAv76O7rYZ8ChrgiZK8XAV5rLPHnDLZ
	LLlj0r1M6TX2MzaTL8Ly4XZ+ULzXjuL4iJvqwjbeks+K3Cuqczcy4NFpLj71rV6yItsOZ1
	Yfv+4yxc8zkb4HAq2usjABlEmvpi8dI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709811468;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/6rnq2fulmVaab7I+CrnbDWh6KTcAjm8jlxwOIBhYY=;
	b=b+ytpdrN7uCdvhWHTW3iCobFS5j/i4RhAhHqnW/CqqkmXbALN43+gU/UjF5629ZOo2+jF2
	D2Q2JXMCYivdMgAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709811468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/6rnq2fulmVaab7I+CrnbDWh6KTcAjm8jlxwOIBhYY=;
	b=zYm5qCrzQ8rMckO/ebe0q2c73Io0LeqOqXcWM6NXAv76O7rYZ8ChrgiZK8XAV5rLPHnDLZ
	LLlj0r1M6TX2MzaTL8Ly4XZ+ULzXjuL4iJvqwjbeks+K3Cuqczcy4NFpLj71rV6yItsOZ1
	Yfv+4yxc8zkb4HAq2usjABlEmvpi8dI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709811468;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/6rnq2fulmVaab7I+CrnbDWh6KTcAjm8jlxwOIBhYY=;
	b=b+ytpdrN7uCdvhWHTW3iCobFS5j/i4RhAhHqnW/CqqkmXbALN43+gU/UjF5629ZOo2+jF2
	D2Q2JXMCYivdMgAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7660B12FC5;
	Thu,  7 Mar 2024 11:37:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +I/ZGwyn6WXmOQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 07 Mar 2024 11:37:48 +0000
Message-ID: <f30c79fd-2421-4065-b27e-92177535c603@suse.de>
Date: Thu, 7 Mar 2024 12:37:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] nvme-fabrics: authentication errors are not
 retryable
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, hare@kernel.org,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240127093058.15699-1-hare@kernel.org>
 <20240127093058.15699-9-hare@kernel.org>
 <8655ae60-d0b7-4516-9006-b9a017760135@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <8655ae60-d0b7-4516-9006-b9a017760135@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zYm5qCrz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=b+ytpdrN
X-Spamd-Result: default: False [-5.11 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.81)[99.18%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: 976B9560C
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_035433_961848_17161AE8 
X-CRM114-Status: GOOD (  10.07  )
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

On 3/7/24 11:52, Sagi Grimberg wrote:
> 
> 
> On 27/01/2024 11:30, hare@kernel.org wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> Whenever authentication failed the error is non-retryable as the
>> authentication solely depends on the passed parameters, which do
>> not change during retry.
> 
> Does this directly relate to secure concatenation? because if it isn't 
> we should drop it from here.

No, it does not. Meanwhile it went to the other patch series for 
authentication errors, and will be dropped from the next iteration.

Cheers,

Hannes


