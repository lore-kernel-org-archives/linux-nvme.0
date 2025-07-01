Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885F2C7EE30
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jul 2025 16:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UaSsrUzy9seTj8OP2xcgpOZ1U6zOtxVvROKZcmOw7D0=; b=TD943n1G/8xnKyw7eOkgucqpce
	RTLKNlN6+UE29yfmflaQt63soKU/CxdMCMbCmCXvoYcdAi9xYjZjnxQxpuufhONMuyqXJpYXMfAA0
	Ou3iecdbcFyFkJZ30yW5ZOh/ti9vIvXFToZzJfoayO4ohF3lXr/oSIkUp9fnMM1Hgn/YYTmiTBi11
	ft0Ya71hzRBqAg8ftsJJERBeeceHm1j8BM2Yt8zt0hjQ/PzsNW5KG0BAoyOLZPO0wvGu5z6UuKs5c
	E2iu+PKe9SXS0S6iFpwaAuzAywr6Z/127W3MvJyb3Tg8l8nZBdynpyOxLMRcvJM2/x2qqyW9JNYiE
	GotnEesQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWdht-000000060nE-2PEf;
	Tue, 01 Jul 2025 16:19:41 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWc5H-00000005j5U-1Q7Q
	for linux-nvme@lists.infradead.org;
	Tue, 01 Jul 2025 14:35:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 16D4B4675E;
	Tue,  1 Jul 2025 14:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABFAC4CEEB;
	Tue,  1 Jul 2025 14:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751380543;
	bh=UaSsrUzy9seTj8OP2xcgpOZ1U6zOtxVvROKZcmOw7D0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WdKjGZGoE1XDiCYJrDe+/jUU1dJP9SWcsSMuV7GTl+N0Ujb8pSvwggRJ6u7HCAsG+
	 9XEfzgU8mC5XETsCKRZ9fUCegXDDIIN++u2loglv17xZ9I8uzAu/WfJA7RHQ54U1rl
	 LuK1zDYtCVe4smNtE2PQ5dM9FtU3PNdrs5rvJIheNK6Bz+Vw6YNi9qvOWVcvxyO8uK
	 vC5A0cVzrQ+zZznOhmXHIQQojXMiFgDEZSpnu/sSWurF1bX5feFF96cDJNjBmvoFYo
	 TL3HWiRoIhSQXNLDbKkI4059FWY1WO/PXOLDLAzOAI2bFIoQ85tEKyB0FFihOpUpfk
	 +t3agqM3mgYGA==
Date: Tue, 1 Jul 2025 10:35:39 -0400
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: uring_cmd specific request_queue for SGLs
Message-ID: <aGPyO2trvVxIsn6m@kbusch-mbp>
References: <20250625060915.GB9391@lst.de>
 <aFxzXOZUFtt6hyPA@kbusch-mbp>
 <20250626051413.GC23248@lst.de>
 <aF1nUYSXvLE33osR@kbusch-mbp>
 <20250627072524.GA1329@lst.de>
 <aF66IGSMATG9-sLy@kbusch-mbp>
 <20250630060016.GA28775@lst.de>
 <aGKZf5gX7_JPe4-g@kbusch-mbp>
 <20250701061609.GA17912@lst.de>
 <aGPRa43FJW_B1asI@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGPRa43FJW_B1asI@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_073543_398676_BF610FEE 
X-CRM114-Status: UNSURE (   8.97  )
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

On Tue, Jul 01, 2025 at 08:15:39AM -0400, Keith Busch wrote:
>
> But can they split commands such that they dispatch one per iovec
> instead of as a single command?

That can be done only if individual iovecs are block size aligned, which
isn't always the case. Only the total size is guaranteed to be block
size aligned.

