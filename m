Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6540FCA0EFA
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 01:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hG48u4MqQQ7X1N5zQvGdhe4iy3lSXeVJKhAVGMD5Lxs=; b=nFTIXc8JBUVnibEGkpedmdoM01
	LShwcVmJGdLCH70NxvkdqI2qCQ8nAZxxbF/cyYtwUQrI0vZFR9HIXtWrFmxy/w1cdd6IP30DhUJHz
	Q6DMTZdI9nFiDVOUpAysEKd0Y/YhHlgJM5zTVNp22HMDr66/m9B3KYSECVWAjXkbHvcQMK/M3qHgn
	MUsXL7gMguQf1M+UFqL3Sb4joFcjNO/NcBOktGl751hhwXkoIBeuVgVLEB2AxwDowKUX7SL9E2WTo
	FeWzjZiWwZRu8LbZ2WR44mS4H2Dk9tZv8PpVarPhMV7Gf0UGWFmEkfGIuCwayFTJ/VxDlsL9ekmFn
	X5Y4XKKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uotwe-0000000FQJY-1hoe;
	Thu, 21 Aug 2025 01:18:24 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoqi2-0000000F279-37ph
	for linux-nvme@lists.infradead.org;
	Wed, 20 Aug 2025 21:51:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 84327A5780B;
	Wed, 20 Aug 2025 21:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A885AC4CEED;
	Wed, 20 Aug 2025 21:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755726665;
	bh=iNwtBYePNA83SA5pocE4fjOSvyILpdaCkYud2gMR2lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZNoSs+gQ9tEFIzJZ8Vl1TiQSfqBduFjlvUC1EdpzqPHY3j+ANOKNJBQK9Q7g2V7ZG
	 2GPnCPbYuDdUzvCUo8/EXN0C6DTd3nKWLlBgER/Sw4/UceqZChM1x74kooLTMwxA9x
	 ok0HeWLDoknz3R6+PVfRp8v9uzg/LdwuobC4IU+NcIvNgBjc2Nm/52qVONq1Q6IYG2
	 YblDxZ+GgwR94GCedT0MzPVy7O0ITBl5tHKRqOv6AB29G9RXgCOmwg9fPiLZTFfKPs
	 Ri4JhocvjbhmB9rLECeIOor3hX6EFDAUOTswGKJTl4AbYAlinV34I8POQN0IZb6+YX
	 qVtO8f+V62ueQ==
Date: Wed, 20 Aug 2025 15:51:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, nilay@linux.ibm.com, martin.petersen@oracle.com,
	djwong@kernel.org, mcgrof@infradead.org
Subject: Re: [RFC PATCH] nvme: add an opt-in to use AWUPF
Message-ID: <aKZDRrfUTxJoFA1m@kbusch-mbp>
References: <20250820150220.1923826-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820150220.1923826-1-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_145106_855388_DD80127B 
X-CRM114-Status: GOOD (  10.02  )
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

On Wed, Aug 20, 2025 at 03:02:20PM +0000, John Garry wrote:
> It would be preferred to stop honouring AWUPF altogether, but this may
> needlessly disable atomic write support for many "good" devices which
> only specify AWUPF. Currently all validation of controller-related
> atomics limits is dropped.

These "good" devices that only report AWUPF, is there some set of
characteristics that generally applies to all of them? I tried to list
out conditions for when I think the value could be counted on here:

  https://lore.kernel.org/linux-nvme/aGvuRS8VmC0JXAR3@kbusch-mbp/

I just don't know if you know of any devices where that criteria doesn't
git. If not, maybe we can work with that without introducing more user
knobs.

