Return-Path: <SRS0=I4H8=LP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC708C48BC2
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 17:27:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7CCB60FF2
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 17:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7CCB60FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K0N0jmEFU3cRhYvakEqFePQ3zHa0Qa0jnHsvf3a/ays=; b=P6vSMcVjV+dr4H
	zBE0q0o3dqT1GGu+nQ79Q/3+zln4BYWZaXr6huQRVbcarLYjNOyWeut6jYFwKC5JSILlSVTE7mJbI
	wEwvPu61gFD2vw2vXr9ue422dBlFHa0B+FAuTDajMIumcetPLIAw2T1SNVRowA2DZlUqT3499WjMW
	MaTaYcZC8V/c8nmS7L/Ko5hm+ZmAJKI2vkcO8TwQoUVX8LdtiGufiMgIKSSiMmOCgi/xrJxD06Ok4
	cyF7t96/MLHiBBJOqkSIhQTCllvLAp2feZdZT8U0puvKhuJW+Iufl8YHnxJHICh4MbIHqbEKGwPcP
	1Jd/9rGAGDS/cdcGWEug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvNhK-004FlK-7w; Mon, 21 Jun 2021 17:26:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvNhH-004Fka-Nd
 for linux-nvme@lists.infradead.org; Mon, 21 Jun 2021 17:26:56 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id F125860FF2;
 Mon, 21 Jun 2021 17:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624296415;
 bh=/jz8zd1gSCUziIaV161ZneyufCzKh7BqHfL+c2WH3Bk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=epRsG0sZ6NHeZ1Ynq8gz+JZAYJSr3I6Sf0frxDuifE/YUWuMQ7ZUIPtpz/mn2v2rq
 hA746lBPR2QLcR8VKJl6hPvha0mH02Sq/XJ26lKjWIB2ke3yIyRXEIDM6RTaxaV9ze
 hmPt8fdt/lwd4UXFo2ZI9uVOgfAnGK0PlBzpPIW6rE+j/jQKRsxOYn56Y9Suq/Jh4L
 9Pz7dPqolB4HeD4/+v/Qi73I8z8XzWfQ7zAfNiABUJx8ZV02cmF3LlMALC4jEK1Bqz
 fsr3P2Vhze/hG6x+JvPZG4SSDB+pOzTKGxAzduIGkO03LuKpKbTxuQ1XLhWe1+g/2m
 UKVio1yaQ9VlA==
Date: Mon, 21 Jun 2021 10:26:53 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv6] nvme: allow to re-attach namespaces after all paths
 are down
Message-ID: <20210621172653.GC1268033@dhcp-10-100-145-180.wdc.com>
References: <20210609150118.130650-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210609150118.130650-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210621_102655_876444_870C5942 
X-CRM114-Status: GOOD (  14.21  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jun 09, 2021 at 05:01:18PM +0200, Hannes Reinecke wrote:
> -void nvme_mpath_remove_disk(struct nvme_ns_head *head)
> +void nvme_mpath_check_last_path(struct nvme_ns_head *head)
>  {
> +	bool last_path = false;
>  	if (!head->disk)
>  		return;
> -	if (head->disk->flags & GENHD_FL_UP) {
> -		nvme_cdev_del(&head->cdev, &head->cdev_device);
> -		del_gendisk(head->disk);
> +
> +	/* Synchronize with nvme_init_ns_head() */
> +	mutex_lock(&head->subsys->lock);
> +	if (list_empty(&head->list))
> +		last_path = true;
> +	mutex_unlock(&head->subsys->lock);
> +	if (last_path) {
> +		kblockd_schedule_work(&head->requeue_work);
> +		if (head->disk->flags & GENHD_FL_UP) {
> +			nvme_cdev_del(&head->cdev, &head->cdev_device);
> +			del_gendisk(head->disk);
> +		}
>  	}
> +}

This is being called when a path is removed. If it is the last path, the
head's block device is being deleted. If a live head reference is held,
and the a path reconnects, the code will find the previous head, but the
disk is gone and it's not coming back, so the new connection can't be
used.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
