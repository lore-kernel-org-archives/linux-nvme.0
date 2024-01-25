Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93152C47258
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jan 2024 17:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TYiYZb5movKnZUK5D5cCIZBaRWiU3C0sNR9D/Em4FXw=; b=id6j8blbimWNbJUgWuGbXOzztk
	9QJ3qpLo6LFqJJVny8U6SSqhreA/TPAVWnxMITaRc2GqIuLdjtbq9ffc+Z+jBM9xCL4PKKuwJ9bvs
	IV1yr98TsarbLpuOxB7rcoupBc7Kj8S0QZjvX5gcJczbAuZ5U9N7wZoPjxvC4h7KMVAgrdY/ZRiwO
	CjFN4xlk+uAjHFU1U65r8fwBGeuOsPpjA9mvB7Zug41PKJOp/9rERFyVoG5W9jC7fNkKM88eOUuuM
	WHJlw2F/nT/GgOrooVkW28mssELiq87hnN2dKyDsmyz4YkZuqDdYVD5HxYmEvO1ZCd5W/0H/nEe36
	zotqeQOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT3E3-000000014Yf-1v68;
	Thu, 25 Jan 2024 17:09:15 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT3Dz-000000014WD-0yLW
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jan 2024 17:09:13 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 937F01F8AB;
	Thu, 25 Jan 2024 17:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706202549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYiYZb5movKnZUK5D5cCIZBaRWiU3C0sNR9D/Em4FXw=;
	b=JUUmfzToBXHs0rJ4rFKSwln25W+TLHmpGDm11NaGOEbsh6JMG7un2Q1EUYszdIeDjBLy/n
	LtttwzlBqqAEsGuCSfHmheEcVJYPy/frtHCaBrzWlMpU1TEdFERWvQFHQhF0skK+DZdBcL
	Vr6udehImdbwXD/gMLbR5VvsQw8OKz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706202549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYiYZb5movKnZUK5D5cCIZBaRWiU3C0sNR9D/Em4FXw=;
	b=oomX6MAsEEeutV6GT6Ullnp5YTrzRkSmxM6EpcXKBu4rrX9Qa9e1bk+u/HoeiBqXEKIWo0
	ZZBbbVLqxe2xSDDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706202549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYiYZb5movKnZUK5D5cCIZBaRWiU3C0sNR9D/Em4FXw=;
	b=JUUmfzToBXHs0rJ4rFKSwln25W+TLHmpGDm11NaGOEbsh6JMG7un2Q1EUYszdIeDjBLy/n
	LtttwzlBqqAEsGuCSfHmheEcVJYPy/frtHCaBrzWlMpU1TEdFERWvQFHQhF0skK+DZdBcL
	Vr6udehImdbwXD/gMLbR5VvsQw8OKz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706202549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYiYZb5movKnZUK5D5cCIZBaRWiU3C0sNR9D/Em4FXw=;
	b=oomX6MAsEEeutV6GT6Ullnp5YTrzRkSmxM6EpcXKBu4rrX9Qa9e1bk+u/HoeiBqXEKIWo0
	ZZBbbVLqxe2xSDDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55D6D134C3;
	Thu, 25 Jan 2024 17:09:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id piH4ErWVsmWmCAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 25 Jan 2024 17:09:09 +0000
Message-ID: <d4a814f5-0dc9-46d9-8c5c-eaa31cd889f4@suse.de>
Date: Thu, 25 Jan 2024 18:09:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: enable retries for authentication commands
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: hare@kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Martin George <marting@netapp.com>
References: <20240125130906.94874-1-hare@kernel.org>
 <13922738-7cdb-457d-9ba6-4a3a9a064a8b@kernel.dk>
 <20240125154814.GA23800@lst.de>
 <b3e68e05-f698-4fbc-87a7-99f7461d88be@suse.de>
 <aa4a3561-2ecc-4e64-895f-356405dc14c3@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aa4a3561-2ecc-4e64-895f-356405dc14c3@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JUUmfzTo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oomX6MAs
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 937F01F8AB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_090911_467726_2DBE5421 
X-CRM114-Status: GOOD (  16.75  )
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

On 1/25/24 17:50, Jens Axboe wrote:
> On 1/25/24 9:20 AM, Hannes Reinecke wrote:
>> On 1/25/24 16:48, Christoph Hellwig wrote:
>>> On Thu, Jan 25, 2024 at 08:42:10AM -0700, Jens Axboe wrote:
>>>> On 1/25/24 6:09 AM, hare@kernel.org wrote:
>>>>> From: Hannes Reinecke <hare@suse.de>
>>>>>
>>>>> Authentication commands are normal NVMe commands, and as such
>>>>> can return a status where NVME_SC_DNR is not set, indicating
>>>>> that the command should be retried.
>>>>> Rather than checking NVME_SC_DNR manually for each command completion
>>>>> this patch adds a flag 'retry' to __nvme_submit_sync_cmd(), causing
>>>>> the REQ_FAILFAST_DRIVER option to be cleared and the command to
>>>>> be retried via the normal mechanism.
>>>>
>>>> Can we please do this without adding Yet Another parameter to that
>>>> function?
>>>
>>> Heh, I wrote about the same reply a few minutes ago.  I'll try to think
>>> what we can do instead.
>>
>> We could do something like this:
> 
> That won't really do much, and yeah wouldn't be the way even if
> complete. How about just not setting the flag in the first place?
> nvme_init_request() defaults to doing it, so either pass in the init
> flags to that, or just clear it in there and have the callers decide if
> they want to set it.
> 
But that's the thing; the request is never visible to the caller.
So moving things out of the nvme_init_request() doesn't really help.

And open-coding __nvme_submit_sync_cmd() also doesn't look very
appealing.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


