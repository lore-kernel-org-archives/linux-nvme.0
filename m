Return-Path: <SRS0=IcOG=JL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017A4C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 08:41:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7237C6113D
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 08:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7237C6113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oKZMVa3dcquERnQO98Ln87laLwfkGljzodxtxdka18g=; b=a1stk0fmVV5H9WpJ7mu4PAvBX
	qUTsaj5Du9F6HcNOxrZFzII/GFlRwkVNS21y6P3BLOxbA5eVQ++Ir3T8Dmf6shuhq84IuDQuVWql7
	EIvRNRlYvcfOelmwz8duH6hN6si+aJdpC7XrMoQx3DgHjh9zUOeO0HrdvqNBdkp1jIWY9Q5x0U1+g
	/fMFa1k6cDYbi6rqoZvj4XG1YBPyAgt7kUgEQAjy43Ged1QKj/G7ql35AJlXGK+kb6Rbw1bk7i7JK
	7+QDfEFMSyIrh9X1doHjQqvbdc3SUQkEZSze6a9Mbo/ULCp9e6orwLwWWdbsh3QwsvKk0JCdirEB3
	9cIW7gNFg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWb5d-00C1RG-Gy; Wed, 14 Apr 2021 08:41:37 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWb3u-00C0k3-Dr
 for linux-nvme@desiato.infradead.org; Wed, 14 Apr 2021 08:39:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=vXvXN/2oaHP0s0OCFWQYAIVyvgXHj+bsj/daRHCcRWc=; b=rJ/jtuINseZQXj1qtDPRz9wOzK
 szD+CWzFQv03Bv5rMOfajJzlS31BNE3Bu9mnkt0P/2zDNQ6hRs0/uZXrtca99sOhp0uhkmms+WBH2
 Pa04GfFW5Xqey0raVkTUREGlvlOBY0yY3EIj9K5ul0S5NX1EvZ1eklsLOUKMnksZIuPvFqLhcEA95
 JFtEihjdlyRtVS2eMykezNKpRVvFNduCS3Ki4ER9R8hbZD//frBgF7o8yh05MKBIWMLARk7chnZZC
 vyOhQUdFDtk1krNgtt/A3jCEC8fYSgP+VIpwLWUtlyyc7nav6a3d8YJ1l2Hx3NkizhcLbW5utHowt
 D+d4z0+Q==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWb3r-007cRX-RH
 for linux-nvme@lists.infradead.org; Wed, 14 Apr 2021 08:39:49 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1061C613CD;
 Wed, 14 Apr 2021 08:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1618389587;
 bh=2DHSVSV5XZPd7ez4fn13WfAhWgF0+pHVBEeJRWI0iuo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J6yBBk/yeSazHS6ErkbRhMMWqChBhZToZm+w57V4FSx66MLrm93tH1JK1GSFvSGNa
 zit54wVuWhJNXCT+n1cVYpDeQwm5dqHL9G1lO6j82m/hhaAvUpPPAhSV8u+WadN9DF
 s5URfBhzDnsaOE3aLpigwP5oZFjK/hrDHE/3lvTE=
Date: Wed, 14 Apr 2021 10:39:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Prike Liang <Prike.Liang@amd.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org,
 Chaitanya.Kulkarni@wdc.com, hch@infradead.org,
 stable@vger.kernel.org, Shyam-sundar.S-k@amd.com, Alexander.Deucher@amd.com
Subject: Re: [PATCH 2/2] nvme-pci: add AMD PCIe quirk for suspend/resume
Message-ID: <YHaqUQxc0SNIsBri@kroah.com>
References: <1618388281-15629-1-git-send-email-Prike.Liang@amd.com>
 <1618388281-15629-2-git-send-email-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1618388281-15629-2-git-send-email-Prike.Liang@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210414_013947_950747_A0EFA55D 
X-CRM114-Status: GOOD (  26.53  )
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

On Wed, Apr 14, 2021 at 04:18:01PM +0800, Prike Liang wrote:
> The NVME device pluged in some AMD PCIE root port will resume timeout
> from s2idle which caused by NVME power CFG lost in the SMU FW restore.
> This issue can be workaround by using PCIe power set with simple
> suspend/resume process path instead of APST. In the onwards ASIC will
> try do the NVME shutdown save and restore in the BIOS and still need
> PCIe power setting to resume from RTD3 for s2idle.
> 
> Update the nvme_acpi_storage_d3() _with previously added quirk.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> [ck: split patches for nvme and pcie]
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Cc: <stable@vger.kernel.org> # 5.11+
> ---
>  drivers/nvme/host/pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6bad4d4..ce9f42b 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2832,6 +2832,7 @@ static bool nvme_acpi_storage_d3(struct pci_dev *dev)
>  {
>  	struct acpi_device *adev;
>  	struct pci_dev *root;
> +	struct pci_dev *rdev;
>  	acpi_handle handle;
>  	acpi_status status;
>  	u8 val;
> @@ -2845,6 +2846,12 @@ static bool nvme_acpi_storage_d3(struct pci_dev *dev)
>  	if (!root)
>  		return false;
>  
> +	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
> +	if (rdev && (rdev->dev_flags & PCI_DEV_FLAGS_AMD_NVME_SIMPLE_SUSPEND)) {
> +		pci_dev_put(rdev);
> +		return true;
> +	}
> +
>  	adev = ACPI_COMPANION(&root->dev);
>  	if (!adev)
>  		return false;
> -- 
> 2.7.4
> 


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
