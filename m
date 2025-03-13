Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D90CC282EC
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 17:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6H7972kNL4LeXIGkbCgVm/fpAR4fHhha27OnCRyWNJk=; b=GsHXUbboieNFqf7YJiF+6gd18c
	Tgg6Li0m2jvRezt6buXXHQbZI1b6Xgt3TfHyFX4iFYG/GVT+JwzPYDD6WTMnLrDVzSDtXh0TTyiv8
	VKyMLV0RMPkwDmGfRAL3D+fwBDLdi6gajLfcijAxoKSCiEjL5gDUolm5PmvXxA5skbvRxJtgRbvhP
	1wYdgoRO64NSA8HDOgm4jg1RVN3+0o7/faRk921dvH0Hp2gWqXblsz2E1EYDs2RkWN4IakPPxhMd/
	yjbEwrmPRMUm82695kgNM9pKxo1RObLTuay41fKC03PVzRzlD62kFKy/8OD77xAEbBubEFWcuTmMA
	Y/4QcpVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsm9h-0000000Bywh-3LV2;
	Thu, 13 Mar 2025 17:15:37 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tslxC-0000000BueH-011L
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 17:02:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5F942A477C1;
	Thu, 13 Mar 2025 16:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E83C4CEDD;
	Thu, 13 Mar 2025 17:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741885360;
	bh=6H7972kNL4LeXIGkbCgVm/fpAR4fHhha27OnCRyWNJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MHjP5x03JkkgrVbFaMj2Cs7W6gcC+zK5JxnUKeN9d9ufFU0EC5mjlWkeTTex6nFM3
	 kem8fX2rHCSfDwpu1gFtDnTO5ixbYIAMMq8Ntxrs9dokxfBPbViv54hI5btcSQZYjE
	 yltfbZhJ/Druq0y4YX6xMaOJLkawNbHm+0KaH6pAU/331Gp7MCdY4A+owRAH4QAbML
	 qCCShy5m1CYVAyiZFsLs5Ut1C+zvazd9Gguph28wa7hcY1g1My6NXe9FSoewBZqsqp
	 WhNXE4YNff4fhfakLlGi6a7d75z8dJVtUAX9Zvm09hgfBP7nyXgN4qsKRuASTHQ/q6
	 Q+MR5Gm7NhSZw==
Date: Thu, 13 Mar 2025 11:02:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: zns: Simplify nvme_zone_parse_entry()
Message-ID: <Z9MPrs5a2SsNcGcI@kbusch-mbp.dhcp.thefacebook.com>
References: <20250313052520.1439245-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313052520.1439245-1-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_100242_105582_BE08AF01 
X-CRM114-Status: UNSURE (   7.62  )
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

On Thu, Mar 13, 2025 at 02:25:20PM +0900, Damien Le Moal wrote:
> Instead of passing a pointer to a struct nvme_ctrl and a pointer to a
> struct nvme_ns_head as the first two arguments of
> nvme_zone_parse_entry(), pass only a pointer to a struct nvme_ns as both
> the controller structure and ns head structure can be infered from the
> namespace structure.

Thanks, applied to nvme-6.15.

