Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11716CD5BA0
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2024 09:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G++O0eKPCtxjaY7nOOJScZYc8VEySxGzGVRvgLPE4aY=; b=TvMI32aSkw7Xh1ktSo9EOwmG1Z
	QVpCGVakzjn165PRcyHJUmC2PeV7XUI67hy6iEA4yFRWVb7Kh+ElBh+2ZyQxh0hgDm0Bz1tLq+jAc
	pI69R5zXYQoXIU7TPI0IwlNVr8eAqUSsAt36ez3hZlHZwhNub2+MODTqBSY9hY3EfSql5ewJU15FK
	ZzBHlLIOljuUrxtdwdXrmCUL9yao+YdKCdiOOKetVQf0U2oRbyxROnM+8JNPN52Pt/Tsj4E1CsK4R
	Zr2TC/nWghpxez67nxurg3Yw3IS/sH6s+OQ5nDQSQL5WRleHbiXO3/ryN+H75wBI/rQItmALQT+JK
	jfQm3gtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm8jE-00000007kh6-3B9w;
	Thu, 05 Sep 2024 09:24:36 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm8iZ-00000007kcm-0QzU
	for linux-nvme@lists.infradead.org;
	Thu, 05 Sep 2024 09:23:58 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 755401F7D4;
	Thu,  5 Sep 2024 09:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725528233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G++O0eKPCtxjaY7nOOJScZYc8VEySxGzGVRvgLPE4aY=;
	b=zR8iLfR8i7qieueSBWO7GQr2ClyCepS8aoDrP2tFwC8u/5fGdIJ/Kjaq1NBHhIFnn97QK7
	TQ7wXGpVXv4PiRm61K3b7pm8qXwj5PXneVfX6lO3PkEd9iKn9cGYtwFs+XxoJVAJTWrcnm
	qeJ5alGh+l4/pZowrxPQGTqwQfkflEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725528233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G++O0eKPCtxjaY7nOOJScZYc8VEySxGzGVRvgLPE4aY=;
	b=1Rm31bSDL68ui3HZo8NfU5FrSciUMNW8jspJOYwwYXsyKG42qu+YDM5xtRUlH9xokK6Ee/
	lxjA6lIMranisfCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zR8iLfR8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1Rm31bSD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725528233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G++O0eKPCtxjaY7nOOJScZYc8VEySxGzGVRvgLPE4aY=;
	b=zR8iLfR8i7qieueSBWO7GQr2ClyCepS8aoDrP2tFwC8u/5fGdIJ/Kjaq1NBHhIFnn97QK7
	TQ7wXGpVXv4PiRm61K3b7pm8qXwj5PXneVfX6lO3PkEd9iKn9cGYtwFs+XxoJVAJTWrcnm
	qeJ5alGh+l4/pZowrxPQGTqwQfkflEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725528233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G++O0eKPCtxjaY7nOOJScZYc8VEySxGzGVRvgLPE4aY=;
	b=1Rm31bSDL68ui3HZo8NfU5FrSciUMNW8jspJOYwwYXsyKG42qu+YDM5xtRUlH9xokK6Ee/
	lxjA6lIMranisfCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 405E71395F;
	Thu,  5 Sep 2024 09:23:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tFHtDal42WZkNgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 05 Sep 2024 09:23:53 +0000
Message-ID: <6624571d-a23f-4c0c-bcee-383cb3ed357f@suse.de>
Date: Thu, 5 Sep 2024 11:23:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-multipath: fix I/O stall when remapping
 namespaces
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240903180345.35253-1-hare@kernel.org>
 <20240903180345.35253-3-hare@kernel.org>
 <1acc9b52-e3dc-4142-91d4-48eba61d4fd0@grimberg.me>
 <3654d3d6-7f5c-4e5b-926c-339a985ace1e@suse.de>
 <47002e19-0de1-4bfd-9549-57894741d0c4@suse.de>
 <a5d65cfa-46a1-4d11-9a27-c7db5dcab45a@grimberg.me>
 <a9ed2520-0687-4379-b5cd-d186bb9cf5c0@suse.de>
 <a37a764f-5cf2-47fb-bc35-4f44f5a717c2@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <a37a764f-5cf2-47fb-bc35-4f44f5a717c2@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 755401F7D4
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240905_022355_318630_FAD4CE08 
X-CRM114-Status: GOOD (  19.33  )
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

On 9/5/24 11:06, Sagi Grimberg wrote:
> 
> 
> 
> On 05/09/2024 11:39, Hannes Reinecke wrote:
>> On 9/5/24 09:06, Sagi Grimberg wrote:
>>>
>>>
>>>
>>> On 04/09/2024 11:59, Hannes Reinecke wrote:
>>>> On 9/4/24 10:20, Hannes Reinecke wrote:
[ .. ]
>>>> in addition to moving of kblockd_schedule.
>>>>
>>>> So what do you prefer, checking NVME_NS_HEAD_LIVE or NVME_NS_READY?
>>>
>>> Well, NVME_NS_READY is cleared in nvme_ns_remove (which is fine) but 
>>> also
>>> in nvme_mpath_revalidate_paths() if the capacity changed, so 
>>> theoretically,
>>> if the last remaining path changed its capacity, it will make 
>>> nvme_available_path()
>>> fail, and in turn, mpath IO will fail and not added to the 
>>> requeue_list, which would be
>>> wrong. So I think that nvme_available_path should check 
>>> NVME_NSHEAD_DISK_LIVE,
>>> but nvme_find_path is fine in its current form.
>>
>> Weelll ... not quite.
>> I never get this far, as the only place where nvme_remove_ns() can be
>> called is from the scanning process, yet this is stuck waiting for I/O.
>>
>> My testcase then simulated a namespace replacement by setting a new 
>> UUID, and then enabling the namespace again. The target will return
>> PATH ERROR during that time, causing I/O to be retried (while disabled)
>> or failed over to the same path (as it's the only one left).
>>
>> Of course we could argue that the testcase is invalid, and the target
>> should return INVALID_NS if the UUID changed.
>> But one could also argue that retrying on the same path is pointless,
>> seeing that we'll always get the same error.
>> Hmm?
> 
> Hannes, I was referring to the general case where we have more than one 
> path.
> 
> What I said is that I think that if you drop the NSHEAD_DISK_LIVE check 
> in nvme_find_path
> (it already checks for NS_READY) but have nvme_available_path check for 
> NSHEAD_DISK_LIVE
> and both your test case should work and the general case where there is 
> more than a single
> path.

Ah, _that's_ what you mean. Sure, sounds feasible. I'll give it a spin.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


