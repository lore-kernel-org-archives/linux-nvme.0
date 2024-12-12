Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E22E7717F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 19:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=n5FmdmtYzQRS1EPK7cCvVDxhdBGh1pqOyGB3QzFTnLQ=; b=sfmC3HzFQjd+tj
	oPQz7ulDr5hdnJEqKSJoyTK1kH1XX/fyGX3c5fFI6spE4AIKpFVzkzzI5EMvy38hu/McUfdAY/8gM
	ZpjHr9zTtM/ExQpIwDJeju0UTmjp6xIDl9q1xWH9ToGGAerDNEfCOuQmTYmHSNAtuMuZQfkEyOla5
	brdr8nhMbNBEp2cwl6yaNeYwO6CDp0hkORCqeUOCB3229nK1w1fNkiL8SBsRwhljhF1UAs5nGn08K
	7brlqmsY92fXi6o3gQ1JkUwW5Yst6ymPk8OyBsNe2CkvtWX4IxpaDdvbH4G02QdhUtxSuOdQnogtr
	8OIQwz1XWn39kqvPJYKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLovQ-00000001ehP-2HiC;
	Thu, 12 Dec 2024 19:32:40 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLoLR-00000001WUi-0scy
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 18:55:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5D3925C60C7;
	Thu, 12 Dec 2024 18:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D4FC4CECE;
	Thu, 12 Dec 2024 18:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029728;
	bh=iC63c2TfMwutN6CHlOx6ciqpXlH4loUdJcyZovJHIwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CdLt3LRdRxlehMKz4zIBkBo/OKzlURCHDEkmxHQDI5TfmgA6/hr1ZKA88Xblwa21h
	 Q8c58GT5edDsbsKbt6R0IFL8giY0ocGxd9pWVDqmmgGdMLm1++IhD3Cd+uKBLeFQc8
	 T1WJq9ViN9YeD9hYvPRIOnKCI/GGIgAfDiKnQSvnQvLuXhZCSUfUNdHqtmlzZLL8NW
	 qKu5iSVXt443Y+tO3x9+dw0q8gLgyjRZ75/SBJs5dgj/54YmLhsTxQOtQwTBjmtGp+
	 SDqYMmDn3Qe8d8WJPTvjzRJHzMLF80wtEw4CqQ9LEtd+08JwJQpeYNciACRbCbgQ+p
	 3soTaSulMEgEQ==
Date: Thu, 12 Dec 2024 12:55:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
Message-ID: <20241212185527.GA3356063@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212113440.352958-18-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_105529_288371_931770AB 
X-CRM114-Status: GOOD (  10.53  )
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

On Thu, Dec 12, 2024 at 08:34:39PM +0900, Damien Le Moal wrote:

>    This ensure correct operation if, for instance, the host reboots
>    causing the PCI link to be temporarily down.

s/ensure/ensures/

> The configuration of a NVMe PCI endpoint controller is done using
> configfgs. First the NVMe PCI target controller configuration must be
> done to set up a subsystem and a port with the "pci" addr_trtype
> attribute. The subsystem can be setup using a file or block device
> backed namespace or using a passthrough NVMe device. After this, the
> PCI endpoint can be configured and bound to the PCI endpoint controller
> to start the NVMe endpoint controller.

s/addr_trtype/addr_type/ ?
s/configfgs/configfs/

