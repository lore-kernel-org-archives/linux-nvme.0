Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AFEC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jan 2022 06:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tGDCpE3aR9tLPdXJwcldiyZzf4tRT3+cr3TZYEIx6+c=; b=arRvO9UEgmTwIh4ZYHWY+saOUH
	6snDqxDthxdX2JZEqNvo6HWAd74xxtPtw9EBxluQ3uZuLnzTsV3megu3aRN6mBT8KcskSwfzi3X5s
	nWBihwH7h2djGgBoDRAynTPQpZZnBdYhRsivUpbuE7DkwQ87rHaN2dWYfDPcy4MawEfeBd4KNY6js
	6/uX5yV/9CSpWbr9P9YK2YjeSnssiJovAbXqIkCBoBaTL6yTcJF3nGQZE92f4hkHtCGYzJg6dHn5r
	f/q/PxRrXUWD7sbmcKFb1HELRSFhLNf7LuAP2b4EalGIjXvMNbPUfsrJHNqctH0fFihP8xVXpSwOd
	idiYGGFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCF9J-006Y0P-2x; Tue, 25 Jan 2022 06:17:49 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCF9F-006Xzt-Kh
 for linux-nvme@lists.infradead.org; Tue, 25 Jan 2022 06:17:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E9A0B68C4E; Tue, 25 Jan 2022 07:17:42 +0100 (CET)
Date: Tue, 25 Jan 2022 07:17:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH V2 10/13] block: add helper of disk_release_queue for
 release queue data for disk
Message-ID: <20220125061742.GB26495@lst.de>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
 <20220122111054.1126146-11-ming.lei@redhat.com>
 <20220124131624.GI27269@lst.de> <Ye816Xu9gPU7Q8Ug@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye816Xu9gPU7Q8Ug@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_221745_856866_015F8AC0 
X-CRM114-Status: GOOD (  18.73  )
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

On Tue, Jan 25, 2022 at 07:27:37AM +0800, Ming Lei wrote:
> > Please explain what "queue data for disk" is, and why this helper is
> 
> Here it means elevator, blk-cgroup and rq qos, all actually serve FS
> IOs, maybe it should be changed to FS IOs.
> 
> > useful.  Right now it seems to just move a few things around without a
> > rationale or explanation of why it is safe.
> 
> This patch just moves two function calls into the helper, and there
> doesn't have functional change, so no need rationale and explanation.

Yes, it it does.  If you move calls into a "helper" that has a single
caller and a weird name it better have a good explanation, because the
move does not look useful at all.

