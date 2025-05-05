Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81475C3ABB0
	for <linux-nvme@archiver.kernel.org>; Mon,  5 May 2025 14:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pUareyz6CCRhe6X+yf1+5XdQB44TwW8w4HBsGzmE/rs=; b=qrgIt0SrhIRoyBdVKB4/LPQYYD
	uRCVXagVPouU5FQnXo5RtPfedXg8oBGVLDXNpjvdl6yoCtyyEjI5M8CnrglR3u4euSx37EwJdEoER
	wgCksYW31xozSzHn9g8oKjiV5Z6RYUHkGRLT9OwleCkllKWmCQuLlyz26JkE73QoPoSc3TgawUpsY
	lWn0L1hUn8pUn+w9L+fUXeE0fQtJ509PxQTtZE01t+VAjbX0d0rMTX1NhGn/XYOOI4pw/BKnfVk0Z
	FNQYOhNklm1v2ZUJjHFfKYvazvbKJZ7ZK7ACzxCy1qiULi7k+MYVTxjG6641WaQkpFzMWAG06kUkr
	F1Jxo2OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBwpJ-00000007dYh-1RbZ;
	Mon, 05 May 2025 14:29:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBwpH-00000007dYI-07wt
	for linux-nvme@lists.infradead.org;
	Mon, 05 May 2025 14:29:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AF7DA43F8A;
	Mon,  5 May 2025 14:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C860C4CEE4;
	Mon,  5 May 2025 14:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746455386;
	bh=CD6uIDxK7PuM4/IKezsMaaIGURgMjXMez6lltVRFv3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s76bOPfYZwOomTqJoQgcpmX1YDtAmHKEJbY0ysNXij1GtqBx97Zl0E87GV9b+0mDg
	 sYN6vd1GOdlgHX0VhkpZVO7v28jxK0PpVZE4nh5XtGBM/8eoyQxhGxxy5Xz/odn5GV
	 jTOu8ibb2qGgpeOecR3N3XdiOpxDSj8ij1BKjGEoelIa0BXuUwzFa6mIKtdtPxwTYN
	 efpa1YwpPqBh2TbSCKYxdEiLvPt7ORW/D558omfTb2TXPMLGy0BcFQWqwH5QzLs/zy
	 sMYcHohbq/anIdvAaYOqIcMkf6/Gau9wApdBWUEOB0NieDwuqI1jM8qYN5bPmI6YwS
	 V0ZFr/y/4Iqfg==
Date: Mon, 5 May 2025 07:29:45 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	john.g.garry@oracle.com, bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, brauner@kernel.org,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
Message-ID: <20250505142945.GJ1035866@frogsfrogsfrogs>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com>
 <20250421021509.2366003-8-yi.zhang@huaweicloud.com>
 <20250505132208.GA22182@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505132208.GA22182@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_072947_088370_4FA24F1A 
X-CRM114-Status: GOOD (  22.59  )
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

On Mon, May 05, 2025 at 03:22:08PM +0200, Christoph Hellwig wrote:
> On Mon, Apr 21, 2025 at 10:15:05AM +0800, Zhang Yi wrote:
> > From: Zhang Yi <yi.zhang@huawei.com>
> > 
> > Add a new attribute flag to statx to determine whether a bdev or a file
> > supports the unmap write zeroes command.
> > 
> > Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > ---
> >  block/bdev.c              | 4 ++++
> >  fs/ext4/inode.c           | 9 ++++++---
> >  include/uapi/linux/stat.h | 1 +
> >  3 files changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/block/bdev.c b/block/bdev.c
> > index 4844d1e27b6f..29b0e5feb138 100644
> > --- a/block/bdev.c
> > +++ b/block/bdev.c
> > @@ -1304,6 +1304,10 @@ void bdev_statx(struct path *path, struct kstat *stat,
> >  			queue_atomic_write_unit_max_bytes(bd_queue));
> >  	}
> >  
> > +	if (bdev_write_zeroes_unmap(bdev))
> > +		stat->attributes |= STATX_ATTR_WRITE_ZEROES_UNMAP;
> > +	stat->attributes_mask |= STATX_ATTR_WRITE_ZEROES_UNMAP;
> 
> Hmm, shouldn't this always be set by stat?  But I might just be
> really confused what attributes_mask is, and might in fact have
> misapplied it in past patches of my own..

attributes_mask contains attribute flags known to the filesystem,
whereas attributes contains flags actually set on the file.
"known_attributes" would have been a better name, but that's water under
the bridge. :P

> Also shouldn't the patches to report the flag go into the bdev/ext4
> patches that actually implement the feature for the respective files
> to keep bisectability?

/I/ think so...

--D

