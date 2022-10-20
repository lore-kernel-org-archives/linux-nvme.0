Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810E9C43217
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 17:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dNC0192kgvdPehHw7tDp+u81BJYXwRY05b1yMfrszEQ=; b=KQUoXksHqqKy9t6W1zSzR3Uq0d
	Hdil/49sHi9n7LvrnePL5huGiEKmLhxzBsN0kDQRYhwWmVw+S4N4i6kEKahhzXbrkmcBVbIi2Nrvy
	v4pUbvOEjmwuJqLAbqR3iebmhE090tmRz78Pf8wJjInRaMDcazfGs155T8b229p1qN3NwRfsQpobm
	imTa8KQEs5Ue5IV+69JQvhx81gFIWcGiutZnFi4UHub0mO0OjpwzjZHpwGW2LUCaWSBF6BFuHPoUB
	WPn81R3RGddarrgC1eQnThBA8w/TWIeAhOgjpjY0r6iEtwvSLl2nu2qdOfdsDW70tGFnAvTPmAjvz
	4PjsLQdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olZJu-000qje-0t; Thu, 20 Oct 2022 17:27:02 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olZJr-000qiW-Tb
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 17:27:01 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E43F261CCD;
	Thu, 20 Oct 2022 17:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B083C433C1;
	Thu, 20 Oct 2022 17:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666286818;
	bh=qGrdvZ+avIT5ncewAhAAUh4JMIjmb8C6sPVDy6szDpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lDUknAcyhZzWWlNmaFoNsnGGwHNTQdnWqHNSb2lVuXqFPsUCEep4KEPGBi/5vHjTq
	 0UG5QuJrJPW2m/NwJNHfCvRxNLGa2RD4l73gdSHN8I6VLsHOgIXznuxhk2h7hwUjXy
	 nogHUlJZuPv378o5MzCakmSdhkYF6YxO4PjsUwtxjeFFtU6votIkg+JVyTooNGuzSZ
	 eGmpDLyXRVwLxGcD+g0OUXMjI3ixVp0vfgnFKDVuXFvniRajywva+rBAYrQeWP5K+L
	 XghmZaKdm8SFTezIsBlrOMFyEVL1SzmJ0KcYx7ETAsSIv1GTGO/UyxQ5wD1+rfDK21
	 AVKQd+dJsEuQA==
Date: Thu, 20 Oct 2022 11:26:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>, Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/8] blk-mq: move the srcu_struct used for quiescing to
 the tagset
Message-ID: <Y1GE37ujxcfRn7Tm@kbusch-mbp.dhcp.thefacebook.com>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020105608.1581940-4-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_102700_034386_20BB3D7B 
X-CRM114-Status: GOOD (  14.67  )
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

On Thu, Oct 20, 2022 at 12:56:03PM +0200, Christoph Hellwig wrote:
> All I/O submissions have fairly similar latencies, and a tagset-wide
> quiesce is a fairly common operation.  Becuase there are a lot less

s/Becuase/Because

> @@ -501,6 +502,8 @@ enum hctx_type {
>   * @tag_list_lock: Serializes tag_list accesses.
>   * @tag_list:	   List of the request queues that use this tag set. See also
>   *		   request_queue.tag_set_list.
> + * @srcu:	   Use as lock when type of the request queue is blocking
> + *		   (BLK_MQ_F_BLOCKING). Must be the last member

Since you're not dealing with flexible arrays anymore, I don't think
srcu strictly needs to be the last member.

The code looks great, though!

Reviewed-by: Keith Busch <kbusch@kernel.org>

>   */
>  struct blk_mq_tag_set {
>  	struct blk_mq_queue_map	map[HCTX_MAX_TYPES];
> @@ -521,6 +524,7 @@ struct blk_mq_tag_set {
>  
>  	struct mutex		tag_list_lock;
>  	struct list_head	tag_list;
> +	struct srcu_struct	srcu;
>  };

