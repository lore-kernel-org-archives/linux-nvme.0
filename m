Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37921CA0EEB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 16:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SjWTgNYQykSl5vqwrk7e1u9J/HugCNEPohbX17PekV0=; b=UWUoXR1kxyggCo5BymKwrlIoae
	K4ZkLyZQcMddaGEcspjoycgQP6nD0qw7ezg6iN35oPjApUGBo5is6yK+egnSmku9r83XpqJgEn0ed
	ztmUFPXsRJVkqWaABfhumCeftnRxTvx3WulPvG2CBPPqfapfatx4/138QbD+FPtfeMsTUgPVBdsoo
	FIDG5TiL7+S8GXY7VWjjDs9W7tHHpU2+pC3LALCr5j3bfCd4IdVHqR5y2trCzTcEtZofg1uTc5rLN
	msTrrk/Om1GQ3gyOufQqhrYW2lW4LN1tDZcG51hAO9+vYpf3oPpsLQkM9CdyC8LBJHQ7Xts+NacpA
	Eyhm2pHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg5yv-003nVT-1N;
	Tue, 12 Sep 2023 16:11:17 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg5yt-003nV4-0S
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 16:11:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5920F6146F;
	Tue, 12 Sep 2023 16:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84930C433C7;
	Tue, 12 Sep 2023 16:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694535073;
	bh=SjWTgNYQykSl5vqwrk7e1u9J/HugCNEPohbX17PekV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u/t6axSqrjJvcM/XxM4caXNi9Togbc/FQxSEboDlZ8tz2UJPV/oXsxZNuJRn7c7KB
	 5BWFl//ZDgLOmIpokerKhmEhs4xdfIo8cuurG4bY1bX+sfbFqK9FEHuBS9lgqNcJIE
	 uiNHXuxIwvLRUI4BL1yZmvbfzEhuoUOCsf+Cvd0jlZ5WfpJVqG3S7bJnummRscNSZQ
	 ZoRoh3tiT7o7ot4fDTEgFAn8rl7xSBCh92xJ4MyiS+HiJd3O+Wl6bcYVxyVg61cMN5
	 R0OVOpiy9x4danWKk5sel0AnfQAxIj/flEmFoEiNYb+aKZwWwy5DVrHGQCdhCdGz3I
	 71/8jnKufMlsQ==
Date: Tue, 12 Sep 2023 09:11:11 -0700
From: Keith Busch <kbusch@kernel.org>
To: Pratyush Yadav <ptyadav@amazon.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme-pci: do not set the NUMA node of device if it
 has none
Message-ID: <ZQCNn99783AbnQ5O@kbusch-mbp.dhcp.thefacebook.com>
References: <20230912155249.113009-1-ptyadav@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912155249.113009-1-ptyadav@amazon.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_091115_223878_31604D2F 
X-CRM114-Status: GOOD (  14.13  )
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

On Tue, Sep 12, 2023 at 05:52:49PM +0200, Pratyush Yadav wrote:
> If a device has no NUMA node information associated with it, the driver
> puts the device in node first_memory_node (say node 0). Not having a
> NUMA node and being associated with node 0 are completely different
> things and it makes little sense to mix the two.

Applied for nvme-6.6. This overall makes sense, though I hope the patch
isn't just to work around xen's incompatibility with managed irqs :)

