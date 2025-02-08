Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AF6C0219D
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Feb 2025 18:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=aF5Am46qIdCMSrkuGPtueiy5bHjwt2/lEOXAWFcGPl4=; b=3wsbtm6XXCORz+
	TaA+cU27lYeY4Sl61vm/zE5qJ28QzI27eoRXD2wqO7EgJ3TWNh4mWvZsl0wDSaozJUSfNrcpnuHDW
	TMJ1tGAMXRFw9EoLO9htOa4/fiwSTWMM2sHTjZsNyLmItpLNVXq5pf8dUjNeZFqVkGGL2avmM3ItH
	ZFcFEqt0upWCVA/OW7rbvpOn0Vsl/nuvU778b1T5SOSMj+mjLT9AgPAcAghSKg0SCVOSRhYgIXYlb
	uQr4jKiQxKpM3VyT9qhgH8Yk1R70sde0NCSHd6866CFKkYG5e4Pmtr9npuJ9jm378KZCFi3qCK4IL
	N7wpvIoXjoSZVw6/OXtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgpvT-0000000DOMd-0uwd;
	Sat, 08 Feb 2025 18:51:35 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgpvM-0000000DOMG-1sd9
	for linux-nvme@lists.infradead.org;
	Sat, 08 Feb 2025 18:51:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 05CE35C545C;
	Sat,  8 Feb 2025 18:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D750C4CED6;
	Sat,  8 Feb 2025 18:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739040686;
	bh=ocQtBMyOozySwQUoJT5XoGfejv3UAKO+w7LOrRwBmi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cSLxDSiNI9z7JD5E3qbP2Q9bNIajFXQ8nkWOG0DQD+LvxmAybYhZY/We1rTFe5WN8
	 H/4gqZ2VlwqkDBFVwDD3gA5gAMnNLiLWx4EAULgyUmNoDIK6Ge9ISJxTFfS5ZhCwq9
	 aQnCXZxmxhxi0gL37uUSrJvwnqNAg62ZSNW2zIOesqeCSgH9mQSTiRqD/JzWTv9zvv
	 m89R7lubffnQ5AgmW8dKkBUfl39ayKvX+wUlpNzRXw75uGBjwhPMci+6nDTgDShB/H
	 C7OHSJCoix8XmXrpktZ9PU0yR9LuqbX6szaUwsLTaWYw+e8cjLbHDFxl83ys3IPY5v
	 pn6U8As/qI7VQ==
Date: Sat, 8 Feb 2025 12:51:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org, rafael@kernel.org,
	ulf.hansson@linaro.org
Subject: Re: [PATCH] nvme-pci: Use NVME_QUIRK_SIMPLE_SUSPEND for Qualcomm
 Snapdragon 8cx Gen 3 platforms
Message-ID: <20250208185124.GA1120888@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250126050309.7243-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250208_105128_532957_FA9CDBD1 
X-CRM114-Status: GOOD (  12.96  )
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

On Sun, Jan 26, 2025 at 10:33:09AM +0530, Manivannan Sadhasivam wrote:
> On these platforms, power to the PCIe bus is not retained if the SoC enters
> its own deep low power state called, CX power collapse state during system
> suspend. Once the SoC resumes after going through CX power collapse, all
> the PCIe bus state will be lost. So the NVMe devices on these platforms
> won't resume properly, rendering the machines useless until forcefully
> restarted by the users.

I guess "forcefully restarted" means a power cycle?

> +++ b/drivers/nvme/host/pci.c
> @@ -3162,6 +3162,16 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
>  	if (dmi_match(DMI_BOARD_NAME, "LXKT-ZXEG-N6"))
>  		return NVME_QUIRK_NO_APST;
>  
> +	/*
> +	 * Qualcomm Snapdragon 8cx Gen 3 (SC8280XP) platforms doesn't retain
> +	 * power to the PCIe bus after entering low power CX power collapse
> +	 * state during system suspend. So shutdown the NVMe devices to have a
> +	 * working system suspend on these platforms.
> +	 */
> +	if (dmi_match(DMI_PRODUCT_FAMILY, "SCP_MAKENA") ||
> +	    dmi_match(DMI_PRODUCT_FAMILY, "ThinkPad X13s Gen 1"))
> +		return NVME_QUIRK_SIMPLE_SUSPEND;

I certainly acknowledge that this is a big problem for users.  At the
same time, this seems like a maintenance nightmare of
platform-specific hacks scattered through endpoint drivers.

