Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379CDD75BBA
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2024 04:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PVTU19XXSVY7UlVaLaj149eRwdVFbApD/P8A55SEq2U=; b=FAV3KERfe0/yBQ+7CC0iHtpkdR
	Zz9w5HaMP64P3tKqmlCdT3I8pS+FGWG5kmy3Y6LLY5OGQXfPo/SG2AgiVhE8IOPpDgL3F5HwuqWQP
	gtM3d/EFEuWci8i8O11HHQglJphlLYJcT5gXV9JgqWSK7ck+dlhkwC5P6eK94RFLXUzq+3q7Z6M5R
	nyV3im6Vr+fuQkQY7VH00yTirYbFJaSRDHdVPv9XWeA1M11kPkWSPYAnpU1CJ7abaezYzXSD93l+l
	mM/DCpo0hTL3NNG+Ivlyzn6UWqftqfGVSKA2WPjamR4YchGjEQoNkRcmhwuVmE+gEZ0L8B0jDrYOJ
	U90SHxRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDzFp-0000000Gpd5-0hBo;
	Thu, 21 Nov 2024 04:57:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDzFm-0000000Gpcg-3wz2
	for linux-nvme@lists.infradead.org;
	Thu, 21 Nov 2024 04:57:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CC6E968BEB; Thu, 21 Nov 2024 05:57:14 +0100 (CET)
Date: Thu, 21 Nov 2024 05:57:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Paul Webb <paul.x.webb@oracle.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [bug-report] 5-9% FIO randomwrite ext4 perf regression on
 6.12.y kernel
Message-ID: <20241121045714.GA20680@lst.de>
References: <392209D9-5AC6-4FDE-8D84-FB8A82AD9AEF@oracle.com> <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com> <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241120_205719_123512_F59815C8 
X-CRM114-Status: GOOD (  13.57  )
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

On Wed, Nov 20, 2024 at 06:20:12PM -0700, Jens Axboe wrote:
> There's no way that commit is involved, the test as quoted doesn't even
> touch write zeroes. Hence if there really is a regression here, then
> it's either not easily bisectable, some error was injected while
> bisecting, or the test itself is bimodal.

ext4 actually has some weird lazy init code using write zeroes.  So
if the test actually wasn't a steady state one but only run for a short
time after init, and the mentioned commit dropped the intel hack for
deallocate as write zeroes it might actually make a difference.

To check for that do a :

/sys/block/nvmeXn1/queue/write_zeroes_max_bytes

with and without that commit.
 

