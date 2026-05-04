Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FB3CD3423
	for <linux-nvme@archiver.kernel.org>; Mon,  4 May 2026 04:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jlih6NvAh4WvaG/O7PVidqtNlmD0RagHqeRI/xJVk+E=; b=AO53ZXnxv8LvSxbVkzC0jNcOEG
	eFCIMlycZItZzRZIh4LYXbACG7QmWdIvnTt0AtcNh0VGCv9Ik2Q7RrCC5w1iy+HVKjMSOdOhgh60+
	ELqpccAV2XE8TllnA73owo/t3fHgRAWmfKqoeBT5yH7Ij0K17nLIXTGfA9lrrnG/cmQ9JieHdmMpS
	O9+BjfyRaE8BCkIhezx5HWJVD8+tct8V93nLUNZ4tddb9V0vB8Zr/sVjpcuIhw0FMgju/o3bupZb1
	/jP0Gs8Q3kxEc0WMRiQliwkVX/2yolJBj6Nsea7ch3pSC0IcydMJa3mNsLtWwR6n8i1qEeoO8MW0j
	5YuYzxDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJl3K-0000000CLBf-3Wwo;
	Mon, 04 May 2026 04:37:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJl3H-0000000CLAw-3OI6
	for linux-nvme@lists.infradead.org;
	Mon, 04 May 2026 04:37:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EFCD168AFE; Mon,  4 May 2026 06:36:55 +0200 (CEST)
Date: Mon, 4 May 2026 06:36:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bean Huo <beanhuo@iokpp.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bean Huo <beanhuo@micron.com>
Subject: Re: [PATCH] nvme: skip I/O Command Set specific Identify
 Controller on pre-2.0 devices
Message-ID: <20260504043655.GA9013@lst.de>
References: <20260503200243.2968366-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503200243.2968366-1-beanhuo@iokpp.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260503_213703_988550_5C71B0FD 
X-CRM114-Status: UNSURE (   9.32  )
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

No.  NVMe allow TPs to be implemented on devices claiming earlier
compliance.  We've had this patch and this answer probably half a
dozen times now.

