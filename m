Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC44CCF9F1
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Oct 2025 09:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7//DUXe6LBiO9vclse2pTn19jG2ifhfk88y7uBZhmRE=; b=b4qQ+N98a/TvTZ4u1WIwRJFpVX
	puQfiLAikL/5om6ezVIZJ2+lcN2CSD1WlgWJv02pkCYSiS2Fx/Yay1M55pWOGrzMWV05tIjLlMqyS
	tSiJR43l8OmkCwJ8U/U71ppSOZwBspDH/2BCGqAgRF9r7DwHdDnBDOFn6sv5zM15jYkoe/qxGHdI1
	/RqsS+3V8bkLhC1IGp1xYJpJwwD6gDU00wS7Wsg+Fx5xKs31G6UVOArWhszUwWcaP/U/0DuQe04aX
	km1j1OkVtuE58nRHL2+8vunpAJu5ePB0PAsWnRUPRGkq/aXHSKldGAocgv5HNl+1w36Z5LqkottRS
	NM6tljvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEPE8-00000003tBA-2Pnk;
	Thu, 30 Oct 2025 09:45:52 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEPE5-00000003tAA-3NwY
	for linux-nvme@lists.infradead.org;
	Thu, 30 Oct 2025 09:45:51 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 830031F7CA;
	Thu, 30 Oct 2025 09:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761817546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7//DUXe6LBiO9vclse2pTn19jG2ifhfk88y7uBZhmRE=;
	b=m2in7CiTIzapR2qu6RZlXJfcIIcLt1qDGfvF1gTEbCBkMNCu3Zps5D57RRItZ9yLLBqZ07
	xdAz7KMTZLs09x6rsdzb+w90JXoCvojGtzThfvYPItMosuUQyZ6YVBZJ2B5IRmcdhPi4G9
	71W5Cpa7UREKkcASz/jiBY/T6D7YeTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761817546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7//DUXe6LBiO9vclse2pTn19jG2ifhfk88y7uBZhmRE=;
	b=QYkEOxtp+LCQrhuEedB+A8ZnpgaZ61SdL0zng+cHRUT1cxpJOY8q9ULEV5s9FQm1E3EqMV
	+RQ8P7zJC7wypiCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761817546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7//DUXe6LBiO9vclse2pTn19jG2ifhfk88y7uBZhmRE=;
	b=m2in7CiTIzapR2qu6RZlXJfcIIcLt1qDGfvF1gTEbCBkMNCu3Zps5D57RRItZ9yLLBqZ07
	xdAz7KMTZLs09x6rsdzb+w90JXoCvojGtzThfvYPItMosuUQyZ6YVBZJ2B5IRmcdhPi4G9
	71W5Cpa7UREKkcASz/jiBY/T6D7YeTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761817546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7//DUXe6LBiO9vclse2pTn19jG2ifhfk88y7uBZhmRE=;
	b=QYkEOxtp+LCQrhuEedB+A8ZnpgaZ61SdL0zng+cHRUT1cxpJOY8q9ULEV5s9FQm1E3EqMV
	+RQ8P7zJC7wypiCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57BE71396A;
	Thu, 30 Oct 2025 09:45:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zQdzFMozA2luBQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 30 Oct 2025 09:45:46 +0000
Message-ID: <e26aecb0-ed6c-4454-b19d-0a024de1506d@suse.de>
Date: Thu, 30 Oct 2025 10:45:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: split host and target nvme_auth_extract_key
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 kernel test robot <lkp@intel.com>
References: <20251029145745.3723258-1-kbusch@meta.com>
 <20251030060155.GA12793@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251030060155.GA12793@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,intel.com:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251030_024550_013371_5D07BC73 
X-CRM114-Status: GOOD (  14.99  )
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

On 10/30/25 07:01, Christoph Hellwig wrote:
> On Wed, Oct 29, 2025 at 07:57:45AM -0700, Keith Busch wrote:
>> From: Keith Busch <kbusch@kernel.org>
>>
>> The host and target share common code, but the config allows you to
>> disable support for one and not the other. When support is disabled, a
>> stub implementation needs to be used, but that would clash with the real
>> implementation that the other relies on.
>>
>> Split the host and target implementations into uniquely named stub
>> functions that either call the real implementation or return an error if
>> their config option is disabled.
>>
>> Fixes: f59ae5c9e356b5e ("nvme: parse dhchap keys during option parsing")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202510100105.cibujuUJ-lkp@intel.com/
>> Signed-off-by: Keith Busch <kbusch@kernel.org>
> 
> This seems a bit backwards.  How about dropping the stub entirely
> and guard the calls with IS_ENABLED or if needed ifdefs instead?
> 
Tried this once, but then ran into the same issue with one side being
modular and the other side being compiled in.
Can't we just fiddle with config magic to require 
CONFIG_NVME_TARGET_AUTH and CONFIG_NVME_HOST_AUTH
to either be disabled or having the same type
(eg _either_ Y or M). Hmm?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

