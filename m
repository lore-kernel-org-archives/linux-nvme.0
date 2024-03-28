Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A910CD11DD
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 22:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IVxtrsQyU59W5Vggd5LI5HVPrndB9GeCBj+KxNWWa4c=; b=HQRcdSIbR4o3f/r6VD9shhFur0
	DQzPpKlDt/PtfR9uIoo/J4WP09PPfHzgN5/cjidctPds+ciudufWqNZjxxmj+r8kaxkLuBFgxZcpi
	yjWXwC+qddMzItn/3JeLBzTxMdpG0MiVH+69EoSH7HjqgVzSLKpD6j/FZhZuignpFvFC5b+gRmeBM
	JX1TkLutGCr42Q9fmBuSzqWwVlCuBa61v7RJ3SUq5XtHX9qPtx1F8/Yf5Ptw7qeTgrUnUWdwyw1C7
	yU66Y55QoQD5Mb8JnjpxB6nTbJkAdehoSwSeoze82xp8jrU/aSAjRGgX2nkPDsLTPFukydGsuTYmx
	bEOZLzVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpyFR-0000000Fwf0-18K7;
	Thu, 28 Mar 2024 22:29:25 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpyFK-0000000Fwee-19uH
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 22:29:19 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4V5J9n5gCFz6Cnk8t;
	Thu, 28 Mar 2024 22:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711664954; x=1714256955; bh=IVxtrsQyU59W5Vggd5LI5HVP
	rndB9GeCBj+KxNWWa4c=; b=WGRjrY8Mbq21ADwKQKBYOrZXqMNykXjiqMsEqSvk
	ynupNMIjngpQPs4evEW+Rpz3ctV1rFfX+1jtgCu9VOYd4CNoDHRDKelaYDXdgCX5
	5stoUEXe2mg9EY2PN4lB5EA+WcKCPM74Q4fqCMAw5yemE0ZTs6LumG5lrYsB+QWe
	tPLkTEvlEuXI/J5WIyT5cPAlrry5gcU8lpQx/65gqjmDS6/ahBvGcmks6ydEaQtf
	2bZHYtZXIezOuQj/KILkUWHqlpdQDhLDOy+c91yTLEOnkyocvWgRuDrBnPBItrsj
	YmkH0xsbf33dTvoGc5c08l2tfxOY1r7sRzLxYutGwjb0Lg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id H57sQG6YDuzT; Thu, 28 Mar 2024 22:29:14 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4V5J9j06CYz6Cnk8m;
	Thu, 28 Mar 2024 22:29:12 +0000 (UTC)
Message-ID: <5f98992d-e94a-4558-84bf-2602a13b6f74@acm.org>
Date: Thu, 28 Mar 2024 15:29:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/30] block: Pre-allocate zone write plugs
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-10-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240328004409.594888-10-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_152918_361712_BAE40A24 
X-CRM114-Status: GOOD (  14.03  )
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

On 3/27/24 5:43 PM, Damien Le Moal wrote:
> Allocating zone write plugs using kmalloc() does not guarantee that
> enough write plugs can be allocated to simultaneously write up to
> the maximum number of active zones or maximum number of open zones of
> a zoned block device.
> 
> Avoid any issue with memory allocation by pre-allocating zone write
> plugs up to the disk maximum number of open zones or maximum number of
> active zones, whichever is larger. For zoned devices that do not have
> open or active zone limits, the default 128 is used as the number of
> write plugs to pre-allocate.
> 
> Pre-allocated zone write plugs are managed using a free list. If a
> change to the device zone limits is detected, the disk free list is
> grown if needed when blk_revalidate_disk_zones() is executed.

Is there a way to retry bio submission if allocating a zone write plug
fails? Would that make it possible to drop this patch?

Thanks,

Bart.


