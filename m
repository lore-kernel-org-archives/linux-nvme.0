Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14ECC25B75
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jun 2024 09:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eSDgE8l46R7RpNxPmAdHDdwYh7tkrvI5HLTyxSYp75U=; b=oPZjz7XloAO0eU78J94fmqku1Z
	LASq6Nflj2YyiM/kew4kUtRkbOa2WZ5hC4wX5j8TZkEVRVoR7SJzFvQ3+O+qd1Z9XjmiFCoVPM29w
	b6REE6zWrswCRx8li3ZVkSWT3KJGHiIwtrpHX2Uo2ZeLCbDeZtC8CxQaPpCacYIkWJXlUMM8Eqyq0
	W30oVfCLClmDHWTCDW/7pY/E5qe1M0r6o01Ydhu7oo71VsIq9Jii3OTj0fBCOioZ+lQXdOsn9DimG
	SZoQbZhRIAI1+CHx+MyRiVN4D36Pdry3Gr45exCUQWZljpLNKLO4x8Ef53pZ5lsWV38esLYxiABUT
	/tfJuKPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE3fh-0000000G8ow-1AVx;
	Mon, 03 Jun 2024 09:08:05 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE3fc-0000000G8oB-2Nf8
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jun 2024 09:08:02 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 06AF420010;
	Mon,  3 Jun 2024 09:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717405678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSDgE8l46R7RpNxPmAdHDdwYh7tkrvI5HLTyxSYp75U=;
	b=EFaWHWyDM1b5NdDa9MadJ0vfSn36GBj93Cdo8NnNX8E9eQTf6WtvWeEp41mvs3XVDOSUGi
	4UBndJfX+eQjWfvhwcbhHy1tL7t6i50sMXcm1aFG0COO/5WuSOuDiUVkGhIWAKlh927lod
	refa9WP2WjR2scL28HAYg6wgC70Aigw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717405678;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSDgE8l46R7RpNxPmAdHDdwYh7tkrvI5HLTyxSYp75U=;
	b=Xcyh93ycKFGruh6MNLpCiNc/sPEjWrMG706NVPeNbLQVVxyTyY5LY7MiNck61gKko8W4bu
	SNHTdMnprM4QlMAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717405678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSDgE8l46R7RpNxPmAdHDdwYh7tkrvI5HLTyxSYp75U=;
	b=EFaWHWyDM1b5NdDa9MadJ0vfSn36GBj93Cdo8NnNX8E9eQTf6WtvWeEp41mvs3XVDOSUGi
	4UBndJfX+eQjWfvhwcbhHy1tL7t6i50sMXcm1aFG0COO/5WuSOuDiUVkGhIWAKlh927lod
	refa9WP2WjR2scL28HAYg6wgC70Aigw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717405678;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSDgE8l46R7RpNxPmAdHDdwYh7tkrvI5HLTyxSYp75U=;
	b=Xcyh93ycKFGruh6MNLpCiNc/sPEjWrMG706NVPeNbLQVVxyTyY5LY7MiNck61gKko8W4bu
	SNHTdMnprM4QlMAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76FE213A93;
	Mon,  3 Jun 2024 09:07:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IgRyHO2HXWY4egAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 03 Jun 2024 09:07:57 +0000
Message-ID: <05d5fd1a-9295-4753-a201-c9a968ee7982@suse.de>
Date: Mon, 3 Jun 2024 11:07:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] bugfix: Introduce sendpages_ok() to check
 sendpage_ok() on contiguous pages
To: Jakub Kicinski <kuba@kernel.org>, Ofir Gal <ofir.gal@volumez.com>
Cc: davem@davemloft.net, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 ceph-devel@vger.kernel.org, dhowells@redhat.com, edumazet@google.com,
 pabeni@redhat.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
 christoph.boehmwalder@linbit.com, idryomov@gmail.com, xiubli@redhat.com
References: <20240530142417.146696-1-ofir.gal@volumez.com>
 <20240601153430.19416989@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240601153430.19416989@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.96 / 50.00];
	BAYES_HAM(-2.67)[98.56%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,lists.infradead.org,redhat.com,google.com,kernel.org,kernel.dk,lst.de,grimberg.me,linbit.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_020800_793680_FA2D2AA0 
X-CRM114-Status: UNSURE (   8.32  )
X-CRM114-Notice: Please train this message.
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

On 6/2/24 00:34, Jakub Kicinski wrote:
> On Thu, 30 May 2024 17:24:10 +0300 Ofir Gal wrote:
>> skbuff: before sendpage_ok - i: 0. page: 0x654eccd7 (pfn: 120755)
>> skbuff: before sendpage_ok - i: 1. page: 0x1666a4da (pfn: 120756)
>> skbuff: before sendpage_ok - i: 2. page: 0x54f9f140 (pfn: 120757)
> 
> noob question, how do you get 3 contiguous pages, the third of which
> is slab? is_slab doesn't mean what I think it does, or we got extremely
> lucky with kmalloc?
> 
I guess it's not slab which triggered; the actual code is:

static inline bool sendpage_ok(struct page *page)
{
         return !PageSlab(page) && page_count(page) >= 1;
}

My bet is on 'page_count()' triggering.

Cheers,

Hannes


