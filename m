Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFACC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jun 2022 21:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xZo4XH1aAbMhBkpVxJ/NOrwVnd5ZKtgmtliBn1CtpLc=; b=Cg8CqD3Ovrhu8XyonaM1xn2NCZ
	TnJMgLK/4z1fuWaPCPWJXzEq6SecY8A5a5C2ptWPfym5zI2+j/BihJyNxB1rYdxyrzETkOXtqLRTb
	UjLnzxIo+oC9cs5iLv+GPrbBrLfIqr02iS57ormRvDNeF45gnqkyV6QjlQ9Yv+bNvS1Y4ktZnQUf/
	P2jI8usFtpLpy/TxoJPuvufikaj2r/ujtmD02RaJgr01JNs9hmpTdMSIT78sSsyTAr+avr3bC16IB
	v7CSB18ELVY58ya4nIPf439w9HG12okf0UR+wg5mailZxa8nhidOA/IUZuS6wPBeTxSdUwMT92mGg
	5vnFtPWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3PN8-002bNa-Pg; Mon, 20 Jun 2022 21:55:50 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3PN2-002bLQ-Bz
	for linux-nvme@lists.infradead.org; Mon, 20 Jun 2022 21:55:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 943DEB81213;
	Mon, 20 Jun 2022 21:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12598C3411B;
	Mon, 20 Jun 2022 21:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655762141;
	bh=ajGWL3lxFpSLL0zneyLb2e865mhvfIPsZmrYHYpRDEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SNuFc+Xb7v6R1rTOwCfxmiiiiwV/0WG2K4Do0Tw0pYCTuzmT4935A/NfXyhtJtq8h
	 KGukZMK9J3NBV3yYV+BXsV2QIKcYLDKe1eVvQIlpr7BZl64DFYFyXy+c34u/dcovh8
	 3AT4HKG3AmJhSAvR9OwlRNGxShTEQEhxxueLmp7f581Yy97oJInnwPjkr5ZwnYMDGf
	 MHNXKtewnYvPwN7rA5JBnVw7N7mK2v6uiB1dcwWLP7n4/e/izBjgHEH2qwtZlqo3MQ
	 BzFWS//lgPQ3COOycLt7G9P3YjWfHYpR8waeQRQQGv7i47Jm5wnfKIMFKPxu6xcmXL
	 SyyypaVNeWdqA==
Date: Mon, 20 Jun 2022 15:55:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leo Savernik <l.savernik@aon.at>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] NVMe quirk needed for multiple Micron MTFDKBA2T0TFH SSDs
Message-ID: <YrDs2sPzH4RPzhGI@kbusch-mbp.dhcp.thefacebook.com>
References: <af7628d5-2b91-4fea-a2bd-56825dbcb02f@aon.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af7628d5-2b91-4fea-a2bd-56825dbcb02f@aon.at>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220620_145544_597217_A6BB7FCF 
X-CRM114-Status: GOOD (  18.67  )
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

On Mon, Jun 20, 2022 at 09:29:38PM +0200, Leo Savernik wrote:
> Hello
> 
> As suggested by Keith Busch, I'm posting a patch to make multiple Micron
> MTFDKBA2T0TFH devices work to the mailing list for inclusion in the latest
> kernel versions.
> 
> This patch applies cleanly against 5.15.48 and 5.19-rc1
> 
> Please see bug 216147 [1] for details.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=216147
> 
> Leo

The diff looks fine, but we need a better commit message for the change log. :)

Specifically, sections "Describe your changes" and "Sign your work", described
here:

  https://www.kernel.org/doc/html/latest/process/submitting-patches.html
 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b925a5f4afc3..2e5c33f3b868 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3372,5 +3372,7 @@ static const struct pci_device_id nvme_id_table[] = {
> NVME_QUIRK_128_BYTES_SQES |
> 				NVME_QUIRK_NO_DEEPEST_PS |
> 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
> +	{ PCI_DEVICE(0x1344, 0x5407), /* Micron Technology Inc NVMe SSD */
> +		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN },
> 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
> 	{ 0, }
> };
> 
> 

