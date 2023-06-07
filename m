Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1BBC77B7A
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 09:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t4qHSZMzs3GXEE/fiVPPs4Q+ZH4rYSYVL24l6cHecBQ=; b=flwnkV2mJCjIglC6fABVO2FI5O
	YOiyVxc+qw3N1QyaLyf5DyTspWCZHBqCn5CI/UlLXrsPFqlt4M//pYcc0dtX9S3PJzdkClIvd5nSX
	cT0mlmUT5SJbIyF+Hr8dcpPrvwo5PMP949JT8ZPITZscoC4yvLHfiWLGIcMv5UODDD70qA3IGioKl
	MEA5H0ffFlj7MBRmoPVFmlsSZmuaTRGket5Koms7gs51cnCU5Ixe41mVKkv6B4C6PnGDGbRMaXBW5
	9CHEZ71mL/lTuu+sPHJ+Xeq9lU1Wex+jRIErtj1TBlCw1Sdgaz5wx6Uxc0W9qbKC3t2zoHYmOejor
	5ol6MGVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6p1o-0057iQ-1Y;
	Wed, 07 Jun 2023 09:00:28 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6p1m-0057h8-00;
	Wed, 07 Jun 2023 09:00:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 80F3863C9A;
	Wed,  7 Jun 2023 09:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6B9C433D2;
	Wed,  7 Jun 2023 09:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686128424;
	bh=M5xM1l9LuXkX4mSzz59D4IdQFYmmNTr6OfgkeVyfa04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bkgRvGgC50EeuypHe3xl97j+bK6/ZhC9326XXBYH1ZIWYaQ5jbu1O85bi3HGmv9M+
	 hZ2SFMqNmWRyraR3Jgx4RRg8awjy8xDqCx+4vNdQpqr+khy+3Nr2thG3oUeGWCmFLy
	 XyvLCHm2vTS/PPKFg0NhX/7Rvav0gZ/EJtvHCBmt00R9oRm3Ttf4E19bdvBrMVREuf
	 /zBjY37bjH2obx9yTShQpHDAYvGzclq+GoqwGhXKZinmsKkN75qgYYwu5ZHTg6eiYP
	 J5jVActoZkfoLY/PBMoBsxKMx6RMvbVXquwF1Lct1mLaflpQuIgCkcbVYTKwI3tb6X
	 079ePZ3MnBG6Q==
Date: Wed, 7 Jun 2023 11:00:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
	Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
	linux-block@vger.kernel.org, linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 23/31] mtd: block: use a simple bool to track open for
 write
Message-ID: <20230607-exakt-fahrzeit-31037992dd33@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-24-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-24-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_020026_073831_501FDA17 
X-CRM114-Status: GOOD (  12.35  )
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

On Tue, Jun 06, 2023 at 09:39:42AM +0200, Christoph Hellwig wrote:
> Instead of propagating the fmode_t, just use a bool to track if a mtd
> block device was opened for writing.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

