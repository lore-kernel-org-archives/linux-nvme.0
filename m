Return-Path: <SRS0=eYyw=5R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99612C43331
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 09:05:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A83020772
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 09:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pP1OuK6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A83020772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z4E7nh8yk3RhRe1R5rFOPJeS3r29lSILM8CexBRI8a8=; b=pP1OuK6qTSAxOk
	R4Ar5Xu5ilsgjlMD2qBhS/dqzNAJcDDGkgRsgIdFA5El+XZNuFq850LmOzChkIXcUvHWYy5vlyZ7z
	GY4twPlUko3ABd9fgjKv07wzomqV1HkijtdtDAjsfwuWkZjROb6tqZOWYRwKjwChkV5SDszNLabec
	A2P9NMgqGBaiMMEXiVRcnXXnGNraRjVY0p4Ij8YtCgg/o5fQ1J2zzFE9+Ic3wVgbuggDRDEI5rKll
	rv1VBVL6OyX+cDOQmvR8GMLRhBCGLw34XriZLcsgvQA1b98scedvn4nnSucSfpcDpIe/PGOIhXkHR
	8RQ0mE/4j1P5Lw9wyPbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJZJi-0001No-Sn; Wed, 01 Apr 2020 09:05:46 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJZJh-0001NL-3b
 for linux-nvme@lists.infradead.org; Wed, 01 Apr 2020 09:05:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4A0DC68AFE; Wed,  1 Apr 2020 11:05:43 +0200 (CEST)
Date: Wed, 1 Apr 2020 11:05:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2] nvme: inherit stable pages constraint in the mpath
 stack device
Message-ID: <20200401090542.GB31980@lst.de>
References: <20200401060625.10293-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200401060625.10293-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200401_020545_294803_FE8D0BE0 
X-CRM114-Status: GOOD (  10.15  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Mar 31, 2020 at 11:06:25PM -0700, Sagi Grimberg wrote:
> @@ -1907,6 +1907,13 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>  	if (ns->head->disk) {
>  		nvme_update_disk_info(ns->head->disk, ns, id);
>  		blk_queue_stack_limits(ns->head->disk->queue, ns->queue);
> +		if (bdi_cap_stable_pages_required(ns->queue->backing_dev_info)) {
> +			struct backing_dev_info *info =
> +				ns->head->disk->queue->backing_dev_info;
> +
> +                        info->capabilities |= BDI_CAP_STABLE_WRITES;
> +		}

I think this needs to go into blk_queue_stack_limits instead, otherwise
we have the same problem with other stacking drivers.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
