Return-Path: <SRS0=uBfD=K4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE2DC4708F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 14:40:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC548613BF
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 14:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC548613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XUXsu88btAoPWkmNF0awlEf3zK9J2YKg3cHj7E2v8f8=; b=vdVy7gmNqMvQR8
	bcnc7Tz3XYnXmijipekaMrKcCutgtTiPFympsL7aN3Qs7EJ2UqLW5S6m3QPCj1D9NsVVGtYWcuT2E
	y4KVI4BNst/zqO6MqPjkaMj6jCbwwcv6HJaQPCXZ6NRScLDfaQWvf++lIYN75vtRwkCrksI2vpb7q
	QfaDBx7lZmc5HZ556Yl/szpP5l6E1m+g3RtCCRTDwbBALXuG/S6/S45T+WlnLfDgeeTuQvW6exqJJ
	yAwjNYHnyGKgJJbRT4Cl+JBrxo9bNcAbEGT292hTuf657fkS6e4V2+I3/48VRyVHnQq0ATlrlEERz
	ihKJIHHQXrAizCD6kOHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1loS35-004e0N-Gi; Wed, 02 Jun 2021 14:40:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loS24-004dTz-HK
 for linux-nvme@lists.infradead.org; Wed, 02 Jun 2021 14:39:45 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF6D7613AA;
 Wed,  2 Jun 2021 14:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622644783;
 bh=jI+GIBfW+TTSPEkqnl9cajZsedb1xU15s5PN+0Ulsm4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XLA8dEJsn5AN9LP9sVq8efoYniWRR1tfgU0lv7D1Z1C0PGsBAIivJU601YNX0koiX
 ZAfeGHRjs49+Nj1WYzTRQ+pFlQKUtNpi7FXoxto+ya+HEffNbDKjmWGhb0uBBXmUMG
 omPTip3iY20rdDSiiUkUeqZHFGc6FcoMBxzTNKgIT95Q4RmueG7vq5nWQIKpFwQRVv
 kPZpqWrtB+vSQZvfh89RPF9UiNSwaMYxAZba80cZWBHUoz0D8eP8atmVW04j7IlY9U
 FTFtalztjYK6q9/YGuMQrNqgAXj7dpilUUMuWZbm1+KiwNnwSKTKsLw3BK/vK9pmB2
 0Glq1dhflBldw==
Date: Wed, 2 Jun 2021 07:39:40 -0700
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: linux-nvme@lists.infradead.org, dan.j.williams@intel.com,
 logang@deltatee.com, linux-mm@kvack.org, hch@lst.de,
 sagi@grimberg.me, david@redhat.com, oren@nvidia.com,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH 3/3] nvme-pci: align CMB size according to P2PMEM alignment
Message-ID: <20210602143940.GA5751@dhcp-10-100-145-180.wdc.com>
References: <20210602111055.10480-1-mgurtovoy@nvidia.com>
 <20210602111055.10480-4-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210602111055.10480-4-mgurtovoy@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210602_073944_629277_D3EFE95C 
X-CRM114-Status: GOOD (  19.38  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jun 02, 2021 at 02:10:55PM +0300, Max Gurtovoy wrote:
> P2PMEM is using mhp framework to connect to the memory subsystem. In
> case the CMB size is not compatible to mhp alignment, the CMB mapping
> will fail. Use pci_p2pdma_align_size to align CMB size in order to
> successfully map non-aligned original CMB.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  drivers/nvme/host/pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index a29b170701fc..1197263b4cd0 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1817,6 +1817,7 @@ static void nvme_map_cmb(struct nvme_dev *dev)
>  	u64 size, offset;
>  	resource_size_t bar_size;
>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
> +	unsigned long nr_pages, min_align;

These new variables don't appear to be used anywhere.

>  	int bar;
>  
>  	if (dev->cmb_size)
> @@ -1856,6 +1857,12 @@ static void nvme_map_cmb(struct nvme_dev *dev)
>  	if (size > bar_size - offset)
>  		size = bar_size - offset;
>  
> +	size = pci_p2pdma_align_size(size);
> +	if (!size) {
> +		dev_warn(dev->ctrl.device, "CMB size is 0 after alignment\n");
> +		return;
> +	}
> +
>  	if (pci_p2pdma_add_resource(pdev, bar, size, offset)) {
>  		dev_warn(dev->ctrl.device,
>  			 "failed to register the CMB\n");
> -- 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
