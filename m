Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8ABC369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 16:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HeKjALPGIMhsEQxzqLmX6cKCNR2ufdGkHbmnWKcpzKY=; b=5CSsMWk8pAxEK+OIo/sEwjYc2r
	rkHHwGPvzd/qqEUFcmfKCim+IzR/W1fqI5leFO6TV4So49Uzb5D2fps+5iEUu9VgVFInfwP91/jtT
	mw2W6Suq+oQmZ6LsgFXvKs1TdWNDA1lmMx0t4gAurb2bzRsyQET8RmI9LEOHxHzdmUJ0WQQCKl/bi
	JUScRJqP1yv8L2DPLHw1h8SlkBysn7PEGg1zRAipkFrmS3JUKb5p5F/PJk4czgMBGy2cRWYIoskOf
	CXlwINB4n8e5xtk7kk5mVQStTKQFMPoOm1zSGrN6rZiyCP5JLVtBy2XWkMwnjz+g4Kq3yLEbSJ4zx
	sOVmIrpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Lr3-00000000CMu-30kx;
	Fri, 25 Apr 2025 16:24:45 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8KHM-0000000HTcd-208Q
	for linux-nvme@bombadil.infradead.org;
	Fri, 25 Apr 2025 14:43:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HeKjALPGIMhsEQxzqLmX6cKCNR2ufdGkHbmnWKcpzKY=; b=V+l30zHyZun6AIuAeV+IjjOrep
	JlzSNwB7Wh3sypCRFvs+P6x6RPncrxzLSbIaDb4P2lXRZ/U5lqKcY3LWraBwt9m/pXl/OZsFD/r8X
	yWIyyYFTQ/1ny9XZkkXgLeh/tscD5r0QQ85aLrP+XmxHfK1otMMI1ReHq98rQ/rmJpL1Bj01IIYAs
	NYn5PO1vY1Gey4P8+U4Q5LWyoEqlb17dqb3nFflkawUUsBJ+1OQGL3djvUj9guNewapK+eDJvxIEV
	laCRTgDMf3ghvSs598ckVmlZS255roAZtUq3wVqItUyBooM7CnflWRIUTo5Od9L1NKPQLbH7FHPDt
	ZmkcWJuA==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u8KHJ-0000000C58g-19wx
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 14:43:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 822DC68B05; Fri, 25 Apr 2025 16:43:36 +0200 (CEST)
Date: Fri, 25 Apr 2025 16:43:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	kbusch@kernel.org, hare@suse.de, sagi@grimberg.me,
	jmeneghi@redhat.com, axboe@kernel.dk, martin.petersen@oracle.com,
	gjoyce@ibm.com
Subject: Re: [RFC PATCHv2 1/3] nvme-multipath: introduce delayed removal of
 the multipath head node
Message-ID: <20250425144336.GA12179@lst.de>
References: <20250425103319.1185884-1-nilay@linux.ibm.com> <20250425103319.1185884-2-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425103319.1185884-2-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_154345_562225_3F59E604 
X-CRM114-Status: GOOD (  19.06  )
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

On Fri, Apr 25, 2025 at 04:03:08PM +0530, Nilay Shroff wrote:
> @@ -4007,10 +4008,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>  
>  	mutex_lock(&ns->ctrl->subsys->lock);
>  	list_del_rcu(&ns->siblings);
> -	if (list_empty(&ns->head->list)) {
> -		list_del_init(&ns->head->entry);
> -		last_path = true;
> -	}
>  	mutex_unlock(&ns->ctrl->subsys->lock);
>  
>  	/* guarantee not available in head->list */
> @@ -4028,8 +4025,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>  	mutex_unlock(&ns->ctrl->namespaces_lock);
>  	synchronize_srcu(&ns->ctrl->srcu);
>  
> -	if (last_path)
> -		nvme_mpath_shutdown_disk(ns->head);
> +	nvme_mpath_shutdown_disk(ns->head);

This now removes the head list deletion from the first critical
section into nvme_mpath_shutdown_disk.  I remember we had to do it
the way it currently is done because we were running into issues
otherwise, the commit history might help a bit with what the issues
were.

> +	if (a == &dev_attr_delayed_removal_secs.attr) {
> +		struct nvme_ns_head *head = dev_to_ns_head(dev);
> +		struct gendisk *disk = dev_to_disk(dev);
> +
> +		/*
> +		 * This attribute is only valid for head node and non-fabric
> +		 * setup.
> +		 */
> +		if (!nvme_disk_is_ns_head(disk) ||
> +				test_bit(NVME_NSHEAD_FABRICS, &head->flags))
> +			return 0;
> +	}

Didn't we say we also want to allow fabrics to use it if explicitly
configured?


