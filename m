Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B4FC87FCB
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Aug 2025 10:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4GuKuzfDs4g5aKMDRCXzmF0ewuve2tJiuZ4rJf2mDYI=; b=xXZEqzaiDxSYgoxJ0UzRoPFkwS
	WDQz+ChonlGikKQf2+HQzpIXOHbO58sQ2YT3t3dWKNUL5UZ5TOBHTCqW7il7cWdXnGO64Yz/duALd
	GhFPkaq99Mhr8uzjtJAawj+RyoHGaRC3+UCURKLkyIKAbKKNfxABGIz0fmcUsXoXSbSKD8IvovNH6
	3upKTDNnYp94TrpIoA4cml/A4DglKsjmzge/uf77ooqktu3OpjI66km2oFz1mqogilvAzPYO9FSCj
	XYFKgTsrNhODnXkaj9EK+I9B/+JxYAfHBqVCgnGsoMQVjdjbEuRCTfAfujVMkXmg7nLBtVoubJzzD
	Oum5VgDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujbnF-0000000ExbO-3Lyc;
	Wed, 06 Aug 2025 10:54:49 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujbnD-0000000ExaQ-1uTP
	for linux-nvme@lists.infradead.org;
	Wed, 06 Aug 2025 10:54:48 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 026D01F7F5;
	Wed,  6 Aug 2025 10:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754477686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GuKuzfDs4g5aKMDRCXzmF0ewuve2tJiuZ4rJf2mDYI=;
	b=R67Cp3pDxnzb/2nWVjYWlk8mrQtq/xmY9nLnPJUwlrQWafyZBLU9Qf/UqXFH0C15HRcNt/
	ETKXZXaL+OqsIjSkvlKFkakJua3M+rN9mW05kpXjVjBdi5uj6Jl/b666Uv713SaGvdGLKw
	t43ibI65z4LbKPa5hiroHppTuEke3es=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754477686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GuKuzfDs4g5aKMDRCXzmF0ewuve2tJiuZ4rJf2mDYI=;
	b=d6DTN0w3bLXHWgNlWDfm3RnUYErLAdXPyn6flXQcrnjXpZ7rdnru/GosX9lVHo1DbyeT5c
	dw0zgi6XJev8h+BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754477686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GuKuzfDs4g5aKMDRCXzmF0ewuve2tJiuZ4rJf2mDYI=;
	b=R67Cp3pDxnzb/2nWVjYWlk8mrQtq/xmY9nLnPJUwlrQWafyZBLU9Qf/UqXFH0C15HRcNt/
	ETKXZXaL+OqsIjSkvlKFkakJua3M+rN9mW05kpXjVjBdi5uj6Jl/b666Uv713SaGvdGLKw
	t43ibI65z4LbKPa5hiroHppTuEke3es=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754477686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GuKuzfDs4g5aKMDRCXzmF0ewuve2tJiuZ4rJf2mDYI=;
	b=d6DTN0w3bLXHWgNlWDfm3RnUYErLAdXPyn6flXQcrnjXpZ7rdnru/GosX9lVHo1DbyeT5c
	dw0zgi6XJev8h+BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B674013AA8;
	Wed,  6 Aug 2025 10:54:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MCieKnU0k2i1OwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 06 Aug 2025 10:54:45 +0000
Message-ID: <3ab1de01-7a55-4c7b-b183-49618dc93a09@suse.de>
Date: Wed, 6 Aug 2025 12:54:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests nvme/tcp nvme/060 hang
To: Maurizio Lombardi <mlombard@bsdbackstore.eu>,
 Yi Zhang <yi.zhang@redhat.com>, linux-block <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Maurizio Lombardi <mlombard@redhat.com>
References: <CAHj4cs-zu7eVB78yUpFjVe2UqMWFkLk8p+DaS3qj+uiGCXBAoA@mail.gmail.com>
 <DBV4IHEMUOQ8.28P7LBNP9EHVK@bsdbackstore.eu>
 <DBV4NAR2A6N2.1LFJCYHLTHUN2@bsdbackstore.eu>
 <DBV53ULYUBX6.1ZBU5KFWA2SHH@bsdbackstore.eu>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <DBV53ULYUBX6.1ZBU5KFWA2SHH@bsdbackstore.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_035447_637619_80715F3E 
X-CRM114-Status: GOOD (  15.62  )
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

On 8/6/25 08:44, Maurizio Lombardi wrote:
> On Wed Aug 6, 2025 at 8:22 AM CEST, Maurizio Lombardi wrote:
>> On Wed Aug 6, 2025 at 8:16 AM CEST, Maurizio Lombardi wrote:
>>>
>>> I think that the problem is due to the fact that nvmet_tcp_data_ready()
>>> calls the queue->data_ready() callback with the sk_callback_lock
>>> locked.
>>> The data_ready callback points to nvmet_tcp_listen_data_ready()
>>> which tries to lock the same sk_callback_lock, hence the deadlock.
>>>
>>> Maybe it can be fixed by deferring the call to queue->data_ready() by
>>> using a workqueue.
>>>
>>
>> Ops sorry they are two read locks, the real problem then is that
>> something is holding the write lock.
> 
> Ok, I think I get what happens now.
> 
> The threads that call nvmet_tcp_data_ready() (takes the read lock 2
> times) and
> nvmet_tcp_release_queue_work() (tries to take the write lock)
> are blocking each other.
> So I still think that deferring the call to queue->data_ready() by
> using a workqueue should fix it.
> 
It's nvmet_tcp_list_data_ready() which is the problem; thing is, we only
need to take the lock to access 'sk_user_data' (as this might be
while the callback is running). But the 'sk_state' value can be accessed
without a lock, and as we need to look at sk_user_data only if the
socket is in TCP_LISTEN state (which I hope is not the case during
socket shutdown) we can move the check out of the lock and avoid
this issue.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

