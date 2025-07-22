Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9423C83F25
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jul 2025 07:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sqhSEHDBYGdPkuyTz2kaUvUc+Mtf+Kq/Ye+ffap9784=; b=O8vxax3GOrDW0+b0L7eFO8kFzV
	mjQSDTFWE9wv+NLD+OxLLBpGOhgVcxuAgKid81PeXnt8O4aEZJ/Go4TAxSTugzgF+3t7E82c/YNnE
	RNhr4KOLoWCOlbwZFAw81hxaCuTtREsBVjRc4euxhm2TmW7coZhHQkFKyptT4Vf3OTjTxadBNsSDs
	/xmnWR4fR+3h+CzKpLBVkJlibT9YDPTiwGYLI+LbNvAXKUtB8GxelenhQWKLXUCQx4TwI66uHaOm8
	S6D7HwdyUbYOIYiSRq9XKAXYdcwpXJwda6jdWD06OfQh7O93QtnFu8zf/FrtK5JifAz0NWDpQOa3b
	4zDwHB0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue6zD-00000001X9u-3u5L;
	Tue, 22 Jul 2025 07:00:27 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue6zA-00000001X9A-3bl2
	for linux-nvme@lists.infradead.org;
	Tue, 22 Jul 2025 07:00:26 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 383DE210F3;
	Tue, 22 Jul 2025 07:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753167623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqhSEHDBYGdPkuyTz2kaUvUc+Mtf+Kq/Ye+ffap9784=;
	b=1C/g2u7c0OtMF4p69F9GML9LH3DnthTcBzIGLgs24Htk2P/RYkGHcd7XilidcLz8Bv0MWN
	rn0fDoOY/Z0+/8JrMyxzR4EhB1mkOloCpGTzHKjCDEGDon7KXCBc2ksDuP4kv2CovXDIZC
	8ZFsE1hjf7CfNcPZeeVBVPWNapb9MVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753167623;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqhSEHDBYGdPkuyTz2kaUvUc+Mtf+Kq/Ye+ffap9784=;
	b=lSbAHEioFH2rB25ep+FuAeSvKmXeFnfR8jqa8JZbOIsRkIpXBJRP/rMXMF6WALXF/E2umV
	dOUC8D7CdQQG6aAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="1C/g2u7c";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lSbAHEio
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753167623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqhSEHDBYGdPkuyTz2kaUvUc+Mtf+Kq/Ye+ffap9784=;
	b=1C/g2u7c0OtMF4p69F9GML9LH3DnthTcBzIGLgs24Htk2P/RYkGHcd7XilidcLz8Bv0MWN
	rn0fDoOY/Z0+/8JrMyxzR4EhB1mkOloCpGTzHKjCDEGDon7KXCBc2ksDuP4kv2CovXDIZC
	8ZFsE1hjf7CfNcPZeeVBVPWNapb9MVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753167623;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqhSEHDBYGdPkuyTz2kaUvUc+Mtf+Kq/Ye+ffap9784=;
	b=lSbAHEioFH2rB25ep+FuAeSvKmXeFnfR8jqa8JZbOIsRkIpXBJRP/rMXMF6WALXF/E2umV
	dOUC8D7CdQQG6aAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D68F413A32;
	Tue, 22 Jul 2025 07:00:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qOG/MgY3f2jCcQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Jul 2025 07:00:22 +0000
Message-ID: <da450263-9944-45d0-aa58-f4f606f88c6a@suse.de>
Date: Tue, 22 Jul 2025 09:00:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: check duplicate unique identifiers in order
To: Keith Busch <kbusch@kernel.org>, John Meneghini <jmeneghi@redhat.com>
Cc: Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, mlombard@bsdbackstore.eu
References: <20250509151627.20434-1-bgurney@redhat.com>
 <aB4gO7mAYDO3Bm3A@kbusch-mbp>
 <cec53fce-2f1d-4162-8685-ab7c56649953@redhat.com>
 <aCId7XmLnrLWZPdk@kbusch-mbp> <aFrBVeEcapNtOvPx@kbusch-mbp>
 <1352e125-180b-4ec9-ac3e-1cd8570910a3@redhat.com>
 <aHasJPv2Jb4bQ3ik@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aHasJPv2Jb4bQ3ik@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 383DE210F3
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250722_000025_070552_161349B9 
X-CRM114-Status: GOOD (  16.75  )
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

On 7/15/25 21:29, Keith Busch wrote:
> On Tue, Jul 15, 2025 at 03:01:59PM -0400, John Meneghini wrote:
>> On 6/24/25 11:16 AM, Keith Busch wrote:
>>> On Mon, May 12, 2025 at 10:12:29AM -0600, Keith Busch wrote:
>>>> On Mon, May 12, 2025 at 11:18:58AM -0400, John Meneghini wrote:
>>>>> On 5/9/25 11:33 AM, Keith Busch wrote:
>>>>>
>>>>>> If those are not unique, they need to be blanked out to make sure we don't
>>>>>> expose these on the namespace's sysfs attributes.
>>>>>
>>>>> OK, we can add another patch that blanks out the lower precedent/invalid IDs.
>>>>>
>>>>> Will that work?
>>>>
>>>> I think you'd have to blank out the non-unique ones, otherwise the
>>>> driver would export them.
>>>>
>>>> And while I think that might work, this proposal didn't go over so well
>>>> last time it came up:
>>>>
>>>> https://lore.kernel.org/linux-nvme/20250414111916.GB13225@lst.de/
>>>
>>> I've recently encountered some devices with this behavior, from machines
>>> hosted by various cloud providers. I had to pull in something
>>> out-of-tree like the patch here just to get things going. I think we
>>> should have the kernel discard lower priority fields.
>>
>> OK good I will ask Bryan to resubmit this as a version 2 patch.
>> We can add another patch that blanks out the lower precedent/invalid IDs in sysfs so that only the unique IDs are reported.
> 
> Note, it's not me who needs convincing.
> 
> FWIW, this is what I'm running with. There's just some extra care here
> to ensure we refresh sysfs attributes as needed, as well as prevent
> repeatedly spamming the kernel messages with the same error.
> 
Ah, so you got another one?

We got one, too (which is essentially that one posted on the mailing list).

If we now can get Oracle to chime in (maybe with a different patch
altogether?) we have all major vendors implementing different fixes
for the same problem.

Fun ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

