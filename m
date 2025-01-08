Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E0FE77188
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2025 10:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MCI+7xV/HCNzqE2MRTPEy2ckmf1AuTtWqGP+r5bI7Nw=; b=fv321jiteHqDzlHasx0KSlfekA
	8fVqOBi/op9ujKM/0SXnmPQR07wbPZ7TgtCgOEeidKJ0K2fUNkFBJyGN3j0YHSKlzn3Pxiy601TQv
	xLwMtTSK08dI+smCsiuin0T2ipOHk3iw9vhZiqaUHs06zmGNPCSWV2wNjQToHwI38n04dJ52NVMww
	uaxxuU/QO0GkoFeBLpJ/JZnJd7R5X81GOizDS3b25d6YDUejziW1xcMTmLPPu0HYkV5HOSLfXVWeu
	YAKC5F7/wUfnOPIuuj14qna8w9jx4Facm+oWMXEgltm00wZTU6juAjxh1muJREgFwIWk9KWKWDylr
	Q62wwJVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTE9-00000007yJ4-2jMV;
	Wed, 08 Jan 2025 10:23:53 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVT9W-00000007x5y-14w7
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jan 2025 10:19:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D0B9DA4073C;
	Wed,  8 Jan 2025 10:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E0BC4CEE0;
	Wed,  8 Jan 2025 10:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736331545;
	bh=dkqDR05KFDLNT/Pbc9CxeI0diORr/6V3vHanHq4U2l4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jvKNWS4v+PqOHtv4hV9noqVZ9/EmiKq07PFogOqviiUsQV//u5k/Sfp1w4KVlDYn2
	 nPl0o40WeNGO4W7f/P/e2xwrjsjb0pi4uU7m0e0UIQnMfK7pO4DECHLNAWPUPrggSj
	 T6+yr73UvUnY7WRPKDLRQwZ7ywYY3P9WMLg0x8AbmaalOvI4CnN6A9Q5MdRkna60aD
	 MaGJmA2wpqp2JVuohGbuO0JyCjsW2mMamZBs0F+DCw9z/eVaZWS2Flt9Qmmj7EzrC4
	 nZM2id5Dw8bEXYZzVPZJSAJ7+dI45N5gfaGVD0aTptnE1yB/eDbOAoeDzZhaFHoWZZ
	 +7qGNPY18A5UA==
Message-ID: <878a32c6-fbee-400f-891d-09db146db572@kernel.org>
Date: Wed, 8 Jan 2025 19:18:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] block: fix queue freeze vs limits lock order in
 sysfs store methods
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 nbd@other.debian.org, linux-scsi@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net
References: <20250108092520.1325324-1-hch@lst.de>
 <20250108092520.1325324-6-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250108092520.1325324-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_021906_365596_BD48F517 
X-CRM114-Status: GOOD (  13.68  )
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

On 1/8/25 6:25 PM, Christoph Hellwig wrote:
> queue_attr_store() always freezes a device queue before calling the
> attribute store operation. For attributes that control queue limits, the
> store operation will also lock the queue limits with a call to
> queue_limits_start_update(). However, some drivers (e.g. SCSI sd) may
> need to issue commands to a device to obtain limit values from the
> hardware with the queue limits locked. This creates a potential ABBA
> deadlock situation if a user attempts to modify a limit (thus freezing
> the device queue) while the device driver starts a revalidation of the
> device queue limits.
> 
> Avoid such deadlock by not freezing the queue before calling the
> ->store_limit() method in struct queue_sysfs_entry and instead use the
> queue_limits_commit_update_frozen helper to freeze the queue after taking
> the limits lock.
> 
> (commit log adapted from a similar patch from  Damien Le Moal)
> 
> Fixes: ff956a3be95b ("block: use queue_limits_commit_update in queue_discard_max_store")
> Fixes: 0327ca9d53bf ("block: use queue_limits_commit_update in queue_max_sectors_store")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

