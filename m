Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E41C27C4F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Jun 2024 06:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GNfqQGqsIz/+ZkszIvGSJ1qaNasPf0UutTt+vN8anyU=; b=Jteqw94LBa2iZBJKtUcuCicjO+
	QWRvQYBnFbgEoE4OYCBTbGYjwHFLzkTI+q7CeaU5AoKQ6vyfnNX4IeiV6mZapbgb6u1IiY9mFOeHl
	/a76Z/1dVCbQmbmRxWs9SYYq0wIf14kP8u9uAQOF+045gFTzspDmGVMCwL88a5BDYF1m4V7VevRuh
	M7ySy4W/yW8zJtCI30qh6yp+h76sGgw3yUrsbJY07+nSfA0ui7K1exo+rVXe/d1ZWchWu53QG75hj
	E3mwiFHduzJq5rlZmSpnRnCc3MA5RXvwG08vzNlPbkZ7+GWihIVaM8sdtMVszhiIKBWJx+uPmPanA
	MvCtZFxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJSh6-0000000DsZU-1Bab;
	Tue, 18 Jun 2024 06:51:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJSeV-0000000Ds1R-3sa3
	for linux-nvme@lists.infradead.org;
	Tue, 18 Jun 2024 06:49:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5871867373; Tue, 18 Jun 2024 08:49:07 +0200 (CEST)
Date: Tue, 18 Jun 2024 08:49:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
	djwong@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com, willy@infradead.org, agk@redhat.com,
	snitzer@kernel.org, mpatocka@redhat.com, dm-devel@lists.linux.dev,
	hare@suse.de, Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH v8 10/10] nvme: Atomic write support
Message-ID: <20240618064907.GA29009@lst.de>
References: <20240610104329.3555488-1-john.g.garry@oracle.com> <CGME20240610162108epcas5p27ec7c4797da691f5874208bfcfa7c3e3@epcas5p2.samsung.com> <20240610104329.3555488-11-john.g.garry@oracle.com> <faaa5c15-a80d-339a-d9dd-2dd05fb26621@samsung.com> <2ddb92d2-97e8-4eb3-9c76-8c5438bb2a44@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ddb92d2-97e8-4eb3-9c76-8c5438bb2a44@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240617_234912_234490_9FCCBDB5 
X-CRM114-Status: GOOD (  16.49  )
X-Mailman-Approved-At: Mon, 17 Jun 2024 23:51:51 -0700
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

On Mon, Jun 17, 2024 at 07:04:23PM +0100, John Garry wrote:
>> Nit: I'd cache blk_rq_bytes(req), since that is repeating and this
>> function is called for each atomic IO.
>
> blk_rq_bytes() is just a wrapper for rq->__data_len. I suppose that we 
> could cache that value to stop re-reading that memory, but I would 
> hope/expect that memory to be in the CPU cache anyway.

Yes, that feels a bit pointless.

> Only NVMe supports an LBA space boundary, so that part is specific to NVMe.
>
> Regardless, the block layer already should ensure that the atomic write 
> length and boundary is respected. nvme_valid_atomic_write() is just an 
> insurance policy against the block layer or some other component not doing 
> its job.
>
> For SCSI, the device would error - for example - if the atomic write length 
> was larger than the device supported. NVMe silently just does not execute 
> the write atomically in that scenario, which we must avoid.

It might be worth to expand the comment to include this information to
help future readers.


