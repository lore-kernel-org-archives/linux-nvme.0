Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE8CC04FF8
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Apr 2024 06:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l0hq0CSyxD2fxFOY8ZZadNSqFnxiTHJGDZtXgx89H+4=; b=ul/Jyx8FhXmPG/Z9Q6k5/8/IIt
	j0Uk9OXUMw3aE0+mKQUBJHNzPiPcdTAH0epd6M8TJCye/RZEC/2PzmQNoL+jbI2pl8MCsAXt/Bldk
	pz5VNe+uqTiL4MyyhVPAHp810yZLHPCe/gLTZ7/PiOqlbEdobokZoy+v8uwEsjpTJ3eT+Ru+ZMvA7
	Sm9ySXEGVbACLo0ChqarXgHdr0hkjChwpO2SJ9hk4xXI+3qSK9CUGdHeDqe7xQhx68IK4IfxdbfaA
	GDoR5OKuSsBXqwIhr6/s/zBedLBYkzWj8m0F1JUr1VdxgAjZqN++/bm2J3EPlVHyGQm6P+Mui4CPn
	Gmilw8dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxLDZ-000000016xk-3BMe;
	Thu, 18 Apr 2024 06:25:57 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxLDS-000000016vX-3kdJ
	for linux-nvme@lists.infradead.org;
	Thu, 18 Apr 2024 06:25:54 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4D69134A23;
	Thu, 18 Apr 2024 06:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713421547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0hq0CSyxD2fxFOY8ZZadNSqFnxiTHJGDZtXgx89H+4=;
	b=uqpgmcJI3IOWT0wDQBF84g4RxF7RUaS1S10VT4JfTzGhyFjiK3RKuJdsODkHt8k3m83z2h
	zJISVukP/qsCOn3Vl2Cn7q4KsZo49XGxMGr49fJ2E6YK9nRdP7F9A2VyQo3L41zZdWl6r0
	kp8wezMmTryVXB4nmpOMHnMnPr/GGNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713421547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0hq0CSyxD2fxFOY8ZZadNSqFnxiTHJGDZtXgx89H+4=;
	b=prCQyFhtO8qrstMq3xUnWSxFp4y5CmZCL0bPYeGmk1+a+GpU21u8VRTgizC2hAKNM7Zz/X
	UIb5cHiaIj4q5IDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uqpgmcJI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=prCQyFht
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713421547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0hq0CSyxD2fxFOY8ZZadNSqFnxiTHJGDZtXgx89H+4=;
	b=uqpgmcJI3IOWT0wDQBF84g4RxF7RUaS1S10VT4JfTzGhyFjiK3RKuJdsODkHt8k3m83z2h
	zJISVukP/qsCOn3Vl2Cn7q4KsZo49XGxMGr49fJ2E6YK9nRdP7F9A2VyQo3L41zZdWl6r0
	kp8wezMmTryVXB4nmpOMHnMnPr/GGNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713421547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0hq0CSyxD2fxFOY8ZZadNSqFnxiTHJGDZtXgx89H+4=;
	b=prCQyFhtO8qrstMq3xUnWSxFp4y5CmZCL0bPYeGmk1+a+GpU21u8VRTgizC2hAKNM7Zz/X
	UIb5cHiaIj4q5IDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E081C13687;
	Thu, 18 Apr 2024 06:25:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IyrHNOq8IGY6cgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 18 Apr 2024 06:25:46 +0000
Message-ID: <09b3d5e9-0ead-44b0-8517-2a1954026784@suse.de>
Date: Thu, 18 Apr 2024 08:25:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme-cli spdk plugin
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Daniel Wagner <dwagner@suse.de>
Cc: Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Tomasz Zawadzki <tomasz.zawadzki@intel.com>, Sagi Grimberg
 <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <xulnfwru3jfl2nooq27yym7nx3cdpxqslzqz5nvwnkymncapnt@pzascju2tmvf>
 <20240417142610.GA31809@lst.de>
 <7a926cbb-51f9-4e03-b737-b4434b1270dd@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <7a926cbb-51f9-4e03-b737-b4434b1270dd@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4D69134A23
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240417_232551_109360_D9F414C2 
X-CRM114-Status: GOOD (  16.04  )
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

On 4/17/24 16:31, Jens Axboe wrote:
> On 4/17/24 8:26 AM, Christoph Hellwig wrote:
>> On Wed, Apr 17, 2024 at 10:33:17AM +0200, Daniel Wagner wrote:
>>> There is a PR [1] pending, adding a spdk plugin for nvme-cli. The
>>> problem this new plugin tries to solve is, that with the recent change
>>> to use sysfs only for discovering the nvme subystem, nvme-cli
>>> lost support for spdk.
>>>
>>> My question is, should we have a special plugin for 'list' and
>>> 'list-subsystem' or should we try to get this somehow integrated into
>>> the existing code? So that 'list' just works?
>>
>> І don't think nvme-cli should deal with anything that is not driven
>> by the kernel nvme driver.
> 
> Exactly, why on earth would we care about spdk at all in the first
> place, nvme-cli or not.
> 

And that depends on the direction of development we want to take.
Do we want nvme-cli to become a 'general' nvme management tool, then
we should investigate in having an spdk plugin.
Or do we want to have nvme-cli as the cli for the linux nvme kernel 
driver, then clearly we wouldn't need an spdk plugin.
That, I guess, is the real discussion.

Personally I would vote for the first option. But I'm sure others have
other opinions.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


