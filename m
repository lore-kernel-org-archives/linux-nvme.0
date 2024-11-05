Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2416D12686
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 11:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/RHgiACkoxH9FQ95lGguvA9q42b/3rb142rGt6LEI9I=; b=zQOvHz5IFfyeDBScwwac8waKYU
	zo8G37xVF/9FiPKR3VqVYBnW9/ylCiRQ04nJBsiqwUIMNL/V6hGpv/br7m8UyotljPcen44/r7k+O
	WW8ymkPT7J6Ptv2FO7gipakvKN3L7O5XAoIHb//4rDZnaikSjTdJ2pglZPMIlapIDmrp/yUXltxyW
	ov4ap96hRL1sWtx8cxEskifdeopaAxDFOVdD13qi6Bb2Vu/t/ChQnkEca6VYxVgR97dWxwbSc5Zpe
	LogEq9py9yJ1fIkwJ838Jljvf3tf4QI0dUyYwbNAOtlu1xn9U4ckTj6HsEg9P7iMzOPJATJHYBUQV
	De2TypLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8HUP-0000000GnxA-0pmA;
	Tue, 05 Nov 2024 11:12:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8HUM-0000000GnvP-1T1z
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 11:12:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C111F227AA8; Tue,  5 Nov 2024 12:12:43 +0100 (CET)
Date: Tue, 5 Nov 2024 12:12:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH RFC 1/3] nvme: check ns's volatile write cache not
 present
Message-ID: <20241105111243.GB1993@lst.de>
References: <20241104085524.118221-1-kanie@linux.alibaba.com> <20241104085524.118221-2-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104085524.118221-2-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_031246_555062_E19C5D4A 
X-CRM114-Status: GOOD (  12.29  )
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

On Mon, Nov 04, 2024 at 04:55:00PM +0800, Guixin Liu wrote:
> When the VWC of a namespace does not exist, the BLK_FEAT_WRITE_CACHE
> flag should not be set when registering the block device, regardless
> of whether the controller supports VWC.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


