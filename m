Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAA8C27C5E
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 16:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vv0VteWfz8gjEJZMAWzkSdv+qo/UptSkZrPr3VGIELc=; b=nMtHAU7FYj/wf0MxJSdoeky5nY
	DP6Z6rjGr3/Ak4lODkwFw42bKIBJCnHqpaLz6Xm7sXWGdakX/90kbp0szjL/r0CjXorZaozGJszP1
	kSC9biWfWu6UPYWCm2XaAYGp/keOYv3WdW6lm6ESzv/3IWwwMaZ+W+E8jH/gVPVUtVDj13T+QrOPf
	Zays1YHgmN86ZeZQkSGObWMiwKhVUPkDMGUGlsOV6K4NxI+JNpvupzStTiV1PTVS5n0Ukclb/eMhH
	VSRboKv58B3YkJP7MV2qgmZY9u/IVL3fgupIrHpqx2QJ4eX8dr39LkfO3TuHnyYIJHqqF+mdP5XHt
	pOl6IBgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEt4U-00000006kpk-1t0p;
	Wed, 05 Jun 2024 16:01:06 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEt4R-00000006kna-00bY
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 16:01:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id DB324CE1874;
	Wed,  5 Jun 2024 16:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BE6C2BD11;
	Wed,  5 Jun 2024 16:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717603260;
	bh=SrI+71rKl1K55T4g8XU6Gvy25ryGeT0fvpfwcj0HJCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jHUeSONoFrp3K20BeziXOsfGHdN9+CvCafPknjBXdJW+EfKtGiK5+3WI/vwdj1EyD
	 MO80yupTQMqjZGPjwp+VHixRfN1Pg6SFZtqced7+XJIyys+mkew9jCEIFl5hIUertr
	 RICZQAJCDC7XrX95B7TPOSlnPQQEylrVMvJB8F8eS89M/ROim6kRRVi/qVdMjLUXnP
	 brQguPtw3afEfUMvmO5w9YJFgz82e4A+n63cXuHixDXKyVLiKDmunhmgXR0U5OD1RZ
	 vxfMXVa850T6ypr1vB4zSzkoE+yc4G+UL5KWOpKHW7TizUNts2XQVS3v4pN96lCiIg
	 P8//SmpLJ2DCQ==
Date: Wed, 5 Jun 2024 10:00:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 07/12] block: use kstrtoul in flag_store
Message-ID: <ZmCLuFEjvb-BejMT@kbusch-mbp.dhcp.thefacebook.com>
References: <20240605063031.3286655-1-hch@lst.de>
 <20240605063031.3286655-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605063031.3286655-8-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_090103_247743_4EFA4F5C 
X-CRM114-Status: UNSURE (   8.95  )
X-CRM114-Notice: Please train this message.
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

On Wed, Jun 05, 2024 at 08:28:36AM +0200, Christoph Hellwig wrote:
> Use the text to integer helper that has error handling and doesn't modify
> the input pointer.

Looks good. 

Reviewed-by: Keith Busch <kbusch@kernel.org>

