Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9763EC02181
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2025 07:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rg2J2YLlDaVcmj1tGtUxmVrw1PMytrwgXF9scFAG480=; b=T7IDfftt5PDW52nB59JERJVAJw
	WYuKujnIgqqK1q7nqXkjuHh8eW81YL/tdCsgQShCr9OT+Zw6mbCz+2KxOl9BHOtxkmZKs07BgaDKf
	/5lbiCm9Hg82cWM0RMTZEA566BC4/MgwwH/jFvLUagzYuyH1vEjM6VcdDpeTwWnNFt/wsomEZF39S
	0sdy5wjX6gKzr2tJoyAaTr/WPCXhC94YnJOq5+PYOSDwTdxwE81BZV0EQ145MmaC3j2kO4Y6rD6Fv
	E7/ZfAqKqRIH2o3j23GaYb4Ez5aA0ZbJmFi2ivYR3ARLZf8j810yzkqRPTNe1bwwChYct3+IW0w+b
	Y3Mji83Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXF6I-00000004H0j-1edb;
	Mon, 13 Jan 2025 07:43:06 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXF6G-00000004Gz4-1Rxe
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jan 2025 07:43:05 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 83696210FB;
	Mon, 13 Jan 2025 07:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736754182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rg2J2YLlDaVcmj1tGtUxmVrw1PMytrwgXF9scFAG480=;
	b=UGIaBRLbW47ils+vDcMBdvjyNcYMJaN0OaImKC/3v5l7MF47qIcrTL3bDwEP0ipSwIGL7A
	obCtMFMDJbv4p+az9yv55dxunw4E2kvmJYCFrqkSUilT3CqOEjVAzbdiqcBz+vJ7wD58rp
	qBMQXkqth3Kohd2MdewT4yjtXCebFgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736754182;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rg2J2YLlDaVcmj1tGtUxmVrw1PMytrwgXF9scFAG480=;
	b=N3BYK3lnMhpa8PaReBgcb0CzFeGV3sfoNZlhCIsZQ8r8enOP++uM67mgUkYx+i5B/YC+JE
	bvUfKwT74TpI9BDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UGIaBRLb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=N3BYK3ln
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736754182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rg2J2YLlDaVcmj1tGtUxmVrw1PMytrwgXF9scFAG480=;
	b=UGIaBRLbW47ils+vDcMBdvjyNcYMJaN0OaImKC/3v5l7MF47qIcrTL3bDwEP0ipSwIGL7A
	obCtMFMDJbv4p+az9yv55dxunw4E2kvmJYCFrqkSUilT3CqOEjVAzbdiqcBz+vJ7wD58rp
	qBMQXkqth3Kohd2MdewT4yjtXCebFgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736754182;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rg2J2YLlDaVcmj1tGtUxmVrw1PMytrwgXF9scFAG480=;
	b=N3BYK3lnMhpa8PaReBgcb0CzFeGV3sfoNZlhCIsZQ8r8enOP++uM67mgUkYx+i5B/YC+JE
	bvUfKwT74TpI9BDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B906D13310;
	Mon, 13 Jan 2025 07:43:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0J5RKwXEhGfRMwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Jan 2025 07:43:01 +0000
Message-ID: <f71a0a75-1a79-4d0f-803f-5eb8835252ef@suse.de>
Date: Mon, 13 Jan 2025 08:43:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Remove namespace when nvme_identify_ns_descs()
 failed
To: Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20241129140608.115282-1-hare@kernel.org>
 <Z09Y30pUtAg0xwoR@kbusch-mbp> <4ba05af4-9464-4cdf-a306-60585793c46e@suse.de>
 <Z1CF2vn1_xkNIVAM@kbusch-mbp> <99025917-e201-4ec9-ba04-e979f61c411b@suse.de>
 <Z1HRkKr5LhfvfLAs@kbusch-mbp.dhcp.thefacebook.com>
 <c737d451-f8b9-47cc-a411-4b2ed349fab0@suse.de>
 <97a8263b-1efb-43ce-b6ad-8444cf148346@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <97a8263b-1efb-43ce-b6ad-8444cf148346@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 83696210FB
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250112_234304_534551_2FF5BAFE 
X-CRM114-Status: GOOD (  31.90  )
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

