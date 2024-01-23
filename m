Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B9CC47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 16:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KAo1nwqFEJ6gCJGFnB16ySYm1F4RaAX6SXBiejS8A3c=; b=b0znmlqV6SzOqcASEI4/DUGWu+
	jG7dB4gb1gMohuL9581yQFMvdcTP1Tfbkts905U/1gKqWHDsbB2XsbgfPj2Zrv7oC88OHdjJ8ONLE
	FyJoalFcZpV9V4fUZfLJDYH+BlODKn5WmrPqF33MGz73pkKbqjr/qMfyK6BNnEI+vZG27fBINhMlt
	sWlYDEkV1bdk8A2xQUNqtD2C1S5DHnqptmybAWgZttRe/pfln9UBkqMsibTHh1WiDhtUWLO6EszX8
	RFlIcnW5sbU9g6LDZR+jU//xWEACwjgZnxdJlyUY/u22CxN1zzQ3cYM3A77HmctsrNXy4YRQr8VKy
	B1DeUw2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSJoX-00HJYg-39;
	Tue, 23 Jan 2024 16:39:53 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSJoU-00HJXQ-2O
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 16:39:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0F070CE2E02;
	Tue, 23 Jan 2024 16:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CF7C433C7;
	Tue, 23 Jan 2024 16:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706027988;
	bh=KAo1nwqFEJ6gCJGFnB16ySYm1F4RaAX6SXBiejS8A3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZvlIuZxHBDr55mt7MCcC7S7YhEZkfWBNWwImkYoW8hXDetuOGjGOV0LHt7RSSsXw8
	 a/JUFE91cdTPg2XWYIVe64kzUtwyLChdirIgZadI+KpZ4xUmOp4U+zJ8AHUg0e40I3
	 VerHrJYi6cbyVYKrDectsm5Vezw+ok4n/FmX3kouxaPg1L6HzYC5V9uYQJy6NJtwFk
	 O4eiHihutwzrBz2rT//w/nMsJjoZOXxAV99qIz/4A6fuLkhkrWmfXofcoB1LP3uXVX
	 43ovUSa0KX51T1VuOEssMZQ/rHv5FiuMM3YvoWCH7OO/+7Y3DeW/k35Pis0XdZP69e
	 OYv60R9v/Ec+A==
Date: Tue, 23 Jan 2024 09:39:45 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: sagi@grimberg.me, axboe@kernel.dk, hch@lst.de, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: unify aer type enum
Message-ID: <Za_r0ZoaSU1PaLoS@kbusch-mbp.dhcp.thefacebook.com>
References: <20240118125145.57983-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118125145.57983-1-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_083950_955021_DAF3E9FF 
X-CRM114-Status: UNSURE (   4.74  )
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

Applied to nvme-6.8, thanks.

