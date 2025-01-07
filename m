Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEAEE77199
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 08:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BQ8bRumeFsIVsmVyOmsay71G/pHj4JVsoBAKcuZYPfs=; b=ksXpv9jSCeScwn6Y++KE1clFk7
	01S2WKhxTmBxK7QcL9eeS/qjmO92wPE4uZtGpHuLAUmushh9iWaoZHYF+yA1auyRfFq8nx/pivQSR
	BLojwul9H2gykGxU+8FnPRxPELqEuvXeR+biZc+dJsOZRBWuVSXaFswyP/Oqe2vHLaMZ4XPNui4Vd
	icFlMMQXGY4GxGTcJQihGgyQgBbj2+1OMVZilUMNthW5NwYL9GthFjg271r4xO2qWBr0NjPcxO+We
	E08KWRsmkx1Uq/9KN8vZo15YxAW5xJPfAwld88JUgA298nE78lmDd9dzmrDHz9SOhPyG06uAfAr81
	e2iKeG3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV4gv-00000003sS3-2eUO;
	Tue, 07 Jan 2025 08:11:57 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV4go-00000003sPW-0RDo
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 08:11:56 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 173311F37E;
	Tue,  7 Jan 2025 08:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736237507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BQ8bRumeFsIVsmVyOmsay71G/pHj4JVsoBAKcuZYPfs=;
	b=D7obqzZh3SxirqTvyvnk9b/BwRxCuDE8Srfvu1gEIGnIJFMaWnUNAnR6ULdTRwd8IeYG2Q
	GvuwXKcBfLe394UD6TR6E6PLSxk6jf5E43KtIvj3DA5aH6kCKtks6nEpLyNUXqvODjSMg7
	5SezgTtk7f3NjC8WuX3MIp7VgtG93Bg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736237507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BQ8bRumeFsIVsmVyOmsay71G/pHj4JVsoBAKcuZYPfs=;
	b=P6c2jB4mCI0vH0LwLL4qu2tdM33EkAaFy/s6XF0TMpiqzmZSioEWMUMLfu6Ov/zs/CG7Bk
	cULzqbWjgY50xuDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=D7obqzZh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=P6c2jB4m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736237507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BQ8bRumeFsIVsmVyOmsay71G/pHj4JVsoBAKcuZYPfs=;
	b=D7obqzZh3SxirqTvyvnk9b/BwRxCuDE8Srfvu1gEIGnIJFMaWnUNAnR6ULdTRwd8IeYG2Q
	GvuwXKcBfLe394UD6TR6E6PLSxk6jf5E43KtIvj3DA5aH6kCKtks6nEpLyNUXqvODjSMg7
	5SezgTtk7f3NjC8WuX3MIp7VgtG93Bg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736237507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BQ8bRumeFsIVsmVyOmsay71G/pHj4JVsoBAKcuZYPfs=;
	b=P6c2jB4mCI0vH0LwLL4qu2tdM33EkAaFy/s6XF0TMpiqzmZSioEWMUMLfu6Ov/zs/CG7Bk
	cULzqbWjgY50xuDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D508613A6A;
	Tue,  7 Jan 2025 08:11:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a+rUMcLhfGeSNgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 07 Jan 2025 08:11:46 +0000
Message-ID: <bb69b9b9-ad56-4c83-a848-a4b171896097@suse.de>
Date: Tue, 7 Jan 2025 09:11:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Remove namespace when nvme_identify_ns_descs()
 failed
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20241129140608.115282-1-hare@kernel.org>
 <f6229339-5b1f-47d5-8eb1-d11ed2fc2281@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <f6229339-5b1f-47d5-8eb1-d11ed2fc2281@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 173311F37E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_001150_289082_3301CFBF 
X-CRM114-Status: GOOD (  13.07  )
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

On 12/25/24 10:58, Sagi Grimberg wrote:
> 
> 
> 
> On 29/11/2024 16:06, Hannes Reinecke wrote:
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
> Isn't that a bit harsh?
> I would expect to see a specific status line NVME_SC_INVALID_NS or 
> equivalent for a full removal of the namespace?

Does it matter? If we get a DNR status back from 
nvme_identify_ns_descs() we _cannot_ resend that command.
Meaning we cannot get the namespace descriptors. As we
rely on these descriptors to properly map the namespace
we cannot correctly work with it, and we're better off
to pretend the namespace is gone and wait for an AEN
indicating that the namespace (or controller) state has changed.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

