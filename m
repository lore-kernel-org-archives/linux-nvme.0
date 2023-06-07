Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986E3C77B7A
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 08:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sktQH5/gZchOE2ktuYmcp3qpPHa5uOw4gaXM3JxsGn0=; b=ESsP5d5doO/Z+wz8M/EKE+zB4w
	8vBwRuE5OVZJ3HHCiZfjCBC8Y1VS+DykBA3dlMcd7ctSfa6Bzg8ZJmFjJ7cvSP1EMGDbxMem5WJVs
	V6cjKmLmNaDblsBbmv6rvX+02H6PinVL4d/XPhMAAZaPkAMCgWqV12cL4EndaH+PJSssCh8+LNK/I
	fFZzztESKt33KOCTlw7dd4LNPfX0iVbaK7qG+U132SIkWn/Uv1yqxcseFTc1Ha6XU7D0d+vaGpMgm
	ozxwv0Y6yq1+WuNpmNTup5i4hXa8nzFxa0nTnOc7jlHlDWSXi/3S9MyFczSWP4+QMRBOYRzc1Xtac
	jaOHqs9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6p00-0056yf-0d;
	Wed, 07 Jun 2023 08:58:36 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6ozx-0056wm-1y;
	Wed, 07 Jun 2023 08:58:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 381A9635B9;
	Wed,  7 Jun 2023 08:58:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA18C433D2;
	Wed,  7 Jun 2023 08:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686128312;
	bh=ULzdhbcJeHPqQXgxbjAFPajJp4EhMC2K+LFc4KO7vAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QDgpcas10bhc6n+3tq+Tww3RU/1erBcAFvLdGNqmlHFWLpUff8UGptsIZjNJ5w8gT
	 KYA7ed+ki78rGbhq5L/pIz6djcKUzIgFySOylESb78Bo6dP+lYa+WimjJyqZa15c3b
	 1a4lMbl2TA4crdhAnzslPR1Iz130r59S9JasIE6AZsdKPxJjYPbAxErnPuZ4MNQ2GS
	 KGvt5cBHh6T/W5itlNub0ikJLxBe6iyEJiSqAGXrX+LiQTSGUC5G+HFALEh7g1JEED
	 Ql69+otxwsCqAC05NjZF31NRBQV7RRI+/YZWHju6mtccLdXuvkjFbYs/ytHfl1KO7w
	 qd67klAruXQuw==
Date: Wed, 7 Jun 2023 10:58:24 +0200
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
Subject: Re: [PATCH 20/31] scsi: replace the fmode_t argument to scsi_ioctl
 with a simple bool
Message-ID: <20230607-dates-innenansicht-78e76eea7347@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-21-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-21-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_015833_685106_6441BCF5 
X-CRM114-Status: GOOD (  11.72  )
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

On Tue, Jun 06, 2023 at 09:39:39AM +0200, Christoph Hellwig wrote:
> Instead of passing a fmode_t and only checking it for FMODE_WRITE, pass
> a bool open_for_write to prepare for callers that won't have the fmode_t.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

