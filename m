Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD37FC02181
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 15:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GHemV3sxYvZyYKkYiyeHDtsYmAELP5Cv1UUAsvciB8s=; b=gGNdUo6d6GtNSchYSfJxIOa88I
	I/OAH5WkmK+KENjngzAtzUsXPCFzilhAuWpmM4a+hzvkxT+PkZn29A77/l37Sxh6Tl+7CTyTpT5eY
	ybhkMUTdnSCXxZOWTmTDQGfF8+zKb063bra6AQYukkydooPbf9MZbre1oSAvUft7KgY2QRKm1hdW6
	0vgqwMHmuQXuqy1VsRsscLSLLXUCaSEEYF5Nf7XJZafcqdwTuKR5gKh/alaFHXNSmCoiSwMcczOJB
	ZjlbWk353qZz1INNZdT5J7FrmEg5wFbPG6tHalo7BSBhIgAoUc9QX2hkDbxRvk2x7MeLCvnZCUxZU
	axJbQAVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbLOB-0000000Ew6M-1A7D;
	Fri, 24 Jan 2025 15:14:31 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbLK7-0000000EvR3-40GP
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 15:10:21 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4B0001F444;
	Fri, 24 Jan 2025 15:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737731416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GHemV3sxYvZyYKkYiyeHDtsYmAELP5Cv1UUAsvciB8s=;
	b=Tr/PN1KdHhbIfsyFP8xeF03Crc/n446gFHtMxxo30n6KhVPPIJG754JPNdtTLvYZBl9rnQ
	8wuLFARP1D45G4KwJQEwwZn9FTc/tOYbK0zxb287VzSXa+BonS7JryRKyOUnlbQgxzleMO
	1ZiTHGOSd/pRS2TV9liPO1lAfqgynPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737731416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GHemV3sxYvZyYKkYiyeHDtsYmAELP5Cv1UUAsvciB8s=;
	b=yTCUj/3Nwal4gCaZPn9kP1ipCXfvDG0euJfhI96XJbGfOnUAucMrS88cwGutpJ7EUuLgMR
	9758NaSQySx/4EDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737731416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GHemV3sxYvZyYKkYiyeHDtsYmAELP5Cv1UUAsvciB8s=;
	b=Tr/PN1KdHhbIfsyFP8xeF03Crc/n446gFHtMxxo30n6KhVPPIJG754JPNdtTLvYZBl9rnQ
	8wuLFARP1D45G4KwJQEwwZn9FTc/tOYbK0zxb287VzSXa+BonS7JryRKyOUnlbQgxzleMO
	1ZiTHGOSd/pRS2TV9liPO1lAfqgynPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737731416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GHemV3sxYvZyYKkYiyeHDtsYmAELP5Cv1UUAsvciB8s=;
	b=yTCUj/3Nwal4gCaZPn9kP1ipCXfvDG0euJfhI96XJbGfOnUAucMrS88cwGutpJ7EUuLgMR
	9758NaSQySx/4EDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1634D139CB;
	Fri, 24 Jan 2025 15:10:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y5YpBFitk2f0WQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 24 Jan 2025 15:10:16 +0000
Message-ID: <0f18f1ec-5164-483b-99ec-2c6afdb45675@suse.de>
Date: Fri, 24 Jan 2025 16:09:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: move percpu handling into
 nvmet_ns_{enable,disable}
To: Nilay Shroff <nilay@linux.ibm.com>, Sagi Grimberg <sagi@grimberg.me>,
 hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20250124082505.140258-1-hare@kernel.org>
 <afe8968e-ff56-4907-b3ec-a79ac75d5250@grimberg.me>
 <f2dc374b-0a08-48fa-bd9f-1cfccd34446d@suse.de>
 <c125b796-d1f7-4c6a-8e96-79aa80143456@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <c125b796-d1f7-4c6a-8e96-79aa80143456@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_071020_139156_B1F623D4 
X-CRM114-Status: UNSURE (   9.22  )
X-CRM114-Notice: Please train this message.
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

On 1/24/25 15:06, Nilay Shroff wrote:
> 
> 
[ .. ]>
> Though I was never able to recreate this issue on my setup even after running
> nvme/058 hundreds of times, still I think the issue reported by Shinichiro
> appears plausible. So we need this fix and your changes look good to me.
> 
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

Yeah, we definitely need this. I was able to trigger it quite 
consistently with qemu after just a few retries.

And I guess we can now kill the ->enable setting completely, and
just use the xarray mark instead.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

