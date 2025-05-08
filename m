Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340DEC3ABC6
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 15:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OzU5DXECkbcfIc1nBAJNTY2i9RZYB11+/ogXmhk7nJU=; b=mqcYScyV8V1lmZR0vs4ev5EoFM
	cqAsu5yUZ6gC+FkKzpFaSnL3dvRPIdPPVhH3dP6ciaVBuilBD0NVY1Cx/VuICY2y2V3Lublr09y8p
	FFG/opebcpQnaoU6xO4Mkn7Spv5bL+VI2N9YZDWPm1bKRuHvUZbA4EEHYoggoafpsYiMQpa3taev/
	JNngLI824VfXj3pzedkBUKZu27EocIlZrIFYHDmQa/hmNqc36Mp6T5iWgw8thRfcwNcEmTRJxYisQ
	/IZIUadT2e44JE/Hx1EnPM9ULKKuZyCSLU6ktSurD6/wtZHfeeJ005/ej8EGGgXnWbcpKJkhzKDX3
	cQbgBuiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD2qR-000000013P7-3Bnf;
	Thu, 08 May 2025 15:07:31 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD2F9-00000000vDO-3kFV
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 14:29:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 300DE4A5FB;
	Thu,  8 May 2025 14:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A21C4CEE7;
	Thu,  8 May 2025 14:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746714539;
	bh=McQu651ki67ccZAvRQk4ec5g9Jl4X5R1BFgXVoCNQgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mLzONLoNy7ZIbFFlsOVCJiQfAGbAWcMpnxjVLFwQurmfaDRn1abY4Tg0wC5VkctlI
	 XbZiJiYJUEPVuo6VB9bVclsCWWX9vX2NJGlZoynkUObeDCvnn23gky8KbWiNfZa9vS
	 0aPFpd6kEoVGnlSu6H7cMxeehCbOKL1YsV1E6iMwvISlxJXv1dGzlu1Gd6TjlGhJk8
	 7N+RUDrDWcppH53OTIb+XON/P7AW/19tok4XkG9MltiD8aWb9ZVbG+Wri2wi0WIOEb
	 4NiFWbc0GsuhoTTG42qykhT8fkbWAlI1yPpFh+uA7OEujOfPGnz0TDoJJAdgW0PRwO
	 rCQH4VgYuO3Vw==
Date: Thu, 8 May 2025 08:28:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: lock per namespace in nvme_poll_irqdisable
Message-ID: <aBy_qLi3OvYk6HAL@kbusch-mbp>
References: <20250508-nvme-pci-polling-v1-1-29ae900e793d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508-nvme-pci-polling-v1-1-29ae900e793d@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_072859_946963_83E1D56C 
X-CRM114-Status: UNSURE (   8.99  )
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

On Thu, May 08, 2025 at 01:55:55PM +0200, Daniel Wagner wrote:
> +	spin_lock(&nvmeq->cq_poll_lock);
>  	disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
>  	nvme_poll_cq(nvmeq, NULL);
>  	enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
> +	spin_unlock(&nvmeq->cq_poll_lock);
>  }

I noticed disable_irq() contains a "might_sleep()", so the order needs
to have spin_lock() happen after disable_irq().

