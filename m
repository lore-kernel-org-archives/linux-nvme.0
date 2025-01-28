Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FC9C0218D
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 08:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h/V/4mu8tgU3LvFKzQujlgaQYsCHzvHC73/2iNrZX2A=; b=KHEqxnp91GhvsjirX5SrmLFENA
	ITLcPR11+AFUxHmD9wBKs8bN1FxCgyDmIt5ZSON2zU9r77iR6oQQ3SrpqQjW8GvqIdOtLFb+IELZx
	FwqmZ843nwhP/pJc+oL/QA5J1nsWrmxdyVD1uOvUMPPr0SFzRKPAW1q/EfrbGoverC6+dITEymobR
	2vh2FUONp02/Bz96ymlDJPvYvc+CwdoDuJtz3HZH7dHR2xQoZyJ1lELIIA+oYPa5UZUrapDsnoiPr
	LaJBhr7FSy7tuSsapkavQXGGk3TVznGOohOAtOaSxVLpC2jOk9K5Gh/6zomSwPgMF3zWlfF6d2slu
	gfGErmBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tchGw-00000004QZi-0TRs;
	Tue, 28 Jan 2025 08:48:38 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tchGt-00000004QY8-0wjr
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 08:48:36 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9EB1C1F381;
	Tue, 28 Jan 2025 08:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738054113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/V/4mu8tgU3LvFKzQujlgaQYsCHzvHC73/2iNrZX2A=;
	b=o80r9gu+WOkBRWAH+DsBnI9iBsp7tJJ3HekHZL/IHUWgTFTgHevycT5B5qlBpFd555VdLG
	d1rWV2gkruWFcCCt/hT69O/XIWI0KLvL3ZC6jrIXC2PvTK7CWyBxKM1jNVbPEHxBJuwroa
	2wKY7v8tZh3ymdcbgnK/E3imI5239ro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738054113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/V/4mu8tgU3LvFKzQujlgaQYsCHzvHC73/2iNrZX2A=;
	b=C32546dfuF7ek599fEtR2q1Ha/pmSY2aYfE8jqS10Sbgbz0dd/GAiQTIvTh6eSddSpxv8J
	dDi7/8Br/seRvdBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738054113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/V/4mu8tgU3LvFKzQujlgaQYsCHzvHC73/2iNrZX2A=;
	b=o80r9gu+WOkBRWAH+DsBnI9iBsp7tJJ3HekHZL/IHUWgTFTgHevycT5B5qlBpFd555VdLG
	d1rWV2gkruWFcCCt/hT69O/XIWI0KLvL3ZC6jrIXC2PvTK7CWyBxKM1jNVbPEHxBJuwroa
	2wKY7v8tZh3ymdcbgnK/E3imI5239ro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738054113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/V/4mu8tgU3LvFKzQujlgaQYsCHzvHC73/2iNrZX2A=;
	b=C32546dfuF7ek599fEtR2q1Ha/pmSY2aYfE8jqS10Sbgbz0dd/GAiQTIvTh6eSddSpxv8J
	dDi7/8Br/seRvdBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D9DD13715;
	Tue, 28 Jan 2025 08:48:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id la4+GeGZmGcJHgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 28 Jan 2025 08:48:33 +0000
Message-ID: <0b81479d-5a4f-4534-9275-6b3abbb0a6ae@suse.de>
Date: Tue, 28 Jan 2025 09:48:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet: Implement 'admin_only' authentication
To: Sagi Grimberg <sagi@grimberg.me>, hare@kernel.org,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250124114738.115882-1-hare@kernel.org>
 <20250124114738.115882-2-hare@kernel.org>
 <6d74b77d-df2a-4622-8acb-3e5ac74be4d6@grimberg.me>
 <3a6370c2-75c6-43ef-860e-979c714abfc1@suse.de>
 <6c4f6fb5-d3a1-4674-902a-6719cbb8b13f@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <6c4f6fb5-d3a1-4674-902a-6719cbb8b13f@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_004835_417309_94B9C6EA 
X-CRM114-Status: GOOD (  16.03  )
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

On 1/28/25 09:11, Sagi Grimberg wrote:
> 
>> On 1/24/25 14:49, Sagi Grimberg wrote:
>>>
>>>
>>>
>>> On 24/01/2025 13:47, hare@kernel.org wrote:
>>>> From: Hannes Reinecke <hare@kernel.org>
>>>>
>>>> The spec allows for authentication to run on admin queues only, and 
>>>> secure
>>>> concatenation even requires it. So add a configfs attribute 
>>>> 'dhchap_admin_only'
>>>> to the target configuration to allow for testing independently of 
>>>> secure
>>>> concatenation.
>>>
>>> Why do we want it conditionally? why not always?
>>
>> Because we did support it originally, so I thought to play it safe.
>> Plus it'll cause a regression with the host implementation if applied
>> on its own.
>>
>> But if you say so ...
> 
> I'd like to avoid the extra configuration if possible, however we cannot 
> break
> existing hosts.
> 
> Is there a way to not authenticate I/O queues but still allow it?

Not really. Authentication is driven by the AUTHREQ_ATR / AUTHREQ_ASCR
return status code in the connect response. And that is sent by the
target, so the target has to decide whether it wants authentication on
the queue.
Sadly there is no status for 'whatever, I don't care' ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

