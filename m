Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3BFC4332F
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Nov 2023 15:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pa2TlVlFBbaK2GszIzs8Vja/dLxXSyKi9hlTKMmemZU=; b=gzyj1cXAwJorTbiojTU9VTjSCB
	jOIOJgoFcyWAqMvUUeF7WLalMUVSTSrBaSNXF9dWcWarB6PvEsXFdYOy9lBdrxX5GJvwri2B4fm8Y
	uxgZzWPYzrMlVq6Uu54eYpdXFAiYOWVfdnBHKo6Zc5S/CGgRUdOhmlHJiLzQOlY62TWre52GEvMRD
	ffY4IEWOHFTbk7ojiMzu6tH9K8dCKU7+P0AHV2/uNYgGwV950Z8QIb+a3lXLlkooH7UXOoUuXfmB7
	K3iFYWoYU9XieumJGxyguVgHr3Wldo7BtQGhsSYXeKmXnB/8QPsmNpH0/XQv1omgW6bWF88sey4Yc
	VYikkjQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r16j9-006Ymm-2u;
	Thu, 09 Nov 2023 15:13:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r16j5-006Ylu-10
	for linux-nvme@lists.infradead.org;
	Thu, 09 Nov 2023 15:13:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9B40967373; Thu,  9 Nov 2023 16:13:43 +0100 (CET)
Date: Thu, 9 Nov 2023 16:13:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 02/21] block: Limit atomic writes according to bio and
 queue limits
Message-ID: <20231109151343.GB32432@lst.de>
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-3-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929102726.2985188-3-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231109_071347_494476_B2DAA0DC 
X-CRM114-Status: GOOD (  15.90  )
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

On Fri, Sep 29, 2023 at 10:27:07AM +0000, John Garry wrote:
> We rely the block layer always being able to send a bio of size
> atomic_write_unit_max without being required to split it due to request
> queue or other bio limits.
> 
> A bio may contain min(BIO_MAX_VECS, limits->max_segments) vectors,
> and each vector is at worst case the device logical block size from
> direct IO alignment requirement.

A bio can have more than BIO_MAX_VECS if you use bio_init.

> +static unsigned int blk_queue_max_guaranteed_bio_size_sectors(
> +					struct request_queue *q)
> +{
> +	struct queue_limits *limits = &q->limits;
> +	unsigned int max_segments = min_t(unsigned int, BIO_MAX_VECS,
> +					limits->max_segments);
> +	/*  Limit according to dev sector size as we only support direct-io */

Who is "we", and how tells the caller to only ever use direct I/O?
And how would a type of userspace I/O even matter for low-level
block code.  What if I wanted to use this for file system metadata?


