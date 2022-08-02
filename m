Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A5CC00140
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Aug 2022 13:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Q29rYz1LCtX7AYN8zfVxoDdH+Ca+UtYQdSVNjHbXKI=; b=JwYiF6pwHZlbuGxOO6U4KjCYu2
	NjI89MNzPKYQAwKDcboQzSdJSTZWCfCc8KOB7E1k2BZMAR0D6Co7w61uFruLXG/fYOSCrGZNeJGyY
	SioMMSlJFpVmjTUnAr1di9CoPxRbh47b8SuxB79kr3hRA2/xmAThplzSFpwFpbJmVtTEOvLoSfs0O
	sNthisCZlBLiQKkwBRYmH25b0zWT4lKYKX0OmzUa7JjBbtKOVa/00SDCBUlCbp0CnvMUgLN0CIxI/
	MaKVUn4PVvjibs5ECJi6stz2Zg+Cy1cJ7SK0g5E6Bj3nP+YZXdurLxz8bvJSg/v1BDkEQug1aSk6i
	zLd9w44A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIs2Y-00EUZa-KE; Tue, 02 Aug 2022 13:34:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIs2V-00EUVJ-At
	for linux-nvme@lists.infradead.org; Tue, 02 Aug 2022 13:34:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3D75E68AA6; Tue,  2 Aug 2022 15:34:20 +0200 (CEST)
Date: Tue, 2 Aug 2022 15:34:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	"Ewan D . Milne" <emilne@redhat.com>
Subject: Re: [PATCH] nvme-fc: restart admin queue if the caller needs to
 restart queue
Message-ID: <20220802133420.GA337@lst.de>
References: <20220721003358.543509-1-ming.lei@redhat.com> <20220728160637.GA19898@lst.de> <YuiGJdz/p8Csyk37@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuiGJdz/p8Csyk37@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220802_063427_548020_95AD3FB8 
X-CRM114-Status: GOOD (  15.71  )
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

On Tue, Aug 02, 2022 at 10:04:21AM +0800, Ming Lei wrote:
> On Thu, Jul 28, 2022 at 06:06:37PM +0200, Christoph Hellwig wrote:
> > Thanks,
> > 
> > applied to nvme-5.20.
> 
> Hi Christoph,
> 
> Looks not find the patch in your nvme-5.20 tree, :-(

I've pushed it out now.

