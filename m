Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76352CE7AFB
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 10:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bbL/xnHI+fHyYy4951znm6XRkDyXrHrFWT4upEsf2Ng=; b=Z/JBNSeBYdgwV+ri0Vmfe96XqG
	sEtlHT9fzFWwTGvuBjkQSU6bzGWuBdvMUIXCGE21UHe6yZ3t/uguJF8kJMozDcfZqxztBraPgajOV
	4veq3Fk6vgsoHG6sVXJUR/G+iJDShf1gjGigVtEx8GbUHyMeL/zVd+jYMs46GCECcEtHYwR3fyy5J
	7ugmBKj5Pn96jTNLKkRaxgdC16PC7RB/xyvXoJVbkIbT8Kf9YrWy81BBHxeub3TQldsh/TLbIQeCL
	lN0uA5cL3/naHoxg8pdZgyq9fxMHFDZc+ppF5NMfXDXRINHnsxX/FFiD9lxWkyQs6m7H6y1x/an5p
	hJHmi0lQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smWMo-0000000BnOH-3JbT;
	Fri, 06 Sep 2024 10:39:02 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smWJm-0000000BmgC-3EwK
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 10:35:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 334445C5BB7;
	Fri,  6 Sep 2024 10:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75E7C4CEC4;
	Fri,  6 Sep 2024 10:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725618953;
	bh=w5aCLCFQvhF9PMl3qhi2YGmjl1JFiJNAsKcELoR7bd8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AKWrX3WsruXH7JUZs/oWioVYycOonPqwpZW6Gy6utA/le+e3knY0tNBoPhV9uNyCI
	 zESkllLMy0x7r+Ib/ZyDid6m4HTi8HXrdvsAt3GUTNQaB4OcLTFRLaGabrDPlTxaFy
	 QuAJltz8C5ZqS3xxoCn7sP8V53j2Uulw87vKlhnyGVg/uDl/BJ4kC37LvZs1ZmNLFO
	 LwWIYjKhitMZNhxeK2JoI+pPOncYA2KUwJv0tTH36Y/18V+neX4ts/ORYaWS9bnXvR
	 3gTYrrKd6TuFUTMz6E4e7UMCCEiOekBQZbk1rys8C04HO5TRMPQCZLmp6VHVLdK7aJ
	 DO8LffDgM4tlg==
Message-ID: <b7eb6419-9c88-4e79-9c07-1db20a4bbb32@kernel.org>
Date: Fri, 6 Sep 2024 19:35:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: 'nvme disconnect' hangs after remapping
 namespaces
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240906101640.44417-1-hare@kernel.org>
 <20240906101640.44417-4-hare@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240906101640.44417-4-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_033555_002727_6BE3B7D0 
X-CRM114-Status: GOOD (  16.96  )
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

On 9/6/24 19:16, Hannes Reinecke wrote:
> During repetitive namespace map and unmap operations on the target
> (disabling the namespace, changing the UUID, enabling it again)
> the initial scan will hang as the target will be returning
> PATH_ERROR and the I/O is constantly retried:
> 
> [<0>] folio_wait_bit_common+0x12a/0x310
> [<0>] filemap_read_folio+0x97/0xd0
> [<0>] do_read_cache_folio+0x108/0x390
> [<0>] read_part_sector+0x31/0xa0
> [<0>] read_lba+0xc5/0x160
> [<0>] efi_partition+0xd9/0x8f0
> [<0>] bdev_disk_changed+0x23d/0x6d0
> [<0>] blkdev_get_whole+0x78/0xc0
> [<0>] bdev_open+0x2c6/0x3b0
> [<0>] bdev_file_open_by_dev+0xcb/0x120
> [<0>] disk_scan_partitions+0x5d/0x100
> [<0>] device_add_disk+0x402/0x420
> [<0>] nvme_mpath_set_live+0x4f/0x1f0 [nvme_core]
> [<0>] nvme_mpath_add_disk+0x107/0x120 [nvme_core]
> [<0>] nvme_alloc_ns+0xac6/0xe60 [nvme_core]
> [<0>] nvme_scan_ns+0x2dd/0x3e0 [nvme_core]
> [<0>] nvme_scan_work+0x1a3/0x490 [nvme_core]
> 
> Calling 'nvme disconnect' on controllers with these namespaces
> will hang as the disconnect operation tries to flush scan_work:
> 
> [<0>] __flush_work+0x389/0x4b0
> [<0>] nvme_remove_namespaces+0x4b/0x130 [nvme_core]
> [<0>] nvme_do_delete_ctrl+0x72/0x90 [nvme_core]
> [<0>] nvme_delete_ctrl_sync+0x2e/0x40 [nvme_core]
> [<0>] nvme_sysfs_delete+0x35/0x40 [nvme_core]
> [<0>] kernfs_fop_write_iter+0x13d/0x1b0
> [<0>] vfs_write+0x404/0x510
> 
> before the namespaces are removed.
> 
> This patch sets the 'failfast_expired' bit for the controller
> to cause all pending I/O to be failed, and the disconnect process
> to complete.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>  drivers/nvme/host/core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 651073280f6f..b968b672dcf8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4222,6 +4222,13 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>  	 */
>  	nvme_mpath_clear_ctrl_paths(ctrl);
>  
> +	/*
> +	 * Mark the controller as 'failfast' to ensure all pending I/O
> +	 * is killed.

s/is/are ?

> +	 */
> +	set_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
> +	nvme_kick_requeue_lists(ctrl);
> +
>  	/*
>  	 * Unquiesce io queues so any pending IO won't hang, especially
>  	 * those submitted from scan work

-- 
Damien Le Moal
Western Digital Research


