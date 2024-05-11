Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E627C04FFE
	for <linux-nvme@archiver.kernel.org>; Sat, 11 May 2024 09:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nnSx2MOWwW4pI7ik2Ux4U4XWKLd6DkWyoyABdco2Iu8=; b=lyzKJkDH+U+a9v5hh/4Kuoch3G
	Sx2LsrYEAi+C14709LXO9hhsfRCq9Rs6qL00aXn7ZkVRu0AODeR2zfdNS+uXomE3oejTPwS3iZ4b1
	3FqxcNdJuldFRT6+xzn2pPebNg0LWxriui6jcn5bjHYeqdgPk3146VKR0129kPsEENRYbtIR4cVUF
	eblAIrDhmywST24lKNEcTNHIpMq4LeGBoutTwNiB4JieyT/mrLJvRokxsws2VN0fGoFTKdiLol4AY
	1l5fEvcFDXSbPMfN8b+iw7eXtEX011qIeJDsFa0pXH6YHOe7yJjmRfUvR8Hav/W01HeIJAE3R95CY
	bTxNAWhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5is3-00000007bxt-0R7g;
	Sat, 11 May 2024 09:18:23 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5iry-00000007bwJ-2UQt
	for linux-nvme@lists.infradead.org;
	Sat, 11 May 2024 09:18:21 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD40120B2B;
	Sat, 11 May 2024 09:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715419096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nnSx2MOWwW4pI7ik2Ux4U4XWKLd6DkWyoyABdco2Iu8=;
	b=EE8nJRUHWzmXvM+kRNQo4qbE0yukQ+qYm4P4iXEMxMt/NriKeY0poOoO4Xg2Z/r1VECGQx
	UWtiC/6ECyLaNtGW31i2Y799Bjh261qw5aDdFdY0eMyQAdswX2Y+UQs8HTRGG8Yz2jhhyI
	OWuTMKuSdRNwOuWhC7q84akG0hBfoE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715419096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nnSx2MOWwW4pI7ik2Ux4U4XWKLd6DkWyoyABdco2Iu8=;
	b=UE9IhezG09VQlSTJLXqhmQlNuW4H8h3fXqyDJD64Y0OtJC8Nrt5SJxHwuFD5LPwTDfzRK8
	kxwqp1XScitQPABg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715419095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nnSx2MOWwW4pI7ik2Ux4U4XWKLd6DkWyoyABdco2Iu8=;
	b=EcyRrowvPGwfnPtA/N2Xlb62mksRtiwmQCbhf1kTMG9NDyjn3UFeukqVbDPDTNR3M5M8uc
	YDPa9+yXf9rVjlMW/II8fTkVRBVNYcgJhBm29axi3NnQ9Qvriycq83v8KPKvBqkRsTg6BY
	ETVbPwsqsW9emidKOb5mkevZAJuVX6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715419095;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nnSx2MOWwW4pI7ik2Ux4U4XWKLd6DkWyoyABdco2Iu8=;
	b=TtqKQV1jWBMu76WYdOZXdI8c691Z4/D74XHekMJzaQ9/LMsrDVoR+ahbXNvACVMfq8N4rf
	PfCENq/wXdyxnpBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EEED13A3E;
	Sat, 11 May 2024 09:18:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vzAzFNc3P2Y2KAAAD6G6ig
	(envelope-from <hare@suse.de>); Sat, 11 May 2024 09:18:15 +0000
Message-ID: <05bf499a-17a4-4438-a919-50da666fa289@suse.de>
Date: Sat, 11 May 2024 11:18:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] block/bdev: enable large folio support for large
 logical block sizes
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, hare@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Pankaj Raghav <kernel@pankajraghav.com>, Luis Chamberlain
 <mcgrof@kernel.org>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-5-hare@kernel.org>
 <Zj6hHAVWSev-xe4R@casper.infradead.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Zj6hHAVWSev-xe4R@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240511_021818_876808_F9A84454 
X-CRM114-Status: GOOD (  12.26  )
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

On 5/11/24 00:35, Matthew Wilcox wrote:
> On Fri, May 10, 2024 at 12:29:05PM +0200, hare@kernel.org wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> Call mapping_set_folio_min_order() when modifying the logical block
>> size to ensure folios are allocated with the correct size.
> 
> This makes me nervous.  It lets the pagecache allocate folios larger
> than min_order (all the way up to PMD_ORDER).  Filesystems may not
> cope well with seeing tail pages.
> 
> I'd _like_ to be able to do this.  But I think for now we need to
> call mapping_set_folio_order_range(mapping, order, order);
> 
(Misrouted reply to the previous mail; airports make me jumpy ...)

The whole point is that these devices cannot support smaller 
allocations. We might restrict ourselves to min_order == max_order,
but we should be focussing on getting min_order working first ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


