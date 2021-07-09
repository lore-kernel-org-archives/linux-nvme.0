Return-Path: <SRS0=jeJI=MB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD82AC07E99
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 08:25:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DA99613CC
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 08:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA99613CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WjcPHrobzq3D3ZmE4C3aWwnbleFSh5d9d+6Sbp9aQCI=; b=PbfPcBtWwUmD6o
	wKvhGrMaCr8FkB2vMcBUDYxOiIKPi1dxnQhphEuF00SIf8Qu8pODA8Fwc5gPxnzesK6AKRwIPgD/9
	jZ0k6Gp9hlrMrAsFA6BzSFcSjIO9RFcDl1V1epllfZ4lYqn4JUMfPfiagQqDBnfco6vDFePQdVFxz
	BD547pHC6572+4QCF7tVw9uRlyn1ZTggTEKVuVM76Alcr8Mgo8elLMz1uuPq12dAfL9FlQIcAxBVT
	P/zqtxWnrPTB1HgdvzsZJVdLrhVr4rw75YydH5Rrep3RxLl5QbRsaszd9M4sNdGfMZhkwVX6+om6W
	q9n/V1mCaQCRpveNndrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1lpJ-0017RK-Tp; Fri, 09 Jul 2021 08:25:37 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1lpE-0017P0-Fn
 for linux-nvme@lists.infradead.org; Fri, 09 Jul 2021 08:25:33 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 235E620274;
 Fri,  9 Jul 2021 08:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625819131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8K4H3iqSDD9YoSW7p9vhetIaRQmX4th7sJmNpjTLR9c=;
 b=fEmdLSOhPe7NKpluWjJFBjTodSTNn3A6oJQytry6iEejtgk12xRKLjiALvrKlVWqssg9Dn
 VGEDhmn4CdKR74eaYPMR5azEB4aQdE/kBvDM9Qcoom371hunUt6AYrtRsUvmteU1VHNCrU
 KtvVyAZTTXLnIcX80iT8Fa/5Cp0hvoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625819131;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8K4H3iqSDD9YoSW7p9vhetIaRQmX4th7sJmNpjTLR9c=;
 b=KZZl/U3IGR0oCdEhdH42sra8OgDricDFf2IEqoQhYNk1HE0nkMUM2ReWkOp20s+WZ+suUF
 MY5e0UEGVC9PPHBg==
Received: from localhost (unknown [10.163.25.122])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 4C39BA3B9D;
 Fri,  9 Jul 2021 08:25:30 +0000 (UTC)
Date: Fri, 9 Jul 2021 10:25:30 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 Wen Xiong <wenxiong@us.ibm.com>, John Garry <john.garry@huawei.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH V3 02/10] blk-mq: Introduce blk_mq_dev_map_queues
Message-ID: <20210709082530.eefzeucgqulr6spv@beryllium.lan>
References: <20210709081005.421340-1-ming.lei@redhat.com>
 <20210709081005.421340-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210709081005.421340-3-ming.lei@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210709_012532_778360_F568A56D 
X-CRM114-Status: GOOD (  15.94  )
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

On Fri, Jul 09, 2021 at 04:09:57PM +0800, Ming Lei wrote:
> +/**
> + * blk_mq_dev_map_queues - provide generic queue mapping
> + * @qmap:	CPU to hardware queue map.
> + * @dev_off:	Offset to use for the device
> + * @get_queue_affinity:	Callback to retrieve queue affinity
> + * @dev_data:	Device data passed to get_queue_affinity()
> + * @fallback:	If true, fallback to default blk-mq mapping in case of
> + * any failure

The docs have a different order compared to the function definition (dev_data).

> + *
> + * Generic function to setup each queue mapping in @qmap. It will query
> + * each queue's affinity via @get_queue_affinity and built queue mapping
> + * that maps a queue to the CPUs in the queue affinity.
> + *
> + * Driver has to set correct @dev_data, so that the driver callback
> + * of @get_queue_affinity can work correctly.
> + */
> +int blk_mq_dev_map_queues(struct blk_mq_queue_map *qmap, void *dev_data,
> +		int dev_off, get_queue_affinty_fn *get_queue_affinity,
> +		bool fallback)


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
