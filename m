Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2692C4829F
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Feb 2024 07:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+RJUMaQwvclUiG3Yzr4BSVgkgBJgMpbFKrfpIupa2sI=; b=kQsMdu9VxLhpZU15tt1yb1CRbd
	4cwuGuwEJAViJXshiECVfq+lw/9Id3JizH6rMQKLXAcfFWGRTgx4e7VyOD8sqQdw3lDQ2+l1ttMaQ
	cjfQlikQBc0aghKkA7/ZZLb58F5qtxVgkXOVFn1+MrVkXsECvqxKyjlHH44gNB+SGNPCH4T93wbjG
	2Y4QdYtU4vx+zY4FerajIm0Gy/Ndyc1XvUuxBZv4ABdFJsNE6tXPcjYypZuI7PsIKn5D24tcp8KOl
	xju+lfDT8u9gTVG5egJTE6qig65NBneVZQ854cmGVmSuQBRJWOgbtLw0mMkTmFRXEuNMgENcSyiMt
	3mtCnu6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ra9f0-0000000C2sX-0pta;
	Wed, 14 Feb 2024 07:26:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ra9ew-0000000C2pe-0LnU
	for linux-nvme@lists.infradead.org;
	Wed, 14 Feb 2024 07:26:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 54133227A87; Wed, 14 Feb 2024 08:26:10 +0100 (CET)
Date: Wed, 14 Feb 2024 08:26:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
	djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, ojaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v3 07/15] block: Limit atomic write IO size according
 to atomic_write_max_sectors
Message-ID: <20240214072610.GA9881@lst.de>
References: <20240124113841.31824-1-john.g.garry@oracle.com> <20240124113841.31824-8-john.g.garry@oracle.com> <20240213062620.GD23128@lst.de> <749e8de5-8bbb-4fb5-a0c0-82937a9dfa38@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <749e8de5-8bbb-4fb5-a0c0-82937a9dfa38@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240213_232622_293194_BD64CC7D 
X-CRM114-Status: GOOD (  13.63  )
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

On Tue, Feb 13, 2024 at 08:15:08AM +0000, John Garry wrote:
> I'm note sure if that would be better in the fops.c patch (or not added)

We'll need the partition check.  If you want to get fancy you could
also add the atomic boundary offset thing there as a partitions would
make devices with that "feature" useful again, although I'd prefer to
only deal with that if the need actually arises.

The right place is in the core infrastructure, the bdev patch is just
a user of the block infrastructure.  bdev really are just another
file system and a consumer of the block layer APIs.

