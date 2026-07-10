Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99A7C43458
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2026 03:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0KC2NEqiwuxRfm3Qsk1EFtYhbUETyKz9jYkvkW+WGMI=; b=irqtdNqJL77sRnKi26qKGc8sQ/
	yQCL/KwJDNjK31EFWJ8EqobNagt12IoOYDvrP9KBN9Czim9KOs25uMlKf4z7hCo0Nnx2KEaawggQ+
	0EbQujtRt539aFRYQYGOrOypL9XpVm+8g4UL0OIxkYYNrPXg340i9SmNuj/jwHXLrMQmW/6Mnf1HT
	WFtLFobN/MJy6ASOJDoGRJofaNFFpL8u0FYy328g6V4W0HQ0tciTzwdhBMxxKNcAKc0XAs1Aij4/e
	qps2uMmQjF/Fm96+6KAf8rhnj+Yp84tMP/cs4ZOEjbDCX9S7I0c2sPlSjY/5gAs+Smk0LFVkbxURc
	zCfbzZEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi1uK-000000042Hv-0frV;
	Fri, 10 Jul 2026 03:28:08 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi1uC-000000042Ho-1gwr
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jul 2026 03:28:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D264E4389F;
	Fri, 10 Jul 2026 03:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA331F000E9;
	Fri, 10 Jul 2026 03:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783654079;
	bh=0KC2NEqiwuxRfm3Qsk1EFtYhbUETyKz9jYkvkW+WGMI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WJuQMTiYh/yqtt45gXuT2EB3hiFUaRB1d180Wva8rLVQgwNClZXn/bC9aXpu3DjMU
	 TChDz5eC0Pn0DcuQVohx5OPqUYxqS1+ezlpUb1AgGr6HZiY38LZMIqhmj/1GSQj0ov
	 atPZjG3PhsaNAjgwMNtO0f9LcknQPx7J5Bj7wum2Qzp5CVeLwPMOh02UUQcaLWCu2c
	 5XP5R4CLDTp4fjbKT+/nrupFRC+cCEGz3FoRLl2AtZnOjrNxB8DX2cPzn/Z9CIqMuG
	 mVgE9W0y3CK++v1uRLwhigJdJd51mHZjisNMeZCjgLM/ke6aRstk7ahwV8Ilkozlp7
	 igSRKDmTsYqeg==
Message-ID: <bf3201f1-cf49-4c4c-8104-ec50f2d4ae69@kernel.org>
Date: Fri, 10 Jul 2026 12:27:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet-pci: validate queue IDs against endpoint queues
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: kwilczynski@kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260710023015.3744082-1-michael.bommarito@gmail.com>
 <20260710023015.3744082-2-michael.bommarito@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260710023015.3744082-2-michael.bommarito@gmail.com>
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

On 7/10/26 11:30, Michael Bommarito wrote:
> The NVMe PCI endpoint transport allocates SQ/CQ arrays using
> ctrl->nr_queues, which is capped by endpoint interrupt capacity. Common
> target admin validation only checks queue IDs against subsys->max_qid, so
> a root-complex host can submit Create/Delete SQ/CQ commands with qids that
> pass the common checks but index past the smaller endpoint transport
> arrays.
> 
> Impact: A PCI root-complex host can crash an NVMe PCI endpoint target with
> malformed queue IDs.
> 
> Reject queue IDs that are outside ctrl->nr_queues before indexing the
> endpoint SQ/CQ arrays.
> 
> Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5-5-xhigh
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

