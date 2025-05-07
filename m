Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A45DC3ABBF
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 09:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V0+NY3EZCovDfzcx21sFykAovrzJyojJYTocWBSG6VA=; b=2Gouf459pJfUt6XQr2UMk2N2wN
	9b0u1cxUy4nqk48UWyU1zvGN5dH5MCES7VmX37XK75ve3bhDhm5UnFnaoBkOo53J7bcVYBMTmG8Ft
	5D7dg5/T4cS3DySygL6+8joSo9idYezrBp26uTSPUuBN4Eyo77DdBIFyD2s7JTp7QYaWQJEkNToCu
	bhFtBHLOLTBhYki1LQYO3vsP1vxxBZ5F0SAFr6WUGcdg4xDxObaotL0EE4eVzl6Dq34b5ZAIZPsXN
	ekf380Ot+46ACMzv39lcQTdlMqCO+XhvFIB3PJG1+ecyiBCv7xxFs1I9A8EuVmWULQDcIuQHcq6bB
	6nFr5zvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCbUE-0000000F1gW-34h1;
	Wed, 07 May 2025 09:54:46 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCbEC-0000000EzVC-1jGM
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 09:38:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 858F6A4D742;
	Wed,  7 May 2025 09:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59235C4CEE7;
	Wed,  7 May 2025 09:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746610691;
	bh=nCX5VuO5NTi8rhlHb8ANVJgMBobxnz8zGqKJdyB9mlk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QVKjrRZQFNrYTBQh31CiBMtPjd+HT6KilBlDUChVMSxUagx9JNTgZWjarpe5eLPUc
	 1Qim1i/P9/Ln3cO054bsuyI+sponvWmiZUJL5MykzJssDJBel29d55AXshDgJJz0L9
	 7QhOns3N+v0MM1hnYZWjeFDYa9yOA3pbEoPXC1gzR/QvsGITK1iEdDe1k5e7VLmJyy
	 9UKfDYCSq5N6cMstWLk2uawhLvMSjSAhcigwSp7ZNSZPgN0+mUSRAxgJxBb4riYM/0
	 qV6zsvJJC6Sk/3zJ5LqYlZOLN28byfqaYkeKGmmQfdMkqyoKTbFr8Aoev86EZW+Tuz
	 OQPDNV25ra1pw==
Message-ID: <c565dd22-f16e-4163-9c95-8233e1979bf7@kernel.org>
Date: Wed, 7 May 2025 18:37:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-auth: use SHASH_DESC_ON_STACK
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20250507082818.46157-1-hare@kernel.org>
 <20250507082818.46157-2-hare@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250507082818.46157-2-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_023812_515958_09CD2B7C 
X-CRM114-Status: UNSURE (   5.83  )
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

On 5/7/25 5:28 PM, Hannes Reinecke wrote:
> Use SHASH_DESC_ON_STACK to avoid explicit allocation.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

