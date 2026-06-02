Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1EECD6E60
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 12:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=39WEf6zIZHP5iGMMkNJQuPBwWYNkWeJT+8q0IqaVn70=; b=DhCgcJM9yS73X6G32WctM0N7pc
	EasRvv8ZyvREaKrTtnhKpNvWyu5RRWeToGi5aiRFwoATvHdr3ZV+9+xteoK/XqR0KIJgnXBk/GPQV
	+PMyH7jXoBX67jFt+k7LJUe9Qv15gpGZxtOb9YyxAhPozJimeSVJ1xehvHiyRzJb/je/fS+/5Ht5j
	h3Hj+FzEUI9Q9GUMMNdBpIQP1qsJzcUq1aFU7pD+41UyyFuE71FaOXNbraUb4Enh48e8hQSbXn/Uh
	aawBnZrnBPMTn7IS2EtVOptcP9SnuJ1ccTeAbY6d+7vJ8B1kg0l8xVF2Dw23jVkKm1mo6IqJnkhYT
	sfaYBJmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUODi-0000000Cyzn-2LRv;
	Tue, 02 Jun 2026 12:27:46 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUODg-0000000CyzV-1lue
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 12:27:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EBA6C43524;
	Tue,  2 Jun 2026 12:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB5C1F00893;
	Tue,  2 Jun 2026 12:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780403263;
	bh=39WEf6zIZHP5iGMMkNJQuPBwWYNkWeJT+8q0IqaVn70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KytPpwjSafLfL8lgUtnQ8xtkbT6KcgWmXjGDHTMnarQ4fhBoLIJF+p51zwO7WJhMp
	 sGzVEE5vuuf2s+1ZhCW1WSRPx9hJyog9bdcZECJ9yGJaiYDWdxM5P2mumpWDlj0M49
	 zNIYWvKll9ZYRrq3hLnivC1LWx9CgCGHlxdurcwG2fK+nvjkUNrv/vetgshV/dLcU4
	 lrAOBpFsKeoU39QCDdy+SGN+N8U4R8Owm8z7C4AVpg2Rtuj3DtHrSYEaicWtBvRZ+N
	 2liXLgnpaom5nRcDs795/9A1Arhv4mjMk2YC7w3E3konyhBTMdhRKpcPn0r51iJebC
	 i3r52Prlx6JKg==
Date: Tue, 2 Jun 2026 13:27:38 +0100
From: Keith Busch <kbusch@kernel.org>
To: liuxixin <gliuxen@gmail.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] nvme: fix FDP fdpcidx bounds check
Message-ID: <ah7MOp-cE0KqaW0i@kbusch-mbp>
References: <20260527133205.GA12042@lst.de>
 <cover.1779930057.git.gliuxen@gmail.com>
 <20260528083016.GB7073@lst.de>
 <20260528083043.GC7073@lst.de>
 <cover.1748418000.git.gliuxen@gmail.com>
 <a1e2f3c4d5b6a7890abcdef1234567890abcdef12.1748418000.git.gliuxen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1e2f3c4d5b6a7890abcdef1234567890abcdef12.1748418000.git.gliuxen@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_052744_480383_0BAFBB5B 
X-CRM114-Status: UNSURE (   8.36  )
X-CRM114-Notice: Please train this message.
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

On Thu, May 28, 2026 at 06:00:01PM +0800, liuxixin wrote:
> The fdpcidx bounds check sets n = NUMFDPC + 1 but used > instead of >=,
> incorrectly accepting fdp_idx when it equals n (i.e. NUMFDPC + 1).

Thanks, applied patch 1 to nvme-7.2.

Take a look at my omment on patch 2 and let me know if we should wait for
a new version for that one.

