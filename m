Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FB4C5ACC1
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 16:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NxM9c7ASLNiIIr+2XJ2oSLibXodrYBlv7GcD7JfdqD4=; b=iaVaio7ODZ3pc4VzS0bRMM73MQ
	5eWoYrebMFzVdhyghq3WiZtYqjxCucwtCdcHS0v//AqiS2q34pYb/yQvbdobNNnNq7J8Ui82MFEA9
	nU0GX2whqwxnAgVL2SY0MZ38nJVL3vsCgqC2NuZMvVeuhs5XTxYXLiYZ6VSOjqaP3pPxR9DmwnorI
	UElEoqjxyaGsjh0B9xt/RZcZMh1OWeI/nKvgV0zNzuXhfiGTKXerl5cKJna8Ay504DnLlxWqf970R
	ga0E7daIHO+9yU6DWMXjshK0EzMv8aWoqL7kvTtGL+ABLT2qiDR8Atp4cX2E31Vu7aRAOHbZm89KO
	QWfMm80w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtT1g-0000000FATi-2lj9;
	Fri, 20 Feb 2026 16:06:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtT1e-0000000FASa-04C6
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 16:06:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B5D3068B05; Fri, 20 Feb 2026 17:06:39 +0100 (CET)
Date: Fri, 20 Feb 2026 17:06:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] nvme: add preferred I/O size fields to struct
 nvme_id_ns_nvm
Message-ID: <20260220160639.GB15071@lst.de>
References: <20260220032809.758089-1-csander@purestorage.com> <20260220032809.758089-2-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220032809.758089-2-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_080642_194271_96E6A32E 
X-CRM114-Status: GOOD (  13.12  )
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

On Thu, Feb 19, 2026 at 08:28:04PM -0700, Caleb Sander Mateos wrote:
> A subsequent change will use the NPDGL and NPDAL fields of the NVM
> Command Set Specific Identify Namespace structure, so add them (and the
> handful of intervening fields) to struct nvme_id_ns_nvm.

Looks good.  Btw, as the kernel now has a the global scope static_assert,
can you add that too any on the wire format struct you touch to ensure
our modifications aren't changing the sizses?

Signed-off-by: Christoph Hellwig <hch@lst.de>

