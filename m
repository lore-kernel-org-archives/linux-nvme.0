Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2194CC5475B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 01:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2LrjpQ6/KtNA+kwv00MlTGCntAINDPjFBfmLOW4/G3E=; b=pD0HAcNW+Zq/KhVb6dmF3yvAD8
	wjnf99wiD/X5ppra5YhGLXQA9Ms00deBPCSEs7Q5G3XENsOt0578YsP1MjflZ9SRZUMvMhoox4QPq
	8RuAQzw3/4Xh7LymMBCU0OwcutnpocOJmOWK6R+UDYgH03iAbLqaVLMunt5LSY4teiFQKypmNRJS9
	GvvWQzV1Rl9H5A2ksExoDSiLHcaC0GFJE+3KgUTBCXo3PMkcGFujYNnByLcbGu4dH8SUREf4xxZ8d
	uVTYWqQUIGIRXuMRrF43FzcfHqJHWJd5mO4IW7Yw9t98CDxoqFzR9XIolRk05u8y6OToegqjN1GAO
	N1zhHwHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri32G-00000002aSA-2jBz;
	Thu, 07 Mar 2024 01:59:04 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri32D-00000002aQi-20ZG;
	Thu, 07 Mar 2024 01:59:01 +0000
Date: Wed, 6 Mar 2024 17:59:01 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Dave Chinner <david@fromorbit.com>,
	"kbus >> Keith Busch" <kbusch@kernel.org>,
	NeilBrown <neilb@suse.de>, Tso Ted <tytso@mit.edu>
Cc: Matthew Wilcox <willy@infradead.org>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jan Kara <jack@suse.cz>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@infradead.org>,
	Hannes Reinecke <hare@suse.de>,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
	lsf-pc@lists.linuxfoundation.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Large block for I/O
Message-ID: <ZekfZdchUnRZoebo@bombadil.infradead.org>
References: <4343d07b-b1b2-d43b-c201-a48e89145e5c@iogearbox.net>
 <03ebbc5f-2ff5-4f3c-8c5b-544413c55257@suse.de>
 <5c356222-fe9e-41b0-b7fe-218fbcde4573@acm.org>
 <ZYUbB3brQ0K3rP97@casper.infradead.org>
 <ZYUgo0a51nCgjLNZ@infradead.org>
 <9b46c48f-d7c4-4ed3-a644-fba90850eab8@acm.org>
 <ZZxOdWoHrKH4ImL7@casper.infradead.org>
 <ZdeWRaGQo1IX18pL@bombadil.infradead.org>
 <ZdvIlLbhtb7+1CTx@dread.disaster.area>
 <ZdytYs8W9o0CIu_C@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdytYs8W9o0CIu_C@bombadil.infradead.org>
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

On Mon, Feb 26, 2024 at 07:25:23AM -0800, Luis Chamberlain wrote:
> The only thing left worth discussing I think is if we want to let users to
> opt-in to 4k sector size on a drive which allows 16k atomics and
> prefers 16k for instance...

Thinking about this again, I get a sense things are OK as-is but
let's review. I'd also like to clarify that these drives keep a 4k
LBA format. The only thing that changes is an increased is the the IU
and large atomic. The nvme driver today sets the physical block size
to the min of both.

It is similar to a drive today with a logical block size of 512 but a
physical block size of 4k. That allows you to specify a larger sector
size to create the filesystem.

