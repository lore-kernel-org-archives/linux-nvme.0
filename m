Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70930C79F82
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2026 19:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ou5xEo7iAzlKd3AVMCKn53kWM87UjDDrbXoKJa4e2ok=; b=gvdmPOrAYINhHBIx5/ZrsZLhQu
	HDhrEfflYf6f7sAtvv/u13p3NFwSgKXrBt550zgYeLlK2kBDz/UvWRr3gN1R3halPVKxq9aqRFjEd
	6p62jlkLxCyFGSxmXf86zNg9a01VOGNDhbXcuE0y3Tcv2AJXu+zjHxJuV65APPm2v2KEiaJ+uPrnu
	zKjULKgxYIBqTF0QICBFoKhS3gfpm81wA7XDMMMLrlYsb4k0DT5a4z3tq1OJOtN5nD77G1qfM3K4/
	FoOH1mDwgYXAtdt1cD8BVdFrVg+v5nrb1CWzfHTFL1tlADFhX+J9HmaeJdkApndC7762cgu6+8+Fy
	hRgdz1aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x41wY-0000000A7MC-3R5C;
	Tue, 08 Sep 2026 19:57:22 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x41wW-0000000A7M5-37WV
	for linux-nvme@lists.infradead.org;
	Tue, 08 Sep 2026 19:57:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 23579601DE;
	Tue,  8 Sep 2026 19:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB6B1F00A3A;
	Tue,  8 Sep 2026 19:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788897439;
	bh=Ou5xEo7iAzlKd3AVMCKn53kWM87UjDDrbXoKJa4e2ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GNHmohf1u7VomUt1hIYokXhiRrcZQLjlVnOa3qigQ9rBF3uPcA6LcfFSN74luKoPS
	 j5I2D7S1M6qu81n9pq3lh9kJ8gMODoJgAXnsLiBRaaNHzXkZQFH8MjTPd6BVr5bO0W
	 n2FGrM+/J6XeDHxNvu+6WsPXxnGJ1kXIU4nciB7A24ETB6TzaS6A73IA3qnTflf3C1
	 bZaq1XchaMqH5V7cdg+yGIx8yw4rczQB7GHXb6QE9JkBlXnK4Fn1myuUt6FprNOqpA
	 R5t40vIoISnOWc20xwfvLiFpyJFQ/T+mIrePbAIdmFQQiTX1xKFleE5R9oNXsqhuE9
	 0AHenQNI6puXg==
Date: Tue, 8 Sep 2026 13:57:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: pavankumaryalagada@gmail.com
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	syzbot+6c46a179b56c651c4c96@syzkaller.appspotmail.com
Subject: Re: [PATCH] nvmet: validate device_path before enabling namespace
Message-ID: <aqBonYN7WeEn26JZ@kbusch-mbp>
References: <20260908193452.53347-1-pavankumaryalagada@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908193452.53347-1-pavankumaryalagada@gmail.com>
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

On Wed, Sep 09, 2026 at 01:04:52AM +0530, pavankumaryalagada@gmail.com wrote:
> From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
> 
> When buffered_io is enabled, nvmet_bdev_ns_enable() returns -ENOTBLK
> without checking whether device_path is configured. nvmet_ns_enable()
> then falls back to nvmet_file_ns_enable(), which passes the NULL
> device_path to filp_open() and causes a NULL pointer dereference.
> 
> Validate device_path before attempting to enable to namespace and
> return -EINVAL when it has not been configured.

This was alraedy closed:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=09d0c07bd9ce3b2f2d993f672698d32a17543c32

