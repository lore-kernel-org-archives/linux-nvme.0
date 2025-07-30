Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AF0C87FCB
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jul 2025 17:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=LRV7xEuZqEWT3BgOJIs2g9YLiCVl97z3cyqzSd904nE=; b=IpDJol+vAhMj+A
	qBihdwMaJEP2+bvkwbshuD9ltYPiZoNXe2h3XARSgsvsltglIrqZsnID/sfQ9x407Z7hssug4Z1l6
	gcntofKC+o5HCUZG+FoQjhygA0n4LM2snl8MYIZ6+FVpyfaJti0d8dL8LTzsdmO5a26CdbYunOk9J
	JBG2QHoWlBg3S42bOLoIyn9y334U/uspLXpfFTcBMxnsEYXobWkkXwobNkUb59VUPhCF5gYcQHjta
	sc2TSmgz0cB47fkKuX9GcsGBPp+5AFRYlcwwKCHYnZ62HdDRzvqUyGeWwlLicKZjELO5NWYfa4QyG
	Zm1DrLNxGdpKFEvVxfVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhAPH-000000025T9-1RAd;
	Wed, 30 Jul 2025 17:15:59 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhAJa-000000024Vr-0UAL
	for linux-nvme@lists.infradead.org;
	Wed, 30 Jul 2025 17:10:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 304A3455B5;
	Wed, 30 Jul 2025 17:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD009C4CEE3;
	Wed, 30 Jul 2025 17:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753895405;
	bh=dJly3SiaFBKzG7wiQbJ+tNgWZh5VWDYDoYyY3crXU6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QYQ1kYKwl1y4Z+wmPpJp9SZcdNl5mQwl7EGZKF0Kdz5GicuVFrkahPHoDFt55KdZj
	 prEKLFDAKLSc6G4BdJGQidowOpOVhmkr7B/X2VnahJMB+wViwo/+I/atcucRxllwIg
	 xxxijrypaZZksMPKrSLmpcjWeS1+kbc+M+T49tbNvRVW88J1A9q+YUJevO554u1BUI
	 tGNn9eYhB47IB5qjmtdijJeA2LA0z3InvnhVmtJDIWNyFgN/K3nvSJcqYDNUEi4buw
	 S1990NoYUp/6cRyRkr3b87K4VsFbV7jiA70L7vOR3oJdI3dmypikTkX4FWgswgs+E7
	 X1+xxZJb301yA==
Date: Wed, 30 Jul 2025 12:10:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] nvme: Fix typos
Message-ID: <20250730171003.GA3369524@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730162321.GA22255@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250730_101006_175747_BBD18A72 
X-CRM114-Status: GOOD (  11.07  )
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

On Wed, Jul 30, 2025 at 06:23:21PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 23, 2025 at 03:27:51PM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Fix typos in comments.
> 
> This created multiple rejects.  Can you resend against the current
> tree?  If you don't want to deal with the nvme tree, maybe resend
> just before/after rc1?

Sure, will do.  I'll rebase on nvme/nvme-6.17 (e97c0040215f
("nvme-auth: remove unneeded semicolon")) now, and if that's not the
right branch, let me know and I'll redo it around -rc1.

Bjorn

