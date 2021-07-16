Return-Path: <SRS0=k+Rq=MI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8438C07E95
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 08:23:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 508F461279
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 08:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508F461279
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+OpFGBpLKdJLz/I936ZsSLFVjKEqSOSLiENhU0m3iLY=; b=MsnjBUkEAy3A16
	lLb0eAWgyhIZxxbxDjPx0npx0vatGmMaCIpBwfLpq3uY4btu8dHI5ecx4OORjq4Vu50eljxer2fTy
	v0gZy+uKiV7IyrNNDCLgsXgMr1BIUfdL6zb34BBG/WW4POthBTwxsOe5u4LbMZ4AQ8C/xXnLaWZFa
	R8c5iTsd2dHF5nWyM2qFfhU3p7LR27NFIRD9JnrvPavIexSPVrYQlRcCWHg0IuQ9TNrjLMsyukI1C
	2+S0Ry01DxQ9bufgI/EGuoE0p8J0nAnSZ6GIgbE1I+JrBEz+68SWx+cUhKDjyHFuoS+pOsMvYLcW/
	S5EDts3u1/v/nazmi8UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4J82-003hwh-GH; Fri, 16 Jul 2021 08:23:26 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4J7y-003hvw-VT
 for linux-nvme@lists.infradead.org; Fri, 16 Jul 2021 08:23:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9FA8F67373; Fri, 16 Jul 2021 10:23:20 +0200 (CEST)
Date: Fri, 16 Jul 2021 10:23:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv8] nvme: fix refcounting imbalance when all paths are down
Message-ID: <20210716082320.GA15623@lst.de>
References: <20210624085546.123824-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210624085546.123824-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210716_012323_204639_6F93CAE5 
X-CRM114-Status: GOOD (  19.52  )
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

> Changes to v7:
> - Move the list_del() call outside of nvme_mpath_check_last_path()
> Changes to v6:
> - Move the list_del() into nvme_mpath_check_last_path()
> - Drop the tests for GENHD_FL_UP
> Changes to v5:
> - Synchronize between nvme_init_ns_head() and nvme_mpath_check_last_path()
> - Check for removed gendisk in nvme_ns_head_submit_bio()
> Changes to v4:
> - Call del_gendisk() in nvme_mpath_check_last_path() to avoid deadlock
> Changes to v3:
> - Simplify if() clause to detect duplicate namespaces
> Changes to v2:
> - Drop memcpy() statement
> Changes to v1:
> - Always check NSIDs after reattach

The changelog belongs under the ---.

The patch also does not actually apply due to changes in 5.14-rc, so
please respin it.

> -	nvme_mpath_check_last_path(ns);
> +	/* Synchronize with nvme_init_ns_head() */
> +	mutex_lock(&ns->head->subsys->lock);
> +	if (list_empty(&ns->head->list)) {
> +		list_del_init(&ns->head->entry);
> +		last_path = true;
> +	}
> +	mutex_unlock(&ns->head->subsys->lock);
> +	if (last_path)
> +		nvme_mpath_check_last_path(ns->head);

And while we're at it - nvme_mpath_check_last_path is a little misnamed
now as we know this is the last path when we call it now.  Maybe this
function should inherit the nvme_mpath_remove_disk name and ther other
half should become nvme_mpath_cleanup_disk?

> +void nvme_mpath_remove_disk(struct nvme_ns_head *head)
> +{
> +	if (!head->disk)
> +		return;
>  	blk_set_queue_dying(head->disk->queue);
>  	/* make sure all pending bios are cleaned up */
>  	kblockd_schedule_work(&head->requeue_work);
>  	flush_work(&head->requeue_work);
>  	blk_cleanup_queue(head->disk->queue);
> -	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
> +	if (!test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {

This is where the conflict happens.  But given that with the above
changes we can't find the ns_head any more once nvme_ns_remove
decided it actually is the last path I don't think we even need to
clear NVME_NSHEAD_DISK_LIVE any more.  This was only needed when we
tried to reuse the ns_head.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
