Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F384C55822
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2026 22:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IrK+sFIlkFTgCaWsK9DUWhSC502yfO7RwF/MpE5Myxw=; b=mb5JkBf63tuDd4Q4s9VcReCiMI
	fexTUNMB1nAsAJBk7QyRz+YvsxvUq1sX0Ht3azpvZVesb8PzrE4PDLH0Rn2JfGuUnJX2J/Yb6hpcB
	q4u3T0USqLM2Ly52M9r1E5b+S5Pgz1CBBubnKmfrR2JZ+iIEU78mt9Cgb7RfWsmDNnceug6dxbRv/
	u3Aeoc7F6NhxOiljS1IdfYaqeMmD8Zvu87XE5g89b5PzzNWFIP3Srgz1QoE8ZBkn+0Pt90jkF6Ez+
	m5R8bGvDknsf4SL98YDI0o7rYbj7PVqGc9b6ma6dZxmfvk0/D891AWBRshvPZ7M8ZOLNwr/P1nz38
	ypluZ/+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrNcN-00000002s4Y-2DQR;
	Tue, 04 Aug 2026 22:28:15 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrNcM-00000002s4P-0vI7
	for linux-nvme@lists.infradead.org;
	Tue, 04 Aug 2026 22:28:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F3F8A600AA;
	Tue,  4 Aug 2026 22:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C631F000E9;
	Tue,  4 Aug 2026 22:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785882492;
	bh=IrK+sFIlkFTgCaWsK9DUWhSC502yfO7RwF/MpE5Myxw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=N2wemNAvBS2zTNnVQMWlqmNOOBvt7tnmkkBTQQKICH99Psa6lO+6bQlOtR/QB2yHX
	 IzSMt6tdzOE2AYMxqCA91Z6/S16+Q4y6KtR8W+tWe2rxmCYDO3k+ZNE0gBwraGEt6X
	 HOn0iT7E2uL8BjTeaTjJL1V4Jtxzu9840GpQ+yfXzfaxCxejb7pdiycKUxABsfxuA+
	 n3yZjO7ErIyQ2IrP43QZSImOnPI7w7FCHPyCbtt+JZFj/HhJolwncn0E8kU3acJ4cl
	 5KL/dAk9It/6xlq02XswUuDECXcRknjUh430JW6nRL37Y9lI6t4/uB7LV8U1xmlVqY
	 uNy7ieQxY/Vpw==
Message-ID: <04736898-ccfe-4d16-acc7-31d70c6276b3@kernel.org>
Date: Wed, 5 Aug 2026 07:28:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: pci-epf: put CQ ref on create_cq mapping failure
To: Yifei Gao <gyf161023@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260804213626.3410403-1-gyf161023@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260804213626.3410403-1-gyf161023@gmail.com>
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

On 8/5/26 06:36, Yifei Gao wrote:
> nvmet_pci_epf_create_cq() calls nvmet_cq_create(), which takes a
> reference on the controller and installs the completion queue. If the
> subsequent PCI address-space mapping fails or returns a too-small partial
> mapping, the function jumps to err_internal / err_unmap_queue without
> calling nvmet_cq_put(). The matching put in nvmet_pci_epf_delete_cq() is
> gated on NVMET_PCI_EPF_Q_LIVE, which is only set after the mapping
> succeeds, so teardown never releases these references. A remote PCI host
> that drives Create IO CQ commands with a failing PRP1/pci_addr therefore
> leaks the CQ and a controller reference on each attempt.
> 
> Drop the CQ reference on the mapping-failure paths. The err_internal and
> err_unmap_queue labels are only reachable after nvmet_cq_create() has
> succeeded, so this pairs the create/put correctly.
> 
> Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Yifei Gao <gyf161023@gmail.com>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Note: it would be nice if could explicitly mention if you actually tested this
or if this is just an AI generated fix.

-- 
Damien Le Moal
Western Digital Research

