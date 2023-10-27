Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CD2C25B47
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Oct 2023 09:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b/VFmUUUzz/sjZ8DKDlMvnigRo/MO2Lbv4Y1sncGaJ8=; b=XtyI6IVxGIjE8gVSzfxizCohX1
	8L6QN1lHswmnSP5mCVF+JMn71jWPJB3cjF07VlxBrG736w7HDhyDT/ReZsYroOPTmOsTE1CWfxq0f
	lVItdHJEgtyhdLwFf2r7BHf8x4IfZgQV7fyS9DtSZNUo6WsPhjYV/PdZ+V+Vaca1U3k2W7UcttKy/
	zHzZtyOM5/lXzSbi3nTcph/qNKtePRMBUFeiTw0CUXzVo4RVsEt4DEE27OHGNBHo+rVjbwO2AJPuK
	x/UQVGSsN4EqpzmWkCF94NhL3/CAkimCLo/qt1PdDXJ3hPlHMykamOw8UFHKgQIOQ1S0gMTKcKBV8
	Y+iCg5Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qwIpP-00Fzhg-2B;
	Fri, 27 Oct 2023 09:08:27 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qwIpN-00Fzgj-1d
	for linux-nvme@lists.infradead.org;
	Fri, 27 Oct 2023 09:08:26 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA1B521C0C;
	Fri, 27 Oct 2023 09:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698397703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/VFmUUUzz/sjZ8DKDlMvnigRo/MO2Lbv4Y1sncGaJ8=;
	b=O+uQ1GyDJAROYTM/WZSwTmeGSxdFXCQAUBk8OlhaJnpXv1IIuItPLwZ3Adfv1TFOm4nJIc
	2+C4AvfVYA5GAUKWJkudsB5DKC2zaGO15yMNM1REoNBg4maOLgtqMG1a5JkRYWqYkdRJ+Y
	jjyLb68Q4kyRhfUrXlbBZ9/O4vU8tBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698397703;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/VFmUUUzz/sjZ8DKDlMvnigRo/MO2Lbv4Y1sncGaJ8=;
	b=jamGb23ZVdKB9RxPyetxQY1CUlNYO8q5VCC5fXCqFsnslbqHmUSyyanRS3/pLBzPXaP5VQ
	EHrkamiit43nJeCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C810A13524;
	Fri, 27 Oct 2023 09:08:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id JCB8MAd+O2WJUAAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 27 Oct 2023 09:08:23 +0000
Message-ID: <cdf931ad-626b-4efa-bc74-f4566b88e404@suse.de>
Date: Fri, 27 Oct 2023 11:08:23 +0200
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
 <78d1b4e3-4bce-4cbb-8ebe-8eb3f0fe9930@suse.de>
 <468cd6c9-c541-47ea-a2bc-f6cd09155351@app.fastmail.com>
 <20231027083003.GA17042@lst.de>
 <9bd4e078-b206-48b8-b94b-bc411317bb3d@suse.de>
 <20231027085644.GA19366@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231027085644.GA19366@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-6.93 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.84)[99.31%];
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
X-CRM114-CacheID: sfid-20231027_020825_687688_BB48BD78 
X-CRM114-Status: GOOD (  14.25  )
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

On 10/27/23 10:56, Christoph Hellwig wrote:
> On Fri, Oct 27, 2023 at 10:54:42AM +0200, Hannes Reinecke wrote:
>>> I don't really mind the link order, for these cases I usually add a
>>> comment to the Makefile so that people don't accidentally change it.
>>
>> Point is not that it has to be initialized first, point is it has to be
>> initialized only _once_.
> 
> module_init ensure it is only initialized once except for the case where
> the module is unloaded and reloaded, in which case you actually do need
> to initialize it again.
> 
So if I do this:

obj-$(CONFIG_MOD1)	+= mod1.o mod-common.o
obj-$(CONFIG_MOD2)	+= mod2.o mod-common.o

and mod-common contains a 'module_init()' and a 'module_exit()' 
function, what happens if I load mod2 after mod1?
And what happens if I unload mod2, but keep mod1?

Cheers,

Hannes



