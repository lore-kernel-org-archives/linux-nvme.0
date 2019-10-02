Return-Path: <SRS0=mn4A=X3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B576FC10F14
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2019 22:05:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ADF420659
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2019 22:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hjJq0HpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ADF420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gju1oPVMD+J+sVfvvqAWIlLHj6yC3B9unpEPYBuwB5o=; b=hjJq0HpYcwp0OKYHzgg3CoKtr
	M5BYJsvgfmrJEBm88BASdn7mVpPl5hkTlbRB8DxiiCUoVNXN3pvt010x057lPrrZci6Mm5rGC/oM8
	zdDmg0+vlllrwl57k8qoU739IVqbf82loCZyiYAjDa8LUII/JzuYiF79l2QP9Y2YaoAYf3dTP1A01
	MNy8Y63R/oybBO5HqtYFqtIgnbFW76dmJi/Q6Gsm0adhey9KhuFjt5Fck+NtTX+f1bsaSIEJXAENk
	IeJOp6YmAXL+aZxCpNkymwscGJo8ogu12lr+gNOorbPIpMLxtt2N+gTmCCca3XKnY+3+PC2U3iwuS
	hR5e7vpfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iFmkB-00089r-9n; Wed, 02 Oct 2019 22:05:11 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iFmk8-0007gu-Uk
 for linux-nvme@lists.infradead.org; Wed, 02 Oct 2019 22:05:10 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Oct 2019 15:05:06 -0700
X-IronPort-AV: E=Sophos;i="5.67,249,1566889200"; d="scan'208";a="196142452"
Received: from unknown (HELO [10.232.112.84]) ([10.232.112.84])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 02 Oct 2019 15:05:05 -0700
Subject: Re: [RFC PATCH] nvme: retain split access workaround for capability
 reads
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-nvme@lists.infradead.org
References: <20191002073643.5339-1-ard.biesheuvel@linaro.org>
From: "Nadolski, Edmund" <edmund.nadolski@intel.com>
Message-ID: <806b32f6-221a-daa5-1942-f4f6cf47d2bd@intel.com>
Date: Wed, 2 Oct 2019 16:05:04 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191002073643.5339-1-ard.biesheuvel@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191002_150509_009632_A47D58FC 
X-CRM114-Status: GOOD (  25.92  )
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
Cc: axboe@fb.com, kbusch@kernel.org, ilias.apalodimas@linaro.org,
 sagi@grimberg.me, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/2/2019 1:36 AM, Ard Biesheuvel wrote:
> Recent changes to the NVMe core have re-introduced an issue that we
> have attempted to work around in the past, in commit a310acd7a7ea
> ("NVMe: use split lo_hi_{read,write}q").
> 
> The problem is that some PCIe NVMe controllers do not implement 64-bit
> outbound accesses correctly, which is why the commit above switched
> to using lo_hi_[read|write]q for all 64-bit BAR accesses.
> 
> In the mean time, the NVMe subsystem has been refactored, and now calls
> into the PCIe support layer for NVMe via a .reg_read64() method, which
> fails to use lo_hi_readq(), and thus reintroduces the problem that the
> commit above aimed to address.
> 
> Given that, at the moment, .reg_read64() is only used to read the
> capability register [which is known to tolerate split reads, which is
> not guaranteed in the general case, given that the NVMe BAR may be
> non-prefetchable], let's switch .reg_read64() to lo_hi_readq() as
> well.

Might be good to include this as a comment, for clarity and so it won't
get refactored out again.

> To ensure that we will spot any changes that will start using the
> .reg_read64() method for other purposes, WARN() if the requested
> offset != NVME_REG_CAP.

Would WARN_ONCE() suffice?

Ed

> This fixes a boot issue on some ARM boxes with NVMe behind a
> Synopsys DesignWare PCIe host controller.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> Broken since v5.3, so if this gets fixed one way or the other, please
> add cc: stable.
> 
> Given that reg_read64() is only used in a single place to read the
> capability register, it would be cleaner to just drop it and add a
> .reg_readcap() method instead, but this is a more invasive change.
> 
>   drivers/nvme/host/pci.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c0808f9eb8ab..bb012075fbb2 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2672,7 +2672,8 @@ static int nvme_pci_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
>   
>   static int nvme_pci_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
>   {
> -	*val = readq(to_nvme_dev(ctrl)->bar + off);
> +	WARN_ON(off != NVME_REG_CAP);
> +	*val = lo_hi_readq(to_nvme_dev(ctrl)->bar + off);
>   	return 0;
>   }
>   
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
