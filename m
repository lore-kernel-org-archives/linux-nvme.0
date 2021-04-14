Return-Path: <SRS0=IcOG=JL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF05C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 16:24:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 214AE61158
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 16:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214AE61158
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mqqYxyeC6u46SDLNuPPmeC47puuljuJdRRFMCrC624o=; b=RFbZQFKbFhF5R5v+Rg1QCyNR+
	7lOUgpmqvRVG4qMiQWgLSARvI6RaLK17L3Y3Gueb8OYltCMHKwQ7kJhhyXz+E8Tyay+sug6nSdf07
	G2zsUdF0F+XwXgG0umoHREJ4Up7J7F28Eis8icghtOx4qNcJA2v5W0EiFPQByruMtHhUwe3tHOjng
	dhF8D0P0Yf07yMMaTCYDMkzfhXZ2w6fWHPr8xH/GyFVq+cTQoqqRt6Ll3PIuqClUDTHdlogUPRKxQ
	Lfub3TIEZohkIPGUjx2XqhjAzxbnmTv97WRopdluQqAlgbEYROUi/uPR8bO6D/rPamlSoYe0Gmhkr
	T6jZIF2yw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWiJP-00D85t-Jr; Wed, 14 Apr 2021 16:24:19 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWiJK-00D85P-Cp
 for linux-nvme@desiato.infradead.org; Wed, 14 Apr 2021 16:24:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Uxt1OBPPT7A1iRjcDBWEQbOl7spHe7qPHwc/JVpvjB8=; b=5Eu5qgmM5u/O6XNb/fnW2hTD/8
 BU2yRW0DJ5KaH/ohmqssooeKrM23QjzevxuIH86mZdYSDJrXTRk+DxSWDnBeWEvNLvEQtMQ+a4nEi
 o4Z2Gm+aWBDXFMPtTHQE80O2S92K8Hfa6bgvhOgib668Fj4CFrK49syxBzxqO9nKn5n7vhhSvhLr2
 6ebzGviCOffNuECMKsZtnyWnYgJDxpmRSDYzZxpYCVrXTTI8zIcEZKu6L3OjtVCUfssGkAUl+ZY6L
 HeKSXQmNOl+6cPxE5Vqg5PD06+r3TZjBjqxA4ptYak0xFAr8Di47bgZol/fvpSHLwmk/gmt1sgo4F
 WusOzWaw==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWiJH-007wX9-Ng
 for linux-nvme@lists.infradead.org; Wed, 14 Apr 2021 16:24:13 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7369B610E6;
 Wed, 14 Apr 2021 16:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618417451;
 bh=Q/fhaOsYAxGrm1f3bVFX328dWe5mUr0miHfundS2aQA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g1yhmRsN+/jmpmyEr5e1YRkKuKuTCnj7umQUtufzonQB8VfPQ0rMymeufvxXLlopY
 qpuU6oEyKVxJ3DQdTxOeXHI7QicjVR1LkDqASGuUPJP75EZtEJGxCWcqyFMwdVQr4i
 PC1eczEW7p4nKY13UKuir9QRfhxpvOd0B8mMwmWvVjwnGBsaX0s0/36E4aKyhs9QrH
 EUvrJUHiOYSyqciwhE3HtVm2q8Sc7yzZp+gBXM8wTMz6nNtYo6uUfV0BufIFADjjXx
 K7gtZIuKPYDPAFFYOAsfwSGDINlJEyIyAdm7WesVQXiE8VPphcVZpNVEoL+FGy/7Sf
 0BLf3IRJ854HA==
Date: Wed, 14 Apr 2021 09:24:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: Prike Liang <Prike.Liang@amd.com>
Cc: linux-nvme@lists.infradead.org, Chaitanya.Kulkarni@wdc.com,
 gregkh@linuxfoundation.org, hch@infradead.org,
 stable@vger.kernel.org, Shyam-sundar.S-k@amd.com, Alexander.Deucher@amd.com
Subject: Re: [PATCH 2/2] nvme-pci: add AMD PCIe quirk for suspend/resume
Message-ID: <20210414162408.GC2448507@dhcp-10-100-145-180.wdc.com>
References: <1618388281-15629-1-git-send-email-Prike.Liang@amd.com>
 <1618388281-15629-2-git-send-email-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1618388281-15629-2-git-send-email-Prike.Liang@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210414_092411_830021_B5DB88E5 
X-CRM114-Status: GOOD (  17.98  )
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

Chaitanya's Sign-off should be under the annotation explaining what he
changed, and placed below the original author's sign-off.

> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Cc: <stable@vger.kernel.org> # 5.11+
> ---

It doesn't appear that you're reading Greg's autobot reply. This spot
right here is where you should describe what is different about this
patch compared to your previous versions.

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

Instead of assuming '0', shouldn't you use the domain of the NVMe PCI
device?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
