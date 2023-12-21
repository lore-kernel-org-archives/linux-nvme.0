Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74993C35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 12:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C0Cx7if/r000DXrkacvSbOKycx1Xl3mQUDt6OqhcFE4=; b=G/W7NxOizOlMU1SFMbN/3bbD/+
	MqtiOQZNTyT4RQ7HMJcm0/dmvtVjX84xpos6WtnGGa22A5g9YVHyPpIoBCNN562yrT+zwGgJmFdQ5
	OVko3dVU+1DHi7V40gBXWmNEX0/MSULhstoj2r2nRv6dPKnEs1Z4BiKfCUvWMSov8hShcrZddbZ2F
	lmhvvy1NX/oa+j8hzTn7mcVcKAWc2xB9ym6IrLkggKheCxxh2xDbaJ7kCeoHiCXwQdm9A48teYugV
	0uvkbeiSBhRCBNysFSl8zJvtdz3sL5R5kEehoLhuoxU0iFx7edMlaUhb0Al1OmtYFjk6sTFXaS0Qt
	pc9OJKNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGHzy-002jNA-0n;
	Thu, 21 Dec 2023 12:17:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGHzu-002jMp-37
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 12:17:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AEAFE68BFE; Thu, 21 Dec 2023 13:17:46 +0100 (CET)
Date: Thu, 21 Dec 2023 13:17:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, marcan@marcan.st, sven@svenpeter.dev,
	kbusch@kernel.org, axboe@kernel.dk, james.smart@broadcom.com,
	alyssa@rosenzweig.io, asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org, kch@nvidia.com
Subject: Re: [PATCH] nvme: don't set a virt_boundary unless needed
Message-ID: <20231221121746.GA17956@lst.de>
References: <20231221084853.1175482-1-hch@lst.de> <155ec506-ede8-42c7-95f7-e8be32800a8d@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155ec506-ede8-42c7-95f7-e8be32800a8d@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_041755_151463_2D0931D6 
X-CRM114-Status: GOOD (  22.76  )
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

On Thu, Dec 21, 2023 at 11:30:38AM +0200, Sagi Grimberg wrote:
>
>> NVMe PRPs are a pain and force the expensive virt_boundary checking on
>> block layer, prevent secure passthrough and require scatter/gather I/O
>> to be split into multiple commands which is problematic for the upcoming
>> atomic write support.
>
> But is the threshold still correct? meaning for I/Os small enough the
> device will have lower performance? I'm not advocating that we keep it,
> but we should at least mention the tradeoff in the change log.

Chaitanya benchmarked it on the first generation of devices that
supported SGLs.  On the only SGL-enabled device I have there is no
performance penality for using SGLs on small transfer, but I'd love
to see numbers from other setups.

>> For nvme-rdma the virt boundary is always required, as RMDA MRs are just
>> as dumb as NVMe PRPs.
>
> That is actually device dependent. The driver can ask for a pool of
> mrs with type IB_MR_TYPE_SG_GAPS if the device supports IBK_SG_GAPS_REG.
>
> See from ib_srp.c:
> --
>        if (device->attrs.kernel_cap_flags & IBK_SG_GAPS_REG)
>                 mr_type = IB_MR_TYPE_SG_GAPS;
>         else
>                 mr_type = IB_MR_TYPE_MEM_REG;
> --

For that we'd need to support IB_MR_TYPE_SG_GAPS gaps first, which can
be done as an incremental improvement.

>>   +	/*
>> +	 * nvme-apple always uses PRPs and thus needs to set a virt boundary.
>> +	 */
>> +	set_bit(NVME_CTRL_VIRT_BOUNDARY_IO, &anv->ctrl.flags);
>> +	set_bit(NVME_CTRL_VIRT_BOUNDARY_ADMIN, &anv->ctrl.flags);
>> +
>
> Why two flags? Why can't the core just always set the blk virt boundary
> on the admin request queue?

It could, and given that the admin queue isn't performance critical it
probably won't hurt in reality.  But why enforce a really weird limit
on the queue if there is no reason for it?  The only transport that
treats the admin queue different is PCIe, and that's just a spec
oddity.

