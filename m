Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006F9C2BA4C
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jan 2022 17:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/EUaEJHXJBMsU4sa5f2ZGscvSxzn8KsfEJyl3ExoxSk=; b=DJmijtyMSpjDtMV6j9U3fvmkdE
	GsPCGUdejGRpC/QINENC0hqrY4wlGR1wHcqhvQ01HEypLys8O3DDLAcbdpKIU1oXg9OxKbvMpOB3n
	AWWS6sIm6ix89wVWLrYCTpnNcWx8ZR18grBt6Rb1goEBFpIoID4DqrcdQQOJV6TXfMXUCcHo+GUiK
	Y1HGKCgRBhA9bA4nouqX3tTVbIgt80P7WIklyK/Igm5E2AEH1ehSM39AoWgZAxp2JQqWT3f2OEUDM
	gWx1FwQH4Bmv8dlnO2P19poGtYmmYqFVEriTq4lu66mnx2dPxrI4kTZmz4yLsfyxXCZPdbwlXC1QH
	/tIvYFPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCm2g-00Cz49-Mm; Wed, 26 Jan 2022 17:25:10 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nClIZ-00Cgfh-I5
 for linux-nvme@lists.infradead.org; Wed, 26 Jan 2022 16:37:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 500F768AFE; Wed, 26 Jan 2022 17:37:28 +0100 (CET)
Date: Wed, 26 Jan 2022 17:37:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH V2 05/13] block: only account passthrough IO from userspace
Message-ID: <20220126163728.GA31935@lst.de>
References: <Ye8xleeYZfmwA3D7@T590> <20220125061634.GA26495@lst.de>
 <20220125071906.GA27674@lst.de> <Ye++VmBkg0I8Lq8+@T590>
 <20220126055003.GA21089@lst.de> <YfD2YNRf+lhe5BcU@T590>
 <20220126081052.GA23154@lst.de> <YfEHcs6psrBqFu3l@T590>
 <20220126084950.GA23957@lst.de> <YfEbbPr1Q5Ci48cg@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfEbbPr1Q5Ci48cg@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220126_083731_798887_CAD89F3C 
X-CRM114-Status: GOOD (  16.13  )
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

On Wed, Jan 26, 2022 at 05:59:08PM +0800, Ming Lei wrote:
> nvme just sets part0 to rq->bio, which is fine since nvme doesn't
> support partial completion.
> 
> The simplest way could be to assign bio->bi_bdev with q->disk->part0 in both
> bio_copy_user_iov() and bio_map_user_iov(), which should cover most of cases.
> Given user io is always on device instead of partition even though the
> command is sent via partition bdev.

This would be easiest, but it would also assign them when called from
the SG driver.  And that means these I/Os could be in flight when
detaching a SCSI ULP.  At least without the freeze in del_gendisk
(or the local one in case of the sd driver).

