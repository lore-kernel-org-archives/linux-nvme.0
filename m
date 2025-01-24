Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C80C0218B
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 13:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dk5hJNjVwEl4ccKfWtoGLvu4mWuqzBfnSMKKOHbjp4k=; b=WjSJFtqfMW71YjhbiAG5Su3NyU
	EM978t33KvlE6fIKMjbaL29MpOkn4n40UwgdAZ2hk5mJF2T+drbwBmsaB7RNULPgyRQBtyJCVC2lx
	YPZr3/UESCfDkNmZPUO3FPFqG54DzCu1RxndPOtMcJ0eBmC0x0xTfdPJ5cXrk9lOf6ksji59Jms7H
	pAkfz2ogpYX823Xu6eDHJGdQxj+b3DJeDmtDpCgTGQsB3qkFkse+sh0dH+IFflZXcu8yEv0tg/tlb
	eOaQ+xEkUdIMtrTBJhssIsoT4OTj7D5wqzbvUOiTTs3LwVdIrFKmLSf3tPDD8ojGWsaBORDNnkSTm
	PzJn9oOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbKB4-0000000Eoa6-2uy2;
	Fri, 24 Jan 2025 13:56:54 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbK5c-0000000Eo0E-0TS2
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 13:51:17 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A47FA21170;
	Fri, 24 Jan 2025 13:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737726674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dk5hJNjVwEl4ccKfWtoGLvu4mWuqzBfnSMKKOHbjp4k=;
	b=Fy68CnMbhQ6VPstnxVK1SqWyAXF0rTY+g3ieDdJE39qsQyAr4P+H9q/7pAVa//D3uhp5n9
	1+Uni8oCtL/7iA9vFOAxc2FeIrtObZQPccxD2PN5Bige+39cOQA7BygY8Eiaac8v/7SpkX
	4mFXdS6byPYrE24uar0lhRlSDxRYYiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737726674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dk5hJNjVwEl4ccKfWtoGLvu4mWuqzBfnSMKKOHbjp4k=;
	b=a67T4RF4yf8InABuul8sXklia/bNrZBsyTJE/xxylaFgKPd7INfsDpb7QywedmYfYdB2x3
	U+mL6+OjhNkYq/CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737726674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dk5hJNjVwEl4ccKfWtoGLvu4mWuqzBfnSMKKOHbjp4k=;
	b=Fy68CnMbhQ6VPstnxVK1SqWyAXF0rTY+g3ieDdJE39qsQyAr4P+H9q/7pAVa//D3uhp5n9
	1+Uni8oCtL/7iA9vFOAxc2FeIrtObZQPccxD2PN5Bige+39cOQA7BygY8Eiaac8v/7SpkX
	4mFXdS6byPYrE24uar0lhRlSDxRYYiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737726674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dk5hJNjVwEl4ccKfWtoGLvu4mWuqzBfnSMKKOHbjp4k=;
	b=a67T4RF4yf8InABuul8sXklia/bNrZBsyTJE/xxylaFgKPd7INfsDpb7QywedmYfYdB2x3
	U+mL6+OjhNkYq/CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8859F139CB;
	Fri, 24 Jan 2025 13:51:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hRzbINKak2feDwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 24 Jan 2025 13:51:14 +0000
Message-ID: <3a6370c2-75c6-43ef-860e-979c714abfc1@suse.de>
Date: Fri, 24 Jan 2025 14:51:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet: Implement 'admin_only' authentication
To: Sagi Grimberg <sagi@grimberg.me>, hare@kernel.org,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250124114738.115882-1-hare@kernel.org>
 <20250124114738.115882-2-hare@kernel.org>
 <6d74b77d-df2a-4622-8acb-3e5ac74be4d6@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <6d74b77d-df2a-4622-8acb-3e5ac74be4d6@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_055116_301577_8CAE1404 
X-CRM114-Status: GOOD (  10.48  )
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

On 1/24/25 14:49, Sagi Grimberg wrote:
> 
> 
> 
> On 24/01/2025 13:47, hare@kernel.org wrote:
>> From: Hannes Reinecke <hare@kernel.org>
>>
>> The spec allows for authentication to run on admin queues only, and 
>> secure
>> concatenation even requires it. So add a configfs attribute 
>> 'dhchap_admin_only'
>> to the target configuration to allow for testing independently of secure
>> concatenation.
> 
> Why do we want it conditionally? why not always?

Because we did support it originally, so I thought to play it safe.
Plus it'll cause a regression with the host implementation if applied
on its own.

But if you say so ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

