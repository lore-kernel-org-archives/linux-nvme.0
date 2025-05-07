Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E910C3ABC6
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 08:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wB0e4GTqQ85Sn1+HkSOPm0InL06x1Pyn1fw682toUNg=; b=rQD3522qmQoLIfj81txDw+hX8k
	yt0O1jy0sHC3ToBaO/v583hNcRH8uIq1/uTZnb5ldO3eA4vDYZuQTCLVZCJtmQZBTg4J0nEq0JKco
	W5y37N5Mv6ho/OAsZiHLQzlWDUxrvNDDf7S1S3pAM1q9UYa1PiKrML8kOyaJCd62etCtZ7LM7zAmq
	y5BLCKII93oZWwsFbDgYklcokp6Wr+q8ZPDIiZnaWc6hdjTqauE63wkI1e8Oxw1raYpyRfu1q45iA
	o1ZroJsLWs/8aqI8mNdX6KAGHzC0fZXC1K+rlonZ/X5NTSE/vU/WpZmrNo49kZ+KXhBIGJmSb/ymp
	yFpN3qEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCaJ4-0000000EmjF-3ZCy;
	Wed, 07 May 2025 08:39:10 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZPw-0000000EZpm-2aKI
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:42:14 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 91E2D1F38C;
	Wed,  7 May 2025 07:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746603730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wB0e4GTqQ85Sn1+HkSOPm0InL06x1Pyn1fw682toUNg=;
	b=KEo8gF5j83wEca/Kv5eXqz339F6oX4BrbW8J1OLyzNyrrfEhfX58vdKip7Y4q7P6FVo/Nq
	61sn+4uqzXeugtjmukmn16X6B2eIz7+TjxzJYuujsMzCb4qTkrLfKhSmXdQCbJIgOSg2sU
	UrzCa6AXf5dN0Ixsmm8/lEs3y1vioZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746603730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wB0e4GTqQ85Sn1+HkSOPm0InL06x1Pyn1fw682toUNg=;
	b=4qUMjup5LJy7kD2xRmVgJi9/OLwpCRPgRhNL0Mk2o1jFFrlTuO+3diGRVlNj6vOvtaRGFD
	CZc/Sls3UkksE+AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746603730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wB0e4GTqQ85Sn1+HkSOPm0InL06x1Pyn1fw682toUNg=;
	b=KEo8gF5j83wEca/Kv5eXqz339F6oX4BrbW8J1OLyzNyrrfEhfX58vdKip7Y4q7P6FVo/Nq
	61sn+4uqzXeugtjmukmn16X6B2eIz7+TjxzJYuujsMzCb4qTkrLfKhSmXdQCbJIgOSg2sU
	UrzCa6AXf5dN0Ixsmm8/lEs3y1vioZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746603730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wB0e4GTqQ85Sn1+HkSOPm0InL06x1Pyn1fw682toUNg=;
	b=4qUMjup5LJy7kD2xRmVgJi9/OLwpCRPgRhNL0Mk2o1jFFrlTuO+3diGRVlNj6vOvtaRGFD
	CZc/Sls3UkksE+AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 645A313882;
	Wed,  7 May 2025 07:42:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UgfbFtIOG2h7WgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 07 May 2025 07:42:10 +0000
Message-ID: <bf74ef6b-7986-4dbf-8a6d-ce6f031d68c4@suse.de>
Date: Wed, 7 May 2025 09:42:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] nvme-auth: switch to use the kernel keyring
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20250425094927.102656-1-hare@kernel.org>
 <20250507071932.GA1839@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250507071932.GA1839@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_004212_796523_4D18B977 
X-CRM114-Status: GOOD (  10.39  )
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

On 5/7/25 09:19, Christoph Hellwig wrote:
> Can you create documentation on how to actually use the keyring
> interface?  As I just got into the TLS the complete lack of documentation
> there left me a bit stunned and I'd rather avoid that for new interfaces.
> 
Well ... We _do_ have a wiki page on the nvme-cli github:

https://github.com/linux-nvme/nvme-cli/wiki/How-to-Set-Up-TLS-for-NVMe%E2%80%90TCP

which I found a better place than the kernel Documentation.

It does lack information about secure concatenation, true; I'll be
adding that. And we have blktests for TLS and secure concatenation
nowadays (nvme/062 and nvme/063).

I'll probably add another blktest for the new interface to test
with pre-populated keys.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

