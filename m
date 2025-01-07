Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E81E77198
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 17:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cvqRLuHBsga1aqimRGOF0V9OkCcRAupDB7uSQeD2pvw=; b=yO84EOgyusY7NRyfs1V6Q5ZKZX
	TQdCaFlVDe+By3fA8YV8gz+TtPJ/4m5XWSawIXA6m5GbcwuNBPMdZAV86ktOwcufSjrW3mkdjxt88
	RQXSZ88N8tbbxgvF6yzQFHQ08aHDtwYAhy1JSbBTiKFuzf/iA7YYd5vVDkJWktfmdg2preHd7VAIJ
	CY49r6b/OpLc0axsLh7E7l9DVaj3Oep3bloDLeoDbG6wpLbzNdwUGyh8bmBz81TLMk+i1gGq+BtnS
	fIfQjawdKxMzBs4hO/JFDcrW7AGWvn7Lnd7ahbO7KrgUwr0loklOVZpdys/9UlwxKLuygE8iv1NQx
	Fcyxu6Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVD95-00000005nZP-2CMh;
	Tue, 07 Jan 2025 17:13:35 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVCkM-00000005hc0-1WDF
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 16:48:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id BCEA7A419E9;
	Tue,  7 Jan 2025 16:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C84C4CEDD;
	Tue,  7 Jan 2025 16:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736268481;
	bh=cvqRLuHBsga1aqimRGOF0V9OkCcRAupDB7uSQeD2pvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OaWtVrsQB8LCx2DosiLvU4DBuTeP/tOlrvAvgEVwJL/nO+oymLnJ5pngdKLul0rW+
	 pJF+gG5/gwF9tVm0kDK9iqO4BcA5YoYVpjaUNRnFeQx2JGZPeyfzQF8l8JGNKsSCX7
	 PIBjexpjCSUeVPVWVmrTY1YjAfb5UQShp/lxj6LYXUl/CBs87V0nL8zg0p6JnUD9hh
	 DiUnw6pSRHwPIbxHmRCsVB4HgNgDBZVaexNBAvjPAhrtf1RKzvB9YndFdzsw7eCbNG
	 yg65edkwDKWBI9F+rlCoyIkSlQpGL/JP+fu5dCiJiS97ISkvCj7Fd/xtbkL/MbnaD2
	 VizKoV/EAcZVg==
Date: Tue, 7 Jan 2025 09:47:58 -0700
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v9 00/18] NVMe PCI endpoint target driver
Message-ID: <Z31avimMhZ0Bo4r0@kbusch-mbp>
References: <20250104045951.157830-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104045951.157830-1-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_084802_469075_309BF919 
X-CRM114-Status: UNSURE (   7.37  )
X-CRM114-Notice: Please train this message.
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

On Sat, Jan 04, 2025 at 01:59:33PM +0900, Damien Le Moal wrote:
> This patch series implements an NVMe target driver for the PCI transport
> using the PCI endpoint framework.

Thanks, applied to nvme-6.14.

