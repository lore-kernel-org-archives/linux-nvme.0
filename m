Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7231FC2BD05
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jun 2024 10:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gxf/XJjsoWWt8fd72ulCW//Q8VckdYrsDBKVGPJ5CoQ=; b=YqqHE825rWRn292Toy698OCKtK
	VOtTIO9GFfta91aDJf3N8LxpmRM6R0XeQviGd9dlF5v7SU9Y4nS9zmUbeKmqzcsmdn5xuguNOFSrd
	3S0HHoKomaF3ju1I6my7cVhxBC9f/hNwCCfsbhB1KVczAr3RbxcwVishafQl/xPplu2d1PtG4GVC0
	N4h8LnTCG7mVz/TNv4b1ZOX8I5XewcgXbPns7yABPhQl0e8illjOIcQuW8UuiHKE70Cebl6nDkafS
	A8u9XFpwelEHd3DPWKChWuHig3Uo4jap7+p0LCJgcfCohY8H3Jx6ZtYbEudKGo+SrOr7+UYnrdq9n
	MC/buwmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLguc-0000000GPrO-3j8S;
	Mon, 24 Jun 2024 10:27:02 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLguZ-0000000GPpQ-1fyD
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jun 2024 10:27:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EBB6260BAF;
	Mon, 24 Jun 2024 10:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12700C2BBFC;
	Mon, 24 Jun 2024 10:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719224817;
	bh=5Osaek7mJpfFa+5mEwuGe3SGAQhXao7yyk6LZtnNiUs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=M4YujQNw+zL+UeUxJUAX89b2rEUadUMjd81CPYwyJAFeEUO9SdYUgosWRt6WMEHEN
	 K755GKdD4ioU8w2WS5KqyRqUf6Vl2iVbAVSyD32Zole5UwzJQgpW/5/Ew29yLC4QcC
	 8PEB/qHC9V4LjE8JSGqldChQAalcEBYeOl17IkzSI6WYgnfbjtA2eFx9T0VLXGCP3Z
	 6nrqYAG9awPWTwaki4rMB/CIaGhVbPJrOkrswSc48nZQZC/3ArF4dEFmzv4LsnVq7m
	 fF+4MPF1TEFaatsSQIsSyQ3ffAnxcu38m12POz7MMtdOp6CD5e9oiUmN39nnCPWCjJ
	 UXMSa7GyrRuNg==
From: Leon Romanovsky <leon@kernel.org>
To: linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org, 
 chuck.lever@oracle.com, sagi@grimberg.me, Leon Romanovsky <leon@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: oren@nvidia.com, israelr@nvidia.com, maorg@nvidia.com, 
 yishaih@nvidia.com, hch@lst.de, bvanassche@acm.org, shiraz.saleem@intel.com, 
 edumazet@google.com
In-Reply-To: <20240619171153.34631-1-mgurtovoy@nvidia.com>
References: <20240619171153.34631-1-mgurtovoy@nvidia.com>
Subject: Re: [PATCH v2 0/2] Last WQE Reached event treatment
Message-Id: <171922481356.416620.9418503031889142594.b4-ty@kernel.org>
Date: Mon, 24 Jun 2024 13:26:53 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-13183
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_032659_522750_D8F5B4E1 
X-CRM114-Status: UNSURE (   9.75  )
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


On Wed, 19 Jun 2024 20:11:51 +0300, Max Gurtovoy wrote:
> This series adds a support for draining a QP that is associated with a
> SRQ (Shared Receive Queue).
> Leakage problem can occur if we won't treat Last WQE Reached event.
> 
> In the series, that is based on some old series I've send during 2018, I
> used a different approach and handled the event in the RDMA core, as was
> suggested in discussion in the mailing list.
> 
> [...]

Applied, thanks!

[1/2] IB/core: add support for draining Shared receive queues
      https://git.kernel.org/rdma/rdma/c/95dd753bdb674b
[2/2] IB/isert: remove the handling of last WQE reached event
      https://git.kernel.org/rdma/rdma/c/8de1ea4a9d7a2d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


