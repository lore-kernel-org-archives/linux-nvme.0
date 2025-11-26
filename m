Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39FCD1037B
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 10:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0bolAWAt1+CIoTAqV5rZAyXvVcZR5qoX5he4qL0mCh8=; b=CX+y3Y3lBrQPZXGl+nfA4XpXVu
	CTsomIDIlAPo+75+FIH4crrOs9JmhaCFSWsaqjLgm+5i5trYPfRdKOPpuKQpchdtBSipdUnYcrg7S
	IqRFz/dSvJSvyKabUXz78BQk6zaR2mBs7Jt45TMY+zKeL+O2DzvkODvj3hyfZC+ZnJHOJ5MjnjIW3
	Neo7xCOwMM9pzwrlX91rmxSxXbMc/sM819M2mcRmDCJJuEmUqXbmHQAFJX9j3rhI5mZcgr7Q3m1p1
	aY156uM6s+uPg3K23MBmv6dIvUHK9f+Mu4Wm9yTU5WvAr2kLGAXlASdIUt16tJBVJ4qly2lRxr29i
	+7ZdoKYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOCtY-0000000EoYW-0yDH;
	Wed, 26 Nov 2025 10:37:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOCtV-0000000EoXs-2b6I
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 10:37:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E56676732A; Wed, 26 Nov 2025 11:37:00 +0100 (CET)
Date: Wed, 26 Nov 2025 11:37:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk,
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
	song@kernel.org, yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, jaegeuk@kernel.org, chao@kernel.org, cem@kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	bpf@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH V3 4/6] nvmet: ignore discard return value
Message-ID: <20251126103700.GA28056@lst.de>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com> <20251124234806.75216-5-ckulkarnilinux@gmail.com> <e40cb47c-9f92-4982-bf3f-45ec9f2a1681@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e40cb47c-9f92-4982-bf3f-45ec9f2a1681@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_023705_798993_8175D070 
X-CRM114-Status: GOOD (  10.48  )
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

On Wed, Nov 26, 2025 at 06:14:32PM +0800, Yongpeng Yang wrote:
> We also need to check for memory allocation errors in
> __blkdev_issue_discard().

No, we still don't.  What is so hard to grasp about mempool allocations
even after repeated explanations?


