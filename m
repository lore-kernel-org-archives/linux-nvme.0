Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3592BC3ABBE
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 06:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ew2u4pM/p5zxX4wzCJTaZpDw/b43VxbkyvfgA6SBnUM=; b=ogX51D1ieKj4cXQyzMwiEs7bcS
	mNr+0dq+wdFRL4n8la05ZwpfRaFZ6TlHGCxL7q7XEU7F/0TUxvMhotHe2h7Gqn8qn5ysjfaiTFi3K
	XQF7sbQTRwVndsU7azPtygRiIO+n5Gbjq9SOFNolw2k5/CaqZnsM8dFEkGyTgCSIRePT9ro4OTJUt
	vu+7MSYBF9ndbu5svwQpi06UXJcs+wMubPEtUXPRu51ZMj1KvogjjFhmCAf3Q9yTAcz2CtZn5tgyY
	yjyQW3iN8sMmpTZ1TTSsKJVF+3ojMKKlBmqSK1u6e51kAhq2yUyCXf4VLrQY9SGZP2gqdsjVNjZmi
	M78BQyAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCv9R-0000000HWFG-1MNb;
	Thu, 08 May 2025 06:54:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCv3V-0000000HVYs-1r8Q
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 06:48:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9327468AA6; Thu,  8 May 2025 08:48:22 +0200 (CEST)
Date: Thu, 8 May 2025 08:48:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: linux-nvme@lists.infradead.org, kch@nvidia.com, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH v2 2/2] nvme: all namespaces in a subsystem must adhere
 to a common atomic write size
Message-ID: <20250508064821.GA29712@lst.de>
References: <20250507234137.1609876-1-alan.adamson@oracle.com> <20250507234137.1609876-3-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507234137.1609876-3-alan.adamson@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_234829_623912_C04A245B 
X-CRM114-Status: GOOD (  12.74  )
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

On Wed, May 07, 2025 at 04:41:35PM -0700, Alan Adamson wrote:
> +		/*
> +		 * Set subsystem atomic bs.
> +		 */
> +		if (ns->ctrl->subsys->atomic_bs) {
> +			if (atomic_bs > ns->ctrl->subsys->atomic_bs) {
> +				pr_err_ratelimited("%s: Inconsistent Atomic Write Size: Subsystem=%d bytes, Controller/Namespace=%d bytes\n",
> +					ns->disk ? ns->disk->disk_name : "?",
> +					ns->ctrl->subsys->atomic_bs,
> +					atomic_bs);

Maybe mentioned that the controlled is not added as well here?

> +	if (lim.atomic_write_hw_max > ns->ctrl->subsys->atomic_bs) {
> +		blk_mq_unfreeze_queue(ns->disk->queue, memflags);
> +		ret = -ENXIO;
> +		goto out;
> +	}

And add a comment here explaining the check?

Otherwise this looks good.

