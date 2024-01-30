Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B99C46CD2
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 14:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KYY7Dj7K4sDD+lSkPQKDjSXASQ0h9KLRFhA8O+W5AI4=; b=z+FGk1Tov98T0F25RLIg1AdYYW
	+sNfNAcQjWho3Hs2Jh7BGKn8PNkvq39sWJpWxiUL8ttXcZXcymvWgZkzmr/RKcO/8vuQ0ELAa3zB3
	q+izZWE++Q/0uaHgmsrCM9FZ643YzZFu+uMwlmpOkRNjyhUraMMjiEmMFnelzXAxpd4N5cX2fgtLW
	vAlEH70xY5pq8enVUUeZ71z6Nad8erzNK9XuGR1ebCsD2b+1nQ8/Wu3zzb64/EcEVDncMkiRnjiG1
	1MfJZTsp6GzWrDTJDUd0F0f92bpG4KIe7xQanUK6TJWHPdrqcpyfqoiYZazLGrLifRgG0DVvwooy2
	/+OS104Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUpKZ-0000000H0p3-35qH;
	Tue, 30 Jan 2024 14:43:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUpKW-0000000H0oH-3Pxs
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 14:43:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 112CA68B05; Tue, 30 Jan 2024 15:43:14 +0100 (CET)
Date: Tue, 30 Jan 2024 15:43:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 04/14] block: use queue_limits_commit_update in
 queue_max_sectors_store
Message-ID: <20240130144313.GB32125@lst.de>
References: <20240128165813.3213508-1-hch@lst.de> <20240128165813.3213508-5-hch@lst.de> <e65301d3-7274-45fa-a64c-5039257aa333@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e65301d3-7274-45fa-a64c-5039257aa333@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_064317_011815_71D42CDE 
X-CRM114-Status: GOOD (  15.56  )
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

On Tue, Jan 30, 2024 at 12:14:32PM +0000, John Garry wrote:
> On 28/01/2024 16:58, Christoph Hellwig wrote:
>> Convert queue_max_sectors_store to use queue_limits_commit_update to
>> check and update the max_sectors limit and freeze the queue before
>> doing so to ensure we don't have requests in flight while changing
>> the limits.
>>
>> Note that this removes the previously held queue_lock that doesn't
>> protect against any other reader or writer.
>
> I don't really get why we specifically locked that code segment in 
> queue_max_sectors_store() previously. Was it to ensure max_sectors and 
> q->disk->bdi->io_pages are always atomically updated?

It's been there basically forever.  Back in the day before blk-mq
and lock splitting it might actually have protected something.


