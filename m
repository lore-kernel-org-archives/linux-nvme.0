Return-Path: <SRS0=ttKb=YA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9209C47404
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2019 16:56:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7FD2070B
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2019 16:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oEzG7Lw0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7FD2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Pz4ZLPvUPOp8PERMEGOo2HVjHab64HYfm777jucr3Ew=; b=oEzG7Lw0MLwDHM
	F18RzuobwQbGaqXyPPc8K5pyqhwVIurNEGNbTe2JvIdkw34BlmoiX3lOnLOWh4VNtwzrGsir39y+5
	UBpewhYkpUCnMjlFuORO3SAwX+Cqn1/2CjPl8qiUIWoTaJgMwzCNnwFyOw28gwvBypEvxtgOj7+ns
	ZxeJkf3HKpriFO/2E+iLA4nyAbjhQnltLzqY3+skiueOQn1PFztQLWjQU3yi6bavveSsEOEYxr5vc
	fZy706hg8lT1b0BfgV/JwJM7iTdrmEDJGXbCpJEoCezK1Gyt2JhSbJSydAdE1fD6L2EiwIG2HbcN5
	wfD/8GTRjwr3c8G//4sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iHWJN-00015o-1R; Mon, 07 Oct 2019 16:56:41 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red
 Hat Linux)) id 1iHWJL-00015d-R5; Mon, 07 Oct 2019 16:56:39 +0000
Date: Mon, 7 Oct 2019 09:56:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: m.malygin@yadro.com
Subject: Re: [PATCH v3] nvmet: add revalidate ns sysfs attribute to handle
 device resize
Message-ID: <20191007165639.GA31190@infradead.org>
References: <20190926231940.7494-1-m.malygin@yadro.com>
 <20191007073940.19022-1-m.malygin@yadro.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191007073940.19022-1-m.malygin@yadro.com>
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> +static ssize_t nvmet_ns_revalidate_store(struct config_item *item,
> +		const char *page, size_t count)
> +{
> +	struct nvmet_ns *ns = to_nvmet_ns(item);
> +	int ret = 0;
> +
> +	ret = nvmet_ns_revalidate(ns);
> +
> +	return ret ? ret : count;

Nit: no need to initialize ret, and we can use a normal if here:

	ret = nvmet_ns_revalidate(ns);
	if (ret)
		return ret;
	return count;

> +int nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)
> +{
> +	nvmet_bdev_ns_read_size(ns);
> +	return 0;
> +}

I think we can just remove this wrapper.

> +static int nvmet_file_ns_read_size(struct nvmet_ns *ns)
> +{
> +	int ret;
> +	struct kstat stat;
> +
> +	ret = vfs_getattr(&ns->file->f_path,
> +			&stat, STATX_SIZE, AT_STATX_FORCE_SYNC);

Nit: you can add more arguments to the first line:

	ret = vfs_getattr(&ns->file->f_path, &stat, STATX_SIZE,
			  AT_STATX_FORCE_SYNC);

> +int nvmet_file_ns_revalidate(struct nvmet_ns *ns)
> +{
> +	return nvmet_file_ns_read_size(ns);
> +}

And we can just remove this wrapper as well.

Or in fact rename the low-level functions to *_revalidate which
might be a little more obvious.  But either way I don't think we need
small wrappers.

Otherwise this looks good to me, thanks for doing the work!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
