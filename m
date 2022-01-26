Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4E9C2BA4C
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jan 2022 09:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zMHF6f0MT3+XJF4o6Gm2OrzeZ0dXQYMGKwzgfSSU6fw=; b=fcL3y6gAypxfk6SWi1zbpSrLO2
	+bFEToGmUur07eYHRVhn+/9PqTwtjX+Dj0L+Q6hMTbakgO+xfknrOuqGqhssYWioFMA20mEAWlB6m
	jTqztZmtBABO2wYHHXTfUZd4LYYryw7llZz/nkepx5wttW8i4lSpRJkKED1qJxKmHDNLo4jIUi97C
	lGmRj45H4Qtf9hy8qqPWRyA704TmUdgrbTilsOy/ztCBtGtIIZfTiSoKeQzStlFb7BBRBGp/bRNzV
	aEVsHED5x06/6DBPBzYrrNnjFC98d9IlFqbCHWS1yqYVM9ZWp1qd/V/ba1jJYmmEVyWMS3uqpmsPJ
	dhsEt0mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCf5Z-00B7Ib-Mk; Wed, 26 Jan 2022 09:59:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCf5X-00B7GC-9b
 for linux-nvme@lists.infradead.org; Wed, 26 Jan 2022 09:59:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643191178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zMHF6f0MT3+XJF4o6Gm2OrzeZ0dXQYMGKwzgfSSU6fw=;
 b=gjNu0ZfV71A4G6C7kBHqWgJilzaDTNmss0rLKp113odbCx8y1yNRLeExxtgQ2vXfPoEgwb
 aS3jATvRLvrgdmKj4faxji96cbRV+1wYv/xs/kS8+xkeGlDLx0zSoYIj+qujTAphMO+Wfs
 HEDzZYvjTEEnGUmExMyUbVXL0xULkFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-6Qau-70pOiqE3W5BYG2Naw-1; Wed, 26 Jan 2022 04:59:34 -0500
X-MC-Unique: 6Qau-70pOiqE3W5BYG2Naw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9978B51082;
 Wed, 26 Jan 2022 09:59:33 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C96E6128B;
 Wed, 26 Jan 2022 09:59:13 +0000 (UTC)
Date: Wed, 26 Jan 2022 17:59:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH V2 05/13] block: only account passthrough IO from userspace
Message-ID: <YfEbbPr1Q5Ci48cg@T590>
References: <20220124130555.GD27269@lst.de> <Ye8xleeYZfmwA3D7@T590>
 <20220125061634.GA26495@lst.de> <20220125071906.GA27674@lst.de>
 <Ye++VmBkg0I8Lq8+@T590> <20220126055003.GA21089@lst.de>
 <YfD2YNRf+lhe5BcU@T590> <20220126081052.GA23154@lst.de>
 <YfEHcs6psrBqFu3l@T590> <20220126084950.GA23957@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126084950.GA23957@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220126_015939_432567_1D63D9D7 
X-CRM114-Status: GOOD (  18.75  )
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

On Wed, Jan 26, 2022 at 09:49:50AM +0100, Christoph Hellwig wrote:
> On Wed, Jan 26, 2022 at 04:33:54PM +0800, Ming Lei wrote:
> > > I guess you are worried about the latter conditionin that we stop
> > > accounting for no data transfer passthrough commands?
> > 
> > No, I meant that bio->bi_bdev isn't setup yet for passthrough request,
> > and not sure that can be done easily.
> 
> Take a look at e.g. nvme_submit_user_cmd and iblock_get_bio.

nvme just sets part0 to rq->bio, which is fine since nvme doesn't
support partial completion.

The simplest way could be to assign bio->bi_bdev with q->disk->part0 in both
bio_copy_user_iov() and bio_map_user_iov(), which should cover most of cases.
Given user io is always on device instead of partition even though the
command is sent via partition bdev.


Thanks,
Ming


