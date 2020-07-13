Return-Path: <SRS0=Gozd=AY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AA7C433E6
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2020 07:43:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A3120674
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2020 07:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wXOKpAfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A3120674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/6f0tGc70y2zRQMPgNnFiOnGSUR2LV698mY+mJOe6yY=; b=wXOKpAfuDEumxXe9xVZEMCM2J
	3DWOwi6Dc0DxHEcX4vnissdO/1Waqva36jRcKEhu4v/YnUrw0l78tkDU2ri/8LeBfdxpLr6BcB8aI
	6aIKbuu1hgWDQlMV3pjRkRPUQg4VL4xwvPq3R5lM1k8Hi1D4OCNuhePKjhc0a1HajwFQJVbEG2+S1
	k1nNTSJvbkhsZW+3pnX5q4ZRcUC2TKcarj9s5Bd7z2BFgNlcDIngjkGI0rSW+//uNnNdfsenjj+y4
	VyCHYouf9MSmfMmTsAQI0rmWIPQwMEvyAgz3817ZBB1QWvGkYIkQ+adiUrm98sLZJDus/G6Kcl/uM
	vTThxJAlw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jut76-0007bG-W2; Mon, 13 Jul 2020 07:43:01 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jut73-0007Zz-0G
 for linux-nvme@lists.infradead.org; Mon, 13 Jul 2020 07:42:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4DC5E68BEB; Mon, 13 Jul 2020 09:42:55 +0200 (CEST)
Date: Mon, 13 Jul 2020 09:42:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V2 2/2] nvme-pci: use max of PRP or SGL for iod size
Message-ID: <20200713074254.GC14676@lst.de>
References: <20200709234025.10673-1-chaitanya.kulkarni@wdc.com>
 <20200709234025.10673-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200709234025.10673-3-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200713_034257_227491_807D1179 
X-CRM114-Status: GOOD (  19.81  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 09, 2020 at 04:40:25PM -0700, Chaitanya Kulkarni wrote:
> >From the initial implementation of NVMe SGL kernel support
> commit a7a7cbe353a5 ("nvme-pci: add SGL support") with addition of the
> commit 943e942e6266 ("nvme-pci: limit max IO size and segments to avoid
> high order allocations") now there is only caller left for
> nvme_pci_iod_alloc_size() which statically passes true for last
> parameter that calculates allocation size based on SGL since we need
> size of biggest command supported for mempool allocation.
> 
> This patch modifies the helper functions nvme_pci_iod_alloc_size() such
> that it is now uses maximum of PRP and SGL size for iod allocation size
> calculation.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/host/pci.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 68f7c090cf51..8b6792005360 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -363,14 +363,13 @@ static int nvme_pci_npages_sgl(unsigned int num_seg)
>  }
>  
>  static size_t nvme_pci_iod_alloc_size(struct nvme_dev *dev,
> -		unsigned int size, unsigned int nseg, bool use_sgl)
> +		unsigned int size, unsigned int nseg)
>  {
> -	size_t alloc_size;
> +	size_t npages_sgl = nvme_pci_npages_sgl(nseg);
> +	size_t npages = nvme_npages(size, dev);
> +	size_t alloc_size = sizeof(__le64 *);
>  
> -	if (use_sgl)
> -		alloc_size = sizeof(__le64 *) * nvme_pci_npages_sgl(nseg);
> -	else
> -		alloc_size = sizeof(__le64 *) * nvme_npages(size, dev);
> +	alloc_size *= max_t(size_t, npages_sgl, npages);
>  
>  	return alloc_size + sizeof(struct scatterlist) * nseg;
>  }
> @@ -2812,7 +2811,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	 * command we support.
>  	 */
>  	alloc_size = nvme_pci_iod_alloc_size(dev, NVME_MAX_KB_SZ,
> -						NVME_MAX_SEGS, true);
> +						NVME_MAX_SEGS);

I think we can just remove the size and nseg arguments and hard code them
in the function itself.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
