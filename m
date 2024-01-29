Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA238C47422
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 06:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JpwyltL7Ee9DZQeDYoSbExXFRys2rK2cpz83uMpTALs=; b=RMKdwpjpOOCM4g3HN69guBMTu9
	0Vb0p/pPuhaLWWFyLqbnMF+5OoVhm0i6TZMMAaiDSyTrhO2tAdzt07EHdqkAosMhlZYatM9NcqjJt
	COmqb5uqij8vgo7kmpChdiAyDF0/1PwVyLVY68fWHQmqexxNxt329TWxQ8ANVois86zZcBOfKbwgv
	uxLWPwGimpgwiNzJ/Z8RFyD/J/9ajBBBIEF/uZ4pQXr6Rk81ZTrFumfECads+1FyLDDfoSxXg3Y9E
	edE2JTQxyhUNnV8g4v0bkRqBaOMarZ4kuMq72lbA46Jo7W6IXLMxmELAkBgoaMgsbb3RtzdKsOcrZ
	R3VVN6mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUL47-0000000BSHe-1nhW;
	Mon, 29 Jan 2024 06:24:19 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUL42-0000000BSFG-1Tjd
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 06:24:17 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B97D11F7D1;
	Mon, 29 Jan 2024 06:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706509452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JpwyltL7Ee9DZQeDYoSbExXFRys2rK2cpz83uMpTALs=;
	b=DTr6cSWn9GqODM2zJqPVjFR0F3KjF+cT/rxBVt++sHggGXZas0FJO10jx/zx7bMZiY94iZ
	jkvJwLU0UHjSe3qTWe7sHeQ/wfjGzR+eLadvry+60Bi6jtkMTz22xYBPmDxhNh/cpQgonL
	9QyWY4VUS1ZnJErh/FSfBop1InDj1sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706509452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JpwyltL7Ee9DZQeDYoSbExXFRys2rK2cpz83uMpTALs=;
	b=UoGbdKnLFrdfcFcJe5Q2K47nQmAEAe4cM2bmnsfIrB/1sUTGC1ur7+Ol9PywFVlNWkTjfn
	AhszhrzLR+fWPABQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706509452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JpwyltL7Ee9DZQeDYoSbExXFRys2rK2cpz83uMpTALs=;
	b=DTr6cSWn9GqODM2zJqPVjFR0F3KjF+cT/rxBVt++sHggGXZas0FJO10jx/zx7bMZiY94iZ
	jkvJwLU0UHjSe3qTWe7sHeQ/wfjGzR+eLadvry+60Bi6jtkMTz22xYBPmDxhNh/cpQgonL
	9QyWY4VUS1ZnJErh/FSfBop1InDj1sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706509452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JpwyltL7Ee9DZQeDYoSbExXFRys2rK2cpz83uMpTALs=;
	b=UoGbdKnLFrdfcFcJe5Q2K47nQmAEAe4cM2bmnsfIrB/1sUTGC1ur7+Ol9PywFVlNWkTjfn
	AhszhrzLR+fWPABQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7363D12FF7;
	Mon, 29 Jan 2024 06:24:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aeYNGoxEt2WPRwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 29 Jan 2024 06:24:12 +0000
Message-ID: <82af77e3-5330-4178-9ba5-66adb3a3acfa@suse.de>
Date: Mon, 29 Jan 2024 07:24:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: enable retries for authentication commands
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, hare@kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Martin George <marting@netapp.com>
References: <20240127093746.40246-1-hare@kernel.org>
 <20240127093746.40246-4-hare@kernel.org> <20240129060005.GC19136@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240129060005.GC19136@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DTr6cSWn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UoGbdKnL
X-Spamd-Result: default: False [-0.71 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.41)[77.95%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B97D11F7D1
X-Spamd-Bar: /
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240128_222414_581092_24BF0129 
X-CRM114-Status: GOOD (  15.53  )
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

On 1/29/24 07:00, Christoph Hellwig wrote:
> On Sat, Jan 27, 2024 at 10:37:46AM +0100, hare@kernel.org wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> Authentication commands are normal NVMe commands, and as such
>> can return a status where NVME_SC_DNR is not set, indicating
>> that the command should be retried.
> 
> What command is not normal?
> 
Things like 'property set' or 'property get', which are used in eg
nvmf_reg_read() et al. They are used to retrieve or get register 
settings, and it's not quite clear if it's safe (or prudent) to retry them.

>> This patch enables retries by setting NVME_SUBMIT_RETRY for
>> __nvme_submit_sync_cmd().
> 
> I think what should go into the commit log is why the retries are
> desirable here, and not for other admin commands.
> 
Okay.

> Otherwise this looks good to me.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


