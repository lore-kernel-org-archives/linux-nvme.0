Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FBBC4167B
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Nov 2023 15:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SMQAwb8UWtsIyMfWjlsf1jELD0xy0Eh+rkitcCN6FZo=; b=1GTW1YUzYksKQCwTyf128r49X8
	NQWKVwwCdfLUklv5wWoPwGqXLKK9NSTuL2qnAWgqlGRsDTJPhYi4u4eD/lRS2pLmVIfU51R9FKtuL
	WYGVMHMBynytCBMd92uzdv4YDVl8wbab6ZWCkE+cXZE+PVYWKNoJqYn/s6LQrVJi+eqh0n/THANhC
	6PVNAPw6AvyLLdvw6fApgHP9yvDjPrk9y+lWYqSBu8qiw+9VWIuDEr2eVSqcd/qMDH2e3XqOf5pNu
	fgzqalH4PGhfGbq7/49M7xgz7DYPfbzrDo064y3JUvoPnLYQK1/4Hbw0oaZNthqIFAAU+lDz8NVum
	VnI4pFog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r174l-006bLZ-2Q;
	Thu, 09 Nov 2023 15:36:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r174i-006bKT-2G
	for linux-nvme@lists.infradead.org;
	Thu, 09 Nov 2023 15:36:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4BBF667373; Thu,  9 Nov 2023 16:36:04 +0100 (CET)
Date: Thu, 9 Nov 2023 16:36:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org, Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH 21/21] nvme: Support atomic writes
Message-ID: <20231109153603.GA2188@lst.de>
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-22-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929102726.2985188-22-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231109_073608_886019_532E7B6D 
X-CRM114-Status: GOOD (  13.07  )
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

> +			if (le16_to_cpu(id->nabspf))
> +				boundary = (le16_to_cpu(id->nabspf) + 1) * bs;
> +
> +			if (is_power_of_2(boundary) || !boundary) {
> +				blk_queue_atomic_write_max_bytes(disk->queue, atomic_bs);
> +				blk_queue_atomic_write_unit_min_sectors(disk->queue, 1);
> +				blk_queue_atomic_write_unit_max_sectors(disk->queue,
> +									atomic_bs / bs);
> +				blk_queue_atomic_write_boundary_bytes(disk->queue, boundary);
> +			} else {
> +				dev_err(ns->ctrl->device, "Unsupported atomic boundary=0x%x\n",
> +					boundary);
> +			}

Please figure out a way to split the atomic configuration into a
helper and avoid all those crazy long lines,  preferable also avoid
the double calls to the block helpers as well while you're at it.

Also I really want a check in the NVMe I/O path that any request
with the atomic flag set actually adhers to the limits to at least
partially paper over the annoying lack of a separate write atomic
command in nvme.

