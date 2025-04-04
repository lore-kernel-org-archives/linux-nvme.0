Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE0FC3601A
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Apr 2025 06:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HjbdJD4dFGDhFmDgoG0miYx9w5obGsy/bKk52ohXbEU=; b=41jOkRQU2kRvlje1J7gCZ3Pluv
	1HmQbqCENb6hHyN6xEj2zNeZA/miXxBFg45vktW0GGGBFVvC0IDefXntW/pThjs/Yv4eiXOP/iiMO
	viRLWyCCxennsEpZiMQlcWAxUE+4DP1pplBPasqSra/zaqfxe7Oem3OfGkmXE3ZeWhNNht3nue6WW
	Z3IZptgHpJ2FPPDdpHh8AAF0XWT30SO9RRCAV9XFUKc5Mdr79jieo8kRCp0nD61Emu5AC28Aberib
	T5CR9yCKo94vA38LCUM7qelD+TM8c90S9gzgzPC5HPJdplHiZFyUNo8T4G9CheZTsRKct2MlFpMaP
	s0dc3HGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0aUP-0000000AsKA-2jHG;
	Fri, 04 Apr 2025 06:25:17 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0aUM-0000000AsJB-31Dd
	for linux-nvme@lists.infradead.org;
	Fri, 04 Apr 2025 06:25:16 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 048781F385;
	Fri,  4 Apr 2025 06:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743747913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HjbdJD4dFGDhFmDgoG0miYx9w5obGsy/bKk52ohXbEU=;
	b=H1vLWIbKyyKf6CdhglReTet9+8qrZIXF44Mb/H2w7r8ZoyhPtqBogP8HG1eCoAIaNWbkQo
	atvXYZGaY76i/WpvkSvhqOHNPdmmNntQLwtlONjRJ+JYNr9W716+DoRKYRhJIcULg3LSsT
	t66l0jpMNIBmSp7BQ7lV2mzNqUqRtro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743747913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HjbdJD4dFGDhFmDgoG0miYx9w5obGsy/bKk52ohXbEU=;
	b=NyFPWhgDFMGfbWZkLoPCqR9u4V+D+v2tyJPW6iSsOTTAOF6is2E2qBCzLytaBf63TPbr9E
	/ISq396LpHi3eABQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743747913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HjbdJD4dFGDhFmDgoG0miYx9w5obGsy/bKk52ohXbEU=;
	b=H1vLWIbKyyKf6CdhglReTet9+8qrZIXF44Mb/H2w7r8ZoyhPtqBogP8HG1eCoAIaNWbkQo
	atvXYZGaY76i/WpvkSvhqOHNPdmmNntQLwtlONjRJ+JYNr9W716+DoRKYRhJIcULg3LSsT
	t66l0jpMNIBmSp7BQ7lV2mzNqUqRtro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743747913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HjbdJD4dFGDhFmDgoG0miYx9w5obGsy/bKk52ohXbEU=;
	b=NyFPWhgDFMGfbWZkLoPCqR9u4V+D+v2tyJPW6iSsOTTAOF6is2E2qBCzLytaBf63TPbr9E
	/ISq396LpHi3eABQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B81BD1364F;
	Fri,  4 Apr 2025 06:25:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kYEQKkh772eFUgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 04 Apr 2025 06:25:12 +0000
Message-ID: <f0ac1ecd-7c41-4203-9b9e-12f28504e4b3@suse.de>
Date: Fri, 4 Apr 2025 08:25:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvmet: improve 'read-only' handling
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>,
 Lennart Poettering <lennart@poettering.net>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20250403144747.43043-1-hare@kernel.org>
 <20250404061915.GA31468@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250404061915.GA31468@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_232514_907840_47AF045B 
X-CRM114-Status: GOOD (  10.38  )
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

On 4/4/25 08:19, Christoph Hellwig wrote:
> On Thu, Apr 03, 2025 at 04:47:45PM +0200, Hannes Reinecke wrote:
>> Hi all,
>>
>> there was a request (Hi Lennart)
> 
> which Lennart?  There's none on Cc.  Not that it really matters, but
> I'd love to hear a bit more about the use case.
> 
Lennart Poettering has a simple nvmet service in systemd, turning the 
entire system into an nvmet-tcp target exporting the root device.
(He needs it for testing and debugging his systemd changes).
But obviously that would expose his HDD to _anyone_, and so to prevent
$RANDOM_PERSON to access and possibly delete files on his HDD he would
like to have a 'readonly' setting.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

