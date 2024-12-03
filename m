Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B8AE6C5E4
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 00:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mbCJtHTiz0gAT9HGpV4deOGQglV4pHaXHwQoeVIPn64=; b=BrF8oO3YMbahybJ5zhyAtHwSOr
	xyfj2A+Q3Bu2vj1CZfgHByk4RlROmj+PdS+c3h+Dc4u3JZDqHqnMyTdhQUZW53Oe8d5RKWrd7uDIh
	WqPKrsjx+GPAUHmufmzNJ4DQkfLVNuDm6OF3C9/YekKC9cp1HQL1H6QUeW6e1d2FL0YcIjuYZ5eck
	42whFM8eIHHBE+QVHGT2DCXRo63ePEiLh4VQo8Ed+xCKpFLB3sMTkx5tl9HoedDu2JuSHbWuvKIm2
	omUmJ1hGLdRLTMd3K4lRHTAf7NL1nNFhj3r+nioWs5v4SSwGn8i4m821hJCHAmRzlhYP3D5qAO4JL
	HSomR6SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIGtk-00000007q8U-1OBc;
	Tue, 03 Dec 2024 00:36:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIGth-00000007q7X-0JS1
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 00:36:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4074568BEB; Tue,  3 Dec 2024 01:36:08 +0100 (CET)
Date: Tue, 3 Dec 2024 01:36:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, kanie@linux.alibaba.com,
	kch@nvidia.com, loberman@redhat.com, emilne@redhat.com,
	jmeneghi@redhat.com
Subject: Re: [PATCH] nvme-fabrics: handle zero MAXCMD without closing the
 connection
Message-ID: <20241203003607.GA7439@lst.de>
References: <20241129141706.261171-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129141706.261171-1-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_163613_255020_FC784548 
X-CRM114-Status: GOOD (  13.17  )
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

On Fri, Nov 29, 2024 at 03:17:06PM +0100, Maurizio Lombardi wrote:
> The NVMe specification states that MAXCMD is mandatory
> for NVMe-over-Fabrics implementations. However, some NVMe/TCP
> and NVMe/FC arrays from major vendors have buggy firmware
> that reports MAXCMD as zero in the Identify Controller data structure.

Sigh.

>  	if (!ctrl->maxcmd) {
> -		dev_err(ctrl->device, "Maximum outstanding commands is 0\n");
> -		return -EINVAL;
> +		dev_err(ctrl->device,
> +			"Firmware bug: maximum outstanding commands is 0\n");
> +		ctrl->maxcmd = ctrl->sqsize + 1;

Maybe warn instead of err as made it not an error now?  Otherwise
looks fine.


