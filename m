Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CD0C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 15:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zD/3iZu7QTBepjDAFJsl0viHHBJPbs2QwsTkApDUaII=; b=cvochpN+vJ6A8Pl8r4McePRAMx
	LpbAEhb7zOz/RCj8IMAkx71lh5hdWKPcen+rC3akaOmPZK8EwEdjUvipLOrmpxX6xgS7b1NBHGhIC
	J4ZMKQqh/ugIN2edfH5DUwS8onloa3QFhWKGe5GKKfgJVLapwXx5bcY659eJG0XHSnKmHUCdMvNzg
	kgkearETGETuGKspRlohrsP6cSS6wdetCu6yXcEOTaeisjvhz+OJZs2z2R3JglUhYnvapxMc0c/tK
	R5KgyXKbZViRH28etNaCjpSdPrhk6CyGpbj3LrAvuubyPt2yfpmDoPFimUszty7NgJ1hYZrPJZWiX
	GKuhHvng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIAwj-0049ZV-Gm; Thu, 10 Feb 2022 15:01:21 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIAwg-0049ZA-Ms
 for linux-nvme@lists.infradead.org; Thu, 10 Feb 2022 15:01:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D146961AB0;
 Thu, 10 Feb 2022 15:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C03C004E1;
 Thu, 10 Feb 2022 15:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644505277;
 bh=Hi2Mca6jqEt1GgA8oCBVMaSPWVu89ItIPId18WE1+wo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jyWCLFa1Mw22hr0+sxUUJEtJ98QtJ4JJPXo70nMNuzLgcM7f1avHCogMbutMJA2JW
 cWG1WXhix/0Ra+ALhv74XBk85rxAjUV0XN3f67EOqvzjAarXw516zah75060+9/SL3
 DwFv2jtxPqLw77w8PAksghjaxmBYedc3GTxH2jJgSxtALSFf1ISuY+DON88OffKy55
 jEjSugCGbpNc4R4kTrjH1CKwFrtw3KO23kNoDEVlS2Uppfy56vbuEH7VzmdeXRWLVJ
 9+SKJuEgLWbKyqdnNtS4Vf8yo5Un0yKMBPVjp/rmM8LmvwmKD6rY3nE0p7xZFKYpL9
 dt4rQCfvOh1pw==
Date: Thu, 10 Feb 2022 07:01:14 -0800
From: Keith Busch <kbusch@kernel.org>
To: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: Re: [PATCH v1] nvme/pci: Add quick suspend quirk for Toshiba drive.
Message-ID: <20220210150114.GB1617879@dhcp-10-100-145-180.wdc.com>
References: <1644495676-8124-1-git-send-email-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644495676-8124-1-git-send-email-quic_nitirawa@quicinc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220210_070118_807893_5DDEC44D 
X-CRM114-Status: GOOD (  19.31  )
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

On Thu, Feb 10, 2022 at 05:51:16PM +0530, Nitin Rawat wrote:
> The Toshiba KBG40ZPZ256G SSD is having resume issues on SC7280 platform.
> Hence enabling quick suspend quirks for Toshiba KBG40ZPZ256G on sc7280
> platform so that nvme device is taken through shutdown path
> during resume.
> 
> No issue is seen after enabling this quirks.
> 
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> ---
>  drivers/nvme/host/pci.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6a99ed6..04c5954 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3032,6 +3032,15 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
>  		if ((dmi_match(DMI_BOARD_VENDOR, "LENOVO")) &&
>  		     dmi_match(DMI_BOARD_NAME, "LNVNB161216"))
>  			return NVME_QUIRK_SIMPLE_SUSPEND;
> +
> +		/*
> +		 * Toshiba KBG40ZPZ256G on Sc7280 platform is having NVMe
> +		 * Resume issue. Appending quick suspend quirks for sc7280
> +		 * platforms so that full NVMe device shutdown path is
> +		 * executed during resume.
> +		 */
> +		if (of_machine_is_compatible("qcom,sc7280"))
> +			return NVME_QUIRK_SIMPLE_SUSPEND;

Shouldn't this check be moved outside the vendor/device check? It
doesn't seem like this behavior for this platform is specific to any
particular controller, right?

Otherwise, looks fine.

