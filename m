Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D14C28B26
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Mar 2025 15:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9VxXwo+5cnlsC/DeTh0xeyAtlU8hSSXHDmxw9MQ5Ug4=; b=WPmcJ3qGyOYHMevHaGxHOEk5xT
	VVnGlpUEy6l1Xj5HZkpB/sz+ZQbkcvdPHtEeLxF9KVl0VtgW6NVYZtsGcpDiQLVhKDZEeCD8XXWIt
	GScC48sG10BryK9xQjj0X7fbuTdllUe9uwjwEWwJjGm2Sext0T1pn0Ofkhh4tCOerBrB+jAE9cYPR
	ZT3dBMVVZG3Timak9IWCI1sORioJfbuR89fBFKxZtkypa6FW/XJINWOwNJIldKM/YxIJQuDGEFN7T
	NGY0Os+ABkcMQQ2DbitEzDGz0tjiAej8kXDqOho7dcyFuhfU734pZvsL4OCA95mgUoK+NyuFFm9yB
	DHWL9QkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqZhL-0000000EgIz-2Rsw;
	Fri, 07 Mar 2025 15:33:15 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqZZF-0000000EdrE-0yDh
	for linux-nvme@lists.infradead.org;
	Fri, 07 Mar 2025 15:24:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 59941A45885;
	Fri,  7 Mar 2025 15:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A445C4CED1;
	Fri,  7 Mar 2025 15:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741361091;
	bh=ohT+4YkwjY4kMlLLd6wS4lyee9DsScklqWYh9bKIVNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GVnWIaoqRBmDsZ5MPx2O5nkxHnPuc0QbQblI5JwCGMkbrkP7kyj+I2DHb65sHKcdN
	 bT5X9ULaPBJJqzLnGYPc9qno7DbBCRA4MfY+P/FeWJLvXu72klSK97NC7f408ww0/R
	 at1QHm5P41k7/xkK45GLzEZhzCjiugSanu0n94GolihCKBdNv4ANAVcLmFCSVvgpBY
	 H5rblToBMqN4lSgzpdCg5kXX2GcNFys78V5E1xH87kMD4DSAmIqgEiFyW8iNNKCtvx
	 EsC1+q1Pg6WVwFgzpKDUzQoz3jW5x09LJZjR7uQniZNAWWveZ4uCjTHI5K7Bfys5zw
	 35xis1LuHnXFw==
Date: Fri, 7 Mar 2025 08:24:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH] nvme-pci: fix stuck reset on concurrent DPC and HP
Message-ID: <Z8sPwJw2oQH3slpT@kbusch-mbp>
References: <20250307002424.3655342-1-kbusch@meta.com>
 <46617499-17ea-44b9-9ed0-1fb5d238f54f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46617499-17ea-44b9-9ed0-1fb5d238f54f@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250307_072453_352579_82B0DB11 
X-CRM114-Status: UNSURE (   6.56  )
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

On Fri, Mar 07, 2025 at 06:28:28PM +0530, Nilay Shroff wrote:
> Though one question: IMO, the DPC error handler shall invoke nvme_error_detected() prior
> to nvme_error_resume(). And we already disable the device (and cancel in-flight IO) in 
> nvme_error_detected() and so wouldn't that help? 

The sequence is error_detected, slot_reset, error_resume.

The slot_reset schedules the nvme controller reset. That work sends
amdin IO, like identify controller.

If the pciehp removal starts after reset work's controller
initialization, then nothing stops the work from sending new admin
commands, and nothing will complete them. This causes the error_resume
to wait for something that will never happen.

