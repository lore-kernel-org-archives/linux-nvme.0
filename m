Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBA3C83F03
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jul 2025 06:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xlly5fbBXZxxG8m/688aZ7/ocD9yVJ6E2BW4qemmrvw=; b=sW286vqqWqrgjpgsbNoHg1i0Xm
	Wp/5a85lp3j4PVVT+tLQdG3NInKPRp1Q8ZNcUnwf5G2yb6dQafbS/bNoFzDXlP7p40zDd4Zv15qON
	c/y64j1pQf3Z7YZjs11jmka/+AUWB27qgkPLyquDBVdsb3so+A2fke8yc85Me5OcQwdUiEiNlMwU8
	1z/aw8AYX1C5Hj3i8bR54/Sg1xoTutfMwTpiaqBQbRQj6qzN9cY1ZZIHlvxm86rssELpcdw5eMblb
	AqklBOT2nbz/u8sJoegStyb/qT6PI0d7V67kl99N/+T+nIyPROOpFVM99Nv0vPN9aeqAXo1F1yaxs
	gASfI3vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZODB-00000007fU5-3SpK;
	Wed, 09 Jul 2025 06:23:21 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZOB0-00000007fJb-1pg5
	for linux-nvme@lists.infradead.org;
	Wed, 09 Jul 2025 06:21:11 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 272DE2116B;
	Wed,  9 Jul 2025 06:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752042063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xlly5fbBXZxxG8m/688aZ7/ocD9yVJ6E2BW4qemmrvw=;
	b=W2sc/6rXp8Hies2cwvDKI07uY/TUCElx8DdXDnw/WBgk4jsuSEv9pDknCW1Lcy5YTnV+Xg
	tRCcSIE02RPOW7Wb5cTVl9hBjzvdXJdoQAZOIs/x+C0XqVeAkBBpeUzWBa+2sRY1owKT0j
	F7tZzKu+ltFQNvBsglfmSR7cdmlvtp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752042063;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xlly5fbBXZxxG8m/688aZ7/ocD9yVJ6E2BW4qemmrvw=;
	b=SV2MPq+GKMs8ROGJOQWmHQN6aQQKhz6DcKDLjZjM86wS061TNTF8Yp3Kr5Q5T2/Ko9FEpw
	5/2B6ay9SWrX4lAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="W2sc/6rX";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SV2MPq+G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752042063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xlly5fbBXZxxG8m/688aZ7/ocD9yVJ6E2BW4qemmrvw=;
	b=W2sc/6rXp8Hies2cwvDKI07uY/TUCElx8DdXDnw/WBgk4jsuSEv9pDknCW1Lcy5YTnV+Xg
	tRCcSIE02RPOW7Wb5cTVl9hBjzvdXJdoQAZOIs/x+C0XqVeAkBBpeUzWBa+2sRY1owKT0j
	F7tZzKu+ltFQNvBsglfmSR7cdmlvtp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752042063;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xlly5fbBXZxxG8m/688aZ7/ocD9yVJ6E2BW4qemmrvw=;
	b=SV2MPq+GKMs8ROGJOQWmHQN6aQQKhz6DcKDLjZjM86wS061TNTF8Yp3Kr5Q5T2/Ko9FEpw
	5/2B6ay9SWrX4lAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD39713757;
	Wed,  9 Jul 2025 06:21:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /D+ILE4Kbmg4TwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 09 Jul 2025 06:21:02 +0000
Message-ID: <0db83ea3-83aa-45ef-bafd-6b37da541d22@suse.de>
Date: Wed, 9 Jul 2025 08:21:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] nvme-fc: FPIN link integrity handling
To: John Meneghini <jmeneghi@redhat.com>, Bryan Gurney <bgurney@redhat.com>,
 linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, axboe@kernel.dk
Cc: james.smart@broadcom.com, dick.kennedy@broadcom.com,
 linux-scsi@vger.kernel.org, njavali@marvell.com, muneendra737@gmail.com
References: <20250624202020.42612-1-bgurney@redhat.com>
 <CAHhmqcTO_Q59aDr3DywC-tPF=9pe3gxbyn6J4ycdf+eYEOayHQ@mail.gmail.com>
 <19484829-0a7b-42ce-99fe-e74ccda67dce@suse.de>
 <b0817e2a-1c4e-4d7d-9a84-633913d9e0e4@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <b0817e2a-1c4e-4d7d-9a84-633913d9e0e4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,vger.kernel.org,marvell.com,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 272DE2116B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_232106_703520_FCC96ED4 
