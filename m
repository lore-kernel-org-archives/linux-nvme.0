Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92146C54E4A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 14:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y4uCvWz3Wy225W7/wbSZJRlf3ELP7rtGeXQ194o+g58=; b=ycdPE255rgqvTMV9svLf4ojB1c
	N5oA2hbX8JGetf0iWyl3cotkk85CmJdXix9XMno2ee09kEbiL0RlURtRL1F0tWV1ek2QtwnaaA3fu
	zjmXmQ3elohhInnDubbzxwTSDfyoYw2xmssmX+nMS6Nv967wc/8/n+Cxqx3cc57OPA4xqkC4Vc8+O
	SQPfnj7tqMh6dQWy5bOrQtu18hC2YkWweo15DQa/JELOZyGnKou5TGOr1wib2LHuX3rxU50a6DpKZ
	h5Ds1gu/xTC1U4TGBdfVyq019k10LD/EdPcVDTdM7idtnyGUTd3MRAaqu2Zfb1522d7z6utA2H/Ad
	OY5D3gRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riaus-00000009TQz-02iG;
	Fri, 08 Mar 2024 14:09:42 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riaum-00000009TPN-0SrI
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 14:09:38 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 30B4F20B3D;
	Fri,  8 Mar 2024 14:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709906974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y4uCvWz3Wy225W7/wbSZJRlf3ELP7rtGeXQ194o+g58=;
	b=LdMNq9Vk53GnG9IwC9ecyET/5PXz7mAJjJ+gnbYY8BPR9c0b7yNqTpG+DqWDpmFYHoVQfB
	618BZ7iaXEmI1SV3I9VaQA7cvYuyKpUi/d+hTG8uXCbm6Tw+m1jgZ3ah4K6te2ImmvPn7j
	kisnvTKK0k8ZEaLCId+4XNj0iJEDszw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709906974;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y4uCvWz3Wy225W7/wbSZJRlf3ELP7rtGeXQ194o+g58=;
	b=IaEfwZkHw+pQgoIW69W1H4SJ55T1itiwBXuTEQCUJYxabMQ6ALZHOkfwRnrj/mr4Cd1E+s
	BiNBNTpp9w5onaBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709906974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y4uCvWz3Wy225W7/wbSZJRlf3ELP7rtGeXQ194o+g58=;
	b=LdMNq9Vk53GnG9IwC9ecyET/5PXz7mAJjJ+gnbYY8BPR9c0b7yNqTpG+DqWDpmFYHoVQfB
	618BZ7iaXEmI1SV3I9VaQA7cvYuyKpUi/d+hTG8uXCbm6Tw+m1jgZ3ah4K6te2ImmvPn7j
	kisnvTKK0k8ZEaLCId+4XNj0iJEDszw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709906974;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y4uCvWz3Wy225W7/wbSZJRlf3ELP7rtGeXQ194o+g58=;
	b=IaEfwZkHw+pQgoIW69W1H4SJ55T1itiwBXuTEQCUJYxabMQ6ALZHOkfwRnrj/mr4Cd1E+s
	BiNBNTpp9w5onaBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFDF713310;
	Fri,  8 Mar 2024 14:09:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 47nJMB0c62XbKgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 08 Mar 2024 14:09:33 +0000
Message-ID: <4f3ee04a-daeb-4813-9f08-6450cffa1d70@suse.de>
Date: Fri, 8 Mar 2024 15:09:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] nvme-fc: FPIN link integrity handling
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, hare@kernel.org,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20240219085929.31255-1-hare@kernel.org>
 <1dfa9a4e-e4a2-4d48-b569-85e48ce4311c@grimberg.me>
 <1c3eea31-b80f-4b95-ab15-ac42f7c45c16@suse.de>
 <7ff7c9cc-6b02-4adc-9b78-8bab26341049@grimberg.me>
 <0b18f1f9-5011-46f4-a0a1-a69cd54bfc88@suse.de>
 <2b0bdbfb-1bff-405a-8f95-163a99022d94@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <2b0bdbfb-1bff-405a-8f95-163a99022d94@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 URIBL_BLOCKED(0.00)[suse.de:email];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_060936_442877_7AC13262 
X-CRM114-Status: GOOD (  18.78  )
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

On 3/8/24 11:38, Sagi Grimberg wrote:
> 
> 
> On 07/03/2024 14:13, Hannes Reinecke wrote:
>> On 3/7/24 13:01, Sagi Grimberg wrote:
>>>
[ .. ]
>>>
>>> stopped is different because it is not used to determine if it is 
>>> capable for IO (admin or io queues). Hence it is ok to be a flag.
>>>
>> Okay.
>>
But wait, isn't that precisely what we're trying to achieve here?
IE can't we call nvme_quiesce_io_queues() when we detect a link 
integrity failure?

Lemme check how this would work out...

>> So yeah, we could introduce a new state, but I guess a direct transition
>> to 'DEAD' is not really a good idea.
> 
> How common do you think this state would be? On the one hand, having a 
> generic state that the transport is kept a live but simply refuses to
> accept I/O; sounds like a generic state, but I can't think of an
> equivalent in the other transports.
> 

Yeah, it's pretty FC specific for now. Authentication is similar, 
though, as the spec implies that we shouldn't sent I/O when 
authentication is in progress.

> If this is something that is private to FC, perhaps the right way is to 
> add a flag for it that only fc sets, and when a second usage of it appears,
> we promote it to a proper controller state. Thoughts?

But that's what I'm doing, no? Only FC sets the 'transport blocked'
flag, so I'm not sure how your idea would be different here...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


