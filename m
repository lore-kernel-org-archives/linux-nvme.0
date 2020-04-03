Return-Path: <SRS0=Pknt=5T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDF0C43331
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2020 06:43:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F8C320757
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2020 06:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NQ1Asomg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8C320757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zVIeTIJ8tVc6YuVHowg1iNvI4BE3GJpRi+ev2Wb9R+M=; b=NQ1AsomgTt6kgM
	eBGRgL3LaphtvMPkY1E5Yxhmu9ojUP/zpYysK3/oLJwqYIHL6hVxreTxifedNKDwoiNqA8uvf4/Sf
	4dorUWSmCm+tLhFnciWCQGqPc4GQ1Sp04O9VRSCzXSs+BiCwTXJ4ySFiYAJ4cBjpJkLK19AkI0vlb
	Mie+KGJiuA3LV1sSNNTOjhtltmu2WspPfnIs3yBIYOkI97htq1t4UYw5n4NCDjtDIe11SCG7HaXnX
	rMUUk2FfPGWNpYaKgoWXw2Ko7UJY0627y+WdkOt2IOZ8vh12vUYnL25ig7dx0BHz8QFvbMnLSdVam
	Qt/Su9Z7V7C2i5gWHCVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jKG3E-0001wF-DU; Fri, 03 Apr 2020 06:43:36 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jKG3C-0001vv-7e
 for linux-nvme@lists.infradead.org; Fri, 03 Apr 2020 06:43:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E9AE468B05; Fri,  3 Apr 2020 08:43:31 +0200 (CEST)
Date: Fri, 3 Apr 2020 08:43:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anthony Iliopoulos <ailiop@suse.com>
Subject: Re: [PATCH] nvmet: add revalidation support to bdev and file
 backed namespaces
Message-ID: <20200403064331.GA23270@lst.de>
References: <20200402193052.19935-1-ailiop@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200402193052.19935-1-ailiop@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200402_234334_422834_E95D8EB6 
X-CRM114-Status: GOOD (  11.47  )
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
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Apr 02, 2020 at 09:30:52PM +0200, Anthony Iliopoulos wrote:
> Add support for detecting capacity changes on nvmet blockdev and file
> backed namespaces. This allows for emulating and testing online resizing
> of nvme devices and filesystems on top.
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>

I vaguely remember seeing a very similar patch before, is this a repost?

> +void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)
> +{
> +	loff_t size;
> +
> +	size = i_size_read(ns->bdev->bd_inode);
> +
> +	if (ns->size != size)
> +		ns->size = size;

This can be:

	ns->size = i_size_read(ns->bdev->bd_inode);

> +void nvmet_file_ns_revalidate(struct nvmet_ns *ns)
> +{
> +	struct kstat stat;
> +
> +	if (!ns->file)
> +		return;

Shouldn't this always be non-NULL?

> +
> +	if (vfs_getattr(&ns->file->f_path,
> +			&stat, STATX_SIZE, AT_STATX_FORCE_SYNC))
> +		return;

Use up the full line:

	if (vfs_getattr(&ns->file->f_path, &stat, STATX_SIZE,
			AT_STATX_FORCE_SYNC))

Also shouldn't there be error handling?  If we can't stat the file
the namespace is toast.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
