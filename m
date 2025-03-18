Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD577C282EC
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 15:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1ZNH7uNeeEY7x1DW5XdIB8vjZPdZeNLNfLm+hXyx8ts=; b=2+ZivXsvcMK4EfPsijXqTZkCbg
	aBVSquWCmyEFs+ig+GNG9tpTakeQwh+VaaPB5MccpwiZCJggyCaxdVH+OqeBkUOo/0GCCMX2OdJdU
	WiDwNDfu9N4OCzUDlBlENTtO9rWJGPWwaBcNYR77ugr4uagbittbh1dakQOfLwgEK4A8EmkdByxlI
	5dtNvfloGQhAXMxp2CCGKYEpXoXKSsMtRolxaD/HSrkSmsXp9JD1LXkbE0fTaa14wjfIdxq67FYFY
	CnG8ENyrHHzlmAU/9ekvlyLqGF9nGQtbG30E/NkzsAGLr9wIsQbd3rDETj3RNGre2ZMsdCdmjF1ui
	YoWaqfew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuZAv-00000006PBz-1C2q;
	Tue, 18 Mar 2025 15:48:17 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuZ9f-00000006OxL-2C9j
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 15:47:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B018D5C58A2;
	Tue, 18 Mar 2025 15:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3ACC4CEDD;
	Tue, 18 Mar 2025 15:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742312818;
	bh=rlKDub2TXvSh3OB1zL6PA3jiNVRABvWjihPXEQTDibI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZcAFbhE2N68RffEuJYDtO6WdgwSLnnuf1LWRvbB4ceToUnSmLaKKlTgqNaz2dgagf
	 GJxKaQWQurWRSQVT3sLzalKP6I/bp73MtxdsnWi86dmD08vCMRbOuhlOFVojIhdOR0
	 CqK6udVIewH/Fa6MJVxIe1SRsCx6WwhvRpDwiFdfCPdfDQbJr6F11rcBn3DfEWLVvu
	 15+dlefg3AxQ4nKIN69kM8uEk7d4x/QJJpyWpYs/Ns4ptWmDZEWHG/+mAOaY/DWpfy
	 3mDR8IzrahRBrnTuroP2uFDzQ3GCOT7bA9g9YXrKD8cJ/miwXDalX7qK03iSmTBDU7
	 c2g3MJFU8en8A==
Date: Tue, 18 Mar 2025 09:46:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvmet: pci-epf: Always configure BAR0 as 64-bit
Message-ID: <Z9mVb8KDTFcfn8ER@kbusch-mbp>
References: <20250317095703.1661633-2-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317095703.1661633-2-cassel@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_084659_599945_9DA97817 
X-CRM114-Status: GOOD (  12.72  )
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

On Mon, Mar 17, 2025 at 10:57:04AM +0100, Niklas Cassel wrote:
> NVMe PCIe Transport Specification 1.1, section 2.1.10, claims that the
> BAR0 type is Implementation Specific.
> 
> However, in NVMe 1.1, the type is required to be 64-bit.
> 
> Thus, to make our PCI EPF work on as many host systems as possible,
> always configure the BAR0 type to be 64-bit.
> 
> In the rare case that the underlying PCI EPC does not support configuring
> BAR0 as 64-bit, the call to pci_epc_set_bar() will fail, and we will
> return a failure back to the user.
> 
> This should not be a problem, as most PCI EPCs support configuring a BAR
> as 64-bit (and those EPCs with .only_64bit set to true in epc_features
> only support configuring the BAR as 64-bit).

Thanks, applied to nvme-6.15.

