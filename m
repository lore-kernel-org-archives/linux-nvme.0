Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9330DC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jan 2022 06:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LsWkgp182FPHrF7UkZC+uJp0DngW7t6rcOLnMdzViXk=; b=BVXQu8DmINKEDjsXrZAURvSGsz
	keHoPQ3Hfuz66s/Jtscv57ehAk1YbDwvRriTyhrnynlzDCDhb2YQAPDkWA0ISJNIwaX3QwUxDnAGP
	15u3rBan+ffNQGmN9OFQvgxuib+mYC4/VD2RGyvRo1AUu3Yt32w4/S6KomVhN1ZQfPYBdN3ntetM/
	o4eOnFZ/1zbC97aQ/7Zs0ldCm83KpX6vKQccVTKZudqO0oju3tGUR/hrVTjCey4IsYBk5LxrUii4/
	/oECHeSFHJZn8z9yjwtOOCvPGQ5PW26meq6yJ9a3AJ+BXZAXGOCRua/bus52z8tVjAW7V0bFMCDjl
	0Oi0/rmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCF8E-006XvC-EM; Tue, 25 Jan 2022 06:16:42 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCF8B-006Xus-Jo
 for linux-nvme@lists.infradead.org; Tue, 25 Jan 2022 06:16:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 96C0868BFE; Tue, 25 Jan 2022 07:16:34 +0100 (CET)
Date: Tue, 25 Jan 2022 07:16:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH V2 05/13] block: only account passthrough IO from userspace
Message-ID: <20220125061634.GA26495@lst.de>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
 <20220122111054.1126146-6-ming.lei@redhat.com>
 <20220124130555.GD27269@lst.de> <Ye8xleeYZfmwA3D7@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye8xleeYZfmwA3D7@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_221639_823537_BA9092B1 
X-CRM114-Status: GOOD (  17.03  )
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

On Tue, Jan 25, 2022 at 07:09:09AM +0800, Ming Lei wrote:
> > Please explain why you want to change this.
> 
> Please see the following code:

This needs to go into the commit log.

> 
>         /* passthrough requests can hold bios that do not have ->bi_bdev set */
>         if (rq->bio && rq->bio->bi_bdev)
>                 rq->part = rq->bio->bi_bdev;
>         else if (rq->q->disk)
>                 rq->part = rq->q->disk->part0;
> 
> q->disk can be cleared by disk_release() just when referring the above line, then
> NULL ptr reference is caused, and similar issue with any reference to rq->part for
> passthrough request sent not from userspace.

So why not key off accouning off "rq->bio && rq->bio->bi_bdev"
and remove the need for the flag and the second half of the assignment
above?  That is much less error probe and removes code size.

