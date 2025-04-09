Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57825C36002
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 10:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qJSKj78jlBod5LK7N8kwc4NJo6wFmY0snApguc4ffQs=; b=AmnH6Zb2ok5Yvcul6ppKaCShLd
	TFRIPk2GE7fW0IYnIpvohRUF1D0CVRCWmmgHRLbz8C6bWA13Ta9Q3yILq9sMEHbJGgPE3PyaOE18Q
	hcRrbnuXx5l8GkJB3Knvmz4xOXrvmHnB8w0trMH9x/1rEsy4+PbBuDhlto62V8TY6R5jL3T4eebC8
	UID989DsJTpx1XonsWI+Dn1PmsRm9f6WdXgDPH54hK0i95OuzjOEdHbXJVhUYCY47czfyeF1Ez2ff
	4/FCpu1lTiXo/m1cetuatb3qsaV0v6jVGJiQyC0/+C3STySsHlCsCR5x6VtkpLj3FpZTo6OT32R4S
	Nhsdq5mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2SjY-00000006qEz-2iAq;
	Wed, 09 Apr 2025 10:32:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Sis-00000006q47-2bhO
	for linux-nvme@lists.infradead.org;
	Wed, 09 Apr 2025 10:31:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7E1E268CFE; Wed,  9 Apr 2025 12:31:48 +0200 (CEST)
Date: Wed, 9 Apr 2025 12:31:48 +0200
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
Subject: Re: [RFC PATCH -next v3 01/10] block: introduce
 BLK_FEAT_WRITE_ZEROES_UNMAP to queue limits features
Message-ID: <20250409103148.GA4950@lst.de>
References: <20250318073545.3518707-1-yi.zhang@huaweicloud.com> <20250318073545.3518707-2-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318073545.3518707-2-yi.zhang@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_033158_851843_93B054A5 
X-CRM114-Status: GOOD (  15.10  )
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

On Tue, Mar 18, 2025 at 03:35:36PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Currently, disks primarily implement the write zeroes command (aka
> REQ_OP_WRITE_ZEROES) through two mechanisms: the first involves
> physically writing zeros to the disk media (e.g., HDDs), while the
> second performs an unmap operation on the logical blocks, effectively
> putting them into a deallocated state (e.g., SSDs). The first method is
> generally slow, while the second method is typically very fast.
> 
> For example, on certain NVMe SSDs that support NVME_NS_DEAC, submitting
> REQ_OP_WRITE_ZEROES requests with the NVME_WZ_DEAC bit can accelerate
> the write zeros operation by placing disk blocks into

Note that this is a can, not a must.  The NVMe definition of Write
Zeroes is unfortunately pretty stupid.

> +		[RO] Devices that explicitly support the unmap write zeroes
> +		operation in which a single write zeroes request with the unmap
> +		bit set to zero out the range of contiguous blocks on storage
> +		by freeing blocks, rather than writing physical zeroes to the
> +		media.

This is not actually guaranteed for nvme or scsi.


