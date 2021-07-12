Return-Path: <SRS0=IqcX=ME=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC835C07E9B
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jul 2021 07:32:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E3061919
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jul 2021 07:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E3061919
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sWeQ6e5rENCcQBDJEoeqJBpKPrAuEgEPd8Mr1PHVQLg=; b=ZZD+cChRxT8fxA
	MjouEVGjkuOQjOpyhtjSgi3U30zT2AzwQv1Zens9daRO4KMoQzJfQca9ogeap6YJPCwKZ9bZ8a9YE
	gSXWjVy8evGwQAdpEQemJeUC3GViGgFgmaPMvX3bfIiJO7TcPEoqU0GJBqi7Vnc5hpCpfeUSHPlzx
	tYDEt0mty6ICHcqiqHuwoADIGMatVlY2gMGuxslF+6j15LqQkuQfZxaRCGI4fFTKmRTuT9bRIP9Ba
	Sle1qe1ZRmEOjjhqsxqKT11eLENmFzq7PqNJ++2uSUQYSEepDCPqJFvMgYgF5VvFjPcJiLnWxEaRr
	5Js4NZq6lCwpMVrK1uiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m2qQj-006NP4-CZ; Mon, 12 Jul 2021 07:32:41 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m2qQh-006NOG-1q
 for linux-nvme@lists.infradead.org; Mon, 12 Jul 2021 07:32:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5AB4F67373; Mon, 12 Jul 2021 09:32:34 +0200 (CEST)
Date: Mon, 12 Jul 2021 09:32:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, Wen Xiong <wenxiong@us.ibm.com>,
 John Garry <john.garry@huawei.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH V3 02/10] blk-mq: Introduce blk_mq_dev_map_queues
Message-ID: <20210712073233.GB12347@lst.de>
References: <20210709081005.421340-1-ming.lei@redhat.com>
 <20210709081005.421340-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210709081005.421340-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210712_003239_287802_50499543 
X-CRM114-Status: GOOD (  18.08  )
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

> +	/*
> +	 * fallback to default mapping if driver doesn't provide
> +	 * get_queue_affinity callback
> +	 */
> +	if (!get_queue_affinity) {
> +		fallback = true;
> +		goto fallback;
> +	}
> +
> +	for (queue = 0; queue < qmap->nr_queues; queue++) {
> +		mask = get_queue_affinity(dev_data, dev_off, queue);
> +		if (!mask)
> +			goto fallback;
> +
> +		for_each_cpu(cpu, mask)
> +			qmap->mq_map[cpu] = qmap->queue_offset + queue;
> +	}
> +
> +	return 0;
> +
> +fallback:
> +	if (!fallback) {
> +		WARN_ON_ONCE(qmap->nr_queues > 1);
> +		blk_mq_clear_mq_map(qmap);
> +		return 0;
> +	}
> +	return blk_mq_map_queues(qmap);

Please remove the NULL get_affinity case and let the callers handle
the fallback.  Also I think it makes sense to leave the !mask fallback
case to the callers as well to simplify the calling conventions.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
