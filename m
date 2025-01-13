Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E3BE7719E
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2025 07:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CPZHRdvIHwfn70FdbdUbsrDA+X1niLFcmEFoos3VATw=; b=mRUqjnIoSySNPL+OuhEM23oQq9
	3LBNYWTWA3TQCjqLcQK4Hmk/qOgOvkanYSmlYGGAr1+s9YJZZ0JBDMVcMtftIdQx9jONr4yIOI5Vx
	P99ZIZIdSDXS7kEmeEeZwdioM4I1vpCygJwjXC1+qn9mnh9sLzyBUPuqapVWe9/F45e+MIP+MtJT7
	gcMXpH1KQZKD4GbFoUGXZdt//w8MrAkPgvENMp21SLS6Ci7EZyYCvOfbvv0voaZHELs+due8mAq9q
	gdMoEB2cbADsdt7M0QmmZQdXnYr7SLKLBovP6UwNJYzikn7ReH5OE4gCHZzb6C3riXM78YT3OyGbK
	HpWpnzxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXFDn-00000004Ho7-0a3o;
	Mon, 13 Jan 2025 07:50:51 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXFDk-00000004Hnc-0wHj
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jan 2025 07:50:49 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B2DEF1F394;
	Mon, 13 Jan 2025 07:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736754646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CPZHRdvIHwfn70FdbdUbsrDA+X1niLFcmEFoos3VATw=;
	b=PZYFNv7CFmkaNYGP8TDCPyHsp/htROUSv8JjqJOQ3LvpYU9t2frpF1qqzCe8Y3xjpJyCVV
	rty7FLkVbci3Y59IJr3yiWV+n1Zt6UFMopS9WbUkhHK/y+MARk0Eo1pBMrmjkdpHBQ9tkb
	VVl3zrQRHTpwWs++eNwd9qZ4Lul7ih4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736754646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CPZHRdvIHwfn70FdbdUbsrDA+X1niLFcmEFoos3VATw=;
	b=16A6eNoMprzzt+Etd9SCS3ZI1DWXQQyxsNchLMgMzP0bjZOlIlvQEEjSlFse3JvgxkLqCx
	/30aMSMeJBQH/8CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736754646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CPZHRdvIHwfn70FdbdUbsrDA+X1niLFcmEFoos3VATw=;
	b=PZYFNv7CFmkaNYGP8TDCPyHsp/htROUSv8JjqJOQ3LvpYU9t2frpF1qqzCe8Y3xjpJyCVV
	rty7FLkVbci3Y59IJr3yiWV+n1Zt6UFMopS9WbUkhHK/y+MARk0Eo1pBMrmjkdpHBQ9tkb
	VVl3zrQRHTpwWs++eNwd9qZ4Lul7ih4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736754646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CPZHRdvIHwfn70FdbdUbsrDA+X1niLFcmEFoos3VATw=;
	b=16A6eNoMprzzt+Etd9SCS3ZI1DWXQQyxsNchLMgMzP0bjZOlIlvQEEjSlFse3JvgxkLqCx
	/30aMSMeJBQH/8CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EA5D13310;
	Mon, 13 Jan 2025 07:50:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U1HIHNbFhGfkNQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Jan 2025 07:50:46 +0000
Message-ID: <0e6dbc36-ce6f-46ba-9f35-c76562cbf42d@suse.de>
Date: Mon, 13 Jan 2025 08:50:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Remove namespace when nvme_identify_ns_descs()
 failed
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20241129140608.115282-1-hare@kernel.org>
 <f6229339-5b1f-47d5-8eb1-d11ed2fc2281@grimberg.me>
 <bb69b9b9-ad56-4c83-a848-a4b171896097@suse.de>
 <9cdb72d6-291f-46a1-8c80-45ceb75e2b8b@grimberg.me>
 <e3c2d261-c360-4ec4-9423-e5c9ffbd9758@suse.de>
 <77130bd8-5bc9-41f3-b4fc-ab41835850f7@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <77130bd8-5bc9-41f3-b4fc-ab41835850f7@grimberg.me>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250112_235048_410934_89F07AAB 
X-CRM114-Status: GOOD (  16.12  )
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

On 1/11/25 00:16, Sagi Grimberg wrote:
> 
> 
> 
> On 08/01/2025 17:45, Hannes Reinecke wrote:
>> On 1/8/25 11:49, Sagi Grimberg wrote:
>>>
>>>
>>>
>>> On 07/01/2025 10:11, Hannes Reinecke wrote:
>>>> On 12/25/24 10:58, Sagi Grimberg wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 29/11/2024 16:06, Hannes Reinecke wrote:
>>>>>> When a namespace gets unmapped on the target during scanning
>>>>>> nvme_identify_ns_descs() returns with a non-retryable error.
>>>>>> With the currrent code we will ignore that error on the grounds
>>>>>> that we failed to get information, and hence cannot make any
>>>>>> decisions whether to keep or remove that namespace.
>>>>>> But a non-retryable error implies that the namespace is _not_
>>>>>> present as we cannot retry that command and will never get
>>>>>> information about that namespace.
>>>>>> And we need to remove the namespace during scanning, as otherwise
>>>>>> the AEN informing us about a namespace change will find the NSID
>>>>>> present, but nvme_validate_ns() will fail, and the namespace
>>>>>> will never be updated with the correct information.
>>>>>
>>>>> Isn't that a bit harsh?
>>>>> I would expect to see a specific status line NVME_SC_INVALID_NS or 
>>>>> equivalent for a full removal of the namespace?
>>>>
>>>> Does it matter? If we get a DNR status back from 
>>>> nvme_identify_ns_descs() we _cannot_ resend that command.
>>>> Meaning we cannot get the namespace descriptors. As we
>>>> rely on these descriptors to properly map the namespace
>>>> we cannot correctly work with it, and we're better off
>>>> to pretend the namespace is gone and wait for an AEN
>>>> indicating that the namespace (or controller) state has changed.
>>>
>>> I think it does matter. I don't think we should be removing the NS 
>>> without
>>> the controller telling us that it is actually removed.
>>
>> But what would be the recovery action here?
>> If the 'identify ns descs' command cannot be retried, how are
>> we going to map the namespace to an ns_head?
> 
> Let's take a step back here. Can you describe the scenario you hit? what 
> was the error
> status that you observed?

See my reply to Nilay.

Target unmaps the namespace, and we get an AEN for 'namespace changed'.
We start a scan, but by the time we retrieve the list of namespaces the 
NSID has been reassigned to another namespace with a different UUID.
Then our stale namespace will be removed in nvme_validate_ns() and
not rescanned.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

