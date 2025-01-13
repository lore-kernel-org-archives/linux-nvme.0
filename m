Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A773CE7719E
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2025 07:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZEbXcZ9FxU3Bzk1bmtL3avw4j+KWudt6f1gRaHYmg5Q=; b=JwX1OohNE07DLX1eO+GhDTzCEX
	FDuDXIpYJQjPpdtMw7hOeWkWZ/+Ym0ksVMim+sFYAtqAL/rFnrX/mjdr2EbRyylDplB0Ytdb+pFY9
	VkwqIR+eActVusTXAQcR0Z/vMwiaOmLkIBdAoVkfho9mlzgEUgkbs8uYyVV/gRE4Ee153x4nY9UUI
	OlKk68583S7GPn+PqPZM3CK+0XvmFniOKmDzTXAPNe8VVJUrf7sCBYUD1YESqIgtI692dvlPoyx4C
	MEB5RkZuEAJ6hbuO6oM3/7zE6Y4LSZEtp4q5GBOQbrzO70byfVBzTUNdZyKdpcahgL3w+xnRJ8gBt
	Lu2mGz8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXElA-00000004Eae-4BoU;
	Mon, 13 Jan 2025 07:21:17 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXEkv-00000004EYB-1Dvc
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jan 2025 07:21:02 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B369F1F37C;
	Mon, 13 Jan 2025 07:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736752860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEbXcZ9FxU3Bzk1bmtL3avw4j+KWudt6f1gRaHYmg5Q=;
	b=PZUS77tyQYwRnu51vZOKBXdK4rlU4q1hpLT9lqdouVhCsk+JzZcf1xBbGfVWob7RQ0J8cN
	86tPfg+LekyxIogIK0hNKSHBn3jbv6WqRt77RD6CgspQ+My/6iQ38Od1X0dFJbaYCXUDuj
	qTH5iJuT3Fm937u/u8JS/EokyK8Gg/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736752860;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEbXcZ9FxU3Bzk1bmtL3avw4j+KWudt6f1gRaHYmg5Q=;
	b=8SuTSKBJPk5fwEiApCx9Eqjh7ZqauNIoUibzOwttCsx0JUg/QzjfC3jrk8luPYaEqfU3kv
	SBFif2m7vfHwjvCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736752858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEbXcZ9FxU3Bzk1bmtL3avw4j+KWudt6f1gRaHYmg5Q=;
	b=MjtXgVxq1OtTPfOK7Yma44e60zsgNZ8+Gdfv11J/rbGVbuHUJQRIJCMmPHnQYwojIdjM6m
	mmWDBdaKMzUInGUKoJwHOKUrVQmTAc+MJHyaXCBfYSY0YGbQPDWPkdvkvcLSYK90Iv/jX2
	lxG6WvIJYq3mkn8ka+YLurusyOrSBxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736752858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEbXcZ9FxU3Bzk1bmtL3avw4j+KWudt6f1gRaHYmg5Q=;
	b=M9wkXZbberAdazkx/1bXDdLQznZ3lHGMnegB/DBFvw9x/jSt8jdgzG2ptRSPCwTudWg0Ku
	na7jC8ZS2PfXUNDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4679713310;
	Mon, 13 Jan 2025 07:20:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1/ZsD9q+hGcZLQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Jan 2025 07:20:58 +0000
Message-ID: <15cb40c2-df67-423d-a15c-c55e2bb2b8a9@suse.de>
Date: Mon, 13 Jan 2025 08:20:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] block: add a queue_limits_commit_update_frozen
 helper
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, nbd@other.debian.org,
 linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
References: <20250108092520.1325324-1-hch@lst.de>
 <20250108092520.1325324-3-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250108092520.1325324-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250112_232101_484294_5844A1A0 
X-CRM114-Status: GOOD (  11.54  )
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

On 1/8/25 10:24, Christoph Hellwig wrote:
> Add a helper that freezes the queue, updates the queue limits and
> unfreezes the queue and convert all open coded versions of that to the
> new helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-integrity.c      |  4 +---
>   block/blk-settings.c       | 24 ++++++++++++++++++++++++
>   block/blk-zoned.c          |  7 +------
>   drivers/block/virtio_blk.c |  4 +---
>   drivers/scsi/sd.c          | 17 +++++------------
>   drivers/scsi/sr.c          |  5 +----
>   include/linux/blkdev.h     |  2 ++
>   7 files changed, 35 insertions(+), 28 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

