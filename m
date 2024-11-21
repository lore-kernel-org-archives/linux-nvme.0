Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56241D78797
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2024 17:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qb4KrOR+CILTKlO2m3f9IIt024XBHuWRXrTLIU3FsMc=; b=Af/BHMUmYyYTSs/fOJMomMtrfh
	vQf5gN/UlCU+bKlCi0u8eYwc+YBSk3CHA1yIfXERqvo4Ajh2QMNRIHslfKK8igtCWN82lLGylFlfu
	0QT8aXC9AEaZd3bKr+iJxVdxxIbWTnZ4IFLPv+DY8FHhh0CHf1vvMzbKO5Fp9U+impsEPDarE0klW
	l+pq26CxM3BZ+28NNF62jsrplCDzXv1VlBQGBbjZzXu9LDjCnEXtOx/a8Nx3ag2GkXOSgQKextNT/
	BAJfVVIFhjAzCoCoj/GLrqRoq8pmwnBGALLTDIANF+eak7GVRegIjkDg1adNAOkIKbOjHoU4kJMtO
	WtEYYIGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEAYb-00000000VCv-42r5;
	Thu, 21 Nov 2024 17:01:29 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEAYa-00000000VCM-1rXo
	for linux-nvme@lists.infradead.org;
	Thu, 21 Nov 2024 17:01:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C45F2A40C25;
	Thu, 21 Nov 2024 16:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAC0C4CECD;
	Thu, 21 Nov 2024 17:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732208484;
	bh=83thkNpnaAg9T6n+ilEpq0kz8H7CIgsiCYyw4qVQB2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEn1pwH2jeSjI7B0CvcbqTsV85e6aTUgmnVqti0KMnDO5OkrISBdobOKsQbDSEjxY
	 55alnQiXygFIZohgdTDxF6e0QTinFruY78oHKlhgZNcGQlgJxoNwKUcp5h+3IJ8jyZ
	 kbp1HKxDHONsqPjhQkga992KvuffNP49tBvJkWxroZNeKe75vif6U+ZkpkB1hfNtvl
	 43p4I8yuYy9cPiOPXnWZFNkTd4JzXjy6bRaMNjo2TpMLeY1XA5eUpTeWUpSjzIrXgY
	 7MTyZ0iT5Bq3ouBjWy/PaM/0ippqVlrU7d6mg/zmQ8EYywdy9c/sx4vV9Qk9zbBPBh
	 p67vV2DQ8NCbA==
Date: Thu, 21 Nov 2024 10:01:22 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 0/2] nvme: make pr code more readble
Message-ID: <Zz9nYlu77vg0ze2_@kbusch-mbp.dhcp.thefacebook.com>
References: <20241120071008.106933-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120071008.106933-1-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_090128_546967_97579C7C 
X-CRM114-Status: GOOD (  11.24  )
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

On Wed, Nov 20, 2024 at 03:10:06PM +0800, Guixin Liu wrote:
> Changes from v1 to v2:
> - Move the generic definitions to linux/nvme.h and add a separate
> patch for the changes of linux/nvme.h.
> - Define the different CPTPL bits separately.
> 
> Guixin Liu (2):
>   nvme: introduce change ptpl and iekey definition
>   nvme: tuning pr code by using defined structs and macros

Thanks, applied to nvme-6.13.

