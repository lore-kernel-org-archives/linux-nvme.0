Return-Path: <SRS0=VrRv=6P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC027C47253
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 13:05:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C142071E
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 13:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JFSlx3pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C142071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M4Q+lE7toXAtlx3bQCe0mdsSbPnH00/LCDMRFVqS7O8=; b=JFSlx3paetUogk
	pzs+mjRFn6iGIkyDhAtZHXJtiAUeaXf3quO9efOkU/ICe6D6zUK0TAlcG3lTYw6hozPKn2civDf0z
	+VdnW445a0q04BiLNvS+x4eWcA9x8MFOsAp5HoUvk7Twof5CVf1+It0z69H0tZxusFF1U1CF4U9k1
	TqyBJ3Y/CCDEvRU4+qA510lBT/wrKFg0/n/tuSv5d3ZpFPTQPTNmHsp7Q7OjOUf1vvSii4+D9DmGl
	+mC9ioVRvqTOe9MDRsYSUZdWrue1gYEtBNmQVbbUnF4K8i2Jig81dPXa6HnE8VuSl2KgSTLajTfWC
	hyqkVIbKvGeCquHzV9fg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jUVLy-0005zn-8V; Fri, 01 May 2020 13:05:18 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jUVLw-0005zQ-Vh; Fri, 01 May 2020 13:05:16 +0000
Date: Fri, 1 May 2020 06:05:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Weiping Zhang <zhangweiping@didiglobal.com>
Subject: Re: [PATCH v3] nvme: align io queue count with allocted nvme_queue
 in nvme_probe
Message-ID: <20200501130516.GA30943@infradead.org>
References: <20200424043258.GA5512@192.168.3.9>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200424043258.GA5512@192.168.3.9>
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
Cc: axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 hch@infradead.org, kbusch@kernel.org, maxg@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I don't really thing we need the new sysfs attribute.  Comments below:

>  struct nvme_dev {
>  	struct nvme_queue *queues;
> +	int nr_allocated_queue;
> +	int nr_write_queues;
> +	int nr_poll_queues;

Can you keep these at the end of the structure given that they aren't
needed in the fast path?  Also any reason these can't be unsigned?

> +	/* reload io queue count from module paramters write/poll_queues */
> +	if (dev->ctrl.io_queues_reload) {

So instead of the sysfs attribute, what about just executing this
code unconditionally?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