On 1/11/25 15:01, Nilay Shroff wrote:
> 
> 
> On 12/6/24 6:11 PM, Hannes Reinecke wrote:
>> On 12/5/24 17:15, Keith Busch wrote:
>>> On Thu, Dec 05, 2024 at 01:30:39PM +0100, Hannes Reinecke wrote:
>>>> On 12/4/24 17:39, Keith Busch wrote:
>>>>>> 1) AEN triggers a rescan
>>>>>> 2) List of active namespace is retrieved
>>>>>> -> NSID A gets unmapped (or moved to another node in the cluster)
>>>>>> 3) Scan of NSID A returns an error with DNR set.
>>>>>> Without this patch we keep the namespace around, so eventually we'll
>>>>>> trip over the 'non-matching UUID' check once the NSID is reused.
>>>>>
>>>>> I'm still not sure that makes sense. The target shouldn't attach the new
>>>>> namespace until the host acknowledges the removal of the older NSID via
>>>>> the Namespace Change List log. Until the log is read, the inventory for
>>>>> removed namespaces should be latched. Otherwise, timing might remove+add
>>>>> a specific NSID before the host requests the NS Descriptor for the
>>>>> racing removal, then it would just get the "non-matching UUID" issue
>>>>> anyway.
>>>>
>>>> But we read the Namespace Change List log in step 2)
>>>> (Not that we're doing anything with it, but that's another story...)
>>>> Hmm?
>>>
>>> Indeed. So maybe we should just move the log page retrevial *after* we
>>> scan the identify active namespace list processing?
>>
>> Not sure how that would help. We are getting an 'ANA inaccessible' with DNR set status when retrieving the NS descriptor list for the namespace.
>> And this has to happen after we read the list of active namespace.
>> Perfectly legit, but doesn't tell us anything if the namespace is present at all.
>> All we know is that we cannot get information about that, and my argument is that we should treat this as equivalent to a namespace
>> not present.
>>
> I think when a nsid is in "ANA inaccessible" state sending any command which
> has that nsid described in it would be aborted by the controller.
> Per the NVMe 2.0  spec (quoting a snippet from section 8.1.3.3 ANA
> Inaccessible state):
> 
> "A controller shall abort commands, other than those described in section 8.1.4, with a status code of
> Asymmetric Access Inaccessible if those commands are submitted while the relationship between the
> namespace specified by the command and the controller processing the command is in this state.
> 
> While ANA Inaccessible state is reported by a controller for the namespace, the host should retry the
> command on a different controller that is reporting ANA Optimized state or ANA Non-Optimized state. If no
> controllers are reporting ANA Optimized state or ANA Non-Optimized state, then a transition may be
> occurring such that a controller reporting the Inaccessible state may become accessible and the host should
> retry the command on the controller reporting Inaccessible state for at least ANATT seconds (refer to Figure
> 275). Refer to section 8.10.2."
> 
> So as we can see above, removing nsid immediately just because ns-descriptor-list command
> failed with status "ANA inaccessible and DNR set" may not be correct. Because it's possible
> that ANA state may transition back to optimized/non-optimized state, So instead of removing
> ns from host, we may retry that command on another controller which is reporting ANA optimized/
> non-optimized state if that nsid is attached to more than one controller. If nsid is private
> (means attached only to one controller) then we may not have any option but to skip this nsid
> during scan and wait until either ANATT timer expires or nsid transition back from ANA
> inaccessible to ANA optimized/non-optimized state.
> 
I would agree with you for any other command. But the 'identify ns desc' 
command is the very first command send to the namespace, and it's 
required by our implementation to correctly attach the namespace to the 
corresponding ns_head structure.
We simply _cannot_ retry that command on another path, as that other 
path might (and, actually, is expected to) yield different information.

> Yes it might be possible that while nsid is in ANA inaccessible state, it might be un-mapped
> from the target controller. But in that case target should send namespace change notice to the
> host and that shall trigger ns scan. And as Keith proposed, we probably want to move the changed
> log ns retrieval just after we get active list of ns.
> 
That is precisely the scenario which I ran into.
We _do_ get the AEN changed event, but by the time when we start the ns 
scan the NSID has already been reassigned to a namespace with a 
different UUID.

When nvme_scan_ns() is called,  nvme_find_get_ns() would return 'true'
(as we still have the stale namespace in our lists), but the subsequent
nvme_validate_ns() would fail (as the UUID is different).
So the old namespace will be removed, but the new namespace will never 
be rescanned.

So my argument is that in this specific case the 'ANA inaccessible' nvme
state should _not_ be retried, but should be treated as identical to
'invalid namespace' errors.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

