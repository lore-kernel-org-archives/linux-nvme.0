Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3E0C54798
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 23:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AzfcVf2MD8/p0Amw/4NcH7l9FF7lH9l9bZ/XM70hcPY=; b=GY4XvgX1IcPBw7e06UL2iUy0OB
	41l1zAeQVzNv0qBw1agtIvbIJfFoTThMpNcequ0kNTzCQ8KQ7xlH8lOk33XsnvbmVaWeep2/BNaqK
	WuMTrk1HNrnWGUJIaYOpnwhzLzloiepZiAvUUMqoJx/ajrGPh+h1Zb6Nw+boXEAoNxzP9AnP9OCVS
	0F474QAjoFCi32/0u1yDl9NBB1YS+X6JUR88zpwAe9Wxeph9L8aQ2QBbcS3fqTKOZ2h18J2NMfJCg
	oFCWkyfSkrMs7wI31DB8CgxdSM7XfeLZGCK7GZErY9kLhl5Nk131wdHcjZh3oDWVypZ/7491dhfX/
	dbzwvPTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhdvt-0000000FYp1-3DQ7;
	Tue, 05 Mar 2024 23:10:49 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhdvo-0000000FYoI-3vS1
	for linux-nvme@bombadil.infradead.org;
	Tue, 05 Mar 2024 23:10:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AzfcVf2MD8/p0Amw/4NcH7l9FF7lH9l9bZ/XM70hcPY=; b=ALzypJ1YFStiacKMqydGBmTVlP
	YTUVF1xHkoLghzjq7E/lbRgZid3uLJgiw49Sp1jQSAbYyCKb/gHZMWM7rMZZ/ONKXA2F5NEYs1r5D
	8rRucP/IpKNjKJvvm/ETL/0cyT38RtE/zLgQMIkzWtVsfvdDVbGQOR6RbD6iml2tFlK5drIE+zn3u
	HDMMCHitk0ECIe6gGAct543Vsjs58lZLCwbCkHGfUwjkxVC8Llrg7L34j7VDvW8OtAtTaNNVNAALm
	vAUi8qtmJCzc4FlJFblT4FQx2Ur6z8c4WsYyG0tZ8NsFvpA010d5uBs3He6ENJnN7GLLTUPdpFV0N
	hTuYo/4w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhdvh-00000005Saj-2rlV;
	Tue, 05 Mar 2024 23:10:37 +0000
Date: Tue, 5 Mar 2024 23:10:37 +0000
From: Matthew Wilcox <willy@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com
Subject: Re: [PATCH v5 00/10] block atomic writes
Message-ID: <ZeembVG-ygFal6Eb@casper.infradead.org>
References: <20240226173612.1478858-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226173612.1478858-1-john.g.garry@oracle.com>
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

On Mon, Feb 26, 2024 at 05:36:02PM +0000, John Garry wrote:
> This series introduces a proposal to implementing atomic writes in the
> kernel for torn-write protection.

The API as documented will be unnecessarily complicated to implement
for buffered writes, I believe.  What I would prefer is a chattr (or, I
guess, setxattr these days) that sets the tearing boundary for the file.
The page cache can absorb writes of arbitrary size and alignment, but
will be able to guarantee that (if the storage supports it), the only
write tearing will happen on the specified boundary.

We _can_ support arbitrary power-of-two write sizes to the page cache,
but if the requirement is no tearing inside a single write, then we
will have to do a lot of work to make that true.  It isn't clear to me
that anybody is asking for this; the databases I'm aware of are willing
to submit 128kB writes and accept that there may be tearing at 16kB
boundaries (or whatever).


