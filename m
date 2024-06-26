Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4EFC27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 14:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZisKXaQlV//V59MHsxPUDCYi9bHNu06Qxmnvtb3AV5c=; b=HmJrsKkp6GfoPEgTPZ/JAl97NW
	aTSPmDrdHaEHgIJTNdjTfsf9HmBXeJhyRv+R6JYXoGdVkTl/qow5Ebrb+Kf8OBypDhq12DkPBV303
	AClFZZfvEyUU2JyBUumYwRiZvAQ7ecNLW840E2ZHnAKK6Rh4olGIMAql0rkyj7Cmer04ChjexgAy7
	YFO7uly51HuK8vIgWXyNcP+ujKd40e76Ii/HRs6d/h4ULf1HlXgRZt64uX6PDa9hbSikTTDIf/Ym9
	IveMYtn8si9P+5s+hNjW+LX1G6UerkIi2Vz9NyepwMOs0zLJb6JeLKgVoJCfCNmWyTPlEBnwzvbHy
	THsdZOVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMTcw-00000007A5P-464G;
	Wed, 26 Jun 2024 14:28:02 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMTch-000000079yv-1D1u
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 14:27:57 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 175151FB57;
	Wed, 26 Jun 2024 14:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719412064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZisKXaQlV//V59MHsxPUDCYi9bHNu06Qxmnvtb3AV5c=;
	b=sqD5Ua5w6dvJ+tCtAM2PvGcCZMYmnbJ6aSHGXtdP9XuNMg0QuDIVDaxAUCrxAc4xWnVzAv
	aeB55T6RiQub0VTdNcWWLRTFm6SfFF8c8GqWaUuTeT8Jx7f/3ZhKsxhwjTu0hB8fXl5pAj
	E7M3VTm3q/O3oCse6DrsydZpk5/QvuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719412064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZisKXaQlV//V59MHsxPUDCYi9bHNu06Qxmnvtb3AV5c=;
	b=8OhZda6RTM6E1LQ1sDxJtVSsKGlEijh0B2J/BGNEHuS1uHmMC8/qVfwSyR13BeM9zfow7C
	xKcg7iNBzjJif5Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719412064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZisKXaQlV//V59MHsxPUDCYi9bHNu06Qxmnvtb3AV5c=;
	b=sqD5Ua5w6dvJ+tCtAM2PvGcCZMYmnbJ6aSHGXtdP9XuNMg0QuDIVDaxAUCrxAc4xWnVzAv
	aeB55T6RiQub0VTdNcWWLRTFm6SfFF8c8GqWaUuTeT8Jx7f/3ZhKsxhwjTu0hB8fXl5pAj
	E7M3VTm3q/O3oCse6DrsydZpk5/QvuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719412064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZisKXaQlV//V59MHsxPUDCYi9bHNu06Qxmnvtb3AV5c=;
	b=8OhZda6RTM6E1LQ1sDxJtVSsKGlEijh0B2J/BGNEHuS1uHmMC8/qVfwSyR13BeM9zfow7C
	xKcg7iNBzjJif5Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4D0E139C2;
	Wed, 26 Jun 2024 14:27:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id inY/Ml8lfGY1UwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 26 Jun 2024 14:27:43 +0000
Message-ID: <54329e96-918f-46af-a112-dba40c6529b5@suse.de>
Date: Wed, 26 Jun 2024 16:27:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] nvme-tcp scalability improvements
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240626121347.1116-1-hare@kernel.org>
 <d14c86cc-b6cf-4b86-840f-fd514ad8a8c0@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <d14c86cc-b6cf-4b86-840f-fd514ad8a8c0@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_072747_506501_EA3EB722 
X-CRM114-Status: GOOD (  19.43  )
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

On 6/26/24 15:37, Sagi Grimberg wrote:
> 
> 
> On 26/06/2024 15:13, Hannes Reinecke wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> Hi all,
>>
>> we have had reports from partners that nvme-tcp suffers from scalability
>> problems with the number of controllers; they even managed to run into
>> a request timeout by just connecting enough controllers to the host.
>>
>> Looking into it I have found several issues with the nvme-tcp 
>> implementation:
>> - the 'io_cpu' assignment is static, leading to the same calculation
>>    for each controller. Thus each queue with the same number is
>>    assigned the same CPU, leading to CPU starvation.
>> - The blk-mq cpu mapping is not taken into account when calculating
>>    the 'io_cpu' number, leading to excessive thread bouncing during I/O
>> - The socket state is not evaluating, so we're piling more and more
>>    requests onto the socket even when it's already full.
>>
>> This patchset addresses these issues, leading to a better I/O
>> distribution for several controllers.
> 
> Hannes, Please quantify what every change gives us please. Each
> change on its own should present merit, otherwise we should consider
> weather it is actually needed.
> 
Oh, I do agree with you. It's just hard to quantify, as with the current
implementation we vastly favour writes over reads. If we try to balance
things out (as these patches do) read performance goes up significantly,
and write performance goes down. So one can't really say its a 
performance regression in general, we're just shifting things around.

I'll try to get some more meaningful data, but this is a hard task as
I first need to setup a scale-out target such that I can demonstrate the
issues more clearly.

In the end I've send out these patches primarily to show the direction 
I'm investigating in, in case other people want to play around with 
them, too.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


