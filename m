Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093F1C02192
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 13:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0kURa+Z/tH/xv1uL9dsV6jXqWT869unLgiEE7GhfEV8=; b=Vmh1F48ahK3hldEbVjXze/MtW2
	e9Td4xYBWq01nyFkyQLj9KLZHFqjAk7sS9xoVpXnq3VWaSnRhCQG5tbAWUOE3onnj56h4uEXEB5aS
	QHOvx1A+NPlb3tS/wiifu2I0+ahSLrRJ3z0fKvAdf3txf2W/VfxeTcWxdiplQdPGrUZ3wlNYc4+XF
	9AbIbKtAVo8gShs7Jci8mQA9gWq/jAeKjk2O7qA3BGpsgez1wJbIdwDiHCBQbd09xqweP1M1C+Kv6
	kJ/2rp1VFcepfLuOh6G6P/1iIUJ+pgQG9iujn8cvHoCqMyDA136+2/APU/mhwI+xRSmsn409ENQF4
	4Pf9oglg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tewfn-0000000FXwB-0b1o;
	Mon, 03 Feb 2025 13:39:35 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1teweR-0000000FXfZ-34V2
	for linux-nvme@lists.infradead.org;
	Mon, 03 Feb 2025 13:38:12 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 29DF921161;
	Mon,  3 Feb 2025 13:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738589884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0kURa+Z/tH/xv1uL9dsV6jXqWT869unLgiEE7GhfEV8=;
	b=H3M0o7O09hbcNsQBDyBhoOb+9vuK3ZgNweI23I+nU4coGZhnfMRbdQAJb0f+TfLimQSkhL
	ySSqY4WH6VX6dEjfoHQabRvHe8p9PSR7NPV7IPas+gGIv5tAJIohJxe9E30o0g894hqbrD
	Haen2D7Wl87OOwAbpdysqXMkEqtrHmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738589884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0kURa+Z/tH/xv1uL9dsV6jXqWT869unLgiEE7GhfEV8=;
	b=36Rol8uz5QVXzYQ15tZMdoCpjQEp/Eii6zWk+I5J0Kf6BIxP/q/4SerkEfjdBFqG4nIf3B
	vvujzwc7Gpl28UBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jWp5YhWJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PaogBZVd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738589880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0kURa+Z/tH/xv1uL9dsV6jXqWT869unLgiEE7GhfEV8=;
	b=jWp5YhWJKhH6/CfZDg3SEXJrAG8kPA/K2KgKzYwchmXDFttSg/LVLvlWfpngLhX6f1qfdt
	qEPjp9Q+/jGeiOZwWuocL6KOQxaEtzSxoaZ0buW8SyprlkPU74Yhn/7MZYvZz/sjfRzEZX
	vf4cYhSDor27P11AJpOCp/hVAhGaoM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738589880;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0kURa+Z/tH/xv1uL9dsV6jXqWT869unLgiEE7GhfEV8=;
	b=PaogBZVdFR1iVmx60SVRToyWKBex/YXeoBRraBIwBm4jQzTt9DLcdQtUZDYvTePlPN6330
	Y25QvcYNlRAbT1Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1725D13A78;
	Mon,  3 Feb 2025 13:38:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /iAfBbjGoGdwMwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 03 Feb 2025 13:38:00 +0000
Message-ID: <9382676e-6f77-42c0-816d-fd7ac9e8572f@suse.de>
Date: Mon, 3 Feb 2025 14:37:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] nvme: add nvme_auth_derive_tls_psk()
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20250122165829.11603-1-hare@kernel.org>
 <20250122165829.11603-5-hare@kernel.org> <20250128085833.GC25760@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250128085833.GC25760@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 29DF921161
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_053811_912952_CB03C370 
X-CRM114-Status: GOOD (  13.95  )
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

On 1/28/25 09:58, Christoph Hellwig wrote:
>> +	info_len = strlen(psk_digest) + strlen(psk_prefix) + 5;
> 
> Where does the magic 5 come from?
> 
Two bytes for the HASH ID, two bytes for the length field from
HKDF-Expand-Label, and one byte for the space separator.

>>
>> +	info = kzalloc(info_len, GFP_KERNEL);
>> +	if (!info) {
>> +		ret = -ENOMEM;
>> +		goto out_free_prk;
>> +	}
>> +
>> +	put_unaligned_be16(psk_len, info);
>> +	memcpy(info + 2, psk_prefix, strlen(psk_prefix));
>> +	sprintf(info + 2 + strlen(psk_prefix), "%02d %s", hmac_id, psk_digest);
> 
> And this feels like we'd want a basic struct for this, even if it
> just is the len field and a flexible array.  Which will also help the
> compiler to to do bounds checking using __counted_by.
> 
It would, if the were counting the full 'info' string.
But the 'length' field is just the length of the string 'tls13 ' + 
'nvme-tls-psk' (cf the definition of HKDF-Expand-Label in RFC 8446).
So having a _counted_by thingie would only count the first part
of the full 'info' string.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

