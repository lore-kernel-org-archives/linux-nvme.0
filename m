Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73D3E81A3F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Feb 2026 16:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5qZ+gncTo83Pa/tlAU8PPmKc8PzepOWLFBYa3C1pQmQ=; b=VvzMi+fNEA2gzfKxl1n0+WXvU1
	pxNc0tjuGv6+UwwxarpOFDiMz9AhqLqxpWBF9rDDtsKvUWvOrx7G/6tPxeuMTgh81+xc9KboIpdJy
	hc3pdG0MaixCTl6rm8qh7FAZuBT7uShPBVBMOj598yricIJiRykSNpKbuKfTX6yM0gTLmM7sEMnov
	nKldqdbtB6bPOe0A96uHN6ke8oFBfiRuZ4t0Ruw1uFigdS9ttyHqTWJHnDhC0rjQ3kGDRIIe7xmL9
	1dQDwWEMdB3ySdN8+y9/2f/zlu64S6FtioSo4KXs30akiFQ3k+D1my+AwnnQ4l+2pJlFpg5V6MZiq
	eov3s/Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vs1WR-000000072Al-05QK;
	Mon, 16 Feb 2026 16:32:31 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vs1WM-0000000729e-2aZE
	for linux-nvme@lists.infradead.org;
	Mon, 16 Feb 2026 16:32:29 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC08B3E6D3;
	Mon, 16 Feb 2026 16:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771259544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5qZ+gncTo83Pa/tlAU8PPmKc8PzepOWLFBYa3C1pQmQ=;
	b=jJq/b2C/I2XPMvN3uIRDVQcRWqp9Dn73JK65HPxnaFT6II6+9LYOXgu1c/18fbsEemVvPM
	BPfeNDjesZ2D+O+J3m+75Ywl6bQbHCLHG8BGeVYfPbqk5ohm8o3qa8VMx+s7M//zlfA5jC
	sNwwXk/U0o3zpG5WqrvATVYTtWg/8io=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771259544;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5qZ+gncTo83Pa/tlAU8PPmKc8PzepOWLFBYa3C1pQmQ=;
	b=me4ILhSVIq1ZwTrHb2MFHngFrsbUsHKMXpVZAQ//BnKttEgrUxekf4/YKxyCbbCLZdW40B
	/Dv7cOMFGrPjD0DA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="jJq/b2C/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=me4ILhSV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771259544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5qZ+gncTo83Pa/tlAU8PPmKc8PzepOWLFBYa3C1pQmQ=;
	b=jJq/b2C/I2XPMvN3uIRDVQcRWqp9Dn73JK65HPxnaFT6II6+9LYOXgu1c/18fbsEemVvPM
	BPfeNDjesZ2D+O+J3m+75Ywl6bQbHCLHG8BGeVYfPbqk5ohm8o3qa8VMx+s7M//zlfA5jC
	sNwwXk/U0o3zpG5WqrvATVYTtWg/8io=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771259544;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5qZ+gncTo83Pa/tlAU8PPmKc8PzepOWLFBYa3C1pQmQ=;
	b=me4ILhSVIq1ZwTrHb2MFHngFrsbUsHKMXpVZAQ//BnKttEgrUxekf4/YKxyCbbCLZdW40B
	/Dv7cOMFGrPjD0DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 667BA3EA62;
	Mon, 16 Feb 2026 16:32:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zaAdFphGk2lEKwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 16 Feb 2026 16:32:24 +0000
Message-ID: <784d3f14-99a0-4661-afde-b412d44572ab@suse.de>
Date: Mon, 16 Feb 2026 08:26:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Native SCSI multipath support
To: John Garry <john.g.garry@oracle.com>, lsf-pc@lists.linux-foundation.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org
References: <69349b51-72c2-47f9-948f-f89843af62e4@oracle.com>
 <b598c5c9-6732-4661-85b2-7ab10a0830d4@suse.de>
 <dbf5fbdd-8894-40b7-b574-0c6385995ec2@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;
 attachmentreminder=0; deliveryformat=0
X-Identity-Key: id3
Fcc: imap://hare%40Thunderbird_lenient@imap.suse.de/INBOX/Sent
In-Reply-To: <dbf5fbdd-8894-40b7-b574-0c6385995ec2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	URIBL_BLOCKED(0.00)[lst.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: AC08B3E6D3
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260216_083228_351404_13936958 
X-CRM114-Status: GOOD (  21.70  )
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

On 2/14/26 10:42, John Garry wrote:
> On 13/02/2026 17:21, Hannes Reinecke wrote:
>>> At ALPSS 25 I presented a proposal for Native SCSI multipath support. 
>>> Let's discuss this topic at LSFMM.
>>>
>>> The idea for this is that SCSI could natively support multipath, like 
>>> how NVMe host driver does today. It is intended as an alternative to 
>>> dm- multipath support.
>>>
>>> I have been working on the implementation and I plan to post patches 
>>> in the next cycle. I am looking at a 3-stage approach:
>>> a. create a driver-agnostic multipath library, very heavily based on 
>>> NVMe host multipath support.
>>> The library would support features such as path management, path 
>>> selection/iopolicy, failover recovery, PR, delayed removal, gendisk 
>>> management etc.
>>> b. switch NVMe over to use this library
>>> c. add native SCSI multipath support based on this common library
>>>
>> Go for it, John!
>>
>> I'd be very interested in that.
> 
> cheers, in the meantime, I have some comments:
> 
> - I need to test PRs for both NVMe and SCSI, any advice on that would be 
> good. I don't think that blktests covers it. I did see Christoph mention 
> a testsuite at: https://lore.kernel.org/linux-nvme/1438672271-11309-1- 
> git-send-email-hch@lst.de/ - I can check that.
> 
Well, you might have seen the discussion on the device-mapper list, 
where stefanha is implementing generic PRs for dm-multipathing.
Or rather, trying to. We might need to revisit that and see what we
could be doing on the SCSI side.
Maybe we should be having a session about PRs at LSF?

> - I am still not sure on whether we require a multipath version of sg. 
> We can still have per-path sg. NVMe does have a multipath nvme-generic 
> dev, but that just handles IOCTLs/uring cmd, and nothing like sg read/ 
> write fops
> 
'sg' is primarily for testing 'raw' SCSI commands. (And dastardly 
complex to boot). I really would keep it in it's current form, and not
try to mimick something with SCSI multipathing.

> - I have not tried to detangle ALUA support from SCSI DH, so no ALUA 
> support yet
> 
Ouch. But that is the key point of the implementation; ALUA provides
_all_ the information required for multipathing, so how can you _not_
have support for it?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

