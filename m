Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7F6C369A1
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 10:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kIDsOr+u5h/amAvUHjaKA4CyqxjR+cp2Hqyfuo8MB+E=; b=aLCpThRLRaxy2K9qdPRZsiVC2s
	7ghZMNk3LkQ4wZU2nqkjJwkTwu6gGU803D8mzc3q59toqs5pbmOxF6e4S7SF7Lsd5R3GY9tiSa+rK
	rpiOclru0gA5/K9DrxacJrqBI1OL9XvOJ3bW4aSv/XCNCwuv6qbXGP00TeeXREe5UIniPv7H3pwS0
	bNhM2sxopqP7TUKqWASKl5aPPCzJ2qYMp3b2EJHTs1pydE7fHTK4EWFItOqZP//HhPm4nEo2gZzGc
	dMKBPv+wSwVwnMhWZ1SLI1RrgNQ7OXUI6BgFSoEDY7Ge+Osb5Qz6pCeokvfxBx3F0mi6aNXzMBxSh
	+XRvSIcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Snf-00000006rPK-1BiC;
	Wed, 09 Apr 2025 10:36:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Snc-00000006rOL-1S19
	for linux-nvme@lists.infradead.org;
	Wed, 09 Apr 2025 10:36:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0342E68BFE; Wed,  9 Apr 2025 12:36:49 +0200 (CEST)
Date: Wed, 9 Apr 2025 12:36:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
	tytso@mit.edu, djwong@kernel.org, john.g.garry@oracle.com,
	bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH -next v3 09/10] block: factor out common part in
 blkdev_fallocate()
Message-ID: <20250409103648.GE4950@lst.de>
References: <20250318073545.3518707-1-yi.zhang@huaweicloud.com> <20250318073545.3518707-10-yi.zhang@huaweicloud.com> <20250409103629.GD4950@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409103629.GD4950@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_033652_522433_238B7264 
X-CRM114-Status: GOOD (  10.42  )
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

On Wed, Apr 09, 2025 at 12:36:29PM +0200, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

.. although this really should go before the previous patch.

