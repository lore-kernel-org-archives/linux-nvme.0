Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22074C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 09:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OvDFHZz2wL8p8VKMm8u/0A0aZyL7VIN41Wx0LspyyZU=; b=uxzrUufrRxQ8mh/jUsYE2CL9kt
	u22wv4nbRNc8DXLch5y8fCzcSWeLG9AVEcs3nRX0o8uEnbmFHg/7H/HTJkzEo60EzJJcVW6GX+Lkc
	x6qVrX9mOObsnJ8Envn4OxJEeC6XJEcSuJsyyDBGErPI6uLT4YEMS8f37EblRzQcDqNPQSvMn0Yd0
	yS03eEjhUsDtc6YrSFAIKgWNfqptwTIVdofHSXlGAX79yOitr+AMB3jwoz5xTTKeW616/20GS6yhf
	F53RjBhIP27xdXtvuik8+YzFe/XbMq8nnAQ4b50V+W2VBl26JO55hkCUU7vEDdEcWpUP6v9XoftU9
	2HSvZnjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp5Bt-00FSHJ-CB; Mon, 22 Nov 2021 09:00:45 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp5Bo-00FSED-EB
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 09:00:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BF4BD68AA6; Mon, 22 Nov 2021 10:00:31 +0100 (CET)
Date: Mon, 22 Nov 2021 10:00:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/5] blk-mq: rename hctx_lock & hctx_unlock
Message-ID: <20211122090031.GA28870@lst.de>
References: <20211119021849.2259254-1-ming.lei@redhat.com>
 <20211119021849.2259254-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119021849.2259254-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_010040_676441_5B391C6B 
X-CRM114-Status: GOOD (  15.68  )
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

On Fri, Nov 19, 2021 at 10:18:46AM +0800, Ming Lei wrote:
> +static inline void queue_unlock(struct request_queue *q, bool blocking,
> +		int srcu_idx)

I don't think this is a good name, as it can be easily confused with
q->queue_lock.

> +	__releases(q->srcu)
>  {
> -	if (!(hctx->flags & BLK_MQ_F_BLOCKING))
> +	if (!blocking)
>  		rcu_read_unlock();
>  	else
> -		srcu_read_unlock(hctx->queue->srcu, srcu_idx);
> +		srcu_read_unlock(q->srcu, srcu_idx);
>  }

I think you want to make BLK_MQ_F_BLOCKING accessible from the
request_queue instead of passing the extra argument as well.

