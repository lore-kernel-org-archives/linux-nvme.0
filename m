Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D543C54798
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 12:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OXNRJi8qFTGfuD/BIR5zTeWfX9rMtAggVEOB5AYJAJA=; b=kJFWBT+N6nx50W21wUtdhbZwlL
	veOkGiQJSULLmodMOU7s8E3OvAfVNsTBwrGsKGYmN0+zFAZwo2m/JjNN+P2nbfOf6D8BBK8A1BBz3
	mnV5xKJur1z9UUj9lsPcS78o69Mi1nGaen04jIx9yCfX/KnUr6vnxjvt6nsLjBGKD47cLLQaaj6iJ
	AmKu3U3WT5AHtAwyWIW/e4QCi+lad6W+OH8UG7FoeFnFBQFCaJjnW87VgmyFWdCdWRBenZ6pB/11q
	QOyhYzk2NdL27SormDx5hIdL1yjvVtUCcUWNXn3IuitaJrki4bXAr1RBXBwuiSoPliSE2fJ89rgdI
	HxBcBjyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riCZh-00000004VLX-3jxG;
	Thu, 07 Mar 2024 12:10:13 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riCZc-00000004VJc-3qfc
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 12:10:11 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 89D1E403B2;
	Thu,  7 Mar 2024 11:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709811407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OXNRJi8qFTGfuD/BIR5zTeWfX9rMtAggVEOB5AYJAJA=;
	b=OUhGnA/74PfOBoF0GVwHvi6nIDTsvHu3vNX3Zxb6f1KFoK41xsWhNrsGFJfPaN3OExLiEu
	O7ey1xOH67lXOuaC+K40qbageHLchuOB5wvB2XwSchafm0tfuU2L5LPGPMlb2rRW+MR3Gq
	uX7mneKXCuPFbNW9Wku+dSJuGFw0s5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709811407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OXNRJi8qFTGfuD/BIR5zTeWfX9rMtAggVEOB5AYJAJA=;
	b=1ny8ZFR0OPLEx8mTkD1o91XAm8jEoVMPw9ElrIAQ0yP01gzvCyzJpH2pkktr4I3IRRUkAA
	tDfNaSTSXlFVkUAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709811407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OXNRJi8qFTGfuD/BIR5zTeWfX9rMtAggVEOB5AYJAJA=;
	b=OUhGnA/74PfOBoF0GVwHvi6nIDTsvHu3vNX3Zxb6f1KFoK41xsWhNrsGFJfPaN3OExLiEu
	O7ey1xOH67lXOuaC+K40qbageHLchuOB5wvB2XwSchafm0tfuU2L5LPGPMlb2rRW+MR3Gq
	uX7mneKXCuPFbNW9Wku+dSJuGFw0s5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709811407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OXNRJi8qFTGfuD/BIR5zTeWfX9rMtAggVEOB5AYJAJA=;
	b=1ny8ZFR0OPLEx8mTkD1o91XAm8jEoVMPw9ElrIAQ0yP01gzvCyzJpH2pkktr4I3IRRUkAA
	tDfNaSTSXlFVkUAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6ADA412FC5;
	Thu,  7 Mar 2024 11:36:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YIXjGM+m6WXmOQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 07 Mar 2024 11:36:47 +0000
Message-ID: <485c206e-7034-43f3-83a7-965c09a53c18@suse.de>
Date: Thu, 7 Mar 2024 12:36:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] nvme-tcp: check for invalidated or revoked key
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, hare@kernel.org,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240127093058.15699-1-hare@kernel.org>
 <20240127093058.15699-8-hare@kernel.org>
 <ada5f304-e617-42d2-9cc5-0a2904bccf53@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ada5f304-e617-42d2-9cc5-0a2904bccf53@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="OUhGnA/7";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1ny8ZFR0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.46 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.96)[99.85%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 89D1E403B2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_041009_165340_903720CF 
X-CRM114-Status: GOOD (  10.90  )
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

On 3/7/24 11:51, Sagi Grimberg wrote:
> 
> 
> On 27/01/2024 11:30, hare@kernel.org wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> key_lookup() will always return a key, even if that key is revoked
>> or invalidated. So check for invalid keys before continuing.
> 
> Is this a bug fix? it should go probably either as a standalone patch
> or as the first in this set (if it is only relevant with this patchset).

Possibly. But I've created them via code review, so I'm not sure how 
relevant it really is.

Cheers,

Hannes


