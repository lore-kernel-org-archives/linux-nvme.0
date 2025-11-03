Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230CCCCF9F8
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 11:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hnWHmC0GhHJr8yhikrEe9iwl7aeuCKJ/Kg1kvJIiWy0=; b=Nc5nJ/46x2sulf5MqlhxZyyD0z
	5R2UJfTtzBQ0CwrPUEx7c9iO0Foeg6DnofDWliam1PUfxLE92ry1orlkKvGi2pzcJNCH8KjwxDarv
	WApkCa3jZlGolo07axJOf92q1kX760VK9cT4CbKRZyfaWy7zkeeFBX9/EOxHd47FBDU9wmwN6Ki5Z
	gYlijixtfptqMUc3Zut2/3+tmUiLcfLytMfFIcaK3FfqtV+C5v8SFgSJQ2cyWLKwOD4Dpo86dMl5H
	Ft+QNHHlEFcWrxKJ3M9/VTZ1NY7PyAQRu1iAoYu4XO2QW6PHIrjA1pX5CGRVH338uBmWUlvL8W7ar
	g69/eeOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFsvz-00000009kjM-44mS;
	Mon, 03 Nov 2025 11:41:15 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFsvv-00000009kia-1fGg
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 11:41:14 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D4A8921AB9;
	Mon,  3 Nov 2025 11:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762170069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnWHmC0GhHJr8yhikrEe9iwl7aeuCKJ/Kg1kvJIiWy0=;
	b=GnFiK307v7gxVOjgWFv1HYihI+pG6DC96tu0uRuXx4qG/OQ7qAW5FVJvZtciJlrKJBs0g8
	vcJri/+w8gVTF6VHb8WWB9ATK5NP63bK4vstc5ZsA3T0z+LxIiGG+g6l58pOznRbhGVtfC
	eimnZfBs1dNsjSM6C6rJ5lSIgBfV+Jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762170069;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnWHmC0GhHJr8yhikrEe9iwl7aeuCKJ/Kg1kvJIiWy0=;
	b=9p9ERH+NwU7FfwNdPvPTBVG+SV8IA5r5NNLDMghKrIyMiC1pNx1OLsZrvrNaHqb5whoQO0
	WpNP3UaDYQBqvMCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762170068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnWHmC0GhHJr8yhikrEe9iwl7aeuCKJ/Kg1kvJIiWy0=;
	b=YuFfkVS2fEHkPyeK99I8W84VK0ccnnPc7sGWb/mc+wutKzLjsAycsUmDPQbjCpPST0qI39
	3zOEPbnkExrvpd0fOkZy373V9yJPZ8/xQNvMlMX0KjE3dW5ZMFA05M9dpWwXmIzoPYTA4z
	h3hoAo25XQbj3OFpuqtyCicoUpDr+IU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762170068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnWHmC0GhHJr8yhikrEe9iwl7aeuCKJ/Kg1kvJIiWy0=;
	b=eVgOC0V+VD1WpGHlNvIvty3FVY9x8yXwFz9zf3nrKqc+/7fYR3FH0n4zIXEDA8HXcY/zk+
	/5+HiV1Hq+FpfjDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD9511364F;
	Mon,  3 Nov 2025 11:41:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oyvmKdSUCGkSLwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 03 Nov 2025 11:41:08 +0000
Message-ID: <8947e877-cd53-4f1d-989c-bdde311c00e9@suse.de>
Date: Mon, 3 Nov 2025 12:41:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] block: handle zone management operations
 completions
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-4-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251031061307.185513-4-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_034111_740764_60076E20 
X-CRM114-Status: GOOD (  17.94  )
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

On 10/31/25 07:12, Damien Le Moal wrote:
> The functions blk_zone_wplug_handle_reset_or_finish() and
> blk_zone_wplug_handle_reset_all() both modify the zone write pointer
> offset of zone write plugs that are the target of a reset, reset all or
> finish zone management operation. However, these functions do this
> modification before the BIO is executed. So if the zone operation fails,
> the modified zone write pointer offsets become invalid.
> 
> Avoid this by modifying the zone write pointer offset of a zone write
> plug that is the target of a zone management operation when the
> operation completes. To do so, modify blk_zone_bio_endio() to call the
> new function blk_zone_mgmt_bio_endio() which in turn calls the functions
> blk_zone_reset_all_bio_endio(), blk_zone_reset_bio_endio() or
> blk_zone_finish_bio_endio() depending on the operation of the completed
> BIO, to modify a zone write plug write pointer offset accordingly.
> These functions are called only if the BIO execution was successful.
> 
Hmm.
Question remains: what _is_ the status of a write pointer once a
zone management operation is in flight?
I would argue it's turning into a Schroedinger state, and so we
cannot make any assumptions here.
In particular we cannot issue any other write I/O to that zone once
the operation is in flight, and so it becomes meaningless if we set
the write pointer before or after the zone operation.
Once the operation fails we have to issue a 'report write pointer'
command anyway as I'd be surprised if we could assume that a failure
in a zone management command would leave the write pointer unmodified.
So I would assume that zone write plugging already blocks the zone
while an zone management command is in flight.
But if it does, why do we need this patch?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

