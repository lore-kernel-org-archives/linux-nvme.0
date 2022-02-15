Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E369EC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Feb 2022 15:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2WnDCqbTT3onU7UeHvojbweTXBjJZz9We3dfJ1eBBUA=; b=NAkU7saXbKyejK3FKMZw5i2luM
	RMMTkSv7pYEUnUIQqqtP1Xja9Zs9VVS2pytjIY3EEHoNjL+qOpDMwGdW9j6Bzi3Kmoeb14t90kiv3
	Dtz/yGQkGfRtn6x0wzKxQQt/qBNFXOkkAJXUG3Vx9oT4ejV+eC9RniegK4Qls/9jXr8ZLhBYlMMo8
	TsZStF1w1ltVvxY2h1J/CXexP8M4TNuf+ltJWzLLw71ewg8i1eo5KzWHjW5eHxVuWqBZNPndnBdst
	PmAj/caa7rLQ8bSp31ybSYWLMsPNlLWNuQRYpOCe04C4i+mj25ipfzONIqcqeMBcHN6yTgrU2osV8
	P6WI4GJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJzfF-003EEN-GO; Tue, 15 Feb 2022 15:22:49 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJzfC-003ECl-E6
 for linux-nvme@lists.infradead.org; Tue, 15 Feb 2022 15:22:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 174A2B8185B;
 Tue, 15 Feb 2022 15:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03089C340ED;
 Tue, 15 Feb 2022 15:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644938563;
 bh=QuSP9h1TZU+ulCdlSj9yBVKvN6wmhQlsP+xB+0dA3W8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qeKippxEJspepJjnd1bsYhzBkL8iHvQyelB20MvtPKI6dmZdTJo//IXdWbJ/cV0kk
 dfMtnRn0Z5u5Dtcf1TfFRlEVURp5rff03+Ne4jrKDe3vGq300ewL5H1RWqz/MLCEaQ
 os4KGhuSZ/l4ewKyF/T+QDdDKVVWI5A/bv79dF8Cj7dqPpBfRmwYJDZjbMIEz+sPvf
 PmNQd4OdCaiVj8L47yyzAAqq9g7NEu1pRzFtdFWcsYoaHXkl20VpB4RIC269ogeK01
 NT/ZxjIAir4Glmw0x/qDhwGtaavgjO5Q+JFEZ8AnuTA+ZNXbNeZuFp0+qYu7aEso9Q
 zzlQa2qQOiSpg==
Date: Tue, 15 Feb 2022 07:22:40 -0800
From: Keith Busch <kbusch@kernel.org>
To: Markus =?iso-8859-1?Q?Bl=F6chl?= <markus.bloechl@ipetronik.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stefan Roese <sr@denx.de>
Subject: Re: [RFC PATCH] nvme: prevent hang on surprise removal of NVMe disk
Message-ID: <20220215152240.GB1663897@dhcp-10-100-145-180.wdc.com>
References: <20220214095107.3t5en5a3tosaeoo6@ipetronik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220214095107.3t5en5a3tosaeoo6@ipetronik.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220215_072246_651172_378DD8B7 
X-CRM114-Status: GOOD (  16.67  )
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

On Mon, Feb 14, 2022 at 10:51:07AM +0100, Markus Blöchl wrote:
> After the surprise removal of a mounted NVMe disk the pciehp task
> reliably hangs forever with a trace similar to this one:
> 
>  INFO: task irq/43-pciehp:64 blocked for more than 120 seconds.
>  Call Trace:
>   <TASK>
>   __bio_queue_enter
>   blk_mq_submit_bio
>   submit_bio_noacct
>   submit_bio_wait
>   blkdev_issue_flush
>   ext4_sync_fs
>   sync_filesystem
>   fsync_bdev
>   delete_partition
>   blk_drop_partitions
>   del_gendisk
>   nvme_ns_remove
>   nvme_remove_namespaces
>   nvme_remove
>   pci_device_remove
>   __device_release_driver
>   device_release_driver
>   pci_stop_bus_device
>   pci_stop_and_remove_bus_device
>   pciehp_unconfigure_device
>   pciehp_disable_slot
>   pciehp_handle_presence_or_link_change
>   pciehp_ist
>   </TASK>
> 
> I observed this with 5.15.5 from debian bullseye-backports and confirmed
> with 5.17.0-rc3 but previous kernels may be affected as well.

Thanks for the patch.

Entering the queue used to fail if blk_queue_dying() was true. The
condition was changed in commit:

  8e141f9eb803e209714a80aa6ec073893f94c526
  block: drain file system I/O on del_gendisk

I can't actually tell if not checking the DYING flag check was
intentional or not, since the comments in blk_queue_start_drain() say
otherwise.

Christoph, do you know the intention here? Should __bio_queue_enter()
check the queue DYING flag, or do you prefer drivers explicity set the
disk state like this? It looks to me the queue flags should be checked
since that's already tied to the freeze wait_queue_head_t.

> @@ -4573,6 +4573,8 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
>  	if (test_and_set_bit(NVME_NS_DEAD, &ns->flags))
>  		return;
>  
> +	set_bit(GD_DEAD, &ns->disk->state);
> +
>  	blk_set_queue_dying(ns->queue);
>  	nvme_start_ns_queue(ns);

