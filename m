Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C467C7EE24
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 17:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hGhbBOOFWTaYVMmGXnRvNAnBaR95rvSV4SLx1vKxkfk=; b=cOIWn7wNR9hP5LEc4TqP6GcYU+
	OBIJS57jbesSc5Mi33kBz1TIvuc5MlFMP+AH3bYzy8taRCIK29QsmV5AtIJFeGz5Q8aU6naiPZypa
	oknPDpmuvcK56hSL09xJPUuU5FvZTMrcfTgiKbKo0u88YCTmdLwnkCNb5dZ9EwhjVBQ4u7I5r9/v2
	rS0IivVNofvJlr+RrIigcsfzdE4eaH4Ov0UwxQi30Ezugv6ZStYiSV2MSliqTGM+u4U7Q32SppbQG
	67G6DuYLzNe4mU8k2gUgvwQEruKbhis3n0Ufv7kvJKojV/z6EL8tyHa3yyebwsCDhG30/BhwiFCvE
	drdx5wYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6ath-002gR7-2b;
	Tue, 06 Jun 2023 17:55:09 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6ate-002gOD-10
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jun 2023 17:55:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 394C261001;
	Tue,  6 Jun 2023 17:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60408C433D2;
	Tue,  6 Jun 2023 17:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686074104;
	bh=CS51uNu+V3TH212IMYYc1GUFW0sds7boRLarOeJEzBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mma0zKIf9EgK/26geS2UZ5BxnBDh+Xwll6B/kw8OTY4IaedoVNOv5daPrO+SYH4LU
	 eJF3kUx+TuS88APmZpXFrSs/PFLmccuYI2e8w9VtaeCjvpcS0LVss/k8kAhhFcIkI1
	 iCU3Xix6CvbphMgLV2DO9XkVeD2gIDiDYpDXWqg3iwBJlzWqFZ8ZvfNvKB5Cq5IjZR
	 a6BUS8g2nmgOF4kHkADuEN3s1RSGRs0j4X4YfFJyfdXcqOlgh0fBYWasGRvlnMoAzs
	 ZTutoXzzoiEliTyv59rFEObxGLpPPTMYbDuTvxbVHkbtsIlpmWzz2bf455dghE7gHu
	 rgkwlKkhKHI1Q==
Date: Tue, 6 Jun 2023 10:55:02 -0700
From: Keith Busch <kbusch@kernel.org>
To: Irvin Cote <irvincoteg@gmail.com>
Cc: hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-core: warn and abort if shared ns with empty list
Message-ID: <ZH9y9j2KBHRW+Olj@kbusch-mbp.dhcp.thefacebook.com>
References: <20230606082134.20623-1-irvincoteg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606082134.20623-1-irvincoteg@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_105506_400058_3EEB5A92 
X-CRM114-Status: GOOD (  23.51  )
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

On Tue, Jun 06, 2023 at 10:21:34AM +0200, Irvin Cote wrote:
> In nvme_find_ns_head if we find a shared ns but it has an empty
> list or its refcount is 0 we gloss over it and go to the next.
> Ignoring when such a case happens means that when nvme_find_ns_head
> returns NULL, we could create a new nshead with the same nsid. Hence
> we could find ourselves with two shared nsheads having the same nsid.
> Instead warn the user through dev_err and exit.

Let's say you're holding a reference on the old "head" and then hot
remove the drive. The kernel will tear down the device and its
namespace, but the subsystem and empty head will remain due to that
held reference.

Now plug the drive back in. Today, the controller will attach to the
previous subsystem, and make a new "head" for its namespace (because the
old one is empty), and you can continue from there, though the new
handle names may look a bit odd.

This change won't make the re-added namespace visible to the user, which
doesn't sound right.
 
> Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
> ---
>  drivers/nvme/host/core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c8a471482421..175f1516083f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3341,6 +3341,11 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
>  			continue;
>  		if (!list_empty(&h->list) && nvme_tryget_ns_head(h))
>  			return h;
> +		else {
> +			dev_err(ctrl->device,
> +				"Found shared namespace with empty list or 0 refcount\n");

I don't think we're guaranteed this path is using a "shared" namespace.

> +			return ERR_PTR(-ENOENT);
> +		}
>  	}
>  
>  	return NULL;

