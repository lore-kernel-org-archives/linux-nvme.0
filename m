Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2266FCD3420
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2024 12:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DqNZO5VR7+lLuHwxMNLilXwMysqxXswwKuL23irDzTU=; b=zkPt3tmfBnq8AO0RssA0eqAkMp
	hLhI+IF28gZJA8brRQK+HJaSqU3yHafvhyXNCRCGNhV3ipI1344XQVdtomMmcMAdw0v+jcptlth96
	lve2wWIFicrQTlKLJA4bsnh00zJm+ZS1JmLonA5ozFQpqOw462HqVZADTVZNEHbsPk0wMruXUhpDe
	uenPs401dPQ+pFscePgBXtbegOWS0CHWBPqguB5PwESBjnf0p/ZaAu1tQjFJlkZzwJVZuo2Nu56J0
	ff2HTl7zZsW2WmCHTUBDv2CttHdUWTUy3YdPeFyP0MUYh6NzPxLv26JhygGrwFs/6gySAVsDKh5ZD
	KnkwGZOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slSgD-00000000AY0-3STR;
	Tue, 03 Sep 2024 12:30:41 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slSg8-00000000AWn-0zdq
	for linux-nvme@lists.infradead.org;
	Tue, 03 Sep 2024 12:30:39 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2305C1FD01;
	Tue,  3 Sep 2024 12:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725366633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DqNZO5VR7+lLuHwxMNLilXwMysqxXswwKuL23irDzTU=;
	b=XaEChFp5NOyOTxVZ2qREtXojgNb5PT/Px8ZIHOkzIHJN2xBPCWJjQAKF2NS9ETxR+6ZMfm
	na2TcwE1Y+p/FqXL0nKbeZ0RqII35EwQxa1+1fr7Vay7x1OrZgNOSJx5dV0ycnrEXV3O+K
	Ns/IWaqBaJgmfnuYjLQpGwAoMkr5v0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725366633;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DqNZO5VR7+lLuHwxMNLilXwMysqxXswwKuL23irDzTU=;
	b=jkgE276WXAKa/o03dtoNz0ZrYdr6+iuwXKg2s31d3AsLGnVjPhQ+VVRRgEMk0RTIua37Vx
	Onstc+4RvCvrd8AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725366632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DqNZO5VR7+lLuHwxMNLilXwMysqxXswwKuL23irDzTU=;
	b=xZeXH4bo8h5/2F+IyWvbHcHgOELFOfhDrTfpGDPhXmlgaPKexRTIsE8gI5Q3MFRg1kh4rx
	XaeJSiWmHAuEkgsuU7RIKfKM7xQVxTjs/KwQQ9D/SGkbeBNlFZJ2vzxN+GBX4rYIvZq1tK
	KwL2KniF0EMKFgUBErk5YOgDprkU8C8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725366632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DqNZO5VR7+lLuHwxMNLilXwMysqxXswwKuL23irDzTU=;
	b=EDVpLCItabcFW9RTgUIo+0JPM55nMF0HFc90XyEiOYARdLDVfKAjA8/Y9KUnTyosoQavwc
	ntVXpfhWhdVh3SDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1168413A80;
	Tue,  3 Sep 2024 12:30:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 42CVA2gB12bZNQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Sep 2024 12:30:32 +0000
Message-ID: <0c0bdfce-4ec7-4d65-8640-6e1277c7fd36@suse.de>
Date: Tue, 3 Sep 2024 14:30:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] nvme: remove existing namespace on ID mismatch
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240902111548.41430-1-hare@kernel.org>
 <20240902111548.41430-5-hare@kernel.org>
 <807a6a3d-7da4-4c1c-9299-111172d63cd2@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <807a6a3d-7da4-4c1c-9299-111172d63cd2@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
X-CRM114-CacheID: sfid-20240903_053036_594354_6F77B908 
X-CRM114-Status: GOOD (  19.48  )
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

On 9/2/24 19:01, Sagi Grimberg wrote:
> Again, patch title should describe what it is fixing.
> 
> 
> On 02/09/2024 14:15, Hannes Reinecke wrote:
>> When the namespace IDs mismatch during rescan we clearly ran out of
>> sync with the target,
> 
> Not clear at all. When can this happen and how?
> 
>>   but we really can't know whether our local copy
>> of the NSID is correct, and that one found by scanning is not.
>> But clearly something is wrong with the namespaces, so we should remove
>> the existing one, too, to avoid accidental data corruption.
> 
> Umm. So you see a bogus ns and conflicting with another ns which is
> seemingly fine and you remove it?
> 
> I feel like you are describing something "generically useful/correct" 
> while you address
> a very specific problem but you don't describe it to us...
> 
Turns out that this patch was actually pointless, as the code in 
question can only be reached from the 'nvme_alloc_ns()' flow, which
means that no namespace for this nsid on that controller is present
(and hence nothing to remove).

But I seem to have found the root cause now (I/O stall as we don't
kick the requeue list in all cases), will be sending a new patchset.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


