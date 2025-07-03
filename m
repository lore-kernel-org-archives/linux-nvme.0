Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1650C83030
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 09:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O8Chefdsodmo2eUHoE7JEna+rpgsFaMhEa2CT44nUX4=; b=ALHrFgnpedKxMLVCK84Q/aAEMP
	1jr1OZKSTcws25M58/5OsLLbm/GzcUpPbeGi5rUZTEBec6GZ6pIAZ5C9UJsDP75csqwTM7d/pgyMi
	M1q0vBi5SJxcSwx3eguyO4fANW833oUNFH/BrAtv1WkicM8EJ1qQFK5Dx/FPrrMqoNPU85zRCB+1I
	/YN6cxC2qYMHf8ozHIJ+I4qzi2DWJ29mMsee1QKogo5MPcGhD1AK88yg+JwxpVH1LDqHGeJfw8t/4
	cBpVBSxGdJLSA9MTZqLK8uHlWBdip3zj9TvIho/v6ZCQ3OfxqIaimayP3sM93F2aMcQblWZUnXjZQ
	3SRkFMgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXGVW-0000000AsCe-0ZOK;
	Thu, 03 Jul 2025 09:45:30 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXGTJ-0000000Ari5-13Pd
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 09:43:14 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 903841F387;
	Thu,  3 Jul 2025 09:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751535791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O8Chefdsodmo2eUHoE7JEna+rpgsFaMhEa2CT44nUX4=;
	b=CdMrr3lw25ToEqTdIW+pBYOfJf1t82vKT07i5Merruc5y8nCaud6aOYu3s7VjRHG033Ogg
	1GKRfVnN1PQSncMgpJkmXIlJCsVjqgLgVMWeUkE6sgDqwvH3zhvLKK8KlfEgPyQyya/9jw
	x41Xvt7M7moMtUWJGOTzUHghk6C2u6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751535791;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O8Chefdsodmo2eUHoE7JEna+rpgsFaMhEa2CT44nUX4=;
	b=o3B4EkYyYPn2LN2ZiZ4aDm0COmqTAre4aZBfMMrmWX3TjdHqzN+Hko3XlllB2YSCBDvpgt
	u5maaKbi2gmAebCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751535791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O8Chefdsodmo2eUHoE7JEna+rpgsFaMhEa2CT44nUX4=;
	b=CdMrr3lw25ToEqTdIW+pBYOfJf1t82vKT07i5Merruc5y8nCaud6aOYu3s7VjRHG033Ogg
	1GKRfVnN1PQSncMgpJkmXIlJCsVjqgLgVMWeUkE6sgDqwvH3zhvLKK8KlfEgPyQyya/9jw
	x41Xvt7M7moMtUWJGOTzUHghk6C2u6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751535791;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O8Chefdsodmo2eUHoE7JEna+rpgsFaMhEa2CT44nUX4=;
	b=o3B4EkYyYPn2LN2ZiZ4aDm0COmqTAre4aZBfMMrmWX3TjdHqzN+Hko3XlllB2YSCBDvpgt
	u5maaKbi2gmAebCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F3D513721;
	Thu,  3 Jul 2025 09:43:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EDVRHq9QZmguBgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 03 Jul 2025 09:43:11 +0000
Message-ID: <0752f56d-e425-4fb3-af4a-bb1af2ddf2c4@suse.de>
Date: Thu, 3 Jul 2025 11:43:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/9] nvme-auth: switch to use the kernel keyring
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20250528140517.3284-1-hare@kernel.org>
 <20250703093924.GA8177@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250703093924.GA8177@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_024313_433448_C990CA4A 
X-CRM114-Status: UNSURE (   7.38  )
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

On 7/3/25 11:39, Christoph Hellwig wrote:
> Can I get some reviews for this series?
> 
Was about to ask the same question ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

