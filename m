Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60209D5CCB1
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 14:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8FMhE7PAtrxTKhQq/qBchOzchTonlJi8INE1Te4Xdx8=; b=DZl30RmEQ7Ti6/Z18/W3bZFhqr
	UorVz62A4CyN6gTzXRhFEvrWUMdb5bEfv7sfY0XYfopctz+Cuv1+XbsB7aLrT9t3FgZD6wVcYz8oL
	S8+AGtKr/xQL8s91St9XfI9n+UPFO9Wh/z8BnaOgdbmGZgHxwVQ1R29rF4YIyYS+q/z9HeUp4pQ99
	y6gR13FsmjUivUljKHfiFqAY0ur4aFngkPX9leGvzNsVGuSlpx1jNFcubaCX6mQnoWoi2GtaF4KY+
	6zRg9TQriw1YSBGTV46XsAQsVgHXRo95FXHjtepR1SUtjePjF0FP4++qWe3sB8f2djke02gS02aiX
	Et+UjaAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t69XA-00000000czb-1HFO;
	Wed, 30 Oct 2024 14:18:52 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t69X7-00000000cyy-1rwU
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 14:18:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E2A825C5D73;
	Wed, 30 Oct 2024 14:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AD0C4CECE;
	Wed, 30 Oct 2024 14:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730297928;
	bh=2OJ4YTGyzx/icKpLoVN3jD36+5pXJPGI1gXnNYG93NQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c3k0ceCgyH1PI/9aj98yoZ+qGkHpmzWtvtCS+HI8+NeFIC9Y0FlULrIqLtNOc4/9t
	 Z1tkgsgkvYyB6LXFHZVhgFulwgaw+3niLhjQqMhO7BqKASZ+jeVoNRHZVeS4voCPQd
	 LUPNnIaBewYSBk494PYTW7SaozFZlxmrycu+k52nxoppDS/+rWBHzYa38/iZLCs3ps
	 sfcprLPVWQpqHgUneO/Lop7+BOCCSO7AwIEv5tFjGWxPkah+5BeEl35jbEWef8qNPZ
	 KNCL345dcUawR9csYaS6tBbKEuTtt7KfHmEzxAMs085sUiUoddoW9hCyzso5Vo18aB
	 Njv4LxVhDS6Ag==
Date: Wed, 30 Oct 2024 08:18:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, martin.petersen@oracle.com,
	joshi.k@samsung.com, David Wei <dw@davidwei.uk>
Subject: Re: [PATCHv3] nvme: module parameter to disable pi with offsets
Message-ID: <ZyJARWPnVzsWVrYe@kbusch-mbp.dhcp.thefacebook.com>
References: <20241024154923.3156803-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024154923.3156803-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_071849_590030_BD8B22ED 
X-CRM114-Status: GOOD (  16.38  )
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

On Thu, Oct 24, 2024 at 08:49:23AM -0700, Keith Busch wrote:
> +/*
> + * Older kernels didn't enable protection information if it was at an offset.
> + * Newer kernels do, so it breaks reads on the upgrade if such formats were
> + * used in prior kernels since the metadata written did not contain a valid
> + * checksum.
> + */
> +static bool disable_pi_offsets = false;
> +module_param(disable_pi_offsets, bool, 0444);
> +MODULE_PARM_DESC(disable_pi_offsets,
> +	"disable protection information if it has an offset");
> +
>  /*
>   * nvme_wq - hosts nvme related works that are not reset or delete
>   * nvme_reset_wq - hosts nvme reset works
> @@ -1915,6 +1926,8 @@ static void nvme_configure_metadata(struct nvme_ctrl *ctrl,
>  		head->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
>  	if (!(id->dps & NVME_NS_DPS_PI_FIRST))
>  		info->pi_offset = head->ms - head->pi_size;
> +	if (info->pi_offset && disable_pi)
> +		head->pi_type = 0;

I need to rework this yet again. The old code didn't look for offsets.
It looked for the "first" flag. If you have MS == PI_SIZE, "first" and
"last" mean the exact same thing: there is no offset. But the old code
didn't care, it just wanted to see the PI_FIRST flag.

The part needs to look like this:

---
@@ -1937,10 +1937,12 @@ static void nvme_configure_metadata(struct nvme_ctrl *ctrl,

        if (head->pi_size && head->ms >= head->pi_size)
                head->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
-       if (!(id->dps & NVME_NS_DPS_PI_FIRST))
-               info->pi_offset = head->ms - head->pi_size;
+       if (!(id->dps & NVME_NS_DPS_PI_FIRST)) {
+               if (disable_pi_offsets)
+                       head->pi_type = 0;
+               else
+                       info->pi_offset = head->ms - head->pi_size;
+       }
--

