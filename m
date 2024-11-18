Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4430FD591A1
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Nov 2024 16:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xl6ZiI2PbFwne6S7fTd57V4uAf9Gqx8oVZ6eWzA7qZI=; b=glmBeaPZhabFdzqHl8oLJiq003
	gI3yGVj/OEdI8Kp6DYi+NBVpf962TeJlvGsH9/r1TLcxJW9UKcu2b4RG+tM8Ef1uJQ2a53UB8QUI6
	oKH5OHYbYNgWnCWyryL1cYYhITE4VZ+eE3sWbwQmTVVdnMCLo7I/L44M7Z0RFATicONJKZL5ymQoQ
	j/377MNYyJVdL2SPlAUH240U9FhOD7aRCbZIhkQ5b5fscpaBmTua4bykxqpQeG25CNlqSjwyK4Ic4
	axOFUzCXLvWfQ+t+udLT93SWF13TrPnFrPVy9kWdv2SAEk0gvZjeDUaL/8ydQR8MeH4T6amb76kEW
	awFSs2Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tD4cR-0000000A458-31e7;
	Mon, 18 Nov 2024 16:28:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tD4cO-0000000A442-2VUI
	for linux-nvme@lists.infradead.org;
	Mon, 18 Nov 2024 16:28:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 263EA68D12; Mon, 18 Nov 2024 17:28:50 +0100 (CET)
Date: Mon, 18 Nov 2024 17:28:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 3/3] nvme-pci: use sgls for all user requests if
 possible
Message-ID: <20241118162849.GC12281@lst.de>
References: <20241118155738.2737423-1-kbusch@meta.com> <20241118155738.2737423-4-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118155738.2737423-4-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241118_082852_774759_6E03994F 
X-CRM114-Status: GOOD (  15.21  )
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

On Mon, Nov 18, 2024 at 07:57:38AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> If the device supports SGLs, use these for all user requests. This
> format encodes the expected transfer length so it can catch short buffer
> errors in a user command, whether it occurred accidently or maliciously.
> 
> For controllers that support SGL data mode, this is a viable mitigation
> to CVE-2023-6238. For controllers that don't support SGL, log a warning
> in the passthrough path since not having the capability can corrupt
> data if the interface is not use correctly.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


