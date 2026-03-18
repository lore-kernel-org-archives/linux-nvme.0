Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7321FCD0CC
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2026 08:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kCbnlaQudlIsy7QhAeyRpK37Ynr97AgA+v1dSnVLdAI=; b=4g0DGl+cR2SoWrlrl87Bgpf+6C
	OQVYAaxTs49wRMjFzJIhnJUG6FwRg4EM9E1zkohsSNPfPHkcKuQJqBDGAELpQMCC/2MYW2Ah0BWzr
	We2cAksDxa/YNoqGlLz+FRhV2OxwW8RN/xpntuRFGln+vzZ7m8Nwvtzl3zCbAwPSLoAKTFiMEVJ+j
	gsaEznmEK+HdbrINGao8REyw1CEIbC4ug4lQvmvc2ALe2x5NOKB2QxV47B1fWRyo+jZN9j1aOjSoR
	sZ7Ry5V5jjJh/vcBXRxNvynaAqLQ9bvOWBI50KDsxDGM3kuSGSLcKb3GMcPTv6g4X08ApzjAMg8Uh
	ZsuYQ2oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2m6Z-000000082Bx-2fct;
	Wed, 18 Mar 2026 08:18:15 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2m6X-000000082BM-1D5u
	for linux-nvme@lists.infradead.org;
	Wed, 18 Mar 2026 08:18:14 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 524DC4D3E2;
	Wed, 18 Mar 2026 08:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773821889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kCbnlaQudlIsy7QhAeyRpK37Ynr97AgA+v1dSnVLdAI=;
	b=ZFQ5mvtZ4rWmECM4UrHU8/4DaCYAhgTCXT3taENC905Iqy0khCUupX04aXBO+LW2ICOnd5
	N/cDwmzZrJ8AcpD/U4sjBsY9JF3lT6cHZGMv7Cdighgw3sXOz9j8yuTnc2nAplesoB15Ba
	58F2HbdnsA9gyjus5gxCsSW984FVWec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773821889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kCbnlaQudlIsy7QhAeyRpK37Ynr97AgA+v1dSnVLdAI=;
	b=zuZVbDwMAQwtdnMgdSa4cQ8ZZ0xalzdavrrC2u1XvtPIEcg8mfe9wT3VzAfht2XB+p+TFJ
	Y8S+U393Zx0uIlCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773821889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kCbnlaQudlIsy7QhAeyRpK37Ynr97AgA+v1dSnVLdAI=;
	b=ZFQ5mvtZ4rWmECM4UrHU8/4DaCYAhgTCXT3taENC905Iqy0khCUupX04aXBO+LW2ICOnd5
	N/cDwmzZrJ8AcpD/U4sjBsY9JF3lT6cHZGMv7Cdighgw3sXOz9j8yuTnc2nAplesoB15Ba
	58F2HbdnsA9gyjus5gxCsSW984FVWec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773821889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kCbnlaQudlIsy7QhAeyRpK37Ynr97AgA+v1dSnVLdAI=;
	b=zuZVbDwMAQwtdnMgdSa4cQ8ZZ0xalzdavrrC2u1XvtPIEcg8mfe9wT3VzAfht2XB+p+TFJ
	Y8S+U393Zx0uIlCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 168974274D;
	Wed, 18 Mar 2026 08:18:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7snzA8Ffumn1YwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 18 Mar 2026 08:18:09 +0000
Message-ID: <fd8dc843-d349-42cf-90e4-37fed259d460@suse.de>
Date: Wed, 18 Mar 2026 09:18:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: libnvme API review
To: Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <d5b9ca7f-8fd1-48ea-a883-79e92d92ec7e@flourine.local>
 <f1c18ac3-6c1a-44e5-907e-e2d804b0d0aa@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <f1c18ac3-6c1a-44e5-907e-e2d804b0d0aa@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_011813_511409_D020F825 
X-CRM114-Status: GOOD (  28.48  )
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

On 3/18/26 09:01, Nilay Shroff wrote:
> On 3/16/26 3:57 PM, Daniel Wagner wrote:
>> Hi,
>>
>> For the upcoming v3.0 release of nvme-cli and libnvme, I would like to
>> get some feedback on the naming scheme used in the libnvme function API.
>>
>> The goal is to improve consistency across the library. Below is a table
>> comparing the current names with the suggested new names.
>>
>> Functions are grouped by common prefixes:
>>
>> - Generic top-level functions use the nvme_ prefix.
>> - Object-specific functions use the object type as a
>>    prefix (e.g., nvme_ns_).
>>
>> The prefix is typically followed by a verb, such as nvme_create_ctrl.
>>
> Following the verb after the prefix looks good to me, as it aligns well
> with the kernel naming style. While aligning fully with the NVMe spec
> API would likely require a significant amount of cleanup, improving
> consistency within libnvme is definitely a step in the right direction.
> 
> Since we are already considering API changes for the 3.0 release, I’d
> also like to raise another point regarding non-cached variants of some
> APIs (perhaps only for a subset where it makes sense).
> 
> Currently, most libnvme APIs return cached values for attributes. While
> this is efficient, there are cases where a real-time view (for instance,
> nvme-top) is required. For example, retrieving the current ANA state or
> I/O policy may not be accurate if we rely solely on cached data (e.g.,
> nvme_path_get_ana_state() or nvme_subsystem_get_iopolicy()).
> 
> To address this, I’d like to propose introducing non-cached variants of
> selected APIs, for example:
> 
> nvme_path_get_current_<attribute>
> nvme_ctrl_get_current_<attribute>
> nvme_ns_get_current_<attribute>
> nvme_subsystem_get_current_<attibute>
> 
> where <attribute> could be path ana_state, iopolicy, or other
> attributes where fetching the latest value from the device or kernel is
> important.
> 
> Does this approach (naming) make sense?
> 
> One another approach would be to always return the current/non-cached
> value using existing API and then we don't need new API. I think this
> could be reasonable considering the existing nvme-cli commands are
> typically oneshot, and so it doesn't matter whether we return cached
> or non-cached value.
> 
> Alternatively, are there better naming or design approaches for
> distinguishing cached vs real-time queries?
> 
This is actually part of a wider-ranging challenge: lifetime
of structure elements.
While we do have abstractions like 'nvme_ctrl', 'nvme_subsys',
and the like, most of the settings in these objects are typically
read-only, and can only be set when the object is instantiated
(ie read from sysfs).
So we either need to find a way to set the scope of individual
settings (via __attribute__ or something), or we split the
structures into one structure used for _creating_ an object,
and declare the object itself readonly once created.

I've raised in issue in github
(https://github.com/linux-nvme/nvme-cli/issues/3192)
to discuss it there.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

