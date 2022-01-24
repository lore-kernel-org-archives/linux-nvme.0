Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE51C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jan 2022 13:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HWYSkv6I7aeuJv6BAu7D2hACx+8LHtIekRMhQ+2nvPE=; b=D7M4s8gejmd/XM3NzCTcnX8m2d
	4wevP99EqAzSUrKnO0EKvKocGp5U080V+DIiTcwRqWuQSRf6gy1HtQOctF6iMBW4geN3D75mgwaj3
	MwjrxRh2nrtyI5mMln36mhZpeDWBj4sGH7b9L5Nx81/soePN1FbUsLsHszkBizptdHkxwfmlDUA5C
	9UCJcjyvrBq7oR3Jmx1m+FQ9Z5OFm0+ZOMd7x6BVMHKWTU806Z/LIxJyyIrnFiFIPGZensTFw6KN5
	b/TpxXZ7OPkpUF1e1/9GVCCnHfHFDsWkE5nMjqV5FDwWEmcPSQT8pFOJ0ZsoFow8TbVlBn5fmQY5M
	8qcdPUmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nBz3F-003Nbh-Vh; Mon, 24 Jan 2022 13:06:30 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nBz35-003NXf-GB
 for linux-nvme@lists.infradead.org; Mon, 24 Jan 2022 13:06:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B549B68BEB; Mon, 24 Jan 2022 14:06:16 +0100 (CET)
Date: Mon, 24 Jan 2022 14:06:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH V2 06/13] block: don't remove hctx debugfs dir from
 blk_mq_exit_queue
Message-ID: <20220124130616.GE27269@lst.de>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
 <20220122111054.1126146-7-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122111054.1126146-7-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_050619_727784_EE6332A4 
X-CRM114-Status: GOOD (  14.42  )
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

On Sat, Jan 22, 2022 at 07:10:47PM +0800, Ming Lei wrote:
> The queue's top debugfs dir is removed from blk_release_queue(), so all
> hctx's debugfs dirs are removed from there. Given blk_mq_exit_queue()
> is only called from blk_cleanup_queue(), it isn't necessary to remove
> hctx debugfs from blk_mq_exit_queue().
> 
> So remove it from blk_mq_exit_queue().

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

