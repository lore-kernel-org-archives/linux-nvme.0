Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E27C4332F
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Nov 2023 15:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ar/k0F0FhDgO2S+gutDTib6v2xEJuD/LOR4ZPMpZiGk=; b=GvHChwpaT6yomsxNtHZf1OxwgB
	ACq/SChENVjMKHtQBt47wtCyyZYMFQZIIj//SABzcvoYAOnP1yUsxa59mS/3xOGbY/cJeiPXKRFK3
	3SvWQRMzUPUB9MnjyE59Ob7sJkwt3JaUhV5qFo/iIXRCDoGt+m5CG1O/ZhiCY2FEWbA7Toc3+/ycd
	u2yvbYI8PPH1TnXMZJPm5K+iO8/JOmWvZUQM7uImgKPPNasWl/ZhlsqMXzEW+sI04FddMZRc17TLW
	stkrOpZbGwSkKNCNBo4J7MD5qxgC6MMVZuhk3xKj6zIYDWkekiIop+FTGVL11MWFBx2DMdR3zXCJH
	ySSA/fHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r17Ei-006dqj-1P;
	Thu, 09 Nov 2023 15:46:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r17Ef-006dpy-0e
	for linux-nvme@lists.infradead.org;
	Thu, 09 Nov 2023 15:46:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EB3BF68AA6; Thu,  9 Nov 2023 16:46:19 +0100 (CET)
Date: Thu, 9 Nov 2023 16:46:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>,
	axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org, Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH 21/21] nvme: Support atomic writes
Message-ID: <20231109154619.GA3491@lst.de>
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-22-john.g.garry@oracle.com> <20231109153603.GA2188@lst.de> <ZUz98KriiLsM8oQd@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUz98KriiLsM8oQd@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231109_074625_379664_7E814807 
X-CRM114-Status: GOOD (  15.59  )
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

On Thu, Nov 09, 2023 at 03:42:40PM +0000, Matthew Wilcox wrote:
> That wasn't the model we had in mind.  In our thinking, it was fine to
> send a write that crossed the atomic write limit, but the drive wouldn't
> guarantee that it was atomic except at the atomic write boundary.
> Eg with an AWUN of 16kB, you could send five 16kB writes, combine them
> into a single 80kB write, and if the power failed midway through, the
> drive would guarantee that it had written 0, 16kB, 32kB, 48kB, 64kB or
> all 80kB.  Not necessarily in order; it might have written bytes 16-32kB,
> 64-80kB and not the other three.

I can see some use for that, but I'm really worried that debugging
problems in the I/O merging and splitting will be absolute hell.

