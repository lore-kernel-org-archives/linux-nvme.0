Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DBFE77180
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 11:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kHSaIQ/JOUIiNa3sWHABw/dPRWHDyuBXN5og16LTzMs=; b=KdA2rP8qKoTygWc0kwVwhD8m2U
	dK194xeJYUJtWO7XsihSFlYuNguOv9CI5+2P3DVcPqRFX/T2Pa5AeMvE8u8Rx+ZmZyQIrKPQDQgxT
	SycNqzyhvfv3iYMAL1KVuHbjGC07iwCafQ1OgEURgLQ/nZ9/xX7iXC9xXYoWI69w+JbF56qnIlhYB
	yfLLg5FEGfcxW7DXHHRzTIqFqf7Zpgt2dOvb4Q4PiJVqx/cs4qrqae1b84GRu+yKEWYk9BrhoN1fU
	I02Vonkp9z2OA4FLYsV+AapWg4ggENpKs9V4R8Q3XYbnD72JCUSoNu6y92Ac8lGpza3AbBgzhCD3n
	OHHxWHmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKxzK-0000000BEnv-38UV;
	Tue, 10 Dec 2024 11:01:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKxwm-0000000BEJz-3HPv
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 10:58:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B1E4368CFE; Tue, 10 Dec 2024 11:58:22 +0100 (CET)
Date: Tue, 10 Dec 2024 11:58:22 +0100
From: hch <hch@lst.de>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: hch <hch@lst.de>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Javier Gonzalez <javier.gonz@samsung.com>,
	Matthew Wilcox <willy@infradead.org>,
	Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"joshi.k@samsung.com" <joshi.k@samsung.com>
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
Message-ID: <20241210105822.GA3123@lst.de>
References: <yq1ed38roc9.fsf@ca-mkp.ca.oracle.com> <9d61a62f-6d95-4588-bcd8-de4433a9c1bb@acm.org> <yq1plmhv3ah.fsf@ca-mkp.ca.oracle.com> <8ef1ec5b-4b39-46db-a4ed-abf88cbba2cd@acm.org> <yq1jzcov5am.fsf@ca-mkp.ca.oracle.com> <CGME20241205081138epcas5p2a47090e70c3cf19e562f63cd9fc495d1@epcas5p2.samsung.com> <20241205080342.7gccjmyqydt2hb7z@ubuntu> <yq1a5d9op6p.fsf@ca-mkp.ca.oracle.com> <20241210071253.GA19956@lst.de> <2a272dbe-a90a-4531-b6a2-ee7c4c536233@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a272dbe-a90a-4531-b6a2-ee7c4c536233@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_025832_959296_9EE8027A 
X-CRM114-Status: GOOD (  12.41  )
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

On Tue, Dec 10, 2024 at 08:05:31AM +0000, Johannes Thumshirn wrote:
> > Generally agreeing with all you said, but do we actually have any
> > serious use case for cross-LU copies?  They just seem incredibly
> > complex any not all that useful.
> 
> One use case I can think of is (again) btrfs balance (GC, convert, etc) 
> on a multi drive filesystem. BUT this use case is something that can 
> just use the fallback read-write path as it is doing now.

Who uses multi-device file systems on multiple LUs of the same SCSI
target ơr multiple namespaces on the same nvme subsystem?

