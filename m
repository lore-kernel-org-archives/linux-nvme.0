Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4081C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jun 2022 09:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TGuPfqHi82wRfZd1vJmOWb6oBVxR9+w/Uz/OCkA9FdU=; b=WyZ/20HTjXr0u2cse2pyb2gyBO
	uNe0sc7nphmiSJHwEVwWH/tJYtXRVs2wACHNw9MQG3zJegR05pqO4+uCVwAWhSH2NpS6NVAc4TIkY
	JF+VY5qhzGNB78WuTmzM8atTRSwDBt9zYAe1nRb8M2FPegkVkx5s575vGJVJ3UcGcbrlSX26kt3aL
	rz4U9dYx7drJrPXSFA9yEaNyeVTvHCwZaBylFs4a4oSAtiEFqP8OIs8MCnUC/e3Ac5LPua6UuPRK2
	nNqIcOXbg221WUJ31D+oYwyAjuMIJIL7A2ACU4L1nBzPaKM7MTT7j6nc9HKSsfquNeu/Wj+jptHwn
	e5LG9RvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o27qt-006YLQ-7E; Fri, 17 Jun 2022 09:01:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o27qq-006YGZ-Rq
	for linux-nvme@lists.infradead.org; Fri, 17 Jun 2022 09:01:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8636A68AA6; Fri, 17 Jun 2022 11:01:01 +0200 (CEST)
Date: Fri, 17 Jun 2022 11:01:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Klaus Jensen <its@irrelevant.dk>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <20220617090100.GA7767@lst.de>
References: <C85067CB-3909-4B62-A86D-467827EBF96E@oracle.com> <20220420073641.GA6859@lst.de> <26796ED5-859F-4844-B1D1-7C2FF5126E40@oracle.com> <20220608075252.GB13027@lst.de> <F8EC1673-8434-4294-ADAF-96238E65A7AE@oracle.com> <YqDy0BIgLbAVRw2u@kbusch-mbp.dhcp.thefacebook.com> <20220609035323.GA31248@lst.de> <6ACB62F8-BFC4-45A3-9886-E05DB45248D5@oracle.com> <YqNRPEpZgT8Xn9Nr@kbusch-mbp.dhcp.thefacebook.com> <B396ED69-5559-40F0-92F3-8B319D90584C@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B396ED69-5559-40F0-92F3-8B319D90584C@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220617_020113_089177_2D432E8D 
X-CRM114-Status: GOOD (  15.06  )
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

On Wed, Jun 15, 2022 at 08:15:18PM +0000, Alan Adamson wrote:
> Here are my latest changes.  It includes an interface from nvme-cli to specify
> to clear the IDs upon connect.
> 
> Wasn’t sure the proper way to send a clear_ids argument to the target so I followed
> what kato did.  Not sure if that is appropriate for this case.
> 
> This will require a nvme-cli change and blktests changes.  I tested with both loop and tcp.

Well, it changes the nvme over the wire protocol, we can't just do
that.

And the option really is a target side one, that is we want to configure
it using configfs on the target, not the fabrics command line options.

That is, add a new clear_ids attribute to nvmet_passthru_attrs, save
the flag in struct nvmet_subsys, and default to true for loop controllers.

