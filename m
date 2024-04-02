Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9567FC6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 18:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FPQkd5zu6C1/+k4GfuvHQdVyB/R8CdMAIKEzldm7abw=; b=A0htBQFy9yGN8bujDJlMWly1sl
	Thvdb/Ui+FWh9YrQSU2U8YrVfySHq7UROccxAX7mNpenr5gNZLg2/4pB4uBOgXLeu30ivznbjMfQ7
	Gn/siUPCZp/loA8uUMfwJNWXzQwNCUvXKIWCAb5j0E4qPh7r0QYefUDYgbq6d+7x6z/tS9LtlzSl7
	0Tj54FgbjEIYj9jvrpfL6q/qQ6whGq0/i5TPLv/uDNXktSacdUixwh7EiXovFB5Z5xaUZxGeGmATk
	lxry+djED7+iyjKzZsJ7YH95cEnaaPRnrFTfguF78YUux3nXB21xq6NV5rZd1cnEnSBasVu1KEPwb
	VIM4GAYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rriVX-0000000CIVI-1ifb;
	Tue, 02 Apr 2024 18:05:15 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rriVJ-0000000CIRV-1i7G
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 18:05:04 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE64C5C0EC;
	Tue,  2 Apr 2024 18:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712081098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FPQkd5zu6C1/+k4GfuvHQdVyB/R8CdMAIKEzldm7abw=;
	b=bsn5Zk8VgLt72aCAhN5unPjcE2081lTCngz4plimtsJNixERSgMloCO5iAxG1OuzTrvJW/
	SQ8Lyg29lFuPvlqgHS02jZI8KINxweUoLzoVO+1+KhE4OoRBT3mNRzvCKT+sDzI9DUNJKU
	vSKkkV/ltiRt/wZrT64GoXo/5lB488I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712081098;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FPQkd5zu6C1/+k4GfuvHQdVyB/R8CdMAIKEzldm7abw=;
	b=H+ef85c8crymYbZjEYw/y+a0iP991AZDJgJ8NI1nXTqpz2kZvCIJeOKQVi4Ui/bZxYJ3o3
	1it2yRMI7kGx3TAw==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A70913A90;
	Tue,  2 Apr 2024 18:04:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ocGyD8pIDGbwMAAAn2gu4w
	(envelope-from <hare@suse.de>); Tue, 02 Apr 2024 18:04:58 +0000
Message-ID: <4bfe5995-2607-45b7-a104-0a01e27c28bf@suse.de>
Date: Tue, 2 Apr 2024 20:04:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/28] block: Remember zone capacity when revalidating
 zones
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240402123907.512027-1-dlemoal@kernel.org>
 <20240402123907.512027-7-dlemoal@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240402123907.512027-7-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_110501_732760_283164AE 
X-CRM114-Status: GOOD (  16.05  )
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

On 4/2/24 14:38, Damien Le Moal wrote:
> In preparation for adding zone write plugging, modify
> blk_revalidate_disk_zones() to get the capacity of zones of a zoned
> block device. This capacity value as a number of 512B sectors is stored
> in the gendisk zone_capacity field.
> 
> Given that host-managed SMR disks (including zoned UFS drives) and all
> known NVMe ZNS devices have the same zone capacity for all zones
> blk_revalidate_disk_zones() returns an error if different capacities are
> detected for different zones.
> 
> This also adds check to verify that the values reported by the device
> for zone capacities are correct, that is, that the zone capacity is
> never 0, does not exceed the zone size and is equal to the zone size for
> conventional zones.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-zoned.c      | 26 ++++++++++++++++++++++++++
>   include/linux/blkdev.h |  1 +
>   2 files changed, 27 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


