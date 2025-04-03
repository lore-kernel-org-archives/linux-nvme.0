Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3912C3601A
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 15:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DbldMzWR+jSwwjFa/jb3O/AoGTE7m3hG2QSt2j4NCJk=; b=sS51k04yrvan2YtQhhxYdUyq/I
	3fHxZboPevmJ14TtMCGGWUpyo1McVDlYSscJ16/GVZTVF2XQ/4IrmBjMwtMtt22I7hrvypGz6bmOJ
	dQzRun+bR3gPgAirCVM+OMiE+1t7jKT3HG8Tup7nFBkVeqGQQftPCz8Fzv0In85Jwr1A020EsCBMX
	n3PsnrGhJsQRsYH+/I7EaCOWicpuIvUNxstYxGxRCTk0NQ7nDZSCBmapzkVnm9UOSVJ/qmzjK6PEI
	2RrGB5lE/2fDPOXQ8QcK7Nxbk1JxY9VkxIRFWy03Lmuox/qv4gMbhrNYaxIrTPrINhLu/HHmDcvEr
	vg/2iL1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Mrb-00000009I4j-1RHJ;
	Thu, 03 Apr 2025 15:52:19 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0MrG-00000009I2u-1i9L
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 15:51:59 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AAE6D21168;
	Thu,  3 Apr 2025 15:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743695516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DbldMzWR+jSwwjFa/jb3O/AoGTE7m3hG2QSt2j4NCJk=;
	b=glCeElJLtmDtWdFcT3kza4WKh29CuNFqi25HGeWVEiV1x0nNvCDEhh0PyWZQyGdEcPhxDY
	z41YF6H/SV43f05KDh2vsuCuPHyPSnjnc8K1+/OMH++lGzO4ndOZE6QXJ4i/W+kjRd3UtD
	bZNw45HgZ1aWR35DqWxeAgM2N5xS0wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743695516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DbldMzWR+jSwwjFa/jb3O/AoGTE7m3hG2QSt2j4NCJk=;
	b=2rlXN0oXGU3vAaeUdX87sCCvoGllUxV+Ny0h0+gUyNxaj5w+JpYEL2uKKvvtTxvOZZC6V+
	u54nu/wqgNt86SDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743695515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DbldMzWR+jSwwjFa/jb3O/AoGTE7m3hG2QSt2j4NCJk=;
	b=PCk7XuZPW6tGTdEFvjenI/cyXevo0Soikrgu6+4PgznFHk+b2xP0qkK1tD57VlOClC9TLa
	Zzwxp0f2I4GljTu4dSvMN3DaJEMY5ACzbtHlL67wA11XhHjJKFTYRlImJ6V2AsUsNYiSXP
	Mr0zEYU5UqGgEBpVgPqyB2+hwlSS11E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743695515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DbldMzWR+jSwwjFa/jb3O/AoGTE7m3hG2QSt2j4NCJk=;
	b=KcpfQKyYoYO6PAhbfHoUIGqdU0+mq3EZvr4OBQLYryJx+Rrfhk+Z1OxP18tjZXwroFLwJB
	i7URtZc1khul6vAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70AEE13A2C;
	Thu,  3 Apr 2025 15:51:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0vM/Gpuu7mc0cQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 03 Apr 2025 15:51:55 +0000
Message-ID: <80565e9c-3cee-49e5-989f-296cff95ed4c@suse.de>
Date: Thu, 3 Apr 2025 17:51:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet: make 'readonly' setting configurable
To: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Lennart Poettering <lennart@poettering.net>
References: <20250403144747.43043-1-hare@kernel.org>
 <20250403144747.43043-2-hare@kernel.org> <Z-6s9_rE-qAmhn8w@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Z-6s9_rE-qAmhn8w@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_085158_610465_BCA72F81 
X-CRM114-Status: GOOD (  13.85  )
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

On 4/3/25 17:44, Keith Busch wrote:
> On Thu, Apr 03, 2025 at 04:47:46PM +0200, Hannes Reinecke wrote:
>> +static ssize_t nvmet_ns_readonly_store(struct config_item *item,
>> +		const char *page, size_t count)
>> +{
>> +	struct nvmet_ns *ns = to_nvmet_ns(item);
>> +	bool val;
>> +
>> +	if (kstrtobool(page, &val))
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&ns->subsys->lock);
>> +	if (ns->enabled) {
>> +		pr_err("the ns:%d is already enabled.\n", ns->nsid);
>> +		mutex_unlock(&ns->subsys->lock);
>> +		return -EINVAL;
>> +	}
>> +	ns->readonly = val;
>> +	mutex_unlock(&ns->subsys->lock);
> 
> Not sure how people feel about the "cleanup" constructs. If we're okay
> using them in this driver, this is a simple use case for the guard to
> manage the mutex:
> 
> 	guard(mutex)(&ns->subsys->lock);
> 
> And then you don't need to worry about unlocking.
> 
Sure, can do that.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

