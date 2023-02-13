Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F8CC636CC
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 06:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+wMpWIdsVh0/pbQTllqd151S54MnLfYlHB9ScL6tVWQ=; b=P1aY1zu/fd213hbZDk77uZfQyf
	0jhJq8Vv85wRzIhHRBbB42Kzyy31nYxWgfK75HwtXYNrwrX6xzJPSibpCpMa19JZkgi9o+d9kOrrj
	GoEVOG5UhTz8WRZt64Jrp6sP5+b6kaNHmtXYW20OPLi837WBxnzzzx9ZqwxXqXGq0T5azXH0GzP+R
	gVd0JiVNtn4QvqIiQdPOtGd8lM7xxNGtvFzDPeZhSQWl0HKIGEUk/+YyZwOyiKSpSlLaETlHehIkG
	zpi7OQC4gx0laJuvokLqtTCeHpGkXTJVWLpzssDF2tBthvz8tAencWxu6hKiURkqCVgU3SsQ85IHj
	iyrWDUzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRSCC-00DKLs-8W; Mon, 13 Feb 2023 06:20:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRSC3-00DKKz-UA
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 06:20:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1A0F868BFE; Mon, 13 Feb 2023 07:19:59 +0100 (CET)
Date: Mon, 13 Feb 2023 07:19:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/5] nvme: split __nvme_submit_sync_cmd()
Message-ID: <20230213061958.GA14223@lst.de>
References: <20230209143820.118097-1-hare@suse.de> <20230209143820.118097-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209143820.118097-2-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230212_222009_050367_921D8531 
X-CRM114-Status: GOOD (  11.08  )
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

> +struct request *nvme_alloc_request(struct request_queue *q,
> +				   struct nvme_command *cmd, int qid,
> +				   blk_mq_req_flags_t flags)
>  {
>  	struct request *req;
> -	int ret;
>  
>  	if (qid == NVME_QID_ANY)
>  		req = blk_mq_alloc_request(q, nvme_req_op(cmd), flags);
>  	else
>  		req = blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), flags,
>  						qid - 1);
> +	if (!IS_ERR(req))

As already said last time, please split out a nvme_alloc_request_qid
function for the few caller that pass a qid.

