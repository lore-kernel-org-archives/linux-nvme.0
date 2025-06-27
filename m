Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59863C77B7F
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Jun 2025 07:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zy1iXMmSwr2i+dJPh7YXLDl6/tadMCK4OkYezTtllbg=; b=dSMdscZAjffheN
	84gDw+SG6Mb1YMNR+WcE1YLYMBuBzZRiI2cqdgwVzkosEdQAmXvMtIZ2dbhWQHEs1UElAAXBt9UQs
	N/e6lxy2jDP4UWAo5dCt4C5FL6mVuq36DMwh+LDIpcmotloWZGeflMAAVq8WXTTjJXY6Dt4Fcz/Yj
	UzNYtFnnEounJkFtiBouMAV3hpF7cxFD0CcSjcxDs8FbWQSsH6w6G+aPm3Gn2Ca3t8US9tuiWdh2l
	T1d4wNFbojIBawsAfacZiPCuDEwK4jA7d5GWav28DVSYgcbUFRwvcWA6m0u1pm1tKWRPUi4yweOMN
	iogHdnJReVNbezxoz5RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV3hS-0000000DqzD-2zXy;
	Fri, 27 Jun 2025 07:40:42 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV3dw-0000000DqFB-2gJ6
	for linux-nvme@lists.infradead.org;
	Fri, 27 Jun 2025 07:37:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5963644536;
	Fri, 27 Jun 2025 07:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF33C4CEE3;
	Fri, 27 Jun 2025 07:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751009824;
	bh=8tWM2V7SABVM4Zm2xnFjW1gr4tL1mw3yIKCaSFAN2h8=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LpGiayUOr3w+byudp9Vy4RuM08kkOqWo1NVWnzU63SVuFqAw8aVhqWLSOYwBZHe56
	 A6J+gBthtqorzmOjenBlFBpuEEQTl3wahl6LNGyu2axbGhty/bB68ds5uqsm0boexB
	 IncpGDv3fOODElQ4Vr66d08lYKbLtsdIGITT+5G5WBA1pnNTRWrcugTY2evyH2sp/K
	 E4KSd4wbMzsmnkiz39sR+2g7vu6IsjrgqFfFAAdX/eAhemWpzKufXbCsZubsxzBLbQ
	 V/swmaccvueJ+yG2Xmwwh57SAE5iWLB9rDcP9cycDaG5KmSbWpXlFE6ab5hlDBSNNM
	 7uT5Vu2ICs6XQ==
Message-ID: <cddf9f29-c2e1-4b9c-b3b7-c64e3a513bf4@kernel.org>
Date: Fri, 27 Jun 2025 09:37:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: new DMA API conversion for nvme-pci v3
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Leon Romanovsky <leon@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>,
 Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250625113531.522027-1-hch@lst.de>
 <175086952686.169509.6467735913091492336.b4-ty@kernel.dk>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <175086952686.169509.6467735913091492336.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_003704_701778_57335322 
X-CRM114-Status: GOOD (  12.20  )
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
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 25/06/2025 18.38, Jens Axboe wrote:
> 
> On Wed, 25 Jun 2025 13:34:57 +0200, Christoph Hellwig wrote:
>> this series converts the nvme-pci driver to the new IOVA-based DMA API
>> for the data path.
>>
>> Chances since v2:
>>  - fix handling of sgl_threshold=0
>>
>> Chances since v1:
>>  - minor cleanups to the block dma mapping helpers
>>  - fix the metadata SGL supported check for bisectability
>>  - fix SGL threshold check
>>  - fix/simplify metadata SGL force checks
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/8] block: don't merge different kinds of P2P transfers in a single bio
>       commit: 226d6099402d8de166af60b2794fc198360d98fb
> [2/8] block: add scatterlist-less DMA mapping helpers
>       commit: d6c12c69ef4fa33e32ceda4a53991ace01401cd9
> [3/8] nvme-pci: refactor nvme_pci_use_sgls
>       commit: 07c81cbf438b769e0d673be3b5c021a424a4dc6f
> [4/8] nvme-pci: merge the simple PRP and SGL setup into a common helper
>       commit: 06cae0e3f61c4c1ef18726b817bbb88c29f81e57
> [5/8] nvme-pci: remove superfluous arguments
>       commit: 07de960ac7577662c68f1d21bd4907b8dfc790c4
> [6/8] nvme-pci: convert the data mapping to blk_rq_dma_map
>       commit: 235118de382d6545d3822ead0571a05e017ed8f1
> [7/8] nvme-pci: replace NVME_MAX_KB_SZ with NVME_MAX_BYTE
>       commit: d1df6bd4c551110e0d1b06ee85c7bca057439d28
> [8/8] nvme-pci: rework the build time assert for NVME_MAX_NR_DESCRIPTORS
>       commit: 0c34198a16a88878aba455bebe157037c9ab52c5
> 
> Best regards,

Do you still accept new tags/trailers?

