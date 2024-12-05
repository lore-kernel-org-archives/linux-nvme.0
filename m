Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485DCE7716D
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2024 12:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kdW4FyXp3VA4hYXIXBApp/rejsddwFIs7XX9QSGioIw=; b=3U1lHm876t8bkxCC0Ott7nrZ7Z
	QwZykdqA9X0Gg41RhS/MGn5sKnmzODyINmOarB+Vjjrid+BtA7qiGI0AGsEtlT44GdHaFUnlCGrT3
	ElkIcVYO7H9198HewblbvA8n0GhmxHvDWV6I1mNUM+aguhJWPI/z6aEuuOJD/GspUXDnddb+n8SUG
	jYU/wlVD/2b7+Ux8dBWbjvmBId/N7wyb6UR+JUfl2m9d0td+OaIfa5APNqL7mps/eozm/0fEv1lWh
	3VLgUNayE9xIdU2fmBDiiv/M1Ya1pkhGtCH+iQRP7vIu9AWhN5tXsXp399fHCUpl8kNKU5sgsceF+
	3jnEQnFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJB57-0000000FycR-2rty;
	Thu, 05 Dec 2024 12:35:45 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJB0E-0000000FxgP-2U0M
	for linux-nvme@lists.infradead.org;
	Thu, 05 Dec 2024 12:30:43 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 68FF11F396;
	Thu,  5 Dec 2024 12:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733401839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdW4FyXp3VA4hYXIXBApp/rejsddwFIs7XX9QSGioIw=;
	b=IoG4ChSkHpH3DKmF8f96kymtKF6x/cJ3Xrv/zu9m3sBTVNw9L21CsKgsaYOKwPFnaBKMzC
	E8d3xkpnIgPcsHrcAWtWyhxDoKnb8W7QIDYyISA1aawLKv0jncBUQAbmnVKsWZ40jm5yiE
	sH6gUjpT400Xlt+SDodSJEx3sLTGnbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733401839;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdW4FyXp3VA4hYXIXBApp/rejsddwFIs7XX9QSGioIw=;
	b=R1sc5LU+35NMhJvsIt1g8EEslrAM5SRWNq84MgB0LsTdYNiQDGYHi2XoEAu1gwazJZj43W
	6SgOGI9srMv+5ZBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733401839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdW4FyXp3VA4hYXIXBApp/rejsddwFIs7XX9QSGioIw=;
	b=IoG4ChSkHpH3DKmF8f96kymtKF6x/cJ3Xrv/zu9m3sBTVNw9L21CsKgsaYOKwPFnaBKMzC
	E8d3xkpnIgPcsHrcAWtWyhxDoKnb8W7QIDYyISA1aawLKv0jncBUQAbmnVKsWZ40jm5yiE
	sH6gUjpT400Xlt+SDodSJEx3sLTGnbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733401839;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdW4FyXp3VA4hYXIXBApp/rejsddwFIs7XX9QSGioIw=;
	b=R1sc5LU+35NMhJvsIt1g8EEslrAM5SRWNq84MgB0LsTdYNiQDGYHi2XoEAu1gwazJZj43W
	6SgOGI9srMv+5ZBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56B60132EB;
	Thu,  5 Dec 2024 12:30:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N0myFO+cUWfQOAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 05 Dec 2024 12:30:39 +0000
Message-ID: <99025917-e201-4ec9-ba04-e979f61c411b@suse.de>
Date: Thu, 5 Dec 2024 13:30:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Remove namespace when nvme_identify_ns_descs()
 failed
To: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20241129140608.115282-1-hare@kernel.org>
 <Z09Y30pUtAg0xwoR@kbusch-mbp> <4ba05af4-9464-4cdf-a306-60585793c46e@suse.de>
 <Z1CF2vn1_xkNIVAM@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Z1CF2vn1_xkNIVAM@kbusch-mbp>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_043042_785427_E061AA27 
X-CRM114-Status: GOOD (  17.58  )
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

On 12/4/24 17:39, Keith Busch wrote:
> On Wed, Dec 04, 2024 at 08:14:08AM +0100, Hannes Reinecke wrote:
>> On 12/3/24 20:15, Keith Busch wrote:
>>> On Fri, Nov 29, 2024 at 03:06:08PM +0100, Hannes Reinecke wrote:
>>>> When a namespace gets unmapped on the target during scanning
>>>> nvme_identify_ns_descs() returns with a non-retryable error.
>>>> With the currrent code we will ignore that error on the grounds
>>>> that we failed to get information, and hence cannot make any
>>>> decisions whether to keep or remove that namespace.
>>>> But a non-retryable error implies that the namespace is _not_
>>>> present as we cannot retry that command and will never get
>>>> information about that namespace.
>>>> And we need to remove the namespace during scanning, as otherwise
>>>> the AEN informing us about a namespace change will find the NSID
>>>> present, but nvme_validate_ns() will fail, and the namespace
>>>> will never be updated with the correct information.
>>>
>>> The scanning only checks namespaces returned in the "active" namespace
>>> list. Every namespace not in the active list gets removed already. Why
>>> is this unmapped namespace appearing on the active list?
>>
>> Timing. Imagine a system used as a backing store for kubernetes, where
>> namespaces come and go at a _really_ fast pace.
>> 1) AEN triggers a rescan
>> 2) List of active namespace is retrieved
>> -> NSID A gets unmapped (or moved to another node in the cluster)
>> 3) Scan of NSID A returns an error with DNR set.
>> Without this patch we keep the namespace around, so eventually we'll
>> trip over the 'non-matching UUID' check once the NSID is reused.
> 
> I'm still not sure that makes sense. The target shouldn't attach the new
> namespace until the host acknowledges the removal of the older NSID via
> the Namespace Change List log. Until the log is read, the inventory for
> removed namespaces should be latched. Otherwise, timing might remove+add
> a specific NSID before the host requests the NS Descriptor for the
> racing removal, then it would just get the "non-matching UUID" issue
> anyway.

But we read the Namespace Change List log in step 2)
(Not that we're doing anything with it, but that's another story...)
Hmm?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

