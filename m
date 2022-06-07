Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3902EC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 10:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ITpcIHZ91VsoD+W9JTNgOFEnqyf1cKHXAugBq/VIOmE=; b=bh7cGemSrisjVTwouXxfwO6KWW
	6i4eTaxFotJPYIpCIb4TMEvS9Ir8PzNaz0NvqbjsESXo0Myoo8OsTx2CuuDg82WLc4zM0d+kFlipl
	ruNb7IntoZ/NxRqW9d7oYHThQGglld44a1SSq4Z0NVzLAb4sxKlGt/NjeauWFFwzAQqRuJpcbTQ2d
	yeSNoiDJXkKH4SKDtJw2n8sk3EUfcl5H4L6xiFzwbgOpdEAB1F9Pc3+FyRoeTy8BN0f+8d8dULqs/
	WE6U2GkfaJRDVu3781rOVPBYtVYo68v36DccIkmp8xNullsKnJJDTwOne3dielP8o2FsvXDrCmibq
	Y5AoIpZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyWOx-006dEh-5x; Tue, 07 Jun 2022 10:25:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyWFK-006ZLO-NX
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 10:15:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C5B3B67373; Tue,  7 Jun 2022 12:15:26 +0200 (CEST)
Date: Tue, 7 Jun 2022 12:15:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@fb.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: add bug report info for global duplicate id
Message-ID: <20220607101526.GA23753@lst.de>
References: <20220606164047.2549647-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606164047.2549647-1-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220607_031534_975247_C2103B5F 
X-CRM114-Status: GOOD (  11.46  )
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

On Mon, Jun 06, 2022 at 09:40:47AM -0700, Keith Busch wrote:
>  	if (ret) {
> +		struct nvme_subsystem *subsys = ctrl->subsys;
> +
>  		dev_err(ctrl->device,
>  			"globally duplicate IDs for nsid %d\n", nsid);
> +		dev_err(ctrl->device,
> +			"bug report info: VID:%04x model:%.*s firmware:%.*s\n",
> +			subsys->vendor_id,
> +			nvme_str_len(subsys->model, sizeof(subsys->model)),
> +			subsys->model,
> +			nvme_str_len(subsys->firmware_rev,
> +				     sizeof(subsys->firmware_rev)),
> +			subsys->firmware_rev);

So I like the idea here, but this won't give us the PCI device id
that we usually need for quirks.

