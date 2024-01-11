Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB97C47073
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jan 2024 01:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7bk/KPEWBuUgsVEGP/h7HBCoC9cvvECUPXKRx2ssl0=; b=Se8S6M88Ej4IPOyCZud5v4l4zc
	lUrkmYv2jLJRMsFw5AlTF3OhJ21BXpC8mw407osfupIIYZl2o3NTObES7ICXxB+ajmG9YMpuczuEy
	KCm5eGkrDAO/r21OTe+jZfS7dS3JzamExy3dmsCxJFI5NLUYac16dSPiq3jkwdbESiIvwOdFUnRz3
	jdXljEo4OrpTJTbYiGSc1BM/UMt5rkQu4N3ZD1AKXwkCMECSjZGHbzX/oks1adl5L9aNAr+XH5S1p
	prcUAhSHZzKFaftlCrAEOaSdSQwsEfApIaO7oqV5DW8xPvTsxkvQXW2Yn0u7Mvn/WtsSdRbFsZK3S
	14B5epFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNk46-00FI6P-1X;
	Thu, 11 Jan 2024 01:41:02 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNk43-00FI5H-07
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jan 2024 01:41:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7532561947;
	Thu, 11 Jan 2024 01:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D61C433F1;
	Thu, 11 Jan 2024 01:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704937257;
	bh=u51yyq5q6reKn5H0CqnJR7jUYlsGmLnDJKKy8teJDRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cfDXvP+m7491pQR0YUCkm0mTB2aBegWGodHoLZFFG4xnm1HYzXRQuH2gS9jmS4sxK
	 4a1YcSnAQwsufJxQwNnVNUv8zlTNrN2c8FDL4SvgoPYxlV5HCtl48g/zf8dKFEZFKy
	 s2oFPeyW0anIBYuwCbKWlfg0iILlMck90/uZ6HjK3pEsmr6x3ggHxQYlbGaZ+LM+u9
	 Cdp1Me8dqv2fMqivWwzjoUve3j+IWy/LLnsB6hnY7qN7e4nycBAq9OtxqrOqUVgXsd
	 pNUpTm723vIzDa8WcFdKrRTfElEbLc8gQRM3fqF3Cypry45w0MWn8V/GMykrc5s3y6
	 6wFr/xhlj/0lw==
Date: Wed, 10 Jan 2024 17:40:56 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>,
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
Message-ID: <20240111014056.GL722975@frogsfrogsfrogs>
References: <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com>
 <20231219051456.GB3964019@frogsfrogsfrogs>
 <20231219052121.GA338@lst.de>
 <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com>
 <20231219151759.GA4468@lst.de>
 <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com>
 <20231221065031.GA25778@lst.de>
 <73d03703-6c57-424a-80ea-965e636c34d6@oracle.com>
 <ZZ3Q4GPrKYo91NQ0@dread.disaster.area>
 <20240110091929.GA31003@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110091929.GA31003@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240110_174059_144934_6424BA6D 
X-CRM114-Status: GOOD (  18.95  )
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

On Wed, Jan 10, 2024 at 10:19:29AM +0100, Christoph Hellwig wrote:
> On Wed, Jan 10, 2024 at 10:04:00AM +1100, Dave Chinner wrote:
> > Hence history teaches us that we should be designing the API around
> > the generic filesystem function required (hard alignment of physical
> > extent allocation), not the specific use case that requires that
> > functionality.
> 
> I disagree.  The alignment requirement is an artefact of how you
> implement atomic writes.  As the fs user I care that I can do atomic
> writes on a file and need to query how big the writes can be and
> what alignment is required.
> 
> The forcealign feature is a sensible fs side implementation of that
> if using hardware based atomic writes with alignment requirements,
> but it is a really lousy userspace API.
> 
> So with John's API proposal for XFS with hardware alignment based atomic
> writes we could still use force align.
> 
> Requesting atomic writes for an inode will set the forcealign flag
> and the extent size hint, and after that it'll report atomic write
> capabilities.  Roughly the same implementation, but not an API
> tied to an implementation detail.

Sounds good to me!  So to summarize, this is approximately what
userspace programs would have to do something like this:

struct statx statx;
struct fsxattr fsxattr;
int fd = open('/foofile', O_RDWR | O_DIRECT);

ioctl(fd, FS_IOC_GETXATTR, &fsxattr);

fsxattr.fsx_xflags |= FS_XFLAG_FORCEALIGN | FS_XFLAG_WRITE_ATOMIC;
fsxattr.fsx_extsize = 16384; /* only for hardware no-tears writes */

ioctl(fd, FS_IOC_SETXATTR, &fsxattr);

statx(fd, "", AT_EMPTY_PATH, STATX_ALL | STATX_WRITE_ATOMIC, &statx);

if (statx.stx_atomic_write_unit_max >= 16384) {
	pwrite(fd, &iov, 1, 0, RWF_SYNC | RWF_ATOMIC);
	printf("HAPPY DANCE\n");
}

(Assume we bail out on errors.)

--D

