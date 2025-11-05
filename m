Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311EBCCF9F8
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 07:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kXAgOysDR0iv133ShWDlyk3KMUK8BVW/8XvwvJquiOQ=; b=kUbrf5LRG28+Oodtq4vWmarz1B
	Wam79852Wnye/NB5eo/ljUH5+wUjtxiPmZH+PAnw0EiyvZUcXddwJd1mKPa3yK1qSXEKU9h4avbaa
	K/Ixmr37WtONd08X5+6E/Vqru7Gbx3DO3PwZawS4LfqYSn/d1PpNioV2zB9ROW4GNzucGZrBP3MBM
	HvnHyHJ09D8WEQ9ZosCr4bXVzGAA3uZuPhMgiKGnWdRg0FqFFTznpZCax6NDFHqMiwVEqPz4Ogr26
	+YjPl9Z2Cdt2Xs5NBmV2YBnzPOkPgVt3+mmzKicoGF8yxWiKwtmKmkTvhUrore8D1XN463i4a8Va0
	Ldkhncyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGXgy-0000000D9wu-2MZI;
	Wed, 05 Nov 2025 07:12:28 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGXgv-0000000D9vY-41ab
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 07:12:27 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 346F221192;
	Wed,  5 Nov 2025 07:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762326744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kXAgOysDR0iv133ShWDlyk3KMUK8BVW/8XvwvJquiOQ=;
	b=pqmBHcb7XXB95TPpLPCkl+GtTj4IiJO7d0f5GlP+7huYn75mVr7JE6ocMGHjNYFkg0J9WH
	O0ADkBjKjXPkBzcyL4ZxoXfHNVbVhqHlCmpcnR8K8ykFoHZoWaEgyDQpXFY/cZVR3RzYrQ
	Hgz7a3rul1kChFQy881nuSmM42D5bC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762326744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kXAgOysDR0iv133ShWDlyk3KMUK8BVW/8XvwvJquiOQ=;
	b=ukSI2R6tkOJ2cClSpz13q3BodZrZP1dJ3J5E3pMfKfdEzg7grpGHlUUy6dC/W3ONMD0C8r
	KX2mUUgn3sXoNTCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762326744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kXAgOysDR0iv133ShWDlyk3KMUK8BVW/8XvwvJquiOQ=;
	b=pqmBHcb7XXB95TPpLPCkl+GtTj4IiJO7d0f5GlP+7huYn75mVr7JE6ocMGHjNYFkg0J9WH
	O0ADkBjKjXPkBzcyL4ZxoXfHNVbVhqHlCmpcnR8K8ykFoHZoWaEgyDQpXFY/cZVR3RzYrQ
	Hgz7a3rul1kChFQy881nuSmM42D5bC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762326744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kXAgOysDR0iv133ShWDlyk3KMUK8BVW/8XvwvJquiOQ=;
	b=ukSI2R6tkOJ2cClSpz13q3BodZrZP1dJ3J5E3pMfKfdEzg7grpGHlUUy6dC/W3ONMD0C8r
	KX2mUUgn3sXoNTCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66445132DD;
	Wed,  5 Nov 2025 07:12:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vAbwFtf4CmmmFQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 05 Nov 2025 07:12:23 +0000
Message-ID: <c7d9f83b-34af-48f2-bab6-8c79c88f5104@suse.de>
Date: Wed, 5 Nov 2025 08:12:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/15] block: add zone write plug condition to debugfs
 zone_wplugs
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251104013147.913802-1-dlemoal@kernel.org>
 <20251104013147.913802-14-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251104013147.913802-14-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,wdc.com:email,lst.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_231226_139696_C6BAD562 
X-CRM114-Status: GOOD (  11.56  )
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

On 11/4/25 02:31, Damien Le Moal wrote:
> Modify queue_zone_wplug_show() to include the condition of a zone write
> plug to the zone_wplugs debugfs attribute of a zoned block device.
> To improve readability and ease of use, rather than the zone condition
> raw value, the zone condition name is given using blk_zone_cond_str().
> 
> Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-zoned.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

