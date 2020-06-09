Return-Path: <SRS0=KBoe=7W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6070C433DF
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2020 16:30:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7187F20734
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2020 16:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qA0es/bQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6q0N9P+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7187F20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OH6BJJm7ZKXc5dt4hq2PjZ8m/4p+xv7lwtYFgAf5ZOo=; b=qA0es/bQDCU/9S
	WtNfkiNt3LuOTP6/fnAzhGwEwDzU8lq18ggovW5c2Iw6/CKVIwfui5+X+rGxLCNqfhIUNYnV2pcMS
	P459eS38be/VF2T8toSAxQAyGb8E86FQKbovCtGvm9HuykLjX72+0df3/KneqyH5+RyEhqSxmfRTY
	Yo260xeMNJVa+4T04F8WbcsFwH3XYkgT3BpMrIq5hplqMyG4eqI91PT76Xcl+a+WMTXDmu5H78ZNx
	UM+4Wt5pdKjZTdHh2N/lFL+fhBUK2j/bwgJZ+hKGO/fxXLGyAreAJxyW4FAnmeGRFLP7vflNsqH+7
	IerabSy5cJpCBkRxkDrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jih8v-0006v0-Kh; Tue, 09 Jun 2020 16:30:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jih8T-0004DI-CS
 for linux-nvme@lists.infradead.org; Tue, 09 Jun 2020 16:30:04 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 680F720734;
 Tue,  9 Jun 2020 16:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591720200;
 bh=odzrkutCnb/Mtz/1MI/RxwM8wGIVqiOoOyQ5ygEFFyg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=E6q0N9P+JqyLEZRQcTKOjN/zGmCt1TYjpoOSKJGJIKxHJy6Ld4sWgh9A6p87zc0Ez
 s13oz17xRPKdVI3Y4hpTHaDjUJc2uWO4+jHmgCf1gUHE5zz09Ps+vxmr3UqWJLU66A
 VOdKRTPsNgagP1aE2RQqVz/p0V3+6v5Flt3cFVgM=
Date: Wed, 10 Jun 2020 01:29:53 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme-pci: use simple suspend when a HMB is enabled
Message-ID: <20200609162953.GA2278@redsun51.ssa.fujisawa.hgst.com>
References: <20200609161053.46493-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200609161053.46493-1-hch@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200609_093001_595791_FC61F17B 
X-CRM114-Status: GOOD (  18.56  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 09, 2020 at 06:10:53PM +0200, Christoph Hellwig wrote:
> While the NVMe specification allows the device to access the host memory
> buffer in host DRAM from all power states, hosts will fail access to
> DRAM during S3 and similar power states.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Stable ought to pick this up too.

>  drivers/nvme/host/pci.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index d690d5593a8095..e2bacd369a88a0 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2950,9 +2950,15 @@ static int nvme_suspend(struct device *dev)
>  	 * the PCI bus layer to put it into D3 in order to take the PCIe link
>  	 * down, so as to allow the platform to achieve its minimum low-power
>  	 * state (which may not be possible if the link is up).
> +	 *
> +	 * If a host memory buffer is enabled, shut down the device as the NVMe
> +	 * specification allows the device to access the host memory buffer in
> +	 * host DRAM from all power states, but hosts will fail access to DRAM
> +	 * during S3.
>  	 */
>  	if (pm_suspend_via_firmware() || !ctrl->npss ||
>  	    !pcie_aspm_enabled(pdev) ||
> +	    ndev->nr_host_mem_descs ||
>  	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
>  		return nvme_disable_prepare_reset(ndev, true);
>  
> -- 

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
