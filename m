Return-Path: <SRS0=HRbs=ZT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22949C432C0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2019 07:51:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E63CF20684
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2019 07:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fqVkryJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63CF20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S2LwKkafBXyoRHRLgj1dptPCrN5ltkfWbL0TWcjO/Yc=; b=fqVkryJOaaoniC
	FNeSXcsZQ3hpf0f3dSKG16AsW1W5Hq+GvSaqrH75ZlwveyMRnIYS6Ch4toP2CTtBt5kcZPW79yTZq
	LtqdD/A+TI+sqmywRTjyI4xv2Gl8/8t9cGNvxL7ou88cp/aiVi0jRFJOaP2sdAYQ5DSk5dshedMTd
	UlxL0BrjSS/CBfRALUc9Iy/1vifNoMw4KA5D7UKyStyqK38163Uj4vBVLskqZ4DoTWgdzYPC5LT9z
	QJlVe7SXw70pvxmekl6IVA599E+PslB09FY9OMcPAsXqsW41upONqhM0p4eVGoC8xXKCzp4WvzbiQ
	ryh8kx5JpD3ueW2NebNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZs6w-0001Vi-N6; Wed, 27 Nov 2019 07:51:42 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1iZs6u-0001VS-HL; Wed, 27 Nov 2019 07:51:40 +0000
Date: Tue, 26 Nov 2019 23:51:40 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Edmund Nadolski <edmund.nadolski@intel.com>
Subject: Re: [PATCH v2 1/1] nvme: remove unused return code from nvme_alloc_ns
Message-ID: <20191127075140.GA431@infradead.org>
References: <20191126222632.2446-1-edmund.nadolski@intel.com>
 <20191126222632.2446-2-edmund.nadolski@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191126222632.2446-2-edmund.nadolski@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I think this needs some tweaks..

>  	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
>  	if (!ns)
> -		return -ENOMEM;
> +		goto out;

kmalloc failures already always leave a trace, so we can just return
here.

>  	ns->queue = blk_mq_init_queue(ctrl->tagset);
>  	if (IS_ERR(ns->queue)) {
> @@ -3525,10 +3525,8 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  	if (ret)
>  		goto out_free_queue;
>  
> -	if (id->ncap == 0) {
> -		ret = -EINVAL;
> +	if (id->ncap == 0)
>  		goto out_free_id;
> -	}

ncap == 0 means there is no namespace, this is a quirk dating back
to NVMe 1.0 where the driver has to do a sequential scan.  So we don't
need a warning here either.

So looking at this a bit more I'm not even sure we need warning messages
contrary to my previous advice, as the only obvious error that is not
a memory allocation is the command execution in nvme_identify_ns,
and the lightnvm registration which both already log warnings.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
