Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48D7606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 07:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FvOpjJur;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XI+szojO;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DuRv8c0r;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XI+szojO;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DuRv8c0r
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=SH0Mwzi2Js4WHVw9Noto6S8RHc6TqrPrX38eRo/RRy4=; b=FvOpjJur4FyTPD
	H5tmvwwysVKi31c+MS1PpEy+XISGU6LfNquqSWQN03nuA+f+UEwFOaYjoKKQjwi+gbRFGXtkJBG9S
	ohQBqI/d86fbQfY/Ydnvhsl4m3NUeKNqaqHUrtAuKudxKJveLVom3ieyy+qvHBm+GgMgafiv4jrRs
	4vXFqFocdlpHdvrd+qj7M5iXDG2YFiKSkvnTCEF8Zaxfgf7dyhjjI9kUJR7LsNw0rm2OFbFsVEODA
	vwn5w/4pgg2SH2wVpj/UfKL6qrIrPI4GJGJDvZbvgP2MlPjGObhwmb4Uw/AhgJgnbvEyy48AHTpeC
	GGk5SlkfMU15cJswmsqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMgjo-0000000AyGW-07ei;
	Fri, 30 Oct 2026 07:09:20 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMgjl-0000000AyG7-0ueO
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 07:09:18 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 264DE223EA;
	Fri, 30 Oct 2026 07:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793344153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SH0Mwzi2Js4WHVw9Noto6S8RHc6TqrPrX38eRo/RRy4=;
	b=XI+szojOPwK2NAJhwY4YHFeTTbyfIxIW3pAWzPawwBHXae4xVEiWct9qkSZ25xpPJB6dsa
	WnKWtJTa2CAzoDrNYRGG6NHbw7exg61IHIVsD5Io7Uf9lLf/dcHFaawCLLBDHZSwVRXj6R
	4uqObCY4rgO/gJ+M/3hlUQ4VZITRRb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793344153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SH0Mwzi2Js4WHVw9Noto6S8RHc6TqrPrX38eRo/RRy4=;
	b=DuRv8c0rOBl9wOqDoZX7pZTkrLXjfT44h96aNP2AayNPRK+Ibi5vA284SC9jAMBtbQ8DPY
	U+856/BCTRlvGiCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793344153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SH0Mwzi2Js4WHVw9Noto6S8RHc6TqrPrX38eRo/RRy4=;
	b=XI+szojOPwK2NAJhwY4YHFeTTbyfIxIW3pAWzPawwBHXae4xVEiWct9qkSZ25xpPJB6dsa
	WnKWtJTa2CAzoDrNYRGG6NHbw7exg61IHIVsD5Io7Uf9lLf/dcHFaawCLLBDHZSwVRXj6R
	4uqObCY4rgO/gJ+M/3hlUQ4VZITRRb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793344153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SH0Mwzi2Js4WHVw9Noto6S8RHc6TqrPrX38eRo/RRy4=;
	b=DuRv8c0rOBl9wOqDoZX7pZTkrLXjfT44h96aNP2AayNPRK+Ibi5vA284SC9jAMBtbQ8DPY
	U+856/BCTRlvGiCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B825713419;
	Fri, 30 Oct 2026 07:09:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N1UOHJhC5Gp0SwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 30 Oct 2026 07:09:12 +0000
Message-ID: <7c9343a2-d69a-4215-b2c7-0d9d412c2e0d@suse.de>
Date: Fri, 30 Oct 2026 08:09:12 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] nvme-tcp: NIC topology aware I/O queue scaling and
 queue info export
To: Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, chaitanyak@nvidia.com,
 gjoyce@linux.ibm.com, linux-nvme@lists.infradead.org
References: <20261026123411.1988949-4-nilay@linux.ibm.com>
 <28fc7035-2beb-4f67-9a55-09b31d873608@flourine.local>
 <a9d3333f-3b70-45c7-ba79-7b441336415e@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <a9d3333f-3b70-45c7-ba79-7b441336415e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.29
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261030_000917_580761_F3E9F0CF 
X-CRM114-Status: GOOD (  19.75  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 5:59 PM, Nilay Shroff wrote:
> On 10/29/26 9:41 PM, Daniel Wagner wrote:
>> On Mon, Oct 26, 2026 at 06:03:21PM +0530, Nilay Shroff wrote:
>>> Following the feedback, the logic for determining the number of 
>>> fabric I/O
>>> queues (nr-io-queues) has been moved to userspace in nvme-cli [2]. As a
>>> result, the first two patches from the previous series, which 
>>> implemented
>>> this logic in the kernel driver, have been dropped. This series contains
>>> the remaining two patches, which export NVMe/TCP I/O queue information
>>> through debugfs to facilitate host-side network tuning.
>>>
>>> The first patch introduces debugfs helper functions that can be used by
>>> drivers to export debugfs attributes.
>>
>> What is the expectation, what's the use case here? Should this
>> information be available in a productive system? In this case debugfs
>> might not be the right choice.
> 
> Ideally, this information should be available on production systems to
> facilitate network stack tuning.
> 
> Would you recommend exposing it through sysfs rather than debugfs? During
> the last LSFMM, I received feedback suggesting debugfs, so I implemented
> the interface accordingly in this patch series. However, I'm open to moving
> it to sysfs if we agree that it is the more appropriate interface.
> 
Hmm. This matches what netdevs do with their tx/rx queue mapping, and 
that is in sysfs. Typically I would prefer debugfs for this, but here
I really don't mind as it's somewhere in the middle between generally
useful and being a niche usecase.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

