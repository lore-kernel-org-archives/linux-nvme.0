Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110DCC7618D
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Mar 2023 13:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xilk8mKqT1WaYay/k9udgTRmcfLmDalWQjP7LmOy50s=; b=EfBW0GFoqyurgbDAZKO2JkjqGW
	oblzkWHu5mwCliByQNKiElIx/SVwJN6lRD4+EJZeNN3h8SzGdDp39Dgq8hmiAS8j2GB38C4/yDgF4
	dmOI4KaeKLgLnHlqJX1hU0ZcRzr9tAr7jvF2tdWDVNOGfHYXMK2hKbq/9217P8ZdKP7QYbIkP5NwL
	Dq2tCQ+aweRjQEcXyY4FiKEWAtec13VG+f4i7YbaSnK3NyI7tr8MTCZ2XoRyR+zdLrbu1v979oWNv
	BA1LEc/9PZxfJHAnm2P3kW/M5AZjI1lFGAUKi3gmGCNfDHUxvW0Wv5yTsJ+5wgla0pn6ro+kW00ol
	NU/tSDGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peFDi-0093I5-02;
	Mon, 20 Mar 2023 13:06:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peFDe-0093F9-2C
	for linux-nvme@lists.infradead.org;
	Mon, 20 Mar 2023 13:06:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BA35E68AFE; Mon, 20 Mar 2023 14:06:25 +0100 (CET)
Date: Mon, 20 Mar 2023 14:06:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: Stefan Haberland <sth@linux.ibm.com>, Christoph Hellwig <hch@lst.de>,
	bvanassche@acm.org, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	snitzer@kernel.org, axboe@kernel.dk, linux-nvme@lists.infradead.org,
	chaitanyak@nvidia.com, kbusch@kernel.org,
	target-devel@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>
Subject: Re: [PATCH v4 02/18] block: Rename BLK_STS_NEXUS to
 BLK_STS_RESV_CONFLICT
Message-ID: <20230320130625.GA11908@lst.de>
References: <20230224174502.321490-1-michael.christie@oracle.com> <20230224174502.321490-3-michael.christie@oracle.com> <20230314171119.GB6780@lst.de> <33ed9615-b570-03c7-9a7a-d07f020d3222@linux.ibm.com> <20230315133039.GA24533@lst.de> <4484f553-84c1-5402-4f52-c2972ad3e496@linux.ibm.com> <6da0ec0a-d465-fec4-0ca5-96b2ffb7be7a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6da0ec0a-d465-fec4-0ca5-96b2ffb7be7a@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230320_060634_883355_B0950DE3 
X-CRM114-Status: GOOD (  17.48  )
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

On Thu, Mar 16, 2023 at 11:36:12AM -0500, Mike Christie wrote:
> I think we are ok for dasd using BLK_STS_RESV_CONFLICT.
> 
> It thought it sounded similar to SCSI/NVMe and userspace will still
> see -EBADE because the blk_status_to_errno/errno_to_blk_status will
> handle this.
> 
> There was no internal dasd code checking for BLK_STS_NEXUS.
> 
> There is a pr_ops API, but dasd is not hooked into it so we don't
> have to worry about behavior changes.

Yes, we don't have to worry about it.  I just find a bit confusing
to have a PR-related error in a driver that doesn't use PRs.

Maybe add a little comment that it is used for some s390 or DASD
specific locking instead.

