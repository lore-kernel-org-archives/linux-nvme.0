Return-Path: <SRS0=eYGd=M4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989A6C4338F
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 12:01:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5647B6113C
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 12:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5647B6113C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BaenW8r8kjcT8F4fgKithv0D7DcGb9UbCWXp0KjCfdg=; b=1O1I8JsvlDJqRS
	o7X4gb2K8NKUiZdEhewOVgr6oRvQUlMpvfas7ulkeIvfokIE23rd65ndXPzwveqwpY736TnlpMiAq
	WHCkoOXkgpVggA+USUXpwfo25DZBLXULYk77kv7Avl7SzrROgETLqTQSxbDeAQDlx4LPQwKloUy9E
	dEMhLTZ3AICTT8QLbxZsD+j4c5dZlkMlKrAIwaw3i9b/2UEhqHU1D4o3T9c6K8cjwZlqaRwwS7jGj
	F32f3ElksX1bqO2+pIEVEIVTZz/xZvNIJf9ZkLIe3T7fJp8CbUj6fdAe2HSuX5yqHGrvYRAghKMmZ
	kCHcjtM10mpSsogzT7Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBc3r-009KVL-M5; Thu, 05 Aug 2021 12:01:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBc3p-009KUB-1f; Thu, 05 Aug 2021 12:01:18 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A71D61132;
 Thu,  5 Aug 2021 12:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628164876;
 bh=16APo6fE3eY2p/uODzQ81+asSQi2UhYxhFw1Qx5gvPA=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=GBn0dlwHiVqhZLu0Fo3yWrc2WkaZ8Qxmkal+0DaBkwi+BvGzswN7HO32obdM883P8
 GLXYp5zrCYFSooklqA/+FyCoX3FEdOBcszKoImj7aROLY8frbXu3pVDXLBfWyIDif2
 7JZlUtaEG2Cs6EnBQrEMitiERfXIseQJZZ3Es/tUNvGXwIwE504ASrY3BUGa8BFQKq
 Yn0f6WglLCJr4+2CLWe8GOkmTcQiNYAJ5IZ1S2rgdE92TbRixoDwaSh1iAiFVe10Uo
 tXvaCfm8noqmXKtlQN9Az7jhyrZ6iFBXdlKQsstatDnle26sVhwJ2Qmu8JmMHb8E4/
 AZo5dSnvsRRxg==
Message-ID: <440e1815a8b6f1605b6bce51af6eceadf8e742f7.camel@kernel.org>
Subject: Re: [PATCH 07/15] rbd: use bvec_virt
From: Jeff Layton <jlayton@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Geoff Levand <geoff@infradead.org>, Ilya
 Dryomov <idryomov@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan
 Hajnoczi <stefanha@redhat.com>, Song Liu <song@kernel.org>, Mike Snitzer
 <snitzer@redhat.com>, Coly Li <colyli@suse.de>, Stefan Haberland
 <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, "Martin K.
 Petersen" <martin.petersen@oracle.com>, Phillip Lougher
 <phillip@squashfs.org.uk>,  linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-um@lists.infradead.org, 
 ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
 linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org
Date: Thu, 05 Aug 2021 08:01:13 -0400
In-Reply-To: <20210804095634.460779-8-hch@lst.de>
References: <20210804095634.460779-1-hch@lst.de>
 <20210804095634.460779-8-hch@lst.de>
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210805_050117_159174_2C5EC8AE 
X-CRM114-Status: GOOD (  14.36  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, 2021-08-04 at 11:56 +0200, Christoph Hellwig wrote:
> Use bvec_virt instead of open coding it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/rbd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 6d596c2c2cd6..e65c9d706f6f 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2986,8 +2986,7 @@ static bool is_zero_bvecs(struct bio_vec *bvecs, u32 bytes)
>  	};
>  
>  	ceph_bvec_iter_advance_step(&it, bytes, ({
> -		if (memchr_inv(page_address(bv.bv_page) + bv.bv_offset, 0,
> -			       bv.bv_len))
> +		if (memchr_inv(bvec_virt(&bv), 0, bv.bv_len))
>  			return false;
>  	}));
>  	return true;

LGTM

Reviewed-by: Jeff Layton <jlayton@kernel.org>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
