Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0413EC48260
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Feb 2024 06:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SjIP93SL2UWuc2PiduUduAbU55YwA1lcl3SrT2094Ag=; b=ybCpZ4yO6KLMr+j95JIAZlDFjS
	cQXb9+y/JYQ0shTfkUc8S6TUMgX/oAoDxuwuY37OVqmKTbacqq7aV6cC5zwnucrxxXBll0fX0CceC
	liHownyWuYs8Rsf/YWhnjgaOwMgSpmr5AJ1EUSA/yh51XEml/RWYuG+vkxoddUJPockiotY2JbcK3
	nLszcHfHA4qXWglXTcCWMnej3wOMN1lYib8aZFXRa+OvNPd5VPR1gZarIx2LfAy43nu8rHtG+Dj82
	LYwCL4ldEXK+8fpKoEjyNp1ywp965zjtfJboisO613sKJlWtLLfh+CLhJeRCRm//rovp6nlcOxDgV
	6z8QTwiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZmKb-000000088jg-3snr;
	Tue, 13 Feb 2024 06:31:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZmKV-000000088ij-3IUu
	for linux-nvme@lists.infradead.org;
	Tue, 13 Feb 2024 06:31:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CBC45227A87; Tue, 13 Feb 2024 07:31:39 +0100 (CET)
Date: Tue, 13 Feb 2024 07:31:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, ojaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v3 11/15] scsi: sd: Support reading atomic write
 properties from block limits VPD
Message-ID: <20240213063139.GA23305@lst.de>
References: <20240124113841.31824-1-john.g.garry@oracle.com> <20240124113841.31824-12-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124113841.31824-12-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_223143_991806_551A4CC7 
X-CRM114-Status: GOOD (  11.15  )
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

On Wed, Jan 24, 2024 at 11:38:37AM +0000, John Garry wrote:
> Also update block layer request queue sysfs properties.
> 
> See sbc4r22 section 6.6.4 - Block limits VPD page.

Not the most useful commit log..

Can you merge this with the next patch and write a detailed commit
log how atomic writes map to SBC features and what limitations
Linux atomic writes on Linux have?