X-CRM114-Status: GOOD (  32.09  )
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

On 7/8/25 21:56, John Meneghini wrote:
> On 7/2/25 2:10 AM, Hannes Reinecke wrote:
>>> During path fail testing on the numa iopolicy, I found that I/O moves
>>> off of the marginal path after a first link integrity event is
>>> received, but if the non-marginal path the I/O is on is disconnected,
>>> the I/O is transferred onto a marginal path (in testing, sometimes
>>> I've seen it go to a "marginal optimized" path, and sometimes
>>> "marginal non-optimized").
>>>
>> That is by design.
>> 'marginal' paths are only evaluated for the 'optimized' path selection,
>> where it's obvious that 'marginal' paths should not be selected as
>> 'optimized'.
> 
> I think we might want to change this.  With the NUMA scheduler you can 
> end up with using the non-optimized marginal path.  This happens when
 > we test with 4 paths (2 optimized and 2 non-optimized) and set all 4
 > paths to marginal.  In this case> the NUMA scheduler should simply 
choose the optimized marginal path on
> the closest numa node.  However, that's not what happens. It consistently
 > chooses the non-optimized first non-optimized path.>
Ah. So it seems that the NUMA scheduler needs to be fixed.
I'll have a look there.

>> For 'non-optimized' the situation is less clear; is the 'non-optimized'
>> path preferrable to 'marginal'? Or the other way round?
>> So once the 'optimized' path selection returns no paths, _any_ of the
>> remaining paths are eligible.
> 
> This is a good question for Broadcom.  I think, with all IO schedulers, 
> as long
> as there is a non-marginal path available, that path should be used.  So
> a non-marginal non-optimized path should take precedence over a marginal 
> optimized path.
> 
> In the case were all paths are marginal, I think the scheduler should 
> simply use the first optimized path on the closest numa node.

For the NUMA case, yes. But as I said above, it seems that the NUMA
scheduler needs to fixes.

>>> The queue-depth iopolicy doesn't change its path selection based on
>>> the marginal flag, but looking at nvme_queue_depth_path(), I can see
>>> that there's currently no logic to handle marginal paths.  We're
>>> developing a patch to address that issue in queue-depth, but we need
>>> to do more testing.
>>>
>> Again, by design.
>> The whole point of the marginal path patchset is that I/O should
>> be steered away from the marginal path, but the path itself should
>> not completely shut off (otherwise we just could have declared the
>> path as 'faulty' and be done with).
>> Any I/O on 'marginal' paths should have higher latencies, and higher
>> latencies should result in higher queue depths on these paths. So
>> the queue-depth based IO scheduler should to the right thing
>> automatically.
> 
> I don't understand this.  The Round-robin scheduler removes marginal 
> paths, why shouldn't the queue-depth and numa scheduler do the same?
> 
The NUMA scheduler should, that's correct.

>> Always assuming that marginal paths should have higher latencies.
>> If they haven't then they will be happily selection for I/O.
>> But then again, if the marginal path does _not_ have highert
>> latencies why shouldn't we select it for I/O?
> 
> This may be true with FPIN Congestion Signal, but we are testing Link 
> Integrity.  With FPIN LI I think we want to simply stop using the path.
> LI has nothing to do with latency.  So unless ALL paths are marginal, 
> the IO scheduler should not be using any marginal path.
> 
For FPIN LI the paths should be marked as 'faulty', true.

> Do we need another state here?  There is an ask to support FPIN CS, so 
> maybe using the term "marginal" to describe LI is wrong.
> 
> Maybe we need something like "marginal_li" and "marginal_cs" to describe 
> the difference.
> 
Really not so sure. I really wonder how a FPIN LI event reflect back on
the actual I/O. Will the I/O be aborted with an error? Or does the I/O
continue at a slower pace?
I would think the latter, and that's the design assumption for this
patchset. If it's the former and I/O is aborted with an error we are in
a similar situation like we have with a faulty cable, and we need
to come up with a different solution.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

