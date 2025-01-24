Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36687C0218C
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 08:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0swO7gZgLUNQqgIae/+mfi6+2RZ+H7X2rMPtRwYPnrY=; b=LQuwM1D+k5gZ0BBVGqTY/b3Vv+
	rTjG2abqGkHreeCmbhc3Q/RYG9zFAilY5O0r0DFuOHD+S0c7edK7uHuX4YzDXokfkOTFxL12QpoR0
	Dm88WeTPGV0alZhEJbTQAkj4E7aHkGuwkUGulT4ULwcOW3pUp2PExJ0KKbdLXliWw4aw1ZfV38ATs
	mBYrOPE8i6kKqQ1OD5Y1e4o4ng7X6zT6FuL2mqKU8aq8kw+ymwETKmItyqH4twDUBeJ9tHCXQMEwp
	l3wUXCweD7TSm2Gzb0jFraRwOQUSJJo/dm1Eqfp/0cBb2O6fQi8UWZtpGnEg3tkTsHrD4bnKt3XyT
	MvuAmv+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbF4E-0000000EFZ6-25Yj;
	Fri, 24 Jan 2025 08:29:30 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbF3M-0000000EFS8-3fhT
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 08:28:38 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E5481F38C;
	Fri, 24 Jan 2025 08:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737707313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0swO7gZgLUNQqgIae/+mfi6+2RZ+H7X2rMPtRwYPnrY=;
	b=gP9ofgIA22QJdm8Lgx6VGMKmLnC1hRdVP9a5qSMKuwTsh4f2WQGfGzMmXjdjkMYxkX+zC5
	eS2IKKSZcDph24HOhDHci0XbUV8wtySRxWRtk7bsBIGdSwzWkBTORAxeYMLvZ31KEcdiCu
	OrnIRlmMYoLmorA0IkRCXsYdbLihaSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737707313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0swO7gZgLUNQqgIae/+mfi6+2RZ+H7X2rMPtRwYPnrY=;
	b=OtusyNSZYOXPVQwtoLOOvDqgsDxxQ10uKumIc7WUPabaQUTwhjqt2qi/U/BEXgXGXC0vjQ
	R+j12oh046UcyBBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gP9ofgIA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OtusyNSZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737707313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0swO7gZgLUNQqgIae/+mfi6+2RZ+H7X2rMPtRwYPnrY=;
	b=gP9ofgIA22QJdm8Lgx6VGMKmLnC1hRdVP9a5qSMKuwTsh4f2WQGfGzMmXjdjkMYxkX+zC5
	eS2IKKSZcDph24HOhDHci0XbUV8wtySRxWRtk7bsBIGdSwzWkBTORAxeYMLvZ31KEcdiCu
	OrnIRlmMYoLmorA0IkRCXsYdbLihaSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737707313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0swO7gZgLUNQqgIae/+mfi6+2RZ+H7X2rMPtRwYPnrY=;
	b=OtusyNSZYOXPVQwtoLOOvDqgsDxxQ10uKumIc7WUPabaQUTwhjqt2qi/U/BEXgXGXC0vjQ
	R+j12oh046UcyBBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E77E9139CB;
	Fri, 24 Jan 2025 08:28:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iucvNzBPk2fgXQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 24 Jan 2025 08:28:32 +0000
Message-ID: <cd8e197d-721a-4e5c-b4fb-c39caca0edfc@suse.de>
Date: Fri, 24 Jan 2025 09:28:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 blktests] nvme/058: detach loop device after test finish
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: shinichiro.kawasaki@wdc.com, gjoyce@ibm.com
References: <20250124074753.9802-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250124074753.9802-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8E5481F38C
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_002837_061570_D935B0BB 
X-CRM114-Status: GOOD (  12.92  )
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

On 1/24/25 08:47, Nilay Shroff wrote:
> The nvme/058 creates three (temp file backed) namespaces and
> attach each namespace to a loop device while starting the test.
> However it never detach those namespaces from the loop device
> once test finishes. Ideally, we should detach loop device from
> namespace so that the associated loop device is later destroyed
> and its resources are released. This patch helps detach each
> namespace from its associated loop device after test finishes.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
> Changes from v1:
>      - keep blkdevs, which are used for setting up ns, in an array
>        and then later access the array to free/detach each blkdev
>        (Shinichiro Kawasaki)
>      - use longer option name instead of short name for readability
>        (Shinichiro Kawasaki)
> ---
>   tests/nvme/058 | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

