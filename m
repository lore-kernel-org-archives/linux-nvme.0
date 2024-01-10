Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48095C3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jan 2024 09:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IR6Ns2GlhxlVCEplPO+6+F5QlUAeUgDKJssWiKXQa0s=; b=oSe0dZl4Un7XzROCX3lQtW+HXO
	eZLl4ONuvo0GYp16uvH1tk3wkqR0vz7GB2Z5nGoTiP28BhoSVJG814DxaiiWT3D5itrU28iZT0gLH
	nSXMv/exVmUZJ3OOgN+I7GD/rkJSdDOrZEigsSe75p2s235yOa7qcPq2N2khvZgi/HAl164srAsKp
	fi2NQV4BWVVYz5L14Xf2RUcdNbH2buyO/D/VL+rYsjf/t3SU7g6uw3JkIlXFyWa8vXSgHkX8lsbZH
	etZWMden4MlugKcCudcQ6csBdBuMADoH2PbYEeoslJXfRFmuoZMzo8VGmnaup/jIf4DgZvqoZkGoD
	EuNYP8Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNUkP-00Arx0-1O;
	Wed, 10 Jan 2024 09:19:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNUkL-00Arul-1p
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jan 2024 09:19:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 34B2368BFE; Wed, 10 Jan 2024 10:19:29 +0100 (CET)
Date: Wed, 10 Jan 2024 10:19:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>, axboe@kernel.dk,
	kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ming.lei@redhat.com, bvanassche@acm.org,
	ojaswin@linux.ibm.com
Subject: Re: [PATCH v2 00/16] block atomic writes
Message-ID: <20240110091929.GA31003@lst.de>
References: <20231213154409.GA7724@lst.de> <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com> <20231219051456.GB3964019@frogsfrogsfrogs> <20231219052121.GA338@lst.de> <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com> <20231219151759.GA4468@lst.de> <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com> <20231221065031.GA25778@lst.de> <73d03703-6c57-424a-80ea-965e636c34d6@oracle.com> <ZZ3Q4GPrKYo91NQ0@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ3Q4GPrKYo91NQ0@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240110_011937_745384_D9A2B3B0 
X-CRM114-Status: GOOD (  12.97  )
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

On Wed, Jan 10, 2024 at 10:04:00AM +1100, Dave Chinner wrote:
> Hence history teaches us that we should be designing the API around
> the generic filesystem function required (hard alignment of physical
> extent allocation), not the specific use case that requires that
> functionality.

I disagree.  The alignment requirement is an artefact of how you
implement atomic writes.  As the fs user I care that I can do atomic
writes on a file and need to query how big the writes can be and
what alignment is required.

The forcealign feature is a sensible fs side implementation of that
if using hardware based atomic writes with alignment requirements,
but it is a really lousy userspace API.

So with John's API proposal for XFS with hardware alignment based atomic
writes we could still use force align.

Requesting atomic writes for an inode will set the forcealign flag
and the extent size hint, and after that it'll report atomic write
capabilities.  Roughly the same implementation, but not an API
tied to an implementation detail.

