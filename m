Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB26C2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 15:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LNCRGhroRCeExzgeHLpAuVeJHtlpAf/pHFSpcXopM9U=; b=wDueH8rbgc7lactM7YbZG5Jhoj
	8p24+IgMQUghi7hi0/DvDkT6Dtkpbr+Ztwwmd7P0k0YF8fgRFyKQ1p8Z+RdzmcWuHtl67YztiHtwQ
	AB1e3COh8qYXSdL1ySObLZ+tT8yeGypvAz6FnWE10NRSQhT6ISPki3A2d1Z6Vu2MxjzdP73EFr1fB
	IxtSiXeHJSYpacpQA0YK5bpF6oWWR6mzuqq8DUU8zslDld4KYgDL7WYZm3BRSb9A1MD36ir8O3QK5
	JXedGc0QPyqeCZDcu9FLlSaFMgG9D2lH941ESrJy+TYWfFLKsxSv+p8adhZcBkQnbAcR15TZy0n6Q
	R9E2G1Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1Ub-0000000Ab2R-2DDg;
	Wed, 03 Jul 2024 15:01:57 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1UV-0000000Aaym-3yol
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 15:01:55 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 692D32128B;
	Wed,  3 Jul 2024 15:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720018910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LNCRGhroRCeExzgeHLpAuVeJHtlpAf/pHFSpcXopM9U=;
	b=dhbMg3oAcH2LTCUydLEESHaWFIR2d9zW/2Ueq96ODjlces7I8AjgT9+0/WmXCHIrAHcgPn
	GvRdXKvLKul3NYH5MkVZdc2EtCkdET0055TTBEwwfNY3eJjeA9iucNgJVdImPq9L2xEQdS
	ASnebkvE3PvnwfFFA6+lnfXzBh9x5Ec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720018910;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LNCRGhroRCeExzgeHLpAuVeJHtlpAf/pHFSpcXopM9U=;
	b=R1xwiKcchAdg5VRs/cBiS1S6bJQ8yL3pIsI/rl+t/8y3iZgHUJf4abxoPLlPQ4Tf4DiYEN
	+k5sfkXTKQX20HDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dhbMg3oA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=R1xwiKcc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720018910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LNCRGhroRCeExzgeHLpAuVeJHtlpAf/pHFSpcXopM9U=;
	b=dhbMg3oAcH2LTCUydLEESHaWFIR2d9zW/2Ueq96ODjlces7I8AjgT9+0/WmXCHIrAHcgPn
	GvRdXKvLKul3NYH5MkVZdc2EtCkdET0055TTBEwwfNY3eJjeA9iucNgJVdImPq9L2xEQdS
	ASnebkvE3PvnwfFFA6+lnfXzBh9x5Ec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720018910;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LNCRGhroRCeExzgeHLpAuVeJHtlpAf/pHFSpcXopM9U=;
	b=R1xwiKcchAdg5VRs/cBiS1S6bJQ8yL3pIsI/rl+t/8y3iZgHUJf4abxoPLlPQ4Tf4DiYEN
	+k5sfkXTKQX20HDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2716713889;
	Wed,  3 Jul 2024 15:01:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZsRuBt5nhWbxSAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 03 Jul 2024 15:01:50 +0000
Message-ID: <792eeb90-90ba-4750-ab22-622023967eeb@suse.de>
Date: Wed, 3 Jul 2024 17:01:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] nvme-tcp: switch to 'cpu' affinity scope for unbound
 workqueues
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240703135021.34143-1-hare@kernel.org>
 <20240703135021.34143-5-hare@kernel.org>
 <1259766c-234e-4958-a16f-9de753a4a0b5@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <1259766c-234e-4958-a16f-9de753a4a0b5@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 692D32128B
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_080152_162408_97C0409B 
X-CRM114-Status: GOOD (  15.58  )
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

On 7/3/24 16:22, Sagi Grimberg wrote:
> 
> 
> On 03/07/2024 16:50, Hannes Reinecke wrote:
>> We should switch to the 'cpu' affinity scope when using the 'wq_unbound'
>> parameter as this allows us to keep I/O locality and improve performance.
> 
> Can you please describe more why this is better? locality between what?
> 
Well; the default unbound scope is 'cache', which groups the cpu 
according to the cache hierarchy. I want the cpu locality of the 
workqueue items to be preserved as much as possible, so I switched
to 'cpu' here.

I'll get some performance numbers.

> While you mention in your cover letter "comments and reviews are welcome"
> The change logs in your patches are not designed to assist your reviewer.

I spent the last few weeks trying to come up with a solution based on my
original submission, but in the end I gave up as I hadn't been able to
fix the original issue.
This here is a different approach by massaging the 'wq_unbound' 
mechanism, which is not only easier but also has the big advantage that
it actually works :-)
So I did not include a changlog to the previous patchset as this is a 
pretty different approach.
Sorry if this is confusing.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


