Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F5BE7716B
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Dec 2024 07:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=51Sk1uDiezXDt8F/1vJscvx4Wer82byOvjCOXuETr2o=; b=4I0R+bDzP/IOkkFUnGZhrnuk53
	grf6qzyGkhlqB/HadfnVTs/qDqRQlYyG4ttKD5VY6ARBmgeAm8RnEXRsM4VhWLDxCsjU3wD6GxQmM
	ln1RmqjVMaXlYBwRRF1Er0FyP5XfP83luw206FZ5c5blR1O+pl4yfhLULSBJlOmg6AQqkxPkIan5t
	9O+sav22Fdl3bDwOxfxllyJSg4Yc3Zv547zhedI/RO3OvH8AjQfYD3atjx+qcpeBv+pi1U+ZADftf
	6tyx5o+L99nf2z4WZmdULQJ1cS2a++NeKjqcLoCGhgnTmAELmUJdQ9j1fmpwc7DACxshivqS2/xf+
	XX5N+/WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIjaR-0000000BgUr-3QWw;
	Wed, 04 Dec 2024 07:14:15 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIjaP-0000000BgUM-2xpJ
	for linux-nvme@lists.infradead.org;
	Wed, 04 Dec 2024 07:14:14 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5292A1F44F;
	Wed,  4 Dec 2024 07:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733296450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=51Sk1uDiezXDt8F/1vJscvx4Wer82byOvjCOXuETr2o=;
	b=l8XuwmDvL6EUO6YMEn3oarq1FHyNC2fm1CB7STM7wxTGmF0VbFfmZLh/oh1ZVJxkcnvgTt
	2N9tSBZx/9c+S1vSAsWmImK86cXR7gSAr64J2uXkhjHCT6rNOnphcXXUy4kd+ZrkgQyp1T
	j3vWi1k+PO/HCrqgOsyCotBPIBWcDCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733296450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=51Sk1uDiezXDt8F/1vJscvx4Wer82byOvjCOXuETr2o=;
	b=up2MOSxHFp4K3V6KGF59dRxGamwHPnDlX34lOHAK1OVEWipbc2GFz5RUSpZY1OE9D04klf
	ImPV2q8I6EC8/YAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733296449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=51Sk1uDiezXDt8F/1vJscvx4Wer82byOvjCOXuETr2o=;
	b=D+L+qab9hEscfIMvfobKATfTqpMwTJ5GLdTjYQi+34+E/wg53aLd6R4twQB/yTCJrLkF6M
	UyBXSXDV5xQDdIG4kqWuW43fNgztUPCyCl5uApO2uszDE3S6WazKwN8Lre3BOoM2OnSBGW
	OSPqzlsfiUnISJlqqaMyKJaqPZiLr1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733296449;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=51Sk1uDiezXDt8F/1vJscvx4Wer82byOvjCOXuETr2o=;
	b=5ZyGFFLyROYTEU/3Axv+I5gmycZ5ehT8xSTTRfbciBGzFRByTQf962IAzfBCkm6EdfiI5i
	RvOgL5lT6XEhgVCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21959139C2;
	Wed,  4 Dec 2024 07:14:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3KNBBkEBUGfCRAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 04 Dec 2024 07:14:09 +0000
Message-ID: <4ba05af4-9464-4cdf-a306-60585793c46e@suse.de>
Date: Wed, 4 Dec 2024 08:14:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Remove namespace when nvme_identify_ns_descs()
 failed
To: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20241129140608.115282-1-hare@kernel.org>
 <Z09Y30pUtAg0xwoR@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Z09Y30pUtAg0xwoR@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241203_231413_891704_F44F178D 
X-CRM114-Status: GOOD (  13.49  )
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

On 12/3/24 20:15, Keith Busch wrote:
> On Fri, Nov 29, 2024 at 03:06:08PM +0100, Hannes Reinecke wrote:
>> When a namespace gets unmapped on the target during scanning
>> nvme_identify_ns_descs() returns with a non-retryable error.
>> With the currrent code we will ignore that error on the grounds
>> that we failed to get information, and hence cannot make any
>> decisions whether to keep or remove that namespace.
>> But a non-retryable error implies that the namespace is _not_
>> present as we cannot retry that command and will never get
>> information about that namespace.
>> And we need to remove the namespace during scanning, as otherwise
>> the AEN informing us about a namespace change will find the NSID
>> present, but nvme_validate_ns() will fail, and the namespace
>> will never be updated with the correct information.
> 
> The scanning only checks namespaces returned in the "active" namespace
> list. Every namespace not in the active list gets removed already. Why
> is this unmapped namespace appearing on the active list?

Timing. Imagine a system used as a backing store for kubernetes, where 
namespaces come and go at a _really_ fast pace.
1) AEN triggers a rescan
2) List of active namespace is retrieved
-> NSID A gets unmapped (or moved to another node in the cluster)
3) Scan of NSID A returns an error with DNR set.
Without this patch we keep the namespace around, so eventually we'll
trip over the 'non-matching UUID' check once the NSID is reused.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

