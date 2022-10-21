Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28641C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 13:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iFw/cDSlPBuBVXVGmaUBhsnxl5dRRkaxCHj+IqELRZc=; b=RksRmMmPAM4bnMOCttcQnrDeER
	TUmXNWFPTaUJ9bUgzja+a96abnEJAiSTLU6LJ5CojrNVAp68EWrEbVw5tGImVDYyh489G0JteF1n7
	uKf7amBQuw2mPby79NP89xo4MP+7jIbPs11updQiNKynfRiUp0PK+WWh9ZmUQQ6JgR2GaSMVy7Jpx
	/IBecrCvQ4zUKyj0NE+pOyOrM/no+LNwi1eH109ibuuMZXAqBRG9236U6egoH1YN54sBgagt9Da4H
	fDA9MlNxSyBMz/R0wJzlp+YhiUhgEIAtosgxTrNsgh7dgULv0UDPSklQThMZGzpuYrPZdCj2i7c9Y
	TWSNtVBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olryk-007u19-01; Fri, 21 Oct 2022 13:22:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olryc-007twP-DN
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 13:22:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E11CA68B05; Fri, 21 Oct 2022 15:22:14 +0200 (CEST)
Date: Fri, 21 Oct 2022 15:22:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 3/8] blk-mq: move the srcu_struct used for quiescing to
 the tagset
Message-ID: <20221021132214.GC22327@lst.de>
References: <20221020105608.1581940-1-hch@lst.de> <20221020105608.1581940-4-hch@lst.de> <46ce9b02-7474-22a7-f8c2-10f46e88853a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46ce9b02-7474-22a7-f8c2-10f46e88853a@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221021_062218_644744_AA8750F4 
X-CRM114-Status: GOOD (  13.70  )
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

On Fri, Oct 21, 2022 at 03:16:50PM +0800, Chao Leng wrote:
>>   	struct list_head	tag_list;
>> +	struct srcu_struct	srcu;
> srcu_struct size is more than 50+ KB, it is waste for the tagset which do not set
> the BLK_MQ_F_BLOCKING, and most tagsets do not set the BLK_MQ_F_BLOCKING.
> Maybe we can define "srcu" as a pointer, and allocate the memory in blk_mq_alloc_tag_set
> just for tagset which set the BLK_MQ_F_BLOCKING.

I guess we could do that.  Still better than the variable sized struct.

p.s. any chance you could properly trim your replies?  I took me a while
to find your comment in the sea of quotes.

