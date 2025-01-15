Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B2EC02183
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 08:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WYza0hgJoAaCGlidanYAaq+mYgyvILetbeH2/rdyMng=; b=CXoHk8m1bEGVHn4AoxYujYNHlZ
	4tlhQGvfmEUMQKLEn8Rd5HR0NpJZz8H1LZFBD/gapDZ0Tfmgzi6IhcsQ+X6hOJONS6lHHM8h0FtZg
	/wxYn68KQmcdLHUMfQ+5mKKTxzpU2OkNa1nXbk5rTWulSm69YjiTnPuiMeGMb18FImwsYCd59w0qz
	OCycrG4usdhT15nDQB8kSWFgQ2UVZClc1W/TnHrRZ4ujucLzaBaFE1kpkRcWVOQtaGSt4X8Xff2+A
	w9HQ7nH2nqSUufCRW6O36ODCjRrYQ82bMVa48BQiz3yP3r7Pf8SalxdNLNs/3Igb/AZSA5qhbHxBN
	5mmyyPeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXyM4-0000000B1N8-3asx;
	Wed, 15 Jan 2025 08:02:24 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXyM2-0000000B1Me-1hMh
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 08:02:23 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 068981F458;
	Wed, 15 Jan 2025 08:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736928139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYza0hgJoAaCGlidanYAaq+mYgyvILetbeH2/rdyMng=;
	b=xi/vUvGIvdM7DHrM0ESyPa83Nf6OaytnAJF/OGANcjqKfZdFPcXhUiCJHk2CFcHNKensQi
	0MsYw8smkrObydziDlYIQShomH2J/NpXqDfDsqyd+iVomhrAH52azlk1gbSEoMutFYdEBz
	qbEijR6srH+s8Txfv+4sf9IHnoewLGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736928139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYza0hgJoAaCGlidanYAaq+mYgyvILetbeH2/rdyMng=;
	b=u0MEAgD7InF0T89fmL1lZWN8upSErj4NFBbK+tGJt6VGsMKMvrL1CsRywC5+8OnR3ELt3v
	N12LCb0KsLDVNwDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736928139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYza0hgJoAaCGlidanYAaq+mYgyvILetbeH2/rdyMng=;
	b=xi/vUvGIvdM7DHrM0ESyPa83Nf6OaytnAJF/OGANcjqKfZdFPcXhUiCJHk2CFcHNKensQi
	0MsYw8smkrObydziDlYIQShomH2J/NpXqDfDsqyd+iVomhrAH52azlk1gbSEoMutFYdEBz
	qbEijR6srH+s8Txfv+4sf9IHnoewLGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736928139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYza0hgJoAaCGlidanYAaq+mYgyvILetbeH2/rdyMng=;
	b=u0MEAgD7InF0T89fmL1lZWN8upSErj4NFBbK+tGJt6VGsMKMvrL1CsRywC5+8OnR3ELt3v
	N12LCb0KsLDVNwDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2E9A139CB;
	Wed, 15 Jan 2025 08:02:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4o/5LYprh2eDcgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 15 Jan 2025 08:02:18 +0000
Message-ID: <7cd569e6-324a-45bd-b06b-754464806220@suse.de>
Date: Wed, 15 Jan 2025 09:02:18 +0100
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
 <f71a0a75-1a79-4d0f-803f-5eb8835252ef@suse.de>
 <c0f49aed-2f93-4b31-b768-e9e354c98d42@linux.ibm.com>
 <7aacb2fa-a7b9-4eb2-ad87-bdd24e1cd308@suse.de>
 <b7f55b77-1bb2-4a0d-8ad9-aa78dae72cf6@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <b7f55b77-1bb2-4a0d-8ad9-aa78dae72cf6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_000222_598624_30413534 
X-CRM114-Status: GOOD (  21.91  )
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

On 1/15/25 08:48, Nilay Shroff wrote:
> 
> 
> On 1/13/25 7:59 PM, Hannes Reinecke wrote:
>> On 1/13/25 15:12, Nilay Shroff wrote:
>>>
>>>
>>> On 1/13/25 1:13 PM, Hannes Reinecke wrote:
>>>> On 1/11/25 15:01, Nilay Shroff wrote:
>>>>>
>>>>>
>> [ .. ]
>>>> So my argument is that in this specific case the 'ANA inaccessible' nvme
>>>> state should _not_ be retried, but should be treated as identical to
>>>> 'invalid namespace' errors.
>>>>
>>> I think I got what you're trying to propose. So when this issue manifests, on host, if we
>>> could possibly differentiate between nvme_identify_ns_descs() failed reasons : is it failed
>>> because the nsid has been removed/un-mapped on the target or is it failed due to "ANA inaccessible"
>>> state? IMO, for "ANA inaccessible" status, we may not want to immediately remove the ns from
>>> the host (due to reason I mentioned earlier per NVMe spec section 8.1.3.3), however for the
>>> other error case we may remove the ns from the host.
>>> I think issuing ns descriptor list command to target for a nsid which doesn't exist on the
>>> target would return buffer filled with all zeros. So that might be an indication that ns has
>>> been removed from the target.
>>>    
>> But only if the NSID has not been remapped in the meantime.
>> If it has (as in my case) the ns descriptor list will be valid, it just
>> refers to another namespace.
>>
> If NSID has been unmapped and then remapped on the targer then in that case,
> host would hit the mismatch uuid case (under nvme_validate_ns()) and so host
> would then remove the namespace.
> 
> I think there are two cases,
> Case1:
> 1. AEN triggers rescan
> 2. List of active nsid is retrieved
> -> NSID A is removed on the target
> 3. Scanning of NSID A fails (i.e. nvme_identify_ns_descs() returns buffer filled with all zeros)
> -> host removes the respective namespace
> 
> Case2:
> 1. AEN triggers rescan
> 2. List of active nsid is retrieved
> -> NSID A is unmapped and remapped (possibly with different uuid) on target
> 3. Scanning of NSID A succeed
> 4. host finds the mismatch uuid for NSID A (i.e. nvme_validate_ns() fails)
> -> host removes the respective namespace
>   
Entirely correct.
But Case2 results in the new namespace never to be scanned, and not 
visible to the OS. Which is the error I'm fighting with.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

