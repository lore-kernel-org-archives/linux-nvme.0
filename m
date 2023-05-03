Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5B5C77B75
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 05:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S+TVkVEYU53AKl40tkWNytsipqxW5p/cGgtCl8Qz53A=; b=r5Fe1l7LLBXP8yrlco0mN9MnK8
	awb5Elpg18lwZZbQQ1J+RsYLnMUQcqbCc53+TBC/GsRXLq0O4uuEP+ZVoWXkub96Nf4ZB4vvk1qof
	g6rsgvpEkxCQrAqEgl1xdVxirwQHpHs8RhTyviWwhuTAiQ9/G1rQG8WFpHmmnXjYgafmSn4nq7jHq
	kAHlg85v3SHK1Y33RQcXSBqc/AutvuUMFuXo018Yhvy14QY1Od3FCReFOUoVIR6ZHoaBlKAXmXqow
	YRuCzOE3kVF/8MniOw/yt42aarNIfV+3y6XE+cczFYti+bce/s8jzPYSo0RAL/6Plj+fUUxEwzCOv
	dO9vk/8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pu4fm-003MCb-0x;
	Wed, 03 May 2023 05:05:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pu4fk-003MBi-1q
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 05:05:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DB11368AA6; Wed,  3 May 2023 07:04:57 +0200 (CEST)
Date: Wed, 3 May 2023 07:04:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	joshi.k@samsung.com, axboe@kernel.dk, hch@lst.de,
	xiaoguang.wang@linux.alibaba.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC 3/3] nvme: create special request queue for cdev
Message-ID: <20230503050457.GB19301@lst.de>
References: <20230501153306.537124-1-kbusch@meta.com> <20230501153306.537124-4-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501153306.537124-4-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230502_220500_746359_31780661 
X-CRM114-Status: GOOD (  12.08  )
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

On Mon, May 01, 2023 at 08:33:06AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The cdev only services passthrough commands which don't merge, track
> stats, or need accounting. Give it a special request queue with all
> these options cleared so that we're not adding overhead for it.

Why can't we always skip these for passthrough commands on any queue
with a little bit of core code?

