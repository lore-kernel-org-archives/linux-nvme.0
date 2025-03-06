Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0364C282D1
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Mar 2025 07:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=btwXWJeiuH6RkYwrUlziz8O8gADeHxdSBWZsmqwxI20=; b=3U7+rZneNo+vqpfFAHNcbmc3DY
	Y2VhgINIcr1kVr/6PqJx7h3gV5nEKf7BtZJsdc3PeVmHk0O7rAJQNWhDiv4kOKUf15fOjfp5QoFg5
	hYWbQ06IfWFU+a5FINZYauqlf0vKzIQ9sMkm7yVbtads2vaIm7yWg6dHu21IMiLmtTFYJOzGTs+EJ
	dSl0qNTfylx8EfhrCcbJZrGNSUixPKUMvcbsCrhAqisQeKhMoDTJ+dDMEDD5pAv9wFfv6eEnXl+WK
	YCBIdZi80/XVTkSvHAP/9gZ6Oku9D8MSgSGJYBci1ebNI6KPtgFQ0o6J5ExMhlnmyRoK240R1BxEY
	1u4u9vrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tq5QP-0000000ABKY-2ZDd;
	Thu, 06 Mar 2025 07:13:45 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tq5Ou-0000000ABCU-2nrr
	for linux-nvme@bombadil.infradead.org;
	Thu, 06 Mar 2025 07:12:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=btwXWJeiuH6RkYwrUlziz8O8gADeHxdSBWZsmqwxI20=; b=ilfjEsfxq/123eMSrQ34aRbAlc
	uRdGVO+Up7nFS/gtxZQz3Xvw0Y8JC346Qwci1HX46e1YlY00L6ZPWSLtTqs4vwbJL2uE+9Wc6BPdd
	lNuHc8NMlo/8dUrXqaDSdXmN4PONZ60sYpNlcoMZZukpv4bbEhuuDtg3bAdaSJlclmCndxYaQ+R3s
	MbLv/Mbf+3YZtPOReHteAxwLxhvauLWrQu4MQJADUq/HgCdwQaKaFVQp5+USi9xcx6+KrSQltRjHb
	grKBvBQ77IQ+ecS7Dd7VK5IM6GlaCRhjtz7s+M9Cnexygrl/FyI2acvQSHcPR0ygBmec+jl/sd/NH
	pbhTvXvw==;
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by casper.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tq5Or-00000006yej-2Dd4
	for linux-nvme@lists.infradead.org;
	Thu, 06 Mar 2025 07:12:11 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8898421197;
	Thu,  6 Mar 2025 07:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741245125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btwXWJeiuH6RkYwrUlziz8O8gADeHxdSBWZsmqwxI20=;
	b=NUj1C150ROtfb0iZ36i67LHLiHH1eEabFacd/bXWJByThNGFmryJwibIBuaF3VgBL2YiR4
	wORKlBKUHjrqTlXtBYWMPBkxdsF6QfFjOK76DYIQQWQWGXFJKUMIShJS8dvKwFSuTRgHC9
	sCzax4Jt9z31HwZNbc/Z+BGL0g5A9aE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741245125;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btwXWJeiuH6RkYwrUlziz8O8gADeHxdSBWZsmqwxI20=;
	b=YNfY1JPxqvEGDwpGH3kW4pYy7R6CrxSV+7ILxcGHbCTQSE/IeAKyVR96bTXan7VKsknDBq
	oHiYRRlk4La25uDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NUj1C150;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YNfY1JPx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741245125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btwXWJeiuH6RkYwrUlziz8O8gADeHxdSBWZsmqwxI20=;
	b=NUj1C150ROtfb0iZ36i67LHLiHH1eEabFacd/bXWJByThNGFmryJwibIBuaF3VgBL2YiR4
	wORKlBKUHjrqTlXtBYWMPBkxdsF6QfFjOK76DYIQQWQWGXFJKUMIShJS8dvKwFSuTRgHC9
	sCzax4Jt9z31HwZNbc/Z+BGL0g5A9aE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741245125;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btwXWJeiuH6RkYwrUlziz8O8gADeHxdSBWZsmqwxI20=;
	b=YNfY1JPxqvEGDwpGH3kW4pYy7R6CrxSV+7ILxcGHbCTQSE/IeAKyVR96bTXan7VKsknDBq
	oHiYRRlk4La25uDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C71D13A61;
	Thu,  6 Mar 2025 07:12:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YUgnIMRKyWfAaQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 06 Mar 2025 07:12:04 +0000
Message-ID: <1ffebf60-5672-4cd0-bb5a-934376c16694@suse.de>
Date: Thu, 6 Mar 2025 08:12:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 John Meneghini <jmeneghi@redhat.com>, bmarzins@redhat.com,
 Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
 axboe@kernel.dk
References: <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com>
 <Z7TARX-tFY3mnuU7@kbusch-mbp>
 <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com>
 <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me>
 <Z7dct_AbaSO7uZ2h@kbusch-mbp> <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de>
 <20250305141554.GA18065@lst.de> <Z8hrJ5JVqi7TgFCn@kbusch-mbp>
 <20250305235119.GB896@lst.de> <Z8jk-D3EjEdyBIU5@kbusch-mbp>
 <20250306000348.GA1233@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250306000348.GA1233@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8898421197
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_071209_648333_1DB3813A 
X-CRM114-Status: GOOD (  12.08  )
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

On 3/6/25 01:03, Christoph Hellwig wrote:
> On Wed, Mar 05, 2025 at 04:57:44PM -0700, Keith Busch wrote:
>>>> Obviously he's not talking about multiported PCIe.
>>>
>>> Why is that obvious?
>>
>> No one here would think a multiported device *wouldn't* report CMIC.
> 
> I hopes so.
> 
>> The
>> fact Hannes thinks that's a questionable feature for his device gives
>> away that it is single ported.
> 
> Well, his quote reads like he doesn't know about multiport PCIe devices.
> But maybe he just meant to say "despite being single-ported"
> 
Single ported.
There is a range of Samsung NVMe where one is a normal, single ported,
NVMe, and one with a nearly identical model number reporting CMIC.

Causing _quite_ a lot of confusion with the customer (and L3) when
used under MD, as for the first hotplug works, for the second ... not so 
much.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