After reviewing again our current language for syfs parameters in
Documentation/ABI/stable/sysfs-block for logical and physical block size
and how nvme_update_disk_info() deals with NPWG (the IU used), NAWUPF
(namespace atomic) and NOWS (optimal write size), we seem to be using
it aready appropriately. However, I think the language used in the
original commit c72758f33784e ("block: Export I/O topology for block
devices and partitions") on May 22, 2009, which clearly outlined
the implications of a read-modify-write makes it even clearer.
A later commit 7e5f5fb09e6fc ("block: Update topology documentation") 3
months later updates the documentation to remove the read-modify-write
language in favor of "atomic".

Even though we'd like to believe that userspace is doing the right thing
today, I think it would be good to review this today and ensure we're
doing the right thing to make things transparent.

We have two types large capacity NVMe drives to consider. As far as I
can tell all drives will always supporting 512 or 4k LBA format which
controls the logical block size, so they always remain backward
compatible. It would be up to users to format the drives to 512 or 4k.

One type of drive is without the large NAWUPF (atomic), and another with it.
Both will have a large NPWG (the IU). The NPWG is used to set minimum_io_size,
and so, using the original commit's langauge for minimum_io_size, direct IO
would benefit best to rely on that as a minimum.

At least Red Hat's documentation [0] about this suggests that minimum_io_size
will be read by userspace but at least for direct IO it suggests that
direct IO must be aligned to *mutiples of the logical block size*.
That does not clarify to me however if the minimum IO used in userspace
today for direct IO will rely on minimum_io_size. If it is, then things
will work optimally for these drives already.

When a large atomic is supported (NAWUPF) the physical block size will be
lifted, and users can use that to create a filesystem with a larger
sector size than 4k. That certainly would help ensure at least the
filesystem aligns all metadata and data to the large IU. After Jan
Kara's patches which prevent writes to the block device once a
filesystem is mounted, userspace would not be allowed to be mucking
around with the block device, so userspace IO using the raw block device 
with, say a smaller logical sector size would not be allowed. Since,
in these cases the sector size is set to a larger value for the filesystem,
direct IO on the filesystem should respect that preferred larger sector size.

If userspace is indeed already relying on minimum_io_size correctly I am
not sure if we need to do any change. Drives with a large NPWG would get
minimum_io_size set for them already. And a large atomic would just lift
the physical block size. So I don't think we need to force the logical
block size to be 16k of both NPWG and NAWUPF are 16k. *Iff* however, we
feel we may want to help userspace further, I wonder if having the option to
lift the logical block size to the NPWG is desriable.

I did some testing with fio against a 4k physical virtio drive with a
512 byte logical block size and creating a 4k block size XFS filesystem
with a 4k sector size. fio seems to chug along happy if you issue writes
with -bs=512 and even -blockalign=512.

Using Daniel Gomez's ./tools/blkalgn.py tool I still see 512 IO commands
issued, and I don't think they failed. But this was against a virtio
drive for convenience. QEMU in NVMe today doesn't let you have a
different logical block size than physical, so you'd need to do some
odd hacks to test something similar to emulate a large atomic.

root@frag ~/bcc (git::blkalgn)# cat
/sys/block/vdh/queue/physical_block_size 
4096
root@frag ~/bcc (git::blkalgn)# cat
/sys/block/vdh/queue/logical_block_size 
512

mkfs.xfs -f -b size=4k -s size=4k /dev/vdh

fio -name=ten-1g-per-thread --nrfiles=10 -bs=512 -ioengine=io_uring \
-direct=1 \
-blockalign=512 \
--group_reporting=1 --alloc-size=1048576 --filesize=8KiB \
--readwrite=write --fallocate=none --numjobs=$(nproc) --create_on_open=1 \
--directory=/mnt

root@frag ~/bcc (git::blkalgn)# ./tools/blkalgn.py -d vdh

     Block size          : count     distribution
         0 -> 1          : 4        |                                        |
         2 -> 3          : 0        |                                        |
         4 -> 7          : 0        |                                        |
         8 -> 15         : 0        |                                        |
        16 -> 31         : 0        |                                        |
        32 -> 63         : 0        |                                        |
        64 -> 127        : 0        |                                        |
       128 -> 255        : 0        |                                        |
       256 -> 511        : 0        |                                        |
       512 -> 1023       : 79       |****                                    |
      1024 -> 2047       : 320      |********************                    |
      2048 -> 4095       : 638      |****************************************|
      4096 -> 8191       : 161      |**********                              |
      8192 -> 16383      : 0        |                                        |
     16384 -> 32767      : 1        |                                        |

     Algn size           : count     distribution
         0 -> 1          : 0        |                                        |
         2 -> 3          : 0        |                                        |
         4 -> 7          : 0        |                                        |
         8 -> 15         : 0        |                                        |
        16 -> 31         : 0        |                                        |
        32 -> 63         : 0        |                                        |
        64 -> 127        : 0        |                                        |
       128 -> 255        : 0        |                                        |
       256 -> 511        : 0        |                                        |
       512 -> 1023       : 0        |                                        |
      1024 -> 2047       : 0        |                                        |
      2048 -> 4095       : 0        |                                        |
      4096 -> 8191       : 1196     |****************************************|

Userspace can still be do silly things, but I expected in the above that
512 IOs would not be issued.

[0] https://access.redhat.com/articles/3911611

  Luis

