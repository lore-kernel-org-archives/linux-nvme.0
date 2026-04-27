Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6426DFF8860
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2026 05:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bRWCwHZrIuPrBpUAkRlJv3PyGCtUSdR/QxWZat0B26Y=; b=pf/qZW+99/vEqrrWyJ5t+lf9LZ
	TgmuxEVgbgzUT8C7dEcpy4hACxU/95jrV7cZI8kSEYBysGkrScenXjWflKiGzm/slG8ymWFoALsNR
	R8xUKYRPZcc98lmkwhPu9FU+iTYlqPtt3ASoRz0BOkFzBEMFCQShyNIYJNY6z/lR5juwA+qpCuTec
	g4aUVQLKmR3n0KHkW2xrxOAW6eW9dWeFk2QOmvftPkpI6hY6Bf2hhch7+k6qon5magdcRLgcPnJ96
	qwibLjx6PNo6KU/c88c2MUtSrJYR65kapY0FWhlj+VgOjlyLNEj4InD1Ym3Av5jgxefCTYTyS0Qgr
	T5xtg28w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHEYb-0000000GBWA-1mSY;
	Mon, 27 Apr 2026 05:30:57 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHEYV-0000000GBW3-4AnB
	for linux-nvme@lists.infradead.org;
	Mon, 27 Apr 2026 05:30:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 59B9C60138;
	Mon, 27 Apr 2026 05:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C1EC19425;
	Mon, 27 Apr 2026 05:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777267850;
	bh=zM0v6VqgoySR2CiA5H4Q5YFlHnUVTM7lRp0ZIity4dk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nlfMk/ydTPFXH4hipfvRCq07Sd/q/03iwqrmejTabIg6DGEe1Gbu+a+A7LWLkv4hr
	 3GlA6H4Fvn+jPNziqcI4GEUxQpLJq1GgPkr0/uTAWcBE9MnJc8lKfppm24bqrsMi+h
	 +nJsUevGln5dgNVX8JRwYwnMUC4bHsWWX46Sr4Bb0943HkWgNmJDOXlyV5FvZ9v5pN
	 vvmez8V7ihWv0vtewIBXUetSLOt+BhWjhnpZRVJ3UXrDbCxtIOTbS/SajgFypDRKCO
	 WjEvUNBZsDuycW303XIEajJnxyoeuu/OexNiIavN/W2sFv0yN0aPSSZwaoZu4U8pRl
	 uoJbBKGGN/AcA==
Message-ID: <f3005356-c9d8-4bc4-af72-ad02866bc8bc@kernel.org>
Date: Mon, 27 Apr 2026 14:30:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: pci-epf: fix heap overflow for invalid I/O
 SQES/CQES from the host
To: Junrui Luo <moonafterrain@outlook.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
References: <SYBPR01MB7881878B234CD11D13DCAFCCAF2B2@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <SYBPR01MB7881878B234CD11D13DCAFCCAF2B2@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 4/24/26 11:24 PM, Junrui Luo wrote:
> nvmet_pci_epf_enable_ctrl() computes ctrl->io_sqes and ctrl->io_cqes
> from the host-controlled CC.IOSQES/CC.IOCQES fields and only rejects
> values below sizeof(struct nvme_command) / sizeof(struct nvme_completion).
> The resulting sizes are used as DMA transfer lengths against the
> fixed-size iod->cmd (64B) and iod->cqe (16B) buffers.
> 
> An oversized IOSQES causes nvmet_pci_epf_transfer() to overflow
> iod->cmd with host-controlled data, and an oversized IOCQES causes
> memcpy_toio() to leak adjacent slab memory back to the host.
> 
> Change both checks from '<' to '!='.
> 
> Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

