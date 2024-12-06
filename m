Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066C1E77173
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 12:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uIr4hPTMcc/Y6GYqE1SEckkIWq9Jr3ct2YdONaW3QcA=; b=DoKeOcF8RtMyXZOhrX/uFOQ6F8
	eq/93UwohozA9Klju9dRdW+m78X8QTd4xobfFKbt0XzfgtLo6mAvEy+ChprqAYNCJdR8UlMjiPmkr
	mU4JNUS3HMLlr7rvFd5vwHAqASxn/0ev5iKkCVuYXL2lr5iiZIUTr1t2LETsl6O0PkbgQm5nUSSUK
	MgHW1QJ2RF5R1vF4WK2UNv2qNItIJa0T9zQKEciGT6VRCc2Cgqr3SS0bt4s3YQQOn4qWxc/bAReaK
	i9QQRqxbriEeX3RLbmtfzFpjNfeBW+hacjGFWIhHqxHM1rTavRYIvkCrVjS0PBCVUy6/xD2Kmhn1Y
	WUnRCoSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJXer-00000001bTv-09pb;
	Fri, 06 Dec 2024 12:42:09 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJXdx-00000001bOO-0dKp
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 12:41:14 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 130952118D;
	Fri,  6 Dec 2024 12:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733488870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uIr4hPTMcc/Y6GYqE1SEckkIWq9Jr3ct2YdONaW3QcA=;
	b=hN5khsCNFjdHNorIPq8YejT0HzZ3gBEhBQOfMEyv6TzEjPVd0XIR7ZvWbl6VUhTpsRmYQF
	2D5eVh2TZtk8uKGiCAMiEI8BwNTF/9FTvlgK821Dz+CA9O5Eg8zx9BNeZfspLNlgtBUbcI
	YFT91ykR3rTVSkbFusxPawF+yFepf3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733488870;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uIr4hPTMcc/Y6GYqE1SEckkIWq9Jr3ct2YdONaW3QcA=;
	b=djWNGaCUXUmEB0d4sTC6YdSIdHzNGWdRHxufwsIsInltTMVl128MEZKunfya4RWkv/FOhk
	fFwP5+jg3scRw+AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=InUMiwQ6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZiG8eb0O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733488869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uIr4hPTMcc/Y6GYqE1SEckkIWq9Jr3ct2YdONaW3QcA=;
	b=InUMiwQ6pDahq666nhyGIFcUekaCqf0M9d+zpPNz7kaPpCHI6BYkQut5Id4Mf6NxmVydK4
	DSITNIS5zj7vRCJsOGX7cliacrYyZfXq7VNSxw97s6jf9nlcrlN/gB8V9bS0uX13WMXFUq
	Y/ldw7UzA2hP1eXVGBk3cyucz/crJK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733488869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uIr4hPTMcc/Y6GYqE1SEckkIWq9Jr3ct2YdONaW3QcA=;
	b=ZiG8eb0OIOPsnevQmxK7g1/7cGMU3CYkXG/ZIFSq4LBER32myH5IiFpqWXKCSWIU7oofhl
	3PLFiQXFuqRMzAAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00E20138A7;
	Fri,  6 Dec 2024 12:41:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XbBSO+TwUmfMRwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 06 Dec 2024 12:41:08 +0000
Message-ID: <c737d451-f8b9-47cc-a411-4b2ed349fab0@suse.de>
Date: Fri, 6 Dec 2024 13:41:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Remove namespace when nvme_identify_ns_descs()
 failed
To: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20241129140608.115282-1-hare@kernel.org>
 <Z09Y30pUtAg0xwoR@kbusch-mbp> <4ba05af4-9464-4cdf-a306-60585793c46e@suse.de>
 <Z1CF2vn1_xkNIVAM@kbusch-mbp> <99025917-e201-4ec9-ba04-e979f61c411b@suse.de>
 <Z1HRkKr5LhfvfLAs@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Z1HRkKr5LhfvfLAs@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 130952118D
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241206_044113_355504_44238FB7 
X-CRM114-Status: GOOD (  14.07  )
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

On 12/5/24 17:15, Keith Busch wrote:
> On Thu, Dec 05, 2024 at 01:30:39PM +0100, Hannes Reinecke wrote:
>> On 12/4/24 17:39, Keith Busch wrote:
>>>> 1) AEN triggers a rescan
>>>> 2) List of active namespace is retrieved
>>>> -> NSID A gets unmapped (or moved to another node in the cluster)
>>>> 3) Scan of NSID A returns an error with DNR set.
>>>> Without this patch we keep the namespace around, so eventually we'll
>>>> trip over the 'non-matching UUID' check once the NSID is reused.
>>>
>>> I'm still not sure that makes sense. The target shouldn't attach the new
>>> namespace until the host acknowledges the removal of the older NSID via
>>> the Namespace Change List log. Until the log is read, the inventory for
>>> removed namespaces should be latched. Otherwise, timing might remove+add
>>> a specific NSID before the host requests the NS Descriptor for the
>>> racing removal, then it would just get the "non-matching UUID" issue
>>> anyway.
>>
>> But we read the Namespace Change List log in step 2)
>> (Not that we're doing anything with it, but that's another story...)
>> Hmm?
> 
> Indeed. So maybe we should just move the log page retrevial *after* we
> scan the identify active namespace list processing?

Not sure how that would help. We are getting an 'ANA inaccessible' with 
DNR set status when retrieving the NS descriptor list for the namespace.
And this has to happen after we read the list of active namespace.
Perfectly legit, but doesn't tell us anything if the namespace is 
present at all.
All we know is that we cannot get information about that, and my 
argument is that we should treat this as equivalent to a namespace
not present.

And I really don't want to delay clearing of the AEN, as that would
open the door for us to miss subsequent AENs, getting even more 
out-of-sync with the target.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

