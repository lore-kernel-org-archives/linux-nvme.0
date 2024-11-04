Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF60D132C0
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 13:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DOECyxCGOwvv7BM6GUwwDqz2RGrqvfsFT6yooin5W4A=; b=RARb2boN6AutamQhw3DT4gm7kn
	ILGRudKfBcWQSLUjXeDow7eFRmoRTAFS6QQK6PnH4V4E7p9yWyJ9UWTe6tWMs04U0ln1caiZ462as
	6NJAfjH6yEBc8qvSDy+Dq9w4saM+f/Cq86ha6+PzTgTxx9HN7ICEJPkthXBD55ah70frviW/LTFcg
	O+IitofH8FJAJhgG/SoVmOVB2SpxlFjMzeJeoSHOTxH48u13x1FDc3Qq92N9+cfPN+bm+s22WksUh
	HCVz6p9OAb2kEpRJtRGA1ioDTENUfGM55V6bWaM7HugDdmVzvp1C7MwlT2FiYyEl8gT7v7wZoQq7Q
	gVFlGz3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7wvi-0000000Do9c-2ert;
	Mon, 04 Nov 2024 13:15:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7wvf-0000000Do93-2eDi
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 13:15:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1F2EE227AAF; Mon,  4 Nov 2024 14:15:30 +0100 (CET)
Date: Mon, 4 Nov 2024 14:15:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: check at least one ns identification reported
Message-ID: <20241104131529.GA14373@lst.de>
References: <20241104031418.121235-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104031418.121235-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_051535_842256_0E3569CA 
X-CRM114-Status: GOOD (  11.80  )
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

On Mon, Nov 04, 2024 at 11:14:18AM +0800, Guixin Liu wrote:
> Per the NVMe spec after 1.3:
>   At least one Namespace Identification Descriptor identifying the
>   namespace (i.e., NIDT field set to 1h, 2h, or 3h).
> Check there is at least one reported.

What problem does this try to solve?


