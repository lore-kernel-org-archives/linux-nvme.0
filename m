Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8098C3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 08:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iQ/fthSSpeyf/fKGCeuiBW/n9M+WeAqGukzoymbcurw=; b=NAzQiT8zdaO7qJBQmn7w58DAJl
	uxM66IaK3PmmUidQFV9nXfTVU4qlidmOyajcoJ37EG33ye4GQtlywXBAtTiMhTgEzhliid2ovHVNT
	9AnT/GV0chEFOXdSGdTH+G+X1UItgmsiByqD2l0zgFi3NXZdIGzDc3s3OtW2aPXfacoTrH8Y4s0sR
	GqQOA6auvtrmVUUT+fvxr1nAeL3lTyNcLL09m1GRDxrHJD2hwrw/yw5aL3C8Ou4yxRhnJDL0KQiMA
	94zMM7GW5P1R34xJq0hHJ2RnDEwixfCnNSv4Qvb/uKdR0FLqm9jT5xmTa9D7ttARiHARjMxvhHJiJ
	r81UitlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCaEG-0000000Ekc4-1WIt;
	Wed, 07 May 2025 08:34:12 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZEq-0000000EXYg-2QAn
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:30:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 986D85C54B2;
	Wed,  7 May 2025 07:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DE6C4CEE7;
	Wed,  7 May 2025 07:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746603043;
	bh=+r547NGohNP6O4oLhK5wXo8m8DnfcP1w2BlsdrYteI4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mpR4Yn5LNor0fIEaD5gEXZewq2FTk3aS0TrYwOwlXJ7dfJbInBhB9e8Pw/J4Nv4Up
	 TNGgNXoufmVax2JUEGDIUlokIADD1Mjc3ttyUHAyXyYvCyM8dHJPh1fVTSpkrO/TdR
	 6LFJEbPtIWeK5AAA2/QGYRGnGh4BQ6mlkkxsZJP3IeKmpJb1L2oQGmtjqkx6xrUDrm
	 G39EWnDmsDsgkP0GSaZZzGTZSh8Mmkg361GKmO/UI48yrsTYgn7j+YJFkaQ7WjqjCD
	 EYl3g+U80QML90s26VIx1TTSlxUSE61yjgevgsNMwpMB3stTaEIzqczpDOFBD45oPl
	 Y+3GOghQ7K3/g==
Message-ID: <b5c178a8-6b61-444a-a18c-5c018d19aee8@kernel.org>
Date: Wed, 7 May 2025 16:29:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] nvmet: support completion queue sharing
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: alistair.francis@wdc.com, cassel@kernel.org,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20250424051352.7980-2-wilfred.opensource@gmail.com>
 <20250424051352.7980-6-wilfred.opensource@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250424051352.7980-6-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_003044_674517_8C403C44 
X-CRM114-Status: GOOD (  13.45  )
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

On 4/24/25 2:13 PM, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> The NVMe PCI transport specification allows for completion queues to be
> shared by different submission queues.
> 
> This patch allows a submission queue to keep track of the completion queue
> it is using with reference counting. As such, it can be ensured that a
> completion queue is not deleted while a submission queue is actively
> using it.
> 
> This patch enables completion queue sharing in the pci-epf target driver.
> For fabrics drivers, completion queue sharing is not enabled as it is
> not possible as per the fabrics specification. However, this patch
> modifies the fabrics drivers to correctly integrate the new API that
> supports completion queue sharing.
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

