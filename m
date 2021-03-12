Return-Path: <SRS0=WLLZ=IK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E637CC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 20:48:26 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ABC664F4F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 20:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABC664F4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	 bh=H9FEO3trXscejy6txV3lCYH5AdwEhVNrjy21YsBr6K4=; b=hh5OzQW26TjNTHCa+/3ZQ+jgs
	VUfRo+h4WFNZM0/mocGvb0QxHgUFQheWxYl+PJ/JjPLEt53UW4K2FmV3CdgLbFq6BHqsRN9OPw8EA
	LP7o4wXAOtukuCvn+vDYqJfXeH9PwVRLvQe/YKr0ZcPZ8KWh21Cru9e0P/Zta0kFTqGZRxTCJGff+
	l6liQdoRYUq0ScqP14vuPCSwr/ROa4PBHdT96OnZfg0tnfB4CP1KK+81nxfjWchJUzvhifurV4pNW
	4DFU7h756RTRX6r8S8HRIExjhJrBSo6HRP1cshU1HUhJuPNZugGYKI1tUWX14drUOSIHcKmhpIEl5
	HvC5Inuug==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKohj-00CNR7-Si; Fri, 12 Mar 2021 20:48:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKoZP-00CM61-FH
 for linux-nvme@lists.infradead.org; Fri, 12 Mar 2021 20:40:07 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CA2864F4F;
 Fri, 12 Mar 2021 20:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615581577;
 bh=9xbU4dGm9+BmmqkFklPfuZZosdug6fd3AsnEv7H5YFw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=HwKo5k8pp1FCYm+q0FK8hZDzmOtZx9D48iVHE47cQK63UFdrBQCVKqUKLkgEBggln
 9ztDXjeFMO5NtU6M81ttmz3YIzjAGdpaoj3WUyaTpYbLYPOIKTitTDDSUkBhPVh3ei
 uZsnO60vXuNiDQWVZ67GOIH2ex/69BES8gJ7TKBgxsWmrOjmXpp0jtb76zJB+drQ+5
 ttjsPLmcKVIKwI3YB6xyobjyZP8xBLzeJdU5wwcKBBOdxC6tVTrjKJeom0pbVqECZk
 AfgwD4VNAjFL9YMwxOIBwj+mIvgXP13JwgZm35A3RHZfv+EulcxAypQ0uvjMBrvARD
 TGvtqBg9cRwfw==
Date: Fri, 12 Mar 2021 14:39:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Ira Weiny <iweiny@intel.com>, John Hubbard <jhubbard@nvidia.com>,
 Don Dutile <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>
Subject: Re: [RFC PATCH v2 01/11] PCI/P2PDMA: Pass gfp_mask flags to
 upstream_bridge_distance_warn()
Message-ID: <20210312203936.GA2286981@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210311233142.7900-2-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210312_204005_251123_1F99754C 
X-CRM114-Status: GOOD (  23.07  )
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

On Thu, Mar 11, 2021 at 04:31:31PM -0700, Logan Gunthorpe wrote:
> In order to call this function from a dma_map function, it must not sleep.
> The only reason it does sleep so to allocate the seqbuf to print
> which devices are within the ACS path.

s/this function/upstream_bridge_distance_warn()/ ?
s/so to/is to/

Maybe the subject could say something about the purpose, e.g., allow
calling from atomic context or something?  "Pass gfp_mask flags" sort
of restates what we can read from the patch, but without the
motivation of why this is useful.

> Switch the kmalloc call to use a passed in gfp_mask  and don't print that
> message if the buffer fails to be allocated.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/p2pdma.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 196382630363..bd89437faf06 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -267,7 +267,7 @@ static int pci_bridge_has_acs_redir(struct pci_dev *pdev)
>  
>  static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
>  {
> -	if (!buf)
> +	if (!buf || !buf->buffer)
>  		return;
>  
>  	seq_buf_printf(buf, "%s;", pci_name(pdev));
> @@ -495,25 +495,26 @@ upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
>  
>  static enum pci_p2pdma_map_type
>  upstream_bridge_distance_warn(struct pci_dev *provider, struct pci_dev *client,
> -			      int *dist)
> +			      int *dist, gfp_t gfp_mask)
>  {
>  	struct seq_buf acs_list;
>  	bool acs_redirects;
>  	int ret;
>  
> -	seq_buf_init(&acs_list, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
> -	if (!acs_list.buffer)
> -		return -ENOMEM;
> +	seq_buf_init(&acs_list, kmalloc(PAGE_SIZE, gfp_mask), PAGE_SIZE);
>  
>  	ret = upstream_bridge_distance(provider, client, dist, &acs_redirects,
>  				       &acs_list);
>  	if (acs_redirects) {
>  		pci_warn(client, "ACS redirect is set between the client and provider (%s)\n",
>  			 pci_name(provider));
> -		/* Drop final semicolon */
> -		acs_list.buffer[acs_list.len-1] = 0;
> -		pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
> -			 acs_list.buffer);
> +
> +		if (acs_list.buffer) {
> +			/* Drop final semicolon */
> +			acs_list.buffer[acs_list.len - 1] = 0;
> +			pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
> +				 acs_list.buffer);
> +		}
>  	}
>  
>  	if (ret == PCI_P2PDMA_MAP_NOT_SUPPORTED) {
> @@ -566,7 +567,7 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
>  
>  		if (verbose)
>  			ret = upstream_bridge_distance_warn(provider,
> -					pci_client, &distance);
> +					pci_client, &distance, GFP_KERNEL);
>  		else
>  			ret = upstream_bridge_distance(provider, pci_client,
>  						       &distance, NULL, NULL);
> -- 
> 2.20.1
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
