Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAA1C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 05:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x9ZeuK2/tjQ5/yo03IJBs76rtICUewTqHzMi3UDiaMs=; b=410DRIjwn2k8e5A0vlqiYl/Ofv
	Vt7LhBZ3R+fkcVyw4f0ixTXpPDiQbY7CDqGhlQlsX/7nWBj6/NKhvGQy56ZkM5q7ZGanWJSnHmwdF
	YQ532giFYAhtCTMNbq+2t1sQq4abVDIeYDXteL60kZeUuHZ2R4SB13+gAwQ3BPQQOIg/WiWGMrzB1
	pDbJ5e9zGkkeZwnJE3w0gEw/IJ6ySprzjERA6pocI+mAz60IqQLbRLEZy2kFgboXm4ku3LGkkQ814
	T/YOF9EyRdcO8dq8SJE8YcGJmL8n0xqiZjnsk8UhjmcCn2WXeqv7VGhNCA8nOoPrggp3kT2cTLGP+
	eqnD5WYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbbxF-00HBHi-Qk; Tue, 05 Apr 2022 05:42:13 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbbxC-00HBGd-Nz
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 05:42:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7B59668AFE; Tue,  5 Apr 2022 07:42:05 +0200 (CEST)
Date: Tue, 5 Apr 2022 07:42:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 util-linux@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Subject: Re: [PATCH] nvme: add namespace paths links
Message-ID: <20220405054205.GA23466@lst.de>
References: <20220401092855.90652-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401092855.90652-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_224210_965486_733BE4BC 
X-CRM114-Status: GOOD (  23.40  )
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

On Fri, Apr 01, 2022 at 11:28:55AM +0200, Hannes Reinecke wrote:
> It is really annoying to always have to loop through the entire
> /sys/block directory just to find the namespace path links for
> a single namespace in libnvme/nvme-cli.
> So provide links to the namespace paths for efficient lookup.

I think having some form of links would be useful.  Quite a while ago
Thadeu looked into adding some form of relationship for lsblk and
friends.  Maybe it would be good to sync up and make sure whatever
links we are adding would be useful for all users?

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/host/core.c      | 3 +++
>  drivers/nvme/host/multipath.c | 8 ++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f204c6f78b5b..df4d89aa061f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4054,6 +4054,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>  
>  	if (!nvme_ns_head_multipath(ns->head))
>  		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
> +	else
> +		sysfs_remove_link(&disk_to_dev(ns->head->disk)->kobj,
> +				  ns->disk->disk_name);
>  	del_gendisk(ns->disk);
>  	blk_cleanup_queue(ns->queue);
>  
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 7fc58e1f6b09..dc9a4018f90d 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -801,6 +801,8 @@ static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
>  
>  void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
>  {
> +	int ret;
> +
>  	if (nvme_ctrl_use_ana(ns->ctrl)) {
>  		struct nvme_ana_group_desc desc = {
>  			.grpid = id->anagrpid,
> @@ -831,6 +833,12 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
>  	if (blk_queue_is_zoned(ns->queue) && ns->head->disk)
>  		ns->head->disk->queue->nr_zones = ns->queue->nr_zones;
>  #endif
> +	ret = sysfs_create_link(&disk_to_dev(ns->head->disk)->kobj,
> +				&disk_to_dev(ns->disk)->kobj,
> +				ns->disk->disk_name);
> +	if (ret)
> +		dev_warn(ns->ctrl->device,
> +			 "failed to create namespace path link\n");
>  }
>  
>  void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
> -- 
> 2.29.2
---end quoted text---

