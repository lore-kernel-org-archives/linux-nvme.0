Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16178C83F1A
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 15:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZbFf9JDCsd1WQM8Bw2XZ8/R/LepGVpQH6YHCMwiKEbY=; b=eCpbZTKtLuPtCbtUb3AbqOBI43
	MQY97E5WGhvX/rsEmiy8yu2d7ROTgDNgWPJSGeHULle2bwJ76jdkTJ3vl+HaGfkj8/ke70KHKPlbh
	jgDn/nObf0x7bepPtaMU2NggsPzL1g7zHFO85tHjvohj4v92ZRelQitRRyQvNfc7eqzCj7MukDXaF
	2hyXekHfh8AL2qzyfFu/qr6QmAHpqjypJPUKYD48MmjDR/nVsh2zcaYFPk31XMtWVTV/cg80faY0l
	bI6HkX2/MfnwFQrcnRCuVnVoL0sFAsGHVohMnfaamDOW+DM85O4TRGgr+prHrY+jYqNoUDprX3dEZ
	UPZxGPYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubLIy-00000002ipU-2fI0;
	Mon, 14 Jul 2025 15:41:24 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubKV3-00000002WLt-2OEr
	for linux-nvme@lists.infradead.org;
	Mon, 14 Jul 2025 14:49:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7D5735C628C;
	Mon, 14 Jul 2025 14:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C81C4CEED;
	Mon, 14 Jul 2025 14:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752504588;
	bh=f25iqxvfV9dJzUutA3u087TPgzbwLvIiEBcCf+GFU5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uupPO1LNca+9hkzBNGgzFduH64LTLX6NPnRFGaCBAxgv+phQLgUoSiIEMWiGiZmXD
	 XBUS8bLD8HusAo4u1QcSwGB8xVDLeWSdBCM65hCIiSPtzJWX7pGDa4MWwEW+zGRDhU
	 kOzRc4nGsSgTdDUjsCAz1P9jO21VkjalUM90Q74VkuzNo47b+bJc5fhqVHbvL1KjQo
	 Hav5eU2E5BGK3OdleqGXQcL637n15fS/VKSQundM2TEcTfCJXDqJbpnh9hs/LN/iuU
	 xIkUyFeGdGK17N3lwffC3liUGsT6fV8yz4qgwdhsnWAH01UuB7J7xEEWvUgiafaHUp
	 IhkS/qDKWEHyw==
Date: Mon, 14 Jul 2025 08:49:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>, yi.zhang@redhat.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: revert the cross-controller atomic write size
 validation
Message-ID: <aHUZCbSJUjUPPBf9@kbusch-mbp>
References: <20250714144406.1692041-1-hch@lst.de>
 <20250714144406.1692041-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714144406.1692041-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_074949_650464_E91C4831 
X-CRM114-Status: GOOD (  14.18  )
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

On Mon, Jul 14, 2025 at 04:44:01PM +0200, Christoph Hellwig wrote:
> This was originally added by commit 8695f060a029 ("nvme: all namespaces
> in a subsystem must adhere to a common atomic write size") to check
> the all controllers in a subsystem report the same atomic write size,
> but the check wasn't quite correct and caused problems for devices
> with multiple namespaces that report different LBA sizes.  Commit
> f46d273449ba ("nvme: fix atomic write size validation") tried to fix
> this, but then caused problems for namespace rediscovery after a
> format with an LBA size change that changes the AWUPF value.
> 
> This drop the validation and essentially revers those two commits while
> keeping the cleanup that went in between the two.  We'll need to figure
> out how to properly check for the mouse trap that nvme left us, but for
> now revert the check to keep devices working for users who couldn't care
> less about the atomic write feature.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

