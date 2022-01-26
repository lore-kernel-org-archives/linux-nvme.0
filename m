Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766F1C28CF5
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jan 2022 08:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gEUGLzp3K3Ka5xmeccgBixQP0B4yiVBBrDcf4TfGoGo=; b=uXxSxG77v2RbpAxo8KIc1YkGLw
	T3UVYwk9NdGoHK3gflkdEZ0Bjmxqs6mwbp7F4GprD7pk4ZgBdn44Ti2UR7uA9TlmfvEyHFw2oaox7
	IqZnT9ut0H7KhgVszbDQvzj3sfVWAsPzzBk5Oh3D6fIQOv+JrAB3tdIwn2u6mVLx+C/Dz7ECLg5kO
	z2owipCmozcm3NO0FDuEqYC682u5wEL/gHOHRr9dPdGp1dtdKcfhuzp1PSxjsMXaxPX1IkdKjPLaN
	Kup4fQcyYpJn/Po30bnl+XNPBxvprf2nm7BehOHZvrVDVbOx5TgU8fAvs3C0YjWZupv3FzLJ+GTKE
	ZQ06K0bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCdOP-00AdtV-T6; Wed, 26 Jan 2022 08:11:01 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCdON-00Adro-Im
 for linux-nvme@lists.infradead.org; Wed, 26 Jan 2022 08:11:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DB70F68AFE; Wed, 26 Jan 2022 09:10:52 +0100 (CET)
Date: Wed, 26 Jan 2022 09:10:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH V2 05/13] block: only account passthrough IO from userspace
Message-ID: <20220126081052.GA23154@lst.de>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
 <20220122111054.1126146-6-ming.lei@redhat.com>
 <20220124130555.GD27269@lst.de> <Ye8xleeYZfmwA3D7@T590>
 <20220125061634.GA26495@lst.de> <20220125071906.GA27674@lst.de>
 <Ye++VmBkg0I8Lq8+@T590> <20220126055003.GA21089@lst.de>
 <YfD2YNRf+lhe5BcU@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfD2YNRf+lhe5BcU@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220126_001059_811105_A6FB44EA 
X-CRM114-Status: GOOD (  22.53  )
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

On Wed, Jan 26, 2022 at 03:21:04PM +0800, Ming Lei wrote:
> > I think the right way would be to just remove this branch entirely.
> > This means we only account bios with a block_device, which implies
> > they have a gendisk.
> 
> That will not account userspace IO, and people may complain.
> 
> We can just account passthrough request from userspace by the patch
> in my last email.

Let's take a step back:  what I/O do we want to account, and how
do we want to archive that?

Assuming accounting is enabled:

 - current mainline accounts all I/O one queues that have a gendisk
 - your original patch accounts file system I/O and some passthrough I/O
   that has a special flag set

Dropping the conditional to grab a bdev from the queue leaves us with
the following rule:

 - all I/O that has a bio and bdev is accounted.  This requires
   passthrough I/O to explicitly set the bdev in case we haven't
   done so, and it requires them to have a bio at all

I guess you are worried about the latter conditionin that we stop
accounting for no data transfer passthrough commands?

