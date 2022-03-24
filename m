Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DCAC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 06:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eT5P76Hy7A3wof5YQPWhV7x/iSgVMTM9DmVN+49qeYQ=; b=FwoLDjgcquCugHH9UYPwXa/Ig5
	NJSUdWCqwr713btx8G427GgIUWR244i94Rlxl6jD+3F+zykYfj7SPd8S8cQOgorpEbVjMbx2HlO7Y
	wgt9I/KGXKFSUKCRru4fkGm/7hOQoM4Ney2pwbVDw07xT72T2FCrxWe+rBMNKXLbst/rNMrcLN9zO
	p1N7+RBYRYRkuWpyuHuomIESE/AwTUD/4vfi0NKv9NkKhUyOFInXb3INhpA+WFEPTUUMV7G3ujbuy
	9ppnATDXZbbhPVHvt68wMTI1yepEczU/xGJFHo3Mw5eM9NyCOc5ppJGo6zdi7XFl5PcS3DE0iz70g
	AwqMbCdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXGaB-00Fjsk-5k; Thu, 24 Mar 2022 06:04:27 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXGZu-00Fjk9-0h
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 06:04:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8FF4668C4E; Thu, 24 Mar 2022 07:04:05 +0100 (CET)
Date: Thu, 24 Mar 2022 07:04:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anton Eidelman <anton.eidelman@gmail.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com, Anton Eidelman <anton@lightbitslabs.com>
Subject: Re: [PATCH v3 2/2] nvme/mpath: fix crash in nvme_mpath_update for
 non-ana ctrl
Message-ID: <20220324060404.GB12261@lst.de>
References: <20220324003008.1588225-3-anton@lightbitslabs.com>
 <20220324003900.1589124-1-anton@lightbitslabs.com>
 <20220324003900.1589124-3-anton@lightbitslabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324003900.1589124-3-anton@lightbitslabs.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_230410_240037_1689C190 
X-CRM114-Status: GOOD (  12.94  )
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

> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 12d4afde3662..d36f2543ebe1 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -712,11 +712,13 @@ static void nvme_ana_work(struct work_struct *work)
>  
>  void nvme_mpath_update(struct nvme_ctrl *ctrl)
>  {
> -	u32 nr_change_groups = 0;
> +	if (ctrl->ana_log_buf) {
> +		u32 nr_change_groups = 0;
>  
> -	mutex_lock(&ctrl->ana_lock);
> -	nvme_parse_ana_log(ctrl, &nr_change_groups, nvme_update_ana_state);
> -	mutex_unlock(&ctrl->ana_lock);
> +		mutex_lock(&ctrl->ana_lock);
> +		nvme_parse_ana_log(ctrl, &nr_change_groups, nvme_update_ana_state);

Overly long line.  Kust retun early for the !ana_log_buf case
to sort this out trivially.

