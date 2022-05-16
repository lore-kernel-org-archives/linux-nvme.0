Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E26C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 16 May 2022 20:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=Pm6g082srAjUjvEdhGp2+mp3shYJzBW7AJTkkSKN3WI=; b=4XbKeKldMQxZn1
	uz9SKnSERwl41sKshIX697SvIit5l8hAvJHK2ratXFOChhIdI9ZR+mNdlNB4zCzeKWPINzsLGmgmq
	IZHr22xfiLvlTY2iznI0elihZvclIr+Boaob4l7n921oM8UuA3nbeaSX3ryqy/zJGbEV3dkf5Wvc+
	/qttZ6gFLcHjypCQt/6TZ5fXp+8ASUIampHHomlfCDlH+LUbJfxdw3jcR7E2Yb+kbKs3+RZWvEoA+
	WK7aU6f0peQiHFSVJ70cZLQh9DXnv61kzRQus16nHrgMp+3G92SNgZF/eAdLcBuiGhVpq9b6FrCEf
	+ujvrKSAi6xX0k48SlOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqhAb-00A1Uh-Na; Mon, 16 May 2022 20:18:21 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqhAZ-00A1Tf-Rs
 for linux-nvme@lists.infradead.org; Mon, 16 May 2022 20:18:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2EA4A6121A;
 Mon, 16 May 2022 20:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9343CC34115;
 Mon, 16 May 2022 20:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652732299;
 bh=+6uDV10Sc3DTLJDwxFmU67G8zR9GmxWTjZaSRJ32XLg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=e4kdVQ/Dpfon3rGXiGajSkfjR9K2FBo1wKLw+wBBNeMi+8vyzfTWecKzDAW3TzJ7z
 hxID2Br1Mj8PN/ghRReXgpxOIUhovVXSC7q6OCnTP0fBTK+2B045Dd01UGJQ+/SBmD
 0YmUSh87/GSaM70G2VJ7hhy2LGITABy1w11uDcGncZMALgUpekTZHVRDOwD7Z8oqBq
 pw3kHdktEP7gZuRSm0gpVZGAMiF996gaYID9Axl6FPHNQ7xMB93+ks+STQmDifhLkq
 ulNVvCjlwUGzbchx+0ihF8VPGYcos2W0d5K1dYo2vpVvIgdbOGqEw4LN0ye0tNN+mg
 cn2fff1GBOWxg==
Date: Mon, 16 May 2022 15:18:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
 hch@lst.de, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, svarbanov@mm-sol.com,
 bjorn.andersson@linaro.org, axboe@fb.com, quic_vbadigan@quicinc.com,
 quic_krichai@quicinc.com, quic_nitirawa@quicinc.com,
 vidyas@nvidia.com, sagi@grimberg.me
Subject: Re: [PATCH 1/3] PCI: Add a flag to notify PCI drivers about
 powerdown during suspend
Message-ID: <20220516201817.GA1047280@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513110027.31015-2-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220516_131819_975802_28F9ECF6 
X-CRM114-Status: GOOD (  20.96  )
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

On Fri, May 13, 2022 at 04:30:25PM +0530, Manivannan Sadhasivam wrote:
> On some systems like Chromebooks based on Qcom chipsets, the OS may
> powerdown all PCIe devices during system suspend for aggressive
> powersaving. In that case, the PCI host controller drivers need to notify
> the PCI device drivers that the power will be taken off during system
> suspend so that the drivers can prepare the devices accordingly.

"The OS may powerdown all PCIe devices ..." makes it sound like this
is an OS policy decision.  Where exactly (what function) is that?

Or if it's not an OS policy decision, but rather some property of the
hardware, say that specifically.

> One prime example is the PCI NVMe driver. This flag can be used by the
> driver to shutdown the NVMe device during suspend and recover it during
> resume.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  include/linux/pci.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 60adf42460ab..069caf1fe88d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -578,6 +578,7 @@ struct pci_host_bridge {
>  	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
>  	unsigned int	size_windows:1;		/* Enable root bus sizing */
>  	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
> +	unsigned int	suspend_poweroff:1;	/* OS may poweroff devices during system suspend */
>  
>  	/* Resource alignment requirements */
>  	resource_size_t (*align_resource)(struct pci_dev *dev,
> -- 
> 2.25.1
> 

