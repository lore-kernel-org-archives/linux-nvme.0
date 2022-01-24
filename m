Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D62C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jan 2022 23:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sbJA2xuz3URkRYCZHu8yHlPerUmywWzM55rS4FYvDFo=; b=yOqntQrOsVM+ncS/IG8pSHFTMU
	9TWD1iEV5THlp/YV1ZsYwZRVGHLoyen6blWY8aXxo+3wedfJLEg4GCtpQGwKW5+hTKVN3+9nidJd0
	fh8d20zld3F5BZaWDQFvW7hNLfU/8i40AG4Jz5RdufQ253AEBE2PIqN0zaTz0kFGHSFfZXQXCzlEz
	7Ppebe5f50js7tCNRRSRYc6cLTKq3Ot2t81Ee1DyXdCh2RlzdYYevvM3VzM27uuyki6vKkdxf4aJB
	ItVT7Ex+y2c0RTLzdEqL5QoEOF/3gHGS7fxtvDUx3dHs91KcP1tifNFKimNYDLjM+K6nmAlvsWLXm
	ZwrQkNIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nC8Sw-005Xq0-IO; Mon, 24 Jan 2022 23:09:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nC8St-005Xp9-So
 for linux-nvme@lists.infradead.org; Mon, 24 Jan 2022 23:09:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643065773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sbJA2xuz3URkRYCZHu8yHlPerUmywWzM55rS4FYvDFo=;
 b=DiQaHjYljSjach8eCcIyWRDBmmmNX3C1zd62irzoOFLv7E6b2Hrnx/U22tH+K7IijKXCku
 /NbR4bF0OK4ek0pyJxD8RsglyliLAuIGMVKjKEpg5Q3/kFYDH4cKFxSiosvkzOWMZUYZMj
 oMwA4UuhsU7L8DKUTdsp3b4wl+T9ywQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333--DPA2fEiNG2r-rihv1RRCg-1; Mon, 24 Jan 2022 18:09:32 -0500
X-MC-Unique: -DPA2fEiNG2r-rihv1RRCg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF8AF1B18BC0;
 Mon, 24 Jan 2022 23:09:30 +0000 (UTC)
Received: from T590 (ovpn-8-21.pek2.redhat.com [10.72.8.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D98845ED44;
 Mon, 24 Jan 2022 23:09:14 +0000 (UTC)
Date: Tue, 25 Jan 2022 07:09:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH V2 05/13] block: only account passthrough IO from userspace
Message-ID: <Ye8xleeYZfmwA3D7@T590>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
 <20220122111054.1126146-6-ming.lei@redhat.com>
 <20220124130555.GD27269@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124130555.GD27269@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_150936_052164_BE0FE6BD 
X-CRM114-Status: GOOD (  21.05  )
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

On Mon, Jan 24, 2022 at 02:05:55PM +0100, Christoph Hellwig wrote:
> On Sat, Jan 22, 2022 at 07:10:46PM +0800, Ming Lei wrote:
> > Passthrough request from userspace has one active block_device/disk
> > associated, so they can be accounted via rq->q->disk. For other
> > passthrough request, there may not be disk/block_device for the queue,
> > since either the queue has not a disk or the disk may be deleted
> > already.
> > 
> > Add flag of BLK_MQ_REQ_USER_IO for only accounting passthrough request
> > from userspace.
> 
> Please explain why you want to change this.

Please see the following code:

        /* passthrough requests can hold bios that do not have ->bi_bdev set */
        if (rq->bio && rq->bio->bi_bdev)
                rq->part = rq->bio->bi_bdev;
        else if (rq->q->disk)
                rq->part = rq->q->disk->part0;

q->disk can be cleared by disk_release() just when referring the above line, then
NULL ptr reference is caused, and similar issue with any reference to rq->part for
passthrough request sent not from userspace.

> 
> Also this is missing I/O from /dev/sg, CDROM CDDA BPC reading, the tape
> drivers and bsg-lib.

Except for CDROM CDDA BPC reading, the others don't have gendisk associated,
so they needn't such change. And it looks easy to do that for CDROM CDDA BPC
reading.


Thanks,
Ming


