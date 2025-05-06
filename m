Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B715C3ABBC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 06:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ABvQY4OaE83jYWxv+dXoo4LZo5v0BAqzs5wGjn1g8b0=; b=e/EnEtTcea0M8b+EvKKDfq66+p
	Gj6BmWCfbbRSzs878XUrMjB/8RAVequi4nvHqcIC3hD5FBQ09n/bsVJ3jUq2o36W8SZOFVO4D+6RR
	X9OBfN+aKEE5MQBVMPuY1bCgvY1zqSyGXMawopI+DTJ6xsUFnjjCDQqWzzxUFScxgNl5lHMIgwaad
	xX/+LlQESqxW806+3+yQtCXr5CrV59dnDZQZXmvLzAlhwpdtasfoJhznkLHCTxLyJPvV02RirOaFO
	278mwov7azdvMb0qGqq+/+czgul8u4oKsBwi6JTUFSGM/WzUrr8Kz7lZmWZO+911Qsql23mhkkCVV
	Ze/ZodiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCBWy-0000000Ac4E-3Epj;
	Tue, 06 May 2025 06:11:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCA5K-0000000AG80-1aFH
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 04:39:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A9A3367373; Tue,  6 May 2025 06:39:07 +0200 (CEST)
Date: Tue, 6 May 2025 06:39:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, john.g.garry@oracle.com, bmarzins@redhat.com,
	chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
	brauner@kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
Message-ID: <20250506043907.GA27061@lst.de>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com> <20250421021509.2366003-8-yi.zhang@huaweicloud.com> <20250505132208.GA22182@lst.de> <20250505142945.GJ1035866@frogsfrogsfrogs> <c7d8d0c3-7efa-4ee6-b518-f8b09ec87b73@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7d8d0c3-7efa-4ee6-b518-f8b09ec87b73@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_213914_556781_C7E61A0C 
X-CRM114-Status: GOOD (  11.26  )
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

On Tue, May 06, 2025 at 12:28:54PM +0800, Zhang Yi wrote:
> OK, since this statx reporting flag is not strongly tied to
> FALLOC_FL_WRITE_ZEROES in vfs_fallocate(), I'll split this patch into
> three separate patches.

I don't think that is the right thing to do do.  Keep the flag addition
here, and then report it in the ext4 and bdev patches adding
FALLOC_FL_WRITE_ZEROES as the reporting should be consistent with
the added support.


