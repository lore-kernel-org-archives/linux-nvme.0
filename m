Return-Path: <SRS0=tL+/=A3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2EEC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2020 16:14:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB912071B
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2020 16:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q/aMQyA0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0zAVnDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB912071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zWVmEuN5p7KqohF2xyu9DTRZEpEhHjj0c72XCSwxfnQ=; b=q/aMQyA0D6zRVrvIZYMzU3xJ3
	BLJnfiBBAI32x5y4pG5xN3i94KZKNY7oBuawEauJMAUq/B6H2XLIJpUXX/5kHBfco/pkg42WCN0Gd
	7NngJl+P99Pc3R6GExTVvBJq8Yde+0qPeSmYennz+Wi4vyEhNni7hk1+VfG52ePCVgTYYHm8VjnHj
	4x8OJ85e5Wqt7iMHnHwZ/8Hpgn/gwatYWtuuZgZkD8t/6NHA8iD2XAcuT6HWVDH0i0GdZT2uPcPf7
	rCjjPQa4Hs7C0YrZZ1xS/EvOxxDhywrCE9+oEvpAgWI27R71tj9HVFStGMjsfhXbT+W207EN9KzdT
	d9BbzOQ8Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jw6WO-0007Jc-Sz; Thu, 16 Jul 2020 16:14:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jw6WM-0007IH-Cy
 for linux-nvme@lists.infradead.org; Thu, 16 Jul 2020 16:14:07 +0000
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E15FE2071B;
 Thu, 16 Jul 2020 16:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594916045;
 bh=IsQlmNduJzeA8K1Kqpn59fkMWUZGOxWfixc27MP6dzU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G0zAVnDO8NWsmmiYN+rhUPAyB7KFY+LQOLyh4YClWHQRWefZ2Jm+ImloAVXS1u+ZS
 oVUsuBejKjoYoC5ek3a/739RY8E1veaC7aNYMTLK6cTSVEMw+H92Eb3Yac21VwNmOH
 5lNBq3cdm/e7bNYYAdDMmK/d7ott/hZBQf4w+7Jw=
Date: Thu, 16 Jul 2020 18:13:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Initial support for SD express card/host
Message-ID: <20200716161358.GA3135454@kroah.com>
References: <20200716141534.30241-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200716141534.30241-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200716_121406_546539_92425896 
X-CRM114-Status: GOOD (  15.89  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Rui Feng <rui_feng@realsil.com.cn>,
 linux-pci@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Adrian Hunter <adrian.hunter@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 16, 2020 at 04:15:34PM +0200, Ulf Hansson wrote:
> +int mmc_send_if_cond_pcie(struct mmc_host *host, u32 ocr)
> +{
> +	u32 resp = 0;
> +	u8 pcie_bits = 0;
> +	int ret;
> +
> +	if (host->caps2 & MMC_CAP2_SD_EXP) {
> +		/* Probe card for SD express support via PCIe. */
> +		pcie_bits = 0x10;
> +		if (host->caps2 & MMC_CAP2_SD_EXP_1_2V)
> +			/* Probe also for 1.2V support. */
> +			pcie_bits = 0x30;
> +	}
> +
> +	ret = __mmc_send_if_cond(host, ocr, pcie_bits, &resp);
> +	if (ret)
> +		return 0;
> +
> +	/* Continue with the SD express init, if the card supports it. */
> +	resp &= 0x3000;
> +	if (pcie_bits && resp) {
> +		if (resp == 0x3000)

0x3000 should be some defined value, right?  Otherwise it just looks
like magic bits :)

> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -60,6 +60,8 @@ struct mmc_ios {
>  #define MMC_TIMING_MMC_DDR52	8
>  #define MMC_TIMING_MMC_HS200	9
>  #define MMC_TIMING_MMC_HS400	10
> +#define MMC_TIMING_SD_EXP	11
> +#define MMC_TIMING_SD_EXP_1_2V	12
>  
>  	unsigned char	signal_voltage;		/* signalling voltage (1.8V or 3.3V) */
>  
> @@ -172,6 +174,9 @@ struct mmc_host_ops {
>  	 */
>  	int	(*multi_io_quirk)(struct mmc_card *card,
>  				  unsigned int direction, int blk_size);
> +
> +	/* Initialize an SD express card, mandatory for MMC_CAP2_SD_EXP. */
> +	int	(*init_sd_express)(struct mmc_host *host, struct mmc_ios *ios);
>  };
>  
>  struct mmc_cqe_ops {
> @@ -357,6 +362,8 @@ struct mmc_host {
>  #define MMC_CAP2_HS200_1_2V_SDR	(1 << 6)        /* can support */
>  #define MMC_CAP2_HS200		(MMC_CAP2_HS200_1_8V_SDR | \
>  				 MMC_CAP2_HS200_1_2V_SDR)
> +#define MMC_CAP2_SD_EXP		(1 << 7)	/* SD express via PCIe */

BIT(7)?

> +#define MMC_CAP2_SD_EXP_1_2V	(1 << 8)	/* SD express 1.2V */

BIT(8)?

thanks,

greg k-h

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
