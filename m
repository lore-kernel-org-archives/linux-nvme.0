Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA033C25B47
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Oct 2023 06:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zn+QonWz6n7LWeoDiIgh//gq13z7iGNf6P5SiZEKFNQ=; b=QmopWRsK4BeYEZimubhdZi6tI4
	O3AGJ9xyY2C0oJYkXzoV3apnyeZLUTd9/bewKKVS35Pb6bk7PjuVpsCuiapQJaAKPRp6Vji8NLcLC
	4ypsesVvWsOaxQjXPk77heG1M0NdkVPmsrynM3mkZBPp0HsTt25aZTVjjD5DklloBH8VVAoqN0HWc
	e0YFkn/k3qlFbcOX43F5uY1LZce+tu2uwD2V5XUcI7XK/LN4DX8p3ZBVT2G7fyvhsQu+4xGlHEGPs
	tyVw8J8hwGA3SJmFyVKUwo1dUc+czksvYX70CZxXCe+tb63iyBGEiLCvqOBg7umekHfOvgAjCY9wo
	bVX6JQPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qwFuK-00FdpH-0U;
	Fri, 27 Oct 2023 06:01:20 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qwFuG-00Fdn2-2i
	for linux-nvme@lists.infradead.org;
	Fri, 27 Oct 2023 06:01:18 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B905621AFC;
	Fri, 27 Oct 2023 06:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698386470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zn+QonWz6n7LWeoDiIgh//gq13z7iGNf6P5SiZEKFNQ=;
	b=q9rK3xW8MIJ9NWgcIUOC3uWk+V7Id65V+K1t2eRHAwfrQRD6gKu2W7jwBERcLdSZOavOxz
	lq+g0g4nfOix/59+mpsivt9sc41w6NVcEYLEzRGQFq6nO/l8I5aj2SmY0ibgIbkHKDZPpE
	I3wjW13W0bH8suULC7kt31SpmRJG9Hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698386470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zn+QonWz6n7LWeoDiIgh//gq13z7iGNf6P5SiZEKFNQ=;
	b=T0lOpLTH2yo+S6AoUko6XoSsAbsgvaFLytf/1qjIV7szFzwTQm6ZKEjofBSlEP0HVEOLKL
	PXOYNbvldqgtzJBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7534B1358C;
	Fri, 27 Oct 2023 06:01:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Q4QsGiZSO2VKaQAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 27 Oct 2023 06:01:10 +0000
Message-ID: <78d1b4e3-4bce-4cbb-8ebe-8eb3f0fe9930@suse.de>
Date: Fri, 27 Oct 2023 08:01:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: keyring: fix conditional compilation
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20231026130804.142586-1-hare@suse.de>
 <20231026130804.142586-3-hare@suse.de>
 <b138c4c5-9b49-4338-a79a-2f77a13381e8@app.fastmail.com>
 <d497429d-a1a2-4bf4-a958-3865294d9f2e@suse.de> <20231027052118.GB7885@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231027052118.GB7885@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-7.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231026_230117_030902_6C1EB3B4 
X-CRM114-Status: GOOD (  17.06  )
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

On 10/27/23 07:21, Christoph Hellwig wrote:
> On Thu, Oct 26, 2023 at 04:20:12PM +0200, Hannes Reinecke wrote:
>> Host Target Keyring
>> n    n      n
>> n    m      m
>> n    y      y
>> m    n      m
>> m    m      m
>> m    y      y
>> y    n      y
>> y    m      y
>> y    y      y
>>
>> So we're correct in 75% of all cases :-)
>> And before we trying to figure out some weird complex kconfig syntax
>> to get all cases correct I prefer the easy solution.
>> Plus it has the benefit that the keyring is avialable right from the
>> start, so you can pre-provision keys even before nvme is loaded.
> 
> in the 75% of cases that don't really matter, as 99% of all setups
> have nvme and nvmet built modular, and for that you now build code
> into the kernel for no good reason at all.
> 
> FYI, what's I've done a lot in the past for such simple helper is
> to not have a Kconfig symbol at all, but let the Makefile handle
> it.
> 
> A
> 
> obj-$(CONFIG_MOD1)	+= mod1.o mod-common.o
> obj-$(CONFIG_MOD2)	+= mod2.o mod-common.o
> 
> will actually do the right thing here without much complicated
> boilerplate.
> 
In principle. Unfortunately I have to initialize the keyring, and that
can be done only once.
I see if I can come up with a different solution.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


