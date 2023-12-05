Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D931C4167B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Dec 2023 17:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=waunzxouAu+EhVCebQmRlGhPFC3Fc2GsLS9nml3O+7Q=; b=CDItzXFAceQcNvGc3lI3X89n2J
	PFDurnnWK1oV+LQZ2UAcdE51E5vwJwWtRQ8la9N5ovU/cn3lNAJda4QCVIfALHIT3VWuly7gxayMc
	wANJVhqyt/1LuBZYHmE8yseD+u48qUoNBLBZC0HnJlCOb40fhXzwZLAEBpbhEczZ5CQeifjnWMtlk
	EHIiSsmHZnOu/Kxuc3ikvmd5+NIlM41SS1TJhh+IlrfEq3pel5h6zimcHzkKu+nHBbvtnjlgNIXXG
	pwcUUIgGvw5rKXpzK0ONnDBOJPplJ6tNpePFD6/OIRg80j9NM8u5uROjGw6rojdx3tvTgtdS4+ZEP
	uV0ehbXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAZ3D-00814k-02;
	Tue, 05 Dec 2023 17:17:39 +0000
Received: from mail.tuxedocomputers.com ([157.90.84.7])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAZ3A-008141-0I
	for linux-nvme@lists.infradead.org;
	Tue, 05 Dec 2023 17:17:37 +0000
Received: from [192.168.42.20] (p5de457e6.dip0.t-ipconnect.de [93.228.87.230])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 01B7C2FC01FB;
	Tue,  5 Dec 2023 18:17:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1701796648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=waunzxouAu+EhVCebQmRlGhPFC3Fc2GsLS9nml3O+7Q=;
	b=BDy8Ub4llOR5f3HkIivg25SIFVoVgVyNtDJQs4Zk2UpJnMmgz8oRbfTvpIObN8NfcR9ZL6
	RmLKAC/D7/Va+XxBt2meQFz8oVupjFgnMjC9+AvwVNDubJHdURZjm4TFpHQcR7+JD3t6sb
	utDdS8KhuUB4OPVHyi+6y2TPeowmOOY=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <12d32e8e-e20b-4023-8299-39d2a69c0cd9@tuxedocomputers.com>
Date: Tue, 5 Dec 2023 18:17:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Add sleep quirk for Kingston drives
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Georg Gottleuber <ggo@tuxedocomputers.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230920085210.22573-1-wse@tuxedocomputers.com>
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20230920085210.22573-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231205_091736_307139_3362198D 
X-CRM114-Status: GOOD (  23.76  )
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

Hi,

Am 20.09.23 um 10:52 schrieb Werner Sembach:
> From: Georg Gottleuber <ggo@tuxedocomputers.com>
>
> Some Kingston NV1 and A2000 are wasting a lot of power on specific TUXEDO
> platforms in s2idle sleep if 'Simple Suspend' is used.
>
> This patch applies a new quirk 'Force No Simple Suspend' to achieve a
> low power sleep without 'Simple Suspend'.
>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
> Cc: <stable@vger.kernel.org>

Want to leave a gentle bump here. Any issues with this patch?

Kind regards,

Werner Sembach

> ---
>   drivers/nvme/host/nvme.h |  5 +++++
>   drivers/nvme/host/pci.c  | 16 +++++++++++++++-
>   2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index f35647c470afa..74f74b459f5fa 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -156,6 +156,11 @@ enum nvme_quirks {
>   	 * No temperature thresholds for channels other than 0 (Composite).
>   	 */
>   	NVME_QUIRK_NO_SECONDARY_TEMP_THRESH	= (1 << 19),
> +
> +	/*
> +	 * Disables simple suspend/resume path.
> +	 */
> +	NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND	= (1 << 20),
>   };
>   
>   /*
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 347cb5daebc3c..b4e6f0d21a44c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2903,6 +2903,18 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
>   		if ((dmi_match(DMI_BOARD_VENDOR, "LENOVO")) &&
>   		     dmi_match(DMI_BOARD_NAME, "LNVNB161216"))
>   			return NVME_QUIRK_SIMPLE_SUSPEND;
> +	} else if (pdev->vendor == 0x2646 && (pdev->device == 0x2263 ||
> +		   pdev->device == 0x500f)) {
> +		/*
> +		 * Exclude some Kingston NV1 and A2000 devices from
> +		 * NVME_QUIRK_SIMPLE_SUSPEND. Do a full suspend to save a
> +		 * lot fo energy with s2idle sleep on some TUXEDO platforms.
> +		 */
> +		if (dmi_match(DMI_BOARD_NAME, "NS5X_NS7XAU") ||
> +		    dmi_match(DMI_BOARD_NAME, "NS5x_7xAU") ||
> +		    dmi_match(DMI_BOARD_NAME, "NS5x_7xPU") ||
> +		    dmi_match(DMI_BOARD_NAME, "PH4PRX1_PH6PRX1"))
> +			return NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND;
>   	}
>   
>   	return 0;
> @@ -2933,7 +2945,9 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
>   	dev->dev = get_device(&pdev->dev);
>   
>   	quirks |= check_vendor_combination_bug(pdev);
> -	if (!noacpi && acpi_storage_d3(&pdev->dev)) {
> +	if (!noacpi &&
> +	    !(quirks & NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND) &&
> +	    acpi_storage_d3(&pdev->dev)) {
>   		/*
>   		 * Some systems use a bios work around to ask for D3 on
>   		 * platforms that support kernel managed suspend.

