Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BC1CD11C2
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Apr 2024 06:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BNLgUz/+lOOfevg+dkBVhtWYDruDKjanIbvBZcBNA/0=; b=VckTONwzRtyoQRKZpZ6YOqb9/N
	ClhKrkC5rS9TgTpzWU/hlET0lQdz4RZSwjYCqh4K4Ba0coQKjXEmN/i6y2wJpxnv0Q/LIdfyFGiyv
	cUV7C+QUBBRHF7GGMM0RPl9ZRkys54Om//sgEKDY3RX4TdIgtjc/b/5lQOvq8MOa2AcXvFyZlviH3
	n3uhp4WuUsSN4DanVQo2Y/5v0+oxeYK3pHeYbjmJNI557sp0Umwk0ud5wFsuD7HECs4HoA6cUZu9r
	WotHdb3xK9A++z44Hazuaf9agE5VkB8dQeEqObUGg4AZoUAdvMs0DNEIzMRkiiaXTcK7irrPpnpWw
	xnPOoUdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rscoH-00000005Pf3-1313;
	Fri, 05 Apr 2024 06:12:21 +0000
Received: from out-185.mta0.migadu.com ([91.218.175.185])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rscoE-00000005PbU-080X
	for linux-nvme@lists.infradead.org;
	Fri, 05 Apr 2024 06:12:19 +0000
Date: Fri, 5 Apr 2024 02:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712297526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BNLgUz/+lOOfevg+dkBVhtWYDruDKjanIbvBZcBNA/0=;
	b=IRKs2zjYyJ+KMctnQ/0DhUhMApuNjL3MOVy2oE2cIRgQtQyuG8NLyNivvmfAB6NMHG59CY
	mySU2wZE4wOa4XuwJiuNgMUVdZiASjZtqJp5AynHbabVbPjawmiAQ4FO3HGKVrsGoDcHJs
	Td/GPXPJIlnETLxp8CXjqtVEV0OjDw8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, lsf-pc@lists.linux-foundation.org, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "kbusch@kernel.org" <kbusch@kernel.org>, 
	"axboe@kernel.dk" <axboe@kernel.dk>, josef@toxicpanda.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [Lsf-pc] [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] Meta/Integrity/PI
 improvements
Message-ID: <2zvjinuyaxg22d4az76n3ad7injl7ru46xzh64tuqtx3qrtwzo@zhdq434oypwg>
References: <CGME20240222193304epcas5p318426c5267ee520e6b5710164c533b7d@epcas5p3.samsung.com>
 <aca1e970-9785-5ff4-807b-9f892af71741@samsung.com>
 <yq14jdu7t2u.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq14jdu7t2u.fsf@ca-mkp.ca.oracle.com>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_231218_439804_193478D2 
X-CRM114-Status: GOOD (  23.20  )
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

On Mon, Feb 26, 2024 at 06:15:19PM -0500, Martin K. Petersen wrote:
> 
> Kanchan,
> 
> > - Generic user interface that user-space can use to exchange meta. A
> > new io_uring opcode IORING_OP_READ/WRITE_META - seems feasible for
> > direct IO.
> 
> Yep. I'm interested in this too. Reviving this effort is near the top of
> my todo list so I'm happy to collaborate.
> 
> > NVMe SSD can do the offload when the host sends the PRACT bit. But in
> > the driver, this is tied to global integrity disablement using
> > CONFIG_BLK_DEV_INTEGRITY.
> 
> > So, the idea is to introduce a bio flag REQ_INTEGRITY_OFFLOAD
> > that the filesystem can send. The block-integrity and NVMe driver do
> > the rest to make the offload work.
> 
> Whether to have a block device do this is currently controlled by the
> /sys/block/foo/integrity/{read_verify,write_generate} knobs. At least
> for SCSI, protected transfers are always enabled between HBA and target
> if both support it. If no integrity has been attached to an I/O by the
> application/filesystem, the block layer will do so controlled by the
> sysfs knobs above. IOW, if the hardware is capable, protected transfers
> should always be enabled, at least from the block layer down.
> 
> It's possible that things don't work quite that way with NVMe since, at
> least for PCIe, the drive is both initiator and target. And NVMe also
> missed quite a few DIX details in its PI implementation. It's been a
> while since I messed with PI on NVMe, I'll have a look.
> 
> But in any case the intent for the Linux code was for protected
> transfers to be enabled automatically when possible. If the block layer
> protection is explicitly disabled, a filesystem can still trigger
> protected transfers via the bip flags. So that capability should
> definitely be exposed via io_uring.

I've little interest in checksum calculation offload - but protected
transfers are interesting.

bcachefs moves data around in the background (copygc, rebalance), and
whenever we move existing data we're careful to carry around the
existing checksum and revalidate it at every step, and when we have to
compute a new checksum (fragmenting an existing extent) we compute new
checksums and check that they sum up to the old checksum.

It'd be pretty cool to push this down into the storage device (and up
into the page cache as well).

