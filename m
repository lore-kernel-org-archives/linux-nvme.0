Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979C2E8B383
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Feb 2026 00:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7cHI3uSb2KV86cPnzYM+zOJht6nE5Zyq4EtYxfdNliI=; b=oeBywsipHyl2WjTVeirmHyQD+0
	galrucq/hLBEMYXYvLAVje4vEBJM9ICEUFuy1LM+M7LVpgcFlsxcmh6IZV8k1nyP91OICFgxi6Mdr
	uP0As3OGasg4USr9KtGk53NbqcS1mVSkeVsafUh1ai9JUie5nP2E18iG3CT7CllImXVBeRf0sgmYe
	a4YRKbFrxw/9yNutAsF2y6hCCyY02FZx/+5XqhsdA5PTXZqMu5cL/4zV+L7IQjwidvl+BqeongBxn
	uCVLU5Ih3VYNjrqxcaNKqGJ8eqYl2CAIEaQMNlK3r9U5wBFM4QMqZRWSmJCzly1h8kAZ8UBZmh+AJ
	UM+aGggg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnQv2-00000007dp1-2m1h;
	Wed, 04 Feb 2026 00:38:56 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnQv0-00000007doS-0mEu
	for linux-nvme@lists.infradead.org;
	Wed, 04 Feb 2026 00:38:56 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 720843E6CF;
	Wed,  4 Feb 2026 00:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770165532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7cHI3uSb2KV86cPnzYM+zOJht6nE5Zyq4EtYxfdNliI=;
	b=a0KgJXxSaUCWnt9XndCe0vBIMla6i0bGGyBP86dt/YujBl5GPe1LTaL29glhpQSkT2EK9l
	mP0oQfJAEFuo5zvwlN/o1kOdv3vfSHjWnfpcNWtQ1ps831/31hjCqpMveTN556xIJUZua5
	VHRAZaBerVhWfJZPJGznjA51sB4bhtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770165532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7cHI3uSb2KV86cPnzYM+zOJht6nE5Zyq4EtYxfdNliI=;
	b=KhKMyrVPu3SV98zrSs3+HVTBypkOoG99Ib6i9CLMsDlL5SO7C3GXj46yvsDohv+ojwHM6l
	/KWDVs7qsks/2eAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770165532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7cHI3uSb2KV86cPnzYM+zOJht6nE5Zyq4EtYxfdNliI=;
	b=a0KgJXxSaUCWnt9XndCe0vBIMla6i0bGGyBP86dt/YujBl5GPe1LTaL29glhpQSkT2EK9l
	mP0oQfJAEFuo5zvwlN/o1kOdv3vfSHjWnfpcNWtQ1ps831/31hjCqpMveTN556xIJUZua5
	VHRAZaBerVhWfJZPJGznjA51sB4bhtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770165532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7cHI3uSb2KV86cPnzYM+zOJht6nE5Zyq4EtYxfdNliI=;
	b=KhKMyrVPu3SV98zrSs3+HVTBypkOoG99Ib6i9CLMsDlL5SO7C3GXj46yvsDohv+ojwHM6l
	/KWDVs7qsks/2eAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DD233EA63;
	Wed,  4 Feb 2026 00:38:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3apVDBeVgmnrZwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 04 Feb 2026 00:38:47 +0000
Message-ID: <21be273b-b1b2-4813-8178-e01cb0aa6301@suse.de>
Date: Wed, 4 Feb 2026 01:38:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/14] nvmet: Implement CCR nvme command
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-4-mkhalfella@purestorage.com>
 <77a00fa1-5707-4859-8a7a-e823ca18c9fe@suse.de>
 <20260203184039.GB3729-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260203184039.GB3729-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me,purestorage.com,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_163854_367955_7CAD6C83 
X-CRM114-Status: GOOD (  13.96  )
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

On 2/3/26 19:40, Mohamed Khalfella wrote:
> On Tue 2026-02-03 04:19:50 +0100, Hannes Reinecke wrote:
>> On 1/30/26 23:34, Mohamed Khalfella wrote:
>>> @@ -1501,6 +1516,38 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
>>>    	return ctrl;
>>>    }
>>>    
>>> +struct nvmet_ctrl *nvmet_ctrl_find_get_ccr(struct nvmet_subsys *subsys,
>>> +					   const char *hostnqn, u8 ciu,
>>> +					   u16 cntlid, u64 cirn)
>>> +{
>>> +	struct nvmet_ctrl *ctrl;
>>> +	bool found = false;
>>> +
>>> +	mutex_lock(&subsys->lock);
>>> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>>> +		if (ctrl->cntlid != cntlid)
>>> +			continue;
>>> +		if (strncmp(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE))
>>> +			continue;
>>> +
>> Why do we compare the hostnqn here, too? To my understanding the host
>> NQN is tied to the controller, so the controller ID should be sufficient
>> here.
> 
> We got cntlid from CCR nvme command and we do not trust the value sent by
> the host. We check hostnqn to confirm that host is actually connected to
> the impacted controller. A host should not be allowed to reset a
> controller connected to another host.
> 
Errm. So we're starting to not trust values in NVMe commands?
That is a very slippery road.
Ultimately it would require us to validate the cntlid on each
admin command. Which we don't.
And really there is no difference between CCR and any other
admin command; you get even worse effects if you would assume
a misdirected 'FORMAT' command.

Please don't. Security is _not_ a concern here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

