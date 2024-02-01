Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C516C47DDF
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Feb 2024 12:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pNulsnfLW8vN7uY9MUHrP0RR2dzcocOH9POfk8gEbtA=; b=FS3Wo1G4K0T6ys4mT5s9m6jxqL
	QAM0i5fbxp/v/KYscotcfX5CC0/YgNPxF9wNSJv3vS2oasq1+QOpqcdBihwdUPJ8584QgEArbus9t
	ESY3xISYKMBUGttD5+cFTD3AVofLe0fY8eOuKelI06xYBrsqBSkwsOZTRVZ0H5lFBANpeWlr2CQ+b
	N8/vMIfqpew2FAKVJ0zWtDARUZIzEis+Hjb6rOcDE1g6ylu7e9rzs6BjmdSYDEEU47fDvMqxf8iiS
	MKR+MtKARQkohx5G9vIL68FOzd8uzIf+UHyurRE5ZaN9YHH0NeaUhDIq2KjZfA0B6O5I2NGazjGsE
	ADd+LtmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVWOb-00000007nsv-4C31;
	Thu, 01 Feb 2024 12:42:22 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVWOX-00000007now-2XWo
	for linux-nvme@lists.infradead.org;
	Thu, 01 Feb 2024 12:42:20 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3BE181F385;
	Thu,  1 Feb 2024 12:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706791333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNulsnfLW8vN7uY9MUHrP0RR2dzcocOH9POfk8gEbtA=;
	b=nUlZng0jXMmIHXrcx4p7ty+mDhAdLSSbOSeURx3mAQy4qWNNPhEIhpZlbY5JXDkuKJDAYG
	fu8arzbKUc37d1zq1tj7m99n+IFEzh4fwj4P5BBzkoSx2rmtH6OrbZKrDG6AP0LdUQcWJY
	jZy0ZpGVC6fYSien9mpDBTr+kFFY9As=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706791333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNulsnfLW8vN7uY9MUHrP0RR2dzcocOH9POfk8gEbtA=;
	b=USQoimqpN5kQ9u8B+gkm8NzQZvFeNY6QPWhrIULGaMAhKcijINPHBHme9EXY8Aifl/NbK6
	ov06BMMIt7P3UJAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706791333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNulsnfLW8vN7uY9MUHrP0RR2dzcocOH9POfk8gEbtA=;
	b=nUlZng0jXMmIHXrcx4p7ty+mDhAdLSSbOSeURx3mAQy4qWNNPhEIhpZlbY5JXDkuKJDAYG
	fu8arzbKUc37d1zq1tj7m99n+IFEzh4fwj4P5BBzkoSx2rmtH6OrbZKrDG6AP0LdUQcWJY
	jZy0ZpGVC6fYSien9mpDBTr+kFFY9As=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706791333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNulsnfLW8vN7uY9MUHrP0RR2dzcocOH9POfk8gEbtA=;
	b=USQoimqpN5kQ9u8B+gkm8NzQZvFeNY6QPWhrIULGaMAhKcijINPHBHme9EXY8Aifl/NbK6
	ov06BMMIt7P3UJAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89E7B139B1;
	Thu,  1 Feb 2024 12:42:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YP5zD6ORu2XNOAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 01 Feb 2024 12:42:11 +0000
Message-ID: <6950991f-0c1b-40e0-a11d-258276ac56ad@suse.de>
Date: Thu, 1 Feb 2024 13:42:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/12] nvmet-fcloop: swap the list_add_tail arguments
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240131085112.21668-1-dwagner@suse.de>
 <20240131085112.21668-3-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240131085112.21668-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nUlZng0j;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=USQoimqp
X-Spamd-Result: default: False [-3.26 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.96)[99.82%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3BE181F385
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240201_044217_820938_C6A93CA0 
X-CRM114-Status: GOOD (  13.27  )
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

On 1/31/24 09:51, Daniel Wagner wrote:
> The first argument of list_add_tail function is the new element which
> should be added to the list which is the second argument. Swap the
> arguments to allow processing more than one element at a time.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/fcloop.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


