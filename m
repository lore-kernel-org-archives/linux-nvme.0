Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DFDC2BD09
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jun 2024 05:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3S4MOQWq75PjVfYb3NeSd0mr55BZaHNtYmfjwxb5FFI=; b=kuTkIUZi3/QlCT4WMsb4F1fr4T
	vrY9CLw0+32LW897zM3YOeFFppEnfd/sienyroDE3jA7QdcPSgHl2ICYpnOaQhwu7ojQxeBdoHBwL
	991yUNAR26R3IT4ec8KyAgxCE7fDFXUbhvAM62DXxGvQNlwjCU8hrhbykMM/6JfReKgILPsgXZnq7
	+B1WmEY7Y0QXCXJNNhfosDaWe9lrBML37THarneNp6QOa7fio1EqgnD50vi8xpM4kSy5qfWD1Y/y4
	HmBuzgOhWCubHrGBTIGdnfzx8RIBinTEETic9jmSNit+ZxZwsSHXFf3qmcebEyN/N1T9bDGNDQ1Wf
	sHnwv8WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMi6c-00000009KD4-2dt9;
	Thu, 27 Jun 2024 05:55:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMi6J-00000009KB7-2cMK
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jun 2024 05:55:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A2FEB68CFE; Thu, 27 Jun 2024 07:55:15 +0200 (CEST)
Date: Thu, 27 Jun 2024 07:55:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v7 3/4] driver core: shut down devices asynchronously
Message-ID: <20240627055515.GC15415@lst.de>
References: <20240626194650.3837-1-stuart.w.hayes@gmail.com> <20240626194650.3837-4-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626194650.3837-4-stuart.w.hayes@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_225527_984370_858FB74D 
X-CRM114-Status: GOOD (  18.10  )
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

On Wed, Jun 26, 2024 at 02:46:49PM -0500, Stuart Hayes wrote:
> Add code to allow asynchronous shutdown of devices, ensuring that each
> device is shut down before its parents & suppliers.
> 
> Add async_shutdown_enable to struct device_driver, and expose it via sysfs.
> This can be used to view or change driver opt-in to asynchronous shutdown.
> Only devices with drivers that have async_shutdown_enable enabled will be
> shut down asynchronously.
> 
> This can dramatically reduce system shutdown/reboot time on systems that
> have multiple devices that take many seconds to shut down (like certain
> NVMe drives). On one system tested, the shutdown time went from 11 minutes
> without this patch to 55 seconds with the patch.

We discussed this before, but there is no summary of it and I of course
forgot the conclusion:

 - why don't we do this by default?
 - why is it safe to user enable it?

> + * @shutdown_after - used during device shutdown to ensure correct shutdown ordering.

Overly long line.

> +static ssize_t async_shutdown_enable_store(struct device_driver *drv, const char *buf,

.. and here.


