Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C48EC41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 05:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wDDuJPbOnZIW8GFTGVXnSMnwOADG+46WPtNCCOVT/aI=; b=K4tDFMuVxTfAsJBwmf2qBn6VeI
	SCzBSMlV95AA9WY40NwWakvo1NRg8lgw6Y0D8JNRt5BUvlTOEuzVkBg1r7VnIa6+2kokRmMSJIryZ
	Jv2NlhomAt2qZwJhMWJuy07L90jvrUhuYq+t7gL9bMGsPISNwk95ySmiO6+0uQWfbDwy3EYVxwVz2
	Ut0f/CyIQ1Rv8gJwnBNK653UzRRTSGzqLLsNSnVhLdm6vNMeLKrRoIyw2PhrwNC2hEoyWFPgW/qQD
	CLN6Se9COZ9r/8P+W0L+tdYy/rf9N6qIiqq3xQZpns04RmWFczeNMnQzrYKLu0tWbmtT7HJDnJPJ6
	esGBLg0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFSXo-00Cscx-0Z;
	Tue, 19 Dec 2023 05:21:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFSXl-00CscT-2s
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 05:21:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9A84268AFE; Tue, 19 Dec 2023 06:21:21 +0100 (CET)
Date: Tue, 19 Dec 2023 06:21:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>,
	axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, jaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v2 00/16] block atomic writes
Message-ID: <20231219052121.GA338@lst.de>
References: <20231212110844.19698-1-john.g.garry@oracle.com> <20231212163246.GA24594@lst.de> <b8b0a9d7-88d2-45a9-877a-ecc5e0f1e645@oracle.com> <20231213154409.GA7724@lst.de> <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com> <20231219051456.GB3964019@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219051456.GB3964019@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_212126_078752_479D3E70 
X-CRM114-Status: GOOD (  18.48  )
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

On Mon, Dec 18, 2023 at 09:14:56PM -0800, Darrick J. Wong wrote:
> /me stumbles back in with plenty of covidbrain to go around.
> 
> So ... Christoph, you're asking for a common API for
> sysadmins/applications to signal to the filesystem that they want all
> data allocations aligned to a given value, right?
> 
> e.g. if a nvme device advertises a capability for untorn writes between
> $lbasize and 64k, then we need a way to set up each untorn-file with
> some alignment between $lbasize and 64k?
> 
> or if cxl storage becomes not ung-dly expensive, then we'd want a way to
> set up files with an alignment of 2M (x86) or 512M (arm64lol) to take
> advantage of PMD mmap mappings?

The most important point is to not mix these up.

If we want to use a file for atomic writes I should tell the fs about
it, and preferably in a way that does not require me to know about weird
internal implementation details of every file system.  I really just
want to use atomic writes.  Preferably I'd just start using them after
asking for the limits.  But that's obviously not going to work for
file systems that use the hardware offload and don't otherwise align
to the limit (which would suck for very small files anyway :))

So as a compromise I tell the file system before writing or otherwise
adding any data [1] to file that I want to use atomic writes so that
the fs can take the right decisions.

[1] reflinking data into a such marked file will be ... interesting.


