Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722D7C47077
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jan 2024 05:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0HsQvP22IqvAprAUrWo9wX//o45hQJSEEnY0Adf591g=; b=BaWnSelBqNohHjs5mpK/zGxbDE
	/HCTKdXIEwbnSTi/gLm+M7p2U5gub5f5et69D/wCOgJB3gG+J0njnPnnAiylOLDp+BZetfMiIAVE6
	GnvQj2TViGUlj8LBb5AGMTBExwhLqPaKJe7n4qvNcSJEl+QcYePNg9wf9HA/AlgUDF3v8ItFRkZHq
	Ez8+WF3aDHr2933se1fz65cBJao1KdGwF5lvssCCn+9ocJ4qhsGfZYK1yo4t1Fp3BujF1akJWgtkR
	K23DHLKE8zNahQaklztSved9lwrNVdxOs+/t9u/KcehshvCdRR0OYjzcLlHp3Jk3kvUUrFG8gZR4m
	M1cG/3OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNnDk-00Ft4e-08;
	Thu, 11 Jan 2024 05:03:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNnDg-00Ft2z-0N
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jan 2024 05:03:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2AD3D68CFE; Thu, 11 Jan 2024 06:02:57 +0100 (CET)
Date: Thu, 11 Jan 2024 06:02:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>,
	John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ming.lei@redhat.com, bvanassche@acm.org,
	ojaswin@linux.ibm.com
Subject: Re: [PATCH v2 00/16] block atomic writes
Message-ID: <20240111050257.GA4457@lst.de>
References: <20231219051456.GB3964019@frogsfrogsfrogs> <20231219052121.GA338@lst.de> <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com> <20231219151759.GA4468@lst.de> <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com> <20231221065031.GA25778@lst.de> <73d03703-6c57-424a-80ea-965e636c34d6@oracle.com> <ZZ3Q4GPrKYo91NQ0@dread.disaster.area> <20240110091929.GA31003@lst.de> <20240111014056.GL722975@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111014056.GL722975@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240110_210308_301010_269F4D9A 
X-CRM114-Status: GOOD (  12.62  )
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

On Wed, Jan 10, 2024 at 05:40:56PM -0800, Darrick J. Wong wrote:
> struct statx statx;
> struct fsxattr fsxattr;
> int fd = open('/foofile', O_RDWR | O_DIRECT);
> 
> ioctl(fd, FS_IOC_GETXATTR, &fsxattr);
> 
> fsxattr.fsx_xflags |= FS_XFLAG_FORCEALIGN | FS_XFLAG_WRITE_ATOMIC;
> fsxattr.fsx_extsize = 16384; /* only for hardware no-tears writes */
> 
> ioctl(fd, FS_IOC_SETXATTR, &fsxattr);
> 
> statx(fd, "", AT_EMPTY_PATH, STATX_ALL | STATX_WRITE_ATOMIC, &statx);
> 
> if (statx.stx_atomic_write_unit_max >= 16384) {
> 	pwrite(fd, &iov, 1, 0, RWF_SYNC | RWF_ATOMIC);
> 	printf("HAPPY DANCE\n");
> }

I think this still needs a check if the fs needs alignment for
atomic writes at all. i.e.

struct statx statx;
struct fsxattr fsxattr;
int fd = open('/foofile', O_RDWR | O_DIRECT);

ioctl(fd, FS_IOC_GETXATTR, &fsxattr);
statx(fd, "", AT_EMPTY_PATH, STATX_ALL | STATX_WRITE_ATOMIC, &statx);
if (statx.stx_atomic_write_unit_max < 16384) {
	bailout();
}

fsxattr.fsx_xflags |= FS_XFLAG_WRITE_ATOMIC;
if (statx.stx_atomic_write_alignment) {
	fsxattr.fsx_xflags |= FS_XFLAG_FORCEALIGN;
	fsxattr.fsx_extsize = 16384; /* only for hardware no-tears writes */
}
if (ioctl(fd, FS_IOC_SETXATTR, &fsxattr) < 1) {
	bailout();
}

pwrite(fd, &iov, 1, 0, RWF_SYNC | RWF_ATOMIC);
printf("HAPPY DANCE\n");

