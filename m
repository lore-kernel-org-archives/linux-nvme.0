Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCF7C25B7E
	for <linux-nvme@archiver.kernel.org>; Tue, 28 May 2024 06:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Us0ikjG+JUxQxOWfW3Oh9bjGMp8p6F05tQTo8cWcwek=; b=gB8TKk1eFw6ORZcLJi3CoiNnmj
	qyQf4JfLYVUdNGGssnOZVj9aGiszPL9k+Y4AJDMkXjzclZLBDXoOp0ubnWY2ysMj1vUfb/9KBiqwy
	1G0RAkPctZcJYSn/NgfFqHR5/zxY4fWwWV1qPSSjuyAi53D4awoux/Hst1qBPcVBAAPdfijiGT50H
	l74iUz4vqiZXGfemKA9sY3AlJWcdhk0v799796YN4FB1lCAiDk3OS4edq1b515IlYV/T+B4cncLBx
	vHRPpX/JlLmTwEodkxI3zOgxOhLrBey0Hm9uctixLgQ5UHLysJmAfHGVMVuC0m15unHDaWNqPg/3g
	vaXIeOog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBqMq-0000000HCgU-0x8z;
	Tue, 28 May 2024 06:31:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBqMn-0000000HCeX-0u6K
	for linux-nvme@lists.infradead.org;
	Tue, 28 May 2024 06:31:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6D36D67373; Tue, 28 May 2024 08:31:09 +0200 (CEST)
Date: Tue, 28 May 2024 08:31:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tanjore Suresh <tansuresh@google.com>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v6 3/4] driver core: shut down devices asynchronously
Message-ID: <20240528063109.GA29965@lst.de>
References: <20240516154920.221445-1-stuart.w.hayes@gmail.com> <20240516154920.221445-4-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516154920.221445-4-stuart.w.hayes@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240527_233125_490650_715EBAEB 
X-CRM114-Status: GOOD (  12.83  )
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
> Add /sys/kernel/async_shutdown to allow user control of this feature:
> 
>   safe: shut down all devices synchronously, unless driver prefers async
> 	shutdown (driver opt-in) (default)
>   on:	shut down all devices asynchronously, unless disabled by the driver
> 	(driver opt-out)
>   off:	shut down all devices synchronously

The on option seems very odd.  IMHO safe is the only really sensible
option, and maybe we have to support off as a bandaid due to userspace
behavior dependent on synchronous shutdown, but I'd rather try even
without that first.


