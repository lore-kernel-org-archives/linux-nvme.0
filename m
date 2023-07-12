Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCE3EB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 13:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=734aVamIJkSX5gNhWvtok8uBNUQJ1O5QclH6etQliaw=; b=obwjSXcSgkDLqsRXDrWh/UE0o0
	Zd4dtudDwaSzx2I8zDoOM62ux3Zr9e0j3tO01ia1oZMP/kGUHWfeDuEpJyHP9CNW1CuD/bfOky/vO
	Rq8DpxZAG4iBH0cnonDlOp0DJmt+NUy5DMjKJsoaQQzp5COQzgDUg1HzwCU85cszgYJaHZfZDESRj
	pn2hUEJufplIdhfPy52CK/ixcukP1fvC21wRDsdeckcWzmbZs+gYV9Zdt4Jv7NBJEjwYeui8p+iu+
	nvZhiOIxqgVyPP/AU3KROHPG1YN4EXqBjXy9OEtlbZx/Gz2i4dIKOIOrFr919ITawcmp+no9hXFkR
	gxxN+lGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJZSL-0000fV-1T;
	Wed, 12 Jul 2023 13:00:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJZSH-0000e0-2v
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 13:00:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BBA8167373; Wed, 12 Jul 2023 15:00:17 +0200 (CEST)
Date: Wed, 12 Jul 2023 15:00:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Wen Xiong <wenxiong@linux.ibm.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/8] blk-mq: add blk_mq_max_nr_hw_queues()
Message-ID: <20230712130017.GA12417@lst.de>
References: <20230712125455.1986455-1-ming.lei@redhat.com> <20230712125455.1986455-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712125455.1986455-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_060030_107333_76F83D19 
X-CRM114-Status: GOOD (  16.14  )
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

On Wed, Jul 12, 2023 at 08:54:48PM +0800, Ming Lei wrote:
> +/* Max nr_hw_queues for each hw queue type */
> +unsigned int blk_mq_max_nr_hw_queues(void)
> +{
> +	if (is_kdump_kernel())
> +		return 1;
> +	return nr_cpu_ids;

Again, these is_kdump_kernel hacks don't make any sense.   The amount
of maximum available CPU needs to come through a proper API, and we
need to use it, not add hacks like this.

The only thing that makes sense here is to find the last CPU
in cpu_possible_mask, and for kdump kernels to ensure that number
is 1 or whatever low value they want.


