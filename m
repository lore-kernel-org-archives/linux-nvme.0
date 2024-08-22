Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6436C531DF
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 06:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sln05SP9VyeXBACU/NftwIWX+1yMzr8oh6Ot7wGCpZg=; b=YE1rirqI6tZn5LA+1jMp2plswY
	mIkLMqHTCayuibkdcNX0TYGm6uqzo6Mml4fNIOZ/oO5AYvYwUn6tUUxQsBX8L36kkx5CTFCqFeVdQ
	16g3F+zmh2lbAYMMqGvDc6/ROcyTMHJf9qOhlbbhNc2nRS3yekeoZf7IXf88mH5a6tkdk10mLOceu
	Jtj9RWRAAbAZ5LQBCw50Xb+QUnYfLnfGXE0feDYxKGioPFL2PzAreE6ey7e88PUWvjI7t7pX5Xcif
	56ynxMjh0DuFE2f/ahUmuFrT7mzVqCz0FgVjZa70c9Kd/cX/UOs0kxjkMMRkdrzqXlIfqlB3ZUPqa
	vasImygw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh1kN-0000000Bj2S-0oTM;
	Thu, 22 Aug 2024 06:56:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh1kJ-0000000Bj0Z-38gs
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 06:56:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6FF29227AAA; Thu, 22 Aug 2024 08:56:30 +0200 (CEST)
Date: Thu, 22 Aug 2024 08:56:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: return 'namespace not ready' for disabled
 namespaces
Message-ID: <20240822065630.GB3141@lst.de>
References: <20240819122917.65313-1-hare@kernel.org> <dc3d279d-58a9-412b-9cb3-cc51297f65ba@grimberg.me> <9e1839fc-5b8f-435f-abde-e8fb1bd9b60d@suse.de> <94e2d189-28dd-457b-af17-8a21efbdf744@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94e2d189-28dd-457b-af17-8a21efbdf744@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240821_235635_950561_04FA2026 
X-CRM114-Status: GOOD (  16.80  )
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

On Mon, Aug 19, 2024 at 05:22:18PM +0300, Sagi Grimberg wrote:
> subsystems in nvmet based implementations are not limited to a single 
> server.  The originated reporter ran a subsystem over multiple hosts
> with drbd as the backend.
>
> In this case, disabled NS does need to signal a path error, and hence why
> a path error was chosen.
>
> If you want to change that, please make sure that io failover works as 
> expected in this case as well.

Exactly.  nvmet_subsys_nsid_exists indicates the nsid is configured
in the subsystem, so NVME_SC_INTERNAL_PATH_ERROR is the right error
to return here.  For the !nvmet_subsys_nsid_exists case we already
return NVME_SC_INVALID_NS, which is the correct error if it does not
exist.  NVME_SC_NS_NOT_READY is always wrong.


