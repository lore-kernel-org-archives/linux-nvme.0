Return-Path: <SRS0=i2V4=PV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AB7C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Nov 2021 17:04:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07CEA60E9B
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Nov 2021 17:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 07CEA60E9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3bBcvFcyfbMgkxTabHoDugt0QDDF2AsVik61xYhcvY8=; b=l3bBzcYGM9NIQncpWcEyOMtpCp
	HBa0ZdWUF/JhfqWov8lDa02KHa+MwXsEfAxx79xqoRAY3HX1kJ7NPoV424iqiYsuyfOiYflKilc9d
	EzulbRImN4eeV9NCtX2cJ2G6g+6urXhWOugPqdlQRdAvNMjVsS3LzE/A+DM2PRLsyWoYHIT1hDLk0
	4l5Qbr3fSUpL8T1yyJ001cTa772gENQRbtdWKfo0eW7UHPMaiSgSSZhqHzjtp4T4vawr85O3PiuJM
	allh1/wB0TZUTfZ20FAMQ+Hay8fEEWmq5kFMIy6G9MRA0gUx+jpGAAs6yawDwgpI1ZaOgvF8xj3VA
	cMbs0Bvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mhxCg-002RRQ-Gx; Tue, 02 Nov 2021 17:04:06 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mhxCQ-002RP3-6N; Tue, 02 Nov 2021 17:03:50 +0000
Date: Tue, 2 Nov 2021 10:03:50 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Geoff Levand <geoff@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jim Paris <jim@jtan.com>,
 Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
 senozhatsky@chromium.org, Richard Weinberger <richard@nod.at>,
 miquel.raynal@bootlin.com, vigneshr@ti.com,
 Vishal L Verma <vishal.l.verma@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,
 "Weiny, Ira" <ira.weiny@intel.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-mtd@lists.infradead.org, Linux NVDIMM <nvdimm@lists.linux.dev>,
 linux-nvme@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/13] nvdimm/btt: do not call del_gendisk() if not needed
Message-ID: <YYFvdiOYoqRPx8JE@bombadil.infradead.org>
References: <20211015235219.2191207-1-mcgrof@kernel.org>
 <20211015235219.2191207-4-mcgrof@kernel.org>
 <CAPcyv4gU0q=UhDhGoDjK1mwS8WNcWYUXgEb7Rd8Amqr1XFs6ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gU0q=UhDhGoDjK1mwS8WNcWYUXgEb7Rd8Amqr1XFs6ow@mail.gmail.com>
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

On Sun, Oct 31, 2021 at 10:47:22AM -0700, Dan Williams wrote:
> On Fri, Oct 15, 2021 at 4:53 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > We know we don't need del_gendisk() if we haven't added
> > the disk, so just skip it. This should fix a bug on older
> > kernels, as del_gendisk() became able to deal with
> > disks not added only recently, after the patch titled
> > "block: add flag for add_disk() completion notation".
> 
> Perhaps put this in:
> 
>     commit $abbrev_commit ("block: add flag for add_disk() completion notation")
> 
> ...format, but I can't seem to find that commit?

Indeed, that patch got dropped and it would seem Christoph preferred
a simpler approach with the new disk_live()

commit 40b3a52ffc5bc3b5427d5d35b035cfb19d03fdd6
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed Aug 18 16:45:32 2021 +0200

    block: add a sanity check for a live disk in del_gendisk

> If you're touching the changelog how about one that clarifies the
> impact and drops "we"?
> "del_gendisk() is not required if the disk has not been added. On
> kernels prior to commit $abbrev_commit ("block: add flag for
> add_disk() completion notation")
> it is mandatory to not call del_gendisk() if the underlying device has
> not been through device_add()."
> 
> Fixes: 41cd8b70c37a ("libnvdimm, btt: add support for blk integrity")
> 
> With that you can add:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

You got it.

  Luis

