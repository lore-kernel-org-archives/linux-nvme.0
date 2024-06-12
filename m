Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BA9C27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 20:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7hVwnRMoSBMJPWcJy7RzH5XrD2/fHAC4H1l7q6/ESG8=; b=Q+XYL2j7ptgjoO8vQEKwRm4cXf
	Ep3LnG/RQNqP/ZYteQ4OqvEd44o+BdRonqIgxVmqbwGdX3FHZjZumiU5KH1Pkaz0efepqcEyzc71j
	bavCcmAufket2mSzQwS4ZQ3FPUBAUyLXvWdPQU4FqzULtmwDzV5KpLt/HascY3weF1Cv/tfSjFMME
	Z+aUSB7dBQ6RDzcwrgkfIqCV7F75rCoHpYQHLXFilQfYNPMv0PcFTVcUGZltNle9IHPiKI8YBT3uy
	WcquXjodFixpKTncJPTDUWSgqF5rmQ0teBpycMKinsWbvaNdK5K0YWpQod13EbrQJugxz7VzgPbqX
	U0MfZCTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHV08-0000000E6rU-2Yj4;
	Wed, 12 Jun 2024 20:55:24 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHV00-0000000E6np-1QHD
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 20:55:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 61085614BF;
	Wed, 12 Jun 2024 20:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4AAC116B1;
	Wed, 12 Jun 2024 20:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718225715;
	bh=vtyWHnXG1p3yyQvY7vBy4X4sTbiCW7OZDwJn2nOC4hM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cxj/s95xv3glfSecT6BZP98WWPduof/lIMq4LzAnx+gsENNyq1OZE+bzjQcSRImUe
	 GZEJrLRd3hMmXRYAfhlqPMOM7E9pz4sfHIElIZno7wqUKgQllosOVxlXeGkl2xjADS
	 hOWG30s4dUfq7IqiSBaPPOCd4R6QOd3r3ruc5iirQUS//afFkppnDWdJ4lXiq5phDJ
	 PHxH4/No+mxfybSPxNPv42tGz0eiWXlfTyR67RJBsQ8uYmUlRQGEmisXI8Z6yvNFeP
	 SadQ9IOm8jdyYEFIifm+VFBK6bcm6DYWCtWTZGEBPJFSzhG7jMFmeMOWmvT8Gi9W+g
	 vBU93sGE5l3sQ==
Date: Wed, 12 Jun 2024 14:55:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tanjore Suresh <tansuresh@google.com>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Lukas Wunner <lukas@wunner.de>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v6 3/4] driver core: shut down devices asynchronously
Message-ID: <ZmoLL8c_ujmjzSHQ@kbusch-mbp.dhcp.thefacebook.com>
References: <20240516154920.221445-1-stuart.w.hayes@gmail.com>
 <20240516154920.221445-4-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516154920.221445-4-stuart.w.hayes@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_135516_625501_806A7C03 
X-CRM114-Status: GOOD (  19.57  )
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

On Thu, May 16, 2024 at 10:49:19AM -0500, Stuart Hayes wrote:
> Add code to shut down devices asynchronously, while ensuring that each
> device is shut down before its parents & suppliers, and allowing devices
> that share a driver to be shutdown one at a time if necessary.
> 
> Add /sys/kernel/async_shutdown to allow user control of this feature:
> 
>   safe: shut down all devices synchronously, unless driver prefers async
> 	shutdown (driver opt-in) (default)
>   on:	shut down all devices asynchronously, unless disabled by the driver
> 	(driver opt-out)
>   off:	shut down all devices synchronously
> 
> Add async_shutdown to struct device_driver, and expose it via sysfs.
> This will be used to view or change driver opt-in/opt-out of asynchronous
> shutdown, if it is globally enabled.
> 
>  async:   driver opt-in to async device shutdown (devices will be shut down
>           asynchronously if async_shutdown is "on" or "safe")
>  sync:    driver opt-out of async device shutdown (devices will always be
>           shut down synchronously)
>  default: devices will be shutdown asynchronously if async_shutdown is "on"
> 
> This can dramatically reduce system shutdown/reboot time on systems that
> have multiple devices that take many seconds to shut down (like certain
> NVMe drives). On one system tested, the shutdown time went from 11 minutes
> without this patch to 55 seconds with the patch.

I've successfully tested this out on a few systems, and noticing a very
decent shutdown time on my nvme systems. I also like the current
solution here, as the two-pass method was harder to follow.

So I think just remove the extra options that Christoph mentioned and
always use the driver's preferred shutdown method, then this would all
look good to me.

